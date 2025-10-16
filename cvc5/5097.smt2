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

(declare-sort var3575 0)
(declare-sort var1294 0)
(declare-sort var3328 0)
(declare-sort var2050 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toString/-512974245 (var3575) String)
(declare-fun var3328_isNotBlank/-616714458 (String) Bool)
(declare-fun var1294_contains/-441121415 (var1294 var2050) Bool)
(declare-fun cast-from-String-to-var2050 (String) var2050)
(declare-fun var1294_add/328494887 (var1294 var2050) Bool)
(declare-const null-var3575 var3575)
(declare-const null-var1294 var1294)
(declare-const var3638 var3575) ; Statement: r0 := @parameter0: java.net.InetAddress 
(assert (not (= var3638 null-var3575)))
(declare-const var2254 var1294) ; Statement: r4 := @parameter1: java.util.List 
(assert (not (= var2254 null-var1294)))
(assert true)
(define-const var1120 String (toString/-512974245 var3638)) ; Statement: $r1 = virtualinvoke r0.<java.net.InetAddress: java.lang.String toString()>() 
; split operation: var1938 = var1120.split("\u005cs*/\u005cs*") ; Statement: r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s*/\\s*") 
(define-const var1194 Int (get_split_length var1120 "\u005cs*/\u005cs*" -1)) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 <= 0 goto return 
(assert (not (<= var1194 0))) ; Negate: Cond: $i0 <= 0  
(define-const var3707 Int (get_split_length var1120 "\u005cs*/\u005cs*" -1)) ; Statement: i1 = lengthof r2 
(define-const var2450 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i1 goto return 
(assert (not (>= var2450 var3707))) ; Negate: Cond: i2 >= i1  
(define-const var2398 String (get_split_element var1120 "\u005cs*/\u005cs*" -1 var2450)) ; Statement: r3 = r2[i2] 
(define-const var2051 Bool (var3328_isNotBlank/-616714458 var2398)) ; Statement: $z0 = staticinvoke <org.apache.logging.log4j.util.Strings: boolean isNotBlank(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto i2 = i2 + 1 
(assert (not (= (ite var2051 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var831 Bool (var1294_contains/-441121415 var2254 (cast-from-String-to-var2050 var2398))) ; Statement: $z1 = interfaceinvoke r4.<java.util.List: boolean contains(java.lang.Object)>(r3) 
 ; Statement: if $z1 != 0 goto i2 = i2 + 1 
(assert (not (not (= (ite var831 1 0) 0)))) ; Negate: Cond: $z1 != 0  
;(assert (var1294_add/328494887 var2254 (cast-from-String-to-var2050 var2398))) ; Statement: interfaceinvoke r4.<java.util.List: boolean add(java.lang.Object)>(r3) 

(declare-const var2254!1 var1294)
(declare-const var2398!1 String)
(assert true) ; Non Conditional
(define-const var2450!1 Int (+ var2450 1)) ; Statement: i2 = i2 + 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i1 goto return 
(assert (>= var2450!1 var3707)) ; Cond: i2 >= i1 
 ; Statement: return 
(check-sat)
; {toString/-512974245=([java.net.InetAddress], java.lang.String), var3328_isNotBlank/-616714458=([java.lang.String], boolean), var1294_contains/-441121415=([java.util.List, java.lang.Object], boolean), cast-from-String-to-var2050=([java.lang.String], java.lang.Object), var1294_add/328494887=([java.util.List, java.lang.Object], boolean)}
; {var3575=java.net.InetAddress, var3638=r0, var1294=java.util.List, var2254=r4, var1120=$r1, var1938=r2, var1194=$i0, var3707=i1, var2450=i2, var2398=r3, var3328=org.apache.logging.log4j.util.Strings, var2051=$z0, var2050=java.lang.Object, var831=$z1}
; {java.net.InetAddress=var3575, r0=var3638, java.util.List=var1294, r4=var2254, $r1=var1120, r2=var1938, $i0=var1194, i1=var3707, i2=var2450, r3=var2398, org.apache.logging.log4j.util.Strings=var3328, $z0=var2051, java.lang.Object=var2050, $z1=var831}
;seq <java.net.InetAddress: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.net.InetAddress;	r4 := @parameter1: java.util.List;	$r1 = virtualinvoke r0.<java.net.InetAddress: java.lang.String toString()>();	r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s*/\\s*");	$i0 = lengthof r2;	if $i0 <= 0 goto return;	i1 = lengthof r2;	i2 = 0;	if i2 >= i1 goto return;	r3 = r2[i2];	$z0 = staticinvoke <org.apache.logging.log4j.util.Strings: boolean isNotBlank(java.lang.String)>(r3);	if $z0 == 0 goto i2 = i2 + 1;	$z1 = interfaceinvoke r4.<java.util.List: boolean contains(java.lang.Object)>(r3);	if $z1 != 0 goto i2 = i2 + 1;	interfaceinvoke r4.<java.util.List: boolean add(java.lang.Object)>(r3);	i2 = i2 + 1;	goto [?= (branch)];	if i2 >= i1 goto return;	return
;block_num 9
(get-model)
