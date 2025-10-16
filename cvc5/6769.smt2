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

(declare-sort var2541 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-String String)
(declare-const var2057 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2057 null-String)))
; split operation: var1968 = var2057.split("\u005c(") ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\(") 
(define-const var517 Int (get_split_length var2057 "\u005c(" -1)) ; Statement: $i0 = lengthof $r1 
 ; Statement: if $i0 <= 0 goto return "" 
(assert (<= var517 0)) ; Cond: $i0 <= 0 
 ; Statement: return "" 
(check-sat)
; {}
; {var2057=r0, var2541=null_type, var1968=$r1, var517=$i0}
; {r0=var2057, null_type=var2541, $r1=var1968, $i0=var517}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\(");	$i0 = lengthof $r1;	if $i0 <= 0 goto return "";	return ""
;block_num 2
(get-model)
