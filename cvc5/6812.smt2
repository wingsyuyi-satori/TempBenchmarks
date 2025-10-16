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

(declare-sort var2499 0)
(declare-sort var2039 0)
(declare-sort var3431 0)
(declare-sort var3937 0)
(declare-sort var48 0)
(declare-sort var456 0)
(declare-sort var102 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3937-init () var3937)
(declare-fun <init>/-707998177 (var3937) void)
(declare-fun omitComments/-1276310728 (var2499) Bool)
(declare-fun store/877702891 (var48 var2039 String) void)
(declare-fun cast-from-var2499-to-var48 (var2499) var48)
(declare-fun cast-from-var3937-to-var2039 (var3937) var2039)
(declare-fun toString/-372517094 (var3937 var456) String)
(declare-const null-var2499 var2499)
(declare-const null-var2039 var2039)
(declare-const null-String String)
(declare-const var102-ISO_8859_1 var456)
(declare-const var2499-EOL String)
(declare-const var2906 var2499) ; Statement: r1 := @this: org.springframework.core.SortedProperties 
(assert (not (= var2906 null-var2499)))
(declare-const var1728 var2039) ; Statement: r6 := @parameter0: java.io.OutputStream 
(assert (not (= var1728 null-var2039)))
(declare-const var2021 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var2021 null-String)))
(define-const var1296 var3937 var3937-init) ; Statement: $r0 = new java.io.ByteArrayOutputStream 
(assert true)
;(assert (<init>/-707998177 var1296)) ; Statement: specialinvoke $r0.<java.io.ByteArrayOutputStream: void <init>()>() 

(declare-const var1296!1 var3937)
(define-const var2977 Bool (omitComments/-1276310728 var2906)) ; Statement: $z0 = r1.<org.springframework.core.SortedProperties: boolean omitComments> 
 ; Statement: if $z0 == 0 goto $r13 = r2 
(assert (not (= (ite var2977 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1886 String null-String) ; Statement: $r13 = null 
 ; Statement: goto [?= specialinvoke r1.<java.util.Properties: void store(java.io.OutputStream,java.lang.String)>($r0, $r13)] 
(assert true) ; Non Conditional
(assert true)
;(assert (store/877702891 (cast-from-var2499-to-var48 var2906) (cast-from-var3937-to-var2039 var1296!1) var1886)) ; Statement: specialinvoke r1.<java.util.Properties: void store(java.io.OutputStream,java.lang.String)>($r0, $r13) 

(declare-const var2906!1 var2499)
(declare-const var1296!2 var3937)
(declare-const var1886!1 String)
(define-const var1797 var456 var102-ISO_8859_1) ; Statement: $r3 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset ISO_8859_1> 
(assert true)
(define-const var87 String (toString/-372517094 var1296!2 var1797)) ; Statement: $r11 = virtualinvoke $r0.<java.io.ByteArrayOutputStream: java.lang.String toString(java.nio.charset.Charset)>($r3) 
(define-const var125 String var2499-EOL) ; Statement: $r4 = <org.springframework.core.SortedProperties: java.lang.String EOL> 
; split operation: var2456 = var87.split(var125) ; Statement: $r12 = virtualinvoke $r11.<java.lang.String: java.lang.String[] split(java.lang.String)>($r4) 
(define-const var2293 Int (get_split_length var87 var125 -1)) ; Statement: $i0 = lengthof $r12 
(define-const var1566 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto return 
(assert (>= var1566 var2293)) ; Cond: i1 >= $i0 
 ; Statement: return 
(check-sat)
; {var3937-init=([], java.io.ByteArrayOutputStream), <init>/-707998177=([java.io.ByteArrayOutputStream], void), omitComments/-1276310728=([org.springframework.core.SortedProperties], boolean), store/877702891=([java.util.Properties, java.io.OutputStream, java.lang.String], void), cast-from-var2499-to-var48=([org.springframework.core.SortedProperties], java.util.Properties), cast-from-var3937-to-var2039=([java.io.ByteArrayOutputStream], java.io.OutputStream), toString/-372517094=([java.io.ByteArrayOutputStream, java.nio.charset.Charset], java.lang.String)}
; {var2499=org.springframework.core.SortedProperties, var2906=r1, var2039=java.io.OutputStream, var1728=r6, var2021=r2, var3431=null_type, var3937=java.io.ByteArrayOutputStream, var1296=$r0, var2977=$z0, var1886=$r13, var48=java.util.Properties, var456=java.nio.charset.Charset, var102=java.nio.charset.StandardCharsets, var1797=$r3, var87=$r11, var125=$r4, var2456=$r12, var2293=$i0, var1566=i1}
; {org.springframework.core.SortedProperties=var2499, r1=var2906, java.io.OutputStream=var2039, r6=var1728, r2=var2021, null_type=var3431, java.io.ByteArrayOutputStream=var3937, $r0=var1296, $z0=var2977, $r13=var1886, java.util.Properties=var48, java.nio.charset.Charset=var456, java.nio.charset.StandardCharsets=var102, $r3=var1797, $r11=var87, $r4=var125, $r12=var2456, $i0=var2293, i1=var1566}
;seq <java.io.ByteArrayOutputStream: java.lang.String toString(java.nio.charset.Charset)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @this: org.springframework.core.SortedProperties;	r6 := @parameter0: java.io.OutputStream;	r2 := @parameter1: java.lang.String;	$r0 = new java.io.ByteArrayOutputStream;	specialinvoke $r0.<java.io.ByteArrayOutputStream: void <init>()>();	$z0 = r1.<org.springframework.core.SortedProperties: boolean omitComments>;	if $z0 == 0 goto $r13 = r2;	$r13 = null;	goto [?= specialinvoke r1.<java.util.Properties: void store(java.io.OutputStream,java.lang.String)>($r0, $r13)];	specialinvoke r1.<java.util.Properties: void store(java.io.OutputStream,java.lang.String)>($r0, $r13);	$r3 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset ISO_8859_1>;	$r11 = virtualinvoke $r0.<java.io.ByteArrayOutputStream: java.lang.String toString(java.nio.charset.Charset)>($r3);	$r4 = <org.springframework.core.SortedProperties: java.lang.String EOL>;	$r12 = virtualinvoke $r11.<java.lang.String: java.lang.String[] split(java.lang.String)>($r4);	$i0 = lengthof $r12;	i1 = 0;	if i1 >= $i0 goto return;	return
;block_num 5
(get-model)
