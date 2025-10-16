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

(declare-sort var1234 0)
(declare-sort var3044 0)
(declare-sort var3119 0)
(declare-sort var3839 0)
(declare-sort var832 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun var3119_newHashMap/701256970 () var3044)
(declare-fun var3044_put/1464166817 (var3044 var3839 var3839) var3839)
(declare-fun cast-from-String-to-var3839 (String) var3839)
(declare-fun var832-init () var832)
(declare-fun <init>/379364885 (var832) void)
(declare-fun var3044_get/1088891777 (var3044 var3839) var3839)
(declare-fun cast-from-var3839-to-String (var3839) String)
(declare-fun setWord/1927702860 (var832 String) void)
(declare-fun setLemma/-2044772538 (var832 String) void)
(declare-fun setTag/-492450796 (var832 String) void)
(declare-fun setValue/-1305364003 (var832 String) void)
(declare-fun setOriginalText/-1052378824 (var832 String) void)
(declare-const null-String String)
(declare-const var2632 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2632 null-String)))
(assert true)
(define-const var3882 Int (length/-134980193 var2632)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(define-const var3973 Int (- var3882 1)) ; Statement: $i1 = $i0 - 1 
(assert (and true (and (>= 1 0) (>= (str.len var2632) var3973) (>= var3973 1))))
(define-const var3298 String (substring/-1240304868 var2632 1 var3973)) ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(1, $i1) 
; split operation: var527 = var3298.split(" ") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ") 
(define-const var2707 var3044 var3119_newHashMap/701256970) ; Statement: r3 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Map newHashMap()>() 
(define-const var3201 Int (get_split_length var3298 " " -1)) ; Statement: i2 = lengthof r2 
(define-const var840 Int 0) ; Statement: i4 = 0 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord 
(assert (not (>= var840 var3201))) ; Negate: Cond: i4 >= i2  
(define-const var21 String (get_split_element var3298 " " -1 var840)) ; Statement: r15 = r2[i4] 
; split operation: var14 = var21.split("=") ; Statement: r16 = virtualinvoke r15.<java.lang.String: java.lang.String[] split(java.lang.String)>("=") 
(define-const var1469 String (get_split_element var21 "=" -1 0)) ; Statement: r17 = r16[0] 
(define-const var368 String "") ; Statement: r18 = "" 
(define-const var2583 Int (get_split_length var21 "=" -1)) ; Statement: $i3 = lengthof r16 
 ; Statement: if $i3 != 2 goto interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18) 
(assert (not (= var2583 2))) ; Cond: $i3 != 2 
;(assert (var3044_put/1464166817 var2707 (cast-from-String-to-var3839 var1469) (cast-from-String-to-var3839 var368))) ; Statement: interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18) 

(declare-const var2707!1 var3044)
(declare-const var1469!1 String)
(declare-const var368!1 String)
(define-const var840!1 Int (+ var840 1)) ; Statement: i4 = i4 + 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord 
(assert (not (>= var840!1 var3201))) ; Negate: Cond: i4 >= i2  
(define-const var21!1 String (get_split_element var3298 " " -1 var840!1)) ; Statement: r15 = r2[i4] 
; split operation: var14!1 = var21!1.split("=") ; Statement: r16 = virtualinvoke r15.<java.lang.String: java.lang.String[] split(java.lang.String)>("=") 
(define-const var1469!2 String (get_split_element var21!1 "=" -1 0)) ; Statement: r17 = r16[0] 
(define-const var368!2 String "") ; Statement: r18 = "" 
(define-const var2583!1 Int (get_split_length var21!1 "=" -1)) ; Statement: $i3 = lengthof r16 
 ; Statement: if $i3 != 2 goto interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18) 
(assert (not (= var2583!1 2))) ; Cond: $i3 != 2 
;(assert (var3044_put/1464166817 var2707!1 (cast-from-String-to-var3839 var1469!2) (cast-from-String-to-var3839 var368!2))) ; Statement: interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18) 

(declare-const var2707!2 var3044)
(declare-const var1469!3 String)
(declare-const var368!3 String)
(define-const var840!2 Int (+ var840!1 1)) ; Statement: i4 = i4 + 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord 
(assert (>= var840!2 var3201)) ; Cond: i4 >= i2 
(define-const var3084 var832 var832-init) ; Statement: $r4 = new edu.stanford.nlp.ling.IndexedWord 
(assert true)
;(assert (<init>/379364885 var3084)) ; Statement: specialinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void <init>()>() 

