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

(declare-sort var3829 0)
(declare-sort var2859 0)
(declare-sort var3737 0)
(declare-sort var3726 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun Int_parseInt/1370970945 (String) Int)
(declare-fun mwtTokens/-371264511 (var3829) var3737)
(declare-fun var3737_add/328494887 (var3737 var3726) Bool)
(declare-fun cast-from-String-to-var3726 (String) var3726)
(declare-fun mwtMiscs/-371264511 (var3829) var3737)
(declare-fun mwtLastCoreLabels/-371264511 (var3829) var3737)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun cast-from-Int-to-var3726 (Int) var3726)
(declare-const null-var3829 var3829)
(declare-const null-String String)
(declare-const var3225 var3829) ; Statement: r7 := @this: edu.stanford.nlp.pipeline.CoNLLUReader$CoNLLUSentence 
(assert (not (= var3225 null-var3829)))
(declare-const var1887 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1887 null-String)))
; split operation: var2491 = var1887.split("\t") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\t") 
(define-const var2959 String (get_split_element var1887 "\t" -1 0)) ; Statement: $r2 = r1[0] 
; split operation: var3562 = var2959.split("-") ; Statement: r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("-") 
(define-const var992 String (get_split_element var1887 "\t" -1 1)) ; Statement: r4 = r1[1] 
(define-const var2431 String (get_split_element var2959 "-" -1 0)) ; Statement: $r5 = r3[0] 
(define-const var3362 Int (Int_parseInt/1370970945 var2431)) ; Statement: i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>($r5) 
(define-const var2490 String (get_split_element var2959 "-" -1 1)) ; Statement: $r6 = r3[1] 
(define-const var2605 Int (Int_parseInt/1370970945 var2490)) ; Statement: i1 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>($r6) 
(define-const var1441 Int (- var3362 1)) ; Statement: i4 = i0 - 1 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i1 goto $r8 = r7.<edu.stanford.nlp.pipeline.CoNLLUReader$CoNLLUSentence: java.util.List mwtTokens> 
(assert (>= var1441 var2605)) ; Cond: i4 >= i1 
(define-const var1311 var3737 (mwtTokens/-371264511 var3225)) ; Statement: $r8 = r7.<edu.stanford.nlp.pipeline.CoNLLUReader$CoNLLUSentence: java.util.List mwtTokens> 
;(assert (var3737_add/328494887 var1311 (cast-from-String-to-var3726 var992))) ; Statement: interfaceinvoke $r8.<java.util.List: boolean add(java.lang.Object)>(r4) 

(declare-const var1311!1 var3737)
(declare-const var992!1 String)
(define-const var3121 var3737 (mwtMiscs/-371264511 var3225)) ; Statement: $r10 = r7.<edu.stanford.nlp.pipeline.CoNLLUReader$CoNLLUSentence: java.util.List mwtMiscs> 
(define-const var34 String (get_split_element var1887 "\t" -1 9)) ; Statement: $r9 = r1[9] 
;(assert (var3737_add/328494887 var3121 (cast-from-String-to-var3726 var34))) ; Statement: interfaceinvoke $r10.<java.util.List: boolean add(java.lang.Object)>($r9) 

(declare-const var3121!1 var3737)
(declare-const var34!1 String)
(define-const var1085 var3737 (mwtLastCoreLabels/-371264511 var3225)) ; Statement: $r11 = r7.<edu.stanford.nlp.pipeline.CoNLLUReader$CoNLLUSentence: java.util.List mwtLastCoreLabels> 
(define-const var2764 Int (- var2605 1)) ; Statement: $i2 = i1 - 1 
(define-const var1802 Int (Int_valueOf/-1371140006 var2764)) ; Statement: $r12 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i2) 
;(assert (var3737_add/328494887 var1085 (cast-from-Int-to-var3726 var1802))) ; Statement: interfaceinvoke $r11.<java.util.List: boolean add(java.lang.Object)>($r12) 

(declare-const var1085!1 var3737)
(declare-const var1802!1 Int)
 ; Statement: return 
(check-sat)
; {Int_parseInt/1370970945=([java.lang.String], int), mwtTokens/-371264511=([edu.stanford.nlp.pipeline.CoNLLUReader$CoNLLUSentence], java.util.List), var3737_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-String-to-var3726=([java.lang.String], java.lang.Object), mwtMiscs/-371264511=([edu.stanford.nlp.pipeline.CoNLLUReader$CoNLLUSentence], java.util.List), mwtLastCoreLabels/-371264511=([edu.stanford.nlp.pipeline.CoNLLUReader$CoNLLUSentence], java.util.List), Int_valueOf/-1371140006=([int], java.lang.Integer), cast-from-Int-to-var3726=([java.lang.Integer], java.lang.Object)}
; {var3829=edu.stanford.nlp.pipeline.CoNLLUReader$CoNLLUSentence, var3225=r7, var1887=r0, var2859=null_type, var2491=r1, var2959=$r2, var3562=r3, var992=r4, var2431=$r5, var3362=i0, var2490=$r6, var2605=i1, var1441=i4, var3737=java.util.List, var1311=$r8, var3726=java.lang.Object, var3121=$r10, var34=$r9, var1085=$r11, var2764=$i2, var1802=$r12}
; {edu.stanford.nlp.pipeline.CoNLLUReader$CoNLLUSentence=var3829, r7=var3225, r0=var1887, null_type=var2859, r1=var2491, $r2=var2959, r3=var3562, r4=var992, $r5=var2431, i0=var3362, $r6=var2490, i1=var2605, i4=var1441, java.util.List=var3737, $r8=var1311, java.lang.Object=var3726, $r10=var3121, $r9=var34, $r11=var1085, $i2=var2764, $r12=var1802}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r7 := @this: edu.stanford.nlp.pipeline.CoNLLUReader$CoNLLUSentence;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\t");	$r2 = r1[0];	r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("-");	r4 = r1[1];	$r5 = r3[0];	i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>($r5);	$r6 = r3[1];	i1 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>($r6);	i4 = i0 - 1;	if i4 >= i1 goto $r8 = r7.<edu.stanford.nlp.pipeline.CoNLLUReader$CoNLLUSentence: java.util.List mwtTokens>;	$r8 = r7.<edu.stanford.nlp.pipeline.CoNLLUReader$CoNLLUSentence: java.util.List mwtTokens>;	interfaceinvoke $r8.<java.util.List: boolean add(java.lang.Object)>(r4);	$r10 = r7.<edu.stanford.nlp.pipeline.CoNLLUReader$CoNLLUSentence: java.util.List mwtMiscs>;	$r9 = r1[9];	interfaceinvoke $r10.<java.util.List: boolean add(java.lang.Object)>($r9);	$r11 = r7.<edu.stanford.nlp.pipeline.CoNLLUReader$CoNLLUSentence: java.util.List mwtLastCoreLabels>;	$i2 = i1 - 1;	$r12 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>($i2);	interfaceinvoke $r11.<java.util.List: boolean add(java.lang.Object)>($r12);	return
;block_num 3
(get-model)
