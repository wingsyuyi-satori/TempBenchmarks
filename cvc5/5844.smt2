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

(declare-sort var2706 0)
(declare-sort var223 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var223_slurpFile/458402865 (String) String)
(declare-fun arr-__Array__Int__Float64__-init () (Array Int (Array Int Float64)))
(declare-fun getLength-Arr-Float64-2 ((Array Int (Array Int Float64))) Int)
(declare-const null-String String)
(declare-const var3162 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3162 null-String)))
(define-const var3422 String (var223_slurpFile/458402865 var3162)) ; Statement: r1 = staticinvoke <edu.stanford.nlp.io.IOUtils: java.lang.String slurpFile(java.lang.String)>(r0) 
; split operation: var2510 = var3422.split("[\r\n]+") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("[\r\n]+") 
(define-const var791 Int (get_split_length var3422 "[\r\n]+" -1)) ; Statement: $i0 = lengthof r2 
(define-const var1408 (Array Int (Array Int Float64)) arr-__Array__Int__Float64__-init) ; Statement: r3 = newarray (double[])[$i0] 
(define-const var394 Int 0) ; Statement: i4 = 0 
(assert true) ; Non Conditional
(define-const var27 Int (getLength-Arr-Float64-2 var1408)) ; Statement: $i1 = lengthof r3 
 ; Statement: if i4 >= $i1 goto return r3 
(assert (>= var394 var27)) ; Cond: i4 >= $i1 
 ; Statement: return r3 
(check-sat)
; {var223_slurpFile/458402865=([java.lang.String], java.lang.String), arr-__Array__Int__Float64__-init=([], double[][]), getLength-Arr-Float64-2=([double[][]], int)}
; {var3162=r0, var2706=null_type, var223=edu.stanford.nlp.io.IOUtils, var3422=r1, var2510=r2, var791=$i0, var1408=r3, var394=i4, var27=$i1}
; {r0=var3162, null_type=var2706, edu.stanford.nlp.io.IOUtils=var223, r1=var3422, r2=var2510, $i0=var791, r3=var1408, i4=var394, $i1=var27}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 = staticinvoke <edu.stanford.nlp.io.IOUtils: java.lang.String slurpFile(java.lang.String)>(r0);	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("[\r\n]+");	$i0 = lengthof r2;	r3 = newarray (double[])[$i0];	i4 = 0;	$i1 = lengthof r3;	if i4 >= $i1 goto return r3;	return r3
;block_num 3
(get-model)
