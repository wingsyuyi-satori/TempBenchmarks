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

(declare-sort var2009 0)
(declare-sort var3023 0)
(declare-sort var2823 0)
(declare-sort var1673 0)
(declare-sort var1337 0)
(declare-sort var3244 0)
(declare-sort var1730 0)
(declare-sort var3282 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1337!class ClassObject)
(declare-fun var1673_fillOptions/-926000568 (ClassObject var2009) void)
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun equals/1194252418 (var3244 var1730) Bool)
(declare-fun cast-from-var3023-to-var3244 (var3023) var3244)
(declare-fun cast-from-var3023-to-var1730 (var3023) var1730)
(declare-fun var3282-init () var3282)
(declare-fun <init>/-1040522254 (var3282) void)
(declare-const null-var2009 var2009)
(declare-const null-var3023 var3023)
(declare-const null-var2823 var2823)
(declare-const var1337-numWordsCompound String)
(declare-const var3023-SURFACE var3023)
(declare-const var3023-DEP var3023)
(declare-const var1604 var2009) ; Statement: r0 := @parameter0: java.util.Properties 
(assert (not (= var1604 null-var2009)))
(declare-const var779 var3023) ; Statement: r3 := @parameter1: edu.stanford.nlp.patterns.PatternFactory$PatternType 
(assert (not (= var779 null-var3023)))
(declare-const var3260 var2823) ; Statement: r15 := @parameter2: java.util.Set 
(assert (not (= var3260 null-var2823)))
;(assert (var1673_fillOptions/-926000568 var1337!class var1604)) ; Statement: staticinvoke <edu.stanford.nlp.util.ArgumentParser: void fillOptions(java.lang.Class,java.util.Properties)>(class "Ledu/stanford/nlp/patterns/PatternFactory;", r0) 

(declare-const var1332 ClassObject)
(declare-const var1604!1 var2009)
(define-const var1958 Int 0) ; Statement: <edu.stanford.nlp.patterns.PatternFactory: int numWordsCompoundMax> = 0 
(define-const var1841 String var1337-numWordsCompound) ; Statement: $r1 = <edu.stanford.nlp.patterns.PatternFactory: java.lang.String numWordsCompound> 
(assert true)
(define-const var209 Bool (contains/1009244746 var1841 (cast-from-String-to-String ","))) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean contains(java.lang.CharSequence)>(",") 
 ; Statement: if $z0 != 0 goto $r2 = <edu.stanford.nlp.patterns.PatternFactory: java.lang.String numWordsCompound> 
(assert (not (= (ite var209 1 0) 0))) ; Cond: $z0 != 0 
(define-const var455 String var1337-numWordsCompound) ; Statement: $r2 = <edu.stanford.nlp.patterns.PatternFactory: java.lang.String numWordsCompound> 
; split operation: var1273 = var455.split(";") ; Statement: $r20 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(";") 
(define-const var3243 Int (get_split_length var455 ";" -1)) ; Statement: $i4 = lengthof $r20 
(define-const var1151 Int 0) ; Statement: i5 = 0 
(assert true) ; Non Conditional
 ; Statement: if i5 >= $i4 goto (branch) 
(assert (>= var1151 var3243)) ; Cond: i5 >= $i4 
 ; Statement: goto [?= $r4 = <edu.stanford.nlp.patterns.PatternFactory$PatternType: edu.stanford.nlp.patterns.PatternFactory$PatternType SURFACE>] 
(assert true) ; Non Conditional
(define-const var2040 var3023 var3023-SURFACE) ; Statement: $r4 = <edu.stanford.nlp.patterns.PatternFactory$PatternType: edu.stanford.nlp.patterns.PatternFactory$PatternType SURFACE> 
(assert true)
(define-const var632 Bool (equals/1194252418 (cast-from-var3023-to-var3244 var779) (cast-from-var3023-to-var1730 var2040))) ; Statement: $z1 = virtualinvoke r3.<edu.stanford.nlp.patterns.PatternFactory$PatternType: boolean equals(java.lang.Object)>($r4) 
 ; Statement: if $z1 == 0 goto $r5 = <edu.stanford.nlp.patterns.PatternFactory$PatternType: edu.stanford.nlp.patterns.PatternFactory$PatternType DEP> 
(assert (= (ite var632 1 0) 0)) ; Cond: $z1 == 0 
(define-const var3481 var3023 var3023-DEP) ; Statement: $r5 = <edu.stanford.nlp.patterns.PatternFactory$PatternType: edu.stanford.nlp.patterns.PatternFactory$PatternType DEP> 
(assert true)
(define-const var2936 Bool (equals/1194252418 (cast-from-var3023-to-var3244 var779) (cast-from-var3023-to-var1730 var3481))) ; Statement: $z2 = virtualinvoke r3.<edu.stanford.nlp.patterns.PatternFactory$PatternType: boolean equals(java.lang.Object)>($r5) 
 ; Statement: if $z2 == 0 goto $r6 = new java.lang.UnsupportedOperationException 
