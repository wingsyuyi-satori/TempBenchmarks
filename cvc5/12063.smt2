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

(declare-sort var348 0)
(declare-sort var3692 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var348 var348)
(declare-const null-String String)
(declare-const var2196 var348) ; Statement: r5 := @this: edu.stanford.nlp.international.french.process.FrenchTokenizer$FrenchTokenizerFactory 
(assert (not (= var2196 null-var348)))
(declare-const var1391 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1391 null-String)))
; split operation: var3376 = var1391.split(",") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var3164 Int (get_split_length var1391 "," -1)) ; Statement: i0 = lengthof r1 
(define-const var2399 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i0 goto return 
(assert (>= var2399 var3164)) ; Cond: i3 >= i0 
 ; Statement: return 
(check-sat)
; {}
; {var348=edu.stanford.nlp.international.french.process.FrenchTokenizer$FrenchTokenizerFactory, var2196=r5, var1391=r0, var3692=null_type, var3376=r1, var3164=i0, var2399=i3}
; {edu.stanford.nlp.international.french.process.FrenchTokenizer$FrenchTokenizerFactory=var348, r5=var2196, r0=var1391, null_type=var3692, r1=var3376, i0=var3164, i3=var2399}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r5 := @this: edu.stanford.nlp.international.french.process.FrenchTokenizer$FrenchTokenizerFactory;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	i0 = lengthof r1;	i3 = 0;	if i3 >= i0 goto return;	return
;block_num 3
(get-model)
