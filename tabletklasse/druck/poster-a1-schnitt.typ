// Regelplakat A1 aus 4 × A3, Schnittversion mit Spielraum:
// Eigenes Layout, bei dem kein Element über eine Klebekante läuft (Nähte liegen in weißen Lücken).
// Teil 1 (oben links) bleibt ganz. Teil 2 und 4 werden links, Teil 3 und 4 oben an der gestrichelten
// Linie abgeschnitten und überlappend auf den weißen Klebestreifen des Nachbarteils gelegt.
// --input sw=1 = schwarz-weiß.
#import "icons.typ": icon
#let R = json("regeln.json")
#let sw = sys.inputs.at("sw", default: "0") == "1"
#let teal = if sw { luma(0) } else { rgb("#1f7a72") }
#let orange = if sw { luma(85) } else { rgb("#d9702a") }
#let hell = if sw { luma(150) } else { orange.lighten(40%) }

#let aussen = 16mm            // Rand an den Außenkanten des fertigen Plakats
#let innen = 22mm             // Rand an den Nahtseiten (enthält Schnittlinie bzw. Klebestreifen)
#let schnitt = 14mm           // Abstand der Schnittlinie von der Blattkante (Nahtseite)
#let bw = 297mm - aussen - innen
#let bh = 420mm - aussen - innen
#let strich = (paint: luma(120), thickness: 0.6pt, dash: (5pt, 4pt))

#set page(paper: "a3", margin: 0pt)
#set text(font: "Avenir Next", size: 20pt, lang: "de")
#set par(leading: 0.55em)

// c = Spalte (0 links, 1 rechts), r = Zeile (0 oben, 1 unten)
#let kachel(c, r, inhalt) = {
  let x = if c == 0 { aussen } else { innen }
  let y = if r == 0 { aussen } else { innen }
  // Klebestreifen (wird später überdeckt): rechts bei linken Teilen, unten bei oberen Teilen
  if c == 0 { place(top + left, dx: 297mm - innen + 5mm, dy: 0mm, rect(width: innen - 5mm, height: 420mm, fill: luma(246), stroke: none)) }
  if r == 0 { place(top + left, dx: 0mm, dy: 420mm - innen + 5mm, rect(width: 297mm, height: innen - 5mm, fill: luma(246), stroke: none)) }
  // Schnittlinien: links bei rechten Teilen, oben bei unteren Teilen
  if c == 1 {
    place(top + left, line(start: (schnitt, 0mm), end: (schnitt, 420mm), stroke: strich))
    place(top + left, dx: schnitt - 2.6mm, dy: 4mm, text(11pt, fill: luma(110))[✂])
  }
  if r == 1 {
    place(top + left, line(start: (0mm, schnitt), end: (297mm, schnitt), stroke: strich))
    place(top + left, dx: if c == 1 { 297mm - 10mm } else { 4mm }, dy: schnitt - 3mm, text(11pt, fill: luma(110))[✂])
  }
  place(top + left, dx: x, dy: y, block(width: bw, height: bh, inhalt))
}

