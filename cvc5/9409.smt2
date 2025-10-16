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

(declare-sort var474 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-String String)
(declare-const var2902 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2902 null-String)))
; split operation: var3880 = var2902.split("\u005c(") ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\(") 
(define-const var151 Int (get_split_length var2902 "\u005c(" -1)) ; Statement: $i0 = lengthof $r1 
 ; Statement: if $i0 <= 0 goto return "" 
(assert (<= var151 0)) ; Cond: $i0 <= 0 
 ; Statement: return "" 
(check-sat)
; {}
; {var2902=r0, var474=null_type, var3880=$r1, var151=$i0}
; {r0=var2902, null_type=var474, $r1=var3880, $i0=var151}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\(");	$i0 = lengthof $r1;	if $i0 <= 0 goto return "";	return ""
;block_num 2
(get-model)
