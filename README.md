# Agenda das salas

Agenda web para as salas 12, 18, 19 e 22. A autenticação e os agendamentos usam o Supabase.

Endereço publicado: <https://lerinaldo.github.io/Calend-rio/>.

## Configuração do Supabase

1. No projeto Supabase, abra **SQL Editor** e execute [`supabase-schema.sql`](./supabase-schema.sql). O script cria a tabela, impede reservas sobrepostas e ativa políticas RLS para contas `@educacao.sp.gov.br`. Reservas podem ser criadas, editadas e canceladas apenas por quem as criou; os usuários institucionais podem consultar a agenda compartilhada.
2. Em **Authentication → Users**, cadastre os usuários. A tela usa autenticação por e-mail e senha do Supabase Auth; a criação de contas fica a cargo do administrador.
3. A URL do projeto e a chave `publishable` já estão configuradas em [`index.html`](./index.html). Essa chave foi feita para uso no navegador; nunca coloque uma chave `service_role` ou `secret` no HTML.
4. O site está hospedado em <https://lerinaldo.github.io/Calend-rio/>. No Supabase Auth, confira os **URL Configuration** e defina o endereço do site como URL principal e endereço de redirecionamento permitido.

Depois de configurado, a agenda lê e grava as reservas no banco e atualiza as telas abertas quando há mudanças. O banco bloqueia simultaneamente dois agendamentos sobrepostos para a mesma sala.

