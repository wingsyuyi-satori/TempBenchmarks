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

(declare-sort var1057 0)
(declare-sort var2919 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-String String)
(declare-const null-var2919 var2919)
(declare-const null-Bool Bool)
(declare-const var693 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var693 null-String)))
(declare-const var1307 var2919) ; Statement: r3 := @parameter1: java.util.logging.Logger 
(assert (not (= var1307 null-var2919)))
(declare-const var2786 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var2786 null-Bool)))
; split operation: var1505 = var693.split("\n") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
 ; Statement: if z0 != 0 goto $r2 = new java.lang.StringBuilder 
(assert (not (not (= (ite var2786 1 0) 0)))) ; Negate: Cond: z0 != 0  
(define-const var1306 Int (get_split_length var693 "\n" -1)) ; Statement: i0 = lengthof r1 
(define-const var2504 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto (branch) 
(assert (>= var2504 var1306)) ; Cond: i1 >= i0 
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {}
; {var693=r0, var1057=null_type, var2919=java.util.logging.Logger, var1307=r3, var2786=z0, var1505=r1, var1306=i0, var2504=i1}
; {r0=var693, null_type=var1057, java.util.logging.Logger=var2919, r3=var1307, z0=var2786, r1=var1505, i0=var1306, i1=var2504}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r3 := @parameter1: java.util.logging.Logger;	z0 := @parameter2: boolean;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	if z0 != 0 goto $r2 = new java.lang.StringBuilder;	i0 = lengthof r1;	i1 = 0;	if i1 >= i0 goto (branch);	goto [?= return];	return
;block_num 5
(get-model)
