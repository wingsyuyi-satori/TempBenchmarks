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

(declare-sort var3350 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-String-init () (Array Int String))
(declare-fun arr-Int-init () (Array Int Int))
(declare-const null-String String)
(declare-const var717 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var717 null-String)))
; split operation: var1022 = var717.split("[,;]") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("[,;]") 
(define-const var2610 Int 0) ; Statement: i9 = 0 
(define-const var1463 Int (get_split_length var717 "[,;]" -1)) ; Statement: $i0 = lengthof r1 
(define-const var1739 (Array Int String) arr-String-init) ; Statement: r2 = newarray (java.lang.String)[$i0] 
(define-const var1049 Int (get_split_length var717 "[,;]" -1)) ; Statement: $i1 = lengthof r1 
(define-const var1876 (Array Int Int) arr-Int-init) ; Statement: r3 = newarray (int)[$i1] 
(define-const var2112 Int 0) ; Statement: i10 = 0 
(assert true) ; Non Conditional
(define-const var1217 Int (get_split_length var717 "[,;]" -1)) ; Statement: $i2 = lengthof r1 
 ; Statement: if i10 >= $i2 goto $i3 = i9 + 1 
(assert (>= var2112 var1217)) ; Cond: i10 >= $i2 
(define-const var3635 Int (+ var2610 1)) ; Statement: $i3 = i9 + 1 
(define-const var1143 (Array Int String) arr-String-init) ; Statement: r10 = newarray (java.lang.String)[$i3] 
(define-const var1042 Int 0) ; Statement: i12 = 0 
(assert true) ; Non Conditional
(define-const var2678 Int (get_split_length var717 "[,;]" -1)) ; Statement: $i4 = lengthof r1 
 ; Statement: if i12 >= $i4 goto return r10 
(assert (>= var1042 var2678)) ; Cond: i12 >= $i4 
 ; Statement: return r10 
(check-sat)
; {arr-String-init=([], java.lang.String[]), arr-Int-init=([], int[])}
; {var717=r0, var3350=null_type, var1022=r1, var2610=i9, var1463=$i0, var1739=r2, var1049=$i1, var1876=r3, var2112=i10, var1217=$i2, var3635=$i3, var1143=r10, var1042=i12, var2678=$i4}
; {r0=var717, null_type=var3350, r1=var1022, i9=var2610, $i0=var1463, r2=var1739, $i1=var1049, r3=var1876, i10=var2112, $i2=var1217, $i3=var3635, r10=var1143, i12=var1042, $i4=var2678}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("[,;]");	i9 = 0;	$i0 = lengthof r1;	r2 = newarray (java.lang.String)[$i0];	$i1 = lengthof r1;	r3 = newarray (int)[$i1];	i10 = 0;	$i2 = lengthof r1;	if i10 >= $i2 goto $i3 = i9 + 1;	$i3 = i9 + 1;	r10 = newarray (java.lang.String)[$i3];	i12 = 0;	$i4 = lengthof r1;	if i12 >= $i4 goto return r10;	return r10
;block_num 5
(get-model)
