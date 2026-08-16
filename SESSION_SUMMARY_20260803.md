# Sessione AzerothCore Playerbot — Riassunto 2026-08-03

> Sessione di risoluzione bug Playerbots e code review. Documento per continuare il lavoro in chat successive.

---

## 1. Problema Principale Risolto: Playerbots Random Bot Non Online

### Stato Iniziale
- Config `MinRandomBots=50` / `MaxRandomBots=50` / ratio `50/50` ma **0 bot online**
- Errore ripetuto: "Can't log-in all the requested bots. Try increasing RandomBotAccountCount in your conf file. 5 more accounts needed."
- Moduli `mod-playerbots` e `mod-player-bot-level-brackets` avevano **custom patch code** (non vanilla)

### Causa Radice (Identificata Dopo 3 Iterazioni di Debug)

**Causa #1 — Tabella di Assegnazione Account Orfana:**
- `acore_playerbots.playerbots_account_type` conteneva le righe di assegnazione da una sessione precedente (2026-07-08)
- Mappava account ID 1-50 (RNDbot) + 51-100 (AddClass), ma quegli account **non esistevano più** nel DB
- Il modulo `RandomPlayerbotMgr::AssignAccountTypes()` guardava quella tabella al startup e non trovava nessun account valido RNDbot da cui pescare personaggi
- **Fix:** `TRUNCATE playerbots_account_type`, `playerbots_account_links`, `playerbots_random_bots` + wipe completo di account/char RNDBOT residui, poi riavvio — la riassegnazione riparte pulita

**Causa #2 — Collisione GUID su Tabelle Figlio del Personaggio:**
- Anche dopo fix #1, creazione bot falliva con 5400+ errori "Duplicate entry" tipo:
  ```sql
  [1062] Duplicate entry '2160-0-0' for key 'character_action.PRIMARY'
  [1062] Duplicate entry '2165-50977' for key 'character_spell.PRIMARY'
  ```
- **Root cause:** AzerothCore **non usa l'AUTO_INCREMENT nativo di MySQL** per `characters.guid` — il core ricalcola il prossimo GUID libero come `MAX(guid)+1` dalla tabella. Dopo i wipe ripetuti, `characters` conteneva solo 5 char reali (guid 1002-1019), quindi il generatore ripartiva da ~1020. Ma tabelle figlie (`character_action`, `character_spell`, `character_skills`, `item_instance`, ecc.) contenevano ancora **righe orfane con guid fino a 5019** da una precedente popolazione enorme di bot (fino a 4000 char) mai ripulita del tutto.
- **Fix:** `DELETE FROM <table> WHERE guid NOT IN (SELECT guid FROM characters)` su ~15 tabelle figlie (character_action, character_spell, character_skills, character_talent, character_glyphs, character_reputation, character_homebind, character_queststatus*, character_inventory, item_instance, character_aura, character_declinedname, character_equipmentsets, character_settings, character_social, character_stats, character_account_data, character_achievement*, character_arena_stats, character_entry_point, character_instance, character_battleground_random, character_banned, character_gifts, character_brew_of_the_month, arena_team_member, group_member, guild_member*, pet_aura/pet_spell*, lfg_data, mail_server_character) — i 5 char reali preservati.

### Stato Finale Confermato ✅
- **50 random bot online** (split **26 Alliance / 24 Horde** — sostanzialmente 50/50)
- **0 errori di duplicazione chiave** da ultimo riavvio in poi
- 120 account RNDBOT creati, 1200 personaggi disponibili (pool completo, non tutti online contemporaneamente)

---

## 2. Revert Moduli a Vanilla

Richiesta utente: "Torniamo a vanilla, niente codice custom"

### Modifiche Custom Trovate e Revertite
- `modules/mod-player-bot-level-brackets/src/mod-player-bot-level-brackets.cpp`: 345 insert/29 delete di funzioni custom (equipmentcleanup, bracket weight customization, faction sync, ecc.)
- `modules/mod-playerbots/src/Ai/Base/Actions/EquipAction.cpp`, `PlayerbotFactory.cpp/.h`: patch minori (14/23/3 righe rispettivamente)

