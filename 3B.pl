/*Задача 3Б Проверить, является ли длина заданного списка нечётной
len(List, Sum), odd1(List), odd2(List)
*/

len([], 0).
len([_ | Tail], Sum) :- len(Tail, Newsum), Sum is Newsum + 1.

odd1(List) :- len(List, Len), Len mod 2 =:= 1.
/*Тест
odd1([1,2,3,4,5,6,7]) -> True
odd1([1,2,3,4,5,6,7,8]) -> False
/*

