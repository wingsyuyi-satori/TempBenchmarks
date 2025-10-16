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

(declare-sort var1054 0)
(declare-sort var3936 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var1054 var1054)
(declare-const null-String String)
(declare-const var1680 var1054) ; Statement: r2 := @this: org.apache.dubbo.registry.nacos.NacosRegistry 
(assert (not (= var1680 null-var1054)))
(declare-const var2257 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2257 null-String)))
(define-const var2930 Int (cast-from-Int-to-Int -1)) ; Statement: $i2 = (int) -1 
; split operation: var3100 = var2257.split(":", var2930) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", $i2) 
(define-const var3189 Int (get_split_length var2257 ":" var2930)) ; Statement: $i0 = lengthof $r1 
 ; Statement: if $i0 != 4 goto $z0 = 0 
(assert (not (= var3189 4))) ; Cond: $i0 != 4 
(define-const var1573 Bool (ite (= 1 0) true false)) ; Statement: $z0 = 0 
(assert true) ; Non Conditional
 ; Statement: return $z0 
(check-sat)
; {cast-from-Int-to-Int=([int], int)}
; {var1054=org.apache.dubbo.registry.nacos.NacosRegistry, var1680=r2, var2257=r0, var3936=null_type, var2930=$i2, var3100=$r1, var3189=$i0, var1573=$z0}
; {org.apache.dubbo.registry.nacos.NacosRegistry=var1054, r2=var1680, r0=var2257, null_type=var3936, $i2=var2930, $r1=var3100, $i0=var3189, $z0=var1573}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r2 := @this: org.apache.dubbo.registry.nacos.NacosRegistry;	r0 := @parameter0: java.lang.String;	$i2 = (int) -1;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", $i2);	$i0 = lengthof $r1;	if $i0 != 4 goto $z0 = 0;	$z0 = 0;	return $z0
;block_num 3
(get-model)
