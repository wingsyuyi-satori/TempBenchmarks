(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3522 0)
(declare-sort var1673 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun splitRegex/-1299977600 (var3522) String)
(declare-fun arr-String-init () (Array Int String))
(declare-const null-var3522 var3522)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var3495 var3522) ; Statement: r1 := @this: edu.stanford.nlp.process.DocumentPreprocessor$PlainTextIterator$1 
(assert (not (= var3495 null-var3522)))
(declare-const var3713 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3713 null-String)))
(assert true)
(define-const var2630 String (trim/-847153721 var3713)) ; Statement: $r3 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>() 
(define-const var1867 String (splitRegex/-1299977600 var3495)) ; Statement: $r2 = r1.<edu.stanford.nlp.process.DocumentPreprocessor$PlainTextIterator$1: java.lang.String splitRegex> 
; split operation: var2653 = var2630.split(var1867) ; Statement: r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>($r2) 
(define-const var3995 Int (get_split_length var2630 var1867 -1)) ; Statement: $i0 = lengthof r4 
 ; Statement: if $i0 != 2 goto $r5 = newarray (java.lang.String)[1] 
(assert (not (= var3995 2))) ; Cond: $i0 != 2 
(define-const var283 (Array Int String) arr-String-init) ; Statement: $r5 = newarray (java.lang.String)[1] 
(declare-const var283!1 (Array Int String))
(assert (not (= var283!1 null-__Array__Int__String__)))
(assert (= (select var283!1 0) var3713)) ; Statement: $r5[0] = r0 
 ; Statement: return $r5 
(check-sat)
; {trim/-847153721=([java.lang.String], java.lang.String), splitRegex/-1299977600=([edu.stanford.nlp.process.DocumentPreprocessor$PlainTextIterator$1], java.lang.String), arr-String-init=([], java.lang.String[])}
; {var3522=edu.stanford.nlp.process.DocumentPreprocessor$PlainTextIterator$1, var3495=r1, var3713=r0, var1673=null_type, var2630=$r3, var1867=$r2, var2653=r4, var3995=$i0, var283=$r5}
; {edu.stanford.nlp.process.DocumentPreprocessor$PlainTextIterator$1=var3522, r1=var3495, r0=var3713, null_type=var1673, $r3=var2630, $r2=var1867, r4=var2653, $i0=var3995, $r5=var283}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @this: edu.stanford.nlp.process.DocumentPreprocessor$PlainTextIterator$1;	r0 := @parameter0: java.lang.String;	$r3 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>();	$r2 = r1.<edu.stanford.nlp.process.DocumentPreprocessor$PlainTextIterator$1: java.lang.String splitRegex>;	r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>($r2);	$i0 = lengthof r4;	if $i0 != 2 goto $r5 = newarray (java.lang.String)[1];	$r5 = newarray (java.lang.String)[1];	$r5[0] = r0;	return $r5
;block_num 2
(get-model)
