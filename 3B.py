import janus_swi

janus_swi.consult('3B.pl')

res1 = janus_swi.query_once('odd1([1,2,3,4,5,6,7])', {})
print(f"odd1([1,2,3,4,5,6,7]) -> {res1['truth']}")

res2 = janus_swi.query_once('odd1([1,2,3,4,5,6,7,8])', {})
print(f"odd1([1,2,3,4,5,6,7,8]) -> {res2['truth']}")