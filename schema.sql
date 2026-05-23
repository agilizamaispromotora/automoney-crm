-- ============================================================
-- AUTO MONEY CRM - Schema do Banco de Dados
-- Cole este arquivo no SQL Editor do Supabase e clique em Run
-- ============================================================

-- Extensão para UUIDs
create extension if not exists "uuid-ossp";

-- ============================================================
-- VEÍCULOS
-- ============================================================
create table if not exists vehicles (
  id uuid primary key default uuid_generate_v4(),
  brand text not null,
  model text not null,
  year integer,
  plate text not null unique,
  color text,
  chassis text,
  renavam text,
  owner text default 'Loja',
  owner_name text,
  entry_value numeric(12,2) default 0,
  sale_value numeric(12,2) default 0,
  expenses numeric(12,2) default 0,
  status text default 'Disponivel',
  entry_type text default 'Compra',
  mileage integer default 0,
  created_at timestamp with time zone default now()
);

-- ============================================================
-- CLIENTES
-- ============================================================
create table if not exists clients (
  id uuid primary key default uuid_generate_v4(),
  name text not null,
  cpf text,
  phone text,
  email text,
  address text,
  city text default 'Curitiba',
  type text default 'Comprador',
  created_at timestamp with time zone default now()
);

-- ============================================================
-- VENDAS
-- ============================================================
create table if not exists sales (
  id uuid primary key default uuid_generate_v4(),
  vehicle_id uuid references vehicles(id),
  client_id uuid references clients(id),
  seller text,
  sale_date date default current_date,
  sale_value numeric(12,2) default 0,
  pay_method text,
  bank_name text,
  financing numeric(12,2) default 0,
  down_payment numeric(12,2) default 0,
  commission numeric(12,2) default 0,
  transfer_type text default 'Cliente',
  despachante text default 'Aguardando',
  status text default 'Em andamento',
  created_at timestamp with time zone default now()
);

-- ============================================================
-- DESPESAS
-- ============================================================
create table if not exists expenses (
  id uuid primary key default uuid_generate_v4(),
  category text,
  description text not null,
  value numeric(12,2) not null,
  date date default current_date,
  type text default 'Fixo',
  paid text default 'Pendente',
  created_at timestamp with time zone default now()
);

-- ============================================================
-- FUNCIONÁRIOS
-- ============================================================
create table if not exists employees (
  id uuid primary key default uuid_generate_v4(),
  name text not null unique,
  role text not null,
  salary numeric(12,2) default 0,
  help_cost numeric(12,2) default 0,
  created_at timestamp with time zone default now()
);

-- ============================================================
-- LANÇAMENTOS DE PAGAMENTO (extrato por funcionário)
-- ============================================================
create table if not exists payment_logs (
  id uuid primary key default uuid_generate_v4(),
  employee_name text not null,
  date date default current_date,
  description text not null,
  value numeric(12,2) not null,
  type text default 'Salario',
  created_at timestamp with time zone default now()
);

-- ============================================================
-- LEADS
-- ============================================================
create table if not exists leads (
  id uuid primary key default uuid_generate_v4(),
  name text not null,
  phone text,
  interest text,
  portal text,
  date date default current_date,
  status text default 'Novo',
  notes text,
  created_at timestamp with time zone default now()
);

-- ============================================================
-- AGENDA
-- ============================================================
create table if not exists appointments (
  id uuid primary key default uuid_generate_v4(),
  title text not null,
  date date not null,
  time text,
  person text,
  type text,
  notes text,
  created_at timestamp with time zone default now()
);

-- ============================================================
-- FORNECEDORES
-- ============================================================
create table if not exists suppliers (
  id uuid primary key default uuid_generate_v4(),
  name text not null,
  category text,
  cnpj text,
  phone text,
  contact text,
  created_at timestamp with time zone default now()
);

-- ============================================================
-- USUÁRIOS DO SISTEMA
-- ============================================================
create table if not exists system_users (
  id uuid primary key default uuid_generate_v4(),
  username text not null unique,
  password_hash text not null,
  role text not null,
  created_at timestamp with time zone default now()
);

-- Inserir usuários iniciais (senha: 1234 para todos)
insert into system_users (username, password_hash, role) values
  ('ANDERSON', '1234', 'gestor'),
  ('ANA',      '1234', 'gestor'),
  ('CAMILA',   '1234', 'consignadora'),
  ('HELOISE',  '1234', 'consignadora'),
  ('NATAN',    '1234', 'vendedor'),
  ('OZIEL',    '1234', 'vendedor'),
  ('WILLIAM',  '1234', 'preparador')
on conflict (username) do nothing;

-- Inserir funcionários iniciais
insert into employees (name, role, salary, help_cost) values
  ('ANDERSON', 'Gestor',       0,    0),
  ('ANA',      'Gestora',      0,    0),
  ('CAMILA',   'Consignadora', 1800, 300),
  ('HELOISE',  'Consignadora', 1800, 300),
  ('NATAN',    'Vendedor',     1500, 200),
  ('OZIEL',    'Vendedor',     1500, 200),
  ('WILLIAM',  'Preparador',   1800, 150)
on conflict (name) do nothing;

-- ============================================================
-- SEGURANÇA: Row Level Security (RLS)
-- Permite leitura/escrita apenas com a chave anon autenticada
-- ============================================================
alter table vehicles        enable row level security;
alter table clients         enable row level security;
alter table sales           enable row level security;
alter table expenses        enable row level security;
alter table employees       enable row level security;
alter table payment_logs    enable row level security;
alter table leads           enable row level security;
alter table appointments    enable row level security;
alter table suppliers       enable row level security;
alter table system_users    enable row level security;

-- Políticas: acesso total via anon key (o sistema controla login)
create policy "allow_all_vehicles"     on vehicles     for all using (true) with check (true);
create policy "allow_all_clients"      on clients      for all using (true) with check (true);
create policy "allow_all_sales"        on sales        for all using (true) with check (true);
create policy "allow_all_expenses"     on expenses     for all using (true) with check (true);
create policy "allow_all_employees"    on employees    for all using (true) with check (true);
create policy "allow_all_payment_logs" on payment_logs for all using (true) with check (true);
create policy "allow_all_leads"        on leads        for all using (true) with check (true);
create policy "allow_all_appointments" on appointments for all using (true) with check (true);
create policy "allow_all_suppliers"    on suppliers    for all using (true) with check (true);
create policy "allow_all_system_users" on system_users for all using (true) with check (true);

-- ============================================================
-- FIM DO SCHEMA
-- ============================================================
select 'Schema criado com sucesso!' as resultado;
