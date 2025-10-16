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

(declare-sort var1696 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-String String)
(declare-const var674 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var674 null-String)))
(declare-const var2606 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var2606 null-String)))
(declare-const var1173 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var1173 null-String)))
; split operation: var3727 = var674.split(var1173) ; Statement: r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(r1) 
(define-const var3101 Int (get_split_length var674 var1173 -1)) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 != 0 goto $i1 = lengthof r2 
(assert (not (not (= var3101 0)))) ; Negate: Cond: $i0 != 0  
 ; Statement: return "" 
(check-sat)
; {}
; {var674=r0, var1696=null_type, var2606=r3, var1173=r1, var3727=r2, var3101=$i0}
; {r0=var674, null_type=var1696, r3=var2606, r1=var1173, r2=var3727, $i0=var3101}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r3 := @parameter1: java.lang.String;	r1 := @parameter2: java.lang.String;	r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(r1);	$i0 = lengthof r2;	if $i0 != 0 goto $i1 = lengthof r2;	return ""
;block_num 2
(get-model)
