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

(declare-sort var1383 0)
(declare-sort var3968 0)
(declare-sort var1095 0)
(declare-sort var3067 0)
(declare-sort var251 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun tlp/-1510366313 (var3067) var1095)
(declare-fun cast-from-var1383-to-var3067 (var1383) var3067)
(declare-fun var1095_morphFeatureSpec/-1525671968 (var1095) var251)
(declare-fun morphoSpec/-974673759 (var1383) var251)
(declare-fun toString/1418588163 (var251) String)
(declare-const null-var1383 var1383)
(declare-const null-String String)
(declare-const var2468 var1383) ; Statement: r2 := @this: edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams 
(assert (not (= var2468 null-var1383)))
(declare-const var1863 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1863 null-String)))
; split operation: var1352 = var1863.split(",") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var2336 var1095 (tlp/-1510366313 (cast-from-var1383-to-var3067 var2468))) ; Statement: $r3 = r2.<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams: edu.stanford.nlp.trees.TreebankLanguagePack tlp> 
(define-const var452 var251 (var1095_morphFeatureSpec/-1525671968 var2336)) ; Statement: $r4 = interfaceinvoke $r3.<edu.stanford.nlp.trees.TreebankLanguagePack: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphFeatureSpec()>() 
(declare-const var2468!1 var1383)
(assert (not (= var2468!1 null-var1383)))
(assert (= (morphoSpec/-974673759 var2468!1) var452)) ; Statement: r2.<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphoSpec> = $r4 
(define-const var2684 Int (get_split_length var1863 "," -1)) ; Statement: i0 = lengthof r1 
(define-const var3129 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r5 = r2.<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphoSpec> 
(assert (>= var3129 var2684)) ; Cond: i1 >= i0 
(define-const var2704 var251 (morphoSpec/-974673759 var2468!1)) ; Statement: $r5 = r2.<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphoSpec> 
(assert true)
(define-const var1511 String (toString/1418588163 var2704)) ; Statement: $r6 = virtualinvoke $r5.<edu.stanford.nlp.international.morph.MorphoFeatureSpecification: java.lang.String toString()>() 
 ; Statement: return $r6 
(check-sat)
; {tlp/-1510366313=([edu.stanford.nlp.parser.lexparser.AbstractTreebankParserParams], edu.stanford.nlp.trees.TreebankLanguagePack), cast-from-var1383-to-var3067=([edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams], edu.stanford.nlp.parser.lexparser.AbstractTreebankParserParams), var1095_morphFeatureSpec/-1525671968=([edu.stanford.nlp.trees.TreebankLanguagePack], edu.stanford.nlp.international.morph.MorphoFeatureSpecification), morphoSpec/-974673759=([edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams], edu.stanford.nlp.international.morph.MorphoFeatureSpecification), toString/1418588163=([edu.stanford.nlp.international.morph.MorphoFeatureSpecification], java.lang.String)}
; {var1383=edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams, var2468=r2, var1863=r0, var3968=null_type, var1352=r1, var1095=edu.stanford.nlp.trees.TreebankLanguagePack, var3067=edu.stanford.nlp.parser.lexparser.AbstractTreebankParserParams, var2336=$r3, var251=edu.stanford.nlp.international.morph.MorphoFeatureSpecification, var452=$r4, var2684=i0, var3129=i1, var2704=$r5, var1511=$r6}
; {edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams=var1383, r2=var2468, r0=var1863, null_type=var3968, r1=var1352, edu.stanford.nlp.trees.TreebankLanguagePack=var1095, edu.stanford.nlp.parser.lexparser.AbstractTreebankParserParams=var3067, $r3=var2336, edu.stanford.nlp.international.morph.MorphoFeatureSpecification=var251, $r4=var452, i0=var2684, i1=var3129, $r5=var2704, $r6=var1511}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<edu.stanford.nlp.international.morph.MorphoFeatureSpecification: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r2 := @this: edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r3 = r2.<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams: edu.stanford.nlp.trees.TreebankLanguagePack tlp>;	$r4 = interfaceinvoke $r3.<edu.stanford.nlp.trees.TreebankLanguagePack: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphFeatureSpec()>();	r2.<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphoSpec> = $r4;	i0 = lengthof r1;	i1 = 0;	if i1 >= i0 goto $r5 = r2.<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphoSpec>;	$r5 = r2.<edu.stanford.nlp.parser.lexparser.ArabicTreebankParserParams: edu.stanford.nlp.international.morph.MorphoFeatureSpecification morphoSpec>;	$r6 = virtualinvoke $r5.<edu.stanford.nlp.international.morph.MorphoFeatureSpecification: java.lang.String toString()>();	return $r6
;block_num 3
(get-model)
