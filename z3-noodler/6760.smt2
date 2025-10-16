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

(declare-sort var2296 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-String String)
(declare-const var796 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var796 null-String)))
; split operation: var3397 = var796.split("\u005c(") ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\(") 
(define-const var1637 Int (get_split_length var796 "\u005c(" -1)) ; Statement: $i0 = lengthof $r1 
 ; Statement: if $i0 <= 0 goto return "" 
(assert (not (<= var1637 0))) ; Negate: Cond: $i0 <= 0  
; split operation: var892 = var796.split("\u005c(") ; Statement: $r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\(") 
(define-const var1502 String (get_split_element var796 "\u005c(" -1 0)) ; Statement: $r3 = $r2[0] 
(assert true)
(define-const var2095 String (trim/-847153721 var1502)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.String: java.lang.String trim()>() 
 ; Statement: return $r4 
(check-sat)
; {trim/-847153721=([java.lang.String], java.lang.String)}
; {var796=r0, var2296=null_type, var3397=$r1, var1637=$i0, var892=$r2, var1502=$r3, var2095=$r4}
; {r0=var796, null_type=var2296, $r1=var3397, $i0=var1637, $r2=var892, $r3=var1502, $r4=var2095}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2,"<java.lang.String: java.lang.String trim()>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\(");	$i0 = lengthof $r1;	if $i0 <= 0 goto return "";	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\(");	$r3 = $r2[0];	$r4 = virtualinvoke $r3.<java.lang.String: java.lang.String trim()>();	return $r4
;block_num 2
(get-model)
