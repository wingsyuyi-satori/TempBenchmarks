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

(declare-sort var1879 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const var1594 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1594 null-String)))
(define-const var3 Int (cast-from-Int-to-Int -1)) ; Statement: $i5 = (int) -1 
; split operation: var2123 = var1594.split("\u005c.", var3) ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\.", $i5) 
(define-const var853 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
(define-const var231 Int (get_split_length var1594 "\u005c." var3)) ; Statement: $i0 = lengthof r1 
 ; Statement: if i3 >= $i0 goto return 1 
(assert (>= var853 var231)) ; Cond: i3 >= $i0 
 ; Statement: return 1 
(check-sat)
; {cast-from-Int-to-Int=([int], int)}
; {var1594=r0, var1879=null_type, var3=$i5, var2123=r1, var853=i3, var231=$i0}
; {r0=var1594, null_type=var1879, $i5=var3, r1=var2123, i3=var853, $i0=var231}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$i5 = (int) -1;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\.", $i5);	i3 = 0;	$i0 = lengthof r1;	if i3 >= $i0 goto return 1;	return 1
;block_num 3
(get-model)
