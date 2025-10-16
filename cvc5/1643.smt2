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

(declare-sort var1146 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-String String)
(declare-const var1689 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1689 null-String)))
(define-const var1094 Int 0) ; Statement: i5 = 0 
; split operation: var2912 = var1689.split("\u005c.") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.") 
(define-const var3719 Int (get_split_length var1689 "\u005c." -1)) ; Statement: i0 = lengthof r1 
(define-const var1830 Int 0) ; Statement: i6 = 0 
(assert true) ; Non Conditional
 ; Statement: if i6 >= i0 goto return i5 
(assert (>= var1830 var3719)) ; Cond: i6 >= i0 
 ; Statement: return i5 
(check-sat)
; {}
; {var1689=r0, var1146=null_type, var1094=i5, var2912=r1, var3719=i0, var1830=i6}
; {r0=var1689, null_type=var1146, i5=var1094, r1=var2912, i0=var3719, i6=var1830}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	i5 = 0;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.");	i0 = lengthof r1;	i6 = 0;	if i6 >= i0 goto return i5;	return i5
;block_num 3
(get-model)
