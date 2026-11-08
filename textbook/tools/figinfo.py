import re,subprocess,statistics,os,json
S='.'
info={}
for fn in sorted(os.listdir('figures')):
    if not fn.endswith('.pdf'): continue
    name=fn[:-4]
    out=subprocess.run(['pdftotext','-bbox','figures/'+fn,'-'],capture_output=True,text=True).stdout
    pg=re.search(r'<page width="([\d.]+)" height="([\d.]+)"',out)
    W,H=float(pg.group(1)),float(pg.group(2))
    hs=[]
    for m in re.finditer(r'<word xMin="([\d.]+)" yMin="([\d.]+)" xMax="([\d.]+)" yMax="([\d.]+)">([^<]*)</word>',out):
        h=float(m.group(4))-float(m.group(2)); w=m.group(5)
        if len(w)>=2 or w.isalpha(): hs.append(h/0.885)
    if hs:
        hs.sort(); p10=hs[int(len(hs)*0.10)]; med=statistics.median(hs)
    else: p10=med=10
    info[name]=dict(W=W,H=H,p10=p10,med=med)
json.dump(info,open('tools/figinfo.json','w'))
