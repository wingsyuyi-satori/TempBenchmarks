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

(declare-sort var3902 0)
(declare-sort var989 0)
(declare-sort var3284 0)
(declare-sort var160 0)
(declare-sort var397 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var160-init () var160)
(declare-fun <init>/358169345 (var160) void)
(declare-fun omitComments/-1276310728 (var3902) Bool)
(declare-fun store/-1111572071 (var397 var989 String) void)
(declare-fun cast-from-var3902-to-var397 (var3902) var397)
(declare-fun cast-from-var160-to-var989 (var160) var989)
(declare-fun toString/138175384 (var160) String)
(declare-const null-var3902 var3902)
(declare-const null-var989 var989)
(declare-const null-String String)
(declare-const var3902-EOL String)
(declare-const var2844 var3902) ; Statement: r1 := @this: org.springframework.core.SortedProperties 
(assert (not (= var2844 null-var3902)))
(declare-const var3073 var989) ; Statement: r5 := @parameter0: java.io.Writer 
(assert (not (= var3073 null-var989)))
(declare-const var1834 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1834 null-String)))
(define-const var3816 var160 var160-init) ; Statement: $r0 = new java.io.StringWriter 
(assert true)
;(assert (<init>/358169345 var3816)) ; Statement: specialinvoke $r0.<java.io.StringWriter: void <init>()>() 

(declare-const var3816!1 var160)
(define-const var1924 Bool (omitComments/-1276310728 var2844)) ; Statement: $z0 = r1.<org.springframework.core.SortedProperties: boolean omitComments> 
 ; Statement: if $z0 == 0 goto $r10 = r2 
(assert (not (= (ite var1924 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2776 String null-String) ; Statement: $r10 = null 
 ; Statement: goto [?= specialinvoke r1.<java.util.Properties: void store(java.io.Writer,java.lang.String)>($r0, $r10)] 
(assert true) ; Non Conditional
(assert true)
;(assert (store/-1111572071 (cast-from-var3902-to-var397 var2844) (cast-from-var160-to-var989 var3816!1) var2776)) ; Statement: specialinvoke r1.<java.util.Properties: void store(java.io.Writer,java.lang.String)>($r0, $r10) 

(declare-const var2844!1 var3902)
(declare-const var3816!2 var160)
(declare-const var2776!1 String)
(assert true)
(define-const var2444 String (toString/138175384 var3816!2)) ; Statement: $r8 = virtualinvoke $r0.<java.io.StringWriter: java.lang.String toString()>() 
(define-const var3120 String var3902-EOL) ; Statement: $r3 = <org.springframework.core.SortedProperties: java.lang.String EOL> 
; split operation: var507 = var2444.split(var3120) ; Statement: $r9 = virtualinvoke $r8.<java.lang.String: java.lang.String[] split(java.lang.String)>($r3) 
(define-const var2803 Int (get_split_length var2444 var3120 -1)) ; Statement: $i0 = lengthof $r9 
(define-const var1532 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto return 
(assert (>= var1532 var2803)) ; Cond: i1 >= $i0 
 ; Statement: return 
(check-sat)
; {var160-init=([], java.io.StringWriter), <init>/358169345=([java.io.StringWriter], void), omitComments/-1276310728=([org.springframework.core.SortedProperties], boolean), store/-1111572071=([java.util.Properties, java.io.Writer, java.lang.String], void), cast-from-var3902-to-var397=([org.springframework.core.SortedProperties], java.util.Properties), cast-from-var160-to-var989=([java.io.StringWriter], java.io.Writer), toString/138175384=([java.io.StringWriter], java.lang.String)}
; {var3902=org.springframework.core.SortedProperties, var2844=r1, var989=java.io.Writer, var3073=r5, var1834=r2, var3284=null_type, var160=java.io.StringWriter, var3816=$r0, var1924=$z0, var2776=$r10, var397=java.util.Properties, var2444=$r8, var3120=$r3, var507=$r9, var2803=$i0, var1532=i1}
; {org.springframework.core.SortedProperties=var3902, r1=var2844, java.io.Writer=var989, r5=var3073, r2=var1834, null_type=var3284, java.io.StringWriter=var160, $r0=var3816, $z0=var1924, $r10=var2776, java.util.Properties=var397, $r8=var2444, $r3=var3120, $r9=var507, $i0=var2803, i1=var1532}
;seq <java.io.StringWriter: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @this: org.springframework.core.SortedProperties;	r5 := @parameter0: java.io.Writer;	r2 := @parameter1: java.lang.String;	$r0 = new java.io.StringWriter;	specialinvoke $r0.<java.io.StringWriter: void <init>()>();	$z0 = r1.<org.springframework.core.SortedProperties: boolean omitComments>;	if $z0 == 0 goto $r10 = r2;	$r10 = null;	goto [?= specialinvoke r1.<java.util.Properties: void store(java.io.Writer,java.lang.String)>($r0, $r10)];	specialinvoke r1.<java.util.Properties: void store(java.io.Writer,java.lang.String)>($r0, $r10);	$r8 = virtualinvoke $r0.<java.io.StringWriter: java.lang.String toString()>();	$r3 = <org.springframework.core.SortedProperties: java.lang.String EOL>;	$r9 = virtualinvoke $r8.<java.lang.String: java.lang.String[] split(java.lang.String)>($r3);	$i0 = lengthof $r9;	i1 = 0;	if i1 >= $i0 goto return;	return
;block_num 5
(get-model)
