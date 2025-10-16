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

(declare-sort var881 0)
(declare-sort var2231 0)
(declare-sort var1110 0)
(declare-sort var438 0)
(declare-sort var3743 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun var1110_newHashMap/701256970 () var2231)
(declare-fun var2231_put/1464166817 (var2231 var438 var438) var438)
(declare-fun cast-from-String-to-var438 (String) var438)
(declare-fun var3743-init () var3743)
(declare-fun <init>/379364885 (var3743) void)
(declare-fun var2231_get/1088891777 (var2231 var438) var438)
(declare-fun cast-from-var438-to-String (var438) String)
(declare-fun setWord/1927702860 (var3743 String) void)
(declare-fun setLemma/-2044772538 (var3743 String) void)
(declare-fun setTag/-492450796 (var3743 String) void)
(declare-fun setValue/-1305364003 (var3743 String) void)
(declare-fun setOriginalText/-1052378824 (var3743 String) void)
(declare-const null-String String)
(declare-const var850 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var850 null-String)))
(assert true)
(define-const var3605 Int (length/-134980193 var850)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(define-const var504 Int (- var3605 1)) ; Statement: $i1 = $i0 - 1 
(assert (and true (and (>= 1 0) (>= (str.len var850) var504) (>= var504 1))))
(define-const var872 String (substring/-1240304868 var850 1 var504)) ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(1, $i1) 
; split operation: var2283 = var872.split(" ") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ") 
(define-const var2558 var2231 var1110_newHashMap/701256970) ; Statement: r3 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Map newHashMap()>() 
(define-const var1226 Int (get_split_length var872 " " -1)) ; Statement: i2 = lengthof r2 
(define-const var3457 Int 0) ; Statement: i4 = 0 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord 
(assert (not (>= var3457 var1226))) ; Negate: Cond: i4 >= i2  
(define-const var3323 String (get_split_element var872 " " -1 var3457)) ; Statement: r15 = r2[i4] 
; split operation: var3647 = var3323.split("=") ; Statement: r16 = virtualinvoke r15.<java.lang.String: java.lang.String[] split(java.lang.String)>("=") 
(define-const var2572 String (get_split_element var3323 "=" -1 0)) ; Statement: r17 = r16[0] 
(define-const var2413 String "") ; Statement: r18 = "" 
(define-const var1899 Int (get_split_length var3323 "=" -1)) ; Statement: $i3 = lengthof r16 
 ; Statement: if $i3 != 2 goto interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18) 
(assert (not (not (= var1899 2)))) ; Negate: Cond: $i3 != 2  
(define-const var2413!1 String (get_split_element var3323 "=" -1 1)) ; Statement: r18 = r16[1] 
(assert true) ; Non Conditional
;(assert (var2231_put/1464166817 var2558 (cast-from-String-to-var438 var2572) (cast-from-String-to-var438 var2413!1))) ; Statement: interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18) 

(declare-const var2558!1 var2231)
(declare-const var2572!1 String)
(declare-const var2413!2 String)
(define-const var3457!1 Int (+ var3457 1)) ; Statement: i4 = i4 + 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord 
(assert (>= var3457!1 var1226)) ; Cond: i4 >= i2 
(define-const var2566 var3743 var3743-init) ; Statement: $r4 = new edu.stanford.nlp.ling.IndexedWord 
(assert true)
;(assert (<init>/379364885 var2566)) ; Statement: specialinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void <init>()>() 

