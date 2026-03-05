import janus_swi

janus_swi.consult('4A.pl')

res1 = janus_swi.query_once('checkrev([5,6,7],[1,2,3,4,5,6,7])', {})
print(f"checkrev([5,6,7],[1,2,3,4,5,6,7]) -> {res1['truth']}")

res2 = janus_swi.query_once('checkrev([5,6,7,9],[1,2,3,4,5,6,7])', {})
print(f"checkrev([5,6,7,9],[1,2,3,4,5,6,7]) -> {res2['truth']}")

res3 = janus_swi.query_once('checkrev([1],[1])', {})
print(f"checkrev([1],[1]) -> {res3['truth']}")