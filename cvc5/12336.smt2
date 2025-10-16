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

(declare-sort var1168 0)
(declare-sort var1767 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var1168 var1168)
(declare-const null-String String)
(declare-const var1477 var1168) ; Statement: r4 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention 
(assert (not (= var1477 null-var1168)))
(declare-const var2917 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2917 null-String)))
; split operation: var170 = var2917.split("/") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(define-const var434 Int (get_split_length var2917 "/" -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 != 1 goto $r5 = r1[1] 
(assert (not (= var434 1))) ; Cond: $i0 != 1 
(define-const var2702 String (get_split_element var2917 "/" -1 1)) ; Statement: $r5 = r1[1] 
(assert true) ; Non Conditional
; split operation: var694 = var2702.split(":") ; Statement: $r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":") 
(define-const var1988 Int (get_split_length var2702 ":" -1)) ; Statement: $i1 = lengthof $r3 
 ; Statement: if $i1 != 1 goto $r2 = $r3[0] 
(assert (not (not (= var1988 1)))) ; Negate: Cond: $i1 != 1  
 ; Statement: return $r5 
(check-sat)
; {}
; {var1168=org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, var1477=r4, var2917=r0, var1767=null_type, var170=r1, var434=$i0, var2702=$r5, var694=$r3, var1988=$i1}
; {org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention=var1168, r4=var1477, r0=var2917, null_type=var1767, r1=var170, $i0=var434, $r5=var2702, $r3=var694, $i1=var1988}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r4 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	$i0 = lengthof r1;	if $i0 != 1 goto $r5 = r1[1];	$r5 = r1[1];	$r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":");	$i1 = lengthof $r3;	if $i1 != 1 goto $r2 = $r3[0];	return $r5
;block_num 4
(get-model)
