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

(declare-sort var522 0)
(declare-sort var3955 0)
(declare-sort var979 0)
(declare-sort var1253 0)
(declare-sort var1299 0)
(declare-sort var655 0)
(declare-sort var1370 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var979_requireNonNull/-961817614 (var1253) var1253)
(declare-fun cast-from-String-to-var1253 (String) var1253)
(declare-fun isLoggable/-616065502 (var1299 var655) Bool)
(define-fun indexOf/-1209756239 ((s String) (subs String)) Int (str.indexof s subs 0))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun resolve/784746797 (var522 String String) var1370)
(declare-const null-var522 var522)
(declare-const null-String String)
(declare-const var522-log var1299)
(declare-const var655-FINEST var655)
(declare-const var1223 var522) ; Statement: r3 := @this: org.jline.utils.StyleResolver 
(assert (not (= var1223 null-var522)))
(declare-const var1705 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1705 null-String)))
;(assert (var979_requireNonNull/-961817614 (cast-from-String-to-var1253 var1705))) ; Statement: staticinvoke <java.util.Objects: java.lang.Object requireNonNull(java.lang.Object)>(r0) 

(declare-const var1705!1 String)
(define-const var2645 var1299 var522-log) ; Statement: $r2 = <org.jline.utils.StyleResolver: java.util.logging.Logger log> 
(define-const var3193 var655 var655-FINEST) ; Statement: $r1 = <java.util.logging.Level: java.util.logging.Level FINEST> 
(assert true)
(define-const var545 Bool (isLoggable/-616065502 var2645 var3193)) ; Statement: $z0 = virtualinvoke $r2.<java.util.logging.Logger: boolean isLoggable(java.util.logging.Level)>($r1) 
 ; Statement: if $z0 == 0 goto $i0 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":-") 
(assert (= (ite var545 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var335 Int (indexOf/-1209756239 var1705!1 ":-")) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":-") 
(define-const var585 Int (cast-from-Int-to-Int -1)) ; Statement: $i2 = (int) -1 
 ; Statement: if $i0 == $i2 goto $r4 = <org.jline.utils.AttributedStyle: org.jline.utils.AttributedStyle DEFAULT> 
(assert (not (= var335 var585))) ; Negate: Cond: $i0 == $i2  
; split operation: var3080 = var1705!1.split(":-") ; Statement: r6 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(":-") 
(define-const var38 String (get_split_element var1705!1 ":-" -1 0)) ; Statement: $r7 = r6[0] 
(assert true)
(define-const var2707 String (trim/-847153721 var38)) ; Statement: $r10 = virtualinvoke $r7.<java.lang.String: java.lang.String trim()>() 
(define-const var3400 String (get_split_element var1705!1 ":-" -1 1)) ; Statement: $r8 = r6[1] 
(assert true)
(define-const var3147 String (trim/-847153721 var3400)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.String: java.lang.String trim()>() 
(assert true)
(define-const var2476 var1370 (resolve/784746797 var1223 var2707 var3147)) ; Statement: $r11 = virtualinvoke r3.<org.jline.utils.StyleResolver: org.jline.utils.AttributedStyle resolve(java.lang.String,java.lang.String)>($r10, $r9) 
 ; Statement: return $r11 
(check-sat)
; {var979_requireNonNull/-961817614=([java.lang.Object], java.lang.Object), cast-from-String-to-var1253=([java.lang.String], java.lang.Object), isLoggable/-616065502=([java.util.logging.Logger, java.util.logging.Level], boolean), indexOf/-1209756239=([java.lang.String, java.lang.String], int), cast-from-Int-to-Int=([int], int), trim/-847153721=([java.lang.String], java.lang.String), resolve/784746797=([org.jline.utils.StyleResolver, java.lang.String, java.lang.String], org.jline.utils.AttributedStyle)}
; {var522=org.jline.utils.StyleResolver, var1223=r3, var1705=r0, var3955=null_type, var979=java.util.Objects, var1253=java.lang.Object, var1299=java.util.logging.Logger, var2645=$r2, var655=java.util.logging.Level, var3193=$r1, var545=$z0, var335=$i0, var585=$i2, var3080=r6, var38=$r7, var2707=$r10, var3400=$r8, var3147=$r9, var1370=org.jline.utils.AttributedStyle, var2476=$r11}
; {org.jline.utils.StyleResolver=var522, r3=var1223, r0=var1705, null_type=var3955, java.util.Objects=var979, java.lang.Object=var1253, java.util.logging.Logger=var1299, $r2=var2645, java.util.logging.Level=var655, $r1=var3193, $z0=var545, $i0=var335, $i2=var585, r6=var3080, $r7=var38, $r10=var2707, $r8=var3400, $r9=var3147, org.jline.utils.AttributedStyle=var1370, $r11=var2476}
;seq <java.lang.String: int indexOf(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String trim()>
;cnt {"<java.lang.String: int indexOf(java.lang.String)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: java.lang.String trim()>": 2}
;stmts r3 := @this: org.jline.utils.StyleResolver;	r0 := @parameter0: java.lang.String;	staticinvoke <java.util.Objects: java.lang.Object requireNonNull(java.lang.Object)>(r0);	$r2 = <org.jline.utils.StyleResolver: java.util.logging.Logger log>;	$r1 = <java.util.logging.Level: java.util.logging.Level FINEST>;	$z0 = virtualinvoke $r2.<java.util.logging.Logger: boolean isLoggable(java.util.logging.Level)>($r1);	if $z0 == 0 goto $i0 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":-");	$i0 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>(":-");	$i2 = (int) -1;	if $i0 == $i2 goto $r4 = <org.jline.utils.AttributedStyle: org.jline.utils.AttributedStyle DEFAULT>;	r6 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(":-");	$r7 = r6[0];	$r10 = virtualinvoke $r7.<java.lang.String: java.lang.String trim()>();	$r8 = r6[1];	$r9 = virtualinvoke $r8.<java.lang.String: java.lang.String trim()>();	$r11 = virtualinvoke r3.<org.jline.utils.StyleResolver: org.jline.utils.AttributedStyle resolve(java.lang.String,java.lang.String)>($r10, $r9);	return $r11
;block_num 3
(get-model)
