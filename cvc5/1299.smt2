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

(declare-sort var1473 0)
(declare-sort var934 0)
(declare-sort var2022 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun Int_parseInt/1370970945 (String) Int)
(declare-fun var2022-init () var2022)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var2022 String) void)
(declare-const null-String String)
(declare-const null-var934 var934)
(declare-const var1281 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1281 null-String)))
; split operation: var3425 = var1281.split("/") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(define-const var2192 String (get_split_element var1281 "/" -1 0)) ; Statement: r2 = r1[0] 
(define-const var2092 Int (get_split_length var1281 "/" -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 >= 2 goto $r3 = r1[1] 
(assert (>= var2092 2)) ; Cond: $i0 >= 2 
(define-const var203 String (get_split_element var1281 "/" -1 1)) ; Statement: $r3 = r1[1] 
(define-const var1736 Int (Int_parseInt/1370970945 var203)) ; Statement: i1 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>($r3) 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var3530 var934) ; Statement: $r8 := @caughtexception 
(assert (not (= var3530 null-var934)))
(define-const var882 var2022 var2022-init) ; Statement: $r9 = new java.lang.IllegalArgumentException 
(define-const var2388 String String-init) ; Statement: $r10 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2388)) ; Statement: specialinvoke $r10.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2388!1 String)
(assert (= var2388!1 ""))
(assert true)
(define-const var2977 String (append/672562846 var2388!1 "Invalid subnet: ")) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid subnet: ") 
(declare-const var2388!2 String)
(assert (= var2388!2 (str.++ var2388!1 "Invalid subnet: ")))
(assert true)
(define-const var2779 String (append/672562846 var2977 var1281)) ; Statement: $r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var2977!1 String)
(assert (= var2977!1 (str.++ var2977 var1281)))
(assert true)
(define-const var1317 String (toString/-2075883882 var2779)) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var882 var1317)) ; Statement: specialinvoke $r9.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r13) 

(declare-const var882!1 var2022)
(declare-const var1317!1 String)
 ; Statement: throw $r9 
(check-sat)
; {Int_parseInt/1370970945=([java.lang.String], int), var2022-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var1281=r0, var1473=null_type, var3425=r1, var2192=r2, var2092=$i0, var203=$r3, var1736=i1, var934=java.net.UnknownHostException, var3530=$r8, var2022=java.lang.IllegalArgumentException, var882=$r9, var2388=$r10, var2977=$r11, var2779=$r12, var1317=$r13}
; {r0=var1281, null_type=var1473, r1=var3425, r2=var2192, $i0=var2092, $r3=var203, i1=var1736, java.net.UnknownHostException=var934, $r8=var3530, java.lang.IllegalArgumentException=var2022, $r9=var882, $r10=var2388, $r11=var2977, $r12=var2779, $r13=var1317}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	r2 = r1[0];	$i0 = lengthof r1;	if $i0 >= 2 goto $r3 = r1[1];	$r3 = r1[1];	i1 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>($r3);	$r8 := @caughtexception;	$r9 = new java.lang.IllegalArgumentException;	$r10 = new java.lang.StringBuilder;	specialinvoke $r10.<java.lang.StringBuilder: void <init>()>();	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid subnet: ");	$r12 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r9.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r13);	throw $r9
;block_num 3
(get-model)
