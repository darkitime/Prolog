
/* A. Добавить элемент в начало списка:
   add(Element, OldList, NewList)*/ 

add(E, Lst, [E | Lst]).

/* тесты:
add(1, [], Answer). -> Answer=[1]
add(1, [2,3], Answer). -> Answer=[1,2,3]
*/

/* B. Добавить элемент в начало списка:
   append(Element, OldList, NewList)*/ 

append(E, [], [E]).
append(E, [H | T], [H | Res]) :- append(E, T, Res).

/* тесты:
append(1, [], Answer). -> Answer=[1]
append(1, [2,3], Answer). -> Answer=[2,3,1]
*/

/* C. Удалить элемент из списка (если этот элемент там есть).
   Удаляется только первое вхождение:
   del(Element, OldList, NewList)
   */
   
del(_, [], []).
del(E, [E | Tail], Tail).
del(E, [H | Tail], [H | Res]) :- del(E, Tail, Res).

/* тесты:
del(1, [], Answer). -> Answer=[]
del(1, [2,3], Answer). -> Answer=[2,3]
del(1, [2,1,3], Answer). -> Answer=[2,3]
*/

/* D. Конкатенация списков (объединение двух списков в один)
  concat(List1, List2, Result)
*/
concat([], List, List).
concat([H | T], List, [H | Rest]) :- concat(T, List, Rest).


/* тесты:
concat([], [], Answer). -> Answer=[]
concat([1,2], [3,4], Answer). -> Answer=[1,2,3,4]
*/


/*E. Сделать новый список, в
котором убран каждый третий элемент исходного.
del3(OldList,NewList)
	*/
del3([], []).
del3([X], [X]).
del3([X, Y], [X, Y]).
del3([X, Y, _ | Tail], [X, Y | NewTail]) :-
    del3(Tail, NewTail).
/* тесты:
del3([], Answer). -> Answer=[]
del3([1, 2, 3, 4, 5, 6, 7], Answer). -> Answer=[1, 2, 4, 5, 7]
*/