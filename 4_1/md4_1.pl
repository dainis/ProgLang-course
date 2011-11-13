% pârbauda vai saraksti X un Y sakrît, pârbaude tiek veikta òemot sakrîtoðos elementu nost lîdz abi saraksti ir tukði
uequal([], []).
uequal([Xh|Xt], Y) :- member(Xh, Y), select(Xh, Y, Z), uequal(Xt, Z).

% lîdzîgi kâ uequal predikâta gadîjumâ tikai, sakrîtoðais elements tiek izòemts 3 reizes ârâ
threetimes([], []).
threetimes([Ah|At], F) :- member(Ah, F), select(Ah, F, T), select(Ah, T, S), select(Ah, S, Z), threetimes(At, Z).


p([], [], [], [], [], []).
p(A, B, C, D, E, F) :- intersection(A, B, Iab), uequal(D, Iab), 		% 1, 5 un 6 prasîba, A un B ðíçlums ir vienâds ar D
					   intersection(A, C, Iac), uequal(E, Iac), 		% 2, 5 un 6 prasîba, A un C ðíçlums ir vienâds ar E
					   intersection(A, F, Iaf), 						% A un F ðíçlums
					   intersection(Iaf, D, Iadf), uequal([], Iadf), 	% 3 prasîba, A un F ðkçluma ðíçlums ar D ir tukða kopa
					   intersection(Iaf, E, Iaef), uequal([], Iaef), 	% 3 prasîba, A un F ðíçluma ðíçlums ar E ir tukða kopa
					   threetimes(Iaf, F).								% 4 un 5 prasîba