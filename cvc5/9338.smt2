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

(declare-sort var3290 0)
(declare-sort var2910 0)
(declare-sort var1398 0)
(declare-sort var459 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun loadTextClassifier/2023711293 (var1398 var2910) void)
(declare-fun cast-from-var3290-to-var1398 (var3290) var1398)
(declare-fun readLine/150542008 (var2910) String)
(declare-fun var459-init () var459)
(declare-fun <init>/-1084991535 (var459 String) void)
(declare-const null-var3290 var3290)
(declare-const null-var2910 var2910)
(declare-const var1556 var3290) ; Statement: r0 := @this: edu.stanford.nlp.ie.crf.CRFClassifierNonlinear 
(assert (not (= var1556 null-var3290)))
(declare-const var2102 var2910) ; Statement: r1 := @parameter0: java.io.BufferedReader 
(assert (not (= var2102 null-var2910)))
(assert true)
;(assert (loadTextClassifier/2023711293 (cast-from-var3290-to-var1398 var1556) var2102)) ; Statement: specialinvoke r0.<edu.stanford.nlp.ie.crf.CRFClassifier: void loadTextClassifier(java.io.BufferedReader)>(r1) 

(declare-const var1556!1 var3290)
(declare-const var2102!1 var2910)
(assert true)
(define-const var132 String (readLine/150542008 var2102!1)) ; Statement: r83 = virtualinvoke r1.<java.io.BufferedReader: java.lang.String readLine()>() 
; split operation: var1879 = var132.split("\u005ct") ; Statement: r84 = virtualinvoke r83.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\t") 
(define-const var2030 String (get_split_element var132 "\u005ct" -1 0)) ; Statement: $r2 = r84[0] 
(assert true)
(define-const var3491 Bool (= var2030 "nodeFeatureIndicesMap.size()=")) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>("nodeFeatureIndicesMap.size()=") 
 ; Statement: if $z0 != 0 goto $r3 = r84[1] 
(assert (not (not (= (ite var3491 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var3235 var459 var459-init) ; Statement: $r82 = new java.lang.RuntimeException 
(assert true)
;(assert (<init>/-1084991535 var3235 "format error in nodeFeatureIndicesMap")) ; Statement: specialinvoke $r82.<java.lang.RuntimeException: void <init>(java.lang.String)>("format error in nodeFeatureIndicesMap") 

(declare-const var3235!1 var459)
(declare-const var3501 String)
 ; Statement: throw $r82 
(check-sat)
; {loadTextClassifier/2023711293=([edu.stanford.nlp.ie.crf.CRFClassifier, java.io.BufferedReader], void), cast-from-var3290-to-var1398=([edu.stanford.nlp.ie.crf.CRFClassifierNonlinear], edu.stanford.nlp.ie.crf.CRFClassifier), readLine/150542008=([java.io.BufferedReader], java.lang.String), var459-init=([], java.lang.RuntimeException), <init>/-1084991535=([java.lang.RuntimeException, java.lang.String], void)}
; {var3290=edu.stanford.nlp.ie.crf.CRFClassifierNonlinear, var1556=r0, var2910=java.io.BufferedReader, var2102=r1, var1398=edu.stanford.nlp.ie.crf.CRFClassifier, var132=r83, var1879=r84, var2030=$r2, var3491=$z0, var459=java.lang.RuntimeException, var3235=$r82, var3501="format error in nodeFeatureIndicesMap"}
; {edu.stanford.nlp.ie.crf.CRFClassifierNonlinear=var3290, r0=var1556, java.io.BufferedReader=var2910, r1=var2102, edu.stanford.nlp.ie.crf.CRFClassifier=var1398, r83=var132, r84=var1879, $r2=var2030, $z0=var3491, java.lang.RuntimeException=var459, $r82=var3235, "format error in nodeFeatureIndicesMap"=var3501}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @this: edu.stanford.nlp.ie.crf.CRFClassifierNonlinear;	r1 := @parameter0: java.io.BufferedReader;	specialinvoke r0.<edu.stanford.nlp.ie.crf.CRFClassifier: void loadTextClassifier(java.io.BufferedReader)>(r1);	r83 = virtualinvoke r1.<java.io.BufferedReader: java.lang.String readLine()>();	r84 = virtualinvoke r83.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\t");	$r2 = r84[0];	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>("nodeFeatureIndicesMap.size()=");	if $z0 != 0 goto $r3 = r84[1];	$r82 = new java.lang.RuntimeException;	specialinvoke $r82.<java.lang.RuntimeException: void <init>(java.lang.String)>("format error in nodeFeatureIndicesMap");	throw $r82
;block_num 2
(get-model)
