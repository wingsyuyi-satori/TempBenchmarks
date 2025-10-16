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

(declare-sort var3378 0)
(declare-sort var920 0)
(declare-sort var343 0)
(declare-sort var3763 0)
(declare-sort var2024 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun var343_newHashMap/701256970 () var920)
(declare-fun var920_put/1464166817 (var920 var3763 var3763) var3763)
(declare-fun cast-from-String-to-var3763 (String) var3763)
(declare-fun var2024-init () var2024)
(declare-fun <init>/379364885 (var2024) void)
(declare-fun var920_get/1088891777 (var920 var3763) var3763)
(declare-fun cast-from-var3763-to-String (var3763) String)
(declare-fun setWord/1927702860 (var2024 String) void)
(declare-fun setLemma/-2044772538 (var2024 String) void)
(declare-fun setTag/-492450796 (var2024 String) void)
(declare-fun setValue/-1305364003 (var2024 String) void)
(declare-fun setOriginalText/-1052378824 (var2024 String) void)
(declare-const null-String String)
(declare-const var3830 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3830 null-String)))
(assert true)
(define-const var763 Int (length/-134980193 var3830)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(define-const var3490 Int (- var763 1)) ; Statement: $i1 = $i0 - 1 
(assert (and true (and (>= 1 0) (>= (str.len var3830) var3490) (>= var3490 1))))
(define-const var1041 String (substring/-1240304868 var3830 1 var3490)) ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(1, $i1) 
; split operation: var1908 = var1041.split(" ") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ") 
(define-const var3243 var920 var343_newHashMap/701256970) ; Statement: r3 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Map newHashMap()>() 
(define-const var2966 Int (get_split_length var1041 " " -1)) ; Statement: i2 = lengthof r2 
(define-const var1731 Int 0) ; Statement: i4 = 0 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord 
(assert (not (>= var1731 var2966))) ; Negate: Cond: i4 >= i2  
(define-const var2278 String (get_split_element var1041 " " -1 var1731)) ; Statement: r15 = r2[i4] 
; split operation: var1922 = var2278.split("=") ; Statement: r16 = virtualinvoke r15.<java.lang.String: java.lang.String[] split(java.lang.String)>("=") 
(define-const var1032 String (get_split_element var2278 "=" -1 0)) ; Statement: r17 = r16[0] 
(define-const var1143 String "") ; Statement: r18 = "" 
(define-const var3063 Int (get_split_length var2278 "=" -1)) ; Statement: $i3 = lengthof r16 
 ; Statement: if $i3 != 2 goto interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18) 
(assert (not (= var3063 2))) ; Cond: $i3 != 2 
;(assert (var920_put/1464166817 var3243 (cast-from-String-to-var3763 var1032) (cast-from-String-to-var3763 var1143))) ; Statement: interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18) 

(declare-const var3243!1 var920)
(declare-const var1032!1 String)
(declare-const var1143!1 String)
(define-const var1731!1 Int (+ var1731 1)) ; Statement: i4 = i4 + 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord 
(assert (>= var1731!1 var2966)) ; Cond: i4 >= i2 
(define-const var18 var2024 var2024-init) ; Statement: $r4 = new edu.stanford.nlp.ling.IndexedWord 
(assert true)
;(assert (<init>/379364885 var18)) ; Statement: specialinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void <init>()>() 

