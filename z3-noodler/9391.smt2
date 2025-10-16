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

(declare-sort var1138 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-String String)
(declare-const var3769 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3769 null-String)))
; split operation: var1798 = var3769.split("\u005c(") ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\(") 
(define-const var385 Int (get_split_length var3769 "\u005c(" -1)) ; Statement: $i0 = lengthof $r1 
 ; Statement: if $i0 <= 0 goto return "" 
(assert (not (<= var385 0))) ; Negate: Cond: $i0 <= 0  
; split operation: var1367 = var3769.split("\u005c(") ; Statement: $r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\(") 
(define-const var1048 String (get_split_element var3769 "\u005c(" -1 0)) ; Statement: $r3 = $r2[0] 
(assert true)
(define-const var2028 String (trim/-847153721 var1048)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.String: java.lang.String trim()>() 
 ; Statement: return $r4 
(check-sat)
; {trim/-847153721=([java.lang.String], java.lang.String)}
; {var3769=r0, var1138=null_type, var1798=$r1, var385=$i0, var1367=$r2, var1048=$r3, var2028=$r4}
; {r0=var3769, null_type=var1138, $r1=var1798, $i0=var385, $r2=var1367, $r3=var1048, $r4=var2028}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2,"<java.lang.String: java.lang.String trim()>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\(");	$i0 = lengthof $r1;	if $i0 <= 0 goto return "";	$r2 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\(");	$r3 = $r2[0];	$r4 = virtualinvoke $r3.<java.lang.String: java.lang.String trim()>();	return $r4
;block_num 2
(get-model)
