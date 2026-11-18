#!/usr/bin/env python3
"""Baut alles für den Workshop Tabletklasse aus einer Quelle (druck/regeln.json).

- workshop.html     (eine Datei, offline lauffähig, Bilder/Icons eingebettet)
- druck/icons.typ   (aus icons.py)
- PDFs (Vertrag, A3-Plakat, Übersichtsblatt) + Kopien von HTML und Typst nach iCloud
"""
import base64, html, json, shutil, subprocess, sys
from pathlib import Path

import icons

HERE = Path(__file__).resolve().parent
DRUCK = HERE / "druck"
ICLOUD = Path.home() / "Library/Mobile Documents/com~apple~CloudDocs/Unterricht/Klassenleitung/Tabletklasse"
URL = "https://nitrogen-ai.github.io/Klassenleitung/tabletklasse/workshop.html"

R = json.loads((DRUCK / "regeln.json").read_text(encoding="utf-8"))
e = html.escape


def ico(name):
    return f'<span class="ico">{icons.svg(name)}</span>'


def build_html():
    src = (HERE / "workshop.src.html").read_text(encoding="utf-8")
    gr = "".join(
        f'<div class="card t"><span class="badge">{ico(g["icon"])}</span>'
        f'<div><h3>{n}. {e(g["kurz"])}</h3><p>{e(g["text"])}</p></div></div>'
        for n, g in enumerate(R["grundregeln"], 1)
    )
    kr = "".join(
        f'<div class="card o"><span class="badge o">{ico(k["icon"])}</span>'
        f'<div><h3>{e(k["titel"])}<span class="ref">GR {e(k["bezug"])}</span></h3><p>{e(k["text"])}</p></div></div>'
        for k in R["klassenregeln"]
    )
    ni = "".join(
        f'<div class="note"><p><b>{e(x["vorschlag"])}</b><br>{e(x["grund"])}</p></div>'
        for x in R["nicht_uebernommen"]
    )
    rep = {
        "{{KLASSE}}": e(R["klasse"]), "{{SCHULE}}": e(R["schule"]), "{{MOTTO}}": e(R["motto"]),
        "{{GRUNDREGELN_TITEL}}": e(R["grundregeln_titel"]), "{{GRUNDREGELN}}": gr,
        "{{KLASSENREGELN}}": kr, "{{NICHT}}": ni, "{{HINWEIS}}": e(R["hinweis"]),
        "{{VERPFLICHTUNG}}": e(R["verpflichtung"]),
        "{{ZIEL}}": "".join(f"<span>{e(z)}</span>" for z in R["ziel"]),
    }
    for k, v in rep.items():
        src = src.replace(k, v)
    for name in icons.PATHS:
        src = src.replace("{{ICON:%s}}" % name, ico(name))
    for img in (HERE / "assets").glob("*.jpg"):
        b64 = base64.b64encode(img.read_bytes()).decode()
        src = src.replace("{{IMG:%s}}" % img.stem, "data:image/jpeg;base64," + b64)
    if "{{" in src:
        sys.exit("Unersetzter Platzhalter in workshop.src.html: " + src[src.index("{{"):][:40])
    (HERE / "workshop.html").write_text(src, encoding="utf-8")
    return HERE / "workshop.html"


def main():
    (DRUCK / "icons.typ").write_text(icons.typst_module(), encoding="utf-8")
    out = build_html()
    print("HTML:", out)
    if not ICLOUD.exists():
        print("iCloud-Ordner fehlt, PDFs übersprungen:", ICLOUD)
        return
    pdfs = {
        "vertrag.typ": f"Tablet-Regeln Vertrag {R['klasse']}.pdf",
        "poster-a3.typ": f"Tablet-Regeln Plakat A3 {R['klasse']}.pdf",
        "uebersicht.typ": "Workshop Tabletklasse Übersicht.pdf",
    }
    for typ, pdf in pdfs.items():
        subprocess.run(["typst", "compile", "--input", f"url={URL}", str(DRUCK / typ), str(ICLOUD / pdf)], check=True)
        print("PDF:", ICLOUD / pdf)
    shutil.copy2(out, ICLOUD / "Workshop Tabletklasse.html")
    tdir = ICLOUD / "Typst (Kopie, Quelle im Repo Klassenleitung)"
    tdir.mkdir(exist_ok=True)
    for f in DRUCK.iterdir():
        if f.suffix in (".typ", ".json"):
            shutil.copy2(f, tdir / f.name)
    print("Kopien:", ICLOUD)


if __name__ == "__main__":
    main()
