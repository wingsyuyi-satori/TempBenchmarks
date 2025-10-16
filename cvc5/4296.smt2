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

(declare-sort var2587 0)
(declare-sort var1792 0)
(declare-sort var2514 0)
(declare-sort var1615 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1615_getCapabilitiesByName/-679790978 () var2514)
(declare-const null-String String)
(declare-const null-var1792 var1792)
(declare-const null-var2514 var2514)
(declare-const var1845 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1845 null-String)))
(declare-const var814 var1792) ; Statement: r8 := @parameter1: java.util.Set 
(assert (not (= var814 null-var1792)))
(declare-const var2979 var2514) ; Statement: r12 := @parameter2: java.util.Map 
(assert (not (= var2979 null-var2514)))
(declare-const var1871 var2514) ; Statement: r10 := @parameter3: java.util.Map 
(assert (not (= var1871 null-var2514)))
(define-const var2223 var2514 var1615_getCapabilitiesByName/-679790978) ; Statement: r0 = staticinvoke <org.jline.utils.InfoCmp: java.util.Map getCapabilitiesByName()>() 
; split operation: var1049 = var1845.split("\n") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(define-const var2743 Int 1) ; Statement: i3 = 1 
(assert true) ; Non Conditional
(define-const var3083 Int (get_split_length var1845 "\n" -1)) ; Statement: $i0 = lengthof r2 
 ; Statement: if i3 >= $i0 goto return 
(assert (>= var2743 var3083)) ; Cond: i3 >= $i0 
 ; Statement: return 
(check-sat)
; {var1615_getCapabilitiesByName/-679790978=([], java.util.Map)}
; {var1845=r1, var2587=null_type, var1792=java.util.Set, var814=r8, var2514=java.util.Map, var2979=r12, var1871=r10, var1615=org.jline.utils.InfoCmp, var2223=r0, var1049=r2, var2743=i3, var3083=$i0}
; {r1=var1845, null_type=var2587, java.util.Set=var1792, r8=var814, java.util.Map=var2514, r12=var2979, r10=var1871, org.jline.utils.InfoCmp=var1615, r0=var2223, r2=var1049, i3=var2743, $i0=var3083}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @parameter0: java.lang.String;	r8 := @parameter1: java.util.Set;	r12 := @parameter2: java.util.Map;	r10 := @parameter3: java.util.Map;	r0 = staticinvoke <org.jline.utils.InfoCmp: java.util.Map getCapabilitiesByName()>();	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	i3 = 1;	$i0 = lengthof r2;	if i3 >= $i0 goto return;	return
;block_num 3
(get-model)
