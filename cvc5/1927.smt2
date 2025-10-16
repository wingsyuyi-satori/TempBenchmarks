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

(declare-sort var364 0)
(declare-sort var1563 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const null-var364 var364)
(declare-const null-String String)
(declare-const var815 var364) ; Statement: r2 := @this: org.apache.logging.log4j.core.config.DefaultConfigurationFactory 
(assert (not (= var815 null-var364)))
(declare-const var2469 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2469 null-String)))
; split operation: var1792 = var2469.split(",") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var3316 Int (get_split_length var2469 "," -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 <= 1 goto $r3 = new java.net.URI 
(assert (not (<= var3316 1))) ; Negate: Cond: $i0 <= 1  
 ; Statement: return r1 
(check-sat)
; {}
; {var364=org.apache.logging.log4j.core.config.DefaultConfigurationFactory, var815=r2, var2469=r0, var1563=null_type, var1792=r1, var3316=$i0}
; {org.apache.logging.log4j.core.config.DefaultConfigurationFactory=var364, r2=var815, r0=var2469, null_type=var1563, r1=var1792, $i0=var3316}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r2 := @this: org.apache.logging.log4j.core.config.DefaultConfigurationFactory;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$i0 = lengthof r1;	if $i0 <= 1 goto $r3 = new java.net.URI;	return r1
;block_num 2
(get-model)
