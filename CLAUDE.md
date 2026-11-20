# Klassenleitung

## Was hier liegt
- Material zur Klassenleitung (Workshops, Regeln, Moderation) als HTML und Typst.
- GitHub Pages: https://nitrogen-ai.github.io/Klassenleitung/

## Öffentlich, Vorsicht
- Repo ist public. KEINE Schüler-Klarnamen, Noten, Klassenrat-Inhalte oder
  andere personenbezogene Daten in Dateien oder Commit-Nachrichten.
  (Ein Gruppenplakat der Tabletklasse trägt Namen, die bleiben in iCloud.)
- Unterschriebene Verträge und Fotos nie ins Repo.

## tabletklasse/
- Einzige Quelle der Regeltexte: `druck/regeln.json` (Grundregeln wörtlich
  aus der Workshop-Präsentation, Klassenregeln der 9.1 aus den Gruppenplakaten).
  Klassenregeln dürfen die Grundregeln nur präzisieren, nie abschwächen.
- `workshop.src.html` ist die Vorlage; `workshop.html` wird von `build.py`
  erzeugt (Bilder aus `assets/` und Icons eingebettet, offline lauffähig).
  Nie `workshop.html` von Hand bearbeiten.
- `rosas-tablet.src.html` -> `rosas-tablet.html` (build.py): Übungsspiel im Stil von
  Rosas Säurelabor. Tisch 1 Classroom/Docs/Sheets/Präsentationen als Klick-Simulation,
  Tisch 2 GoodNotes-Werkzeugleiste 1–24 (Positionen auf `assets/werkzeuge.jpg`),
  Zertifikat-PDF heißt `JJJJ-MM-TT-Zertifikat-Nachname.pdf`. Verlinkt auf Folie 8.
  Space-Design wie Rosas Proteine (Chemie-Repo): `space-theme.css`/`space-theme.js` setzt build.py als
  Themenschicht ein (Raum, Tische, Textur, Rosa-Antenne, Holo-Sprechblase); jede Ersetzung wird geprüft.
- `druck/plakat.typ` ist der Plakatinhalt; `poster-a3.typ` (A3) und
  `poster-a1-kacheln.typ` (A1 aus 4 × A3 mit Schnittlinien, `--input sw=1` = schwarz-weiß) nutzen ihn.
- `poster-a1-schnitt.typ`: eigenes A1-Layout aus 4 × A3, Nähte liegen in weißen Lücken
  (Titel am Wortende geteilt). Teile rechts/unten werden an der Schnittlinie gekürzt und
  überlappend auf den Klebestreifen gelegt. Gebaut als schwarz-weiß.
- `icons.py`: Linien-Icons für HTML und Typst (`druck/icons.typ` wird erzeugt).
- `python3 build.py` baut alles und legt PDFs (Vertrag A4, Plakat A3, Plakat A1 aus 4 × A3,
  Übersichtsblatt mit klickbaren QR-Codes) + HTML + Typst-Kopien nach
  iCloud `Unterricht/Klassenleitung/Tabletklasse`. PDFs gehören nicht ins Repo.
