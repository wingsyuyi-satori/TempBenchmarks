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

(declare-sort var2405 0)
(declare-sort var876 0)
(declare-sort var84 0)
(declare-sort var2892 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var876-init () var876)
(declare-fun <init>/-325640736 (var876) void)
(declare-fun var84_getSieves/-107895238 (var2405) String)
(declare-fun var84_getCurrentSieveForTrain/-1427544085 (var2405) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-const null-var2405 var2405)
(declare-const null-String String)
(declare-const var1504 var2405) ; Statement: r1 := @parameter0: java.util.Properties 
(assert (not (= var1504 null-var2405)))
(define-const var2393 var876 var876-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var2393)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var2393!1 var876)
(define-const var2051 String (var84_getSieves/-107895238 var1504)) ; Statement: r2 = staticinvoke <edu.stanford.nlp.coref.hybrid.HybridCorefProperties: java.lang.String getSieves(java.util.Properties)>(r1) 
(define-const var1630 String (var84_getCurrentSieveForTrain/-1427544085 var1504)) ; Statement: r3 = staticinvoke <edu.stanford.nlp.coref.hybrid.HybridCorefProperties: java.lang.String getCurrentSieveForTrain(java.util.Properties)>(r1) 
 ; Statement: if r3 != null goto $r4 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(r3) 
(assert (not (not (= var1630 null-String)))) ; Negate: Cond: r3 != null  
(assert true)
(define-const var3067 String (trim/-847153721 var2051)) ; Statement: $r10 = virtualinvoke r2.<java.lang.String: java.lang.String trim()>() 
; split operation: var3464 = var3067.split(",\u005cs*") ; Statement: $r11 = virtualinvoke $r10.<java.lang.String: java.lang.String[] split(java.lang.String)>(",\\s*") 
 ; Statement: goto [?= r7 = $r11] 
(assert true) ; Non Conditional
(declare-const var3464 (Array Int String))
(define-const var2670 (Array Int String) var3464) ; Statement: r7 = $r11 
(define-const var2774 Int (get_split_length var3067 ",\u005cs*" -1)) ; Statement: $i0 = lengthof $r11 
(define-const var87 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= $i0 goto return $r0 
(assert (>= var87 var2774)) ; Cond: i1 >= $i0 
 ; Statement: return $r0 
(check-sat)
; {var876-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), var84_getSieves/-107895238=([java.util.Properties], java.lang.String), var84_getCurrentSieveForTrain/-1427544085=([java.util.Properties], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String)}
; {var2405=java.util.Properties, var1504=r1, var876=java.util.ArrayList, var2393=$r0, var84=edu.stanford.nlp.coref.hybrid.HybridCorefProperties, var2051=r2, var1630=r3, var2892=null_type, var3067=$r10, var3464=$r11, var2670=r7, var2774=$i0, var87=i1}
; {java.util.Properties=var2405, r1=var1504, java.util.ArrayList=var876, $r0=var2393, edu.stanford.nlp.coref.hybrid.HybridCorefProperties=var84, r2=var2051, r3=var1630, null_type=var2892, $r10=var3067, $r11=var3464, r7=var2670, $i0=var2774, i1=var87}
;seq <java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r1 := @parameter0: java.util.Properties;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	r2 = staticinvoke <edu.stanford.nlp.coref.hybrid.HybridCorefProperties: java.lang.String getSieves(java.util.Properties)>(r1);	r3 = staticinvoke <edu.stanford.nlp.coref.hybrid.HybridCorefProperties: java.lang.String getCurrentSieveForTrain(java.util.Properties)>(r1);	if r3 != null goto $r4 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(r3);	$r10 = virtualinvoke r2.<java.lang.String: java.lang.String trim()>();	$r11 = virtualinvoke $r10.<java.lang.String: java.lang.String[] split(java.lang.String)>(",\\s*");	goto [?= r7 = $r11];	r7 = $r11;	$i0 = lengthof $r11;	i1 = 0;	if i1 >= $i0 goto return $r0;	return $r0
;block_num 5
(get-model)
