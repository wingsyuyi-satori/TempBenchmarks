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

(declare-sort var3242 0)
(declare-sort var2858 0)
(declare-sort var751 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun readLine/150542008 (var2858) String)
(declare-fun var751-init () var751)
(declare-fun <init>/-1084991535 (var751 String) void)
(declare-const null-var3242 var3242)
(declare-const null-var2858 var2858)
(declare-const var3799 var3242) ; Statement: r3 := @this: edu.stanford.nlp.ie.crf.CRFClassifier 
(assert (not (= var3799 null-var3242)))
(declare-const var3484 var2858) ; Statement: r0 := @parameter0: java.io.BufferedReader 
(assert (not (= var3484 null-var2858)))
(assert true)
(define-const var1492 String (readLine/150542008 var3484)) ; Statement: r86 = virtualinvoke r0.<java.io.BufferedReader: java.lang.String readLine()>() 
; split operation: var3925 = var1492.split("\u005ct") ; Statement: r87 = virtualinvoke r86.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\t") 
(define-const var1133 String (get_split_element var1492 "\u005ct" -1 0)) ; Statement: $r1 = r87[0] 
(assert true)
(define-const var2898 Bool (= var1133 "labelIndices.length=")) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("labelIndices.length=") 
 ; Statement: if $z0 != 0 goto $r2 = r87[1] 
(assert (not (not (= (ite var2898 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var2345 var751 var751-init) ; Statement: $r85 = new java.lang.RuntimeException 
(assert true)
;(assert (<init>/-1084991535 var2345 "format error")) ; Statement: specialinvoke $r85.<java.lang.RuntimeException: void <init>(java.lang.String)>("format error") 

(declare-const var2345!1 var751)
(declare-const var3520 String)
 ; Statement: throw $r85 
(check-sat)
; {readLine/150542008=([java.io.BufferedReader], java.lang.String), var751-init=([], java.lang.RuntimeException), <init>/-1084991535=([java.lang.RuntimeException, java.lang.String], void)}
; {var3242=edu.stanford.nlp.ie.crf.CRFClassifier, var3799=r3, var2858=java.io.BufferedReader, var3484=r0, var1492=r86, var3925=r87, var1133=$r1, var2898=$z0, var751=java.lang.RuntimeException, var2345=$r85, var3520="format error"}
; {edu.stanford.nlp.ie.crf.CRFClassifier=var3242, r3=var3799, java.io.BufferedReader=var2858, r0=var3484, r86=var1492, r87=var3925, $r1=var1133, $z0=var2898, java.lang.RuntimeException=var751, $r85=var2345, "format error"=var3520}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r3 := @this: edu.stanford.nlp.ie.crf.CRFClassifier;	r0 := @parameter0: java.io.BufferedReader;	r86 = virtualinvoke r0.<java.io.BufferedReader: java.lang.String readLine()>();	r87 = virtualinvoke r86.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\t");	$r1 = r87[0];	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>("labelIndices.length=");	if $z0 != 0 goto $r2 = r87[1];	$r85 = new java.lang.RuntimeException;	specialinvoke $r85.<java.lang.RuntimeException: void <init>(java.lang.String)>("format error");	throw $r85
;block_num 2
(get-model)
