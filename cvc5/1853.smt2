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

(declare-sort var423 0)
(declare-sort var2733 0)
(declare-sort var3156 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toString/1403215111 (var2733) String)
(declare-fun var3156-init () var3156)
(declare-fun <init>/-325640736 (var3156) void)
(declare-fun arr-String-init () (Array Int String))
(declare-const null-var423 var423)
(declare-const null-var2733 var2733)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var119 var423) ; Statement: r18 := @this: org.apache.logging.log4j.core.config.DefaultConfigurationFactory 
(assert (not (= var119 null-var423)))
(declare-const var3365 var2733) ; Statement: r0 := @parameter0: java.net.URI 
(assert (not (= var3365 null-var2733)))
(assert true)
(define-const var2401 String (toString/1403215111 var3365)) ; Statement: $r1 = virtualinvoke r0.<java.net.URI: java.lang.String toString()>() 
; split operation: var3281 = var2401.split("\u005c?") ; Statement: r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\?") 
(define-const var406 var3156 var3156-init) ; Statement: $r3 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var406)) ; Statement: specialinvoke $r3.<java.util.ArrayList: void <init>()>() 

(declare-const var406!1 var3156)
(define-const var1399 Int (get_split_length var2401 "\u005c?" -1)) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 <= 1 goto $r4 = newarray (java.lang.String)[1] 
(assert (<= var1399 1)) ; Cond: $i0 <= 1 
(define-const var1058 (Array Int String) arr-String-init) ; Statement: $r4 = newarray (java.lang.String)[1] 
(define-const var1152 String (get_split_element var2401 "\u005c?" -1 0)) ; Statement: $r5 = r2[0] 
(declare-const var1058!1 (Array Int String))
(assert (not (= var1058!1 null-__Array__Int__String__)))
(assert (= (select var1058!1 0) var1152)) ; Statement: $r4[0] = $r5 
 ; Statement: return $r4 
(check-sat)
; {toString/1403215111=([java.net.URI], java.lang.String), var3156-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), arr-String-init=([], java.lang.String[])}
; {var423=org.apache.logging.log4j.core.config.DefaultConfigurationFactory, var119=r18, var2733=java.net.URI, var3365=r0, var2401=$r1, var3281=r2, var3156=java.util.ArrayList, var406=$r3, var1399=$i0, var1058=$r4, var1152=$r5}
; {org.apache.logging.log4j.core.config.DefaultConfigurationFactory=var423, r18=var119, java.net.URI=var2733, r0=var3365, $r1=var2401, r2=var3281, java.util.ArrayList=var3156, $r3=var406, $i0=var1399, $r4=var1058, $r5=var1152}
;seq <java.net.URI: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r18 := @this: org.apache.logging.log4j.core.config.DefaultConfigurationFactory;	r0 := @parameter0: java.net.URI;	$r1 = virtualinvoke r0.<java.net.URI: java.lang.String toString()>();	r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\?");	$r3 = new java.util.ArrayList;	specialinvoke $r3.<java.util.ArrayList: void <init>()>();	$i0 = lengthof r2;	if $i0 <= 1 goto $r4 = newarray (java.lang.String)[1];	$r4 = newarray (java.lang.String)[1];	$r5 = r2[0];	$r4[0] = $r5;	return $r4
;block_num 2
(get-model)
