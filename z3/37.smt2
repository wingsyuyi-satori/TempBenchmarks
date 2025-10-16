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

(declare-sort var1021 0)
(declare-sort var2188 0)
(declare-sort var2387 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2188-init () var2188)
(declare-fun <init>/-1102441200 (var2188) void)
(declare-fun readLine/150542008 (var1021) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun var2387-init () var2387)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1084991535 (var2387 String) void)
(declare-const null-var1021 var1021)
(declare-const var818 var1021) ; Statement: r1 := @parameter0: java.io.BufferedReader 
(assert (not (= var818 null-var1021)))
(define-const var401 var2188 var2188-init) ; Statement: $r43 = new edu.stanford.nlp.pipeline.AnnotationSerializer$IntermediateSemanticGraph 
(assert true)
;(assert (<init>/-1102441200 var401)) ; Statement: specialinvoke $r43.<edu.stanford.nlp.pipeline.AnnotationSerializer$IntermediateSemanticGraph: void <init>()>() 

(declare-const var401!1 var2188)
(assert true)
(define-const var115 String (readLine/150542008 var818)) ; Statement: $r2 = virtualinvoke r1.<java.io.BufferedReader: java.lang.String readLine()>() 
(assert true)
(define-const var3643 String (trim/-847153721 var115)) ; Statement: r31 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>() 
(assert true)
(define-const var2140 Int (length/-134980193 var3643)) ; Statement: $i0 = virtualinvoke r31.<java.lang.String: int length()>() 
 ; Statement: if $i0 <= 0 goto $r3 = virtualinvoke r1.<java.io.BufferedReader: java.lang.String readLine()>() 
(assert (not (<= var2140 0))) ; Negate: Cond: $i0 <= 0  
; split operation: var1648 = var3643.split("\t") ; Statement: r32 = virtualinvoke r31.<java.lang.String: java.lang.String[] split(java.lang.String)>("\t") 
(define-const var105 Int (get_split_length var3643 "\t" -1)) ; Statement: $i8 = lengthof r32 
 ; Statement: if $i8 >= 3 goto r33 = r32[0] 
(assert (not (>= var105 3))) ; Negate: Cond: $i8 >= 3  
(define-const var2659 var2387 var2387-init) ; Statement: $r45 = new java.lang.RuntimeException 
(define-const var2874 String String-init) ; Statement: $r44 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2874)) ; Statement: specialinvoke $r44.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2874!1 String)
(assert (= var2874!1 ""))
(assert true)
(define-const var3784 String (append/672562846 var2874!1 "ERROR: Invalid dependency node line: ")) ; Statement: $r28 = virtualinvoke $r44.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ERROR: Invalid dependency node line: ") 
(declare-const var2874!2 String)
(assert (= var2874!2 (str.++ var2874!1 "ERROR: Invalid dependency node line: ")))
(assert true)
(define-const var2433 String (append/672562846 var3784 var3643)) ; Statement: $r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r31) 
(declare-const var3784!1 String)
(assert (= var3784!1 (str.++ var3784 var3643)))
(assert true)
(define-const var420 String (toString/-2075883882 var2433)) ; Statement: $r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1084991535 var2659 var420)) ; Statement: specialinvoke $r45.<java.lang.RuntimeException: void <init>(java.lang.String)>($r30) 

(declare-const var2659!1 var2387)
(declare-const var420!1 String)
 ; Statement: throw $r45 
(check-sat)
; {var2188-init=([], edu.stanford.nlp.pipeline.AnnotationSerializer$IntermediateSemanticGraph), <init>/-1102441200=([edu.stanford.nlp.pipeline.AnnotationSerializer$IntermediateSemanticGraph], void), readLine/150542008=([java.io.BufferedReader], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String), length/-134980193=([java.lang.String], int), var2387-init=([], java.lang.RuntimeException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1084991535=([java.lang.RuntimeException, java.lang.String], void)}
; {var1021=java.io.BufferedReader, var818=r1, var2188=edu.stanford.nlp.pipeline.AnnotationSerializer$IntermediateSemanticGraph, var401=$r43, var115=$r2, var3643=r31, var2140=$i0, var1648=r32, var105=$i8, var2387=java.lang.RuntimeException, var2659=$r45, var2874=$r44, var3784=$r28, var2433=$r29, var420=$r30}
; {java.io.BufferedReader=var1021, r1=var818, edu.stanford.nlp.pipeline.AnnotationSerializer$IntermediateSemanticGraph=var2188, $r43=var401, $r2=var115, r31=var3643, $i0=var2140, r32=var1648, $i8=var105, java.lang.RuntimeException=var2387, $r45=var2659, $r44=var2874, $r28=var3784, $r29=var2433, $r30=var420}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: int length()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.io.BufferedReader;	$r43 = new edu.stanford.nlp.pipeline.AnnotationSerializer$IntermediateSemanticGraph;	specialinvoke $r43.<edu.stanford.nlp.pipeline.AnnotationSerializer$IntermediateSemanticGraph: void <init>()>();	$r2 = virtualinvoke r1.<java.io.BufferedReader: java.lang.String readLine()>();	r31 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>();	$i0 = virtualinvoke r31.<java.lang.String: int length()>();	if $i0 <= 0 goto $r3 = virtualinvoke r1.<java.io.BufferedReader: java.lang.String readLine()>();	r32 = virtualinvoke r31.<java.lang.String: java.lang.String[] split(java.lang.String)>("\t");	$i8 = lengthof r32;	if $i8 >= 3 goto r33 = r32[0];	$r45 = new java.lang.RuntimeException;	$r44 = new java.lang.StringBuilder;	specialinvoke $r44.<java.lang.StringBuilder: void <init>()>();	$r28 = virtualinvoke $r44.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ERROR: Invalid dependency node line: ");	$r29 = virtualinvoke $r28.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r31);	$r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r45.<java.lang.RuntimeException: void <init>(java.lang.String)>($r30);	throw $r45
;block_num 3
(get-model)
