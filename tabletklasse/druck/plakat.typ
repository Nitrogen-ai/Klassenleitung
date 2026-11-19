// Plakatinhalt für eine A3-Fläche (297 × 420 mm). Genutzt von poster-a3.typ und poster-a1-kacheln.typ.
#import "icons.typ": icon
#let R = json("regeln.json")
#let teal = rgb("#1f7a72")
#let orange = rgb("#d9702a")

#let plakat() = block(width: 297mm, height: 420mm, inset: (x: 18mm, top: 15mm, bottom: 13mm), breakable: false, {
set text(font: "Avenir Next", size: 15pt, lang: "de")
set par(leading: 0.6em)

grid(columns: (auto, 1fr), gutter: 8mm, align: horizon,
  icon("tablet", col: teal, size: 22mm, stroke: 1.4),
  stack(spacing: 4mm,
    text(14pt, weight: "bold", fill: orange, tracking: 2pt)[KLASSE #R.klasse],
    text(36pt, weight: "bold", fill: teal)[Unsere Tablets, unsere Regeln],
    text(17pt, fill: luma(80))[#R.motto]))
v(3mm)
line(length: 100%, stroke: 2pt + orange)
v(4mm)

let head(t, col, sub) = [#text(22pt, weight: "bold", fill: col)[#t] #h(3mm) #text(13pt, fill: luma(100))[#sub]]

head("Grundregeln der Schule", teal, "gelten für alle und unverändert")
v(2mm)
grid(columns: (1fr, 1fr), gutter: 6mm,
  ..R.grundregeln.enumerate().map(((i, g)) => block(width: 100%, height: 51mm, stroke: 1.5pt + teal, radius: 5mm, inset: 6mm,
    grid(columns: (16mm, 1fr), gutter: 4mm,
      [#icon(g.icon, col: teal, size: 13mm, stroke: 1.5) #v(0mm) #align(center, text(26pt, weight: "bold", fill: teal)[#(i + 1)])],
      [#text(17pt, weight: "bold", fill: teal)[#g.kurz] \ #text(12pt)[#g.text]]))))
v(4mm)
head("Unsere Klassenregeln", orange, "präzisieren die Grundregeln (GR)")
v(2mm)
grid(columns: (1fr, 1fr), gutter: 4mm,
  ..R.klassenregeln.map(k => block(width: 100%, stroke: (left: 4pt + orange, rest: 0.8pt + orange.lighten(40%)), radius: 3mm, inset: (x: 5mm, y: 4mm),
    grid(columns: (13mm, 1fr), gutter: 4mm,
      icon(k.icon, col: orange, size: 12mm, stroke: 1.6),
      [#text(15pt, weight: "bold")[#k.titel] #h(2mm) #text(10pt, weight: "bold", fill: orange)[GR #k.bezug] \ #text(11pt)[#k.text]]))),
  block(width: 100%, height: 33mm, stroke: 1.5pt + teal, radius: 3mm, inset: (x: 5mm, y: 4mm),
    align(center + horizon)[
      #icon("star", col: orange, size: 11mm, stroke: 1.6) \
      #text(14pt, fill: luma(80))[Unser Ziel] \
      #text(20pt, weight: "bold", fill: teal)[#R.ziel.join("  ·  ")]]))
v(5mm)
line(length: 100%, stroke: 0.8pt + luma(170))
text(10.5pt, fill: luma(80))[#R.verpflichtung #h(1fr) #R.schule]
})
