-- 在 Supabase SQL Editor 執行；每位登入者只能存取自己的資料。
create table if not exists public.desk_records (
  id uuid primary key,
  user_id uuid not null references auth.users(id) on delete cascade,
  type text not null check (type in ('diary','task','finance')),
  payload jsonb not null,
  updated_at timestamptz not null,
  deleted boolean not null default false
);
create index if not exists desk_records_user_idx on public.desk_records(user_id);
alter table public.desk_records enable row level security;
revoke all on public.desk_records from anon;
grant select, insert, update, delete on public.desk_records to authenticated;
drop policy if exists "select own" on public.desk_records;
drop policy if exists "insert own" on public.desk_records;
drop policy if exists "update own" on public.desk_records;
drop policy if exists "delete own" on public.desk_records;
create policy "select own" on public.desk_records for select to authenticated using ((select auth.uid())=user_id);
create policy "insert own" on public.desk_records for insert to authenticated with check ((select auth.uid())=user_id);
create policy "update own" on public.desk_records for update to authenticated using ((select auth.uid())=user_id) with check ((select auth.uid())=user_id);
create policy "delete own" on public.desk_records for delete to authenticated using ((select auth.uid())=user_id);
