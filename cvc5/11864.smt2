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

(declare-sort var2021 0)
(declare-sort var2793 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var2021 var2021)
(declare-const null-String String)
(declare-const var1973 var2021) ; Statement: r3 := @this: edu.stanford.nlp.international.arabic.process.ArabicTokenizer$ArabicTokenizerFactory 
(assert (not (= var1973 null-var2021)))
(declare-const var2278 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2278 null-String)))
; split operation: var2997 = var2278.split(",") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var1868 Int (get_split_length var2278 "," -1)) ; Statement: i0 = lengthof r1 
(define-const var1117 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto return 
(assert (>= var1117 var1868)) ; Cond: i1 >= i0 
 ; Statement: return 
(check-sat)
; {}
; {var2021=edu.stanford.nlp.international.arabic.process.ArabicTokenizer$ArabicTokenizerFactory, var1973=r3, var2278=r0, var2793=null_type, var2997=r1, var1868=i0, var1117=i1}
; {edu.stanford.nlp.international.arabic.process.ArabicTokenizer$ArabicTokenizerFactory=var2021, r3=var1973, r0=var2278, null_type=var2793, r1=var2997, i0=var1868, i1=var1117}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r3 := @this: edu.stanford.nlp.international.arabic.process.ArabicTokenizer$ArabicTokenizerFactory;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	i0 = lengthof r1;	i1 = 0;	if i1 >= i0 goto return;	return
;block_num 3
(get-model)
