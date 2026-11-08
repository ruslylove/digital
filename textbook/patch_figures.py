#!/usr/bin/env python3
"""Copy ../tex/*.tex to figsrc/ applying small, book-wide normalisations so that
symbols look identical in every figure (the originals in ../tex are never modified):
  * all flip-flop symbols use one size (flipflops/scale = FF_SCALE);
  * stray global scale keys that change gate size are removed.
Edit FF_SCALE or add rules in PATCHES to change the look of all figures at once."""
import os,re,sys
FF_SCALE='0.85'
src='../tex'; dst='figsrc'
os.makedirs(dst,exist_ok=True)
for fn in sorted(os.listdir(src)):
    if not fn.endswith('.tex') or fn=='live.main.tex': continue
    t=open(os.path.join(src,fn)).read()
    o=t
    t=re.sub(r'^[ \t]*\\ctikzset\{flipflops/scale=[0-9.]+\}[ \t]*\n','',t,flags=re.M)
    body=re.sub(r'%.*','',t)
    if re.search(r'muxdemux|dipchip',body) and not re.search(r'flipflop',body):
        t=t.replace('\\begin{document}','\\begin{document}\n\\makeatletter\\def\\pgf@circ@font@tiny{\\footnotesize}\\makeatother',1)
    if re.search(r'flipflop',body):
        t=t.replace('\\begin{document}','\\begin{document}\n\\ctikzset{flipflops/scale=%s, multipoles/flipflop/font=\\small}\n\\makeatletter\\def\\pgf@circ@font@tiny{\\footnotesize}\\makeatother'%FF_SCALE,1)
    if fn in ('lect_4_multiplier_4x4.tex','lect_7_serial_transfer.tex','lect_7_serial_adder.tex'):
        t=t.replace('font=\\tiny','font=\\footnotesize')
    t=t.replace('\\ctikzset{logic ports=ieee, scale=0.7}','\\ctikzset{logic ports=ieee}')
    dstf=os.path.join(dst,fn)
    if not os.path.exists(dstf) or open(dstf).read()!=t:
        open(dstf,'w').write(t)
print('patched sources in',dst)
