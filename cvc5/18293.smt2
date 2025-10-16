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

(declare-sort var2617 0)
(declare-sort var3093 0)
(declare-sort var913 0)
(declare-sort var3572 0)
(declare-sort var2112 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun toLowerCase/415700667 ((s String)) String (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all s "A" "a") "B" "b") "C" "c") "D" "d") "E" "e") "F" "f") "G" "g") "H" "h") "I" "i") "J" "j") "K" "k") "L" "l") "M" "m") "N" "n") "O" "o") "P" "p") "Q" "q") "R" "r") "S" "s") "T" "t") "U" "u") "V" "v") "W" "w") "X" "x") "Y" "y") "Z" "z"))
(declare-fun isActive/1224434730 (var2112 var3572) Bool)
(declare-fun cast-from-var2617-to-var2112 (var2617) var2112)
(declare-const null-var2617 var2617)
(declare-const null-var3093 var3093)
(declare-const null-String String)
(declare-const var3572-GEN var3572)
(declare-const var3572-PER var3572)
(declare-const var3572-NUM var3572)
(declare-const var2829 var2617) ; Statement: r2 := @this: edu.stanford.nlp.international.french.FrenchMorphoFeatureSpecification 
(assert (not (= var2829 null-var2617)))
(declare-const var114 var3093) ; Statement: r3 := @parameter0: edu.stanford.nlp.international.morph.MorphoFeatures 
(assert (not (= var114 null-var3093)))
(declare-const var425 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var425 null-String)))
; split operation: var251 = var425.split("\u005c-+") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\-+") 
(define-const var3680 Int (get_split_length var425 "\u005c-+" -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 != 3 goto $i1 = lengthof r1 
(assert (not (= var3680 3))) ; Cond: $i0 != 3 
(define-const var3714 Int (get_split_length var425 "\u005c-+" -1)) ; Statement: $i1 = lengthof r1 
(define-const var916 Int (- var3714 1)) ; Statement: $i2 = $i1 - 1 
(define-const var1072 String (get_split_element var425 "\u005c-+" -1 var916)) ; Statement: r27 = r1[$i2] 
(assert true) ; Non Conditional
(assert true)
(define-const var2057 String (toLowerCase/415700667 var1072)) ; Statement: $r28 = virtualinvoke r27.<java.lang.String: java.lang.String toLowerCase()>() 
(define-const var583 var3572 var3572-GEN) ; Statement: $r29 = <edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType: edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType GEN> 
(assert true)
(define-const var8 Bool (isActive/1224434730 (cast-from-var2617-to-var2112 var2829) var583)) ; Statement: $z9 = virtualinvoke r2.<edu.stanford.nlp.international.french.FrenchMorphoFeatureSpecification: boolean isActive(edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType)>($r29) 
 ; Statement: if $z9 == 0 goto $r30 = <edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType: edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType PER> 
(assert (= (ite var8 1 0) 0)) ; Cond: $z9 == 0 
(define-const var551 var3572 var3572-PER) ; Statement: $r30 = <edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType: edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType PER> 
(assert true)
(define-const var1944 Bool (isActive/1224434730 (cast-from-var2617-to-var2112 var2829) var551)) ; Statement: $z10 = virtualinvoke r2.<edu.stanford.nlp.international.french.FrenchMorphoFeatureSpecification: boolean isActive(edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType)>($r30) 
 ; Statement: if $z10 == 0 goto $r31 = <edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType: edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType NUM> 
(assert (= (ite var1944 1 0) 0)) ; Cond: $z10 == 0 
(define-const var2521 var3572 var3572-NUM) ; Statement: $r31 = <edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType: edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType NUM> 
(assert true)
(define-const var1977 Bool (isActive/1224434730 (cast-from-var2617-to-var2112 var2829) var2521)) ; Statement: $z11 = virtualinvoke r2.<edu.stanford.nlp.international.french.FrenchMorphoFeatureSpecification: boolean isActive(edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType)>($r31) 
 ; Statement: if $z11 == 0 goto return 
(assert (= (ite var1977 1 0) 0)) ; Cond: $z11 == 0 
 ; Statement: return 
(check-sat)
; {toLowerCase/415700667=([java.lang.String], java.lang.String), isActive/1224434730=([edu.stanford.nlp.international.morph.MorphoFeatureSpecification, edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType], boolean), cast-from-var2617-to-var2112=([edu.stanford.nlp.international.french.FrenchMorphoFeatureSpecification], edu.stanford.nlp.international.morph.MorphoFeatureSpecification)}
; {var2617=edu.stanford.nlp.international.french.FrenchMorphoFeatureSpecification, var2829=r2, var3093=edu.stanford.nlp.international.morph.MorphoFeatures, var114=r3, var425=r0, var913=null_type, var251=r1, var3680=$i0, var3714=$i1, var916=$i2, var1072=r27, var2057=$r28, var3572=edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType, var583=$r29, var2112=edu.stanford.nlp.international.morph.MorphoFeatureSpecification, var8=$z9, var551=$r30, var1944=$z10, var2521=$r31, var1977=$z11}
; {edu.stanford.nlp.international.french.FrenchMorphoFeatureSpecification=var2617, r2=var2829, edu.stanford.nlp.international.morph.MorphoFeatures=var3093, r3=var114, r0=var425, null_type=var913, r1=var251, $i0=var3680, $i1=var3714, $i2=var916, r27=var1072, $r28=var2057, edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType=var3572, $r29=var583, edu.stanford.nlp.international.morph.MorphoFeatureSpecification=var2112, $z9=var8, $r30=var551, $z10=var1944, $r31=var2521, $z11=var1977}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String toLowerCase()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: java.lang.String toLowerCase()>": 1}
;stmts r2 := @this: edu.stanford.nlp.international.french.FrenchMorphoFeatureSpecification;	r3 := @parameter0: edu.stanford.nlp.international.morph.MorphoFeatures;	r0 := @parameter1: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\-+");	$i0 = lengthof r1;	if $i0 != 3 goto $i1 = lengthof r1;	$i1 = lengthof r1;	$i2 = $i1 - 1;	r27 = r1[$i2];	$r28 = virtualinvoke r27.<java.lang.String: java.lang.String toLowerCase()>();	$r29 = <edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType: edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType GEN>;	$z9 = virtualinvoke r2.<edu.stanford.nlp.international.french.FrenchMorphoFeatureSpecification: boolean isActive(edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType)>($r29);	if $z9 == 0 goto $r30 = <edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType: edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType PER>;	$r30 = <edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType: edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType PER>;	$z10 = virtualinvoke r2.<edu.stanford.nlp.international.french.FrenchMorphoFeatureSpecification: boolean isActive(edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType)>($r30);	if $z10 == 0 goto $r31 = <edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType: edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType NUM>;	$r31 = <edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType: edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType NUM>;	$z11 = virtualinvoke r2.<edu.stanford.nlp.international.french.FrenchMorphoFeatureSpecification: boolean isActive(edu.stanford.nlp.international.morph.MorphoFeatureSpecification$MorphoFeatureType)>($r31);	if $z11 == 0 goto return;	return
;block_num 6
(get-model)
