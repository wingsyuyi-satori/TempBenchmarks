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

(declare-sort var3476 0)
(declare-sort var3322 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toString/-512974245 (var3476) String)
(declare-const null-var3476 var3476)
(declare-const null-var3322 var3322)
(declare-const var2473 var3476) ; Statement: r0 := @parameter0: java.net.InetAddress 
(assert (not (= var2473 null-var3476)))
(declare-const var1936 var3322) ; Statement: r4 := @parameter1: java.util.List 
(assert (not (= var1936 null-var3322)))
(assert true)
(define-const var3891 String (toString/-512974245 var2473)) ; Statement: $r1 = virtualinvoke r0.<java.net.InetAddress: java.lang.String toString()>() 
; split operation: var2699 = var3891.split("\u005cs*/\u005cs*") ; Statement: r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s*/\\s*") 
(define-const var662 Int (get_split_length var3891 "\u005cs*/\u005cs*" -1)) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 <= 0 goto return 
(assert (<= var662 0)) ; Cond: $i0 <= 0 
 ; Statement: return 
(check-sat)
; {toString/-512974245=([java.net.InetAddress], java.lang.String)}
; {var3476=java.net.InetAddress, var2473=r0, var3322=java.util.List, var1936=r4, var3891=$r1, var2699=r2, var662=$i0}
; {java.net.InetAddress=var3476, r0=var2473, java.util.List=var3322, r4=var1936, $r1=var3891, r2=var2699, $i0=var662}
;seq <java.net.InetAddress: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.net.InetAddress;	r4 := @parameter1: java.util.List;	$r1 = virtualinvoke r0.<java.net.InetAddress: java.lang.String toString()>();	r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s*/\\s*");	$i0 = lengthof r2;	if $i0 <= 0 goto return;	return
;block_num 2
(get-model)
