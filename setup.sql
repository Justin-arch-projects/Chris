-- Cristomar Floor Board: run once in Supabase > SQL Editor > New query > Run.

create table if not exists public.docs (
  path        text primary key,
  collection  text not null,
  id          text not null,
  data        jsonb not null default '{}'::jsonb,
  updated_at  timestamptz not null default now()
);

-- Only signed-in shop logins can see or change anything.
alter table public.docs enable row level security;
drop policy if exists "shop read"   on public.docs;
drop policy if exists "shop insert" on public.docs;
drop policy if exists "shop update" on public.docs;
drop policy if exists "shop delete" on public.docs;
create policy "shop read"   on public.docs for select to authenticated using (true);
create policy "shop insert" on public.docs for insert to authenticated with check (true);
create policy "shop update" on public.docs for update to authenticated using (true) with check (true);
create policy "shop delete" on public.docs for delete to authenticated using (true);

-- Merge changed fields into a card in one step, so two people tapping at once don't overwrite each other.
create or replace function public.merge_doc(p_path text, p_patch jsonb)
returns void language sql security invoker as $$
  update public.docs set data = data || p_patch, updated_at = now() where path = p_path;
$$;
revoke all on function public.merge_doc(text, jsonb) from public, anon;
grant execute on function public.merge_doc(text, jsonb) to authenticated;

-- Live updates on every screen.
alter table public.docs replica identity full;
do $$ begin
  alter publication supabase_realtime add table public.docs;
exception when duplicate_object then null; end $$;
