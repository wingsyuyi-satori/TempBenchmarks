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

(declare-sort var1224 0)
(declare-sort var3214 0)
(declare-sort var858 0)
(declare-sort var2517 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var858-init () var858)
(declare-fun <init>/-325640736 (var858) void)
(declare-fun cast-from-var858-to-var2517 (var858) var2517)
(declare-fun tabs/618735517 (var1224) var2517)
(declare-const null-var1224 var1224)
(declare-const null-String String)
(declare-const var2997 var1224) ; Statement: r0 := @this: org.jline.builtins.Less 
(assert (not (= var2997 null-var1224)))
(declare-const var840 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var840 null-String)))
(define-const var1982 var858 var858-init) ; Statement: $r1 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var1982)) ; Statement: specialinvoke $r1.<java.util.ArrayList: void <init>()>() 

(declare-const var1982!1 var858)
(declare-const var2997!1 var1224)
(assert (not (= var2997!1 null-var1224)))
(assert (= (tabs/618735517 var2997!1) (cast-from-var858-to-var2517 var1982!1))) ; Statement: r0.<org.jline.builtins.Less: java.util.List tabs> = $r1 
; split operation: var2931 = var840.split(",") ; Statement: r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var2105 Int (get_split_length var840 "," -1)) ; Statement: i0 = lengthof r3 
(define-const var2172 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i0 goto return 
(assert (>= var2172 var2105)) ; Cond: i2 >= i0 
 ; Statement: return 
(check-sat)
; {var858-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), cast-from-var858-to-var2517=([java.util.ArrayList], java.util.List), tabs/618735517=([org.jline.builtins.Less], java.util.List)}
; {var1224=org.jline.builtins.Less, var2997=r0, var840=r2, var3214=null_type, var858=java.util.ArrayList, var1982=$r1, var2517=java.util.List, var2931=r3, var2105=i0, var2172=i2}
; {org.jline.builtins.Less=var1224, r0=var2997, r2=var840, null_type=var3214, java.util.ArrayList=var858, $r1=var1982, java.util.List=var2517, r3=var2931, i0=var2105, i2=var2172}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.jline.builtins.Less;	r2 := @parameter0: java.lang.String;	$r1 = new java.util.ArrayList;	specialinvoke $r1.<java.util.ArrayList: void <init>()>();	r0.<org.jline.builtins.Less: java.util.List tabs> = $r1;	r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	i0 = lengthof r3;	i2 = 0;	if i2 >= i0 goto return;	return
;block_num 3
(get-model)
