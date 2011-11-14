% sal�dzin��anas predik�ti, tiek izmantoti, jo termini ir salikti no 3 da��d�m v�rt�b�m
cmp_1((_, X, _), (_, Y, _)) :- X =< Y, !.
cmp_2((_, X, _), (_, Y, _)) :- X > Y, !.

% t� k� lapu v�rt�bas tiek padotas k� sadal�tas v�rt�bas, tad, lai t�s sak�rtotu var izmantot merge sort algoritma merge da�u
merge([Xh|Xt], [Yh| Yt], [Xh|Z]) :- cmp_1(Xh, Yh), !,merge(Xt,[Yh|Yt], Z).
merge([Xh|Xt], [Yh| Yt], [Yh|Z]) :- cmp_2(Xh, Yh), !,merge([Xh|Xt], Yt, Z).
merge(X, [], Z) 	:- Z = X.
merge([], Y, Z) 	:- Z = Y.

% atrod minim�lo v�rt�bu sarakst�, tuk�am sarakstam t� ir 0
min_v([], X) 		:- X is 0.
min_v(A, X) 		:- min_list(A, X).

% atrod maksim�lo v�rt�bu sarakst�, tuk�am sarakstam t� ir 0
max_v([], X) 		:- X is 0.
max_v(A, X) 		:- max_list(A, X).

% koka apstaig��anas funkcijas, ja virsotne ir lapa vai ar� ar vienu b�rnu tad rezult�tam non�kot taj�, tas ir jau sak�rtots
aa(n0(A), X) 		:- min_v(A, Min), max_v(A, Max), length(A, Len), X = [(Len, Min, Max)]. % atrod min�lo, maksim�lo v�rt�bu un saraksta garumumu
aa(n1(T1), X) 		:- aa(T1, Y), append(Y, [], X).
aa(n2(T1, T2), X) 	:- aa(T1, Y), aa(T2, Z), merge(Y, Z, X). % t� k� �aj� gad�jum� ir divi rezult�ti tad tie ir j�savieno kop�, lai rezult�ts b�tu sak�rtots

% veic katra saraksta elementa k�pin��anu kvadr�t�, darbs notiek rekurs�vi
double_list([], X)	:- X = [].
double_list([Xh | Xt], X)	:- Y is Xh * Xh, double_list(Xt, Z), append([Y], Z, X).

% veic koka apstaig��anu un rekonstru��anu
bb(n0(A), X)		:- double_list(A, Y), X = n0(Y).
bb(n1(T1), X) 		:- bb(T1, Y), X = n1(Y).
bb(n2(T1, T2), X) 	:- bb(T1, Y), bb(T2, Z), X = n2(Y, Z).
