import janus_swi

janus_swi.consult('lecture2_examples.pl')

results = list(janus_swi.query('del3([1,2,3,4,5,6,7], Answer)', {}))

for q in results:
    print(q['Answer'])
