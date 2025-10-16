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

(declare-sort var1908 0)
(declare-sort var367 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1908_getProperty/258823597 (String) String)
(declare-const null-String String)
(define-const var2824 String (var1908_getProperty/258823597 "org.mockito.inline.preload")) ; Statement: r3 = staticinvoke <java.lang.System: java.lang.String getProperty(java.lang.String)>("org.mockito.inline.preload") 
 ; Statement: if r3 != null goto $r1 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(assert (not (= var2824 null-String))) ; Cond: r3 != null 
; split operation: var751 = var2824.split(",") ; Statement: $r1 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var2607 Int (get_split_length var2824 "," -1)) ; Statement: $i0 = lengthof $r1 
(define-const var1618 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto return 
(assert (>= var1618 var2607)) ; Cond: i1 >= $i0 
 ; Statement: return 
(check-sat)
; {var1908_getProperty/258823597=([java.lang.String], java.lang.String)}
; {var1908=java.lang.System, var2824=r3, var367=null_type, var751=$r1, var2607=$i0, var1618=i1}
; {java.lang.System=var1908, r3=var2824, null_type=var367, $r1=var751, $i0=var2607, i1=var1618}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r3 = staticinvoke <java.lang.System: java.lang.String getProperty(java.lang.String)>("org.mockito.inline.preload");	if r3 != null goto $r1 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r1 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$i0 = lengthof $r1;	i1 = 0;	if i1 >= $i0 goto return;	return
;block_num 4
(get-model)
