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

(declare-sort var1003 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-String-init () (Array Int String))
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-const null-String String)
(declare-const var2552 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2552 null-String)))
; split operation: var1437 = var2552.split(",") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var1109 Int (get_split_length var2552 "," -1)) ; Statement: $i0 = lengthof r1 
(define-const var2982 (Array Int String) arr-String-init) ; Statement: r2 = newarray (java.lang.String)[$i0] 
(define-const var3675 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
(define-const var1680 Int (get_split_length var2552 "," -1)) ; Statement: $i1 = lengthof r1 
 ; Statement: if i2 >= $i1 goto i3 = lengthof r2 
(assert (>= var3675 var1680)) ; Cond: i2 >= $i1 
(define-const var1308 Int (getLength-Arr-String-1 var2982)) ; Statement: i3 = lengthof r2 
(define-const var3788 Int 0) ; Statement: i4 = 0 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i3 goto i5 = lengthof r2 
(assert (not (>= var3788 var1308))) ; Negate: Cond: i4 >= i3  
(define-const var3051 String (select var2982 var3788)) ; Statement: r7 = r2[i4] 
(define-const var2523 String "auth") ; Statement: $r4 = "auth" 
(assert true)
(define-const var1317 Bool (= var2523 var3051)) ; Statement: $z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r7) 
 ; Statement: if $z1 == 0 goto i4 = i4 + 1 
(assert (not (= (ite var1317 1 0) 0))) ; Negate: Cond: $z1 == 0  
 ; Statement: return r7 
(check-sat)
; {arr-String-init=([], java.lang.String[]), getLength-Arr-String-1=([java.lang.String[]], int)}
; {var2552=r0, var1003=null_type, var1437=r1, var1109=$i0, var2982=r2, var3675=i2, var1680=$i1, var1308=i3, var3788=i4, var3051=r7, var2523=$r4, var1317=$z1}
; {r0=var2552, null_type=var1003, r1=var1437, $i0=var1109, r2=var2982, i2=var3675, $i1=var1680, i3=var1308, i4=var3788, r7=var3051, $r4=var2523, $z1=var1317}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$i0 = lengthof r1;	r2 = newarray (java.lang.String)[$i0];	i2 = 0;	$i1 = lengthof r1;	if i2 >= $i1 goto i3 = lengthof r2;	i3 = lengthof r2;	i4 = 0;	if i4 >= i3 goto i5 = lengthof r2;	r7 = r2[i4];	$r4 = "auth";	$z1 = virtualinvoke $r4.<java.lang.String: boolean equals(java.lang.Object)>(r7);	if $z1 == 0 goto i4 = i4 + 1;	return r7
;block_num 6
(get-model)
