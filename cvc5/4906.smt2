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

(declare-sort var2476 0)
(declare-sort var1354 0)
(declare-sort var2421 0)
(declare-sort var344 0)
(declare-sort var2757 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun cast-from-Int-to-Float32 (Int) Float32)
(declare-fun cast-from-Float32-to-Int (Float32) Int)
(declare-fun var1354-init () var1354)
(declare-fun <init>/643259939 (var1354 Int) void)
(declare-fun var2421-init () var2421)
(declare-fun <init>/613807010 (var2421 Int) void)
(declare-fun var344-init () var344)
(declare-fun <init>/-130489206 (var344 var1354 var2757 var2757 var2757 String) void)
(declare-fun cast-from-var2421-to-var2757 (var2421) var2757)
(declare-const null-String String)
(declare-const var2143 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2143 null-String)))
; split operation: var1647 = var2143.split("&") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("&") 
(define-const var1650 Int (get_split_length var2143 "&" -1)) ; Statement: $i0 = lengthof r1 
(define-const var3435 Float32 (cast-from-Int-to-Float32 var1650)) ; Statement: $f0 = (float) $i0 
(define-const var3663 Float32 (fp.div roundNearestTiesToEven var3435 ((_ to_fp 8 24) #x3f400000))) ; Statement: $f1 = $f0 / 0.75F 
(define-const var1030 Int (cast-from-Float32-to-Int var3663)) ; Statement: $i1 = (int) $f1 
(define-const var2258 Int (+ var1030 1)) ; Statement: i2 = $i1 + 1 
(define-const var3727 var1354 var1354-init) ; Statement: $r2 = new java.util.BitSet 
(assert true)
;(assert (<init>/643259939 var3727 var2258)) ; Statement: specialinvoke $r2.<java.util.BitSet: void <init>(int)>(i2) 

(declare-const var3727!1 var1354)
(declare-const var2258!1 Int)
(define-const var385 var2421 var2421-init) ; Statement: $r3 = new java.util.HashMap 
(assert true)
;(assert (<init>/613807010 var385 var2258!1)) ; Statement: specialinvoke $r3.<java.util.HashMap: void <init>(int)>(i2) 

(declare-const var385!1 var2421)
(declare-const var2258!2 Int)
(define-const var2997 var2421 var2421-init) ; Statement: $r4 = new java.util.HashMap 
(assert true)
;(assert (<init>/613807010 var2997 var2258!2)) ; Statement: specialinvoke $r4.<java.util.HashMap: void <init>(int)>(i2) 

(declare-const var2997!1 var2421)
(declare-const var2258!3 Int)
(define-const var3426 var2421 var2421-init) ; Statement: $r5 = new java.util.HashMap 
(assert true)
;(assert (<init>/613807010 var3426 var2258!3)) ; Statement: specialinvoke $r5.<java.util.HashMap: void <init>(int)>(i2) 

(declare-const var3426!1 var2421)
(declare-const var2258!4 Int)
(define-const var324 Int (get_split_length var2143 "&" -1)) ; Statement: i3 = lengthof r1 
(define-const var3107 Int 0) ; Statement: i8 = 0 
(assert true) ; Non Conditional
 ; Statement: if i8 >= i3 goto $r6 = new org.apache.dubbo.common.url.component.URLParam 
(assert (>= var3107 var324)) ; Cond: i8 >= i3 
(define-const var3882 var344 var344-init) ; Statement: $r6 = new org.apache.dubbo.common.url.component.URLParam 
(assert true)
;(assert (<init>/-130489206 var3882 var3727!1 (cast-from-var2421-to-var2757 var385!1) (cast-from-var2421-to-var2757 var2997!1) (cast-from-var2421-to-var2757 var3426!1) var2143)) ; Statement: specialinvoke $r6.<org.apache.dubbo.common.url.component.URLParam: void <init>(java.util.BitSet,java.util.Map,java.util.Map,java.util.Map,java.lang.String)>($r2, $r3, $r4, $r5, r0) 

(declare-const var3882!1 var344)
(declare-const var3727!2 var1354)
(declare-const var385!2 var2421)
(declare-const var2997!2 var2421)
(declare-const var3426!2 var2421)
(declare-const var2143!1 String)
 ; Statement: return $r6 
(check-sat)
; {cast-from-Int-to-Float32=([int], float), cast-from-Float32-to-Int=([float], int), var1354-init=([], java.util.BitSet), <init>/643259939=([java.util.BitSet, int], void), var2421-init=([], java.util.HashMap), <init>/613807010=([java.util.HashMap, int], void), var344-init=([], org.apache.dubbo.common.url.component.URLParam), <init>/-130489206=([org.apache.dubbo.common.url.component.URLParam, java.util.BitSet, java.util.Map, java.util.Map, java.util.Map, java.lang.String], void), cast-from-var2421-to-var2757=([java.util.HashMap], java.util.Map)}
; {var2143=r0, var2476=null_type, var1647=r1, var1650=$i0, var3435=$f0, var3663=$f1, var1030=$i1, var2258=i2, var1354=java.util.BitSet, var3727=$r2, var2421=java.util.HashMap, var385=$r3, var2997=$r4, var3426=$r5, var324=i3, var3107=i8, var344=org.apache.dubbo.common.url.component.URLParam, var3882=$r6, var2757=java.util.Map}
; {r0=var2143, null_type=var2476, r1=var1647, $i0=var1650, $f0=var3435, $f1=var3663, $i1=var1030, i2=var2258, java.util.BitSet=var1354, $r2=var3727, java.util.HashMap=var2421, $r3=var385, $r4=var2997, $r5=var3426, i3=var324, i8=var3107, org.apache.dubbo.common.url.component.URLParam=var344, $r6=var3882, java.util.Map=var2757}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("&");	$i0 = lengthof r1;	$f0 = (float) $i0;	$f1 = $f0 / 0.75F;	$i1 = (int) $f1;	i2 = $i1 + 1;	$r2 = new java.util.BitSet;	specialinvoke $r2.<java.util.BitSet: void <init>(int)>(i2);	$r3 = new java.util.HashMap;	specialinvoke $r3.<java.util.HashMap: void <init>(int)>(i2);	$r4 = new java.util.HashMap;	specialinvoke $r4.<java.util.HashMap: void <init>(int)>(i2);	$r5 = new java.util.HashMap;	specialinvoke $r5.<java.util.HashMap: void <init>(int)>(i2);	i3 = lengthof r1;	i8 = 0;	if i8 >= i3 goto $r6 = new org.apache.dubbo.common.url.component.URLParam;	$r6 = new org.apache.dubbo.common.url.component.URLParam;	specialinvoke $r6.<org.apache.dubbo.common.url.component.URLParam: void <init>(java.util.BitSet,java.util.Map,java.util.Map,java.util.Map,java.lang.String)>($r2, $r3, $r4, $r5, r0);	return $r6
;block_num 3
(get-model)
