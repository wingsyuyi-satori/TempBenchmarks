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

(declare-sort var3226 0)
(declare-sort var775 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3226-init () var3226)
(declare-fun <init>/248943908 (var3226) void)
(declare-const null-var3226 var3226)
(declare-const null-String String)
(declare-const var1358 var3226) ; Statement: r10 := @this: edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification$ArabicMorphoFeatures 
(assert (not (= var1358 null-var3226)))
(declare-const var2264 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2264 null-String)))
; split operation: var3270 = var2264.split("\u005c-") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\-") 
(define-const var1890 var3226 var3226-init) ; Statement: $r2 = new edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification$ArabicMorphoFeatures 
(assert true)
;(assert (<init>/248943908 var1890)) ; Statement: specialinvoke $r2.<edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification$ArabicMorphoFeatures: void <init>()>() 

(declare-const var1890!1 var3226)
(define-const var1757 Int 1) ; Statement: i2 = 1 
(assert true) ; Non Conditional
(define-const var3268 Int (get_split_length var2264 "\u005c-" -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if i2 >= $i0 goto return $r2 
(assert (>= var1757 var3268)) ; Cond: i2 >= $i0 
 ; Statement: return $r2 
(check-sat)
; {var3226-init=([], edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification$ArabicMorphoFeatures), <init>/248943908=([edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification$ArabicMorphoFeatures], void)}
; {var3226=edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification$ArabicMorphoFeatures, var1358=r10, var2264=r0, var775=null_type, var3270=r1, var1890=$r2, var1757=i2, var3268=$i0}
; {edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification$ArabicMorphoFeatures=var3226, r10=var1358, r0=var2264, null_type=var775, r1=var3270, $r2=var1890, i2=var1757, $i0=var3268}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r10 := @this: edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification$ArabicMorphoFeatures;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\-");	$r2 = new edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification$ArabicMorphoFeatures;	specialinvoke $r2.<edu.stanford.nlp.international.arabic.ArabicMorphoFeatureSpecification$ArabicMorphoFeatures: void <init>()>();	i2 = 1;	$i0 = lengthof r1;	if i2 >= $i0 goto return $r2;	return $r2
;block_num 3
(get-model)