(declare-const var18!1 var2024)
(define-const var3811 var3763 (var920_get/1088891777 var3243!1 (cast-from-String-to-var3763 "word"))) ; Statement: $r5 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("word") 
(define-const var1925 String (cast-from-var3763-to-String var3811)) ; Statement: $r6 = (java.lang.String) $r5 
(assert true)
;(assert (setWord/1927702860 var18!1 var1925)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setWord(java.lang.String)>($r6) 

(declare-const var18!2 var2024)
(declare-const var1925!1 String)
(define-const var645 var3763 (var920_get/1088891777 var3243!1 (cast-from-String-to-var3763 "lemma"))) ; Statement: $r7 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("lemma") 
(define-const var2819 String (cast-from-var3763-to-String var645)) ; Statement: $r8 = (java.lang.String) $r7 
(assert true)
;(assert (setLemma/-2044772538 var18!2 var2819)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setLemma(java.lang.String)>($r8) 

(declare-const var18!3 var2024)
(declare-const var2819!1 String)
(define-const var3066 var3763 (var920_get/1088891777 var3243!1 (cast-from-String-to-var3763 "POS"))) ; Statement: $r9 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("POS") 
(define-const var3055 String (cast-from-var3763-to-String var3066)) ; Statement: $r10 = (java.lang.String) $r9 
(assert true)
;(assert (setTag/-492450796 var18!3 var3055)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setTag(java.lang.String)>($r10) 

(declare-const var18!4 var2024)
(declare-const var3055!1 String)
(define-const var287 var3763 (var920_get/1088891777 var3243!1 (cast-from-String-to-var3763 "value"))) ; Statement: $r11 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("value") 
(define-const var52 String (cast-from-var3763-to-String var287)) ; Statement: $r12 = (java.lang.String) $r11 
(assert true)
;(assert (setValue/-1305364003 var18!4 var52)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setValue(java.lang.String)>($r12) 

(declare-const var18!5 var2024)
(declare-const var52!1 String)
(define-const var1419 var3763 (var920_get/1088891777 var3243!1 (cast-from-String-to-var3763 "current"))) ; Statement: $r13 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("current") 
(define-const var3485 String (cast-from-var3763-to-String var1419)) ; Statement: $r14 = (java.lang.String) $r13 
(assert true)
;(assert (setOriginalText/-1052378824 var18!5 var3485)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setOriginalText(java.lang.String)>($r14) 

(declare-const var18!6 var2024)
(declare-const var3485!1 String)
 ; Statement: return $r4 
(check-sat)
; {length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), var343_newHashMap/701256970=([], java.util.Map), var920_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var3763=([java.lang.String], java.lang.Object), var2024-init=([], edu.stanford.nlp.ling.IndexedWord), <init>/379364885=([edu.stanford.nlp.ling.IndexedWord], void), var920_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var3763-to-String=([java.lang.Object], java.lang.String), setWord/1927702860=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setLemma/-2044772538=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setTag/-492450796=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setValue/-1305364003=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setOriginalText/-1052378824=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void)}
; {var3830=r0, var3378=null_type, var763=$i0, var3490=$i1, var1041=r1, var1908=r2, var920=java.util.Map, var343=edu.stanford.nlp.util.Generics, var3243=r3, var2966=i2, var1731=i4, var2278=r15, var1922=r16, var1032=r17, var1143=r18, var3063=$i3, var3763=java.lang.Object, var2024=edu.stanford.nlp.ling.IndexedWord, var18=$r4, var3811=$r5, var1925=$r6, var645=$r7, var2819=$r8, var3066=$r9, var3055=$r10, var287=$r11, var52=$r12, var1419=$r13, var3485=$r14}
; {r0=var3830, null_type=var3378, $i0=var763, $i1=var3490, r1=var1041, r2=var1908, java.util.Map=var920, edu.stanford.nlp.util.Generics=var343, r3=var3243, i2=var2966, i4=var1731, r15=var2278, r16=var1922, r17=var1032, r18=var1143, $i3=var3063, java.lang.Object=var3763, edu.stanford.nlp.ling.IndexedWord=var2024, $r4=var18, $r5=var3811, $r6=var1925, $r7=var645, $r8=var2819, $r9=var3066, $r10=var3055, $r11=var287, $r12=var52, $r13=var1419, $r14=var3485}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r0 := @parameter0: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	$i1 = $i0 - 1;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(1, $i1);	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	r3 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Map newHashMap()>();	i2 = lengthof r2;	i4 = 0;	if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord;	r15 = r2[i4];	r16 = virtualinvoke r15.<java.lang.String: java.lang.String[] split(java.lang.String)>("=");	r17 = r16[0];	r18 = "";	$i3 = lengthof r16;	if $i3 != 2 goto interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18);	interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18);	i4 = i4 + 1;	goto [?= (branch)];	if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord;	$r4 = new edu.stanford.nlp.ling.IndexedWord;	specialinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void <init>()>();	$r5 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("word");	$r6 = (java.lang.String) $r5;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setWord(java.lang.String)>($r6);	$r7 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("lemma");	$r8 = (java.lang.String) $r7;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setLemma(java.lang.String)>($r8);	$r9 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("POS");	$r10 = (java.lang.String) $r9;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setTag(java.lang.String)>($r10);	$r11 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("value");	$r12 = (java.lang.String) $r11;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setValue(java.lang.String)>($r12);	$r13 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("current");	$r14 = (java.lang.String) $r13;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setOriginalText(java.lang.String)>($r14);	return $r4
;block_num 6
(get-model)
