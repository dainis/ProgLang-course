--Dainis Tillers
--dt08050
--MD3_2
module Md3_2 where

--Koka strukturas definîcija, Leaf :: a -> Tree a(lapa), Vertex1 :: Tree a -> Tree a(Virsotne ar vienu bernu), Vertex2 :: Tree a -> Tree a -> Tree a(virsotne ar 2 bçrniem)
data Tree a = Leaf a | Vertex1 (Tree a) | Vertex2 (Tree a) (Tree a) deriving (Show) 

--Atrod saraksta ekstrçmos punktus(maksimumu vai minimumu balsoties uz padoto d vçrtîbu, kas ir ar Ordering tipu, attiecîgi, LT, lai sameklçtu mazâko saraksta elementu, un GT, lai sameklçtu saraksta lielâko), 
--fromIntegral funkcija tiek izmantota jo izpildes laikâ savâdâk notiek kïûda saistîbâ ar Int un Integer datu tipiem
--get_end :: (Ord a, Num a) => a
get_end [] _ = 0 
get_end (lh:[]) _ = fromIntegral(lh) 
get_end (lh:lt) d = if  compare (fromIntegral(lh)) next_smallest == d then fromIntegral(lh) else next_smallest
	where next_smallest = get_end lt d

--Atbilstoði katram iespçjamajam koka virsotnes tipam izpilda atbilstoðu funckiju, ja paðreizçjâ virsotne nav lapa tad tiek iets tâlâk dziïumâ aa :: Integral a => Tree [a] -> [[Int]]
aa (Leaf a) = [[length a, get_end a LT , get_end a GT]]
aa (Vertex1 a) = aa(a)
aa (Vertex2 a b) = aa(a) ++ aa(b)

--Jaunais koks tiek bûvçts rekursîvi uzbûvçjot uzbûvçjot attiecîgâ koka apakðkokus, kad nokïûst lîdz lapai tad tiek pielietota map funkcija visiem lapas saraksta elementiem, mm :: Tree [a] -> (a -> b) -> Tree [b]
mm (Leaf a) f = Leaf (map f a)
mm (Vertex1 a) f = Vertex1 (mm a f)
mm (Vertex2 a b) f = Vertex2 (mm a f) (mm b f)

--Izsauc mm funkciju ar kvadrâtâ kâpinâðanas map funkcijas funkciju, bb :: Num b => Tree [b] -> Tree [b]
bb a = mm a (\x->x*x)

--Testa funkcija, lai pârbaudîtu aa funkcijas darbîbu, test_aa :: [[Int]]
test_aa = aa (Vertex2 (Leaf [1]) (Vertex1 (Vertex2 (Vertex2 (Leaf []) (Leaf [5, 3, 3, 4])) (Leaf [-99999, 4, 3, 99999, 11]))))

--Testa funkcija, lai pârbaudîtu bb funkcijas darbîbu, test_bb :: Tree [Integer]
test_bb = bb (Vertex2 (Leaf [1]) (Vertex1 (Vertex2 (Vertex2 (Leaf []) (Leaf [5, 3, 3, 4])) (Leaf [-99999, 4, 3, 99999, 11]))))