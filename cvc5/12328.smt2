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

(declare-sort var2720 0)
(declare-sort var1072 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var2720 var2720)
(declare-const null-String String)
(declare-const var3082 var2720) ; Statement: r4 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention 
(assert (not (= var3082 null-var2720)))
(declare-const var2561 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2561 null-String)))
; split operation: var3252 = var2561.split("/") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(define-const var3054 Int (get_split_length var2561 "/" -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 != 1 goto $r5 = r1[1] 
(assert (not (not (= var3054 1)))) ; Negate: Cond: $i0 != 1  
(define-const var3283 String var2561) ; Statement: $r5 = r0 
 ; Statement: goto [?= $r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":")] 
(assert true) ; Non Conditional
; split operation: var3398 = var3283.split(":") ; Statement: $r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":") 
(define-const var1392 Int (get_split_length var3283 ":" -1)) ; Statement: $i1 = lengthof $r3 
 ; Statement: if $i1 != 1 goto $r2 = $r3[0] 
(assert (not (= var1392 1))) ; Cond: $i1 != 1 
(define-const var2844 String (get_split_element var3283 ":" -1 0)) ; Statement: $r2 = $r3[0] 
 ; Statement: return $r2 
(check-sat)
; {}
; {var2720=org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, var3082=r4, var2561=r0, var1072=null_type, var3252=r1, var3054=$i0, var3283=$r5, var3398=$r3, var1392=$i1, var2844=$r2}
; {org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention=var2720, r4=var3082, r0=var2561, null_type=var1072, r1=var3252, $i0=var3054, $r5=var3283, $r3=var3398, $i1=var1392, $r2=var2844}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r4 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	$i0 = lengthof r1;	if $i0 != 1 goto $r5 = r1[1];	$r5 = r0;	goto [?= $r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":")];	$r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":");	$i1 = lengthof $r3;	if $i1 != 1 goto $r2 = $r3[0];	$r2 = $r3[0];	return $r2
;block_num 4
(get-model)
