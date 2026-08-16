# Contesto progetto AzerothCore / Ironcore (Playerbot) — riassunto per AI

> Documento pensato per essere incollato all'inizio di una nuova chat con un altro assistente AI,
> per dargli in un colpo solo tutto il contesto del progetto: setup, cosa è stato fatto, convenzioni,
> incidenti risolti, e stato attuale. Aggiornato al 2026-07-27.

---

## 1. Setup generale

- Due server WoW 3.3.5a (WotLK) paralleli, entrambi basati sul fork **AzerothCore + mod-playerbots**
  (branch `Playerbot`, remote `mod-playerbots/azerothcore-wotlk`), gestiti via Docker Desktop su Windows.
  - **Azerothcore** (repo `c:\azerothcore`): realm "classico" pensato per compagnia/socialità.
    Container: `ac-worldserver`, `ac-authserver`, `ac-database` (MySQL/MariaDB, `root`/`password`).
    Ha il modulo `mod-ah-bot` (Auction House Bot). Ha ~50 Playerbot random bot online, chat AI locale
    via Ollama.
  - **Ironcore** (repo `C:\azerothcore-ironcore`): realm più hardcore/solo-focused (niente AH,
    challenge mode: Hardcore/Semi-Hardcore/Iron Man/limiti qualità item/XP basso). Container:
    `ironcore-worldserver`, `ironcore-database`. **Non ha** `mod-ah-bot`.
  - Entrambi hanno una cartella `lua_scripts/` (mod-ale / Eluna) indipendente — stesso pattern
    generale, contenuto spesso diverso per server.
