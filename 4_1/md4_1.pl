% p�rbauda vai saraksti X un Y sakr�t, p�rbaude tiek veikta �emot sakr�to�os elementu nost l�dz abi saraksti ir tuk�i
uequal([], []).
uequal([Xh|Xt], Y) :- member(Xh, Y), select(Xh, Y, Z), uequal(Xt, Z).

% l�dz�gi k� uequal predik�ta gad�jum� tikai, sakr�to�ais elements tiek iz�emts 3 reizes �r�
threetimes([], []).
threetimes([Ah|At], F) :- member(Ah, F), select(Ah, F, T), select(Ah, T, S), select(Ah, S, Z), threetimes(At, Z).


p([], [], [], [], [], []).
p(A, B, C, D, E, F) :- intersection(A, B, Iab), uequal(D, Iab), 		% 1, 5 un 6 pras�ba, A un B ���lums ir vien�ds ar D
					   intersection(A, C, Iac), uequal(E, Iac), 		% 2, 5 un 6 pras�ba, A un C ���lums ir vien�ds ar E
					   intersection(A, F, Iaf), 						% A un F ���lums
					   intersection(Iaf, D, Iadf), uequal([], Iadf), 	% 3 pras�ba, A un F �k�luma ���lums ar D ir tuk�a kopa
					   intersection(Iaf, E, Iaef), uequal([], Iaef), 	% 3 pras�ba, A un F ���luma ���lums ar E ir tuk�a kopa
					   threetimes(Iaf, F).								% 4 un 5 pras�ba