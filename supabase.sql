-- Script para crear/actualizar las tablas en Supabase
-- Pegar esto en: Supabase Dashboard > SQL Editor > New query > Run

-- PARTE 1 (solo si es la primera vez): tabla de viajes
create table if not exists public.viajes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  ruta text not null,
  precio numeric not null default 0,
  estado text not null default 'pendiente',
  abono numeric not null default 0,
  created_at timestamptz not null default now()
);

-- Seguridad: cada usuario solo ve y modifica SUS propios viajes
alter table public.viajes enable row level security;

create policy "Cada usuario ve sus propios viajes"
  on public.viajes for select
  using (auth.uid() = user_id);

create policy "Cada usuario inserta sus propios viajes"
  on public.viajes for insert
  with check (auth.uid() = user_id);

create policy "Cada usuario actualiza sus propios viajes"
  on public.viajes for update
  using (auth.uid() = user_id);

create policy "Cada usuario elimina sus propios viajes"
  on public.viajes for delete
  using (auth.uid() = user_id);

-- PARTE 2 (nuevo): columnas de viajes para empresa y fecha del viaje
-- Se agregan si no existen, asi que se puede volver a ejecutar sin errores
alter table public.viajes add column if not exists empresa text;
alter table public.viajes add column if not exists fecha date;

-- PARTE 3 (nuevo): tabla de gastos
create table if not exists public.gastos (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users (id) on delete cascade,
  descripcion text not null,
  monto numeric not null default 0,
  categoria text not null default 'otros',
  fecha date not null default current_date,
  viaje_id uuid references public.viajes (id) on delete cascade,
  created_at timestamptz not null default now()
);

-- Seguridad: cada usuario solo ve y modifica SUS propios gastos
alter table public.gastos enable row level security;

-- (drop policy if exists = se puede volver a ejecutar este script sin errores)
drop policy if exists "Cada usuario ve sus propios gastos" on public.gastos;
create policy "Cada usuario ve sus propios gastos"
  on public.gastos for select
  using (auth.uid() = user_id);

drop policy if exists "Cada usuario inserta sus propios gastos" on public.gastos;
create policy "Cada usuario inserta sus propios gastos"
  on public.gastos for insert
  with check (auth.uid() = user_id);

drop policy if exists "Cada usuario actualiza sus propios gastos" on public.gastos;
create policy "Cada usuario actualiza sus propios gastos"
  on public.gastos for update
  using (auth.uid() = user_id);

drop policy if exists "Cada usuario elimina sus propios gastos" on public.gastos;
create policy "Cada usuario elimina sus propios gastos"
  on public.gastos for delete
  using (auth.uid() = user_id);

-- PARTE 4 (IMPORTANTE): recargar el caché del esquema
-- Supabase guarda en caché la estructura de las tablas. Si agregaste
-- columnas nuevas (empresa, fecha) o te sale un error como:
-- "Could not find the 'empresa' column of 'viajes' in the schema cache",
-- ejecuta este comando y listo.
notify pgrst, 'reload schema';
