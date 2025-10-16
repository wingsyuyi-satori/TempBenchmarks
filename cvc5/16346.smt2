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

(declare-sort var2242 0)
(declare-sort var1874 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var2242 var2242)
(declare-const null-String String)
(declare-const var1157 var2242) ; Statement: r2 := @this: org.apache.dubbo.registry.nacos.NacosRegistry 
(assert (not (= var1157 null-var2242)))
(declare-const var3051 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3051 null-String)))
(define-const var2401 Int (cast-from-Int-to-Int -1)) ; Statement: $i2 = (int) -1 
; split operation: var3031 = var3051.split(":", var2401) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", $i2) 
(define-const var3225 Int (get_split_length var3051 ":" var2401)) ; Statement: $i0 = lengthof $r1 
 ; Statement: if $i0 != 4 goto $z0 = 0 
(assert (not (not (= var3225 4)))) ; Negate: Cond: $i0 != 4  
(define-const var2171 Bool (ite (= 1 1) true false)) ; Statement: $z0 = 1 
 ; Statement: goto [?= return $z0] 
(assert true) ; Non Conditional
 ; Statement: return $z0 
(check-sat)
; {cast-from-Int-to-Int=([int], int)}
; {var2242=org.apache.dubbo.registry.nacos.NacosRegistry, var1157=r2, var3051=r0, var1874=null_type, var2401=$i2, var3031=$r1, var3225=$i0, var2171=$z0}
; {org.apache.dubbo.registry.nacos.NacosRegistry=var2242, r2=var1157, r0=var3051, null_type=var1874, $i2=var2401, $r1=var3031, $i0=var3225, $z0=var2171}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r2 := @this: org.apache.dubbo.registry.nacos.NacosRegistry;	r0 := @parameter0: java.lang.String;	$i2 = (int) -1;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", $i2);	$i0 = lengthof $r1;	if $i0 != 4 goto $z0 = 0;	$z0 = 1;	goto [?= return $z0];	return $z0
;block_num 3
(get-model)
