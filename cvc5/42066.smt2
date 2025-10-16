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

(declare-sort var3360 0)
(declare-sort var1530 0)
(declare-sort var1231 0)
(declare-sort var1514 0)
(declare-sort var767 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1231_slurpFileNoExceptions/834711247 (String String) String)
(declare-fun arr-var767-init () (Array Int var767))
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun append/-1001720160 ((s String) (tail Int)) String (str.++ s (str.from_int tail)))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun cast-from-String-to-var767 (String) var767)
(declare-fun info/-657332264 (var1514 (Array Int var767)) void)
(declare-const null-var3360 var3360)
(declare-const null-String String)
(declare-const null-Bool Bool)
(declare-const var3360-logger var1514)
(declare-const null-__Array__Int__var767__ (Array Int var767))
(declare-const var593 var3360) ; Statement: r12 := @this: edu.stanford.nlp.wordseg.ChineseDictionary 
(assert (not (= var593 null-var3360)))
(declare-const var2838 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2838 null-String)))
(declare-const var3677 Bool) ; Statement: z0 := @parameter1: boolean 
(assert (not (= var3677 null-Bool)))
(define-const var2022 String (var1231_slurpFileNoExceptions/834711247 var2838 "utf-8")) ; Statement: r1 = staticinvoke <edu.stanford.nlp.io.IOUtils: java.lang.String slurpFileNoExceptions(java.lang.String,java.lang.String)>(r0, "utf-8") 
; split operation: var225 = var2022.split("\n") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(define-const var1132 var1514 var3360-logger) ; Statement: $r5 = <edu.stanford.nlp.wordseg.ChineseDictionary: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels logger> 
(define-const var2289 (Array Int var767) arr-var767-init) ; Statement: $r3 = newarray (java.lang.Object)[1] 
(define-const var3441 String String-init) ; Statement: $r4 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3441)) ; Statement: specialinvoke $r4.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3441!1 String)
(assert (= var3441!1 ""))
(assert true)
(define-const var1900 String (append/672562846 var3441!1 "  ")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("  ") 
(declare-const var3441!2 String)
(assert (= var3441!2 (str.++ var3441!1 "  ")))
(assert true)
(define-const var3969 String (append/672562846 var1900 var2838)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var1900!1 String)
(assert (= var1900!1 (str.++ var1900 var2838)))
(assert true)
(define-const var1646 String (append/672562846 var3969 ": ")) ; Statement: $r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(": ") 
(declare-const var3969!1 String)
(assert (= var3969!1 (str.++ var3969 ": ")))
(define-const var1257 Int (get_split_length var2022 "\n" -1)) ; Statement: $i0 = lengthof r2 
(assert true)
(define-const var2073 String (append/-1001720160 var1646 var1257)) ; Statement: $r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0) 
(declare-const var1646!1 String)
(assert (str.prefixof var1646 var1646!1))
(assert true)
(define-const var3471 String (append/672562846 var2073 " entries")) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" entries") 
(declare-const var2073!1 String)
(assert (= var2073!1 (str.++ var2073 " entries")))
(assert true)
(define-const var2615 String (toString/-2075883882 var3471)) ; Statement: $r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>() 
(declare-const var2289!1 (Array Int var767))
(assert (not (= var2289!1 null-__Array__Int__var767__)))
(assert (= (select var2289!1 0) (cast-from-String-to-var767 var2615))) ; Statement: $r3[0] = $r11 
(assert true)
;(assert (info/-657332264 var1132 var2289!1)) ; Statement: virtualinvoke $r5.<edu.stanford.nlp.util.logging.Redwood$RedwoodChannels: void info(java.lang.Object[])>($r3) 

(declare-const var1132!1 var1514)
(declare-const var2289!2 (Array Int var767))
(define-const var2755 Int (get_split_length var2022 "\n" -1)) ; Statement: i1 = lengthof r2 
(define-const var1096 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= i1 goto return 
(assert (>= var1096 var2755)) ; Cond: i2 >= i1 
 ; Statement: return 
(check-sat)
; {var1231_slurpFileNoExceptions/834711247=([java.lang.String, java.lang.String], java.lang.String), arr-var767-init=([], java.lang.Object[]), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), append/-1001720160=([java.lang.StringBuilder, int], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), cast-from-String-to-var767=([java.lang.String], java.lang.Object), info/-657332264=([edu.stanford.nlp.util.logging.Redwood$RedwoodChannels, java.lang.Object[]], void)}
; {var3360=edu.stanford.nlp.wordseg.ChineseDictionary, var593=r12, var2838=r0, var1530=null_type, var3677=z0, var1231=edu.stanford.nlp.io.IOUtils, var2022=r1, var225=r2, var1514=edu.stanford.nlp.util.logging.Redwood$RedwoodChannels, var1132=$r5, var767=java.lang.Object, var2289=$r3, var3441=$r4, var1900=$r6, var3969=$r7, var1646=$r8, var1257=$i0, var2073=$r9, var3471=$r10, var2615=$r11, var2755=i1, var1096=i2}
; {edu.stanford.nlp.wordseg.ChineseDictionary=var3360, r12=var593, r0=var2838, null_type=var1530, z0=var3677, edu.stanford.nlp.io.IOUtils=var1231, r1=var2022, r2=var225, edu.stanford.nlp.util.logging.Redwood$RedwoodChannels=var1514, $r5=var1132, java.lang.Object=var767, $r3=var2289, $r4=var3441, $r6=var1900, $r7=var3969, $r8=var1646, $i0=var1257, $r9=var2073, $r10=var3471, $r11=var2615, i1=var2755, i2=var1096}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(int)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 4,"<java.lang.StringBuilder: java.lang.StringBuilder append(int)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r12 := @this: edu.stanford.nlp.wordseg.ChineseDictionary;	r0 := @parameter0: java.lang.String;	z0 := @parameter1: boolean;	r1 = staticinvoke <edu.stanford.nlp.io.IOUtils: java.lang.String slurpFileNoExceptions(java.lang.String,java.lang.String)>(r0, "utf-8");	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	$r5 = <edu.stanford.nlp.wordseg.ChineseDictionary: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels logger>;	$r3 = newarray (java.lang.Object)[1];	$r4 = new java.lang.StringBuilder;	specialinvoke $r4.<java.lang.StringBuilder: void <init>()>();	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("  ");	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r8 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(": ");	$i0 = lengthof r2;	$r9 = virtualinvoke $r8.<java.lang.StringBuilder: java.lang.StringBuilder append(int)>($i0);	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" entries");	$r11 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.String toString()>();	$r3[0] = $r11;	virtualinvoke $r5.<edu.stanford.nlp.util.logging.Redwood$RedwoodChannels: void info(java.lang.Object[])>($r3);	i1 = lengthof r2;	i2 = 0;	if i2 >= i1 goto return;	return
;block_num 3
(get-model)
