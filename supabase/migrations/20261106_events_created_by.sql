-- Calendrier : auteur de l'évènement (rempli automatiquement à la création)
alter table events add column if not exists created_by uuid default auth.uid();
