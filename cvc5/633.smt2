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

(declare-sort var2050 0)
(declare-sort var523 0)
(declare-sort var2366 0)
(declare-sort var2103 0)
(declare-sort var1698 0)
(declare-sort var2754 0)
(declare-sort var3041 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-fun var2103_argsToProperties/-1524630653 ((Array Int String) var2050) var2366)
(declare-fun getProperty/1391780669 (var2366 String) String)
(declare-fun var1698-init () var1698)
(declare-fun <init>/-325640736 (var1698) void)
(declare-fun var523-init () var523)
(declare-fun <init>/1278683649 (var523 var2754 var2366) void)
(declare-fun cast-from-var1698-to-var2754 (var1698) var2754)
(declare-fun process/-2031771835 (var523) var2754)
(declare-fun var3041_getBool/43227246 (var2366 String) Bool)
(declare-fun getProperty/-469436802 (var2366 String String) String)
(declare-fun var2754_iterator/-912451715 (var2754) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var523-argOptionDefs var2050)
(declare-const var1893 (Array Int String)) ; Statement: r0 := @parameter0: java.lang.String[] 
(assert (not (= var1893 null-__Array__Int__String__)))
(define-const var3571 Int (getLength-Arr-String-1 var1893)) ; Statement: $i0 = lengthof r0 
 ; Statement: if $i0 >= 1 goto $r1 = <edu.stanford.nlp.international.spanish.pipeline.AnCoraProcessor: java.util.Map argOptionDefs> 
(assert (>= var3571 1)) ; Cond: $i0 >= 1 
(define-const var786 var2050 var523-argOptionDefs) ; Statement: $r1 = <edu.stanford.nlp.international.spanish.pipeline.AnCoraProcessor: java.util.Map argOptionDefs> 
(define-const var260 var2366 (var2103_argsToProperties/-1524630653 var1893 var786)) ; Statement: $r16 = staticinvoke <edu.stanford.nlp.util.StringUtils: java.util.Properties argsToProperties(java.lang.String[],java.util.Map)>(r0, $r1) 
(assert true)
(define-const var214 String (getProperty/1391780669 var260 "")) ; Statement: $r2 = virtualinvoke $r16.<java.util.Properties: java.lang.String getProperty(java.lang.String)>("") 
; split operation: var3608 = var214.split(" ") ; Statement: $r17 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ") 
(define-const var2464 var1698 var1698-init) ; Statement: $r3 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var2464)) ; Statement: specialinvoke $r3.<java.util.ArrayList: void <init>()>() 

(declare-const var2464!1 var1698)
(define-const var2147 Int (get_split_length var214 " " -1)) ; Statement: $i1 = lengthof $r17 
(define-const var1761 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
 ; Statement: if i2 >= $i1 goto $r4 = new edu.stanford.nlp.international.spanish.pipeline.AnCoraProcessor 
(assert (>= var1761 var2147)) ; Cond: i2 >= $i1 
(define-const var2262 var523 var523-init) ; Statement: $r4 = new edu.stanford.nlp.international.spanish.pipeline.AnCoraProcessor 
(assert true)
;(assert (<init>/1278683649 var2262 (cast-from-var1698-to-var2754 var2464!1) var260)) ; Statement: specialinvoke $r4.<edu.stanford.nlp.international.spanish.pipeline.AnCoraProcessor: void <init>(java.util.List,java.util.Properties)>($r3, $r16) 

(declare-const var2262!1 var523)
(declare-const var2464!2 var1698)
(declare-const var260!1 var2366)
(assert true)
(define-const var1015 var2754 (process/-2031771835 var2262!1)) ; Statement: r19 = virtualinvoke $r4.<edu.stanford.nlp.international.spanish.pipeline.AnCoraProcessor: java.util.List process()>() 
(define-const var2190 Bool (var3041_getBool/43227246 var260!1 "convertToUD")) ; Statement: z3 = staticinvoke <edu.stanford.nlp.util.PropertiesUtils: boolean getBool(java.util.Properties,java.lang.String)>($r16, "convertToUD") 
 ; Statement: if z3 == 0 goto $z2 = staticinvoke <edu.stanford.nlp.util.PropertiesUtils: boolean getBool(java.util.Properties,java.lang.String)>($r16, "generateTags") 
(assert (= (ite var2190 1 0) 0)) ; Cond: z3 == 0 
(define-const var78 Bool (var3041_getBool/43227246 var260!1 "generateTags")) ; Statement: $z2 = staticinvoke <edu.stanford.nlp.util.PropertiesUtils: boolean getBool(java.util.Properties,java.lang.String)>($r16, "generateTags") 
(assert true)
(define-const var3368 String (getProperty/-469436802 var260!1 "generateTagsModel" "edu/stanford/nlp/models/pos-tagger/spanish-ud.tagger")) ; Statement: $r10 = virtualinvoke $r16.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("generateTagsModel", "edu/stanford/nlp/models/pos-tagger/spanish-ud.tagger") 
 ; Statement: if $z2 == 0 goto $r23 = interfaceinvoke r19.<java.util.List: java.util.Iterator iterator()>() 
(assert (= (ite var78 1 0) 0)) ; Cond: $z2 == 0 
(define-const var644 Iterator (var2754_iterator/-912451715 var1015)) ; Statement: $r23 = interfaceinvoke r19.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var1671 Bool (Iterator_hasNext/-1669924200 var644)) ; Statement: $z4 = interfaceinvoke $r23.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z4 == 0 goto return 
(assert (= (ite var1671 1 0) 0)) ; Cond: $z4 == 0 
 ; Statement: return 
