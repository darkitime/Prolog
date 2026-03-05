/*Задача 4А Даны два списка. Проверить, является ли первый из них окончанием второго.
Пример: список [1,2,3] является окончанием списков
checkrev(List1,List2)
*/
checkrev(List, List).
checkrev(List1, [_ | Tail2]) :- 
    checkrev(List1, Tail2).
/*Тесты
checkrev([5,6,7],[1,2,3,4,5,6,7]) -> True
checkrev([5,6,7,9],[1,2,3,4,5,6,7]) -> False
checkrev([1],[1]) -> True
*/