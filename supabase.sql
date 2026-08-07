-- Script para crear la tabla de viajes en Supabase
-- Pegar esto en: Supabase Dashboard > SQL Editor > New query > Run

create table public.viajes (
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