- Testo di presentazione realm (client login screen): `breakingnews.html` in ciascun repo,
  descrive le feature del server (vedi §4 per l'ultima modifica fatta ad Azerothcore).
- Reload live:
  - Script Lua (Eluna): in teoria `.reload eluna` da console, ma il metodo affidabile usato finora è
    `docker restart <container>-worldserver` + attesa del log `ready...`.
  - Moduli C++ con solo modifiche a `.conf` (bind-mount da host in `env/dist/etc/modules/`):
    basta `docker restart <container>` — niente ricompilazione.
  - Modifiche a codice `.cpp`/`.h` dei moduli: serve rebuild completo,
    `docker compose up -d --build ac-worldserver` (lento, ricompila tutto il C++, minuti).
- **Attenzione cache client:** il client WoW 3.3.5a cachea localmente (cartella `Cache/*.wdb`, NON
  `WTF`) contenuti per ID (es. `npc_text`). Se lo stesso ID viene usato con contenuto diverso tra
  Azerothcore e Ironcore, il client può mostrare il testo del server sbagliato (bug reale già
  capitato con Sir Gideon). **Regola: non riusare mai lo stesso ID con contenuto diverso tra i due
  server** (va bene riusarlo se il contenuto è identico). Deciso di non riservare fasce di ID diverse
  per server — troppo complesso, si tiene semplice: ID diversi solo quando il contenuto differisce.
- Debug Docker: per capire se una riga di log è "vecchia" (accumulata da riavvii precedenti, dato
  che `docker logs` ritorna tutta la storia e `--since <timestamp>` non filtra sempre in modo
  affidabile in questo ambiente) confrontare con
  `docker inspect <container> --format '{{.State.StartedAt}}'` e usare `docker logs -t` (timestamp
  per riga) per essere certi che una riga appartenga all'avvio corrente.

## 2. Convenzioni/pattern stabiliti in questo progetto

- Feature custom preferibilmente in **Lua (Eluna/mod-ale)**, non C++ — vive in `lua_scripts/`,
  ricaricabile senza ricompilare.
- SQL custom in `data/sql/custom/db_world/` (gitignored, libero da modificare) — **mai** toccare
  `data/sql/base/`, `data/sql/archive/`, o `data/sql/updates/db_*/` (immutabili). Le nuove migration
  vanno in `data/sql/updates/pending_db_*/`.
- Riusare ID/asset nativi (spell, displayId modelli) invece di creare contenuto che richiede
  DBC/MPQ — es. la scena campfire riusa la spell nativa 818 "Basic Campfire".
- Prima di modificare configurazioni "globali" con effetti a cascata (es.
  `playercreateinfo_spell_custom`), **controllare l'impatto prima** — c'è già stato un incidente in
  passato con ~7000 righe attivate insieme per sbaglio (da cui la regola generale "check impact
  before modifying").
- Verificare sempre l'impatto reale (log, query DB) prima di dichiarare una modifica riuscita — non
  fidarsi solo dell'assenza di errori nel log immediato (vedi il bug playerbots in §5: il log diceva
  "1200 Characters loaded" ma la tabella `characters` conteneva 0 righe).
- I moduli scaricati da repository esterno (`modules/mod-playerbots`, `modules/mod-player-bot-level-brackets`)
  sono **anche loro repo git a sé stanti** — eventuali patch custom fatte sopra l'upstream restano
  come modifiche non committate (`git status --short` / `git diff HEAD` per vederle), e sono
  revertibili a vanilla con `git checkout HEAD -- <file>`.

## 3. Feature completate in sessioni precedenti (contesto storico)

### 3.1 Sir Gideon Ofnir, the All-Knowing (NPC entry 200000, entrambi i server)
- Trainer universale: insegna tutte le spell livello 1-10 di ogni classe (tranne Death Knight).
  SQL: `data/sql/custom/db_world/gideon_all_knowing.sql`.
- Menu gossip via Eluna Lua (`lua_scripts/sir_gideon_gossip.lua`, uno per server) con 3 opzioni:
  - "Tell me about this place" → pagina gossip con testo lore **diverso per server** (da `npc_text`
    id 200001, contenuto diverso in ogni DB — SQL: `data/sql/custom/db_world/gideon_gossip_text.sql`).
  - "Teach me your arts" → apre il trainer (`player:SendTrainerList(object)`).
  - "Nothing, thank you" → chiude.
- Bug risolto: NON chiamare `player:GossipComplete()` prima di `SendTrainerList` (il core nativo non
  lo fa, `PlayerGossip.cpp:335-337`) — altrimenti il client esce dalla conversazione invece di aprire
  il trainer.
- Spawn NPC: manuale in gioco con `.npc add 200000` in ogni starting zone (non gestito da SQL per
  evitare di sovrascrivere gli spawn piazzati a mano).

### 3.2 Auction House Bot tuning (solo Azerothcore — Ironcore non ha il modulo)
Obiettivo: vendere meglio i materiali da gathering/crafting (erbe, minerali, pelli, stoffe — tutti
qualità White in game) e avere più oggetti verdi (equip) rispetto ai blu in asta.

Stato finale, catturato in modo versionato in `data/sql/custom/db_world/ahbot_tuning.sql` (prima era
solo live nel DB, non versionato — rischio di perderlo a un reimport pulito):

| Campo (`mod_auctionhousebot`, righe auctionhouse 2/6/7) | Valore |
|---|---|
| `minitems` / `maxitems` | 1000 / 1000 |
| `percentwhitetradegoods` | 50% |
| `percentgreentradegoods` | 22% |
| `percentwhiteitems` (equip white) | 20% |
| `percentgreenitems` (equip green) | 25% |
| `percentblueitems` (equip blue) | 10% |
| `percentpurpleitems` | 5% |
| `minpricewhite` / `maxpricewhite` | 700% / 1000% del vendor price |
| `buyerpricewhite` / `buyerpricegreen` | 30 / 30 (moltiplicatore, erano 3/5) |
| `buyerbidsperinterval` | 30 (era 1) |

Conf `env/dist/etc/modules/mod_ahbot.conf`: `AuctionHouseBot.ItemsPerCycle = 500` (era 200).

Note tecniche: i prezzi (`minprice*`/`maxprice*`) sono per fascia di qualità colore, condivisi tra
equip e trade goods della stessa qualità. `buyerprice*` è un moltiplicatore del vendor sell price
(se il seller price supera il buyer price massimo il bot non compra). Le modifiche non sono
retroattive sugli annunci già in asta.

### 3.3 Camp/hookah/tent/rug scene (entrambi i server) — COMPLETATA
Spell "Camp" (riusa la spell nativa 818 "Basic Campfire", cooldown rimosso) che spawna, oltre al
falò nativo, un hookah (gameobject entry 500001, emote loop via Lua), una tenda (500002) e un
tappeto (500003) intorno al giocatore. Pattern: riuso di asset nativi + logica Lua.

### 3.4 Bank chest su Basic Campfire — TENTATA E POI COMPLETAMENTE REVERTITA
Tentativo di far materializzare, insieme alla scena campfire, anche una chest che apre la banca
personale del giocatore (persistente tra respawn). Bloccata da un problema mai risolto:
`SummonCreature`/`go:SummonCreature`/`player:SummonCreature` non disponibili in questa build di
Eluna (`attempt to call method 'SummonCreature' (a nil value)`) nonostante il metodo esista nel
sorgente mod-eluna — causa non chiarita (possibile binary compilato diverso/stale). Workaround
tentato con la funzione globale `PerformIngameSpawn(...)` — anche questo non ha prodotto una bank
chest funzionante. **Decisione finale dell'utente: revert completo** — il campfire base torna a
spawnare solo falò + tenda + hookah, nessun resto di codice per la chest.

### 3.5 Altre feature
- **Transmog** (mod-transmog): NPC "Warpweaver" spawnabile con `.npc add 190010` (o `190011` per la
  variante Ethereal).
- **Bag + letter feature**: in pausa/non ripresa. Item ID tentativi se ripresa: 22976 e 5839.

## 4. Pulizia repository (fatta in questa sessione)

Inventario completo di backup/dump/file sparsi su entrambi i repo, con conferma dell'utente
categoria per categoria prima di ogni cancellazione (mai cancellato nulla senza conferma esplicita).
Eliminati: numerosi dump DB grandi, file `.bak`, log di build, cartelle di backup da iterazioni
precedenti — su entrambi `c:\azerothcore` e `C:\azerothcore-ironcore`.

**Esplicitamente preservati** (non toccare senza nuova richiesta esplicita):
- `backups/bot_level_brackets_20260725_192441/` (Azerothcore)
- `external-prestige-draft/` (Ironcore)
- `breakingnews.html` (entrambi)
- `.env` (entrambi)

Modifica testuale fatta: `breakingnews.html` (Azerothcore) — riga bot count aggiornata da
"up to 100 AI companions" a **"up to 50 AI companions"** (allineata al numero reale di random bot
configurati).

Da valutare in una prossima pulizia (non ancora richiesto): rimuovere
`rebuild_vanilla_bracket.log` / `rebuild_vanilla_bracket.err.log` (creati in `c:\azerothcore` root
durante il rebuild di questa sessione, §5).

## 5. Playerbots — revert a vanilla e risoluzione bug bot non online (fatto in questa sessione)

### 5.1 Obiettivo richiesto dall'utente
Riportare il sistema Playerbots a uno stato pulito e prevedibile:
1. Esattamente **50 random world bot**, split **50/50 Alliance/Horde**.
2. Solo i moduli **vanilla** `mod-playerbots` e `mod-player-bot-level-brackets` attivi — **zero
   codice custom hand-patched**. I file `.conf` restano come sono (non toccati per questo punto).

### 5.2 Codice custom trovato e rimosso
Entrambi i moduli sono repository git a sé stanti con modifiche locali non committate sopra
l'upstream:
- `modules/mod-player-bot-level-brackets/src/mod-player-bot-level-brackets.cpp`: 345
  inserimenti/29 cancellazioni vs upstream. Aggiungeva: `IsRandomBotAccount()`,
  `HasInappropriateEquipmentForLevel`/`RemoveInappropriateEquipmentForLevel`/
  `RemovePersistentInappropriateEquipmentForLevel` (pulizia SQL diretta di `character_inventory`/
  `item_instance` per bot offline), pesi custom per bracket dinamici
  (`g_ActiveBracketWeight=8.0`, `g_AdjacentBracketWeight=2.0`), sync fazioni, cleanup asincrono.
  → **Revertito con `git checkout HEAD -- src/mod-player-bot-level-brackets.cpp`.**
- `modules/mod-playerbots/src/Ai/Base/Actions/EquipAction.cpp`,
  `src/Bot/Factory/PlayerbotFactory.cpp`, `.h`: patch minori (14/23/3 righe).
  → **Revertiti allo stesso modo.**

Dopo il revert: `git status --short` pulito in entrambi i repo modulo. Rebuild completo eseguito
(`docker compose up -d --build ac-worldserver`, completato con successo).

Config lasciata invariata per esplicita richiesta utente, incluso:
- `AiPlayerbot.SyncLevelWithPlayers = 1` (regola permanente: **non toccare mai** questo valore,
  aggiunto in una sessione precedente per un motivo specifico — cappa il livello massimo dei random
  bot a "livello massimo giocatore online + 3", non fa clustering per bracket).
- `BotLevelBrackets.Enabled = 1` e relativi pesi (`CheckFrequency=300`, `FlaggedProcessLimit=5`,
  `Dynamic.UseActiveBrackets=1`, `ActiveBracketWeight=8.0`, `AdjacentBracketWeight=2.0`,
  `SyncFactions=1`) — il modulo ora è vanilla nel codice ma i suoi parametri di configurazione
  restano quelli già impostati.
- `AiPlayerbot.MinRandomBots = 50`, `MaxRandomBots = 50`, `RandomBotAllianceRatio = 50`,
  `RandomBotHordeRatio = 50` — già corretti da prima, nessuna modifica necessaria per il requisito
  50/50.
- `AiPlayerbot.RandomBotAccountCount = 120` (alzato da 0/60 durante il debug del bug in §5.3 — valore
  generoso, non stretto, lasciato così).
- `AiPlayerbot.AddClassAccountPoolSize = 50`: **non è il pool dei random bot** — è un pool
  *separato* di account riservati alla feature on-demand `.bot add` (bot "companion" per party).
  Chiarito con l'utente il perché si vedevano "100 account invece di 50" (50 random-bot pool + 50
  addclass pool) — non era un bug, nessuna modifica fatta su questo punto.

