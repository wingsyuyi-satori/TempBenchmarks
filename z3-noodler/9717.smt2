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

(declare-sort var3344 0)
(declare-sort var1020 0)
(declare-sort var3888 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun size/-1863229846 (var3344) Int)
(declare-fun add/1770215592 (var3344 var3888) Bool)
(declare-fun cast-from-String-to-var3888 (String) var3888)
(declare-const null-var3344 var3344)
(declare-const null-String String)
(declare-const var3932 var3344) ; Statement: r0 := @parameter0: java.util.ArrayList 
(assert (not (= var3932 null-var3344)))
(declare-const var2747 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2747 null-String)))
(assert true)
(define-const var191 Int (size/-1863229846 var3932)) ; Statement: $i0 = virtualinvoke r0.<java.util.ArrayList: int size()>() 
(define-const var2078 Int (mod var191 2)) ; Statement: $i1 = $i0 % 2 
 ; Statement: if $i1 != 1 goto r15 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(":") 
(assert (not (= var2078 1))) ; Cond: $i1 != 1 
; split operation: var2213 = var2747.split(":") ; Statement: r15 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(":") 
(define-const var1813 Int (get_split_length var2747 ":" -1)) ; Statement: $i2 = lengthof r15 
 ; Statement: if $i2 <= 0 goto $r8 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("=") 
(assert (<= var1813 0)) ; Cond: $i2 <= 0 
; split operation: var1091 = var2747.split("=") ; Statement: $r8 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("=") 
(define-const var3063 Int (get_split_length var2747 "=" -1)) ; Statement: $i3 = lengthof $r8 
 ; Statement: if $i3 <= 0 goto virtualinvoke r0.<java.util.ArrayList: boolean add(java.lang.Object)>(r1) 
(assert (<= var3063 0)) ; Cond: $i3 <= 0 
(assert true)
;(assert (add/1770215592 var3932 (cast-from-String-to-var3888 var2747))) ; Statement: virtualinvoke r0.<java.util.ArrayList: boolean add(java.lang.Object)>(r1) 

(declare-const var3932!1 var3344)
(declare-const var2747!1 String)
 ; Statement: return r0 
(check-sat)
; {size/-1863229846=([java.util.ArrayList], int), add/1770215592=([java.util.ArrayList, java.lang.Object], boolean), cast-from-String-to-var3888=([java.lang.String], java.lang.Object)}
; {var3344=java.util.ArrayList, var3932=r0, var2747=r1, var1020=null_type, var191=$i0, var2078=$i1, var2213=r15, var1813=$i2, var1091=$r8, var3063=$i3, var3888=java.lang.Object}
; {java.util.ArrayList=var3344, r0=var3932, r1=var2747, null_type=var1020, $i0=var191, $i1=var2078, r15=var2213, $i2=var1813, $r8=var1091, $i3=var3063, java.lang.Object=var3888}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r0 := @parameter0: java.util.ArrayList;	r1 := @parameter1: java.lang.String;	$i0 = virtualinvoke r0.<java.util.ArrayList: int size()>();	$i1 = $i0 % 2;	if $i1 != 1 goto r15 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(":");	r15 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(":");	$i2 = lengthof r15;	if $i2 <= 0 goto $r8 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("=");	$r8 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("=");	$i3 = lengthof $r8;	if $i3 <= 0 goto virtualinvoke r0.<java.util.ArrayList: boolean add(java.lang.Object)>(r1);	virtualinvoke r0.<java.util.ArrayList: boolean add(java.lang.Object)>(r1);	return r0
;block_num 4
(get-model)