// Bausteine
#let titelzeile = 54mm
#let abstand = 9mm
#let kopf = titelzeile + 5mm + 1.1mm + 9mm + 16mm + 4mm
#let gh = (bh - kopf - abstand - 32mm) / 2
#let kh = (bh - 16mm - 4mm - 40mm - 4 * abstand) / 5
#let grundkarte(i, g) = block(width: 100%, height: gh, stroke: 2.2pt + teal, radius: 7mm, inset: 9mm,
  grid(columns: (24mm, 1fr), gutter: 7mm,
    [#icon(g.icon, col: teal, size: 22mm, stroke: 1.5) #v(4mm) #align(center, text(46pt, weight: "bold", fill: teal)[#(i + 1)])],
    [#text(34pt, weight: "bold", fill: teal)[#g.kurz] #v(2mm) #text(27pt)[#g.text]]))
#let klassenkarte(k) = block(width: 100%, height: kh, stroke: (left: 6pt + orange, rest: 1.2pt + hell), radius: 4mm, inset: (x: 7mm, y: 5mm),
  grid(columns: (17mm, 1fr), gutter: 6mm,
    icon(k.icon, col: orange, size: 16mm, stroke: 1.6),
    [#text(26pt, weight: "bold")[#k.titel] #h(2mm) #text(16pt, weight: "bold", fill: orange)[GR #k.bezug] \ #v(1mm) #text(20pt)[#k.text]]))
#let zielkarte = block(width: 100%, height: kh, stroke: 2.2pt + teal, radius: 4mm, inset: 6mm,
  align(center + horizon)[
    #icon("star", col: orange, size: 16mm, stroke: 1.6) \
    #text(20pt, fill: luma(80))[Unser Ziel] \
    #text(32pt, weight: "bold", fill: teal)[#R.ziel.join("  ·  ")]])
#let ueber(t, col) = text(36pt, weight: "bold", fill: col)[#t]
#let unter(t) = text(20pt, fill: luma(100))[#t]

// Grundregeln: links 1 und 3, rechts 2 und 4. Klassenregeln: links die geraden, rechts die ungeraden Plätze (wie A3).
#let G = R.grundregeln
#let K = R.klassenregeln
#let links = range(K.len()).filter(i => calc.even(i)).map(i => K.at(i))
#let rechts = range(K.len()).filter(i => calc.odd(i)).map(i => K.at(i))

// Teil 1: oben links
#kachel(0, 0, {
  block(height: titelzeile, width: 100%, align(bottom, grid(columns: (auto, 1fr), gutter: 8mm, align: (left + bottom, right + bottom),
    icon("tablet", col: teal, size: 34mm, stroke: 1.3),
    stack(spacing: 5mm,
      align(right, text(22pt, weight: "bold", fill: orange, tracking: 3pt)[KLASSE #R.klasse]),
      align(right, text(66pt, weight: "bold", fill: teal)[Unsere Tablets,])))))
  v(5mm); line(length: 100%, stroke: 3pt + orange); v(9mm)
  block(height: 16mm, align(bottom, ueber("Grundregeln der Schule", teal)))
  v(4mm)
  stack(dir: ttb, spacing: abstand, grundkarte(0, G.at(0)), grundkarte(2, G.at(2)))
})
#pagebreak()
// Teil 2: oben rechts
#kachel(1, 0, {
  block(height: titelzeile, width: 100%, align(left + bottom, text(66pt, weight: "bold", fill: teal)[unsere Regeln]))
  v(5mm); line(length: 100%, stroke: 3pt + orange); v(9mm)
  block(height: 16mm, align(left + bottom, text(26pt, fill: luma(80))[#R.motto]))
  v(4mm)
  stack(dir: ttb, spacing: abstand, grundkarte(1, G.at(1)), grundkarte(3, G.at(3)))
})
#pagebreak()
// Teil 3: unten links
#kachel(0, 1, {
  block(height: 16mm, align(bottom, ueber("Unsere Klassenregeln", orange)))
  v(4mm)
  stack(dir: ttb, spacing: abstand, ..links.map(klassenkarte))
  v(1fr)
  line(length: 100%, stroke: 1pt + luma(170))
  text(15pt, fill: luma(80))[#R.verpflichtung]
})
#pagebreak()
// Teil 4: unten rechts
#kachel(1, 1, {
  block(height: 16mm, align(left + bottom, text(26pt, fill: luma(80))[präzisieren die Grundregeln (GR)]))
  v(4mm)
  stack(dir: ttb, spacing: abstand, ..rechts.map(klassenkarte), ..if calc.odd(K.len()) { (zielkarte,) } else { () })
  v(1fr)
  line(length: 100%, stroke: 1pt + luma(170))
  align(right, text(15pt, fill: luma(80))[#R.schule · Klasse #R.klasse])
})
