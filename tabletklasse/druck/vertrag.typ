#import "icons.typ": icon
#let R = json("regeln.json")
#let teal = rgb("#1f7a72")
#let orange = rgb("#d9702a")
#set page(paper: "a4", margin: (x: 18mm, top: 14mm, bottom: 14mm))
#set text(font: "Avenir Next", size: 9.6pt, lang: "de")
#set par(justify: true, leading: 0.55em)

#grid(columns: (1fr, auto), align: (left + bottom, right + bottom),
  text(16pt, weight: "bold", fill: teal)[Unsere Tablets, unsere Regeln],
  text(9pt, fill: luma(90))[#R.schule · Klasse #R.klasse])
#line(length: 100%, stroke: 1.2pt + orange)
#v(1mm)
#text(11pt, weight: "bold")[#R.grundregeln_titel]
#v(1mm)
#for (i, g) in R.grundregeln.enumerate() {
  block(width: 100%, stroke: (left: 1.6pt + teal), inset: (left: 7pt, y: 3pt), below: 4pt,
    grid(columns: (14pt, 1fr), gutter: 6pt,
      icon(g.icon, col: teal, size: 13pt),
      [*#(i + 1). #g.kurz:* #g.text]))
}
#v(2mm)
#text(11pt, weight: "bold")[Unsere klasseninternen Regeln (#R.klasse)]
#h(4pt) #text(8.5pt, fill: luma(90))[präzisieren die Grundregeln, Bezug in Klammern]
#v(1mm)
#grid(columns: (1fr, 1fr), gutter: 5pt,
  ..R.klassenregeln.map(k => block(width: 100%, stroke: 0.7pt + orange.lighten(30%), radius: 3pt, inset: 5pt,
    grid(columns: (13pt, 1fr), gutter: 5pt, icon(k.icon, col: orange, size: 12pt),
      text(8.8pt)[*#k.titel* (GR #k.bezug) \ #k.text]))))
#v(1.5mm)
#text(8.5pt, fill: luma(70))[#icon("star", col: orange, size: 9pt) *Ziel:* #R.ziel.join(" · ") #h(1fr) #icon("ban", col: luma(110), size: 9pt) #R.hinweis]
#v(3mm)
#block(width: 100%, stroke: 1pt + teal, radius: 3pt, inset: 8pt)[
  #R.verpflichtung Die klasseninternen Regeln der #R.klasse habe ich gelesen und halte mich ebenfalls daran.
  #v(9mm)
  #grid(columns: (1.3fr, 0.8fr, 1.3fr), gutter: 10pt,
    ..([Name (Druckbuchstaben)], [Ort, Datum], [Unterschrift Schüler:in]).map(t =>
      [#line(length: 100%, stroke: 0.6pt) #v(-2mm) #text(8pt, fill: luma(90), t)]))
]
