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

(declare-sort var345 0)
(declare-sort var311 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun splitRegex/-1299977600 (var345) String)
(declare-const null-var345 var345)
(declare-const null-String String)
(declare-const var595 var345) ; Statement: r1 := @this: edu.stanford.nlp.process.DocumentPreprocessor$PlainTextIterator$1 
(assert (not (= var595 null-var345)))
(declare-const var1928 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1928 null-String)))
(assert true)
(define-const var2328 String (trim/-847153721 var1928)) ; Statement: $r3 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>() 
(define-const var756 String (splitRegex/-1299977600 var595)) ; Statement: $r2 = r1.<edu.stanford.nlp.process.DocumentPreprocessor$PlainTextIterator$1: java.lang.String splitRegex> 
; split operation: var3346 = var2328.split(var756) ; Statement: r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>($r2) 
(define-const var3080 Int (get_split_length var2328 var756 -1)) ; Statement: $i0 = lengthof r4 
 ; Statement: if $i0 != 2 goto $r5 = newarray (java.lang.String)[1] 
(assert (not (not (= var3080 2)))) ; Negate: Cond: $i0 != 2  
 ; Statement: return r4 
(check-sat)
; {trim/-847153721=([java.lang.String], java.lang.String), splitRegex/-1299977600=([edu.stanford.nlp.process.DocumentPreprocessor$PlainTextIterator$1], java.lang.String)}
; {var345=edu.stanford.nlp.process.DocumentPreprocessor$PlainTextIterator$1, var595=r1, var1928=r0, var311=null_type, var2328=$r3, var756=$r2, var3346=r4, var3080=$i0}
; {edu.stanford.nlp.process.DocumentPreprocessor$PlainTextIterator$1=var345, r1=var595, r0=var1928, null_type=var311, $r3=var2328, $r2=var756, r4=var3346, $i0=var3080}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @this: edu.stanford.nlp.process.DocumentPreprocessor$PlainTextIterator$1;	r0 := @parameter0: java.lang.String;	$r3 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>();	$r2 = r1.<edu.stanford.nlp.process.DocumentPreprocessor$PlainTextIterator$1: java.lang.String splitRegex>;	r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>($r2);	$i0 = lengthof r4;	if $i0 != 2 goto $r5 = newarray (java.lang.String)[1];	return r4
;block_num 2
(get-model)
