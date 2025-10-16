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

(declare-sort var3326 0)
(declare-sort var1699 0)
(declare-sort var3108 0)
(declare-sort var1521 0)
(declare-sort var1911 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/-1240304868 ((s String) (begin Int) (end Int)) String (str.substr s begin (- end begin)))
(declare-fun var3108_newHashMap/701256970 () var1699)
(declare-fun var1699_put/1464166817 (var1699 var1521 var1521) var1521)
(declare-fun cast-from-String-to-var1521 (String) var1521)
(declare-fun var1911-init () var1911)
(declare-fun <init>/379364885 (var1911) void)
(declare-fun var1699_get/1088891777 (var1699 var1521) var1521)
(declare-fun cast-from-var1521-to-String (var1521) String)
(declare-fun setWord/1927702860 (var1911 String) void)
(declare-fun setLemma/-2044772538 (var1911 String) void)
(declare-fun setTag/-492450796 (var1911 String) void)
(declare-fun setValue/-1305364003 (var1911 String) void)
(declare-fun setOriginalText/-1052378824 (var1911 String) void)
(declare-const null-String String)
(declare-const var3212 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3212 null-String)))
(assert true)
(define-const var1300 Int (length/-134980193 var3212)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
(define-const var979 Int (- var1300 1)) ; Statement: $i1 = $i0 - 1 
(assert (and true (and (>= 1 0) (>= (str.len var3212) var979) (>= var979 1))))
(define-const var2914 String (substring/-1240304868 var3212 1 var979)) ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(1, $i1) 
; split operation: var3134 = var2914.split(" ") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ") 
(define-const var1214 var1699 var3108_newHashMap/701256970) ; Statement: r3 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Map newHashMap()>() 
(define-const var16 Int (get_split_length var2914 " " -1)) ; Statement: i2 = lengthof r2 
(define-const var3649 Int 0) ; Statement: i4 = 0 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord 
(assert (not (>= var3649 var16))) ; Negate: Cond: i4 >= i2  
(define-const var3207 String (get_split_element var2914 " " -1 var3649)) ; Statement: r15 = r2[i4] 
; split operation: var754 = var3207.split("=") ; Statement: r16 = virtualinvoke r15.<java.lang.String: java.lang.String[] split(java.lang.String)>("=") 
(define-const var2965 String (get_split_element var3207 "=" -1 0)) ; Statement: r17 = r16[0] 
(define-const var2953 String "") ; Statement: r18 = "" 
(define-const var3886 Int (get_split_length var3207 "=" -1)) ; Statement: $i3 = lengthof r16 
 ; Statement: if $i3 != 2 goto interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18) 
(assert (not (= var3886 2))) ; Cond: $i3 != 2 
;(assert (var1699_put/1464166817 var1214 (cast-from-String-to-var1521 var2965) (cast-from-String-to-var1521 var2953))) ; Statement: interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18) 

(declare-const var1214!1 var1699)
(declare-const var2965!1 String)
(declare-const var2953!1 String)
(define-const var3649!1 Int (+ var3649 1)) ; Statement: i4 = i4 + 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord 
(assert (not (>= var3649!1 var16))) ; Negate: Cond: i4 >= i2  
(define-const var3207!1 String (get_split_element var2914 " " -1 var3649!1)) ; Statement: r15 = r2[i4] 
; split operation: var754!1 = var3207!1.split("=") ; Statement: r16 = virtualinvoke r15.<java.lang.String: java.lang.String[] split(java.lang.String)>("=") 
(define-const var2965!2 String (get_split_element var3207!1 "=" -1 0)) ; Statement: r17 = r16[0] 
(define-const var2953!2 String "") ; Statement: r18 = "" 
(define-const var3886!1 Int (get_split_length var3207!1 "=" -1)) ; Statement: $i3 = lengthof r16 
 ; Statement: if $i3 != 2 goto interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18) 
(assert (not (not (= var3886!1 2)))) ; Negate: Cond: $i3 != 2  
(define-const var2953!3 String (get_split_element var3207!1 "=" -1 1)) ; Statement: r18 = r16[1] 
(assert true) ; Non Conditional
;(assert (var1699_put/1464166817 var1214!1 (cast-from-String-to-var1521 var2965!2) (cast-from-String-to-var1521 var2953!3))) ; Statement: interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18) 

(declare-const var1214!2 var1699)
(declare-const var2965!3 String)
(declare-const var2953!4 String)
(define-const var3649!2 Int (+ var3649!1 1)) ; Statement: i4 = i4 + 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord 
(assert (>= var3649!2 var16)) ; Cond: i4 >= i2 
(define-const var585 var1911 var1911-init) ; Statement: $r4 = new edu.stanford.nlp.ling.IndexedWord 
(assert true)
;(assert (<init>/379364885 var585)) ; Statement: specialinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void <init>()>() 

