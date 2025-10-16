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

(declare-sort var40 0)
(declare-sort var322 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-var40 var40)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var1356 var40) ; Statement: r10 := @parameter0: edu.stanford.nlp.util.CollectionValuedMap 
(assert (not (= var1356 null-var40)))
(declare-const var1202 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var1202 null-String)))
(declare-const var1437 Bool) ; Statement: z1 := @parameter2: boolean 
(assert (not (= var1437 null-Bool)))
 ; Statement: if r0 != null goto $r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>() 
(assert (not (= var1202 null-String))) ; Cond: r0 != null 
(assert true)
(define-const var2212 String (trim/-847153721 var1202)) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>() 
; split operation: var1214 = var2212.split("\u005cs*,\u005cs*") ; Statement: $r33 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s*,\\s*") 
(assert true) ; Non Conditional
(declare-const var1214 (Array Int String))
(define-const var2299 (Array Int String) var1214) ; Statement: r2 = $r33 
(define-const var1252 Int (get_split_length var2212 "\u005cs*,\u005cs*" -1)) ; Statement: $i1 = lengthof $r33 
(define-const var661 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= $i1 goto return 
(assert (>= var661 var1252)) ; Cond: i2 >= $i1 
 ; Statement: return 
(check-sat)
; {trim/-847153721=([java.lang.String], java.lang.String)}
; {var40=edu.stanford.nlp.util.CollectionValuedMap, var1356=r10, var1202=r0, var322=null_type, var1437=z1, var2212=$r1, var1214=$r33, var2299=r2, var1252=$i1, var661=i2}
; {edu.stanford.nlp.util.CollectionValuedMap=var40, r10=var1356, r0=var1202, null_type=var322, z1=var1437, $r1=var2212, $r33=var1214, r2=var2299, $i1=var1252, i2=var661}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r10 := @parameter0: edu.stanford.nlp.util.CollectionValuedMap;	r0 := @parameter1: java.lang.String;	z1 := @parameter2: boolean;	if r0 != null goto $r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>();	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>();	$r33 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s*,\\s*");	r2 = $r33;	$i1 = lengthof $r33;	i2 = 0;	if i2 >= $i1 goto return;	return
;block_num 5
(get-model)
