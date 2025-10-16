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

(declare-sort var3939 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3939_getVersion/530152056 () String)
(define-const var3821 String var3939_getVersion/530152056) ; Statement: $r0 = staticinvoke <org.jline.nativ.JLineNativeLoader: java.lang.String getVersion()>() 
; split operation: var1596 = var3821.split("\u005c.") ; Statement: r1 = virtualinvoke $r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.") 
(define-const var3041 Int (get_split_length var3821 "\u005c." -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 <= 0 goto $i1 = 1 
(assert (<= var3041 0)) ; Cond: $i0 <= 0 
(define-const var3327 Int 1) ; Statement: $i1 = 1 
(assert true) ; Non Conditional
 ; Statement: return $i1 
(check-sat)
; {var3939_getVersion/530152056=([], java.lang.String)}
; {var3939=org.jline.nativ.JLineNativeLoader, var3821=$r0, var1596=r1, var3041=$i0, var3327=$i1}
; {org.jline.nativ.JLineNativeLoader=var3939, $r0=var3821, r1=var1596, $i0=var3041, $i1=var3327}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts $r0 = staticinvoke <org.jline.nativ.JLineNativeLoader: java.lang.String getVersion()>();	r1 = virtualinvoke $r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.");	$i0 = lengthof r1;	if $i0 <= 0 goto $i1 = 1;	$i1 = 1;	return $i1
;block_num 3
(get-model)
