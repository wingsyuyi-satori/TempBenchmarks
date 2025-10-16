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

(declare-sort var897 0)
(declare-sort var2606 0)
(declare-sort var1391 0)
(declare-sort var992 0)
(declare-sort var2616 0)
(declare-sort var1378 0)
(declare-sort var620 0)
(declare-sort var2240 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun compress/-1175557387 (var897) Bool)
(declare-fun var1391-init () var1391)
(declare-fun var992-init () var992)
(declare-fun <init>/393586270 (var992 var2606) void)
(declare-fun <init>/30097470 (var1391 var2616) void)
(declare-fun cast-from-var992-to-var2616 (var992) var2616)
(declare-fun var1378-init () var1378)
(declare-fun <init>/1337065752 (var1378 String) void)
(declare-fun var897_loadCorefChains/169242915 (var1391) var620)
(declare-fun readLine/150542008 (var1391) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun var2240-init () var2240)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1253962986 (var2240 String) void)
(declare-const null-var897 var897)
(declare-const null-var2606 var2606)
(declare-const null-var620 var620)
(declare-const var2343 var897) ; Statement: r0 := @this: edu.stanford.nlp.pipeline.CustomAnnotationSerializer 
(assert (not (= var2343 null-var897)))
(declare-const var1252 var2606) ; Statement: r30 := @parameter0: java.io.InputStream 
(assert (not (= var1252 null-var2606)))
(define-const var796 Bool (compress/-1175557387 var2343)) ; Statement: $z0 = r0.<edu.stanford.nlp.pipeline.CustomAnnotationSerializer: boolean compress> 
 ; Statement: if $z0 == 0 goto $r31 = new java.io.BufferedReader 
(assert (= (ite var796 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1387 var1391 var1391-init) ; Statement: $r31 = new java.io.BufferedReader 
(define-const var943 var992 var992-init) ; Statement: $r32 = new java.io.InputStreamReader 
(assert true)
;(assert (<init>/393586270 var943 var1252)) ; Statement: specialinvoke $r32.<java.io.InputStreamReader: void <init>(java.io.InputStream)>(r30) 

(declare-const var943!1 var992)
(declare-const var1252!1 var2606)
(assert true)
;(assert (<init>/30097470 var1387 (cast-from-var992-to-var2616 var943!1))) ; Statement: specialinvoke $r31.<java.io.BufferedReader: void <init>(java.io.Reader)>($r32) 

(declare-const var1387!1 var1391)
(declare-const var943!2 var992)
(define-const var3286 var1378 var1378-init) ; Statement: $r33 = new edu.stanford.nlp.pipeline.Annotation 
(assert true)
;(assert (<init>/1337065752 var3286 "")) ; Statement: specialinvoke $r33.<edu.stanford.nlp.pipeline.Annotation: void <init>(java.lang.String)>("") 

(declare-const var3286!1 var1378)
(declare-const var249 String)
(define-const var485 var620 (var897_loadCorefChains/169242915 var1387!1)) ; Statement: $r34 = staticinvoke <edu.stanford.nlp.pipeline.CustomAnnotationSerializer: java.util.Map loadCorefChains(java.io.BufferedReader)>($r31) 
 ; Statement: if $r34 == null goto $r1 = virtualinvoke $r31.<java.io.BufferedReader: java.lang.String readLine()>() 
(assert (= var485 null-var620)) ; Cond: $r34 == null 
(assert true)
(define-const var595 String (readLine/150542008 var1387!1)) ; Statement: $r1 = virtualinvoke $r31.<java.io.BufferedReader: java.lang.String readLine()>() 
(assert true)
(define-const var2922 String (trim/-847153721 var595)) ; Statement: $r28 = virtualinvoke $r1.<java.lang.String: java.lang.String trim()>() 
(assert true)
(define-const var2179 Int (length/-134980193 var2922)) ; Statement: $i0 = virtualinvoke $r28.<java.lang.String: int length()>() 
 ; Statement: if $i0 <= 0 goto $r2 = new java.util.ArrayList 
(assert (not (<= var2179 0))) ; Negate: Cond: $i0 <= 0  
; split operation: var453 = var2922.split(" ") ; Statement: r35 = virtualinvoke $r28.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ") 
(define-const var3584 Int (get_split_length var2922 " " -1)) ; Statement: $i2 = lengthof r35 
(define-const var75 Int (mod var3584 4)) ; Statement: $i3 = $i2 % 4 
 ; Statement: if $i3 == 0 goto $r15 = new java.util.ArrayList 
(assert (not (= var75 0))) ; Negate: Cond: $i3 == 0  
(define-const var515 var2240 var2240-init) ; Statement: $r23 = new edu.stanford.nlp.io.RuntimeIOException 
(define-const var1921 String String-init) ; Statement: $r24 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1921)) ; Statement: specialinvoke $r24.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1921!1 String)
(assert (= var1921!1 ""))
(assert true)
(define-const var1630 String (append/672562846 var1921!1 "ERROR: Incorrect format for the serialized coref graph: ")) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ERROR: Incorrect format for the serialized coref graph: ") 
(declare-const var1921!2 String)
(assert (= var1921!2 (str.++ var1921!1 "ERROR: Incorrect format for the serialized coref graph: ")))
(assert true)
(define-const var1848 String (append/672562846 var1630 var2922)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r28) 
(declare-const var1630!1 String)
(assert (= var1630!1 (str.++ var1630 var2922)))
(assert true)
(define-const var3416 String (toString/-2075883882 var1848)) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1253962986 var515 var3416)) ; Statement: specialinvoke $r23.<edu.stanford.nlp.io.RuntimeIOException: void <init>(java.lang.String)>($r27) 

