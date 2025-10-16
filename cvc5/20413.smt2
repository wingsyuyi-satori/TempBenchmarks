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

(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toString/-1020053180 (ClassObject) String)
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-const null-ClassObject ClassObject)
(declare-const var1386 ClassObject) ; Statement: r0 := @parameter0: java.lang.Class 
(assert (not (= var1386 null-ClassObject)))
(assert true)
(define-const var3130 String (toString/-1020053180 var1386)) ; Statement: r5 = virtualinvoke r0.<java.lang.Class: java.lang.String toString()>() 
; split operation: var1499 = var3130.split("[.]") ; Statement: r1 = virtualinvoke r5.<java.lang.String: java.lang.String[] split(java.lang.String)>("[.]") 
(define-const var2435 Int (get_split_length var3130 "[.]" -1)) ; Statement: $i0 = lengthof r1 
(define-const var3026 Int (- var2435 1)) ; Statement: $i1 = $i0 - 1 
(define-const var3397 String (get_split_element var3130 "[.]" -1 var3026)) ; Statement: r6 = r1[$i1] 
(assert true)
(define-const var2084 Bool (endsWith/985337093 var3397 "Transition")) ; Statement: $z0 = virtualinvoke r6.<java.lang.String: boolean endsWith(java.lang.String)>("Transition") 
 ; Statement: if $z0 == 0 goto return r6 
(assert (= (ite var2084 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r6 
(check-sat)
; {toString/-1020053180=([java.lang.Class], java.lang.String), endsWith/985337093=([java.lang.String, java.lang.String], boolean)}
; {var1386=r0, var3130=r5, var1499=r1, var2435=$i0, var3026=$i1, var3397=r6, var2084=$z0}
; {r0=var1386, r5=var3130, r1=var1499, $i0=var2435, $i1=var3026, r6=var3397, $z0=var2084}
;seq <java.lang.Class: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: boolean endsWith(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: boolean endsWith(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.Class;	r5 = virtualinvoke r0.<java.lang.Class: java.lang.String toString()>();	r1 = virtualinvoke r5.<java.lang.String: java.lang.String[] split(java.lang.String)>("[.]");	$i0 = lengthof r1;	$i1 = $i0 - 1;	r6 = r1[$i1];	$z0 = virtualinvoke r6.<java.lang.String: boolean endsWith(java.lang.String)>("Transition");	if $z0 == 0 goto return r6;	return r6
;block_num 2
(get-model)
