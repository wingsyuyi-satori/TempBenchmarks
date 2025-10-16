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

(declare-sort var1174 0)
(declare-sort var1252 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var1174 var1174)
(declare-const null-String String)
(declare-const var2172 var1174) ; Statement: r4 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention 
(assert (not (= var2172 null-var1174)))
(declare-const var1863 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1863 null-String)))
; split operation: var2854 = var1863.split("/") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(define-const var3955 Int (get_split_length var1863 "/" -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 != 1 goto $r5 = r1[1] 
(assert (not (= var3955 1))) ; Cond: $i0 != 1 
(define-const var3639 String (get_split_element var1863 "/" -1 1)) ; Statement: $r5 = r1[1] 
(assert true) ; Non Conditional
; split operation: var281 = var3639.split(":") ; Statement: $r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":") 
(define-const var3616 Int (get_split_length var3639 ":" -1)) ; Statement: $i1 = lengthof $r3 
 ; Statement: if $i1 != 1 goto $r2 = $r3[0] 
(assert (not (= var3616 1))) ; Cond: $i1 != 1 
(define-const var1595 String (get_split_element var3639 ":" -1 0)) ; Statement: $r2 = $r3[0] 
 ; Statement: return $r2 
(check-sat)
; {}
; {var1174=org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, var2172=r4, var1863=r0, var1252=null_type, var2854=r1, var3955=$i0, var3639=$r5, var281=$r3, var3616=$i1, var1595=$r2}
; {org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention=var1174, r4=var2172, r0=var1863, null_type=var1252, r1=var2854, $i0=var3955, $r5=var3639, $r3=var281, $i1=var3616, $r2=var1595}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r4 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	$i0 = lengthof r1;	if $i0 != 1 goto $r5 = r1[1];	$r5 = r1[1];	$r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":");	$i1 = lengthof $r3;	if $i1 != 1 goto $r2 = $r3[0];	$r2 = $r3[0];	return $r2
;block_num 4
(get-model)
