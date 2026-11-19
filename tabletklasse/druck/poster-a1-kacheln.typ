// Regelplakat in A1-Größe zum Selbstdrucken: 4 × A3 (2 × 2), jeweils mit 10 mm Druckrand.
// Innenkanten an der gestrichelten Linie abschneiden, Stoß an Stoß legen, hinten mit Tesafilm kleben.
#import "plakat.typ": plakat
#let rand = 10mm                              // Druckrand, den jeder Drucker sicher schafft
#let wt = 297mm - 2 * rand                    // sichtbare Breite je Kachel
#let k = 2 * wt / 297mm                       // Vergrößerung A3 → zusammengesetzt (≈ 1,87)
#let ht = 420mm * k / 2                       // sichtbare Höhe je Kachel
#let mv = (420mm - ht) / 2                    // Rand oben/unten
#let grau = luma(120)
#let schnitt = (paint: luma(90), thickness: 0.6pt, dash: (4pt, 3pt))

#set page(paper: "a3", margin: 0pt)
#set text(font: "Avenir Next", size: 8pt, fill: grau, lang: "de")

#let namen = ("oben links", "oben rechts", "unten links", "unten rechts")

#for r in (0, 1) {
  for c in (0, 1) {
    let n = r * 2 + c
    // Ausschnitt des vergrößerten Plakats
    place(top + left, dx: rand, dy: mv,
      box(width: wt, height: ht, clip: true,
        move(dx: -c * wt, dy: -r * ht, scale(k * 100%, origin: top + left, reflow: false, plakat()))))
    // Außenkanten: feine Rahmenlinie; Innenkanten: Schnittlinie bis zum Blattrand
    let x0 = rand
    let x1 = rand + wt
    let y0 = mv
    let y1 = mv + ht
    let innenX = if c == 0 { x1 } else { x0 }
    let innenY = if r == 0 { y1 } else { y0 }
    place(top + left, line(start: (innenX, 0mm), end: (innenX, 420mm), stroke: schnitt))
    place(top + left, line(start: (0mm, innenY), end: (297mm, innenY), stroke: schnitt))
    // Scheren an den Schnittlinien
    place(top + left, dx: innenX - 2.2mm, dy: if r == 0 { 3mm } else { 420mm - 7mm }, text(9pt, fill: luma(90))[✂])
    place(top + left, dx: if c == 0 { 3mm } else { 297mm - 7mm }, dy: innenY - 2.6mm, text(9pt, fill: luma(90))[✂])
    // Beschriftung im Rand (außen), mit Lageskizze
    let skizze = grid(columns: (3mm, 3mm), rows: (4mm, 4mm), gutter: 0.6pt,
      ..range(4).map(i => rect(width: 3mm, height: 4mm, stroke: 0.4pt + grau, fill: if i == n { grau } else { none })))
    let info = stack(dir: ltr, spacing: 2mm, skizze, align(horizon)[
      *Teil #(n + 1) von 4 (#namen.at(n))* · Regelplakat A1 aus 4 × A3 \
      An der gestrichelten Linie schneiden, Teile Stoß an Stoß legen, auf der Rückseite mit Tesafilm kleben.])
    let ix = if c == 0 { rand } else { rand + 8mm }
    if r == 0 { place(top + left, dx: ix, dy: 2.2mm, info) } else { place(top + left, dx: ix, dy: 420mm - mv + 2.2mm, info) }
    if n < 3 { pagebreak() }
  }
}