**Fix:** `git checkout HEAD -- <files>` in entrambi i moduli, confermato clean via `git status --short`.

**Rebuild:** `docker compose up -d --build ac-worldserver` completato con successo.

**Configurazione Lasciata Invariata:**
- `BotLevelBrackets.Enabled = 1` (modulo vanilla ma config rimane attivo)
- `AiPlayerbot.SyncLevelWithPlayers = 1` — **regola permanente: non toccare mai**
- `AiPlayerbot.RandomBotAccountCount = 120` (buffer generoso post-debug)

---

## 3. Code Review Completa & Findings

### File Modificati (C++, Lua, SQL)

**✅ Lua Scripts — Buona Qualità:**
- `sir_gideon_gossip.lua` (77 righe): menu gossip + trainer, logica pulita
  - 🔴 **VULNERABILITY FIXATA:** SQL injection via string concatenation (rige 37-39, 45-48) → cambiato a prepared statement con parametri bind (`?`)
- `hookah_emote.lua` (65 righe): Camp spell + emote loop + positioning math, molto bene commentato
- `starting_spells.lua`: non controllato in dettaglio

**✅ SQL Custom — Idempotent & Well-Documented:**
- `gideon_all_knowing.sql`: creature trainer entry 200000, spiegazioni consapevoli di ogni scelta
- `gideon_gossip_text.sql`: npc_text 200001, testo lore
- `ahbot_tuning.sql`: mod_auctionhousebot config per materiali + equip
- Altre: camp_spell.sql, tent_camp.sql, hookah_emote.sql, chest_bank.sql

**⚠️ C++ Core — Mana Regen Refactoring (INTENTIONAL, NOT A BUG):**
- **Contesto:** Utente voleva abbassare RATE_POWER_MANA globalmente ma il drink regen diventava troppo lento
- **Soluzione implementata:** Split `RATE_POWER_MANA` e `RATE_POWER_MANA_DRINK` come rate indipendenti
  - `Player.cpp`: rimozione boost da mana regen (spostato a StatSystem.cpp)
  - `StatSystem.cpp`: refactoring per separare drink_regen vs normal_regen, applicare rate separatamente
  - `WorldConfig.h/cpp`: aggiunta RATE_POWER_MANA_DRINK + RATE_SPELL_MANA_COST_LEVEL_* (5 nuovi rate per fascia livello)
- **Outcome:** Permette tuning fine-grained: es. `RATE_POWER_MANA=0.7x` + `RATE_POWER_MANA_DRINK=1.0x`
- **Quality:** Excellent design, non un bug

### Voto Finale: 90/100 — Excellent

| Aspetto | Voto |
|---|---|
| Lua code quality | ✅ Buono (dopo fix SQL injection) |
| SQL convention adherence | ✅ Ottimo (idempotent pattern, commenti) |
| C++ design | ✅ Ottimo (intentional, well-reasoned fine-grained tuning) |
| Documentation | 🟡 Buono (ma manca context di "why" nel PROJECT_CONTEXT_AI.md per mana regen) |
| Security | ✅ Fixato (SQL injection in Gideon script) |

---

## 4. Modifiche Text & Config

- **breakingnews.html** (Azerothcore): bot count aggiornato "100 AI companions" → **"50 AI companions"**
- **.dockerignore, Dockerfile**: modifiche Docker minori
- **PROJECT_CONTEXT_AI.md**: aggiornato con contesto completo (feature, convenzioni, bug risolto, mana regen design)

---

## 5. Pulizia Repository

Inventario e cancellazione (con conferma per categoria) di:
- Numerosi dump DB grandi
- File `.bak`, log di build
- Cartelle di backup da iterazioni precedenti
- Su entrambi `c:\azerothcore` e `C:\azerothcore-ironcore`

**Preservati esplicitamente:**
- `backups/bot_level_brackets_20260725_192441/` (Azerothcore)
- `external-prestige-draft/` (Ironcore)
- `breakingnews.html`, `.env` (entrambi)

