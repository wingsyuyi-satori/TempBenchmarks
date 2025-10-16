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

(declare-sort var3392 0)
(declare-sort var1864 0)
(declare-sort var3522 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toString/-512974245 (var3392) String)
(declare-fun var3522_isNotBlank/-616714458 (String) Bool)
(declare-const null-var3392 var3392)
(declare-const null-var1864 var1864)
(declare-const var3863 var3392) ; Statement: r0 := @parameter0: java.net.InetAddress 
(assert (not (= var3863 null-var3392)))
(declare-const var1235 var1864) ; Statement: r4 := @parameter1: java.util.List 
(assert (not (= var1235 null-var1864)))
(assert true)
(define-const var3976 String (toString/-512974245 var3863)) ; Statement: $r1 = virtualinvoke r0.<java.net.InetAddress: java.lang.String toString()>() 
; split operation: var3167 = var3976.split("\u005cs*/\u005cs*") ; Statement: r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s*/\\s*") 
(define-const var1619 Int (get_split_length var3976 "\u005cs*/\u005cs*" -1)) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 <= 0 goto return 
(assert (not (<= var1619 0))) ; Negate: Cond: $i0 <= 0  
(define-const var2723 Int (get_split_length var3976 "\u005cs*/\u005cs*" -1)) ; Statement: i1 = lengthof r2 
(define-const var1759 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i1 goto return 
(assert (not (>= var1759 var2723))) ; Negate: Cond: i2 >= i1  
(define-const var3456 String (get_split_element var3976 "\u005cs*/\u005cs*" -1 var1759)) ; Statement: r3 = r2[i2] 
(define-const var87 Bool (var3522_isNotBlank/-616714458 var3456)) ; Statement: $z0 = staticinvoke <org.apache.logging.log4j.util.Strings: boolean isNotBlank(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto i2 = i2 + 1 
(assert (= (ite var87 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1759!1 Int (+ var1759 1)) ; Statement: i2 = i2 + 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i1 goto return 
(assert (not (>= var1759!1 var2723))) ; Negate: Cond: i2 >= i1  
(define-const var3456!1 String (get_split_element var3976 "\u005cs*/\u005cs*" -1 var1759!1)) ; Statement: r3 = r2[i2] 
(define-const var87!1 Bool (var3522_isNotBlank/-616714458 var3456!1)) ; Statement: $z0 = staticinvoke <org.apache.logging.log4j.util.Strings: boolean isNotBlank(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto i2 = i2 + 1 
(assert (= (ite var87!1 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1759!2 Int (+ var1759!1 1)) ; Statement: i2 = i2 + 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i1 goto return 
(assert (>= var1759!2 var2723)) ; Cond: i2 >= i1 
 ; Statement: return 
(check-sat)
; {toString/-512974245=([java.net.InetAddress], java.lang.String), var3522_isNotBlank/-616714458=([java.lang.String], boolean)}
; {var3392=java.net.InetAddress, var3863=r0, var1864=java.util.List, var1235=r4, var3976=$r1, var3167=r2, var1619=$i0, var2723=i1, var1759=i2, var3456=r3, var3522=org.apache.logging.log4j.util.Strings, var87=$z0}
; {java.net.InetAddress=var3392, r0=var3863, java.util.List=var1864, r4=var1235, $r1=var3976, r2=var3167, $i0=var1619, i1=var2723, i2=var1759, r3=var3456, org.apache.logging.log4j.util.Strings=var3522, $z0=var87}
;seq <java.net.InetAddress: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.net.InetAddress;	r4 := @parameter1: java.util.List;	$r1 = virtualinvoke r0.<java.net.InetAddress: java.lang.String toString()>();	r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s*/\\s*");	$i0 = lengthof r2;	if $i0 <= 0 goto return;	i1 = lengthof r2;	i2 = 0;	if i2 >= i1 goto return;	r3 = r2[i2];	$z0 = staticinvoke <org.apache.logging.log4j.util.Strings: boolean isNotBlank(java.lang.String)>(r3);	if $z0 == 0 goto i2 = i2 + 1;	i2 = i2 + 1;	goto [?= (branch)];	if i2 >= i1 goto return;	r3 = r2[i2];	$z0 = staticinvoke <org.apache.logging.log4j.util.Strings: boolean isNotBlank(java.lang.String)>(r3);	if $z0 == 0 goto i2 = i2 + 1;	i2 = i2 + 1;	goto [?= (branch)];	if i2 >= i1 goto return;	return
;block_num 10
(get-model)