(declare-const var3084!1 var832)
(define-const var3113 var3839 (var3044_get/1088891777 var2707!2 (cast-from-String-to-var3839 "word"))) ; Statement: $r5 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("word") 
(define-const var3745 String (cast-from-var3839-to-String var3113)) ; Statement: $r6 = (java.lang.String) $r5 
(assert true)
;(assert (setWord/1927702860 var3084!1 var3745)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setWord(java.lang.String)>($r6) 

(declare-const var3084!2 var832)
(declare-const var3745!1 String)
(define-const var3779 var3839 (var3044_get/1088891777 var2707!2 (cast-from-String-to-var3839 "lemma"))) ; Statement: $r7 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("lemma") 
(define-const var3258 String (cast-from-var3839-to-String var3779)) ; Statement: $r8 = (java.lang.String) $r7 
(assert true)
;(assert (setLemma/-2044772538 var3084!2 var3258)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setLemma(java.lang.String)>($r8) 

(declare-const var3084!3 var832)
(declare-const var3258!1 String)
(define-const var3604 var3839 (var3044_get/1088891777 var2707!2 (cast-from-String-to-var3839 "POS"))) ; Statement: $r9 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("POS") 
(define-const var2177 String (cast-from-var3839-to-String var3604)) ; Statement: $r10 = (java.lang.String) $r9 
(assert true)
;(assert (setTag/-492450796 var3084!3 var2177)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setTag(java.lang.String)>($r10) 

(declare-const var3084!4 var832)
(declare-const var2177!1 String)
(define-const var1987 var3839 (var3044_get/1088891777 var2707!2 (cast-from-String-to-var3839 "value"))) ; Statement: $r11 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("value") 
(define-const var89 String (cast-from-var3839-to-String var1987)) ; Statement: $r12 = (java.lang.String) $r11 
(assert true)
;(assert (setValue/-1305364003 var3084!4 var89)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setValue(java.lang.String)>($r12) 

(declare-const var3084!5 var832)
(declare-const var89!1 String)
(define-const var3516 var3839 (var3044_get/1088891777 var2707!2 (cast-from-String-to-var3839 "current"))) ; Statement: $r13 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("current") 
(define-const var261 String (cast-from-var3839-to-String var3516)) ; Statement: $r14 = (java.lang.String) $r13 
(assert true)
;(assert (setOriginalText/-1052378824 var3084!5 var261)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setOriginalText(java.lang.String)>($r14) 

(declare-const var3084!6 var832)
(declare-const var261!1 String)
 ; Statement: return $r4 
(check-sat)
; {length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), var3119_newHashMap/701256970=([], java.util.Map), var3044_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var3839=([java.lang.String], java.lang.Object), var832-init=([], edu.stanford.nlp.ling.IndexedWord), <init>/379364885=([edu.stanford.nlp.ling.IndexedWord], void), var3044_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var3839-to-String=([java.lang.Object], java.lang.String), setWord/1927702860=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setLemma/-2044772538=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setTag/-492450796=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setValue/-1305364003=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setOriginalText/-1052378824=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void)}
; {var2632=r0, var1234=null_type, var3882=$i0, var3973=$i1, var3298=r1, var527=r2, var3044=java.util.Map, var3119=edu.stanford.nlp.util.Generics, var2707=r3, var3201=i2, var840=i4, var21=r15, var14=r16, var1469=r17, var368=r18, var2583=$i3, var3839=java.lang.Object, var832=edu.stanford.nlp.ling.IndexedWord, var3084=$r4, var3113=$r5, var3745=$r6, var3779=$r7, var3258=$r8, var3604=$r9, var2177=$r10, var1987=$r11, var89=$r12, var3516=$r13, var261=$r14}
; {r0=var2632, null_type=var1234, $i0=var3882, $i1=var3973, r1=var3298, r2=var527, java.util.Map=var3044, edu.stanford.nlp.util.Generics=var3119, r3=var2707, i2=var3201, i4=var840, r15=var21, r16=var14, r17=var1469, r18=var368, $i3=var2583, java.lang.Object=var3839, edu.stanford.nlp.ling.IndexedWord=var832, $r4=var3084, $r5=var3113, $r6=var3745, $r7=var3779, $r8=var3258, $r9=var3604, $r10=var2177, $r11=var1987, $r12=var89, $r13=var3516, $r14=var261}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 3}
;stmts r0 := @parameter0: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	$i1 = $i0 - 1;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(1, $i1);	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	r3 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Map newHashMap()>();	i2 = lengthof r2;	i4 = 0;	if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord;	r15 = r2[i4];	r16 = virtualinvoke r15.<java.lang.String: java.lang.String[] split(java.lang.String)>("=");	r17 = r16[0];	r18 = "";	$i3 = lengthof r16;	if $i3 != 2 goto interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18);	interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18);	i4 = i4 + 1;	goto [?= (branch)];	if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord;	r15 = r2[i4];	r16 = virtualinvoke r15.<java.lang.String: java.lang.String[] split(java.lang.String)>("=");	r17 = r16[0];	r18 = "";	$i3 = lengthof r16;	if $i3 != 2 goto interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18);	interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18);	i4 = i4 + 1;	goto [?= (branch)];	if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord;	$r4 = new edu.stanford.nlp.ling.IndexedWord;	specialinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void <init>()>();	$r5 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("word");	$r6 = (java.lang.String) $r5;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setWord(java.lang.String)>($r6);	$r7 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("lemma");	$r8 = (java.lang.String) $r7;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setLemma(java.lang.String)>($r8);	$r9 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("POS");	$r10 = (java.lang.String) $r9;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setTag(java.lang.String)>($r10);	$r11 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("value");	$r12 = (java.lang.String) $r11;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setValue(java.lang.String)>($r12);	$r13 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("current");	$r14 = (java.lang.String) $r13;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setOriginalText(java.lang.String)>($r14);	return $r4
;block_num 9
(get-model)
