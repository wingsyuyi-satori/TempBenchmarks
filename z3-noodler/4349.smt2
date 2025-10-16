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

(declare-sort var3182 0)
(declare-sort var1295 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1295-init () var1295)
(declare-fun <init>/-1461814690 (var1295) void)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-String String)
(declare-const var3160 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3160 null-String)))
(define-const var3736 var1295 var1295-init) ; Statement: $r0 = new java.util.LinkedHashMap 
(assert true)
;(assert (<init>/-1461814690 var3736)) ; Statement: specialinvoke $r0.<java.util.LinkedHashMap: void <init>()>() 

(declare-const var3736!1 var1295)
(assert true)
(define-const var718 String (trim/-847153721 var3160)) ; Statement: $r2 = virtualinvoke r1.<java.lang.String: java.lang.String trim()>() 
; split operation: var1196 = var718.split(",\u005cs*") ; Statement: r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(",\\s*") 
(define-const var3853 Int (get_split_length var718 ",\u005cs*" -1)) ; Statement: i0 = lengthof r3 
(define-const var349 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i0 goto return $r0 
(assert (>= var349 var3853)) ; Cond: i3 >= i0 
 ; Statement: return $r0 
(check-sat)
; {var1295-init=([], java.util.LinkedHashMap), <init>/-1461814690=([java.util.LinkedHashMap], void), trim/-847153721=([java.lang.String], java.lang.String)}
; {var3160=r1, var3182=null_type, var1295=java.util.LinkedHashMap, var3736=$r0, var718=$r2, var1196=r3, var3853=i0, var349=i3}
; {r1=var3160, null_type=var3182, java.util.LinkedHashMap=var1295, $r0=var3736, $r2=var718, r3=var1196, i0=var3853, i3=var349}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @parameter0: java.lang.String;	$r0 = new java.util.LinkedHashMap;	specialinvoke $r0.<java.util.LinkedHashMap: void <init>()>();	$r2 = virtualinvoke r1.<java.lang.String: java.lang.String trim()>();	r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(",\\s*");	i0 = lengthof r3;	i3 = 0;	if i3 >= i0 goto return $r0;	return $r0
;block_num 3
(get-model)
