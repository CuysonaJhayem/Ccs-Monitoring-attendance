-- CCS Track & Field Attendance — run this once in Supabase → SQL Editor

-- 1. Who is allowed to read/write (put your login email here)
create table if not exists public.app_admins (
  email text primary key
);
insert into public.app_admins (email) values ('YOUR-EMAIL@example.com')
on conflict do nothing;

-- 2. One row per athlete per session (e.g. '2026-09-29|AM')
create table if not exists public.attendance (
  session_key text not null,
  athlete_id  text not null,
  status      text not null check (status in ('P','L','A','E')),
  marked_at   timestamptz not null default now(),
  primary key (session_key, athlete_id)
);

-- 3. Locked sessions
create table if not exists public.session_locks (
  session_key text primary key,
  locked_at   timestamptz not null default now()
);

-- 4. Security: only emails in app_admins can touch the data
alter table public.app_admins    enable row level security;
alter table public.attendance    enable row level security;
alter table public.session_locks enable row level security;

create or replace function public.is_app_admin() returns boolean
language sql stable security definer set search_path = public as $$
  select exists (select 1 from public.app_admins where email = auth.jwt() ->> 'email');
$$;

drop policy if exists "admin all attendance" on public.attendance;
create policy "admin all attendance" on public.attendance
  for all to authenticated using (public.is_app_admin()) with check (public.is_app_admin());

drop policy if exists "admin all locks" on public.session_locks;
create policy "admin all locks" on public.session_locks
  for all to authenticated using (public.is_app_admin()) with check (public.is_app_admin());
-- app_admins has RLS on and no policies = nobody can read/change it from the app.
