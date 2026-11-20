// ---------- Space-Thema (wie Rosas Proteine „Raumstation Peptidia“): ersetzt Raum, Tische, Textur ----------
function ell(x, y, rx, ry, fill, stroke, lw){ ctx.beginPath(); ctx.ellipse(x, y, Math.max(.1, rx), Math.max(.1, ry), 0, 0, Math.PI * 2); if (fill){ ctx.fillStyle = fill; ctx.fill(); } if (stroke){ ctx.strokeStyle = stroke; ctx.lineWidth = lw || 4; ctx.stroke(); } }
const SP = { void:'#05070f', hull:'#1a2238', hullL:'#28324f', hullXL:'#3a4669', seam:'#0b1020', cyan:'#4ef0ff', cyanD:'#1593a8',
  mag:'#ff4fd8', gold:'#ffd23f', orange:'#ff8a1f', lime:'#7dff6a', red:'#ff4a5e', steel:'#c9d2e3', steelD:'#8d98b2', grate:'#141a2c' };
const STARS = (() => { const r = rnd(42), a = []; for (let i = 0; i < 140; i++) a.push([r(), r(), .4 + r() * 1.8, r() * 6.28]); return a; })();
function rivets(x1, y1, x2, y2, n, col){ for (let i = 0; i <= n; i++){ const k = i / n; circ(x1 + (x2 - x1) * k, y1 + (y2 - y1) * k, 4, col || SP.hullXL, SP.seam, 2); } }
function hazard(x, y, w, h){
  ctx.save(); ctx.beginPath(); ctx.rect(x, y, w, h); ctx.clip(); ctx.fillStyle = SP.gold; ctx.fillRect(x, y, w, h);
  for (let k = -h; k < w + h; k += 34) poly([x + k, y + h, x + k + 17, y + h, x + k + 17 + h, y, x + k + h, y], '#111'); ctx.restore();
  ctx.strokeStyle = SP.seam; ctx.lineWidth = 3; ctx.strokeRect(x, y, w, h);
}
function neonTxt(c, s, x, y, size, col, font, align){
  c.save(); c.font = `${size}px ${font || '"Orbitron","Trebuchet MS",sans-serif'}`; c.textAlign = align || 'left';
  c.shadowColor = col; c.shadowBlur = size * .45; c.fillStyle = col; c.fillText(s, x, y); c.shadowBlur = 0; c.fillStyle = 'rgba(255,255,255,.85)'; c.fillText(s, x, y); c.restore();
}
function porthole(cx, cy, r, planet){
  circ(cx, cy, r + 26, SP.steelD, SP.seam, 6); circ(cx, cy, r + 12, SP.hullL, SP.seam, 4);
  for (let i = 0; i < 12; i++){ const a = i * Math.PI / 6; circ(cx + Math.cos(a) * (r + 19), cy + Math.sin(a) * (r + 19), 4, SP.steel, SP.seam, 2); }
  ctx.save(); ctx.beginPath(); ctx.arc(cx, cy, r, 0, Math.PI * 2); ctx.clip();
  const g = ctx.createRadialGradient(cx - r * .3, cy - r * .4, 10, cx, cy, r * 1.2); g.addColorStop(0, '#1b1446'); g.addColorStop(1, '#03040c');
  ctx.fillStyle = g; ctx.fillRect(cx - r, cy - r, r * 2, r * 2);
  const rr = rnd(cx | 0); for (let i = 0; i < 70; i++) circ(cx - r + rr() * r * 2, cy - r + rr() * r * 2, rr() * 1.8 + .3, 'rgba(255,255,255,' + (.4 + rr() * .6) + ')');
  if (planet){ const [px, py, pr, c1, c2] = planet;
    const pg = ctx.createRadialGradient(px - pr * .4, py - pr * .4, pr * .1, px, py, pr); pg.addColorStop(0, c1); pg.addColorStop(1, c2);
    ctx.save(); ctx.translate(px, py); ctx.rotate(-.35); ell(0, 0, pr * 1.9, pr * .42, null, 'rgba(255,210,140,.55)', 5); ctx.restore();
    circ(px, py, pr, pg);
    ctx.save(); ctx.beginPath(); ctx.arc(px, py, pr, 0, Math.PI * 2); ctx.clip(); for (let k = -3; k < 4; k++) line(px - pr, py + k * pr * .25, px + pr, py + k * pr * .25 - 8, 'rgba(255,255,255,.12)', 6); ctx.restore();
    ctx.save(); ctx.translate(px, py); ctx.rotate(-.35); ctx.beginPath(); ctx.ellipse(0, 0, pr * 1.9, pr * .42, 0, 0, Math.PI); ctx.strokeStyle = 'rgba(255,210,140,.75)'; ctx.lineWidth = 5; ctx.stroke(); ctx.restore(); }
  ctx.restore();
  ctx.save(); ctx.beginPath(); ctx.arc(cx, cy, r - 8, Math.PI * 1.1, Math.PI * 1.45); ctx.strokeStyle = 'rgba(255,255,255,.35)'; ctx.lineWidth = 8; ctx.stroke(); ctx.restore();
}
function airlock(x1, x2, top, bot, sign, col, label1, label2){
  const w = x2 - x1;
  poly([x1 - 8, top - 14, x2 + 8, top - 18, x2 + 10, bot + 6, x1 - 10, bot + 12], SP.hullXL, SP.seam, 6);
  poly([x1, top, x2, top - 4, x2, bot, x1, bot + 6], '#59647f', SP.seam, 4);
  line(x1 + w / 2, top, x1 + w / 2, bot + 3, SP.seam, 4);
  for (let y = top + 40; y < bot - 20; y += 70) line(x1 + 8, y, x2 - 8, y - 2, 'rgba(11,16,32,.35)', 3);
  hazard(x1 + 4, bot - 46, w - 8, 30);
  poly([x1 + 8, top + 46, x2 - 8, top + 42, x2 - 8, top + 120, x1 + 8, top + 124], SP.seam, col, 3);
  ctx.save(); ctx.font = 'bold 12px "Orbitron","Trebuchet MS",sans-serif'; ctx.textAlign = 'center'; ctx.fillStyle = col; ctx.shadowColor = col; ctx.shadowBlur = 8;
  ctx.fillText(label1, x1 + w / 2, top + 76); ctx.fillText(label2, x1 + w / 2, top + 104); ctx.restore();
  circ(x1 + w / 2, top + 210, 22, '#0b1020', SP.steel, 5); circ(x1 + w / 2 - 6, top + 204, 5, 'rgba(255,255,255,.4)');
  circ(x1 + w / 2, top + 22, 8, col, SP.seam, 2);
  if (sign){ ctx.save(); ctx.translate(x1 + w / 2, top + 300); ctx.rotate(-.06);
    poly([-44, -22, 44, -24, 46, 26, -42, 28], '#fff59a', '#333', 2);
    ctx.fillStyle = '#222'; ctx.font = 'bold 11px "Trebuchet MS",sans-serif'; ctx.textAlign = 'center'; sign.forEach((s, i) => ctx.fillText(s, 2, -6 + i * 14)); ctx.restore(); }
}
drawRoom = function(c){
  ctxSwap(c, () => {
    ctx.fillStyle = SP.void; ctx.fillRect(0, 0, W, H);
    const wg = ctx.createLinearGradient(0, 0, 0, 600); wg.addColorStop(0, '#111830'); wg.addColorStop(1, SP.hullL);
    ctx.fillStyle = wg; ctx.fillRect(0, 0, W, 600);
    for (let x = 0; x < W; x += 240){ line(x, 90, x, 594, SP.seam, 4); line(x + 3, 90, x + 3, 594, 'rgba(255,255,255,.05)', 2); rivets(x + 16, 110, x + 16, 570, 9); }
    line(0, 455, W, 455, SP.seam, 4); line(0, 458, W, 458, 'rgba(78,240,255,.25)', 2);
    poly([0, 0, W, 0, W, 80, 0, 94], '#0a0f20'); line(0, 92, W, 79, SP.cyanD, 4);
    for (let x = 60; x < W; x += 320){ ctx.save(); ctx.shadowColor = SP.cyan; ctx.shadowBlur = 24; poly([x, 34, x + 200, 32, x + 200, 46, x, 48], SP.cyan); ctx.restore(); }
    poly([0, 600, W, 590, W, H, 0, H], SP.grate);
    for (let i = -8; i <= 14; i++) line(960 + i * 95, 596, 960 + i * 210, H, 'rgba(78,240,255,.13)', 3);
    for (const y of [700, 830, 980]) line(0, y, W, y - 6, 'rgba(78,240,255,.10)', 3);
    hazard(0, 592, W, 18);
    // Hauptbildschirm mit Tagesplan
    poly([628, 100, 1302, 94, 1308, 434, 624, 442], SP.steelD, SP.seam, 6);
    poly([650, 118, 1280, 112, 1284, 414, 646, 420], '#020a12', SP.cyanD, 3);
    for (let y = 122; y < 414; y += 6) line(652, y, 1280, y - 6, 'rgba(78,240,255,.05)', 2);
    const mono = '"Share Tech Mono","Courier New",monospace';
    neonTxt(c, 'Tabletklasse 9.1', 686, 176, 40, SP.cyan);
    neonTxt(c, '> 1. Classroom, Docs, Sheets, Präsentationen', 694, 230, 23, SP.lime, mono);
    neonTxt(c, '> 2. GoodNotes: Werkzeuge 1 bis 24', 694, 272, 23, SP.lime, mono);
    neonTxt(c, '> 3. Zertifikat + Abgabe im Classroom', 694, 314, 23, SP.lime, mono);
    neonTxt(c, 'JJJJ-MM-TT-Inhalt-Name', 694, 372, 28, SP.orange, mono);
    neonTxt(c, '█', 1062, 372, 28, SP.orange, mono);
    ctx.save(); ctx.translate(1206, 392); ctx.rotate(.08); poly([-70, -40, 70, -42, 72, 40, -68, 42], '#fff59a', '#333', 2);
    ctx.fillStyle = '#222'; ctx.font = 'bold 15px "Trebuchet MS",sans-serif'; ctx.textAlign = 'center';
    ctx.fillText('Akku unter 20 %?', 2, -12); ctx.fillText('Dann kein Warp.', 2, 8); ctx.fillText('(die Leitung)', 2, 28); ctx.restore();
    // Regelplakat als Leuchttafel (gleiche Klickfläche POSTER)
    const p = POSTER;
    poly([p.x - 6, p.y - 6, p.x + p.w + 6, p.y - 10, p.x + p.w + 10, p.y + p.h + 6, p.x - 4, p.y + p.h + 10], SP.steelD, SP.seam, 5);
    poly([p.x + 8, p.y + 8, p.x + p.w - 8, p.y + 4, p.x + p.w - 4, p.y + p.h - 8, p.x + 10, p.y + p.h - 4], '#0b0820', SP.mag, 3);
    neonTxt(c, 'Unsere Tablets,', p.x + p.w / 2, p.y + 52, 24, SP.mag, null, 'center'); neonTxt(c, 'unsere Regeln', p.x + p.w / 2, p.y + 84, 24, SP.mag, null, 'center');
    line(p.x + 30, p.y + 100, p.x + p.w - 30, p.y + 99, SP.gold, 3);
    for (let r = 0; r < 2; r++) for (let q = 0; q < 2; q++) poly([p.x + 24 + q * 132, p.y + 116 + r * 52, p.x + 148 + q * 132, p.y + 116 + r * 52, p.x + 148 + q * 132, p.y + 160 + r * 52, p.x + 24 + q * 132, p.y + 160 + r * 52], 'rgba(78,240,255,.08)', SP.cyan, 2);
    for (let r = 0; r < 5; r++) for (let q = 0; q < 2; q++){ const x = p.x + 24 + q * 132, y = p.y + 230 + r * 30; line(x, y, x, y + 22, SP.gold, 5); line(x + 12, y + 7, x + 110, y + 7, 'rgba(230,236,255,.45)', 3); line(x + 12, y + 16, x + 80, y + 16, 'rgba(230,236,255,.3)', 3); }
    // Bullauge statt Fenster
    porthole(1612, 268, 140, [1560, 300, 52, '#7fd0ff', '#1b3f8f']);
    ctx.save(); ctx.translate(1612, 446); poly([-122, -14, 122, -16, 124, 14, -120, 16], SP.seam, SP.steelD, 2);
    ctx.fillStyle = SP.steel; ctx.font = 'bold 13px "Orbitron","Trebuchet MS",sans-serif'; ctx.textAlign = 'center'; ctx.fillText('BITTE NICHT WINKEN', 0, 5); ctx.restore();
    // Sternzeit
    poly([1160, 40, 1290, 38, 1290, 82, 1160, 84], '#020a12', SP.mag, 3);
    neonTxt(c, isoToday().slice(0, 7).replace('-', '.'), 1225, 70, 22, SP.mag, mono, 'center');
    // Luftschleuse links
    airlock(18, 112, 196, 626, ['Tablets nicht', 'ins All werfen'], SP.cyan, 'AUSGANG', '9.1');
    // Ladestation rechts
    poly([1836, 292, W, 288, W, 596, 1830, 600], SP.hullXL, SP.seam, 5);
    for (let i = 0; i < 3; i++){ const y = 340 + i * 80; poly([1846, y - 30, W - 6, y - 32, W - 6, y + 30, 1846, y + 32], '#0b1020', SP.seam, 3);
      ctx.save(); ctx.shadowColor = SP.lime; ctx.shadowBlur = 10; line(1856, y + 18, 1856 + 18 + i * 12, y + 18, SP.lime, 6); ctx.restore(); }
    ctx.save(); ctx.font = 'bold 12px "Orbitron","Trebuchet MS",sans-serif'; ctx.fillStyle = SP.lime; ctx.textAlign = 'center'; ctx.fillText('LADEN', 1876, 284); ctx.restore();
  });
};
drawDesk = function(d, time){
  const s = d.sc, x = d.x, b = d.base, w = d.w, topY = d.top, pult = d.id === 'pult';
  const done = d.label ? (d.st === 0 ? gMainDone() && (!G.cert || G.done['g-abgabe']) : d.st === 1 ? gnDone() : G.cert) : false;
  const col = done ? SP.lime : SP.cyan;
  ctx.save(); ctx.globalAlpha = .55 + .2 * Math.sin(time * 2.4 + x); ell(x, b + 2, w * .42, 16 * s, 'rgba(78,240,255,.35)'); ctx.restore();
  // Schwebestuhl
  if (!pult){ poly([x - 60 * s, topY - 76 * s, x + 60 * s, topY - 76 * s, x + 56 * s, topY - 10, x - 56 * s, topY - 10], '#3a1f5c', SP.seam, 4); line(x - 50 * s, topY - 70 * s, x + 50 * s, topY - 70 * s, SP.mag, 3); }
  // Korpus
  poly([x - w / 2 + 24, topY + 14, x + w / 2 - 24, topY + 14, x + w / 2 - 50, b - 22, x - w / 2 + 50, b - 22], SP.hullL, SP.seam, 5);
  ctx.save(); ctx.shadowColor = col; ctx.shadowBlur = 16; line(x - w / 2 + 60, b - 30, x + w / 2 - 60, b - 30, col, 5); ctx.restore();
  for (const k of [-1, 1]) circ(x + k * (w / 2 - 70), topY + 70 * s, 6, k < 0 ? SP.red : SP.lime, SP.seam, 2);
  // Platte (perspektivisch)
  poly([x - w / 2 + 26 * s, topY - 76 * s, x + w / 2 - 26 * s, topY - 76 * s, x + w / 2 + 4, topY, x - w / 2 - 4, topY], pult ? '#aeb9cf' : SP.steel, SP.seam, 5);
  poly([x - w / 2 - 4, topY, x + w / 2 + 4, topY, x + w / 2 + 4, topY + 16, x - w / 2 - 4, topY + 16], SP.steelD, SP.seam, 4);
  line(x - w / 2, topY + 14, x + w / 2, topY + 14, SP.cyanD, 4);
  if (d.st === 0) flatTablet(d, 'google', time);
  if (d.st === 1) flatTablet(d, 'goodnotes', time);
  if (pult){
    const ready = allDone();
    poly([x - 70, topY - 50, x + 10, topY - 54, x + 20, topY - 10, x - 66, topY - 6], '#fffdf6', SP.seam, 3);
    line(x - 54, topY - 36, x + 2, topY - 38, SP.gold, 3); line(x - 52, topY - 24, x - 4, topY - 26, 'rgba(43,29,46,.35)', 3);
    circ(x + 70, topY - 30, 18, P.rose, SP.seam, 3); line(x + 70, topY - 12, x + 70, topY + 4, P.greenD, 4);
    if (ready) sparkle(x - 28, topY - 70, 26 + Math.sin(time * 4) * 4, SP.lime);
  }
  if (!d.st && !pult){
    const bx = x + w / 2 + 34 * s, by = b;
    poly([bx - 30 * s, by, bx + 30 * s, by, bx + 34 * s, by - 76 * s, bx - 34 * s, by - 80 * s], d.id === 'deko1' ? SP.orange : '#3a1f5c', SP.seam, 4);
    poly([bx - 20 * s, by - 10 * s, bx + 20 * s, by - 10 * s, bx + 20 * s, by - 40 * s, bx - 20 * s, by - 40 * s], 'rgba(255,255,255,.25)', SP.seam, 3);
    ctx.beginPath(); ctx.arc(bx, by - 80 * s, 14 * s, Math.PI, 0); ctx.strokeStyle = SP.seam; ctx.lineWidth = 4; ctx.stroke();
  }
  if (d.label){
    ctx.save(); ctx.translate(x, topY + 56 * s);
    ctx.font = `bold ${Math.round(23 * s)}px "Orbitron","Trebuchet MS",sans-serif`;
    const tw = ctx.measureText(d.label).width + 34 * s;
    poly([-tw / 2, -25 * s, tw / 2, -25 * s, tw / 2 + 9, -3, tw / 2, 19 * s, -tw / 2, 19 * s, -tw / 2 - 9, -3], '#020a12', col, 3);
    ctx.font = `bold ${Math.round(23 * s)}px "Orbitron","Trebuchet MS",sans-serif`; ctx.textAlign = 'center'; ctx.shadowColor = col; ctx.shadowBlur = 10; ctx.fillStyle = col; ctx.fillText(d.label, 0, 6 * s);
    ctx.restore();
    if (done){ sparkle(x + w / 2 - 20, topY - 60 * s, 30 * s, SP.lime); txt('✓', x + w / 2 - 20, topY - 48 * s, 30 * s, SP.seam); }
  }
};
renderTexture = function(){
  const t = tex.getContext('2d'); t.clearRect(0, 0, W, H);
  for (let y = 0; y < H; y += 4){ t.fillStyle = 'rgba(0,0,0,.10)'; t.fillRect(0, y, W, 1); }
  const r = rnd(7); for (let i = 0; i < 2500; i++){ t.fillStyle = r() < .5 ? 'rgba(78,240,255,.04)' : 'rgba(0,0,0,.06)'; t.fillRect(r() * W, r() * H, 2, 2); }
};
