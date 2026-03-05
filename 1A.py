import janus_swi


janus_swi.consult('lecture1_examples.pl')

for q in janus_swi.query('aunt_niece(X,Y)', {}):
    print(q)
# запрос, завершающийся неудачей
print('No results:', janus_swi.query_once('aunt_niece(X,Y)', {}))


