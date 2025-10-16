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

(declare-sort var1136 0)
(declare-sort var3714 0)
(declare-sort var757 0)
(declare-sort var810 0)
(declare-sort var3009 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun tlp/-1510366313 (var810) var757)
(declare-fun cast-from-var1136-to-var810 (var1136) var810)
(declare-fun var757_morphFeatureSpec/-1525671968 (var757) var3009)
(declare-fun morphoSpec/1364860559 (var1136) var3009)
(declare-fun toString/1418588163 (var3009) String)
(declare-const null-var1136 var1136)
(declare-const null-String String)
(declare-const var3336 var1136) ; Statement: r2 := @this: edu.stanford.nlp.parser.lexparser.FrenchTreebankParserParams 
(assert (not (= var3336 null-var1136)))
(declare-const var1836 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1836 null-String)))
; split operation: var1072 = var1836.split(",") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var2187 var757 (tlp/-1510366313 (cast-from-var1136-to-var810 var3336))) ; Statement: $r3 = r2.<edu.stanford.nlp.parser.lexparser.FrenchTreebankParserParams: edu.stanford.nlp.trees.TreebankLanguagePack tlp> 
(define-const var3180 var3009 (var757_morphFeatureSpec/-1525671968 var2187)) ; Statement: $r4 = interfaceinvoke $r3.<edu.stanford.nlp.trees.TreebankLanguagePack: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphFeatureSpec()>() 
(declare-const var3336!1 var1136)
(assert (not (= var3336!1 null-var1136)))
(assert (= (morphoSpec/1364860559 var3336!1) var3180)) ; Statement: r2.<edu.stanford.nlp.parser.lexparser.FrenchTreebankParserParams: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphoSpec> = $r4 
(define-const var3831 Int (get_split_length var1836 "," -1)) ; Statement: i0 = lengthof r1 
(define-const var208 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r5 = r2.<edu.stanford.nlp.parser.lexparser.FrenchTreebankParserParams: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphoSpec> 
(assert (>= var208 var3831)) ; Cond: i1 >= i0 
(define-const var1338 var3009 (morphoSpec/1364860559 var3336!1)) ; Statement: $r5 = r2.<edu.stanford.nlp.parser.lexparser.FrenchTreebankParserParams: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphoSpec> 
(assert true)
(define-const var2971 String (toString/1418588163 var1338)) ; Statement: $r6 = virtualinvoke $r5.<edu.stanford.nlp.international.morph.MorphoFeatureSpecification: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {tlp/-1510366313=([edu.stanford.nlp.parser.lexparser.AbstractTreebankParserParams], edu.stanford.nlp.trees.TreebankLanguagePack), cast-from-var1136-to-var810=([edu.stanford.nlp.parser.lexparser.FrenchTreebankParserParams], edu.stanford.nlp.parser.lexparser.AbstractTreebankParserParams), var757_morphFeatureSpec/-1525671968=([edu.stanford.nlp.trees.TreebankLanguagePack], edu.stanford.nlp.international.morph.MorphoFeatureSpecification), morphoSpec/1364860559=([edu.stanford.nlp.parser.lexparser.FrenchTreebankParserParams], edu.stanford.nlp.international.morph.MorphoFeatureSpecification), toString/1418588163=([edu.stanford.nlp.international.morph.MorphoFeatureSpecification], java.lang.String)}
; {var1136=edu.stanford.nlp.parser.lexparser.FrenchTreebankParserParams, var3336=r2, var1836=r0, var3714=null_type, var1072=r1, var757=edu.stanford.nlp.trees.TreebankLanguagePack, var810=edu.stanford.nlp.parser.lexparser.AbstractTreebankParserParams, var2187=$r3, var3009=edu.stanford.nlp.international.morph.MorphoFeatureSpecification, var3180=$r4, var3831=i0, var208=i1, var1338=$r5, var2971=$r6}
; {edu.stanford.nlp.parser.lexparser.FrenchTreebankParserParams=var1136, r2=var3336, r0=var1836, null_type=var3714, r1=var1072, edu.stanford.nlp.trees.TreebankLanguagePack=var757, edu.stanford.nlp.parser.lexparser.AbstractTreebankParserParams=var810, $r3=var2187, edu.stanford.nlp.international.morph.MorphoFeatureSpecification=var3009, $r4=var3180, i0=var3831, i1=var208, $r5=var1338, $r6=var2971}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<edu.stanford.nlp.international.morph.MorphoFeatureSpecification: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r2 := @this: edu.stanford.nlp.parser.lexparser.FrenchTreebankParserParams;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r3 = r2.<edu.stanford.nlp.parser.lexparser.FrenchTreebankParserParams: edu.stanford.nlp.trees.TreebankLanguagePack tlp>;	$r4 = interfaceinvoke $r3.<edu.stanford.nlp.trees.TreebankLanguagePack: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphFeatureSpec()>();	r2.<edu.stanford.nlp.parser.lexparser.FrenchTreebankParserParams: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphoSpec> = $r4;	i0 = lengthof r1;	i1 = 0;	if i1 >= i0 goto $r5 = r2.<edu.stanford.nlp.parser.lexparser.FrenchTreebankParserParams: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphoSpec>;	$r5 = r2.<edu.stanford.nlp.parser.lexparser.FrenchTreebankParserParams: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphoSpec>;	$r6 = virtualinvoke $r5.<edu.stanford.nlp.international.morph.MorphoFeatureSpecification: java.lang.String toString()>();	return $r6
;block_num 3
(get-model)
