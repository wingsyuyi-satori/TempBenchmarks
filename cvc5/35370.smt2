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

(declare-sort var241 0)
(declare-sort var639 0)
(declare-sort var3904 0)
(declare-sort var1373 0)
(declare-sort var2806 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun var3904_newHashMap/701256970 () var639)
(declare-fun var639_put/1464166817 (var639 var1373 var1373) var1373)
(declare-fun cast-from-String-to-var1373 (String) var1373)
(declare-fun var2806-init () var2806)
(declare-fun <init>/379364885 (var2806) void)
(declare-fun var639_get/1088891777 (var639 var1373) var1373)
(declare-fun cast-from-var1373-to-String (var1373) String)
(declare-fun setWord/1927702860 (var2806 String) void)
(declare-fun setLemma/-2044772538 (var2806 String) void)
(declare-fun setTag/-492450796 (var2806 String) void)
(declare-fun setValue/-1305364003 (var2806 String) void)
(declare-fun setOriginalText/-1052378824 (var2806 String) void)
(declare-const null-String String)
(declare-const var166 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var166 null-String)))
(assert true)
(define-const var1528 Int (length/-134980193 var166)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(define-const var2580 Int (- var1528 1)) ; Statement: $i1 = $i0 - 1 
(assert (and true (and (>= 1 0) (>= (str.len var166) var2580) (>= var2580 1))))
(define-const var3601 String (substring/-1240304868 var166 1 var2580)) ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(1, $i1) 
; split operation: var1826 = var3601.split(" ") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ") 
(define-const var1419 var639 var3904_newHashMap/701256970) ; Statement: r3 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Map newHashMap()>() 
(define-const var1266 Int (get_split_length var3601 " " -1)) ; Statement: i2 = lengthof r2 
(define-const var1104 Int 0) ; Statement: i4 = 0 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord 
(assert (not (>= var1104 var1266))) ; Negate: Cond: i4 >= i2  
(define-const var809 String (get_split_element var3601 " " -1 var1104)) ; Statement: r15 = r2[i4] 
; split operation: var776 = var809.split("=") ; Statement: r16 = virtualinvoke r15.<java.lang.String: java.lang.String[] split(java.lang.String)>("=") 
(define-const var3021 String (get_split_element var809 "=" -1 0)) ; Statement: r17 = r16[0] 
(define-const var1861 String "") ; Statement: r18 = "" 
(define-const var1225 Int (get_split_length var809 "=" -1)) ; Statement: $i3 = lengthof r16 
 ; Statement: if $i3 != 2 goto interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18) 
(assert (not (not (= var1225 2)))) ; Negate: Cond: $i3 != 2  
(define-const var1861!1 String (get_split_element var809 "=" -1 1)) ; Statement: r18 = r16[1] 
(assert true) ; Non Conditional
;(assert (var639_put/1464166817 var1419 (cast-from-String-to-var1373 var3021) (cast-from-String-to-var1373 var1861!1))) ; Statement: interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18) 

(declare-const var1419!1 var639)
(declare-const var3021!1 String)
(declare-const var1861!2 String)
(define-const var1104!1 Int (+ var1104 1)) ; Statement: i4 = i4 + 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord 
(assert (not (>= var1104!1 var1266))) ; Negate: Cond: i4 >= i2  
(define-const var809!1 String (get_split_element var3601 " " -1 var1104!1)) ; Statement: r15 = r2[i4] 
; split operation: var776!1 = var809!1.split("=") ; Statement: r16 = virtualinvoke r15.<java.lang.String: java.lang.String[] split(java.lang.String)>("=") 
(define-const var3021!2 String (get_split_element var809!1 "=" -1 0)) ; Statement: r17 = r16[0] 
(define-const var1861!3 String "") ; Statement: r18 = "" 
(define-const var1225!1 Int (get_split_length var809!1 "=" -1)) ; Statement: $i3 = lengthof r16 
 ; Statement: if $i3 != 2 goto interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18) 
(assert (not (= var1225!1 2))) ; Cond: $i3 != 2 
;(assert (var639_put/1464166817 var1419!1 (cast-from-String-to-var1373 var3021!2) (cast-from-String-to-var1373 var1861!3))) ; Statement: interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18) 

(declare-const var1419!2 var639)
(declare-const var3021!3 String)
(declare-const var1861!4 String)
(define-const var1104!2 Int (+ var1104!1 1)) ; Statement: i4 = i4 + 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord 
(assert (>= var1104!2 var1266)) ; Cond: i4 >= i2 
(define-const var413 var2806 var2806-init) ; Statement: $r4 = new edu.stanford.nlp.ling.IndexedWord 
(assert true)
;(assert (<init>/379364885 var413)) ; Statement: specialinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void <init>()>() 

