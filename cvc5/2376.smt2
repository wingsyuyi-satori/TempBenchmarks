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

(declare-sort var2102 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2102_getVersion/530152056 () String)
(declare-fun Int_parseInt/1370970945 (String) Int)
(define-const var2696 String var2102_getVersion/530152056) ; Statement: $r0 = staticinvoke <org.jline.nativ.JLineNativeLoader: java.lang.String getVersion()>() 
; split operation: var99 = var2696.split("\u005c.") ; Statement: r1 = virtualinvoke $r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.") 
(define-const var2820 Int (get_split_length var2696 "\u005c." -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 <= 1 goto $i1 = 0 
(assert (not (<= var2820 1))) ; Negate: Cond: $i0 <= 1  
(define-const var2481 String (get_split_element var2696 "\u005c." -1 1)) ; Statement: $r2 = r1[1] 
(define-const var3128 Int (Int_parseInt/1370970945 var2481)) ; Statement: $i1 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>($r2) 
 ; Statement: goto [?= return $i1] 
(assert true) ; Non Conditional
 ; Statement: return $i1 
(check-sat)
; {var2102_getVersion/530152056=([], java.lang.String), Int_parseInt/1370970945=([java.lang.String], int)}
; {var2102=org.jline.nativ.JLineNativeLoader, var2696=$r0, var99=r1, var2820=$i0, var2481=$r2, var3128=$i1}
; {org.jline.nativ.JLineNativeLoader=var2102, $r0=var2696, r1=var99, $i0=var2820, $r2=var2481, $i1=var3128}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts $r0 = staticinvoke <org.jline.nativ.JLineNativeLoader: java.lang.String getVersion()>();	r1 = virtualinvoke $r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.");	$i0 = lengthof r1;	if $i0 <= 1 goto $i1 = 0;	$r2 = r1[1];	$i1 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>($r2);	goto [?= return $i1];	return $i1
;block_num 3
(get-model)