(assert (= (ite var2936 1 0) 0)) ; Cond: $z2 == 0 
(define-const var2832 var3282 var3282-init) ; Statement: $r6 = new java.lang.UnsupportedOperationException 
(assert true)
;(assert (<init>/-1040522254 var2832)) ; Statement: specialinvoke $r6.<java.lang.UnsupportedOperationException: void <init>()>() 

(declare-const var2832!1 var3282)
 ; Statement: throw $r6 
(check-sat)
; {var1673_fillOptions/-926000568=([java.lang.Class, java.util.Properties], void), contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), equals/1194252418=([java.lang.Enum, java.lang.Object], boolean), cast-from-var3023-to-var3244=([edu.stanford.nlp.patterns.PatternFactory$PatternType], java.lang.Enum), cast-from-var3023-to-var1730=([edu.stanford.nlp.patterns.PatternFactory$PatternType], java.lang.Object), var3282-init=([], java.lang.UnsupportedOperationException), <init>/-1040522254=([java.lang.UnsupportedOperationException], void)}
; {var2009=java.util.Properties, var1604=r0, var3023=edu.stanford.nlp.patterns.PatternFactory$PatternType, var779=r3, var2823=java.util.Set, var3260=r15, var1673=edu.stanford.nlp.util.ArgumentParser, var1337=edu.stanford.nlp.patterns.PatternFactory, var1332=class "Ledu/stanford/nlp/patterns/PatternFactory;", var1958=<edu.stanford.nlp.patterns.PatternFactory: int numWordsCompoundMax>, var1841=$r1, var209=$z0, var455=$r2, var1273=$r20, var3243=$i4, var1151=i5, var2040=$r4, var3244=java.lang.Enum, var1730=java.lang.Object, var632=$z1, var3481=$r5, var2936=$z2, var3282=java.lang.UnsupportedOperationException, var2832=$r6}
; {java.util.Properties=var2009, r0=var1604, edu.stanford.nlp.patterns.PatternFactory$PatternType=var3023, r3=var779, java.util.Set=var2823, r15=var3260, edu.stanford.nlp.util.ArgumentParser=var1673, edu.stanford.nlp.patterns.PatternFactory=var1337, class "Ledu/stanford/nlp/patterns/PatternFactory;"=var1332, <edu.stanford.nlp.patterns.PatternFactory: int numWordsCompoundMax>=var1958, $r1=var1841, $z0=var209, $r2=var455, $r20=var1273, $i4=var3243, i5=var1151, $r4=var2040, java.lang.Enum=var3244, java.lang.Object=var1730, $z1=var632, $r5=var3481, $z2=var2936, java.lang.UnsupportedOperationException=var3282, $r6=var2832}
;seq <java.lang.String: boolean contains(java.lang.CharSequence)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: boolean contains(java.lang.CharSequence)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.util.Properties;	r3 := @parameter1: edu.stanford.nlp.patterns.PatternFactory$PatternType;	r15 := @parameter2: java.util.Set;	staticinvoke <edu.stanford.nlp.util.ArgumentParser: void fillOptions(java.lang.Class,java.util.Properties)>(class "Ledu/stanford/nlp/patterns/PatternFactory;", r0);	<edu.stanford.nlp.patterns.PatternFactory: int numWordsCompoundMax> = 0;	$r1 = <edu.stanford.nlp.patterns.PatternFactory: java.lang.String numWordsCompound>;	$z0 = virtualinvoke $r1.<java.lang.String: boolean contains(java.lang.CharSequence)>(",");	if $z0 != 0 goto $r2 = <edu.stanford.nlp.patterns.PatternFactory: java.lang.String numWordsCompound>;	$r2 = <edu.stanford.nlp.patterns.PatternFactory: java.lang.String numWordsCompound>;	$r20 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(";");	$i4 = lengthof $r20;	i5 = 0;	if i5 >= $i4 goto (branch);	goto [?= $r4 = <edu.stanford.nlp.patterns.PatternFactory$PatternType: edu.stanford.nlp.patterns.PatternFactory$PatternType SURFACE>];	$r4 = <edu.stanford.nlp.patterns.PatternFactory$PatternType: edu.stanford.nlp.patterns.PatternFactory$PatternType SURFACE>;	$z1 = virtualinvoke r3.<edu.stanford.nlp.patterns.PatternFactory$PatternType: boolean equals(java.lang.Object)>($r4);	if $z1 == 0 goto $r5 = <edu.stanford.nlp.patterns.PatternFactory$PatternType: edu.stanford.nlp.patterns.PatternFactory$PatternType DEP>;	$r5 = <edu.stanford.nlp.patterns.PatternFactory$PatternType: edu.stanford.nlp.patterns.PatternFactory$PatternType DEP>;	$z2 = virtualinvoke r3.<edu.stanford.nlp.patterns.PatternFactory$PatternType: boolean equals(java.lang.Object)>($r5);	if $z2 == 0 goto $r6 = new java.lang.UnsupportedOperationException;	$r6 = new java.lang.UnsupportedOperationException;	specialinvoke $r6.<java.lang.UnsupportedOperationException: void <init>()>();	throw $r6
;block_num 7
(get-model)
