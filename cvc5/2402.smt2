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

(declare-sort var565 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var565_getVersion/530152056 () String)
(define-const var2384 String var565_getVersion/530152056) ; Statement: $r0 = staticinvoke <org.jline.nativ.JLineNativeLoader: java.lang.String getVersion()>() 
; split operation: var1428 = var2384.split("\u005c.") ; Statement: r1 = virtualinvoke $r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.") 
(define-const var2199 Int (get_split_length var2384 "\u005c." -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 <= 1 goto $i1 = 0 
(assert (<= var2199 1)) ; Cond: $i0 <= 1 
(define-const var2578 Int 0) ; Statement: $i1 = 0 
(assert true) ; Non Conditional
 ; Statement: return $i1 
(check-sat)
; {var565_getVersion/530152056=([], java.lang.String)}
; {var565=org.jline.nativ.JLineNativeLoader, var2384=$r0, var1428=r1, var2199=$i0, var2578=$i1}
; {org.jline.nativ.JLineNativeLoader=var565, $r0=var2384, r1=var1428, $i0=var2199, $i1=var2578}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts $r0 = staticinvoke <org.jline.nativ.JLineNativeLoader: java.lang.String getVersion()>();	r1 = virtualinvoke $r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.");	$i0 = lengthof r1;	if $i0 <= 1 goto $i1 = 0;	$i1 = 0;	return $i1
;block_num 3
(get-model)
