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

(declare-sort var2503 0)
(declare-sort var528 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-const null-var2503 var2503)
(declare-const null-String String)
(declare-const var1004 var2503) ; Statement: r2 := @this: org.springframework.javapoet.CodeWriter 
(assert (not (= var1004 null-var2503)))
(declare-const var3301 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3301 null-String)))
(define-const var1690 Bool (ite (= 1 1) true false)) ; Statement: z7 = 1 
(define-const var2043 Int (cast-from-Int-to-Int -1)) ; Statement: $i7 = (int) -1 
; split operation: var2094 = var3301.split("\u005cR", var2043) ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\R", $i7) 
(define-const var3297 Int (get_split_length var3301 "\u005cR" var2043)) ; Statement: i0 = lengthof r1 
(define-const var238 Int 0) ; Statement: i4 = 0 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i0 goto return r2 
(assert (>= var238 var3297)) ; Cond: i4 >= i0 
 ; Statement: return r2 
(check-sat)
; {cast-from-Int-to-Int=([int], int)}
; {var2503=org.springframework.javapoet.CodeWriter, var1004=r2, var3301=r0, var528=null_type, var1690=z7, var2043=$i7, var2094=r1, var3297=i0, var238=i4}
; {org.springframework.javapoet.CodeWriter=var2503, r2=var1004, r0=var3301, null_type=var528, z7=var1690, $i7=var2043, r1=var2094, i0=var3297, i4=var238}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r2 := @this: org.springframework.javapoet.CodeWriter;	r0 := @parameter0: java.lang.String;	z7 = 1;	$i7 = (int) -1;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\R", $i7);	i0 = lengthof r1;	i4 = 0;	if i4 >= i0 goto return r2;	return r2
;block_num 3
(get-model)
