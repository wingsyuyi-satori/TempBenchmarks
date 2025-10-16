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

(declare-sort var2962 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-String String)
(declare-const var1057 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1057 null-String)))
; split operation: var3000 = var1057.split("-") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("-") 
(define-const var896 Int (get_split_length var1057 "-" -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 == 2 goto $r2 = r1[0] 
(assert (not (= var896 2))) ; Negate: Cond: $i0 == 2  
 ; Statement: return null 
(check-sat)
; {}
; {var1057=r0, var2962=null_type, var3000=r1, var896=$i0}
; {r0=var1057, null_type=var2962, r1=var3000, $i0=var896}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("-");	$i0 = lengthof r1;	if $i0 == 2 goto $r2 = r1[0];	return null
;block_num 2
(get-model)