### 5.3 Bug reale trovato: bot creati ma mai online (0 bot online nonostante config corretta)

Dopo il revert a vanilla, i bot continuavano a non apparire in game, con errore ripetuto nel log:

```
Can't log-in all the requested bots. Try increasing RandomBotAccountCount in your conf file.
5 more accounts needed.
```

**Causa reale #1 — tabella di assegnazione account orfana.**
`mod-playerbots` tiene in `acore_playerbots.playerbots_account_type` una mappa
`account_id → tipo (1=RNDbot, 2=AddClass, 0=non assegnato)`, popolata una sola volta all'avvio
(`RandomPlayerbotMgr::AssignAccountTypes()`, chiamata da `PlayerbotAIConfig.cpp:710`). Le
cancellazioni ripetute di account/personaggi RNDBOT fatte durante il debug (sessioni precedenti e
questa) **non avevano mai svuotato questa tabella**: conteneva ancora le assegnazioni di account ID
1-50 (RNDbot) e 51-100 (AddClass) da una sessione del 2026-07-08 — account che nel frattempo erano
stati cancellati e ricreati con ID nuovi (406-805 al momento della diagnosi). Verificato con una
JOIN: **0 righe valide** di tipo RNDbot puntavano ad account realmente esistenti → il modulo non
trovava nessun account da cui pescare personaggi da loggare, a prescindere dal valore di
`RandomBotAccountCount`.
**Fix:** `TRUNCATE playerbots_account_type` (+ `playerbots_account_links`, `playerbots_random_bots`
per pulizia) e wipe completo di account/personaggi RNDBOT residui, poi riavvio — così la
riassegnazione fresca ripristina correttamente il mapping sui 120 account attuali.

