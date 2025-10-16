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

(declare-sort var2379 0)
(declare-sort var71 0)
(declare-sort var628 0)
(declare-sort var1894 0)
(declare-sort var2567 0)
(declare-sort var1214 0)
(declare-sort var2251 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun replace/2138489945 ((s String) (old String) (new String)) String (str.replace_all s old new))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun var1894_info/79011599 (var1894 String var2567) void)
(declare-fun cast-from-var628-to-var2567 (var628) var2567)
(declare-fun pageNumbers/1418557443 (var2379) var1214)
(declare-fun Int_valueOf/-1371140006 (Int) Int)
(declare-fun var1214_put/1464166817 (var1214 var2251 var2251) var2251)
(declare-fun cast-from-String-to-var2251 (String) var2251)
(declare-fun cast-from-Int-to-var2251 (Int) var2251)
(declare-const null-var2379 var2379)
(declare-const null-String String)
(declare-const null-var628 var628)
(declare-const var2379-log var1894)
(declare-const var1217 var2379) ; Statement: r6 := @this: org.docx4j.toc.TocPageNumbersHandler 
(assert (not (= var1217 null-var2379)))
(declare-const var2418 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2418 null-String)))
; split operation: var132 = var2418.split(",") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var330 String (get_split_element var2418 "," -1 1)) ; Statement: $r2 = r1[1] 
(assert true)
(define-const var1927 String (replace/2138489945 var330 (cast-from-String-to-String ")") (cast-from-String-to-String ""))) ; Statement: r3 = virtualinvoke $r2.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>(")", "") 
(define-const var135 Int 1) ; Statement: i0 = 1 
(define-const var1098 String (get_split_element var2418 "," -1 0)) ; Statement: $r4 = r1[0] 
(assert true) ; Handling Exception: java.lang.Throwable 
(declare-const var2754 var628) ; Statement: $r9 := @caughtexception 
(assert (not (= var2754 null-var628)))
(define-const var2883 var1894 var2379-log) ; Statement: $r10 = <org.docx4j.toc.TocPageNumbersHandler: org.slf4j.Logger log> 
(define-const var3471 String (str.++ "Invalid page number: \u0001" var2418)) ; Statement: $r11 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.String)>(r0) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("Invalid page number: \u0001") 
;(assert (var1894_info/79011599 var2883 var3471 (cast-from-var628-to-var2567 var2754))) ; Statement: interfaceinvoke $r10.<org.slf4j.Logger: void info(java.lang.String,java.lang.Throwable)>($r11, $r9) 

(declare-const var2883!1 var1894)
(declare-const var3471!1 String)
(declare-const var2754!1 var628)
(assert true) ; Non Conditional
(define-const var1410 var1214 (pageNumbers/1418557443 var1217)) ; Statement: $r7 = r6.<org.docx4j.toc.TocPageNumbersHandler: java.util.Map pageNumbers> 
(define-const var3198 Int (Int_valueOf/-1371140006 var135)) ; Statement: $r8 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0) 
;(assert (var1214_put/1464166817 var1410 (cast-from-String-to-var2251 var1927) (cast-from-Int-to-var2251 var3198))) ; Statement: interfaceinvoke $r7.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r3, $r8) 

(declare-const var1410!1 var1214)
(declare-const var1927!1 String)
(declare-const var3198!1 Int)
 ; Statement: return 
(check-sat)
; {replace/2138489945=([java.lang.String, java.lang.CharSequence, java.lang.CharSequence], java.lang.String), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), var1894_info/79011599=([org.slf4j.Logger, java.lang.String, java.lang.Throwable], void), cast-from-var628-to-var2567=([java.lang.NumberFormatException], java.lang.Throwable), pageNumbers/1418557443=([org.docx4j.toc.TocPageNumbersHandler], java.util.Map), Int_valueOf/-1371140006=([int], java.lang.Integer), var1214_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var2251=([java.lang.String], java.lang.Object), cast-from-Int-to-var2251=([java.lang.Integer], java.lang.Object)}
; {var2379=org.docx4j.toc.TocPageNumbersHandler, var1217=r6, var2418=r0, var71=null_type, var132=r1, var330=$r2, var1927=r3, var135=i0, var1098=$r4, var628=java.lang.NumberFormatException, var2754=$r9, var1894=org.slf4j.Logger, var2883=$r10, var3471=$r11, var2567=java.lang.Throwable, var1214=java.util.Map, var1410=$r7, var3198=$r8, var2251=java.lang.Object}
; {org.docx4j.toc.TocPageNumbersHandler=var2379, r6=var1217, r0=var2418, null_type=var71, r1=var132, $r2=var330, r3=var1927, i0=var135, $r4=var1098, java.lang.NumberFormatException=var628, $r9=var2754, org.slf4j.Logger=var1894, $r10=var2883, $r11=var3471, java.lang.Throwable=var2567, java.util.Map=var1214, $r7=var1410, $r8=var3198, java.lang.Object=var2251}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>": 1}
;stmts r6 := @this: org.docx4j.toc.TocPageNumbersHandler;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$r2 = r1[1];	r3 = virtualinvoke $r2.<java.lang.String: java.lang.String replace(java.lang.CharSequence,java.lang.CharSequence)>(")", "");	i0 = 1;	$r4 = r1[0];	$r9 := @caughtexception;	$r10 = <org.docx4j.toc.TocPageNumbersHandler: org.slf4j.Logger log>;	$r11 = dynamicinvoke "makeConcatWithConstants" <java.lang.String (java.lang.String)>(r0) <java.lang.invoke.StringConcatFactory: java.lang.invoke.CallSite makeConcatWithConstants(java.lang.invoke.MethodHandles$Lookup,java.lang.String,java.lang.invoke.MethodType,java.lang.String,java.lang.Object[])>("Invalid page number: \u0001");	interfaceinvoke $r10.<org.slf4j.Logger: void info(java.lang.String,java.lang.Throwable)>($r11, $r9);	$r7 = r6.<org.docx4j.toc.TocPageNumbersHandler: java.util.Map pageNumbers>;	$r8 = staticinvoke <java.lang.Integer: java.lang.Integer valueOf(int)>(i0);	interfaceinvoke $r7.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r3, $r8);	return
;block_num 3
(get-model)
