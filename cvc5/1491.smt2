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

(declare-sort var1081 0)
(declare-sort var2764 0)
(declare-sort var1480 0)
(declare-sort var1300 0)
(declare-sort var3137 0)
(declare-sort var1237 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun replaceAll/1692887130 (String String String) String)
(declare-fun var1480-init () var1480)
(declare-fun <init>/-325640736 (var1480) void)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun var1300_add/-376848345 (var1300 var3137) Bool)
(declare-fun cast-from-var1480-to-var1300 (var1480) var1300)
(declare-fun cast-from-String-to-var3137 (String) var3137)
(declare-fun var1237-init () var1237)
(declare-fun <init>/1828590458 (var1237 var1300 var3137) void)
(declare-const null-String String)
(declare-const var2764-line1 Int)
(declare-const var1498 String) ; Statement: r15 := @parameter0: java.lang.String 
(assert (not (= var1498 null-String)))
(define-const var172 Int var2764-line1) ; Statement: $i0 = <edu.stanford.nlp.classify.Dataset: int line1> 
(define-const var2170 Int (+ var172 1)) ; Statement: $i1 = $i0 + 1 
(define-const var349 Int var2170) ; Statement: <edu.stanford.nlp.classify.Dataset: int line1> = $i1 
(assert true)
(define-const var2177 String (replaceAll/1692887130 var1498 "#.*" "")) ; Statement: r16 = virtualinvoke r15.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("#.*", "") 
(assert (= (replaceAll/1692887130 var1498 "#.*" "") (str.replace_re_all var1498 (re.++ (str.to_re "#") (re.* re.allchar)) "")))
; split operation: var3848 = var2177.split("\u005cs+") ; Statement: r0 = virtualinvoke r16.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var1364 var1480 var1480-init) ; Statement: $r1 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var1364)) ; Statement: specialinvoke $r1.<java.util.ArrayList: void <init>()>() 

(declare-const var1364!1 var1480)
(define-const var3524 Int 1) ; Statement: i6 = 1 
(assert true) ; Non Conditional
(define-const var3973 Int (get_split_length var2177 "\u005cs+" -1)) ; Statement: $i2 = lengthof r0 
 ; Statement: if i6 >= $i2 goto $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(2147483647) 
(assert (>= var3524 var3973)) ; Cond: i6 >= $i2 
(define-const var3896 String (String_valueOf/1240665136 2147483647)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(2147483647) 
;(assert (var1300_add/-376848345 (cast-from-var1480-to-var1300 var1364!1) (cast-from-String-to-var3137 var3896))) ; Statement: interfaceinvoke $r1.<java.util.Collection: boolean add(java.lang.Object)>($r2) 

(declare-const var1364!2 var1480)
(declare-const var3896!1 String)
(define-const var1550 var1237 var1237-init) ; Statement: $r3 = new edu.stanford.nlp.ling.BasicDatum 
(define-const var3379 String (get_split_element var2177 "\u005cs+" -1 0)) ; Statement: $r4 = r0[0] 
(assert true)
;(assert (<init>/1828590458 var1550 (cast-from-var1480-to-var1300 var1364!2) (cast-from-String-to-var3137 var3379))) ; Statement: specialinvoke $r3.<edu.stanford.nlp.ling.BasicDatum: void <init>(java.util.Collection,java.lang.Object)>($r1, $r4) 

(declare-const var1550!1 var1237)
(declare-const var1364!3 var1480)
(declare-const var3379!1 String)
 ; Statement: return $r3 
(check-sat)
; {replaceAll/1692887130=([java.lang.String, java.lang.String, java.lang.String], java.lang.String), var1480-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), String_valueOf/1240665136=([int], java.lang.String), var1300_add/-376848345=([java.util.Collection, java.lang.Object], boolean), cast-from-var1480-to-var1300=([java.util.ArrayList], java.util.Collection), cast-from-String-to-var3137=([java.lang.String], java.lang.Object), var1237-init=([], edu.stanford.nlp.ling.BasicDatum), <init>/1828590458=([edu.stanford.nlp.ling.BasicDatum, java.util.Collection, java.lang.Object], void)}
; {var1498=r15, var1081=null_type, var2764=edu.stanford.nlp.classify.Dataset, var172=$i0, var2170=$i1, var349=<edu.stanford.nlp.classify.Dataset: int line1>, var2177=r16, var3848=r0, var1480=java.util.ArrayList, var1364=$r1, var3524=i6, var3973=$i2, var3896=$r2, var1300=java.util.Collection, var3137=java.lang.Object, var1237=edu.stanford.nlp.ling.BasicDatum, var1550=$r3, var3379=$r4}
; {r15=var1498, null_type=var1081, edu.stanford.nlp.classify.Dataset=var2764, $i0=var172, $i1=var2170, <edu.stanford.nlp.classify.Dataset: int line1>=var349, r16=var2177, r0=var3848, java.util.ArrayList=var1480, $r1=var1364, i6=var3524, $i2=var3973, $r2=var3896, java.util.Collection=var1300, java.lang.Object=var3137, edu.stanford.nlp.ling.BasicDatum=var1237, $r3=var1550, $r4=var3379}
;seq <java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r15 := @parameter0: java.lang.String;	$i0 = <edu.stanford.nlp.classify.Dataset: int line1>;	$i1 = $i0 + 1;	<edu.stanford.nlp.classify.Dataset: int line1> = $i1;	r16 = virtualinvoke r15.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("#.*", "");	r0 = virtualinvoke r16.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r1 = new java.util.ArrayList;	specialinvoke $r1.<java.util.ArrayList: void <init>()>();	i6 = 1;	$i2 = lengthof r0;	if i6 >= $i2 goto $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(2147483647);	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>(2147483647);	interfaceinvoke $r1.<java.util.Collection: boolean add(java.lang.Object)>($r2);	$r3 = new edu.stanford.nlp.ling.BasicDatum;	$r4 = r0[0];	specialinvoke $r3.<edu.stanford.nlp.ling.BasicDatum: void <init>(java.util.Collection,java.lang.Object)>($r1, $r4);	return $r3
;block_num 3
(get-model)