(declare-const var585!1 var1911)
(define-const var2521 var1521 (var1699_get/1088891777 var1214!2 (cast-from-String-to-var1521 "word"))) ; Statement: $r5 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("word") 
(define-const var3347 String (cast-from-var1521-to-String var2521)) ; Statement: $r6 = (java.lang.String) $r5 
(assert true)
;(assert (setWord/1927702860 var585!1 var3347)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setWord(java.lang.String)>($r6) 

(declare-const var585!2 var1911)
(declare-const var3347!1 String)
(define-const var3672 var1521 (var1699_get/1088891777 var1214!2 (cast-from-String-to-var1521 "lemma"))) ; Statement: $r7 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("lemma") 
(define-const var2367 String (cast-from-var1521-to-String var3672)) ; Statement: $r8 = (java.lang.String) $r7 
(assert true)
;(assert (setLemma/-2044772538 var585!2 var2367)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setLemma(java.lang.String)>($r8) 

(declare-const var585!3 var1911)
(declare-const var2367!1 String)
(define-const var3768 var1521 (var1699_get/1088891777 var1214!2 (cast-from-String-to-var1521 "POS"))) ; Statement: $r9 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("POS") 
(define-const var1947 String (cast-from-var1521-to-String var3768)) ; Statement: $r10 = (java.lang.String) $r9 
(assert true)
;(assert (setTag/-492450796 var585!3 var1947)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setTag(java.lang.String)>($r10) 

(declare-const var585!4 var1911)
(declare-const var1947!1 String)
(define-const var1006 var1521 (var1699_get/1088891777 var1214!2 (cast-from-String-to-var1521 "value"))) ; Statement: $r11 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("value") 
(define-const var1835 String (cast-from-var1521-to-String var1006)) ; Statement: $r12 = (java.lang.String) $r11 
(assert true)
;(assert (setValue/-1305364003 var585!4 var1835)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setValue(java.lang.String)>($r12) 

(declare-const var585!5 var1911)
(declare-const var1835!1 String)
(define-const var2148 var1521 (var1699_get/1088891777 var1214!2 (cast-from-String-to-var1521 "current"))) ; Statement: $r13 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("current") 
(define-const var2611 String (cast-from-var1521-to-String var2148)) ; Statement: $r14 = (java.lang.String) $r13 
(assert true)
;(assert (setOriginalText/-1052378824 var585!5 var2611)) ; Statement: virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setOriginalText(java.lang.String)>($r14) 

(declare-const var585!6 var1911)
(declare-const var2611!1 String)
 ; Statement: return $r4 
(check-sat)
; {length/-134980193=([java.lang.String], int), substring/-1240304868=([java.lang.String, int, int], java.lang.String), var3108_newHashMap/701256970=([], java.util.Map), var1699_put/1464166817=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var1521=([java.lang.String], java.lang.Object), var1911-init=([], edu.stanford.nlp.ling.IndexedWord), <init>/379364885=([edu.stanford.nlp.ling.IndexedWord], void), var1699_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var1521-to-String=([java.lang.Object], java.lang.String), setWord/1927702860=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setLemma/-2044772538=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setTag/-492450796=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setValue/-1305364003=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void), setOriginalText/-1052378824=([edu.stanford.nlp.ling.IndexedWord, java.lang.String], void)}
; {var3212=r0, var3326=null_type, var1300=$i0, var979=$i1, var2914=r1, var3134=r2, var1699=java.util.Map, var3108=edu.stanford.nlp.util.Generics, var1214=r3, var16=i2, var3649=i4, var3207=r15, var754=r16, var2965=r17, var2953=r18, var3886=$i3, var1521=java.lang.Object, var1911=edu.stanford.nlp.ling.IndexedWord, var585=$r4, var2521=$r5, var3347=$r6, var3672=$r7, var2367=$r8, var3768=$r9, var1947=$r10, var1006=$r11, var1835=$r12, var2148=$r13, var2611=$r14}
; {r0=var3212, null_type=var3326, $i0=var1300, $i1=var979, r1=var2914, r2=var3134, java.util.Map=var1699, edu.stanford.nlp.util.Generics=var3108, r3=var1214, i2=var16, i4=var3649, r15=var3207, r16=var754, r17=var2965, r18=var2953, $i3=var3886, java.lang.Object=var1521, edu.stanford.nlp.ling.IndexedWord=var1911, $r4=var585, $r5=var2521, $r6=var3347, $r7=var3672, $r8=var2367, $r9=var3768, $r10=var1947, $r11=var1006, $r12=var1835, $r13=var2148, $r14=var2611}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int,int)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int,int)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 3}
;stmts r0 := @parameter0: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	$i1 = $i0 - 1;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String substring(int,int)>(1, $i1);	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	r3 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Map newHashMap()>();	i2 = lengthof r2;	i4 = 0;	if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord;	r15 = r2[i4];	r16 = virtualinvoke r15.<java.lang.String: java.lang.String[] split(java.lang.String)>("=");	r17 = r16[0];	r18 = "";	$i3 = lengthof r16;	if $i3 != 2 goto interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18);	interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18);	i4 = i4 + 1;	goto [?= (branch)];	if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord;	r15 = r2[i4];	r16 = virtualinvoke r15.<java.lang.String: java.lang.String[] split(java.lang.String)>("=");	r17 = r16[0];	r18 = "";	$i3 = lengthof r16;	if $i3 != 2 goto interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18);	r18 = r16[1];	interfaceinvoke r3.<java.util.Map: java.lang.Object put(java.lang.Object,java.lang.Object)>(r17, r18);	i4 = i4 + 1;	goto [?= (branch)];	if i4 >= i2 goto $r4 = new edu.stanford.nlp.ling.IndexedWord;	$r4 = new edu.stanford.nlp.ling.IndexedWord;	specialinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void <init>()>();	$r5 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("word");	$r6 = (java.lang.String) $r5;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setWord(java.lang.String)>($r6);	$r7 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("lemma");	$r8 = (java.lang.String) $r7;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setLemma(java.lang.String)>($r8);	$r9 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("POS");	$r10 = (java.lang.String) $r9;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setTag(java.lang.String)>($r10);	$r11 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("value");	$r12 = (java.lang.String) $r11;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setValue(java.lang.String)>($r12);	$r13 = interfaceinvoke r3.<java.util.Map: java.lang.Object get(java.lang.Object)>("current");	$r14 = (java.lang.String) $r13;	virtualinvoke $r4.<edu.stanford.nlp.ling.IndexedWord: void setOriginalText(java.lang.String)>($r14);	return $r4
;block_num 10
(get-model)
