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

(declare-sort var2302 0)
(declare-sort var3533 0)
(declare-sort var3169 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3169-init () var3169)
(declare-fun <init>/-325640736 (var3169) void)
(declare-const null-var2302 var2302)
(declare-const null-String String)
(declare-const var1024 var2302) ; Statement: r4 := @parameter0: java.util.Properties 
(assert (not (= var1024 null-var2302)))
(declare-const var1669 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var1669 null-String)))
; split operation: var1543 = var1669.split(";") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(";") 
(define-const var3790 var3169 var3169-init) ; Statement: $r2 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var3790)) ; Statement: specialinvoke $r2.<java.util.ArrayList: void <init>()>() 

(declare-const var3790!1 var3169)
(define-const var2711 Int (get_split_length var1669 ";" -1)) ; Statement: i0 = lengthof r1 
(define-const var3210 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto return $r2 
(assert (>= var3210 var2711)) ; Cond: i1 >= i0 
 ; Statement: return $r2 
(check-sat)
; {var3169-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void)}
; {var2302=java.util.Properties, var1024=r4, var1669=r0, var3533=null_type, var1543=r1, var3169=java.util.ArrayList, var3790=$r2, var2711=i0, var3210=i1}
; {java.util.Properties=var2302, r4=var1024, r0=var1669, null_type=var3533, r1=var1543, java.util.ArrayList=var3169, $r2=var3790, i0=var2711, i1=var3210}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r4 := @parameter0: java.util.Properties;	r0 := @parameter1: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(";");	$r2 = new java.util.ArrayList;	specialinvoke $r2.<java.util.ArrayList: void <init>()>();	i0 = lengthof r1;	i1 = 0;	if i1 >= i0 goto return $r2;	return $r2
;block_num 3
(get-model)
