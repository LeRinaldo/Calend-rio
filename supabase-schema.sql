-- Execute no SQL Editor do projeto Supabase antes de usar a agenda.
create extension if not exists btree_gist;

create table if not exists public.room_bookings (
  id uuid primary key default gen_random_uuid(),
  title text not null check (char_length(title) between 1 and 70),
  room text not null check (room in ('12', '18', '19', '22')),
  meeting_date date not null,
  start_time time not null,
  end_time time not null,
  organizer text not null,
  created_by uuid not null references auth.users(id) on delete cascade,
  created_at timestamptz not null default now(),
  constraint room_bookings_valid_time check (end_time > start_time),
  constraint room_bookings_no_overlap exclude using gist (
    room with =,
    meeting_date with =,
    tsrange(meeting_date + start_time, meeting_date + end_time, '[)') with &&
  )
);

alter table public.room_bookings enable row level security;
grant select, insert, update, delete on public.room_bookings to authenticated;
alter publication supabase_realtime add table public.room_bookings;

create policy "institutional users can view bookings"
  on public.room_bookings for select to authenticated
  using (right(lower(coalesce(auth.jwt() ->> 'email', '')), 19) = '@educacao.sp.gov.br');

create policy "institutional users can create their own bookings"
  on public.room_bookings for insert to authenticated
  with check (
    created_by = auth.uid()
    and right(lower(coalesce(auth.jwt() ->> 'email', '')), 19) = '@educacao.sp.gov.br'
  );

create policy "owners can update their bookings"
  on public.room_bookings for update to authenticated
  using (
    created_by = auth.uid()
    and right(lower(coalesce(auth.jwt() ->> 'email', '')), 19) = '@educacao.sp.gov.br'
  )
  with check (
    created_by = auth.uid()
    and right(lower(coalesce(auth.jwt() ->> 'email', '')), 19) = '@educacao.sp.gov.br'
  );

create policy "owners can delete their bookings"
  on public.room_bookings for delete to authenticated
  using (
    created_by = auth.uid()
    and right(lower(coalesce(auth.jwt() ->> 'email', '')), 19) = '@educacao.sp.gov.br'
  );