(declare-const var2566!1 var3743)
(define-const var3239 var438 (var2231_get/1088891777 var2558!1 (cast-from-String-to-var438 "word"))) ; Statement: $r5 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("word") 
(define-const var3928 String (cast-from-var438-to-String var3239)) ; Statement: $r6 = (java.lang.String) $r5 
(assert true)
;(assert (setWord/1927702860 var2566!1 var3928)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setWord(java.lang.String)>($r6) 

(declare-const var2566!2 var3743)
(declare-const var3928!1 String)
(define-const var3681 var438 (var2231_get/1088891777 var2558!1 (cast-from-String-to-var438 "lemma"))) ; Statement: $r7 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("lemma") 
(define-const var2934 String (cast-from-var438-to-String var3681)) ; Statement: $r8 = (java.lang.String) $r7 
(assert true)
;(assert (setLemma/-2044772538 var2566!2 var2934)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setLemma(java.lang.String)>($r8) 

(declare-const var2566!3 var3743)
(declare-const var2934!1 String)
(define-const var3267 var438 (var2231_get/1088891777 var2558!1 (cast-from-String-to-var438 "POS"))) ; Statement: $r9 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("POS") 
(define-const var1648 String (cast-from-var438-to-String var3267)) ; Statement: $r10 = (java.lang.String) $r9 
(assert true)
;(assert (setTag/-492450796 var2566!3 var1648)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setTag(java.lang.String)>($r10) 

(declare-const var2566!4 var3743)
(declare-const var1648!1 String)
(define-const var207 var438 (var2231_get/1088891777 var2558!1 (cast-from-String-to-var438 "value"))) ; Statement: $r11 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("value") 
(define-const var1773 String (cast-from-var438-to-String var207)) ; Statement: $r12 = (java.lang.String) $r11 
(assert true)
;(assert (setValue/-1305364003 var2566!4 var1773)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setValue(java.lang.String)>($r12) 

(declare-const var2566!5 var3743)
(declare-const var1773!1 String)
(define-const var3262 var438 (var2231_get/1088891777 var2558!1 (cast-from-String-to-var438 "current"))) ; Statement: $r13 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("current") 
(define-const var1646 String (cast-from-var438-to-String var3262)) ; Statement: $r14 = (java.lang.String) $r13 
(assert true)
;(assert (setOriginalText/-1052378824 var2566!5 var1646)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setOriginalText(java.lang.String)>($r14) 

(declare-const var2566!6 var3743)
(declare-const var1646!1 String)
 ; Statement: return $r4 
(check-sat)
; {length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), var1110_newHashMap/701256970=([], java.util.Map), var2231_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var438=([java.lang.String], java.lang.Object), var3743-init=([], edu.stanford.nlp.ling.IndexedWord), <init>/379364885=([edu.stanford.nlp.ling.IndexedWord], void), var2231_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var438-to-String=([java.lang.Object], java.lang.String), setWord/1927702860=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setLemma/-2044772538=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setTag/-492450796=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setValue/-1305364003=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setOriginalText/-1052378824=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void)}
; {var850=r0, var881=null_type, var3605=$i0, var504=$i1, var872=r1, var2283=r2, var2231=java.util.Map, var1110=edu.stanford.nlp.util.Generics, var2558=r3, var1226=i2, var3457=i4, var3323=r15, var3647=r16, var2572=r17, var2413=r18, var1899=$i3, var438=java.lang.Object, var3743=edu.stanford.nlp.ling.IndexedWord, var2566=$r4, var3239=$r5, var3928=$r6, var3681=$r7, var2934=$r8, var3267=$r9, var1648=$r10, var207=$r11, var1773=$r12, var3262=$r13, var1646=$r14}
; {r0=var850, null_type=var881, $i0=var3605, $i1=var504, r1=var872, r2=var2283, java.util.Map=var2231, edu.stanford.nlp.util.Generics=var1110, r3=var2558, i2=var1226, i4=var3457, r15=var3323, r16=var3647, r17=var2572, r18=var2413, $i3=var1899, java.lang.Object=var438, edu.stanford.nlp.ling.IndexedWord=var3743, $r4=var2566, $r5=var3239, $r6=var3928, $r7=var3681, $r8=var2934, $r9=var3267, $r10=var1648, $r11=var207, $r12=var1773, $r13=var3262, $r14=var1646}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r0 := @parameter0: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	$i1 = $i0 - 1;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(1, $i1);	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	r3 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Map newHashMap()>();	i2 = lengthof r2;	i4 = 0;	if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord;	r15 = r2[i4];	r16 = virtualinvoke r15.<java.lang.String: java.lang.String[] split(java.lang.String)>("=");	r17 = r16[0];	r18 = "";	$i3 = lengthof r16;	if $i3 != 2 goto interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18);	r18 = r16[1];	interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18);	i4 = i4 + 1;	goto [?= (branch)];	if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord;	$r4 = new edu.stanford.nlp.ling.IndexedWord;	specialinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void <init>()>();	$r5 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("word");	$r6 = (java.lang.String) $r5;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setWord(java.lang.String)>($r6);	$r7 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("lemma");	$r8 = (java.lang.String) $r7;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setLemma(java.lang.String)>($r8);	$r9 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("POS");	$r10 = (java.lang.String) $r9;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setTag(java.lang.String)>($r10);	$r11 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("value");	$r12 = (java.lang.String) $r11;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setValue(java.lang.String)>($r12);	$r13 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("current");	$r14 = (java.lang.String) $r13;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setOriginalText(java.lang.String)>($r14);	return $r4
;block_num 7
(get-model)
