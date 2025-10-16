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

(declare-sort var637 0)
(declare-sort var1219 0)
(declare-sort var2963 0)
(declare-sort var1648 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun arr-var2963-init () (Array Int var2963))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun cast-from-String-to-var2963 (String) var2963)
(declare-fun var1648_log/2127824580 ((Array Int var2963)) void)
(declare-fun info/114590825 (var1219 String) void)
(declare-const null-String String)
(declare-const null-var1219 var1219)
(declare-const null-Bool Bool)
(declare-const null-__Array__Int__var2963__ (Array Int var2963))
(declare-const var2604 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2604 null-String)))
(declare-const var1643 var1219) ; Statement: r5 := @parameter1: java.util.logging.Logger 
(assert (not (= var1643 null-var1219)))
(declare-const var1599 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var1599 null-Bool)))
; split operation: var14 = var2604.split("\n") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
 ; Statement: if z0 != 0 goto $r2 = new java.lang.StringBuilder 
(assert (not (= (ite var1599 1 0) 0))) ; Cond: z0 != 0 
(define-const var1525 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1525)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1525!1 String)
(assert (= var1525!1 ""))
(define-const var0 Int (get_split_length var2604 "\n" -1)) ; Statement: i2 = lengthof r1 
(define-const var292 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i2 goto $r3 = newarray (java.lang.Object)[1] 
(assert (>= var292 var0)) ; Cond: i3 >= i2 
(define-const var3816 (Array Int var2963) arr-var2963-init) ; Statement: $r3 = newarray (java.lang.Object)[1] 
(assert true)
(define-const var269 String (toString/-2075883882 var1525!1)) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.String toString()>() 
(declare-const var3816!1 (Array Int var2963))
(assert (not (= var3816!1 null-__Array__Int__var2963__)))
(assert (= (select var3816!1 0) (cast-from-String-to-var2963 var269))) ; Statement: $r3[0] = $r4 
;(assert (var1648_log/2127824580 var3816!1)) ; Statement: staticinvoke <edu.stanford.nlp.util.logging.Redwood: void log(java.lang.Object[])>($r3) 

(declare-const var3816!2 (Array Int var2963))
(assert true)
(define-const var2815 String (toString/-2075883882 var1525!1)) ; Statement: $r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (info/114590825 var1643 var2815)) ; Statement: virtualinvoke r5.<java.util.logging.Logger: void info(java.lang.String)>($r6) 

(declare-const var1643!1 var1219)
(declare-const var2815!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), arr-var2963-init=([], java.lang.Object[]), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), cast-from-String-to-var2963=([java.lang.String], java.lang.Object), var1648_log/2127824580=([java.lang.Object[]], void), info/114590825=([java.util.logging.Logger, java.lang.String], void)}
; {var2604=r0, var637=null_type, var1219=java.util.logging.Logger, var1643=r5, var1599=z0, var14=r1, var1525=$r2, var0=i2, var292=i3, var2963=java.lang.Object, var3816=$r3, var269=$r4, var1648=edu.stanford.nlp.util.logging.Redwood, var2815=$r6}
; {r0=var2604, null_type=var637, java.util.logging.Logger=var1219, r5=var1643, z0=var1599, r1=var14, $r2=var1525, i2=var0, i3=var292, java.lang.Object=var2963, $r3=var3816, $r4=var269, edu.stanford.nlp.util.logging.Redwood=var1648, $r6=var2815}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 2}
;stmts r0 := @parameter0: java.lang.String;	r5 := @parameter1: java.util.logging.Logger;	z0 := @parameter2: boolean;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	if z0 != 0 goto $r2 = new java.lang.StringBuilder;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	i2 = lengthof r1;	i3 = 0;	if i3 >= i2 goto $r3 = newarray (java.lang.Object)[1];	$r3 = newarray (java.lang.Object)[1];	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.String toString()>();	$r3[0] = $r4;	staticinvoke <edu.stanford.nlp.util.logging.Redwood: void log(java.lang.Object[])>($r3);	$r6 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r5.<java.util.logging.Logger: void info(java.lang.String)>($r6);	return
;block_num 5
(get-model)
