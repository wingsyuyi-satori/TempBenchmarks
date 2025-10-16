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

(declare-sort var2609 0)
(declare-sort var3435 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-String String)
(declare-const null-var3435 var3435)
(declare-const null-Bool Bool)
(declare-const var97 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var97 null-String)))
(declare-const var318 var3435) ; Statement: r5 := @parameter1: java.util.logging.Logger 
(assert (not (= var318 null-var3435)))
(declare-const var2545 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var2545 null-Bool)))
; split operation: var2519 = var97.split("\n") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
 ; Statement: if z0 != 0 goto $r2 = new java.lang.StringBuilder 
(assert (not (not (= (ite var2545 1 0) 0)))) ; Negate: Cond: z0 != 0  
(define-const var888 Int (get_split_length var97 "\n" -1)) ; Statement: i0 = lengthof r1 
(define-const var817 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto (branch) 
(assert (>= var817 var888)) ; Cond: i1 >= i0 
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {}
; {var97=r0, var2609=null_type, var3435=java.util.logging.Logger, var318=r5, var2545=z0, var2519=r1, var888=i0, var817=i1}
; {r0=var97, null_type=var2609, java.util.logging.Logger=var3435, r5=var318, z0=var2545, r1=var2519, i0=var888, i1=var817}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r5 := @parameter1: java.util.logging.Logger;	z0 := @parameter2: boolean;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	if z0 != 0 goto $r2 = new java.lang.StringBuilder;	i0 = lengthof r1;	i1 = 0;	if i1 >= i0 goto (branch);	goto [?= return];	return
;block_num 5
(get-model)
