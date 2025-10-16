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

(declare-sort var546 0)
(declare-sort var1403 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getPath/39698060 (var546) String)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var1403-init () var1403)
(declare-fun <init>/875830710 (var1403 String) void)
(declare-const null-var546 var546)
(declare-const var1012 var546) ; Statement: r1 := @parameter0: java.net.URI 
(assert (not (= var1012 null-var546)))
(declare-const var1175 var546) ; Statement: r4 := @parameter1: java.net.URI 
(assert (not (= var1175 null-var546)))
(define-const var1132 String String-init) ; Statement: $r25 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1132)) ; Statement: specialinvoke $r25.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1132!1 String)
(assert (= var1132!1 ""))
(assert true)
(define-const var520 String (getPath/39698060 var1012)) ; Statement: $r2 = virtualinvoke r1.<java.net.URI: java.lang.String getPath()>() 
(define-const var594 Int (cast-from-Int-to-Int -1)) ; Statement: $i25 = (int) -1 
; split operation: var911 = var520.split("/", var594) ; Statement: r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("/", $i25) 
(assert true)
(define-const var2564 String (getPath/39698060 var1175)) ; Statement: $r5 = virtualinvoke r4.<java.net.URI: java.lang.String getPath()>() 
(define-const var1345 Int (cast-from-Int-to-Int -1)) ; Statement: $i27 = (int) -1 
; split operation: var2844 = var2564.split("/", var1345) ; Statement: r6 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("/", $i27) 
(define-const var2014 Int (get_split_length var520 "/" var594)) ; Statement: $i0 = lengthof r3 
 ; Statement: if $i0 != 0 goto $i1 = lengthof r6 
(assert (not (not (= var2014 0)))) ; Negate: Cond: $i0 != 0  
(define-const var2449 var1403 var1403-init) ; Statement: $r26 = new java.lang.IllegalArgumentException 
(assert true)
;(assert (<init>/875830710 var2449 "Can\u0027t relativize an empty source URI !")) ; Statement: specialinvoke $r26.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Can\'t relativize an empty source URI !") 

(declare-const var2449!1 var1403)
(declare-const var2318 String)
 ; Statement: throw $r26 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getPath/39698060=([java.net.URI], java.lang.String), cast-from-Int-to-Int=([int], int), var1403-init=([], java.lang.IllegalArgumentException), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var546=java.net.URI, var1012=r1, var1175=r4, var1132=$r25, var520=$r2, var594=$i25, var911=r3, var2564=$r5, var1345=$i27, var2844=r6, var2014=$i0, var1403=java.lang.IllegalArgumentException, var2449=$r26, var2318="Can\'t relativize an empty source URI !"}
; {java.net.URI=var546, r1=var1012, r4=var1175, $r25=var1132, $r2=var520, $i25=var594, r3=var911, $r5=var2564, $i27=var1345, r6=var2844, $i0=var2014, java.lang.IllegalArgumentException=var1403, $r26=var2449, "Can\'t relativize an empty source URI !"=var2318}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.String: java.lang.String[] split(java.lang.String,int)>;	<java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 2}
;stmts r1 := @parameter0: java.net.URI;	r4 := @parameter1: java.net.URI;	$r25 = new java.lang.StringBuilder;	specialinvoke $r25.<java.lang.StringBuilder: void <init>()>();	$r2 = virtualinvoke r1.<java.net.URI: java.lang.String getPath()>();	$i25 = (int) -1;	r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("/", $i25);	$r5 = virtualinvoke r4.<java.net.URI: java.lang.String getPath()>();	$i27 = (int) -1;	r6 = virtualinvoke $r5.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("/", $i27);	$i0 = lengthof r3;	if $i0 != 0 goto $i1 = lengthof r6;	$r26 = new java.lang.IllegalArgumentException;	specialinvoke $r26.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>("Can\'t relativize an empty source URI !");	throw $r26
;block_num 2
(get-model)
