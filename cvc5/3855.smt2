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

(declare-sort var3611 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-String String)
(declare-const var3553 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3553 null-String)))
(define-const var900 Int (cast-from-Int-to-Int -1)) ; Statement: $i3 = (int) -1 
; split operation: var1274 = var3553.split("\u005c.", var900) ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\.", $i3) 
(define-const var1097 Int (get_split_length var3553 "\u005c." var900)) ; Statement: i0 = lengthof r1 
(define-const var1567 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto return 1 
(assert (>= var1567 var1097)) ; Cond: i1 >= i0 
 ; Statement: return 1 
(check-sat)
; {cast-from-Int-to-Int=([int], int)}
; {var3553=r0, var3611=null_type, var900=$i3, var1274=r1, var1097=i0, var1567=i1}
; {r0=var3553, null_type=var3611, $i3=var900, r1=var1274, i0=var1097, i1=var1567}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$i3 = (int) -1;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\.", $i3);	i0 = lengthof r1;	i1 = 0;	if i1 >= i0 goto return 1;	return 1
;block_num 3
(get-model)
