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

(declare-sort var3949 0)
(declare-sort var2200 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-String String)
(declare-const null-var2200 var2200)
(declare-const var2878 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2878 null-String)))
(declare-const var3588 var2200) ; Statement: r3 := @parameter1: java.util.Properties 
(assert (not (= var3588 null-var2200)))
(assert true)
(define-const var2220 String (trim/-847153721 var2878)) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>() 
; split operation: var2311 = var2220.split(",\u005cs*") ; Statement: r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(",\\s*") 
(define-const var2014 Int (get_split_length var2220 ",\u005cs*" -1)) ; Statement: i0 = lengthof r2 
(define-const var3122 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i0 goto return r3 
(assert (>= var3122 var2014)) ; Cond: i3 >= i0 
 ; Statement: return r3 
(check-sat)
; {trim/-847153721=([java.lang.String], java.lang.String)}
; {var2878=r0, var3949=null_type, var2200=java.util.Properties, var3588=r3, var2220=$r1, var2311=r2, var2014=i0, var3122=i3}
; {r0=var2878, null_type=var3949, java.util.Properties=var2200, r3=var3588, $r1=var2220, r2=var2311, i0=var2014, i3=var3122}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r3 := @parameter1: java.util.Properties;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String trim()>();	r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(",\\s*");	i0 = lengthof r2;	i3 = 0;	if i3 >= i0 goto return r3;	return r3
;block_num 3
(get-model)
