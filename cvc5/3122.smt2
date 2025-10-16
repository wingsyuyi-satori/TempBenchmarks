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

(declare-sort var1421 0)
(declare-sort var3601 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3601-init () var3601)
(declare-fun <init>/927978603 (var3601) void)
(declare-const null-String String)
(declare-const var3243 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3243 null-String)))
(define-const var750 var3601 var3601-init) ; Statement: $r0 = new edu.stanford.nlp.stats.ClassicCounter 
(assert true)
;(assert (<init>/927978603 var750)) ; Statement: specialinvoke $r0.<edu.stanford.nlp.stats.ClassicCounter: void <init>()>() 

(declare-const var750!1 var3601)
; split operation: var1163 = var3243.split("\n") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(define-const var1194 Int (get_split_length var3243 "\n" -1)) ; Statement: i0 = lengthof r2 
(define-const var818 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i0 goto return $r0 
(assert (>= var818 var1194)) ; Cond: i2 >= i0 
 ; Statement: return $r0 
(check-sat)
; {var3601-init=([], edu.stanford.nlp.stats.ClassicCounter), <init>/927978603=([edu.stanford.nlp.stats.ClassicCounter], void)}
; {var3243=r1, var1421=null_type, var3601=edu.stanford.nlp.stats.ClassicCounter, var750=$r0, var1163=r2, var1194=i0, var818=i2}
; {r1=var3243, null_type=var1421, edu.stanford.nlp.stats.ClassicCounter=var3601, $r0=var750, r2=var1163, i0=var1194, i2=var818}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @parameter0: java.lang.String;	$r0 = new edu.stanford.nlp.stats.ClassicCounter;	specialinvoke $r0.<edu.stanford.nlp.stats.ClassicCounter: void <init>()>();	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	i0 = lengthof r2;	i2 = 0;	if i2 >= i0 goto return $r0;	return $r0
;block_num 3
(get-model)