**Causa reale #2 — collisione di GUID con righe orfane nelle tabelle figlie del personaggio.**
Anche dopo il fix #1, la creazione dei nuovi personaggi bot falliva silenziosamente con centinaia di
errori SQL tipo:
```
[ERROR]: [1062] Duplicate entry '2160-0-0' for key 'character_action.PRIMARY'
[ERROR]: [1062] Duplicate entry '2165-50977' for key 'character_spell.PRIMARY'
```
Causa: **AzerothCore non usa l'AUTO_INCREMENT nativo di MySQL per `characters.guid`** — il core
ricalcola il prossimo GUID libero come `MAX(guid)+1` scansionando la tabella `characters` all'avvio
(per questo un `ALTER TABLE characters AUTO_INCREMENT = ...` non ha alcun effetto — verificato,
tentativo fallito). Dopo i wipe ripetuti dei bot, `characters` conteneva solo i 5 personaggi reali
(guid 1002-1019), quindi il generatore GUID ripartiva da ~1020 — ma tabelle figlie come
`character_action`, `character_spell`, `character_skills`, `item_instance` contenevano ancora
**righe orfane con guid fino a 5019**, sopravvissute da una popolazione di bot molto più grande
creata in una sessione precedente (fino a 4000 personaggi) e mai ripulita del tutto quando i
personaggi principali erano stati cancellati (le cancellazioni fatte in precedenza toccavano solo
`characters` e `account`, non le ~15 tabelle figlio collegate per `guid`).
**Fix:** pulizia mirata delle righe orfane (guid non presente in `characters`) in tutte le tabelle
figlio pertinenti: `character_action`, `character_spell`, `character_spell_cooldown`,
`character_skills`, `character_talent`, `character_glyphs`, `character_reputation`,
`character_homebind`, `character_queststatus*` (tutte le varianti), `character_inventory`,
`item_instance` (per `owner_guid`), `character_aura`, `character_declinedname`,
`character_equipmentsets`, `character_settings`, `character_social`, `character_stats`,
`character_account_data`, `character_achievement*`, `character_arena_stats`,
`character_entry_point`, `character_instance`, `character_battleground_random`,
`character_banned`, `character_gifts`, `character_brew_of_the_month`, `arena_team_member`,
`group_member`, `guild_member`, `guild_member_withdraw`, `pet_aura`/`pet_spell`/
`pet_spell_cooldown` (per `character_pet`), `lfg_data`, `mail_server_character`. I 5 personaggi
reali (guid 1002-1019, verificati per nome/account prima di procedere) non sono stati toccati.

