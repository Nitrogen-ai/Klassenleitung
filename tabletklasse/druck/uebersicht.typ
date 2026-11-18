// Übersichtsblatt zur Moderation, Layout wie die Stundenblätter (Einstieg + Impulse links, QR rechts).
#import "@preview/tiaoma:0.3.0": qrcode
#import "icons.typ": icon
#let R = json("regeln.json")
#let url = sys.inputs.at("url", default: "https://nitrogen-ai.github.io/Klassenleitung/tabletklasse/workshop.html")
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
    + #icon("board", col: teal) Classroom: Einladung „Einführungsworkshop Tabletklasse“ annehmen, Kursaufgaben zeigen
    + #icon("import", col: teal) Material öffnen: Teilen → „In Goodnotes öffnen“ → als neues bzw. in aktuelles Dokument importieren
    + #icon("pen", col: teal) Apple Pencil: „Mit einem Finger verschieben“ einschalten
    + #icon("list", col: teal) Werkzeugleiste 1–24 durchgehen
    + #icon("cloud", col: teal) Auto-Backup: Google Drive, Dateiformat „Goodnotes“
    + #icon("timer", col: orange) *Schnupperrunde GoodNotes, 20 min:* Liste im Classroom, gegenseitig helfen
    + #icon("scale", col: teal) Grundregeln 1–4 gemeinsam lesen
    + #icon("timer", col: orange) *Gruppenarbeit Regelplakat, 15 min:* Regeln + Begründung, Präsentator:in bestimmen
    + #icon("megaphone", col: teal) Vorstellen, abstimmen, Plakat zum Aufhängen wählen
    + #icon("ban", col: orange) Abgleich: Klassenregeln präzisieren, schwächen die Grundregeln nicht ab
    + #icon("pen", col: teal) Vertrag eigenständig unterschreiben lassen, einsammeln
    #v(3mm)
    #lab[Material]
    #text(9.5pt)[Vertrag (A4, 1 Seite pro Schüler:in) · Regelplakat A3 · Präsentation (QR)]
  ],
  [
    #lab[Links]
    #block(stroke: (left: 1pt + luma(190)), inset: (left: 8pt))[
      #qrcode(url, options: (scale: 2.2))
      #text(8.5pt, fill: luma(90))[Präsentation \ (Pfeiltasten, F = Vollbild)]
      #v(2mm)
      #text(7pt, fill: luma(110), url)
    ]
  ])
