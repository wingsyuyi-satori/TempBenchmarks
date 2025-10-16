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

(declare-sort var2319 0)
(declare-sort var2356 0)
(declare-sort var1573 0)
(declare-sort var1620 0)
(declare-sort var3250 0)
(declare-sort var3215 0)
(declare-sort var3504 0)
(declare-sort var800 0)
(declare-sort var3837 0)
(declare-sort var2750 0)
(declare-sort var1794 0)
(declare-sort var3950 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-String-init () (Array Int String))
(declare-fun var1573_arraycopy/-325913181 (var1620 Int var1620 Int Int) void)
(declare-fun cast-from-__Array__Int__String__-to-var1620 ((Array Int String)) var1620)
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-fun var3215_getEncoding/-422666462 (var2319) String)
(declare-fun var3215_getTagSeparator/-1758988662 (var2319) String)
(declare-fun var3950-init () var3950)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun <init>/875830710 (var3950 String) void)
(declare-const null-var2319 var2319)
(declare-const null-String String)
(declare-const var3250-TEXT var3250)
(declare-const null-var3504 var3504)
(declare-const null-var800 var800)
(declare-const null-var3837 var3837)
(declare-const null-var2750 var2750)
(declare-const null-var1794 var1794)
(declare-const null-Int Int)
(declare-const var3507 var2319) ; Statement: r4 := @parameter0: java.util.Properties 
(assert (not (= var3507 null-var2319)))
(declare-const var448 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var448 null-String)))
; split operation: var793 = var448.split(",") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var2561 Int (get_split_length var448 "," -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 != 1 goto $i1 = lengthof r1 
(assert (not (= var2561 1))) ; Cond: $i0 != 1 
(define-const var2440 Int (get_split_length var448 "," -1)) ; Statement: $i1 = lengthof r1 
(define-const var2222 Int (- var2440 1)) ; Statement: $i2 = $i1 - 1 
(define-const var3524 (Array Int String) arr-String-init) ; Statement: r2 = newarray (java.lang.String)[$i2] 
(define-const var2812 Int (get_split_length var448 "," -1)) ; Statement: $i3 = lengthof r1 
(define-const var483 Int (- var2812 1)) ; Statement: $i4 = $i3 - 1 
;(assert (var1573_arraycopy/-325913181 (cast-from-__Array__Int__String__-to-var1620 var793) 0 (cast-from-__Array__Int__String__-to-var1620 var3524) 0 var483)) ; Statement: staticinvoke <java.lang.System: void arraycopy(java.lang.Object,int,java.lang.Object,int,int)>(r1, 0, r2, 0, $i4) 

(declare-const var793!1 (Array Int String))
(declare-const var2032 Int)
(declare-const var3524!1 (Array Int String))
(declare-const var2032!1 Int)
(declare-const var483!1 Int)
(define-const var696 Int (getLength-Arr-String-1 var793!1)) ; Statement: $i5 = lengthof r1 
(define-const var3682 Int (- var696 1)) ; Statement: $i6 = $i5 - 1 
(define-const var423 String (select var793!1 var3682)) ; Statement: r3 = r1[$i6] 
(define-const var251 var3250 var3250-TEXT) ; Statement: r56 = <edu.stanford.nlp.tagger.io.TaggedFileRecord$Format: edu.stanford.nlp.tagger.io.TaggedFileRecord$Format TEXT> 
(define-const var3410 String (var3215_getEncoding/-422666462 var3507)) ; Statement: r57 = staticinvoke <edu.stanford.nlp.tagger.io.TaggedFileRecord: java.lang.String getEncoding(java.util.Properties)>(r4) 
(define-const var1699 String (var3215_getTagSeparator/-1758988662 var3507)) ; Statement: r58 = staticinvoke <edu.stanford.nlp.tagger.io.TaggedFileRecord: java.lang.String getTagSeparator(java.util.Properties)>(r4) 
(define-const var2913 var3504 null-var3504) ; Statement: r59 = null 
(define-const var3543 var800 null-var800) ; Statement: r60 = null 
(define-const var578 var3837 null-var3837) ; Statement: r61 = null 
(define-const var3713 var2750 null-var2750) ; Statement: r62 = null 
(define-const var2293 var1794 null-var1794) ; Statement: r63 = null 
(define-const var1176 Int null-Int) ; Statement: r64 = null 
(define-const var1717 Int null-Int) ; Statement: r65 = null 
(define-const var3685 Bool (ite (= 1 0) true false)) ; Statement: z11 = 0 
(define-const var1112 Int (getLength-Arr-String-1 var3524!1)) ; Statement: i7 = lengthof r2 
(define-const var2087 Int 0) ; Statement: i9 = 0 
(assert true) ; Non Conditional
 ; Statement: if i9 >= i7 goto $r5 = new edu.stanford.nlp.tagger.io.TaggedFileRecord 
(assert (not (>= var2087 var1112))) ; Negate: Cond: i9 >= i7  
(define-const var3971 String (select var3524!1 var2087)) ; Statement: r6 = r2[i9] 
; split operation: var3207 = var3971.split("=", 2) ; Statement: r7 = virtualinvoke r6.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("=", 2) 
(define-const var2448 Int (get_split_length var3971 "=" 2)) ; Statement: $i8 = lengthof r7 
 ; Statement: if $i8 == 2 goto $r8 = r7[0] 
(assert (not (= var2448 2))) ; Negate: Cond: $i8 == 2  
(define-const var2929 var3950 var3950-init) ; Statement: $r46 = new java.lang.IllegalArgumentException 
(define-const var3596 String String-init) ; Statement: $r47 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3596)) ; Statement: specialinvoke $r47.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3596!1 String)
(assert (= var3596!1 ""))
(assert true)
(define-const var1552 String (append/672562846 var3596!1 "TaggedFileRecord argument ")) ; Statement: $r48 = virtualinvoke $r47.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("TaggedFileRecord argument ") 
(declare-const var3596!2 String)
(assert (= var3596!2 (str.++ var3596!1 "TaggedFileRecord argument ")))
(assert true)
(define-const var1103 String (append/672562846 var1552 var3971)) ; Statement: $r49 = virtualinvoke $r48.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r6) 
(declare-const var1552!1 String)
(assert (= var1552!1 (str.++ var1552 var3971)))
(assert true)
(define-const var1251 String (append/672562846 var1103 " has an unexpected number of =s")) ; Statement: $r50 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" has an unexpected number of =s") 
(declare-const var1103!1 String)
(assert (= var1103!1 (str.++ var1103 " has an unexpected number of =s")))
(assert true)
(define-const var963 String (toString/-2075883882 var1251)) ; Statement: $r51 = virtualinvoke $r50.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (<init>/875830710 var2929 var963)) ; Statement: specialinvoke $r46.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r51) 

