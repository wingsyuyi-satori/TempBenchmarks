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

(declare-sort var1774 0)
(declare-sort var2299 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun info/114590825 (var2299 String) void)
(declare-const null-String String)
(declare-const null-var2299 var2299)
(declare-const null-Bool Bool)
(declare-const var578 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var578 null-String)))
(declare-const var2995 var2299) ; Statement: r3 := @parameter1: java.util.logging.Logger 
(assert (not (= var2995 null-var2299)))
(declare-const var2838 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var2838 null-Bool)))
; split operation: var1509 = var578.split("\n") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
 ; Statement: if z0 != 0 goto $r2 = new java.lang.StringBuilder 
(assert (not (not (= (ite var2838 1 0) 0)))) ; Negate: Cond: z0 != 0  
(define-const var2887 Int (get_split_length var578 "\n" -1)) ; Statement: i0 = lengthof r1 
(define-const var911 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto (branch) 
(assert (not (>= var911 var2887))) ; Negate: Cond: i1 >= i0  
(define-const var2462 String (get_split_element var578 "\n" -1 var911)) ; Statement: r7 = r1[i1] 
(assert true)
(define-const var2394 Bool (startsWith/-1785782452 var2462 "Identification of Mentions")) ; Statement: $z4 = virtualinvoke r7.<java.lang.String: boolean startsWith(java.lang.String)>("Identification of Mentions") 
 ; Statement: if $z4 == 0 goto i1 = i1 + 1 
(assert (not (= (ite var2394 1 0) 0))) ; Negate: Cond: $z4 == 0  
(assert true)
;(assert (info/114590825 var2995 var2462)) ; Statement: virtualinvoke r3.<java.util.logging.Logger: void info(java.lang.String)>(r7) 

(declare-const var2995!1 var2299)
(declare-const var2462!1 String)
 ; Statement: return 
(check-sat)
; {startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), info/114590825=([java.util.logging.Logger, java.lang.String], void)}
; {var578=r0, var1774=null_type, var2299=java.util.logging.Logger, var2995=r3, var2838=z0, var1509=r1, var2887=i0, var911=i1, var2462=r7, var2394=$z4}
; {r0=var578, null_type=var1774, java.util.logging.Logger=var2299, r3=var2995, z0=var2838, r1=var1509, i0=var2887, i1=var911, r7=var2462, $z4=var2394}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r3 := @parameter1: java.util.logging.Logger;	z0 := @parameter2: boolean;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	if z0 != 0 goto $r2 = new java.lang.StringBuilder;	i0 = lengthof r1;	i1 = 0;	if i1 >= i0 goto (branch);	r7 = r1[i1];	$z4 = virtualinvoke r7.<java.lang.String: boolean startsWith(java.lang.String)>("Identification of Mentions");	if $z4 == 0 goto i1 = i1 + 1;	virtualinvoke r3.<java.util.logging.Logger: void info(java.lang.String)>(r7);	return
;block_num 5
(get-model)