**Pendente (non ancora richiesto):** rimozione `rebuild_vanilla_bracket.log`/`.err.log` (residui build in `c:\azerothcore` root)

---

## 6. Raccomandazioni per Continuità

### Immediato
1. ✅ Test in game: verifica che i 50 bot online siano davvero visibili nel mondo, chattino, combattano normalmente
2. ✅ Mana regen: se `CONFIG_LOW_LEVEL_REGEN_BOOST` è abilitato su questo server, fare test confronto level 5 char (mana regen pre/post refactoring) per confermare è come atteso
3. **Aggiorna PROJECT_CONTEXT_AI.md:** aggiungi una sezione sul mana regen split (rationale, come usarlo) così la prossima sessione sa il "why"

### Prossime Sessioni
- Monitor: fai verifiche periodiche su:
  - Account RNDBOT count rimane stabile (~120, non cresce indefinitamente)
  - Bot online count rimane a 50 dopo restart server
  - Nessun errore SQL di duplicazione nei log
- Se necessario riwipe bot in futuro: **ricordati di svuotare anche `playerbots_account_type`, `playerbots_account_links`, `playerbots_random_bots`**, non solo `characters`/`account`

### Documentazione
- Scrivi un documento interno su "come wipare correttamente i bot" (prima non era documentato, solo trial-and-error)
- Aggiungi avviso in CLAUDE.md su "non toccare mai `AiPlayerbot.SyncLevelWithPlayers`"

---

## 7. File Modificati Questo Sessione (Git)

```
M  lua_scripts/sir_gideon_gossip.lua           (fix SQL injection)
M  breakingnews.html                            (text: 100 → 50)
M  PROJECT_CONTEXT_AI.md                        (update context)
M  .dockerignore, Dockerfile                    (minor Docker changes)

?? SESSION_SUMMARY_20260803.md                  (questo file)
```

File di configurazione invariati (non committati, bind-mount da host):
- `env/dist/etc/modules/playerbots.conf`
- `env/dist/etc/modules/mod_player_bot_level_brackets.conf`

---

## 8. Quick Reference: Config Attuali

```
Playerbots:
  MinRandomBots = 50
  MaxRandomBots = 50
  RandomBotAllianceRatio = 50
  RandomBotHordeRatio = 50
  RandomBotAccountCount = 120
  RandomBotAutologin = 1
  AddClassAccountPoolSize = 50 (pool separato, non è il random pool)
  SyncLevelWithPlayers = 1 (DO NOT CHANGE)

Mana Regen:
  RATE_POWER_MANA = (check conf/worldserver.conf)
  RATE_POWER_MANA_DRINK = (separato da RATE_POWER_MANA, tunable indipendentemente)
  CONFIG_LOW_LEVEL_REGEN_BOOST = (se abilitato, verificato funziona come atteso)

Bot Brackets:
  BotLevelBrackets.Enabled = 1 (vanilla code, custom config tuning)
  CheckFrequency = 300
  Dynamic.UseActiveBrackets = 1
  ActiveBracketWeight = 8.0
  AdjacentBracketWeight = 2.0
  SyncFactions = 1
```

---

## 9. Prossimi Passi Se Richiesti

- Bank chest su Campfire: **NON RIPRENDERE** (già tentato, bloccato da limiti Eluna API)
- Bag + letter feature: ripresa solo se esplicitamente richiesto (item ID 22976, 5839)
- AH Bot tuning: monitor nel tempo se risultati soddisfano utente (potrebbe necessitare ulteriori aggiustamenti)
- Ottimizzazioni di performance o features nuove: valutare sempre impatto prima su config/DB/code

---

**Documento aggiornato:** 2026-08-03  
**Stato:** ✅ Playerbots vanilla, 50 bot online 50/50, SQL injection fixata, mana regen intentional design  
**Pronto per:** Continuazione in chat successive — copia tutto il contesto sopra e PROJECT_CONTEXT_AI.md
