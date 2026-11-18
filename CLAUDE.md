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
- `icons.py`: Linien-Icons für HTML und Typst (`druck/icons.typ` wird erzeugt).
- `python3 build.py` baut alles und legt PDFs (Vertrag A4, Plakat A3,
  Übersichtsblatt mit QR) + HTML + Typst-Kopien nach
  iCloud `Unterricht/Klassenleitung/Tabletklasse`. PDFs gehören nicht ins Repo.
