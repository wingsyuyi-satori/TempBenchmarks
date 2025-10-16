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

(declare-sort var2021 0)
(declare-sort var405 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var405-init () var405)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var405 String) void)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var7 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var7 null-String)))
(declare-const var495 (Array Int String)) ; Statement: r11 := @parameter1: java.lang.String[] 
(assert (not (= var495 null-__Array__Int__String__)))
; split operation: var1693 = var7.split("<") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("<") 
(define-const var2966 Int (get_split_length var7 "<" -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 != 2 goto $r2 = new java.lang.IllegalArgumentException 
(assert (not (= var2966 2))) ; Cond: $i0 != 2 
(define-const var2585 var405 var405-init) ; Statement: $r2 = new java.lang.IllegalArgumentException 
(define-const var2725 String String-init) ; Statement: $r3 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2725)) ; Statement: specialinvoke $r3.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2725!1 String)
(assert (= var2725!1 ""))
(assert true)
(define-const var2438 String (append/672562846 var2725!1 "Invalid sieve ordering constraint: ")) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid sieve ordering constraint: ") 
(declare-const var2725!2 String)
(assert (= var2725!2 (str.++ var2725!1 "Invalid sieve ordering constraint: ")))
(assert true)
(define-const var2839 String (append/672562846 var2438 var7)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var2438!1 String)
(assert (= var2438!1 (str.++ var2438 var7)))
(assert true)
(define-const var770 String (toString/-2075883882 var2839)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var2585 var770)) ; Statement: specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r6) 

(declare-const var2585!1 var405)
(declare-const var770!1 String)
 ; Statement: throw $r2 
(check-sat)
; {var405-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var7=r0, var2021=null_type, var495=r11, var1693=r1, var2966=$i0, var405=java.lang.IllegalArgumentException, var2585=$r2, var2725=$r3, var2438=$r4, var2839=$r5, var770=$r6}
; {r0=var7, null_type=var2021, r11=var495, r1=var1693, $i0=var2966, java.lang.IllegalArgumentException=var405, $r2=var2585, $r3=var2725, $r4=var2438, $r5=var2839, $r6=var770}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r11 := @parameter1: java.lang.String[];	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("<");	$i0 = lengthof r1;	if $i0 != 2 goto $r2 = new java.lang.IllegalArgumentException;	$r2 = new java.lang.IllegalArgumentException;	$r3 = new java.lang.StringBuilder;	specialinvoke $r3.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid sieve ordering constraint: ");	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r2.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r6);	throw $r2
;block_num 2
(get-model)
