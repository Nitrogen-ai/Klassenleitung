// Übersichtsblatt zur Moderation, Layout wie die Stundenblätter (Einstieg + Impulse links, QR rechts).
#import "@preview/tiaoma:0.3.0": qrcode
#import "icons.typ": icon
#let R = json("regeln.json")
#let url = sys.inputs.at("url", default: "https://nitrogen-ai.github.io/Klassenleitung/tabletklasse/workshop.html")
#let spiel = sys.inputs.at("spiel", default: "https://nitrogen-ai.github.io/Klassenleitung/tabletklasse/rosas-tablet.html")
#let teal = rgb("#1f7a72")
#let orange = rgb("#d9702a")
#set page(paper: "a4", margin: (x: 18mm, y: 16mm))
#set text(font: "Avenir Next", size: 10.5pt, lang: "de")
#let lab(t) = text(9.5pt, weight: "bold", fill: teal, upper(t))

#text(20pt, weight: "bold", fill: teal)[Workshop Tabletklasse #R.klasse]
#v(-2mm)
#text(11pt, fill: luma(90))[Classroom · GoodNotes · Unsere Tablets, unsere Regeln]
#v(1mm)
#line(length: 100%, stroke: 1.2pt + orange)
#v(2mm)
#grid(columns: (2fr, 1fr), gutter: 8mm,
  [
    #lab[Einstieg]
    #block(fill: teal.lighten(92%), radius: 3pt, inset: 8pt, width: 100%)[
      #icon("question", col: teal) *Fragerunde zur Einrichtung:* WLAN, Google-Anmeldung, Classroom, GoodNotes, Pencil. \
      Daumenabfrage 👍 👌 👎, Fertige helfen den Nachbar:innen.]
    #v(3mm)
    #lab[Impulse]
    #set enum(spacing: 0.9em)
    + #icon("board", col: teal) Classroom: Kurs „Klasse 9.1“ → Kursaufgaben → „Tabletworkshop (Classroom, Goodnotes und Tabletregeln)“
    + #icon("import", col: teal) Material öffnen: Teilen → „In Goodnotes öffnen“ → als neues bzw. in aktuelles Dokument importieren
    + #icon("pen", col: teal) Apple Pencil: „Mit einem Finger verschieben“ einschalten
    + #icon("list", col: teal) Werkzeugleiste 1–24 durchgehen
    + #icon("cloud", col: teal) Auto-Backup: Google Drive, Dateiformat „Goodnotes“
    + #icon("timer", col: orange) *Rosas Tablet, 20 min:* Tisch 1 Classroom + Docs/Sheets/Präsentationen, Tisch 2 GoodNotes 1–24, Zertifikat als PDF
    + #icon("scale", col: teal) Ergebnis: Grundregeln 1–4 und unsere Klassenregeln (u. a. Rucksack zu Beginn, flach auf dem Tisch)
    + #icon("pen", col: teal) Vertrag in GoodNotes unterschreiben, als PDF exportieren
    + #icon("check", col: orange) *Abgabe im Classroom* (Tabletworkshop, ab 23.11., 8:25 Uhr): Klassenregeln, Zertifikat, Text, Präsentation, Tabelle, \
      Benennung #text(9pt)[`JJJJ-MM-TT-Inhalt-Name`], z. B. #text(9pt)[`2026-11-23-Textdokument-Poremski`]
    #v(3mm)
    #lab[Material]
    #text(9.5pt)[Vertrag (A4, 1 Seite pro Schüler:in) · Regelplakat A3 bzw. A1 aus 4 × A3 · Präsentation und Rosas Tablet (QR, anklickbar)]
  ],
  [
    #lab[Links]
    #block(stroke: (left: 1pt + luma(190)), inset: (left: 8pt))[
      #link(url, qrcode(url, options: (scale: 2.2)))
      #text(8.5pt, fill: luma(90))[*Präsentation* \ (Pfeiltasten, F = Vollbild)]
      #v(1mm)
      #text(7pt, fill: luma(110), link(url, url))
      #v(5mm)
      #link(spiel, qrcode(spiel, options: (scale: 2.2)))
      #text(8.5pt, fill: luma(90))[*Rosas Tablet* \ Übungsspiel mit Zertifikat]
      #v(1mm)
      #text(7pt, fill: luma(110), link(spiel, spiel))
    ]
  ])
