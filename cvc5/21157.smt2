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

(declare-sort var2259 0)
(declare-sort var376 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var376-init () var376)
(declare-fun <init>/-325640736 (var376) void)
(declare-const null-String String)
(declare-const var2022 String) ; Statement: r4 := @parameter0: java.lang.String 
(assert (not (= var2022 null-String)))
 ; Statement: if r4 != null goto $r3 = virtualinvoke r4.<java.lang.String: java.lang.String[] split(java.lang.String)>(" *, *") 
(assert (not (= var2022 null-String))) ; Cond: r4 != null 
; split operation: var1207 = var2022.split(" *, *") ; Statement: $r3 = virtualinvoke r4.<java.lang.String: java.lang.String[] split(java.lang.String)>(" *, *") 
(define-const var1936 var376 var376-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var1936)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var1936!1 var376)
(define-const var3748 Int (get_split_length var2022 " *, *" -1)) ; Statement: $i0 = lengthof $r3 
(define-const var1395 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto return $r0 
(assert (>= var1395 var3748)) ; Cond: i1 >= $i0 
 ; Statement: return $r0 
(check-sat)
; {var376-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void)}
; {var2022=r4, var2259=null_type, var1207=$r3, var376=java.util.ArrayList, var1936=$r0, var3748=$i0, var1395=i1}
; {r4=var2022, null_type=var2259, $r3=var1207, java.util.ArrayList=var376, $r0=var1936, $i0=var3748, i1=var1395}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r4 := @parameter0: java.lang.String;	if r4 != null goto $r3 = virtualinvoke r4.<java.lang.String: java.lang.String[] split(java.lang.String)>(" *, *");	$r3 = virtualinvoke r4.<java.lang.String: java.lang.String[] split(java.lang.String)>(" *, *");	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	$i0 = lengthof $r3;	i1 = 0;	if i1 >= $i0 goto return $r0;	return $r0
;block_num 4
(get-model)
