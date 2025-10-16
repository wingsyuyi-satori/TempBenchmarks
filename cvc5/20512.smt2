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

(declare-sort var3763 0)
(declare-sort var1099 0)
(declare-sort var2182 0)
(declare-sort var3356 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2182!class ClassObject)
(declare-const var3356!class ClassObject)
(declare-fun var1099_fillOptions/-926000568 (ClassObject var3763) void)
(declare-const null-var3763 var3763)
(declare-const var2182-ignoreRels String)
(declare-const var2182-allowedTagsForTrigger String)
(declare-const var2374 var3763) ; Statement: r0 := @parameter0: java.util.Properties 
(assert (not (= var2374 null-var3763)))
;(assert (var1099_fillOptions/-926000568 var2182!class var2374)) ; Statement: staticinvoke <edu.stanford.nlp.util.ArgumentParser: void fillOptions(java.lang.Class,java.util.Properties)>(class "Ledu/stanford/nlp/patterns/dep/DepPatternFactory;", r0) 

(declare-const var3951 ClassObject)
(declare-const var2374!1 var3763)
;(assert (var1099_fillOptions/-926000568 var3356!class var2374!1)) ; Statement: staticinvoke <edu.stanford.nlp.util.ArgumentParser: void fillOptions(java.lang.Class,java.util.Properties)>(class "Ledu/stanford/nlp/patterns/PatternFactory;", r0) 

(declare-const var941 ClassObject)
(declare-const var2374!2 var3763)
(define-const var527 String var2182-ignoreRels) ; Statement: $r1 = <edu.stanford.nlp.patterns.dep.DepPatternFactory: java.lang.String ignoreRels> 
; split operation: var1788 = var527.split("[,;]") ; Statement: r7 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("[,;]") 
(define-const var2137 Int (get_split_length var527 "[,;]" -1)) ; Statement: i0 = lengthof r7 
(define-const var3780 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r2 = <edu.stanford.nlp.patterns.dep.DepPatternFactory: java.lang.String allowedTagsForTrigger> 
(assert (>= var3780 var2137)) ; Cond: i1 >= i0 
(define-const var2432 String var2182-allowedTagsForTrigger) ; Statement: $r2 = <edu.stanford.nlp.patterns.dep.DepPatternFactory: java.lang.String allowedTagsForTrigger> 
; split operation: var999 = var2432.split("[,;]") ; Statement: r9 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("[,;]") 
(define-const var3485 Int (get_split_length var2432 "[,;]" -1)) ; Statement: i2 = lengthof r9 
(define-const var1395 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i2 goto return 
(assert (>= var1395 var3485)) ; Cond: i3 >= i2 
 ; Statement: return 
(check-sat)
; {var1099_fillOptions/-926000568=([java.lang.Class, java.util.Properties], void)}
; {var3763=java.util.Properties, var2374=r0, var1099=edu.stanford.nlp.util.ArgumentParser, var2182=edu.stanford.nlp.patterns.dep.DepPatternFactory, var3951=class "Ledu/stanford/nlp/patterns/dep/DepPatternFactory;", var3356=edu.stanford.nlp.patterns.PatternFactory, var941=class "Ledu/stanford/nlp/patterns/PatternFactory;", var527=$r1, var1788=r7, var2137=i0, var3780=i1, var2432=$r2, var999=r9, var3485=i2, var1395=i3}
; {java.util.Properties=var3763, r0=var2374, edu.stanford.nlp.util.ArgumentParser=var1099, edu.stanford.nlp.patterns.dep.DepPatternFactory=var2182, class "Ledu/stanford/nlp/patterns/dep/DepPatternFactory;"=var3951, edu.stanford.nlp.patterns.PatternFactory=var3356, class "Ledu/stanford/nlp/patterns/PatternFactory;"=var941, $r1=var527, r7=var1788, i0=var2137, i1=var3780, $r2=var2432, r9=var999, i2=var3485, i3=var1395}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r0 := @parameter0: java.util.Properties;	staticinvoke <edu.stanford.nlp.util.ArgumentParser: void fillOptions(java.lang.Class,java.util.Properties)>(class "Ledu/stanford/nlp/patterns/dep/DepPatternFactory;", r0);	staticinvoke <edu.stanford.nlp.util.ArgumentParser: void fillOptions(java.lang.Class,java.util.Properties)>(class "Ledu/stanford/nlp/patterns/PatternFactory;", r0);	$r1 = <edu.stanford.nlp.patterns.dep.DepPatternFactory: java.lang.String ignoreRels>;	r7 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("[,;]");	i0 = lengthof r7;	i1 = 0;	if i1 >= i0 goto $r2 = <edu.stanford.nlp.patterns.dep.DepPatternFactory: java.lang.String allowedTagsForTrigger>;	$r2 = <edu.stanford.nlp.patterns.dep.DepPatternFactory: java.lang.String allowedTagsForTrigger>;	r9 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("[,;]");	i2 = lengthof r9;	i3 = 0;	if i3 >= i2 goto return;	return
;block_num 5
(get-model)
