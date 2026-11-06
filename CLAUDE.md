# Foyer

PWA familiale pour David et sa compagne : calendrier partagé, listes, repas, budget.
Publiée sur GitHub Pages : https://davidkhlr.github.io/foyer/ (dépôt `davidkhlr/foyer`, branche `main`).

## Architecture

- **Un seul fichier : `index.html`** — HTML, CSS et JS en ligne, aucun build.
- **supabase-js** chargé depuis jsDelivr en **version figée** (`@supabase/supabase-js@2.118.0`). Ne pas passer à une version flottante.
- Police **Bricolage Grotesque** (Google Fonts).
- **Thème clair et sombre.**
- Backend : Supabase, projet `ldfpfigxzfbmuxxtavvp`. Le MCP Supabase est déclaré dans `.mcp.json` (scopé à ce projet).

## Modules

- **Calendrier** : jours fériés et fêtes françaises calculés en JS (pas de table), évènements sur plusieurs jours (`day` → `end_day`), journée entière ou horaires, couleurs, participants, lieu.
- **Listes** : listes partagées et leurs éléments.
- **Repas** : planning des repas ; les ingrédients peuvent être envoyés vers la liste « Courses ».
- **Budget** : dépenses partagées 50/50, perso ou avancées pour l'autre ; calcul du solde entre nous deux.

## Base Supabase

Tables : `households`, `members`, `events`, `lists`, `list_items`, `meals`, `expenses`.

- Toutes protégées par RLS avec une règle basée sur la fonction `is_member(household_id)`.
- Toutes publiées en temps réel (publication `supabase_realtime`).
- Migrations SQL versionnées dans `supabase/migrations/`.

## Façon de travailler

- **Le dépôt est la seule source de vérité.** Les modifications se font directement dans `index.html` du dépôt, plus dans le dossier « App Familly » du Bureau.
- Après chaque modification :
  1. vérifier la syntaxe JS (par ex. servir le dépôt en local et compiler chaque `<script>` inline avec `new Function(...)` dans le navigateur, ou `node --check` sur le script extrait si Node est disponible) ;
  2. commit avec un message clair **en français** ;
  3. `git push` sur `main` — GitHub Pages se met à jour tout seul (~1 min).
- **Tout changement de structure de la base** passe par une migration SQL appliquée via le MCP Supabase, enregistrée aussi dans `supabase/migrations/`. Toute nouvelle table reçoit la même règle RLS `is_member(household_id)` et est ajoutée à la publication temps réel.
- **Demander confirmation à David avant toute suppression** de table, de colonne ou de données.
- **Ne jamais écrire de clé secrète** (`sb_secret_…` ou `service_role`) dans le code. Seule la clé publishable (`sb_publishable_…`) a sa place dans `index.html`.
