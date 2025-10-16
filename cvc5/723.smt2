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

(declare-sort var1938 0)
(declare-sort var3446 0)
(declare-sort var2949 0)
(declare-sort var2962 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2949-init () var2949)
(declare-fun <init>/598147663 (var2949) void)
(declare-fun var2962-init () var2962)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1253962986 (var2962 String) void)
(declare-const null-var1938 var1938)
(declare-const null-String String)
(declare-const var3233 var1938) ; Statement: r3 := @this: edu.stanford.nlp.sequences.CoNLLDocumentReaderAndWriter 
(assert (not (= var3233 null-var1938)))
(declare-const var1985 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1985 null-String)))
(define-const var861 var2949 var2949-init) ; Statement: $r0 = new edu.stanford.nlp.ling.CoreLabel 
(assert true)
;(assert (<init>/598147663 var861)) ; Statement: specialinvoke $r0.<edu.stanford.nlp.ling.CoreLabel: void <init>()>() 

(declare-const var861!1 var2949)
; split operation: var1478 = var1985.split("\u005cs+") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var2950 Int (get_split_length var1985 "\u005cs+" -1)) ; Statement: $i0 = lengthof r2 
 ; Statement: tableswitch($i0) {     case 0: goto virtualinvoke $r0.<edu.stanford.nlp.ling.CoreLabel: void setWord(java.lang.String)>("*BOUNDARY*");     case 1: goto virtualinvoke $r0.<edu.stanford.nlp.ling.CoreLabel: void setWord(java.lang.String)>("*BOUNDARY*");     case 2: goto $r18 = r2[0];     case 3: goto $r15 = r2[0];     case 4: goto $r11 = r2[0];     case 5: goto $r4 = r3.<edu.stanford.nlp.sequences.CoNLLDocumentReaderAndWriter: edu.stanford.nlp.sequences.SeqClassifierFlags flags>;     default: goto $r22 = new edu.stanford.nlp.io.RuntimeIOException; } 
(assert (and (not (= var2950 5)) (and (not (= var2950 4)) (and (not (= var2950 3)) (and (not (= var2950 2)) (and (not (= var2950 1)) (and (not (= var2950 0)) true))))))) ; Intersect: Negate: Cond: $i0 == 5   and Intersect: Negate: Cond: $i0 == 4   and Intersect: Negate: Cond: $i0 == 3   and Intersect: Negate: Cond: $i0 == 2   and Intersect: Negate: Cond: $i0 == 1   and Intersect: Negate: Cond: $i0 == 0   and Non Conditional      
(define-const var1120 var2962 var2962-init) ; Statement: $r22 = new edu.stanford.nlp.io.RuntimeIOException 
(define-const var1425 String String-init) ; Statement: $r23 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1425)) ; Statement: specialinvoke $r23.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1425!1 String)
(assert (= var1425!1 ""))
(assert true)
(define-const var3499 String (append/672562846 var1425!1 "Unexpected input (many fields): ")) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unexpected input (many fields): ") 
(declare-const var1425!2 String)
(assert (= var1425!2 (str.++ var1425!1 "Unexpected input (many fields): ")))
(assert true)
(define-const var156 String (append/672562846 var3499 var1985)) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var3499!1 String)
(assert (= var3499!1 (str.++ var3499 var1985)))
(assert true)
(define-const var1315 String (toString/-2075883882 var156)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1253962986 var1120 var1315)) ; Statement: specialinvoke $r22.<edu.stanford.nlp.io.RuntimeIOException: void <init>(java.lang.String)>($r26) 

(declare-const var1120!1 var2962)
(declare-const var1315!1 String)
 ; Statement: throw $r22 
(check-sat)
; {var2949-init=([], edu.stanford.nlp.ling.CoreLabel), <init>/598147663=([edu.stanford.nlp.ling.CoreLabel], void), var2962-init=([], edu.stanford.nlp.io.RuntimeIOException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1253962986=([edu.stanford.nlp.io.RuntimeIOException, java.lang.String], void)}
; {var1938=edu.stanford.nlp.sequences.CoNLLDocumentReaderAndWriter, var3233=r3, var1985=r1, var3446=null_type, var2949=edu.stanford.nlp.ling.CoreLabel, var861=$r0, var1478=r2, var2950=$i0, var2962=edu.stanford.nlp.io.RuntimeIOException, var1120=$r22, var1425=$r23, var3499=$r24, var156=$r25, var1315=$r26}
; {edu.stanford.nlp.sequences.CoNLLDocumentReaderAndWriter=var1938, r3=var3233, r1=var1985, null_type=var3446, edu.stanford.nlp.ling.CoreLabel=var2949, $r0=var861, r2=var1478, $i0=var2950, edu.stanford.nlp.io.RuntimeIOException=var2962, $r22=var1120, $r23=var1425, $r24=var3499, $r25=var156, $r26=var1315}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: edu.stanford.nlp.sequences.CoNLLDocumentReaderAndWriter;	r1 := @parameter0: java.lang.String;	$r0 = new edu.stanford.nlp.ling.CoreLabel;	specialinvoke $r0.<edu.stanford.nlp.ling.CoreLabel: void <init>()>();	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$i0 = lengthof r2;	tableswitch($i0) {     case 0: goto virtualinvoke $r0.<edu.stanford.nlp.ling.CoreLabel: void setWord(java.lang.String)>("*BOUNDARY*");     case 1: goto virtualinvoke $r0.<edu.stanford.nlp.ling.CoreLabel: void setWord(java.lang.String)>("*BOUNDARY*");     case 2: goto $r18 = r2[0];     case 3: goto $r15 = r2[0];     case 4: goto $r11 = r2[0];     case 5: goto $r4 = r3.<edu.stanford.nlp.sequences.CoNLLDocumentReaderAndWriter: edu.stanford.nlp.sequences.SeqClassifierFlags flags>;     default: goto $r22 = new edu.stanford.nlp.io.RuntimeIOException; };	$r22 = new edu.stanford.nlp.io.RuntimeIOException;	$r23 = new java.lang.StringBuilder;	specialinvoke $r23.<java.lang.StringBuilder: void <init>()>();	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Unexpected input (many fields): ");	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r22.<edu.stanford.nlp.io.RuntimeIOException: void <init>(java.lang.String)>($r26);	throw $r22
;block_num 2
(get-model)