(check-sat)
; {getLength-Arr-String-1=([java.lang.String[]], int), var2103_argsToProperties/-1524630653=([java.lang.String[], java.util.Map], java.util.Properties), getProperty/1391780669=([java.util.Properties, java.lang.String], java.lang.String), var1698-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), var523-init=([], edu.stanford.nlp.international.spanish.pipeline.AnCoraProcessor), <init>/1278683649=([edu.stanford.nlp.international.spanish.pipeline.AnCoraProcessor, java.util.List, java.util.Properties], void), cast-from-var1698-to-var2754=([java.util.ArrayList], java.util.List), process/-2031771835=([edu.stanford.nlp.international.spanish.pipeline.AnCoraProcessor], java.util.List), var3041_getBool/43227246=([java.util.Properties, java.lang.String], boolean), getProperty/-469436802=([java.util.Properties, java.lang.String, java.lang.String], java.lang.String), var2754_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean)}
; {var1893=r0, var3571=$i0, var2050=java.util.Map, var523=edu.stanford.nlp.international.spanish.pipeline.AnCoraProcessor, var786=$r1, var2366=java.util.Properties, var2103=edu.stanford.nlp.util.StringUtils, var260=$r16, var214=$r2, var3608=$r17, var1698=java.util.ArrayList, var2464=$r3, var2147=$i1, var1761=i2, var2262=$r4, var2754=java.util.List, var1015=r19, var3041=edu.stanford.nlp.util.PropertiesUtils, var2190=z3, var78=$z2, var3368=$r10, var644=$r23, var1671=$z4}
; {r0=var1893, $i0=var3571, java.util.Map=var2050, edu.stanford.nlp.international.spanish.pipeline.AnCoraProcessor=var523, $r1=var786, java.util.Properties=var2366, edu.stanford.nlp.util.StringUtils=var2103, $r16=var260, $r2=var214, $r17=var3608, java.util.ArrayList=var1698, $r3=var2464, $i1=var2147, i2=var1761, $r4=var2262, java.util.List=var2754, r19=var1015, edu.stanford.nlp.util.PropertiesUtils=var3041, z3=var2190, $z2=var78, $r10=var3368, $r23=var644, $z4=var1671}
;seq <edu.stanford.nlp.util.StringUtils: java.util.Properties argsToProperties(java.lang.String[],java.util.Map)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<edu.stanford.nlp.util.StringUtils: java.util.Properties argsToProperties(java.lang.String[],java.util.Map)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String[];	$i0 = lengthof r0;	if $i0 >= 1 goto $r1 = <edu.stanford.nlp.international.spanish.pipeline.AnCoraProcessor: java.util.Map argOptionDefs>;	$r1 = <edu.stanford.nlp.international.spanish.pipeline.AnCoraProcessor: java.util.Map argOptionDefs>;	$r16 = staticinvoke <edu.stanford.nlp.util.StringUtils: java.util.Properties argsToProperties(java.lang.String[],java.util.Map)>(r0, $r1);	$r2 = virtualinvoke $r16.<java.util.Properties: java.lang.String getProperty(java.lang.String)>("");	$r17 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	$r3 = new java.util.ArrayList;	specialinvoke $r3.<java.util.ArrayList: void <init>()>();	$i1 = lengthof $r17;	i2 = 0;	if i2 >= $i1 goto $r4 = new edu.stanford.nlp.international.spanish.pipeline.AnCoraProcessor;	$r4 = new edu.stanford.nlp.international.spanish.pipeline.AnCoraProcessor;	specialinvoke $r4.<edu.stanford.nlp.international.spanish.pipeline.AnCoraProcessor: void <init>(java.util.List,java.util.Properties)>($r3, $r16);	r19 = virtualinvoke $r4.<edu.stanford.nlp.international.spanish.pipeline.AnCoraProcessor: java.util.List process()>();	z3 = staticinvoke <edu.stanford.nlp.util.PropertiesUtils: boolean getBool(java.util.Properties,java.lang.String)>($r16, "convertToUD");	if z3 == 0 goto $z2 = staticinvoke <edu.stanford.nlp.util.PropertiesUtils: boolean getBool(java.util.Properties,java.lang.String)>($r16, "generateTags");	$z2 = staticinvoke <edu.stanford.nlp.util.PropertiesUtils: boolean getBool(java.util.Properties,java.lang.String)>($r16, "generateTags");	$r10 = virtualinvoke $r16.<java.util.Properties: java.lang.String getProperty(java.lang.String,java.lang.String)>("generateTagsModel", "edu/stanford/nlp/models/pos-tagger/spanish-ud.tagger");	if $z2 == 0 goto $r23 = interfaceinvoke r19.<java.util.List: java.util.Iterator iterator()>();	$r23 = interfaceinvoke r19.<java.util.List: java.util.Iterator iterator()>();	$z4 = interfaceinvoke $r23.<java.util.Iterator: boolean hasNext()>();	if $z4 == 0 goto return;	return
;block_num 8
(get-model)
