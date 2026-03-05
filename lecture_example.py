import janus_swi

# разрешим до загрузки кода менять предикат
# parent с 2 параметрами; без этого можно будет только
# запрашивать факты parent из базы, а добавлять
# новые будет нельзя
janus_swi.query_once('dynamic parent/2', {})

# загружаем файл с текстом программы на Prolog
janus_swi.consult('lecture1_examples.pl')

# запрос первого попавшегося совпадения
print('One result:', janus_swi.query_once('parent(X,alice)', {}))
# ответ: {'truth': True, 'X': 'charlie'}

# запрос всех совпадений:
print('All results:')
for q in janus_swi.query('parent(X,alice)', {}):
    print(q)
# ответы:
# {'truth': True, 'X': 'charlie'}
# {'truth': True, 'X': 'diane'}

# запрос, завершающийся неудачей
print('No results:', janus_swi.query_once('parent(alice, X)', {}))
# ответ: {'truth': False, 'X': None}

# запрос с указанием значений параметров
print('Query with params:', janus_swi.query_once('parent(X, Y)',
                                                 {'Y': 'bob'}))
# так как это query_once, то результат
# {'truth': True, 'X': 'charlie'}

# передача нового факта;
# если бы в начале мы не объявили
# предикат parent dynamic, это не сработало бы.
# assertz добавляет факт после всех имеющихся
# фактов с этим же предикатом,
# asserta --- до них
janus_swi.query_once('assertz(parent(alice,zack))', {})

# проверяем, что данные обновились
print('New result:', janus_swi.query_once('parent(alice, X)', {}))

# проверяем, что прежние данные не испортились
print('New query:')
for q in janus_swi.query('parent(X,zack),parent(Y,X)', {}):
    print(q)

# удаляем факт из базы
janus_swi.query_once('retract(parent(alice,zack))', {})
# проверяем, что прежние данные не испортились
print('Query retracted fact:',
      janus_swi.query_once('parent(X,zack)', {}))