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

(declare-sort var924 0)
(declare-sort var1128 0)
(declare-sort var2088 0)
(declare-sort var3240 0)
(declare-sort var2286 0)
(declare-sort var1046 0)
(declare-sort var798 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3240-init () var3240)
(declare-fun <init>/-707998177 (var3240) void)
(declare-fun omitComments/-1276310728 (var924) Bool)
(declare-fun store/877702891 (var2286 var1128 String) void)
(declare-fun cast-from-var924-to-var2286 (var924) var2286)
(declare-fun cast-from-var3240-to-var1128 (var3240) var1128)
(declare-fun toString/-372517094 (var3240 var1046) String)
(declare-const null-var924 var924)
(declare-const null-var1128 var1128)
(declare-const null-String String)
(declare-const var798-ISO_8859_1 var1046)
(declare-const var924-EOL String)
(declare-const var2405 var924) ; Statement: r1 := @this: org.springframework.core.SortedProperties 
(assert (not (= var2405 null-var924)))
(declare-const var3477 var1128) ; Statement: r6 := @parameter0: java.io.OutputStream 
(assert (not (= var3477 null-var1128)))
(declare-const var1222 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1222 null-String)))
(define-const var3677 var3240 var3240-init) ; Statement: $r0 = new java.io.ByteArrayOutputStream 
(assert true)
;(assert (<init>/-707998177 var3677)) ; Statement: specialinvoke $r0.<java.io.ByteArrayOutputStream: void <init>()>() 

(declare-const var3677!1 var3240)
(define-const var534 Bool (omitComments/-1276310728 var2405)) ; Statement: $z0 = r1.<org.springframework.core.SortedProperties: boolean omitComments> 
 ; Statement: if $z0 == 0 goto $r13 = r2 
(assert (= (ite var534 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2654 String var1222) ; Statement: $r13 = r2 
(assert true) ; Non Conditional
(assert true)
;(assert (store/877702891 (cast-from-var924-to-var2286 var2405) (cast-from-var3240-to-var1128 var3677!1) var2654)) ; Statement: specialinvoke r1.<java.util.Properties: void store(java.io.OutputStream,java.lang.String)>($r0, $r13) 

(declare-const var2405!1 var924)
(declare-const var3677!2 var3240)
(declare-const var2654!1 String)
(define-const var726 var1046 var798-ISO_8859_1) ; Statement: $r3 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset ISO_8859_1> 
(assert true)
(define-const var890 String (toString/-372517094 var3677!2 var726)) ; Statement: $r11 = virtualinvoke $r0.<java.io.ByteArrayOutputStream: java.lang.String toString(java.nio.charset.Charset)>($r3) 
(define-const var659 String var924-EOL) ; Statement: $r4 = <org.springframework.core.SortedProperties: java.lang.String EOL> 
; split operation: var1071 = var890.split(var659) ; Statement: $r12 = virtualinvoke $r11.<java.lang.String: java.lang.String[] split(java.lang.String)>($r4) 
(define-const var227 Int (get_split_length var890 var659 -1)) ; Statement: $i0 = lengthof $r12 
(define-const var192 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto return 
(assert (>= var192 var227)) ; Cond: i1 >= $i0 
 ; Statement: return 
(check-sat)
; {var3240-init=([], java.io.ByteArrayOutputStream), <init>/-707998177=([java.io.ByteArrayOutputStream], void), omitComments/-1276310728=([org.springframework.core.SortedProperties], boolean), store/877702891=([java.util.Properties, java.io.OutputStream, java.lang.String], void), cast-from-var924-to-var2286=([org.springframework.core.SortedProperties], java.util.Properties), cast-from-var3240-to-var1128=([java.io.ByteArrayOutputStream], java.io.OutputStream), toString/-372517094=([java.io.ByteArrayOutputStream, java.nio.charset.Charset], java.lang.String)}
; {var924=org.springframework.core.SortedProperties, var2405=r1, var1128=java.io.OutputStream, var3477=r6, var1222=r2, var2088=null_type, var3240=java.io.ByteArrayOutputStream, var3677=$r0, var534=$z0, var2654=$r13, var2286=java.util.Properties, var1046=java.nio.charset.Charset, var798=java.nio.charset.StandardCharsets, var726=$r3, var890=$r11, var659=$r4, var1071=$r12, var227=$i0, var192=i1}
; {org.springframework.core.SortedProperties=var924, r1=var2405, java.io.OutputStream=var1128, r6=var3477, r2=var1222, null_type=var2088, java.io.ByteArrayOutputStream=var3240, $r0=var3677, $z0=var534, $r13=var2654, java.util.Properties=var2286, java.nio.charset.Charset=var1046, java.nio.charset.StandardCharsets=var798, $r3=var726, $r11=var890, $r4=var659, $r12=var1071, $i0=var227, i1=var192}
;seq <java.io.ByteArrayOutputStream: java.lang.String toString(java.nio.charset.Charset)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @this: org.springframework.core.SortedProperties;	r6 := @parameter0: java.io.OutputStream;	r2 := @parameter1: java.lang.String;	$r0 = new java.io.ByteArrayOutputStream;	specialinvoke $r0.<java.io.ByteArrayOutputStream: void <init>()>();	$z0 = r1.<org.springframework.core.SortedProperties: boolean omitComments>;	if $z0 == 0 goto $r13 = r2;	$r13 = r2;	specialinvoke r1.<java.util.Properties: void store(java.io.OutputStream,java.lang.String)>($r0, $r13);	$r3 = <java.nio.charset.StandardCharsets: java.nio.charset.Charset ISO_8859_1>;	$r11 = virtualinvoke $r0.<java.io.ByteArrayOutputStream: java.lang.String toString(java.nio.charset.Charset)>($r3);	$r4 = <org.springframework.core.SortedProperties: java.lang.String EOL>;	$r12 = virtualinvoke $r11.<java.lang.String: java.lang.String[] split(java.lang.String)>($r4);	$i0 = lengthof $r12;	i1 = 0;	if i1 >= $i0 goto return;	return
;block_num 5
(get-model)
