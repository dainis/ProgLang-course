--Dainis Tillers
--dt08050
--MD3_1
module Md where

--Atrod tulkojumu
find (x, []) = []
find (x, (bh:bt)) = if fst(bh) == x then snd(bh):find(x, bt) else find (x, bt)

--Veic tulkosanu
translate [] b = []
translate (ah:at) b = (map (\x-> (fst(ah), x)) (find (snd(ah), b)))++translate at b

--Parbauda vai kopa eksiste vel kads tads pats elements
exists x [] = False;
exists x (h:t) = if x == h then True else exists x t

--Atlasa no kopas tikai unikalos elementus
unique [] = [];
unique (h:t) = if not(exists h t) then h:unique t else unique t

--Veic tulkosanu un atgriez elementus bez atkatosanas
ff a b = unique (translate a b)

test1 = ff [("a", "b"), ("b", "b"), ("c", "b"), ("d", "b"), ("e", "b")] [("b","a"), ("b","b"), ("b", "c"), ("b", "d"), ("b", "e")]
test2 = ff [("a", "a"), ("b", "b"), ("c", "c"), ("d", "d")] [("a", "a"), ("b", "b"), ("c", "c"), ("d", "d"), ("a", "b"), ("b", "c"), ("c", "d"), ("d", "a")]