(declare-const var2929!1 var3950)
(declare-const var963!1 String)
 ; Statement: throw $r46 
(check-sat)
; {arr-String-init=([], java.lang.String[]), var1573_arraycopy/-325913181=([java.lang.Object, int, java.lang.Object, int, int], void), cast-from-__Array__Int__String__-to-var1620=([java.lang.String[]], java.lang.Object), getLength-Arr-String-1=([java.lang.String[]], int), var3215_getEncoding/-422666462=([java.util.Properties], java.lang.String), var3215_getTagSeparator/-1758988662=([java.util.Properties], java.lang.String), var3950-init=([], java.lang.IllegalArgumentException), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), <init>/875830710=([java.lang.IllegalArgumentException, java.lang.String], void)}
; {var2319=java.util.Properties, var3507=r4, var448=r0, var2356=null_type, var793=r1, var2561=$i0, var2440=$i1, var2222=$i2, var3524=r2, var2812=$i3, var483=$i4, var1573=java.lang.System, var1620=java.lang.Object, var2032=0, var696=$i5, var3682=$i6, var423=r3, var3250=edu.stanford.nlp.tagger.io.TaggedFileRecord$Format, var251=r56, var3215=edu.stanford.nlp.tagger.io.TaggedFileRecord, var3410=r57, var1699=r58, var3504=edu.stanford.nlp.trees.TreeTransformer, var2913=r59, var800=edu.stanford.nlp.trees.TreeNormalizer, var3543=r60, var3837=edu.stanford.nlp.trees.TreeReaderFactory, var578=r61, var2750=edu.stanford.nlp.io.NumberRangesFileFilter, var3713=r62, var1794=java.util.function.Predicate, var2293=r63, var1176=r64, var1717=r65, var3685=z11, var1112=i7, var2087=i9, var3971=r6, var3207=r7, var2448=$i8, var3950=java.lang.IllegalArgumentException, var2929=$r46, var3596=$r47, var1552=$r48, var1103=$r49, var1251=$r50, var963=$r51}
; {java.util.Properties=var2319, r4=var3507, r0=var448, null_type=var2356, r1=var793, $i0=var2561, $i1=var2440, $i2=var2222, r2=var3524, $i3=var2812, $i4=var483, java.lang.System=var1573, java.lang.Object=var1620, 0=var2032, $i5=var696, $i6=var3682, r3=var423, edu.stanford.nlp.tagger.io.TaggedFileRecord$Format=var3250, r56=var251, edu.stanford.nlp.tagger.io.TaggedFileRecord=var3215, r57=var3410, r58=var1699, edu.stanford.nlp.trees.TreeTransformer=var3504, r59=var2913, edu.stanford.nlp.trees.TreeNormalizer=var800, r60=var3543, edu.stanford.nlp.trees.TreeReaderFactory=var3837, r61=var578, edu.stanford.nlp.io.NumberRangesFileFilter=var2750, r62=var3713, java.util.function.Predicate=var1794, r63=var2293, r64=var1176, r65=var1717, z11=var3685, i7=var1112, i9=var2087, r6=var3971, r7=var3207, $i8=var2448, java.lang.IllegalArgumentException=var3950, $r46=var2929, $r47=var3596, $r48=var1552, $r49=var1103, $r50=var1251, $r51=var963}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String,int)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 3,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r4 := @parameter0: java.util.Properties;	r0 := @parameter1: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$i0 = lengthof r1;	if $i0 != 1 goto $i1 = lengthof r1;	$i1 = lengthof r1;	$i2 = $i1 - 1;	r2 = newarray (java.lang.String)[$i2];	$i3 = lengthof r1;	$i4 = $i3 - 1;	staticinvoke <java.lang.System: void arraycopy(java.lang.Object,int,java.lang.Object,int,int)>(r1, 0, r2, 0, $i4);	$i5 = lengthof r1;	$i6 = $i5 - 1;	r3 = r1[$i6];	r56 = <edu.stanford.nlp.tagger.io.TaggedFileRecord$Format: edu.stanford.nlp.tagger.io.TaggedFileRecord$Format TEXT>;	r57 = staticinvoke <edu.stanford.nlp.tagger.io.TaggedFileRecord: java.lang.String getEncoding(java.util.Properties)>(r4);	r58 = staticinvoke <edu.stanford.nlp.tagger.io.TaggedFileRecord: java.lang.String getTagSeparator(java.util.Properties)>(r4);	r59 = null;	r60 = null;	r61 = null;	r62 = null;	r63 = null;	r64 = null;	r65 = null;	z11 = 0;	i7 = lengthof r2;	i9 = 0;	if i9 >= i7 goto $r5 = new edu.stanford.nlp.tagger.io.TaggedFileRecord;	r6 = r2[i9];	r7 = virtualinvoke r6.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("=", 2);	$i8 = lengthof r7;	if $i8 == 2 goto $r8 = r7[0];	$r46 = new java.lang.IllegalArgumentException;	$r47 = new java.lang.StringBuilder;	specialinvoke $r47.<java.lang.StringBuilder: void <init>()>();	$r48 = virtualinvoke $r47.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("TaggedFileRecord argument ");	$r49 = virtualinvoke $r48.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r6);	$r50 = virtualinvoke $r49.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(" has an unexpected number of =s");	$r51 = virtualinvoke $r50.<java.lang.StringBuilder: java.lang.String toString()>();	specialinvoke $r46.<java.lang.IllegalArgumentException: void <init>(java.lang.String)>($r51);	throw $r46
;block_num 5
(get-model)
