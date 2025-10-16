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

(declare-sort var1300 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun surfaceForm/46288021 (var1300) String)
(declare-const null-var1300 var1300)
(declare-const var319 var1300) ; Statement: r3 := @parameter0: edu.stanford.nlp.naturalli.Operator 
(assert (not (= var319 null-var1300)))
(declare-const var3702 var1300) ; Statement: r0 := @parameter1: edu.stanford.nlp.naturalli.Operator 
(assert (not (= var3702 null-var1300)))
(define-const var1711 String (surfaceForm/46288021 var3702)) ; Statement: $r1 = r0.<edu.stanford.nlp.naturalli.Operator: java.lang.String surfaceForm> 
; split operation: var2222 = var1711.split(" ") ; Statement: $r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ") 
(define-const var2069 Int (get_split_length var1711 " " -1)) ; Statement: $i1 = lengthof $r2 
(define-const var995 String (surfaceForm/46288021 var319)) ; Statement: $r4 = r3.<edu.stanford.nlp.naturalli.Operator: java.lang.String surfaceForm> 
; split operation: var443 = var995.split(" ") ; Statement: $r5 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ") 
(define-const var3142 Int (get_split_length var995 " " -1)) ; Statement: $i0 = lengthof $r5 
(define-const var3285 Int (- var2069 var3142)) ; Statement: $i2 = $i1 - $i0 
 ; Statement: return $i2 
(check-sat)
; {surfaceForm/46288021=([edu.stanford.nlp.naturalli.Operator], java.lang.String)}
; {var1300=edu.stanford.nlp.naturalli.Operator, var319=r3, var3702=r0, var1711=$r1, var2222=$r2, var2069=$i1, var995=$r4, var443=$r5, var3142=$i0, var3285=$i2}
; {edu.stanford.nlp.naturalli.Operator=var1300, r3=var319, r0=var3702, $r1=var1711, $r2=var2222, $i1=var2069, $r4=var995, $r5=var443, $i0=var3142, $i2=var3285}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r3 := @parameter0: edu.stanford.nlp.naturalli.Operator;	r0 := @parameter1: edu.stanford.nlp.naturalli.Operator;	$r1 = r0.<edu.stanford.nlp.naturalli.Operator: java.lang.String surfaceForm>;	$r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	$i1 = lengthof $r2;	$r4 = r3.<edu.stanford.nlp.naturalli.Operator: java.lang.String surfaceForm>;	$r5 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	$i0 = lengthof $r5;	$i2 = $i1 - $i0;	return $i2
;block_num 1
(get-model)
