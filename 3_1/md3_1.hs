module Md where

find (x, []) = []
find (x, (bh:bt)) = if fst(bh) == x then snd(bh):find(x, bt) else find (x, bt)

translate [] b = []
translate (ah:at) b = (map (\x-> (fst(ah), x)) (find (snd(ah), b)))++translate at b


exists x [] = False;
exists x (h:t) = if x == h then True else exists x t


unique [] = [];
unique (h:t) = if not(exists h t) then h:unique t else unique t


perform_translation a b = unique (translate a b)

test1 = perform_translation [("a", "b"), ("b", "b"), ("c", "b"), ("d", "b"), ("e", "b")] [("b","a"), ("b","b"), ("b", "c"), ("b", "d"), ("b", "e")]
test2 = perform_translation [("a", "a"), ("b", "b"), ("c", "c"), ("d", "d")] [("a", "a"), ("b", "b"), ("c", "c"), ("d", "d"), ("a", "b"), ("b", "c"), ("c", "d"), ("d", "a")]