(declare-const var413!1 var2806)
(define-const var1180 var1373 (var639_get/1088891777 var1419!2 (cast-from-String-to-var1373 "word"))) ; Statement: $r5 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("word") 
(define-const var1112 String (cast-from-var1373-to-String var1180)) ; Statement: $r6 = (java.lang.String) $r5 
(assert true)
;(assert (setWord/1927702860 var413!1 var1112)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setWord(java.lang.String)>($r6) 

(declare-const var413!2 var2806)
(declare-const var1112!1 String)
(define-const var1725 var1373 (var639_get/1088891777 var1419!2 (cast-from-String-to-var1373 "lemma"))) ; Statement: $r7 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("lemma") 
(define-const var3606 String (cast-from-var1373-to-String var1725)) ; Statement: $r8 = (java.lang.String) $r7 
(assert true)
;(assert (setLemma/-2044772538 var413!2 var3606)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setLemma(java.lang.String)>($r8) 

(declare-const var413!3 var2806)
(declare-const var3606!1 String)
(define-const var344 var1373 (var639_get/1088891777 var1419!2 (cast-from-String-to-var1373 "POS"))) ; Statement: $r9 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("POS") 
(define-const var211 String (cast-from-var1373-to-String var344)) ; Statement: $r10 = (java.lang.String) $r9 
(assert true)
;(assert (setTag/-492450796 var413!3 var211)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setTag(java.lang.String)>($r10) 

(declare-const var413!4 var2806)
(declare-const var211!1 String)
(define-const var3651 var1373 (var639_get/1088891777 var1419!2 (cast-from-String-to-var1373 "value"))) ; Statement: $r11 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("value") 
(define-const var1256 String (cast-from-var1373-to-String var3651)) ; Statement: $r12 = (java.lang.String) $r11 
(assert true)
;(assert (setValue/-1305364003 var413!4 var1256)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setValue(java.lang.String)>($r12) 

(declare-const var413!5 var2806)
(declare-const var1256!1 String)
(define-const var452 var1373 (var639_get/1088891777 var1419!2 (cast-from-String-to-var1373 "current"))) ; Statement: $r13 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("current") 
(define-const var2694 String (cast-from-var1373-to-String var452)) ; Statement: $r14 = (java.lang.String) $r13 
(assert true)
;(assert (setOriginalText/-1052378824 var413!5 var2694)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setOriginalText(java.lang.String)>($r14) 

(declare-const var413!6 var2806)
(declare-const var2694!1 String)
 ; Statement: return $r4 
(check-sat)
; {length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), var3904_newHashMap/701256970=([], java.util.Map), var639_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var1373=([java.lang.String], java.lang.Object), var2806-init=([], edu.stanford.nlp.ling.IndexedWord), <init>/379364885=([edu.stanford.nlp.ling.IndexedWord], void), var639_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var1373-to-String=([java.lang.Object], java.lang.String), setWord/1927702860=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setLemma/-2044772538=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setTag/-492450796=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setValue/-1305364003=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setOriginalText/-1052378824=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void)}
; {var166=r0, var241=null_type, var1528=$i0, var2580=$i1, var3601=r1, var1826=r2, var639=java.util.Map, var3904=edu.stanford.nlp.util.Generics, var1419=r3, var1266=i2, var1104=i4, var809=r15, var776=r16, var3021=r17, var1861=r18, var1225=$i3, var1373=java.lang.Object, var2806=edu.stanford.nlp.ling.IndexedWord, var413=$r4, var1180=$r5, var1112=$r6, var1725=$r7, var3606=$r8, var344=$r9, var211=$r10, var3651=$r11, var1256=$r12, var452=$r13, var2694=$r14}
; {r0=var166, null_type=var241, $i0=var1528, $i1=var2580, r1=var3601, r2=var1826, java.util.Map=var639, edu.stanford.nlp.util.Generics=var3904, r3=var1419, i2=var1266, i4=var1104, r15=var809, r16=var776, r17=var3021, r18=var1861, $i3=var1225, java.lang.Object=var1373, edu.stanford.nlp.ling.IndexedWord=var2806, $r4=var413, $r5=var1180, $r6=var1112, $r7=var1725, $r8=var3606, $r9=var344, $r10=var211, $r11=var3651, $r12=var1256, $r13=var452, $r14=var2694}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 3}
;stmts r0 := @parameter0: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	$i1 = $i0 - 1;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(1, $i1);	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	r3 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Map newHashMap()>();	i2 = lengthof r2;	i4 = 0;	if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord;	r15 = r2[i4];	r16 = virtualinvoke r15.<java.lang.String: java.lang.String[] split(java.lang.String)>("=");	r17 = r16[0];	r18 = "";	$i3 = lengthof r16;	if $i3 != 2 goto interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18);	r18 = r16[1];	interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18);	i4 = i4 + 1;	goto [?= (branch)];	if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord;	r15 = r2[i4];	r16 = virtualinvoke r15.<java.lang.String: java.lang.String[] split(java.lang.String)>("=");	r17 = r16[0];	r18 = "";	$i3 = lengthof r16;	if $i3 != 2 goto interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18);	interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18);	i4 = i4 + 1;	goto [?= (branch)];	if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord;	$r4 = new edu.stanford.nlp.ling.IndexedWord;	specialinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void <init>()>();	$r5 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("word");	$r6 = (java.lang.String) $r5;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setWord(java.lang.String)>($r6);	$r7 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("lemma");	$r8 = (java.lang.String) $r7;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setLemma(java.lang.String)>($r8);	$r9 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("POS");	$r10 = (java.lang.String) $r9;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setTag(java.lang.String)>($r10);	$r11 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("value");	$r12 = (java.lang.String) $r11;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setValue(java.lang.String)>($r12);	$r13 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("current");	$r14 = (java.lang.String) $r13;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setOriginalText(java.lang.String)>($r14);	return $r4
;block_num 10
(get-model)
