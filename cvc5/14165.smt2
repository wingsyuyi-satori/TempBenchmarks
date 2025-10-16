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

(declare-sort var454 0)
(declare-sort var2347 0)
(declare-sort var3002 0)
(declare-sort var3046 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2347_debug/594372212 (var2347 String) void)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var3046-init () var3046)
(declare-fun <init>/-1053635008 (var3046 String) void)
(declare-const null-String String)
(declare-const var3002-log var2347)
(declare-const var1017 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1017 null-String)))
(define-const var85 var2347 var3002-log) ; Statement: $r1 = <org.docx4j.model.fields.FormattingSwitchHelper: org.slf4j.Logger log> 
(define-const var424 String (str.++ "\u0001 to Locale" var1017)) ; Statement: $r2 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.String)>(r0) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001 to Locale") 
;(assert (var2347_debug/594372212 var85 var424)) ; Statement: interfaceinvoke $r1.<org.slf4j.Logger: void debug(java.lang.String)>($r2) 

(declare-const var85!1 var2347)
(declare-const var424!1 String)
(define-const var1387 Int (cast-from-Int-to-Int -1)) ; Statement: $i3 = (int) -1 
; split operation: var2160 = var1017.split("-", var1387) ; Statement: r3 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("-", $i3) 
(define-const var1499 Int (get_split_length var1017 "-" var1387)) ; Statement: $i0 = lengthof r3 
 ; Statement: if $i0 != 1 goto $i1 = lengthof r3 
(assert (not (not (= var1499 1)))) ; Negate: Cond: $i0 != 1  
(define-const var3690 var3046 var3046-init) ; Statement: $r13 = new java.util.Locale 
(define-const var3546 String (get_split_element var1017 "-" var1387 0)) ; Statement: $r12 = r3[0] 
(assert true)
;(assert (<init>/-1053635008 var3690 var3546)) ; Statement: specialinvoke $r13.<java.util.Locale: void <init>(java.lang.String)>($r12) 

(declare-const var3690!1 var3046)
(declare-const var3546!1 String)
 ; Statement: return $r13 
(check-sat)
; {var2347_debug/594372212=([org.slf4j.Logger, java.lang.String], void), cast-from-Int-to-Int=([int], int), var3046-init=([], java.util.Locale), <init>/-1053635008=([java.util.Locale, java.lang.String], void)}
; {var1017=r0, var454=null_type, var2347=org.slf4j.Logger, var3002=org.docx4j.model.fields.FormattingSwitchHelper, var85=$r1, var424=$r2, var1387=$i3, var2160=r3, var1499=$i0, var3046=java.util.Locale, var3690=$r13, var3546=$r12}
; {r0=var1017, null_type=var454, org.slf4j.Logger=var2347, org.docx4j.model.fields.FormattingSwitchHelper=var3002, $r1=var85, $r2=var424, $i3=var1387, r3=var2160, $i0=var1499, java.util.Locale=var3046, $r13=var3690, $r12=var3546}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = <org.docx4j.model.fields.FormattingSwitchHelper: org.slf4j.Logger log>;	$r2 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.String)>(r0) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("\u0001 to Locale");	interfaceinvoke $r1.<org.slf4j.Logger: void debug(java.lang.String)>($r2);	$i3 = (int) -1;	r3 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("-", $i3);	$i0 = lengthof r3;	if $i0 != 1 goto $i1 = lengthof r3;	$r13 = new java.util.Locale;	$r12 = r3[0];	specialinvoke $r13.<java.util.Locale: void <init>(java.lang.String)>($r12);	return $r13
;block_num 2
(get-model)
