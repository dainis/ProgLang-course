;Dainis Tillers 
;dt08050
;MD3_2

;Atrod vârdu pâra x otrâ vârda tulkojumu sarakstâ l
(define (find x l)
	(cond ((null? l) (list))
	      (else (cond ((equal? (car (cdr x)) (car(car l))) (append (cdr (car l)) (find x (cdr l)) )) ;Rekursîvi atrod visus iespçjamos tulkojumus
					  (else (find x (cdr l)))
				)
			)
	)
)

;Veic divu sarakstu tulkoðanas procesu
(define (translate a b)
	(cond ((null? a) (list))
		  (else (append (map (lambda (x) (list (car (car a)) x)) (find (car a) b)) (translate (cdr a) b)))
	)
)
	
;Pârbauda vai elements a eksistç kopâ b
(define (exists a b)
	(cond ((null? b) #f)
		  (else (cond ((equal? a (car b)) #t)
					  (else (exists a (cdr b)))
				)
		   )
	)
)

;Atlasa tikai unikâlos saraksta elementus
(define (unique a)
	(cond ((null? a) (list))
		  ((equal? (exists (car a) (cdr a)) #f) (append (list (car a)) (unique (cdr a))))
		  (else (unique (cdr a)))
	)
)

;Veic pilnu tulkoðanas procesu
(define (ff a b)
	(unique (translate a b))
)

;testpiemçrs
(define (test1)
	(ff (list (list "a" "b") (list "b" "b") (list "c" "b") (list "d" "b") (list "e" "b")) (list (list "b" "a") (list "b" "b") (list "b" "c") (list "b" "d") (list "b" "e")))
)

;testpiemçrs
(define (test2)
	(ff (list (list "a" "a") (list "b" "b") (list "c" "c") (list "d" "d")) (list (list "a" "a") (list "b" "b") (list "c" "c") (list "d" "d") (list "a" "b") (list "b" "c") (list "c" "d") (list "d" "a")))
)