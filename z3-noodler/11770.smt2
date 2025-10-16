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

(declare-sort var3493 0)
(declare-sort var466 0)
(declare-sort var3261 0)
(declare-sort var1750 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun info/114590825 (var466 String) void)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun var1750-init () var1750)
(declare-fun <init>/451842749 (var1750) void)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var3261-logger var466)
(declare-const var1437 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1437 null-String)))
(declare-const var1968 (Array Int String)) ; Statement: r18 := @parameter1: java.lang.String[] 
(assert (not (= var1968 null-__Array__Int__String__)))
(define-const var223 var466 var3261-logger) ; Statement: $r1 = <edu.stanford.nlp.ie.machinereading.MachineReadingProperties: java.util.logging.Logger logger> 
(define-const var2638 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2638)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2638!1 String)
(assert (= var2638!1 ""))
(assert true)
(define-const var683 String (append/672562846 var2638!1 "Making result printers from ")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Making result printers from ") 
(declare-const var2638!2 String)
(assert (= var2638!2 (str.++ var2638!1 "Making result printers from ")))
(assert true)
(define-const var1535 String (append/672562846 var683 var1437)) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2) 
(declare-const var683!1 String)
(assert (= var683!1 (str.++ var683 var1437)))
(assert true)
(define-const var118 String (toString/-2075883882 var1535)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (info/114590825 var223 var118)) ; Statement: virtualinvoke $r1.<java.util.logging.Logger: void info(java.lang.String)>($r5) 

(declare-const var223!1 var466)
(declare-const var118!1 String)
(assert true)
(define-const var240 String (trim/-847153721 var1437)) ; Statement: $r6 = virtualinvoke r2.<java.lang.String: java.lang.String trim()>() 
; split operation: var535 = var240.split(",\u005cs*") ; Statement: r7 = virtualinvoke $r6.<java.lang.String: java.lang.String[] split(java.lang.String)>(",\\s*") 
(define-const var407 var1750 var1750-init) ; Statement: $r8 = new java.util.HashSet 
(assert true)
;(assert (<init>/451842749 var407)) ; Statement: specialinvoke $r8.<java.util.HashSet: void <init>()>() 

(declare-const var407!1 var1750)
(define-const var71 Int (get_split_length var240 ",\u005cs*" -1)) ; Statement: i0 = lengthof r7 
(define-const var3363 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto return $r8 
(assert (>= var3363 var71)) ; Cond: i1 >= i0 
 ; Statement: return $r8 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), info/114590825=([java.util.logging.Logger, java.lang.String], void), trim/-847153721=([java.lang.String], java.lang.String), var1750-init=([], java.util.HashSet), <init>/451842749=([java.util.HashSet], void)}
; {var1437=r2, var3493=null_type, var1968=r18, var466=java.util.logging.Logger, var3261=edu.stanford.nlp.ie.machinereading.MachineReadingProperties, var223=$r1, var2638=$r0, var683=$r3, var1535=$r4, var118=$r5, var240=$r6, var535=r7, var1750=java.util.HashSet, var407=$r8, var71=i0, var3363=i1}
; {r2=var1437, null_type=var3493, r18=var1968, java.util.logging.Logger=var466, edu.stanford.nlp.ie.machinereading.MachineReadingProperties=var3261, $r1=var223, $r0=var2638, $r3=var683, $r4=var1535, $r5=var118, $r6=var240, r7=var535, java.util.HashSet=var1750, $r8=var407, i0=var71, i1=var3363}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: java.lang.String trim()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r2 := @parameter0: java.lang.String;	r18 := @parameter1: java.lang.String[];	$r1 = <edu.stanford.nlp.ie.machinereading.MachineReadingProperties: java.util.logging.Logger logger>;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Making result printers from ");	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r2);	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r1.<java.util.logging.Logger: void info(java.lang.String)>($r5);	$r6 = virtualinvoke r2.<java.lang.String: java.lang.String trim()>();	r7 = virtualinvoke $r6.<java.lang.String: java.lang.String[] split(java.lang.String)>(",\\s*");	$r8 = new java.util.HashSet;	specialinvoke $r8.<java.util.HashSet: void <init>()>();	i0 = lengthof r7;	i1 = 0;	if i1 >= i0 goto return $r8;	return $r8
;block_num 3
(get-model)
