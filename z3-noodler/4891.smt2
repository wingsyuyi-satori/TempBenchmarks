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

(declare-sort var2276 0)
(declare-sort var3564 0)
(declare-sort var568 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3564-init () var3564)
(declare-fun <init>/-325640736 (var3564) void)
(declare-fun var568_stringFromFile/-1519934906 (String) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-String String)
(declare-const var600 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var600 null-String)))
(define-const var1969 var3564 var3564-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var1969)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var1969!1 var3564)
(define-const var72 String (var568_stringFromFile/-1519934906 var600)) ; Statement: $r2 = staticinvoke <edu.stanford.nlp.io.IOUtils: java.lang.String stringFromFile(java.lang.String)>(r1) 
(assert true)
(define-const var425 String (trim/-847153721 var72)) ; Statement: $r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>() 
; split operation: var893 = var425.split("\n\n") ; Statement: r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n\n") 
(define-const var1108 Int (get_split_length var425 "\n\n" -1)) ; Statement: i0 = lengthof r4 
(define-const var3392 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto return $r0 
(assert (>= var3392 var1108)) ; Cond: i1 >= i0 
 ; Statement: return $r0 
(check-sat)
; {var3564-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), var568_stringFromFile/-1519934906=([java.lang.String], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String)}
; {var600=r1, var2276=null_type, var3564=java.util.ArrayList, var1969=$r0, var568=edu.stanford.nlp.io.IOUtils, var72=$r2, var425=$r3, var893=r4, var1108=i0, var3392=i1}
; {r1=var600, null_type=var2276, java.util.ArrayList=var3564, $r0=var1969, edu.stanford.nlp.io.IOUtils=var568, $r2=var72, $r3=var425, r4=var893, i0=var1108, i1=var3392}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @parameter0: java.lang.String;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	$r2 = staticinvoke <edu.stanford.nlp.io.IOUtils: java.lang.String stringFromFile(java.lang.String)>(r1);	$r3 = virtualinvoke $r2.<java.lang.String: java.lang.String trim()>();	r4 = virtualinvoke $r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n\n");	i0 = lengthof r4;	i1 = 0;	if i1 >= i0 goto return $r0;	return $r0
;block_num 3
(get-model)
