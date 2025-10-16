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

(declare-sort var1468 0)
(declare-sort var2487 0)
(declare-sort var3099 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1468_getServiceModel/1214805812 (var1468) var2487)
(declare-fun var1468_getTargetServiceUniqueName/-1786712159 (var1468) String)
(declare-const null-var1468 var1468)
(declare-const null-var2487 var2487)
(declare-const null-String String)
(declare-const var255 var1468) ; Statement: r0 := @parameter0: org.apache.dubbo.rpc.Invocation 
(assert (not (= var255 null-var1468)))
(define-const var1049 var2487 (var1468_getServiceModel/1214805812 var255)) ; Statement: $r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: org.apache.dubbo.rpc.model.ServiceModel getServiceModel()>() 
 ; Statement: if $r1 == null goto $r4 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>() 
(assert (= var1049 null-var2487)) ; Cond: $r1 == null 
(define-const var691 String (var1468_getTargetServiceUniqueName/-1786712159 var255)) ; Statement: $r4 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>() 
(define-const var2035 String null-String) ; Statement: r9 = null 
; split operation: var1473 = var691.split("/") ; Statement: $r5 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(define-const var1461 Int (get_split_length var691 "/" -1)) ; Statement: $i0 = lengthof $r5 
 ; Statement: if $i0 != 2 goto return r9 
(assert (not (= var1461 2))) ; Cond: $i0 != 2 
 ; Statement: return r9 
(check-sat)
; {var1468_getServiceModel/1214805812=([org.apache.dubbo.rpc.Invocation], org.apache.dubbo.rpc.model.ServiceModel), var1468_getTargetServiceUniqueName/-1786712159=([org.apache.dubbo.rpc.Invocation], java.lang.String)}
; {var1468=org.apache.dubbo.rpc.Invocation, var255=r0, var2487=org.apache.dubbo.rpc.model.ServiceModel, var1049=$r1, var691=$r4, var3099=null_type, var2035=r9, var1473=$r5, var1461=$i0}
; {org.apache.dubbo.rpc.Invocation=var1468, r0=var255, org.apache.dubbo.rpc.model.ServiceModel=var2487, $r1=var1049, $r4=var691, null_type=var3099, r9=var2035, $r5=var1473, $i0=var1461}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: org.apache.dubbo.rpc.Invocation;	$r1 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: org.apache.dubbo.rpc.model.ServiceModel getServiceModel()>();	if $r1 == null goto $r4 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>();	$r4 = interfaceinvoke r0.<org.apache.dubbo.rpc.Invocation: java.lang.String getTargetServiceUniqueName()>();	r9 = null;	$r5 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	$i0 = lengthof $r5;	if $i0 != 2 goto return r9;	return r9
;block_num 3
(get-model)
