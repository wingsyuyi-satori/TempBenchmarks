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

(declare-sort var1974 0)
(declare-sort var850 0)
(declare-sort var3849 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toString/-512974245 (var1974) String)
(declare-fun var3849_isNotBlank/-616714458 (String) Bool)
(declare-const null-var1974 var1974)
(declare-const null-var850 var850)
(declare-const var2403 var1974) ; Statement: r0 := @parameter0: java.net.InetAddress 
(assert (not (= var2403 null-var1974)))
(declare-const var703 var850) ; Statement: r4 := @parameter1: java.util.List 
(assert (not (= var703 null-var850)))
(assert true)
(define-const var628 String (toString/-512974245 var2403)) ; Statement: $r1 = virtualinvoke r0.<java.net.InetAddress: java.lang.String toString()>() 
; split operation: var3582 = var628.split("\u005cs*/\u005cs*") ; Statement: r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s*/\\s*") 
(define-const var388 Int (get_split_length var628 "\u005cs*/\u005cs*" -1)) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 <= 0 goto return 
(assert (not (<= var388 0))) ; Negate: Cond: $i0 <= 0  
(define-const var3017 Int (get_split_length var628 "\u005cs*/\u005cs*" -1)) ; Statement: i1 = lengthof r2 
(define-const var2610 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i1 goto return 
(assert (not (>= var2610 var3017))) ; Negate: Cond: i2 >= i1  
(define-const var1635 String (get_split_element var628 "\u005cs*/\u005cs*" -1 var2610)) ; Statement: r3 = r2[i2] 
(define-const var629 Bool (var3849_isNotBlank/-616714458 var1635)) ; Statement: $z0 = staticinvoke <org.apache.logging.log4j.util.Strings: boolean isNotBlank(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto i2 = i2 + 1 
(assert (= (ite var629 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2610!1 Int (+ var2610 1)) ; Statement: i2 = i2 + 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i1 goto return 
(assert (>= var2610!1 var3017)) ; Cond: i2 >= i1 
 ; Statement: return 
(check-sat)
; {toString/-512974245=([java.net.InetAddress], java.lang.String), var3849_isNotBlank/-616714458=([java.lang.String], boolean)}
; {var1974=java.net.InetAddress, var2403=r0, var850=java.util.List, var703=r4, var628=$r1, var3582=r2, var388=$i0, var3017=i1, var2610=i2, var1635=r3, var3849=org.apache.logging.log4j.util.Strings, var629=$z0}
; {java.net.InetAddress=var1974, r0=var2403, java.util.List=var850, r4=var703, $r1=var628, r2=var3582, $i0=var388, i1=var3017, i2=var2610, r3=var1635, org.apache.logging.log4j.util.Strings=var3849, $z0=var629}
;seq <java.net.InetAddress: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.net.InetAddress;	r4 := @parameter1: java.util.List;	$r1 = virtualinvoke r0.<java.net.InetAddress: java.lang.String toString()>();	r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s*/\\s*");	$i0 = lengthof r2;	if $i0 <= 0 goto return;	i1 = lengthof r2;	i2 = 0;	if i2 >= i1 goto return;	r3 = r2[i2];	$z0 = staticinvoke <org.apache.logging.log4j.util.Strings: boolean isNotBlank(java.lang.String)>(r3);	if $z0 == 0 goto i2 = i2 + 1;	i2 = i2 + 1;	goto [?= (branch)];	if i2 >= i1 goto return;	return
;block_num 7
(get-model)
