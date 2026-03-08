/*2 Пятнашки

Написать программу для решения головоломки «Пятнашки»: в квадратной коробочке раз-
мера N ×N лежат N ×N −1 пронумерованных квадратных фишек, так что место для одной из них

всегда остаётся пустым и на него можно переместить любую из соседних фишек. Требуется

упорядочить фишки по номерам, начав из произвольного исходного положения, допускающе-
го решение (т.к. возможны случаи, когда решений нет). Можно ограничиться случаем 3 × 3.
*/

/*
Допустим нам задана некоторая комбинация nxn;
Введем координаты чисел (x,y)
[1,2,3
4,5,6
7,8,0]
перевеедм числа в массив по правилу i=n*y+x
[1,2,3,4,5,6,7,8,0]
Какие перемещения разрешены?
1)Если i>=n, (i-n)
2)Если i<n*(n-1), то (i+n)
3)Если i mod n !=0, то (i-1)
4)Если i mod n != (n-1), то (i+1)
*/

/*Свяжем старый и новый индекс нулевой клетки*/
transup(N,I,INew) :- INew is I+N, I<N*(N-1).
transdown(N,I,INew) :- INew is I-N, I>=N.
transleft(N,I,INew) :- INew is I-1, I mod N =\= 0.
transright(N,I,INew) :- INew is I+1, I mod N =\= (N-1).

/*Теперь хотим поменять два элемента в списке, зная их индексы*/

/*Воспользуемся предкатом nth0
Он принимает 4 аргумента: nth0 (Index, List, Element, RestList).
Этот предикат означает, что Element находится на позиции Index в списке List,
а если этот элемент из списка убрать, то останется список RestList.
nth0(2, [a, b, c, d], c, [a, b, d]) -> True.
*/

/*Заменим элемент в списке
replace(I, List, NewElement, NewList)*/
replace(I, List, NewElement, NewList) :- nth0(I, List, _OldElement, RestList), nth0(I, NewList, NewElement, RestList).

/*Поменяем два элемента в списке
move_{up,down,left,right}(N, Board, NewBoard)*/
/*
1.Найдем индекс нуля
2.Выберем правило перемещения и найдем индекс элмента
3.Найдем этот элемент
4.Воспользуемся реплейс, чтобы создать список в которм на месте нуля сидит найденный элемент
5. Добавим нуль на место, где сидел элемент
*/
moveup(N, Board, NewBoard) :- nth0(I, Board, 0, _), transup(N,I,INew), nth0(INew, Board, NewElement, _), replace(I,Board, NewElement, Nozero),
replace(INew, Nozero, 0, NewBoard).
movedown(N, Board, NewBoard) :- nth0(I, Board, 0, _), transdown(N,I,INew), nth0(INew, Board, NewElement, _), replace(I,Board, NewElement, Nozero),
replace(INew, Nozero, 0, NewBoard).
moveleft(N, Board, NewBoard) :- nth0(I, Board, 0, _), transleft(N,I,INew), nth0(INew, Board, NewElement, _), replace(I,Board, NewElement, Nozero),
replace(INew, Nozero, 0, NewBoard).
moveright(N, Board, NewBoard) :- nth0(I, Board, 0, _), transright(N,I,INew), nth0(INew, Board, NewElement, _), replace(I,Board, NewElement, Nozero),
replace(INew, Nozero, 0, NewBoard).
/*Сделаем глобальный предикат движения*/
move(N, Board, NewBoard) :- moveup(N, Board, NewBoard).
move(N, Board, NewBoard) :- movedown(N, Board, NewBoard).
move(N, Board, NewBoard) :- moveleft(N, Board, NewBoard).
move(N, Board, NewBoard) :- moveright(N, Board, NewBoard).

/*
Не все начальные доски разрешими
математическое условие разрешимости (см. википедию)
Для нечетных N : Мы считаем инверсии (без учета нуля) и проверяем, что их количество четное.
Для четных N :  Мы считаем инверсии, находим ряд пустой клетки E и проверяем, что сумма Инверсии + E является четной.
*/
/*Подсчитаем количество инверсий
countinvers(Board)
*/
/* Для этого будем определять сколько элементов меньше головы
count_smaller(H, Tail, Count)
*/
count_smaller(_ , [], 0).
count_smaller(H, [T1 | T2], Count) :- H>T1, count_smaller(H,T2,C1), Count is C1+1.
count_smaller(H, [T1 | T2], Count) :- H=<T1, count_smaller(H,T2,Count).


countinvers([],0).
countinvers([H | Tail], Inv) :- count_smaller(H, Tail, Count), countinvers(Tail, InvT), Inv is Count+InvT.

/*Разрешимость в случае нечетного числа инверсий
solvableodd(N, Board)*/
solvableodd(N, Board) :- N mod 2 =:= 1, delete(Board, 0, BoardNoZero), countinvers(BoardNoZero,Inv), Inv mod 2 =:= 0.

/*Разрешимость в случае четного числа инверсий
solvableevv(N, Board)*/
solvableev(N, Board) :- N mod 2 =:= 0, nth0(I, Board, 0, _), E is I//N+1, delete(Board, 0, BoardNoZero), countinvers(BoardNoZero,Inv), (E+Inv) mod 2 =:= 0.

/*Объединим предикат в один*/
solvable(N,Board) :- solvableodd(N, Board).
solvable(N,Board) :- solvableev(N, Board).

/*Мы хотим получить ответ перебором. Но наши операции могут зациклить перебор. Поэтому будем следить за списками, которые уже получали
Пусть Visited - список всех посещенных состояний.
В него будем добавлять элементы на каждом шаге.
Дальше при помощи member будем смотреть является ли NewBoard его элементом
\+member(NewBoard,Visited)
*/

 /*Ищем те ходы, которые приведут нас к желаемому результату
solve_path(CurrentBoard, TargetBoard, Visited, Path)
*/

solve_path(_N, TargetBoard, TargetBoard, _, [TargetBoard]).
solve_path(N,CurrentBoard, TargetBoard, Visited, [CurrentBoard | RestOfPath]) :- move(N, CurrentBoard, NextBoard), \+member(NextBoard,Visited), 
	solve_path(N, NextBoard, TargetBoard, [NextBoard | Visited], RestOfPath).
/*Запуск алгоритма
start(N,TargetBoard, Board, Path)
length(Path, _) - чтобы не уйти в глубину
*/	
start(N,TargetBoard, Board, Path):- solvable(N,Board), solve_path(N, Board, TargetBoard, [Board], Path), length(Path, _).













