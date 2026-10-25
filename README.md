# Breno's Arcade

A local arcade hub for games built with Claude Code. Open `index.html` (or run `run.command`) to browse and play.

## Games

| Game | Genre | Notes |
|---|---|---|
| Tank Game 3D | Shooter | Diep.io-style 3D tank arena (three.js) |
| Tank Arena | Shooter | Top-down 2D tank battle vs. AI bots |
| Ultimate Eleven | Sports | FIFA-style soccer manager with pack openings and live matches |
| Soccer RNG | Sports | Arcade soccer with randomized mechanics and lucky spins |
| Sword Ball | Action | Sword duels against NPCs and a tracking ball |
| Geometry Dash 3D | Platformer | Geometry Dash clone in 3D with a level editor |
| Web Swing | Action | Spider-Man-style web-swinging traversal |
| Ragdoll Valley | Sandbox | three.js ragdoll physics sandbox |
| The Long Dark Below | Action | Medieval dungeon escape prototype |
| Rival Fighters | Fighting | 8 fighters, 6 arenas, 1v1 or vs CPU, punches/kicks/grabs/specials |
| Head On | Racing | Arena car combat, ram to score, best of 5 rounds vs. AI |
| Build Royale | Battle Royale | 2D side-view battle royale — build walls/floors/ramps, storm shrinks, bots hunt you |
| Paper Minecraft | Sandbox | Tiny 2D block-world sandbox — mining, building, crafting, day/night, world seeds |
| Particle Wave Field | Simulation | Real-time 3D water simulator — particle grid driven by a wave-equation solver, drag to orbit, click to ripple |
| Matter | Simulation | Falling-particle sandbox — sand, water, stone, wood, fire, oil, acid, bombs, all interacting |
| Boids | Simulation | Flocking simulation — multiple flocks, tunable separation/alignment/cohesion, mouse and mic reactive |
| Adrift | Survival | First-person raft survival — fish/hook scrap, craft upgrades, sail to islands, watch for sharks |
| Lava Leap | Platformer | 3D platformer across three floating worlds — collect gems, dodge lava spikes, reach the portal |
| Kart Rush 3D | Racing | Fan-made 3D kart racer — character/vehicle select, Grand Prix / Knockout Tour / Balloon Pop modes |
| Range Ops | Shooter | First-person target range — shoot, throw grenades, chase accuracy and streak scores |
| Aperture Test Chambers | Puzzle | Fan-made Portal-style puzzle game — orange/blue portals, cube puzzles, 53 chambers |
| Perspective | Puzzle | Rotate-the-view puzzle — ball falls and freezes while you turn the camera, 50 levels |
| Amoung Us | Social Deduction | Tiny fan-made Among Us-like — tasks, sabotage, kills, emergency meetings and voting |
| SFS — Spaceflight Simulator | Simulation | Build a rocket part by part and fly it — real orbital physics, staging, throttle, map view, challenges |
| Mechazilla — Booster Catch | Physics | Guide a falling booster into a catch tower's arms — main engine and rotation thrusters, only the ground ends a run |
| ROOM | Sandbox | Tiny first-person three.js playground — punch, kick, find a gun and web-shooter, swing, use the computer, all in one room |
| PAPER SKY | Sandbox | Draw anything on a sketchpad and it folds into a paper plane that really flies — walk a first-person meadow and fill the sky |
| Nine — First-Person Baseball | Sports | Field 3 outs, then bat 3 outs, for 9 innings, entirely first-person — pitch, swing timing, fielding, base running |
| SPING | Platformer | Grab, swing, fly — grapple pivot to pivot across 6 worlds and 90 levels, chase gems and best times |
| Blockcraft | Sandbox | Full 3D Minecraft-style voxel game — mine, build, craft, fight mobs, raid a stronghold, step through a Nether portal |
| Blocky CAD | Creative | Design real 3D models by gluing and cutting solid shapes — drill holes, sculpt, check wall thickness, export for printing |
| Marble Run Tycoon | Tycoon | Buy chutes and curves from a six-tier rarity shop, build a track, run the marble for cash |
| Quintle | Word | Daily Wordle-style puzzle in 5, 7 and 9 letters — archive, streaks and per-size stats |
| Parking Lot Jam | Puzzle | Rush-Hour-style sliding-car puzzle — clear the blockers, drive the red car out, beat par |
| Jigsaw Table | Puzzle | Jigsaw on a virtual table — six drawn pictures or your own photo, 12 to 1000 pieces |
| Tetris | Puzzle | Modern guideline Tetris — SRS rotation, 7-bag randomiser, hold slot, ghost piece |
| Universe Engine | Simulation | The real Solar System computed live from NASA/JPL data — 604 bodies, real stars and galaxies, from the Big Bang to the far future. A folder rather than one file — see below |
| Golazo 26 | Sports | 3D FC-style football — Kick Off, Ultimate Team packs, Career, Rush, International Cup, Copa do Brasil, 144 clubs and 100 nations. Crests and flags load from the internet; offline it draws plain shields |
| Home Row | Learning | Touch-typing tutor — 17 locked levels from F and J to capitals, 90% accuracy to unlock the next keys |

> Not included yet: **OFFBEAT**, a Just Shapes & Beats-inspired rhythm dodge game. It was never saved to a local file and only exists as a published claude.ai artifact (https://claude.ai/code/artifact/c52ba614-d344-44d2-9555-abc2d69ee506) from a session where the scratchpad got cleared. Recover it by signing into the Claude in Chrome extension (or opening that link and saving the page source) and adding it as `games/offbeat/index.html`, then add its card back to `index.html`.

Every game lives at `games/<slug>/index.html` as a single self-contained file (Universe Engine
also has an `assets/` folder beside it, see below). No build step, no server, no network: every library (three.js, cannon-es, React, JSZip) is inlined, so each file runs
on its own by double-clicking it. The only things still loaded from the internet are a webfont in four
games (they fall back to system fonts offline) and Golazo 26's club crests and national flags (it
draws generated shields instead when offline).

