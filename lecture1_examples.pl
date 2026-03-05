
/* родственные отношения */
parent(charlie, alice).
parent(diane, alice).
parent(charlie, bob).
parent(diane, bob).
parent(gregory, emily).
parent(harry, emily).
parent(gregory, fred).
parent(harry, fred).
parent(ian, diane).
parent(jack, diane).
parent(kevin, diane).
parent(ian, gregory).
parent(jack, gregory).
parent(kevin, gregory).
parent(michael, linda).
parent(norman, linda).
parent(michael, kevin).
parent(norman, kevin).
parent(oscar, fred).


child(X, Y) :- parent(Y,X).
grandchild(X, Y) :- parent(Z,X), parent(Y,Z).

woman(alice).
woman(diane).
woman(emily).
woman(linda).
man(bob).
man(charlie).
man(fred).
man(gregory).
man(harry).
man(ian).
man(jack).
man(kevin).
man(michael).
man(norman).
man(oscar).

grandmother(X,Y) :- grandchild(Y, X), woman(Y).
unkle(X,Y) :- parent(X,P), parent(P,D), parent(Y,D), man(Y), dif(Y,P).
sister(X,Y) :- parent(X,P), parent(Y,P),
               woman(X), woman(Y), dif(X,Y).

ancestor(X, Y) :- parent(X,Y).
ancestor(X, Y) :- parent(X,Z), ancestor(Z, Y).

/* членство в списке */
member(X, [X | _], yes).
member(_, [], no).
member(X, [_ | T], Answer) :- member(X, T, Answer).

aunt_niece(X,Y) :- parent(P,X), parent(D,P), parent(D,Y), woman(Y), woman(X), dif(Y,P).
