# Agenda das salas

Agenda web para as salas 12, 18, 19 e 22. A autenticação e os agendamentos usam o Supabase.

Endereço publicado: <https://lerinaldo.github.io/Calend-rio/>.

## Configuração do Supabase

1. No projeto Supabase, abra **SQL Editor** e execute [`supabase-schema.sql`](./supabase-schema.sql). O script cria a tabela, impede reservas sobrepostas e ativa políticas RLS para contas `@educacao.sp.gov.br`. Reservas podem ser criadas, editadas e canceladas apenas por quem as criou; os usuários institucionais podem consultar a agenda compartilhada.
2. Em **Authentication → Users**, cadastre os usuários. A tela usa autenticação por e-mail e senha do Supabase Auth; a criação de contas fica a cargo do administrador.
3. Em [`index.html`](./index.html), substitua `SUPABASE_URL` e `SUPABASE_ANON_KEY` pelos valores de **Project URL** e **anon/public key** em **Project Settings → API**. Use somente a chave pública no navegador; nunca coloque a `service_role` key no HTML.
4. O site já está hospedado em <https://lerinaldo.github.io/Calend-rio/>. Depois de publicar a versão atualizada do arquivo, ajuste os **URL Configuration** do Supabase Auth para `https://lerinaldo.github.io` e adicione o endereço completo do site aos URLs de redirecionamento permitidos.

Depois de configurado, a agenda lê e grava as reservas no banco e atualiza as telas abertas quando há mudanças. O banco bloqueia simultaneamente dois agendamentos sobrepostos para a mesma sala.
