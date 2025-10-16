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

(declare-sort var2896 0)
(declare-sort var1207 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var2896 var2896)
(declare-const null-String String)
(declare-const var3307 var2896) ; Statement: r4 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention 
(assert (not (= var3307 null-var2896)))
(declare-const var2003 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2003 null-String)))
; split operation: var3253 = var2003.split("/") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(define-const var3688 Int (get_split_length var2003 "/" -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 != 1 goto $r5 = r1[1] 
(assert (not (not (= var3688 1)))) ; Negate: Cond: $i0 != 1  
(define-const var1546 String var2003) ; Statement: $r5 = r0 
 ; Statement: goto [?= $r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":")] 
(assert true) ; Non Conditional
; split operation: var51 = var1546.split(":") ; Statement: $r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":") 
(define-const var3909 Int (get_split_length var1546 ":" -1)) ; Statement: $i1 = lengthof $r3 
 ; Statement: if $i1 != 1 goto $r2 = $r3[0] 
(assert (not (not (= var3909 1)))) ; Negate: Cond: $i1 != 1  
 ; Statement: return $r5 
(check-sat)
; {}
; {var2896=org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention, var3307=r4, var2003=r0, var1207=null_type, var3253=r1, var3688=$i0, var1546=$r5, var51=$r3, var3909=$i1}
; {org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention=var2896, r4=var3307, r0=var2003, null_type=var1207, r1=var3253, $i0=var3688, $r5=var1546, $r3=var51, $i1=var3909}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r4 := @this: org.apache.dubbo.tracing.AbstractDefaultDubboObservationConvention;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	$i0 = lengthof r1;	if $i0 != 1 goto $r5 = r1[1];	$r5 = r0;	goto [?= $r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":")];	$r3 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String)>(":");	$i1 = lengthof $r3;	if $i1 != 1 goto $r2 = $r3[0];	return $r5
;block_num 4
(get-model)
