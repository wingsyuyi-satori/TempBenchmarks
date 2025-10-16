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

(declare-sort var2524 0)
(declare-sort var2169 0)
(declare-sort var3865 0)
(declare-sort var1804 0)
(declare-sort var137 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3865_newHashSet/99871946 () var2169)
(declare-fun var2169_size/-649653377 (var2169) Int)
(declare-fun arr-String-init () (Array Int String))
(declare-fun var2169_toArray/-250983565 (var2169 (Array Int var1804)) (Array Int var1804))
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var1804__ ((Array Int String)) (Array Int var1804))
(declare-fun var137_sort/-2094180924 ((Array Int var1804)) void)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-String String)
(declare-const var3654 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3654 null-String)))
(declare-const var1378 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1378 null-String)))
; split operation: var1506 = var3654.split("/") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
; split operation: var3142 = var1378.split("/") ; Statement: r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(define-const var2996 var2169 var3865_newHashSet/99871946) ; Statement: r4 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet()>() 
(define-const var2890 Int (get_split_length var3654 "/" -1)) ; Statement: i2 = lengthof r1 
(define-const var3565 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i2 goto i4 = lengthof r3 
(assert (>= var3565 var2890)) ; Cond: i3 >= i2 
(define-const var2986 Int (get_split_length var1378 "/" -1)) ; Statement: i4 = lengthof r3 
(define-const var796 Int 0) ; Statement: i5 = 0 
(assert true) ; Non Conditional
 ; Statement: if i5 >= i4 goto $i0 = interfaceinvoke r4.<java.util.Set: int size()>() 
(assert (>= var796 var2986)) ; Cond: i5 >= i4 
(define-const var2032 Int (var2169_size/-649653377 var2996)) ; Statement: $i0 = interfaceinvoke r4.<java.util.Set: int size()>() 
(define-const var1043 (Array Int String) arr-String-init) ; Statement: r10 = newarray (java.lang.String)[$i0] 
;(assert (var2169_toArray/-250983565 var2996 (cast-from-__Array__Int__String__-to-__Array__Int__var1804__ var1043))) ; Statement: interfaceinvoke r4.<java.util.Set: java.lang.Object[] toArray(java.lang.Object[])>(r10) 

(declare-const var2996!1 var2169)
(declare-const var1043!1 (Array Int String))
;(assert (var137_sort/-2094180924 (cast-from-__Array__Int__String__-to-__Array__Int__var1804__ var1043!1))) ; Statement: staticinvoke <java.util.Arrays: void sort(java.lang.Object[])>(r10) 

(declare-const var1043!2 (Array Int String))
(define-const var1444 String String-init) ; Statement: $r5 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1444)) ; Statement: specialinvoke $r5.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1444!1 String)
(assert (= var1444!1 ""))
(define-const var3842 Int 0) ; Statement: i6 = 0 
(assert true) ; Non Conditional
(define-const var2776 Int (getLength-Arr-String-1 var1043!2)) ; Statement: $i1 = lengthof r10 
 ; Statement: if i6 >= $i1 goto $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (>= var3842 var2776)) ; Cond: i6 >= $i1 
(assert true)
(define-const var660 String (toString/-2075883882 var1444!1)) ; Statement: $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {var3865_newHashSet/99871946=([], java.util.Set), var2169_size/-649653377=([java.util.Set], int), arr-String-init=([], java.lang.String[]), var2169_toArray/-250983565=([java.util.Set, java.lang.Object[]], java.lang.Object[]), cast-from-__Array__Int__String__-to-__Array__Int__var1804__=([java.lang.String[]], java.lang.Object[]), var137_sort/-2094180924=([java.lang.Object[]], void), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getLength-Arr-String-1=([java.lang.String[]], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3654=r0, var2524=null_type, var1378=r2, var1506=r1, var3142=r3, var2169=java.util.Set, var3865=edu.stanford.nlp.util.Generics, var2996=r4, var2890=i2, var3565=i3, var2986=i4, var796=i5, var2032=$i0, var1043=r10, var1804=java.lang.Object, var137=java.util.Arrays, var1444=$r5, var3842=i6, var2776=$i1, var660=$r6}
; {r0=var3654, null_type=var2524, r2=var1378, r1=var1506, r3=var3142, java.util.Set=var2169, edu.stanford.nlp.util.Generics=var3865, r4=var2996, i2=var2890, i3=var3565, i4=var2986, i5=var796, $i0=var2032, r10=var1043, java.lang.Object=var1804, java.util.Arrays=var137, $r5=var1444, i6=var3842, $i1=var2776, $r6=var660}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	r4 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Set newHashSet()>();	i2 = lengthof r1;	i3 = 0;	if i3 >= i2 goto i4 = lengthof r3;	i4 = lengthof r3;	i5 = 0;	if i5 >= i4 goto $i0 = interfaceinvoke r4.<java.util.Set: int size()>();	$i0 = interfaceinvoke r4.<java.util.Set: int size()>();	r10 = newarray (java.lang.String)[$i0];	interfaceinvoke r4.<java.util.Set: java.lang.Object[] toArray(java.lang.Object[])>(r10);	staticinvoke <java.util.Arrays: void sort(java.lang.Object[])>(r10);	$r5 = new java.lang.StringBuilder;	specialinvoke $r5.<java.lang.StringBuilder: void <init>()>();	i6 = 0;	$i1 = lengthof r10;	if i6 >= $i1 goto $r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	$r6 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	return $r6
;block_num 7
(get-model)
