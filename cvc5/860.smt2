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

(declare-sort var2722 0)
(declare-sort var3102 0)
(declare-sort var2263 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3102-init () var3102)
(declare-fun <init>/598147663 (var3102) void)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var2263-init () var2263)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/-1253962986 (var2263 String) void)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var3533 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3533 null-String)))
(declare-const var1852 Bool) ; Statement: z0 := @parameter1: boolean 
(assert (not (= var1852 null-Bool)))
(define-const var3209 var3102 var3102-init) ; Statement: $r30 = new edu.stanford.nlp.ling.CoreLabel 
(assert true)
;(assert (<init>/598147663 var3209)) ; Statement: specialinvoke $r30.<edu.stanford.nlp.ling.CoreLabel: void <init>()>() 

(declare-const var3209!1 var3102)
(define-const var3434 Int (cast-from-Int-to-Int -1)) ; Statement: $i14 = (int) -1 
; split operation: var1390 = var3533.split("\t", var3434) ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\t", $i14) 
(define-const var2509 Int (get_split_length var3533 "\t" var3434)) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 >= 7 goto $r3 = r2[0] 
(assert (not (>= var2509 7))) ; Negate: Cond: $i0 >= 7  
(define-const var3995 var2263 var2263-init) ; Statement: $r32 = new edu.stanford.nlp.io.RuntimeIOException 
(define-const var852 String String-init) ; Statement: $r31 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var852)) ; Statement: specialinvoke $r31.<java.lang.StringBuilder: void <init>()>() 
(declare-const var852!1 String)
(assert (= var852!1 ""))
(assert true)
(define-const var946 String (append/672562846 var852!1 "ERROR: Invalid format token for serialized token (only ")) ; Statement: $r23 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ERROR: Invalid format token for serialized token (only ") 
(declare-const var852!2 String)
(assert (= var852!2 (str.++ var852!1 "ERROR: Invalid format token for serialized token (only ")))
(define-const var851 Int (get_split_length var3533 "\t" var3434)) ; Statement: $i11 = lengthof r2 
(assert true)
(define-const var2691 String (append/-1001720160 var946 var851)) ; Statement: $r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i11) 
(declare-const var946!1 String)
(assert (str.prefixof var946 var946!1))
(assert true)
(define-const var2879 String (append/672562846 var2691 " tokens): ")) ; Statement: $r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" tokens): ") 
(declare-const var2691!1 String)
(assert (= var2691!1 (str.++ var2691 " tokens): ")))
(assert true)
(define-const var2453 String (append/672562846 var2879 var3533)) ; Statement: $r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1) 
(declare-const var2879!1 String)
(assert (= var2879!1 (str.++ var2879 var3533)))
(assert true)
(define-const var916 String (toString/-2075883882 var2453)) ; Statement: $r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-1253962986 var3995 var916)) ; Statement: specialinvoke $r32.<edu.stanford.nlp.io.RuntimeIOException: void <init>(java.lang.String)>($r27) 

(declare-const var3995!1 var2263)
(declare-const var916!1 String)
 ; Statement: throw $r32 
(check-sat)
; {var3102-init=([], edu.stanford.nlp.ling.CoreLabel), <init>/598147663=([edu.stanford.nlp.ling.CoreLabel], void), cast-from-Int-to-Int=([int], int), var2263-init=([], edu.stanford.nlp.io.RuntimeIOException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/-1253962986=([edu.stanford.nlp.io.RuntimeIOException, java.lang.String], void)}
; {var3533=r1, var2722=null_type, var1852=z0, var3102=edu.stanford.nlp.ling.CoreLabel, var3209=$r30, var3434=$i14, var1390=r2, var2509=$i0, var2263=edu.stanford.nlp.io.RuntimeIOException, var3995=$r32, var852=$r31, var946=$r23, var851=$i11, var2691=$r24, var2879=$r25, var2453=$r26, var916=$r27}
; {r1=var3533, null_type=var2722, z0=var1852, edu.stanford.nlp.ling.CoreLabel=var3102, $r30=var3209, $i14=var3434, r2=var1390, $i0=var2509, edu.stanford.nlp.io.RuntimeIOException=var2263, $r32=var3995, $r31=var852, $r23=var946, $i11=var851, $r24=var2691, $r25=var2879, $r26=var2453, $r27=var916}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @parameter0: java.lang.String;	z0 := @parameter1: boolean;	$r30 = new edu.stanford.nlp.ling.CoreLabel;	specialinvoke $r30.<edu.stanford.nlp.ling.CoreLabel: void <init>()>();	$i14 = (int) -1;	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\t", $i14);	$i0 = lengthof r2;	if $i0 >= 7 goto $r3 = r2[0];	$r32 = new edu.stanford.nlp.io.RuntimeIOException;	$r31 = new java.lang.StringBuilder;	specialinvoke $r31.<java.lang.StringBuilder: void <init>()>();	$r23 = virtualinvoke $r31.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("ERROR: Invalid format token for serialized token (only ");	$i11 = lengthof r2;	$r24 = virtualinvoke $r23.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i11);	$r25 = virtualinvoke $r24.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" tokens): ");	$r26 = virtualinvoke $r25.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r1);	$r27 = virtualinvoke $r26.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r32.<edu.stanford.nlp.io.RuntimeIOException: void <init>(java.lang.String)>($r27);	throw $r32
;block_num 2
(get-model)
