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

(declare-sort var1264 0)
(declare-sort var72 0)
(declare-sort var1036 0)
(declare-sort var1699 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getOutput/-1207014030 (var72) String)
(declare-fun cast-from-var1264-to-var72 (var1264) var72)
(declare-fun arr-var1699-init () (Array Int var1699))
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun cast-from-String-to-var1699 (String) var1699)
(declare-fun error/-1794152874 (var1036 (Array Int var1699)) void)
(declare-const null-var1264 var1264)
(declare-const var1264-log var1036)
(declare-const null-__Array__Int__var1699__ (Array Int var1699))
(declare-const var3528 var1264) ; Statement: r0 := @this: edu.stanford.nlp.ie.crf.CRFClassifierEvaluator 
(assert (not (= var3528 null-var1264)))
(assert true)
(define-const var3559 String (getOutput/-1207014030 (cast-from-var1264-to-var72 var3528))) ; Statement: r1 = virtualinvoke r0.<edu.stanford.nlp.ie.crf.CRFClassifierEvaluator: java.lang.String getOutput()>() 
; split operation: var2721 = var3559.split("\u005cs+") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var3096 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
(define-const var3996 Int (get_split_length var3559 "\u005cs+" -1)) ; Statement: $i0 = lengthof r2 
 ; Statement: if i2 >= $i0 goto i3 = i2 + 1 
(assert (>= var3096 var3996)) ; Cond: i2 >= $i0 
(define-const var3966 Int (+ var3096 1)) ; Statement: i3 = i2 + 1 
(define-const var964 Int (get_split_length var3559 "\u005cs+" -1)) ; Statement: $i1 = lengthof r2 
 ; Statement: if i3 >= $i1 goto $r5 = <edu.stanford.nlp.ie.crf.CRFClassifierEvaluator: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels log> 
(assert (>= var3966 var964)) ; Cond: i3 >= $i1 
(define-const var850 var1036 var1264-log) ; Statement: $r5 = <edu.stanford.nlp.ie.crf.CRFClassifierEvaluator: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels log> 
(define-const var3825 (Array Int var1699) arr-var1699-init) ; Statement: $r3 = newarray (java.lang.Object)[1] 
(define-const var2212 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2212)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2212!1 String)
(assert (= var2212!1 ""))
(assert true)
(define-const var309 String (append/672562846 var2212!1 "in CRFClassifierEvaluator.interpretCmdOutput(), cannot find FB1 score in output:\n")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("in CRFClassifierEvaluator.interpretCmdOutput(), cannot find FB1 score in output:\n") 
(declare-const var2212!2 String)
(assert (= var2212!2 (str.++ var2212!1 "in CRFClassifierEvaluator.interpretCmdOutput(), cannot find FB1 score in output:\n")))
(assert true)
(define-const var1732 String (append/672562846 var309 var3559)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var309!1 String)
(assert (= var309!1 (str.++ var309 var3559)))
(assert true)
(define-const var3518 String (toString/-2075883882 var1732)) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>() 
(declare-const var3825!1 (Array Int var1699))
(assert (not (= var3825!1 null-__Array__Int__var1699__)))
(assert (= (select var3825!1 0) (cast-from-String-to-var1699 var3518))) ; Statement: $r3[0] = $r8 
(assert true)
;(assert (error/-1794152874 var850 var3825!1)) ; Statement: virtualinvoke $r5.<edu.stanford.nlp.util.logging.Redwood$RedwoodChannels: void error(java.lang.Object[])>($r3) 

(declare-const var850!1 var1036)
(declare-const var3825!2 (Array Int var1699))
 ; Statement: return -1.0 
(check-sat)
; {getOutput/-1207014030=([edu.stanford.nlp.optimization.CmdEvaluator], java.lang.String), cast-from-var1264-to-var72=([edu.stanford.nlp.ie.crf.CRFClassifierEvaluator], edu.stanford.nlp.optimization.CmdEvaluator), arr-var1699-init=([], java.lang.Object[]), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), cast-from-String-to-var1699=([java.lang.String], java.lang.Object), error/-1794152874=([edu.stanford.nlp.util.logging.Redwood$RedwoodChannels, java.lang.Object[]], void)}
; {var1264=edu.stanford.nlp.ie.crf.CRFClassifierEvaluator, var3528=r0, var72=edu.stanford.nlp.optimization.CmdEvaluator, var3559=r1, var2721=r2, var3096=i2, var3996=$i0, var3966=i3, var964=$i1, var1036=edu.stanford.nlp.util.logging.Redwood$RedwoodChannels, var850=$r5, var1699=java.lang.Object, var3825=$r3, var2212=$r4, var309=$r6, var1732=$r7, var3518=$r8}
; {edu.stanford.nlp.ie.crf.CRFClassifierEvaluator=var1264, r0=var3528, edu.stanford.nlp.optimization.CmdEvaluator=var72, r1=var3559, r2=var2721, i2=var3096, $i0=var3996, i3=var3966, $i1=var964, edu.stanford.nlp.util.logging.Redwood$RedwoodChannels=var1036, $r5=var850, java.lang.Object=var1699, $r3=var3825, $r4=var2212, $r6=var309, $r7=var1732, $r8=var3518}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: edu.stanford.nlp.ie.crf.CRFClassifierEvaluator;	r1 = virtualinvoke r0.<edu.stanford.nlp.ie.crf.CRFClassifierEvaluator: java.lang.String getOutput()>();	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	i2 = 0;	$i0 = lengthof r2;	if i2 >= $i0 goto i3 = i2 + 1;	i3 = i2 + 1;	$i1 = lengthof r2;	if i3 >= $i1 goto $r5 = <edu.stanford.nlp.ie.crf.CRFClassifierEvaluator: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels log>;	$r5 = <edu.stanford.nlp.ie.crf.CRFClassifierEvaluator: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels log>;	$r3 = newarray (java.lang.Object)[1];	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("in CRFClassifierEvaluator.interpretCmdOutput(), cannot find FB1 score in output:\n");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.String toString()>();	$r3[0] = $r8;	virtualinvoke $r5.<edu.stanford.nlp.util.logging.Redwood$RedwoodChannels: void error(java.lang.Object[])>($r3);	return -1.0
;block_num 4
(get-model)
