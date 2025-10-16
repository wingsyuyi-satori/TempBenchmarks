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

(declare-sort var2881 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2881_getVersion/530152056 () String)
(declare-fun Int_parseInt/1370970945 (String) Int)
(define-const var3576 String var2881_getVersion/530152056) ; Statement: $r0 = staticinvoke <org.jline.nativ.JLineNativeLoader: java.lang.String getVersion()>() 
; split operation: var896 = var3576.split("\u005c.") ; Statement: r1 = virtualinvoke $r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.") 
(define-const var1391 Int (get_split_length var3576 "\u005c." -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 <= 0 goto $i1 = 1 
(assert (not (<= var1391 0))) ; Negate: Cond: $i0 <= 0  
(define-const var3400 String (get_split_element var3576 "\u005c." -1 0)) ; Statement: $r2 = r1[0] 
(define-const var2390 Int (Int_parseInt/1370970945 var3400)) ; Statement: $i1 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>($r2) 
 ; Statement: goto [?= return $i1] 
(assert true) ; Non Conditional
 ; Statement: return $i1 
(check-sat)
; {var2881_getVersion/530152056=([], java.lang.String), Int_parseInt/1370970945=([java.lang.String], int)}
; {var2881=org.jline.nativ.JLineNativeLoader, var3576=$r0, var896=r1, var1391=$i0, var3400=$r2, var2390=$i1}
; {org.jline.nativ.JLineNativeLoader=var2881, $r0=var3576, r1=var896, $i0=var1391, $r2=var3400, $i1=var2390}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts $r0 = staticinvoke <org.jline.nativ.JLineNativeLoader: java.lang.String getVersion()>();	r1 = virtualinvoke $r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\.");	$i0 = lengthof r1;	if $i0 <= 0 goto $i1 = 1;	$r2 = r1[0];	$i1 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>($r2);	goto [?= return $i1];	return $i1
;block_num 3
(get-model)