### 5.4 Stato finale confermato
Dopo entrambi i fix e un riavvio pulito di `ac-worldserver`:
- **0 errori di duplicazione chiave** da quel riavvio in poi.
- 120 account random-bot creati, **1200 personaggi** disponibili (pool completo, non tutti online
  contemporaneamente — normale: solo `MaxRandomBots=50` sono online alla volta).
- **50 bot online**, split **26 Alliance / 24 Horde** (sostanzialmente 50/50, la piccola asimmetria
  è normale rumore statistico del ratio 50/50 su un numero finito di bot).
- Codice di entrambi i moduli confermato vanilla (`git status --short` pulito).

**Lezione generale per il futuro:** quando si cancellano manualmente account/personaggi bot dal DB,
non basta `DELETE FROM characters` + `DELETE FROM account` — vanno ripulite anche le tabelle di
"stato" del modulo Playerbots (`playerbots_account_type`, `playerbots_account_links`,
`playerbots_random_bots`) e, se si vuole essere rigorosi, le tabelle figlio del personaggio (o in
alternativa evitare wipe ripetuti e preferire i comandi console nativi `rndbot reset`/`clear` che
presumibilmente gestiscono la pulizia in modo coerente — non ancora verificato con certezza in
questa sessione se il comando console faccia anche questa pulizia).

## 6. Prossimi passi / cose aperte

- Nessun blocco noto aperto sul fronte Playerbots — situazione confermata funzionante.
- Valutare se il tuning AH Bot (materiali White/Green + più green equip) dà il risultato desiderato
  in game nel tempo; possibili ulteriori aggiustamenti su prezzi Blue/Purple se necessario.
- Bag + letter feature: ripresa solo se richiesto esplicitamente (ID tentativi: 22976, 5839).
- Pulizia minore pendente: `rebuild_vanilla_bracket.log`/`.err.log` in root `c:\azerothcore` (residui
  di questa sessione, non ancora cancellati).
- Bank chest su campfire: **non riprendere** senza nuova richiesta esplicita — già tentata e
  abbandonata per limiti API Eluna in questa build (`SummonCreature` non disponibile).
