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

(declare-sort var1154 0)
(declare-sort var3626 0)
(declare-sort var774 0)
(declare-sort var3277 0)
(declare-sort var782 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isLoggable/-616065502 (var3277 var782) Bool)
(declare-const null-var1154 var1154)
(declare-const null-var3626 var3626)
(declare-const null-String String)
(declare-const var1154-log var3277)
(declare-const var782-FINEST var782)
(declare-const var2478 var1154) ; Statement: r3 := @this: org.jline.utils.StyleResolver 
(assert (not (= var2478 null-var1154)))
(declare-const var3271 var3626) ; Statement: r10 := @parameter0: org.jline.utils.AttributedStyle 
(assert (not (= var3271 null-var3626)))
(declare-const var19 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var19 null-String)))
(define-const var629 var3277 var1154-log) ; Statement: $r1 = <org.jline.utils.StyleResolver: java.util.logging.Logger log> 
(define-const var2789 var782 var782-FINEST) ; Statement: $r0 = <java.util.logging.Level: java.util.logging.Level FINEST> 
(assert true)
(define-const var3610 Bool (isLoggable/-616065502 var629 var2789)) ; Statement: $z0 = virtualinvoke $r1.<java.util.logging.Logger: boolean isLoggable(java.util.logging.Level)>($r0) 
 ; Statement: if $z0 == 0 goto $r9 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(assert (= (ite var3610 1 0) 0)) ; Cond: $z0 == 0 
; split operation: var3110 = var19.split(",") ; Statement: $r9 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var664 Int (get_split_length var19 "," -1)) ; Statement: $i0 = lengthof $r9 
(define-const var3925 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto return r10 
(assert (>= var3925 var664)) ; Cond: i1 >= $i0 
 ; Statement: return r10 
(check-sat)
; {isLoggable/-616065502=([java.util.logging.Logger, java.util.logging.Level], boolean)}
; {var1154=org.jline.utils.StyleResolver, var2478=r3, var3626=org.jline.utils.AttributedStyle, var3271=r10, var19=r2, var774=null_type, var3277=java.util.logging.Logger, var629=$r1, var782=java.util.logging.Level, var2789=$r0, var3610=$z0, var3110=$r9, var664=$i0, var3925=i1}
; {org.jline.utils.StyleResolver=var1154, r3=var2478, org.jline.utils.AttributedStyle=var3626, r10=var3271, r2=var19, null_type=var774, java.util.logging.Logger=var3277, $r1=var629, java.util.logging.Level=var782, $r0=var2789, $z0=var3610, $r9=var3110, $i0=var664, i1=var3925}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r3 := @this: org.jline.utils.StyleResolver;	r10 := @parameter0: org.jline.utils.AttributedStyle;	r2 := @parameter1: java.lang.String;	$r1 = <org.jline.utils.StyleResolver: java.util.logging.Logger log>;	$r0 = <java.util.logging.Level: java.util.logging.Level FINEST>;	$z0 = virtualinvoke $r1.<java.util.logging.Logger: boolean isLoggable(java.util.logging.Level)>($r0);	if $z0 == 0 goto $r9 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r9 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$i0 = lengthof $r9;	i1 = 0;	if i1 >= $i0 goto return r10;	return r10
;block_num 4
(get-model)
