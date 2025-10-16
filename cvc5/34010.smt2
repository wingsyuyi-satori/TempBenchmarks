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

(declare-sort var1508 0)
(declare-sort var2214 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2214-init () var2214)
(declare-fun <init>/598147663 (var2214) void)
(declare-const null-String String)
(declare-const var2036 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2036 null-String)))
(define-const var3374 var2214 var2214-init) ; Statement: $r0 = new edu.stanford.nlp.ling.CoreLabel 
(assert true)
;(assert (<init>/598147663 var3374)) ; Statement: specialinvoke $r0.<edu.stanford.nlp.ling.CoreLabel: void <init>()>() 

(declare-const var3374!1 var2214)
; split operation: var1362 = var2036.split("\u005c|\u005c|\u005c|") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\|\\|\\|") 
(define-const var1263 Int (get_split_length var2036 "\u005c|\u005c|\u005c|" -1)) ; Statement: i0 = lengthof r2 
(define-const var972 Int 0) ; Statement: i8 = 0 
(assert true) ; Non Conditional
 ; Statement: if i8 >= i0 goto return $r0 
(assert (>= var972 var1263)) ; Cond: i8 >= i0 
 ; Statement: return $r0 
(check-sat)
; {var2214-init=([], edu.stanford.nlp.ling.CoreLabel), <init>/598147663=([edu.stanford.nlp.ling.CoreLabel], void)}
; {var2036=r1, var1508=null_type, var2214=edu.stanford.nlp.ling.CoreLabel, var3374=$r0, var1362=r2, var1263=i0, var972=i8}
; {r1=var2036, null_type=var1508, edu.stanford.nlp.ling.CoreLabel=var2214, $r0=var3374, r2=var1362, i0=var1263, i8=var972}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @parameter0: java.lang.String;	$r0 = new edu.stanford.nlp.ling.CoreLabel;	specialinvoke $r0.<edu.stanford.nlp.ling.CoreLabel: void <init>()>();	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\|\\|\\|");	i0 = lengthof r2;	i8 = 0;	if i8 >= i0 goto return $r0;	return $r0
;block_num 3
(get-model)
