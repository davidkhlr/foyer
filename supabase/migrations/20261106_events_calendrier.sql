-- Calendrier : évènements sur plusieurs jours, journée entière, couleur, participants, lieu
alter table events add column if not exists end_day date;
alter table events add column if not exists all_day boolean not null default true;
alter table events add column if not exists color text;
alter table events add column if not exists participants text[] not null default '{}';
alter table events add column if not exists location text;
update events set end_day = day where end_day is null;
update events set all_day = false where start_time is not null;
update events set participants = array[who] where who <> 'both' and participants = '{}';
