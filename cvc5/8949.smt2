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

(declare-sort var2774 0)
(declare-sort var2567 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun info/114590825 (var2567 String) void)
(declare-const null-String String)
(declare-const null-var2567 var2567)
(declare-const null-Bool Bool)
(declare-const var3315 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3315 null-String)))
(declare-const var2575 var2567) ; Statement: r3 := @parameter1: java.util.logging.Logger 
(assert (not (= var2575 null-var2567)))
(declare-const var2644 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var2644 null-Bool)))
; split operation: var1864 = var3315.split("\n") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
 ; Statement: if z0 != 0 goto $r2 = new java.lang.StringBuilder 
(assert (not (= (ite var2644 1 0) 0))) ; Cond: z0 != 0 
(define-const var3378 String String-init) ; Statement: $r2 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3378)) ; Statement: specialinvoke $r2.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3378!1 String)
(assert (= var3378!1 ""))
(define-const var1979 Int (get_split_length var3315 "\n" -1)) ; Statement: i2 = lengthof r1 
(define-const var73 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i2 goto $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (>= var73 var1979)) ; Cond: i3 >= i2 
(assert true)
(define-const var2924 String (toString/-2075883882 var3378!1)) ; Statement: $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (info/114590825 var2575 var2924)) ; Statement: virtualinvoke r3.<java.util.logging.Logger: void info(java.lang.String)>($r4) 

(declare-const var2575!1 var2567)
(declare-const var2924!1 String)
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), info/114590825=([java.util.logging.Logger, java.lang.String], void)}
; {var3315=r0, var2774=null_type, var2567=java.util.logging.Logger, var2575=r3, var2644=z0, var1864=r1, var3378=$r2, var1979=i2, var73=i3, var2924=$r4}
; {r0=var3315, null_type=var2774, java.util.logging.Logger=var2567, r3=var2575, z0=var2644, r1=var1864, $r2=var3378, i2=var1979, i3=var73, $r4=var2924}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r3 := @parameter1: java.util.logging.Logger;	z0 := @parameter2: boolean;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	if z0 != 0 goto $r2 = new java.lang.StringBuilder;	$r2 = new java.lang.StringBuilder;	specialinvoke $r2.<java.lang.StringBuilder: void <init>()>();	i2 = lengthof r1;	i3 = 0;	if i3 >= i2 goto $r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.String toString()>();	$r4 = virtualinvoke $r2.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke r3.<java.util.logging.Logger: void info(java.lang.String)>($r4);	return
;block_num 5
(get-model)
