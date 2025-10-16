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

(declare-sort var1216 0)
(declare-sort var3700 0)
(declare-sort var2810 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var1216 var1216)
(declare-const null-String String)
(declare-const var2810-SERVICE_NAME_SEPARATOR String)
(declare-const var1413 var1216) ; Statement: r4 := @parameter0: java.util.List 
(assert (not (= var1413 null-var1216)))
(declare-const var170 String) ; Statement: r6 := @parameter1: java.lang.String 
(assert (not (= var170 null-String)))
(declare-const var3181 String) ; Statement: r8 := @parameter2: java.lang.String 
(assert (not (= var3181 null-String)))
(declare-const var2986 String) ; Statement: r10 := @parameter3: java.lang.String 
(assert (not (= var2986 null-String)))
(declare-const var3878 String) ; Statement: r0 := @parameter4: java.lang.String 
(assert (not (= var3878 null-String)))
(define-const var564 String var2810-SERVICE_NAME_SEPARATOR) ; Statement: $r1 = <org.apache.dubbo.registry.nacos.NacosRegistry: java.lang.String SERVICE_NAME_SEPARATOR> 
(define-const var3821 Int (cast-from-Int-to-Int -1)) ; Statement: $i2 = (int) -1 
; split operation: var654 = var3878.split(var564, var3821) ; Statement: r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>($r1, $i2) 
(define-const var3914 Int (get_split_length var3878 var564 var3821)) ; Statement: i0 = lengthof r2 
 ; Statement: if i0 == 4 goto r3 = r2[0] 
(assert (not (= var3914 4))) ; Negate: Cond: i0 == 4  
 ; Statement: return 0 
(check-sat)
; {cast-from-Int-to-Int=([int], int)}
; {var1216=java.util.List, var1413=r4, var170=r6, var3700=null_type, var3181=r8, var2986=r10, var3878=r0, var2810=org.apache.dubbo.registry.nacos.NacosRegistry, var564=$r1, var3821=$i2, var654=r2, var3914=i0}
; {java.util.List=var1216, r4=var1413, r6=var170, null_type=var3700, r8=var3181, r10=var2986, r0=var3878, org.apache.dubbo.registry.nacos.NacosRegistry=var2810, $r1=var564, $i2=var3821, r2=var654, i0=var3914}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r4 := @parameter0: java.util.List;	r6 := @parameter1: java.lang.String;	r8 := @parameter2: java.lang.String;	r10 := @parameter3: java.lang.String;	r0 := @parameter4: java.lang.String;	$r1 = <org.apache.dubbo.registry.nacos.NacosRegistry: java.lang.String SERVICE_NAME_SEPARATOR>;	$i2 = (int) -1;	r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>($r1, $i2);	i0 = lengthof r2;	if i0 == 4 goto r3 = r2[0];	return 0
;block_num 2
(get-model)