## Running

Double-click `index.html`. That's it — it works the same on macOS, Windows, ChromeOS, or from a USB
stick, online or off.

`./run.command` also exists (macOS only). It serves the folder over `http://localhost:<port>` and
opens a browser. You don't need it to play; it's useful when you want a real HTTP origin — per-game
`localStorage` (saves and high scores are shared between games on `file://`), or reaching the arcade
from another device on your network.

## As an installed app

Published at https://claude.ai/code/artifact/3d000f85-e50b-416a-aced-e3654287829e — open it in
Chrome and install it for a launcher icon and its own window. A service worker caches the games, and
the download button in the top-right pulls all 41 down for offline play. Universe Engine isn't
among them — it's too big for the host (see below).

`.app-build/` holds the pieces that only the hosted version needs: the hub with the install and
offline controls added, plus `sw.js`, the manifest and the icons. They're deliberately absent from
the local folder — service workers don't run on `file://`, so there they'd be dead weight. To
republish after changing a game, re-run the publish against that same URL so the link stays put, and
bump `VERSION` in `.app-build/sw.js` — the worker is cache-first, so without a bump anyone who already
saved the arcade offline keeps being served the old copy.

`.app-build/arcade.html` is generated from `index.html` with one extra step: the Universe Engine card
is stripped before publishing, since the Artifact host caps a version at 64 MB total and that game
alone is ~100 MB. The local `index.html` keeps every game; only the hosted build drops Universe Engine.

## Universe Engine — the one exception

Every other game is a single self-contained HTML file. Universe Engine is a real astronomical
simulator (604 bodies on NASA/JPL orbits, star and galaxy catalogs, textures, recordings) with about
100 MB of data, too much for one HTML file. So `games/universe-engine/` is a small folder: an
`index.html` with the loading screen and styles, plus `assets/`, which holds the app and three.js as
scripts and each data file wrapped in a `.js` file (base64, gzipped). The page loads those with
`<script>` tags, which work on `file://` where `fetch()` doesn't. It opens with a double-click like everything else. It's built
from the project by `python3 tools/build_standalone.py` (in `~/universe engine`), which writes
`standalone/`; that folder is the copy's source.

`.sources.tsv` marks it `tree` mode, and `.refresh.py` checks it by comparing the whole file tree
byte-for-byte against `universe engine/standalone`, not with the line-membership check every other
game gets. The one exception is `index.html`, which gets the back-to-arcade link, so it gets the
line check. To re-sync after changing the game, rebuild `standalone/` and copy it over
`games/universe-engine/`, then re-add the back link after `<body>`.

It's still excluded from the offline-download button and the hosted app. At ~107 MB it's over the
host's 64 MB cap by itself.

## Keeping it in sync

The games are mirrors. Their originals live elsewhere on this machine and are the source of truth;
`.sources.tsv` maps each game back to its source folder.

```
python3 .refresh.py                                   # check every game for drift
python3 .refresh.py blockcraft                        # or just one
python3 .consolidate.py <source.html> <game-slug>     # re-sync one that drifted
```

`.consolidate.py` wraps the source, adds the back-to-arcade link, and inlines everything the page
loads: `<script src>` and `<link rel=stylesheet>` from beside the source or from `vendor/`, plus
single-entry ES modules — it reads the importmap, swaps bare imports for the library's global, and
wraps the entry in an IIFE, since modules don't load over `file://`. A multi-file module graph
(Golazo 26 has 64 files, with `export … from` re-exports and lazy `import()`) is bundled the same way,
and a source `assets/` folder is embedded as base64 with a small `fetch`/`<img>` shim, so a game that
loads its own model or data files still runs from a double-click. `.refresh.py` checks those embedded
files byte-for-byte. Remote webfonts are left alone;
they fall back to system fonts offline. It's idempotent — re-running on an unchanged source produces
the same bytes.

It compares content, not timestamps — a no-op rebuild bumps an mtime without changing anything, and
a consolidated copy is always "newer" than the source it was built from. It normalises the namespacing
that bundling introduces (`CX` → `ChunkModule.CX`) and ignores the tags consolidation replaces
(`<script src>`, `<link rel=stylesheet>`, importmap entries), so only real differences are reported.

It also flags a debug hook (`window.__debug` and friends) that a copy still carries but its source
no longer has — the one-directional check below cannot see a deletion, and that let a stale hook sit
in a published game. Byte-comparing against a fresh rebuild would catch deletions in general, but
`.consolidate.py` cannot reproduce every game yet (several carry three.js addons it can't resolve),
so that comparison is drowned in false alarms; `.sources.tsv` records each game's entry file for
when it can.

It checks **every** line, and any missing line is drift. Two earlier designs both let real changes
slip past: sampling ~60 lines per file missed a 27-line change inside a 1,160-line module (the
samples fell either side of it), and a percentage threshold couldn't catch it either, since 27/1160
is under 2%. A two-line tolerance then let Blocky CAD through when it drifted by exactly two lines.
Every source file now matches its copy exactly; the handful of genuinely-intentional transforms are
listed by content in `ALLOWED_MISSING`, and build outputs that merely restate their own source are
listed in `IGNORE`.

Universe Engine gets a different check entirely. `.sources.tsv`'s fourth column marks it `tree`,
and `.refresh.py` walks its source folder (`universe engine/standalone`, the built copy) comparing
bytes file-for-file against the arcade copy. Its data is too big to flatten into one file, and the
line-membership check would report every asset file as "not present in any copy."
