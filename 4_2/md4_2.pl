% salîdzinâðanas predikâti
cmp_1((_, X, _), (_, Y, _)) :- X =< Y, !.
cmp_2((_, X, _), (_, Y, _)) :- X > Y, !.

% tâ kâ lapu vçrtîbas tiek padotas kâ sadalîtas vçrtîbas, tad, lai tâs sakârtotu var izmantot merge sort algoritma merge daïu
merge([Xh|Xt], [Yh| Yt], [Xh|Z]) :- cmp_1(Xh, Yh), !,merge(Xt,[Yh|Yt], Z).
merge([Xh|Xt], [Yh| Yt], [Yh|Z]) :- cmp_2(Xh, Yh), !,merge([Xh|Xt], Yt, Z).
merge(X, [], Z) 	:- Z = X.
merge([], Y, Z) 	:- Z = Y.

% atrod minimâlo vçrtîbu sarakstâ, tukðam sarakstam tâ ir 0
min_v([], X) 		:- X is 0.
min_v(A, X) 		:- min_list(A, X).

% atrod maksimâlo vçrtîbu sarakstâ, tukðam sarakstam tâ ir 0
max_v([], X) 		:- X is 0.
max_v(A, X) 		:- max_list(A, X).

% koka apstaigâðanas funkcijas
aa(n0(A), X) 		:- min_v(A, Min), max_v(A, Max), length(A, Len), append([(Len, Min, Max)], [], X).
aa(n1(T1), X) 		:- aa(T1, Y), append(Y, [], X).
aa(n2(T1, T2), X) 	:- aa(T1, Y), aa(T2, Z), merge(Y, Z, X).

% veic katra saraksta elementa kâpinâðanu kvadrâtâ
double_list([], X)	:- X = [].
double_list([Xh | Xt], X)	:- Y is Xh * Xh, double_list(Xt, Z), append([Y], Z, X).

bb(n0(A), X)		:- double_list(A, Y), X = n0(Y).
bb(n1(T1), X) 		:- bb(T1, Y), X = n1(Y).
bb(n2(T1, T2), X) 	:- bb(T1, Y), bb(T2, Z), X = n2(Y, Z).
