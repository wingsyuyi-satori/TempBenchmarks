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

(declare-sort var3571 0)
(declare-sort var3390 0)
(declare-sort var3117 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var3117) void)
(declare-fun cast-from-var3571-to-var3117 (var3571) var3117)
(declare-fun value/-687932879 (var3571) String)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun category/-687932879 (var3571) String)
(declare-fun serviceInterface/-687932879 (var3571) String)
(declare-fun version/-687932879 (var3571) String)
(declare-fun group/-687932879 (var3571) String)
(declare-const null-var3571 var3571)
(declare-const null-String String)
(declare-const var3544 var3571) ; Statement: r0 := @this: org.apache.dubbo.registry.nacos.NacosServiceName 
(assert (not (= var3544 null-var3571)))
(declare-const var3120 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3120 null-String)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var3571-to-var3117 var3544))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var3544!1 var3571)
(declare-const var3544!2 var3571)
(assert (not (= var3544!2 null-var3571)))
(assert (= (value/-687932879 var3544!2) var3120)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String value> = r1 
(define-const var2857 Int (cast-from-Int-to-Int -1)) ; Statement: $i1 = (int) -1 
; split operation: var970 = var3120.split(":", var2857) ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", $i1) 
(define-const var2681 String (get_split_element var3120 ":" var2857 0)) ; Statement: $r3 = r2[0] 
(declare-const var3544!3 var3571)
(assert (not (= var3544!3 null-var3571)))
(assert (= (category/-687932879 var3544!3) var2681)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String category> = $r3 
(define-const var1944 String (get_split_element var3120 ":" var2857 1)) ; Statement: $r4 = r2[1] 
(declare-const var3544!4 var3571)
(assert (not (= var3544!4 null-var3571)))
(assert (= (serviceInterface/-687932879 var3544!4) var1944)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String serviceInterface> = $r4 
(define-const var603 String (get_split_element var3120 ":" var2857 2)) ; Statement: $r5 = r2[2] 
(declare-const var3544!5 var3571)
(assert (not (= var3544!5 null-var3571)))
(assert (= (version/-687932879 var3544!5) var603)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String version> = $r5 
(define-const var2199 String (get_split_element var3120 ":" var2857 3)) ; Statement: $r6 = r2[3] 
(declare-const var3544!6 var3571)
(assert (not (= var3544!6 null-var3571)))
(assert (= (group/-687932879 var3544!6) var2199)) ; Statement: r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String group> = $r6 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var3571-to-var3117=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.Object), value/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String), cast-from-Int-to-Int=([int], int), category/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String), serviceInterface/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String), version/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String), group/-687932879=([org.apache.dubbo.registry.nacos.NacosServiceName], java.lang.String)}
; {var3571=org.apache.dubbo.registry.nacos.NacosServiceName, var3544=r0, var3120=r1, var3390=null_type, var3117=java.lang.Object, var2857=$i1, var970=r2, var2681=$r3, var1944=$r4, var603=$r5, var2199=$r6}
; {org.apache.dubbo.registry.nacos.NacosServiceName=var3571, r0=var3544, r1=var3120, null_type=var3390, java.lang.Object=var3117, $i1=var2857, r2=var970, $r3=var2681, $r4=var1944, $r5=var603, $r6=var2199}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r0 := @this: org.apache.dubbo.registry.nacos.NacosServiceName;	r1 := @parameter0: java.lang.String;	specialinvoke r0.<java.lang.Object: void <init>()>();	r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String value> = r1;	$i1 = (int) -1;	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", $i1);	$r3 = r2[0];	r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String category> = $r3;	$r4 = r2[1];	r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String serviceInterface> = $r4;	$r5 = r2[2];	r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String version> = $r5;	$r6 = r2[3];	r0.<org.apache.dubbo.registry.nacos.NacosServiceName: java.lang.String group> = $r6;	return
;block_num 1
(get-model)
