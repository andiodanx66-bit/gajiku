-- Jalankan ini di Supabase SQL Editor

-- Tabel utama
create table if not exists gaji_state (
  id uuid primary key default gen_random_uuid(),
  user_id uuid references auth.users(id) on delete cascade not null unique,
  data jsonb not null default '{}',
  updated_at timestamptz default now()
);

-- Row Level Security
alter table gaji_state enable row level security;

-- User hanya bisa akses data miliknya sendiri
create policy "user dapat baca datanya sendiri"
  on gaji_state for select
  using (auth.uid() = user_id);

create policy "user dapat insert datanya sendiri"
  on gaji_state for insert
  with check (auth.uid() = user_id);

create policy "user dapat update datanya sendiri"
  on gaji_state for update
  using (auth.uid() = user_id);
