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

(declare-sort var620 0)
(declare-sort var3781 0)
(declare-sort var241 0)
(declare-sort var3379 0)
(declare-sort var505 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3379-init () var3379)
(declare-fun <init>/358169345 (var3379) void)
(declare-fun omitComments/-1276310728 (var620) Bool)
(declare-fun store/-1111572071 (var505 var3781 String) void)
(declare-fun cast-from-var620-to-var505 (var620) var505)
(declare-fun cast-from-var3379-to-var3781 (var3379) var3781)
(declare-fun toString/138175384 (var3379) String)
(declare-const null-var620 var620)
(declare-const null-var3781 var3781)
(declare-const null-String String)
(declare-const var620-EOL String)
(declare-const var3438 var620) ; Statement: r1 := @this: org.springframework.core.SortedProperties 
(assert (not (= var3438 null-var620)))
(declare-const var2040 var3781) ; Statement: r5 := @parameter0: java.io.Writer 
(assert (not (= var2040 null-var3781)))
(declare-const var1859 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1859 null-String)))
(define-const var3362 var3379 var3379-init) ; Statement: $r0 = new java.io.StringWriter 
(assert true)
;(assert (<init>/358169345 var3362)) ; Statement: specialinvoke $r0.<java.io.StringWriter: void <init>()>() 

(declare-const var3362!1 var3379)
(define-const var3729 Bool (omitComments/-1276310728 var3438)) ; Statement: $z0 = r1.<org.springframework.core.SortedProperties: boolean omitComments> 
 ; Statement: if $z0 == 0 goto $r10 = r2 
(assert (= (ite var3729 1 0) 0)) ; Cond: $z0 == 0 
(define-const var678 String var1859) ; Statement: $r10 = r2 
(assert true) ; Non Conditional
(assert true)
;(assert (store/-1111572071 (cast-from-var620-to-var505 var3438) (cast-from-var3379-to-var3781 var3362!1) var678)) ; Statement: specialinvoke r1.<java.util.Properties: void store(java.io.Writer,java.lang.String)>($r0, $r10) 

(declare-const var3438!1 var620)
(declare-const var3362!2 var3379)
(declare-const var678!1 String)
(assert true)
(define-const var2013 String (toString/138175384 var3362!2)) ; Statement: $r8 = virtualinvoke $r0.<java.io.StringWriter: java.lang.String toString()>() 
(define-const var515 String var620-EOL) ; Statement: $r3 = <org.springframework.core.SortedProperties: java.lang.String EOL> 
; split operation: var3279 = var2013.split(var515) ; Statement: $r9 = virtualinvoke $r8.<java.lang.String: java.lang.String[] split(java.lang.String)>($r3) 
(define-const var3590 Int (get_split_length var2013 var515 -1)) ; Statement: $i0 = lengthof $r9 
(define-const var907 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto return 
(assert (>= var907 var3590)) ; Cond: i1 >= $i0 
 ; Statement: return 
(check-sat)
; {var3379-init=([], java.io.StringWriter), <init>/358169345=([java.io.StringWriter], void), omitComments/-1276310728=([org.springframework.core.SortedProperties], boolean), store/-1111572071=([java.util.Properties, java.io.Writer, java.lang.String], void), cast-from-var620-to-var505=([org.springframework.core.SortedProperties], java.util.Properties), cast-from-var3379-to-var3781=([java.io.StringWriter], java.io.Writer), toString/138175384=([java.io.StringWriter], java.lang.String)}
; {var620=org.springframework.core.SortedProperties, var3438=r1, var3781=java.io.Writer, var2040=r5, var1859=r2, var241=null_type, var3379=java.io.StringWriter, var3362=$r0, var3729=$z0, var678=$r10, var505=java.util.Properties, var2013=$r8, var515=$r3, var3279=$r9, var3590=$i0, var907=i1}
; {org.springframework.core.SortedProperties=var620, r1=var3438, java.io.Writer=var3781, r5=var2040, r2=var1859, null_type=var241, java.io.StringWriter=var3379, $r0=var3362, $z0=var3729, $r10=var678, java.util.Properties=var505, $r8=var2013, $r3=var515, $r9=var3279, $i0=var3590, i1=var907}
;seq <java.io.StringWriter: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @this: org.springframework.core.SortedProperties;	r5 := @parameter0: java.io.Writer;	r2 := @parameter1: java.lang.String;	$r0 = new java.io.StringWriter;	specialinvoke $r0.<java.io.StringWriter: void <init>()>();	$z0 = r1.<org.springframework.core.SortedProperties: boolean omitComments>;	if $z0 == 0 goto $r10 = r2;	$r10 = r2;	specialinvoke r1.<java.util.Properties: void store(java.io.Writer,java.lang.String)>($r0, $r10);	$r8 = virtualinvoke $r0.<java.io.StringWriter: java.lang.String toString()>();	$r3 = <org.springframework.core.SortedProperties: java.lang.String EOL>;	$r9 = virtualinvoke $r8.<java.lang.String: java.lang.String[] split(java.lang.String)>($r3);	$i0 = lengthof $r9;	i1 = 0;	if i1 >= $i0 goto return;	return
;block_num 5
(get-model)
