-- doffin-monitor-accelat initial schema
create table if not exists cpv_codes (
  code text primary key
);

create table if not exists user_notices (
  notice_id text primary key,
  status text,
  comment text default '',
  sub_status text,
  updated_at timestamptz default now()
);

create table if not exists notice_cache (
  notice_id text primary key,
  is_dps boolean,
  internal_id text,
  competition_docs_url text,
  checked_at timestamptz default now()
);

-- Row level security with open anon policies (matches original instance)
alter table cpv_codes    enable row level security;
alter table user_notices enable row level security;
alter table notice_cache enable row level security;

create policy "anon all cpv_codes"    on cpv_codes    for all to anon using (true) with check (true);
create policy "anon all user_notices" on user_notices for all to anon using (true) with check (true);
create policy "anon all notice_cache" on notice_cache for all to anon using (true) with check (true);

-- Seed default CPV codes
insert into cpv_codes (code) values
  ('48000000'),
  ('71600000'),
  ('72000000'),
  ('73000000')
on conflict do nothing;
