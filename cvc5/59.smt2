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

(declare-sort var1045 0)
(declare-sort var1445 0)
(declare-sort var1853 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1445_toString/-646077907 (var1445) String)
(declare-const null-var1045 var1045)
(declare-const null-var1445 var1445)
(declare-const null-var1853 var1853)
(declare-const var652 var1045) ; Statement: r5 := @this: javax0.jamal.builtins.Use 
(assert (not (= var652 null-var1045)))
(declare-const var3239 var1445) ; Statement: r0 := @parameter0: javax0.jamal.api.Input 
(assert (not (= var3239 null-var1445)))
(declare-const var250 var1853) ; Statement: r6 := @parameter1: javax0.jamal.api.Processor 
(assert (not (= var250 null-var1853)))
(define-const var1381 String (var1445_toString/-646077907 var3239)) ; Statement: $r1 = interfaceinvoke r0.<javax0.jamal.api.Input: java.lang.String toString()>() 
; split operation: var442 = var1381.split(",") ; Statement: r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var1567 Int (get_split_length var1381 "," -1)) ; Statement: i0 = lengthof r2 
(define-const var361 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto return "" 
(assert (>= var361 var1567)) ; Cond: i1 >= i0 
 ; Statement: return "" 
(check-sat)
; {var1445_toString/-646077907=([javax0.jamal.api.Input], java.lang.String)}
; {var1045=javax0.jamal.builtins.Use, var652=r5, var1445=javax0.jamal.api.Input, var3239=r0, var1853=javax0.jamal.api.Processor, var250=r6, var1381=$r1, var442=r2, var1567=i0, var361=i1}
; {javax0.jamal.builtins.Use=var1045, r5=var652, javax0.jamal.api.Input=var1445, r0=var3239, javax0.jamal.api.Processor=var1853, r6=var250, $r1=var1381, r2=var442, i0=var1567, i1=var361}
;seq <javax0.jamal.api.Input: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r5 := @this: javax0.jamal.builtins.Use;	r0 := @parameter0: javax0.jamal.api.Input;	r6 := @parameter1: javax0.jamal.api.Processor;	$r1 = interfaceinvoke r0.<javax0.jamal.api.Input: java.lang.String toString()>();	r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	i0 = lengthof r2;	i1 = 0;	if i1 >= i0 goto return "";	return ""
;block_num 3
(get-model)
