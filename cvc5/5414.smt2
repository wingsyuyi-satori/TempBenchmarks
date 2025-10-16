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

(declare-sort var3988 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-String String)
(declare-const var1780 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1780 null-String)))
; split operation: var261 = var1780.split("\u005cs+") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var3481 Int (get_split_length var1780 "\u005cs+" -1)) ; Statement: i0 = lengthof r1 
(define-const var2686 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i0 goto return 1 
(assert (>= var2686 var3481)) ; Cond: i2 >= i0 
 ; Statement: return 1 
(check-sat)
; {}
; {var1780=r0, var3988=null_type, var261=r1, var3481=i0, var2686=i2}
; {r0=var1780, null_type=var3988, r1=var261, i0=var3481, i2=var2686}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	i0 = lengthof r1;	i2 = 0;	if i2 >= i0 goto return 1;	return 1
;block_num 3
(get-model)
