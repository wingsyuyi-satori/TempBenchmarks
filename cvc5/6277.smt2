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

(declare-sort var3993 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun endsWith/985337093 ((s String) (suffix String)) Bool (str.suffixof suffix s))
(declare-const null-String String)
(declare-const var3833 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3833 null-String)))
(declare-const var585 String) ; Statement: r3 := @parameter1: java.lang.String 
(assert (not (= var585 null-String)))
(declare-const var3496 String) ; Statement: r1 := @parameter2: java.lang.String 
(assert (not (= var3496 null-String)))
; split operation: var2559 = var3833.split(var3496) ; Statement: r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(r1) 
(define-const var3992 Int (get_split_length var3833 var3496 -1)) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 != 0 goto $i1 = lengthof r2 
(assert (not (= var3992 0))) ; Cond: $i0 != 0 
(define-const var34 Int (get_split_length var3833 var3496 -1)) ; Statement: $i1 = lengthof r2 
(define-const var1429 Int (- var34 1)) ; Statement: $i2 = $i1 - 1 
(define-const var3550 String (get_split_element var3833 var3496 -1 var1429)) ; Statement: r4 = r2[$i2] 
(assert true)
(define-const var591 Bool (endsWith/985337093 var3550 var585)) ; Statement: $z0 = virtualinvoke r4.<java.lang.String: boolean endsWith(java.lang.String)>(r3) 
 ; Statement: if $z0 == 0 goto return r4 
(assert (= (ite var591 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return r4 
(check-sat)
; {endsWith/985337093=([java.lang.String, java.lang.String], boolean)}
; {var3833=r0, var3993=null_type, var585=r3, var3496=r1, var2559=r2, var3992=$i0, var34=$i1, var1429=$i2, var3550=r4, var591=$z0}
; {r0=var3833, null_type=var3993, r3=var585, r1=var3496, r2=var2559, $i0=var3992, $i1=var34, $i2=var1429, r4=var3550, $z0=var591}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: boolean endsWith(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: boolean endsWith(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r3 := @parameter1: java.lang.String;	r1 := @parameter2: java.lang.String;	r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(r1);	$i0 = lengthof r2;	if $i0 != 0 goto $i1 = lengthof r2;	$i1 = lengthof r2;	$i2 = $i1 - 1;	r4 = r2[$i2];	$z0 = virtualinvoke r4.<java.lang.String: boolean endsWith(java.lang.String)>(r3);	if $z0 == 0 goto return r4;	return r4
;block_num 3
(get-model)
