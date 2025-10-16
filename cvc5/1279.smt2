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

(declare-sort var3588 0)
(declare-sort var1412 0)
(declare-sort var1496 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1496-init () var1496)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var1496 String) void)
(declare-const null-String String)
(declare-const null-var1412 var1412)
(declare-const var79 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var79 null-String)))
; split operation: var3796 = var79.split("/") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(define-const var1371 String (get_split_element var79 "/" -1 0)) ; Statement: r2 = r1[0] 
(define-const var1699 Int (get_split_length var79 "/" -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 >= 2 goto $r3 = r1[1] 
(assert (not (>= var1699 2))) ; Negate: Cond: $i0 >= 2  
(define-const var3544 Int 0) ; Statement: i1 = 0 
 ; Statement: goto [?= $r4 = staticinvoke <java.net.InetAddress: java.net.InetAddress getByName(java.lang.String)>(r2)] 
(assert true) ; Non Conditional
(declare-const var2880 var1412) ; Statement: $r8 := @caughtexception 
(assert (not (= var2880 null-var1412)))
(define-const var3750 var1496 var1496-init) ; Statement: $r9 = new java.lang.IllegalArgumentException 
(define-const var1200 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1200)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1200!1 String)
(assert (= var1200!1 ""))
(assert true)
(define-const var687 String (append/672562846 var1200!1 "Invalid subnet: ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid subnet: ") 
(declare-const var1200!2 String)
(assert (= var1200!2 (str.++ var1200!1 "Invalid subnet: ")))
(assert true)
(define-const var3356 String (append/672562846 var687 var79)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var687!1 String)
(assert (= var687!1 (str.++ var687 var79)))
(assert true)
(define-const var3219 String (toString/-2075883882 var3356)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var3750 var3219)) ; Statement: specialinvoke $r9.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r13) 

(declare-const var3750!1 var1496)
(declare-const var3219!1 String)
 ; Statement: throw $r9 
(check-sat)
; {var1496-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var79=r0, var3588=null_type, var3796=r1, var1371=r2, var1699=$i0, var3544=i1, var1412=java.net.UnknownHostException, var2880=$r8, var1496=java.lang.IllegalArgumentException, var3750=$r9, var1200=$r10, var687=$r11, var3356=$r12, var3219=$r13}
; {r0=var79, null_type=var3588, r1=var3796, r2=var1371, $i0=var1699, i1=var3544, java.net.UnknownHostException=var1412, $r8=var2880, java.lang.IllegalArgumentException=var1496, $r9=var3750, $r10=var1200, $r11=var687, $r12=var3356, $r13=var3219}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	r2 = r1[0];	$i0 = lengthof r1;	if $i0 >= 2 goto $r3 = r1[1];	i1 = 0;	goto [?= $r4 = staticinvoke <java.net.InetAddress: java.net.InetAddress getByName(java.lang.String)>(r2)];	$r8 := @caughtexception;	$r9 = new java.lang.IllegalArgumentException;	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid subnet: ");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r9.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r13);	throw $r9
;block_num 3
(get-model)