(declare-const var515!1 var2240)
(declare-const var3416!1 String)
 ; Statement: throw $r23 
(check-sat)
; {compress/-1175557387=([edu.stanford.nlp.pipeline.CustomAnnotationSerializer], boolean), var1391-init=([], java.io.BufferedReader), var992-init=([], java.io.InputStreamReader), <init>/393586270=([java.io.InputStreamReader, java.io.InputStream], void), <init>/30097470=([java.io.BufferedReader, java.io.Reader], void), cast-from-var992-to-var2616=([java.io.InputStreamReader], java.io.Reader), var1378-init=([], edu.stanford.nlp.pipeline.Annotation), <init>/1337065752=([edu.stanford.nlp.pipeline.Annotation, java.lang.String], void), var897_loadCorefChains/169242915=([java.io.BufferedReader], java.util.Map), readLine/150542008=([java.io.BufferedReader], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String), length/-134980193=([java.lang.String], int), var2240-init=([], edu.stanford.nlp.io.RuntimeIOException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1253962986=([edu.stanford.nlp.io.RuntimeIOException, java.lang.String], void)}
; {var897=edu.stanford.nlp.pipeline.CustomAnnotationSerializer, var2343=r0, var2606=java.io.InputStream, var1252=r30, var796=$z0, var1391=java.io.BufferedReader, var1387=$r31, var992=java.io.InputStreamReader, var943=$r32, var2616=java.io.Reader, var1378=edu.stanford.nlp.pipeline.Annotation, var3286=$r33, var249="", var620=java.util.Map, var485=$r34, var595=$r1, var2922=$r28, var2179=$i0, var453=r35, var3584=$i2, var75=$i3, var2240=edu.stanford.nlp.io.RuntimeIOException, var515=$r23, var1921=$r24, var1630=$r25, var1848=$r26, var3416=$r27}
; {edu.stanford.nlp.pipeline.CustomAnnotationSerializer=var897, r0=var2343, java.io.InputStream=var2606, r30=var1252, $z0=var796, java.io.BufferedReader=var1391, $r31=var1387, java.io.InputStreamReader=var992, $r32=var943, java.io.Reader=var2616, edu.stanford.nlp.pipeline.Annotation=var1378, $r33=var3286, ""=var249, java.util.Map=var620, $r34=var485, $r1=var595, $r28=var2922, $i0=var2179, r35=var453, $i2=var3584, $i3=var75, edu.stanford.nlp.io.RuntimeIOException=var2240, $r23=var515, $r24=var1921, $r25=var1630, $r26=var1848, $r27=var3416}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: int length()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: edu.stanford.nlp.pipeline.CustomAnnotationSerializer;	r30 := @parameter0: java.io.InputStream;	$z0 = r0.<edu.stanford.nlp.pipeline.CustomAnnotationSerializer: boolean compress>;	if $z0 == 0 goto $r31 = new java.io.BufferedReader;	$r31 = new java.io.BufferedReader;	$r32 = new java.io.InputStreamReader;	specialinvoke $r32.<java.io.InputStreamReader: void <init>(java.io.InputStream)>(r30);	specialinvoke $r31.<java.io.BufferedReader: void <init>(java.io.Reader)>($r32);	$r33 = new edu.stanford.nlp.pipeline.Annotation;	specialinvoke $r33.<edu.stanford.nlp.pipeline.Annotation: void <init>(java.lang.String)>("");	$r34 = staticinvoke <edu.stanford.nlp.pipeline.CustomAnnotationSerializer: java.util.Map loadCorefChains(java.io.BufferedReader)>($r31);	if $r34 == null goto $r1 = virtualinvoke $r31.<java.io.BufferedReader: java.lang.String readLine()>();	$r1 = virtualinvoke $r31.<java.io.BufferedReader: java.lang.String readLine()>();	$r28 = virtualinvoke $r1.<java.lang.String: java.lang.String trim()>();	$i0 = virtualinvoke $r28.<java.lang.String: int length()>();	if $i0 <= 0 goto $r2 = new java.util.ArrayList;	r35 = virtualinvoke $r28.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	$i2 = lengthof r35;	$i3 = $i2 % 4;	if $i3 == 0 goto $r15 = new java.util.ArrayList;	$r23 = new edu.stanford.nlp.io.RuntimeIOException;	$r24 = new java.lang.StringBuilder;	specialinvoke $r24.<java.lang.StringBuilder: void <init>()>();	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ERROR: Incorrect format for the serialized coref graph: ");	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r28);	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r23.<edu.stanford.nlp.io.RuntimeIOException: void <init>(java.lang.String)>($r27);	throw $r23
;block_num 5
(get-model)
