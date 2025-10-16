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

(declare-sort var2570 0)
(declare-sort var3940 0)
(declare-sort var1550 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3940_getValue/381491177 (var3940) var1550)
(declare-fun cast-from-var1550-to-String (var1550) String)
(declare-fun var2570_contains/1636690605 (var2570 var1550) Bool)
(declare-fun cast-from-String-to-var1550 (String) var1550)
(declare-const null-var2570 var2570)
(declare-const null-var3940 var3940)
(declare-const var1846 var2570) ; Statement: r0 := @parameter0: java.util.Set 
(assert (not (= var1846 null-var2570)))
(declare-const var1576 var3940) ; Statement: r1 := @parameter1: java.util.Map$Entry 
(assert (not (= var1576 null-var3940)))
(define-const var3795 var1550 (var3940_getValue/381491177 var1576)) ; Statement: $r2 = interfaceinvoke r1.<java.util.Map$Entry: java.lang.Object getValue()>() 
(define-const var1738 String (cast-from-var1550-to-String var3795)) ; Statement: $r3 = (java.lang.String) $r2 
; split operation: var2638 = var1738.split(" ") ; Statement: $r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ") 
(define-const var1306 String (get_split_element var1738 " " -1 0)) ; Statement: $r5 = $r4[0] 
(define-const var1122 Bool (var2570_contains/1636690605 var1846 (cast-from-String-to-var1550 var1306))) ; Statement: $z0 = interfaceinvoke r0.<java.util.Set: boolean contains(java.lang.Object)>($r5) 
 ; Statement: if $z0 != 0 goto $z1 = 0 
(assert (not (= (ite var1122 1 0) 0))) ; Cond: $z0 != 0 
(define-const var3494 Bool (ite (= 1 0) true false)) ; Statement: $z1 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {var3940_getValue/381491177=([java.util.Map$Entry], java.lang.Object), cast-from-var1550-to-String=([java.lang.Object], java.lang.String), var2570_contains/1636690605=([java.util.Set, java.lang.Object], boolean), cast-from-String-to-var1550=([java.lang.String], java.lang.Object)}
; {var2570=java.util.Set, var1846=r0, var3940=java.util.Map$Entry, var1576=r1, var1550=java.lang.Object, var3795=$r2, var1738=$r3, var2638=$r4, var1306=$r5, var1122=$z0, var3494=$z1}
; {java.util.Set=var2570, r0=var1846, java.util.Map$Entry=var3940, r1=var1576, java.lang.Object=var1550, $r2=var3795, $r3=var1738, $r4=var2638, $r5=var1306, $z0=var1122, $z1=var3494}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.util.Set;	r1 := @parameter1: java.util.Map$Entry;	$r2 = interfaceinvoke r1.<java.util.Map$Entry: java.lang.Object getValue()>();	$r3 = (java.lang.String) $r2;	$r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	$r5 = $r4[0];	$z0 = interfaceinvoke r0.<java.util.Set: boolean contains(java.lang.Object)>($r5);	if $z0 != 0 goto $z1 = 0;	$z1 = 0;	return $z1
;block_num 3
(get-model)
