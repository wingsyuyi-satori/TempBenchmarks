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

(declare-sort var57 0)
(declare-sort var3904 0)
(declare-sort var2350 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3904_getValue/381491177 (var3904) var2350)
(declare-fun cast-from-var2350-to-String (var2350) String)
(declare-fun var57_contains/1636690605 (var57 var2350) Bool)
(declare-fun cast-from-String-to-var2350 (String) var2350)
(declare-const null-var57 var57)
(declare-const null-var3904 var3904)
(declare-const var3450 var57) ; Statement: r0 := @parameter0: java.util.Set 
(assert (not (= var3450 null-var57)))
(declare-const var3003 var3904) ; Statement: r1 := @parameter1: java.util.Map$Entry 
(assert (not (= var3003 null-var3904)))
(define-const var1499 var2350 (var3904_getValue/381491177 var3003)) ; Statement: $r2 = interfaceinvoke r1.<java.util.Map$Entry: java.lang.Object getValue()>() 
(define-const var3940 String (cast-from-var2350-to-String var1499)) ; Statement: $r3 = (java.lang.String) $r2 
; split operation: var1193 = var3940.split(" ") ; Statement: $r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ") 
(define-const var1155 String (get_split_element var3940 " " -1 0)) ; Statement: $r5 = $r4[0] 
(define-const var3859 Bool (var57_contains/1636690605 var3450 (cast-from-String-to-var2350 var1155))) ; Statement: $z0 = interfaceinvoke r0.<java.util.Set: boolean contains(java.lang.Object)>($r5) 
 ; Statement: if $z0 != 0 goto $z1 = 0 
(assert (not (not (= (ite var3859 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var2712 Bool (ite (= 1 1) true false)) ; Statement: $z1 = 1 
 ; Statement: goto [?= return $z1] 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {var3904_getValue/381491177=([java.util.Map$Entry], java.lang.Object), cast-from-var2350-to-String=([java.lang.Object], java.lang.String), var57_contains/1636690605=([java.util.Set, java.lang.Object], boolean), cast-from-String-to-var2350=([java.lang.String], java.lang.Object)}
; {var57=java.util.Set, var3450=r0, var3904=java.util.Map$Entry, var3003=r1, var2350=java.lang.Object, var1499=$r2, var3940=$r3, var1193=$r4, var1155=$r5, var3859=$z0, var2712=$z1}
; {java.util.Set=var57, r0=var3450, java.util.Map$Entry=var3904, r1=var3003, java.lang.Object=var2350, $r2=var1499, $r3=var3940, $r4=var1193, $r5=var1155, $z0=var3859, $z1=var2712}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.util.Set;	r1 := @parameter1: java.util.Map$Entry;	$r2 = interfaceinvoke r1.<java.util.Map$Entry: java.lang.Object getValue()>();	$r3 = (java.lang.String) $r2;	$r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	$r5 = $r4[0];	$z0 = interfaceinvoke r0.<java.util.Set: boolean contains(java.lang.Object)>($r5);	if $z0 != 0 goto $z1 = 0;	$z1 = 1;	goto [?= return $z1];	return $z1
;block_num 3
(get-model)
