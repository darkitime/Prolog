import janus_swi

janus_swi.consult('5A.pl')

results = list(janus_swi.query('cr([[a,b], [1,2,3], [c,d,[e,f]], [], [4]], Answer)', {}))

for q in results:
    print(q['Answer'])