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

(declare-sort var3519 0)
(declare-sort var2682 0)
(declare-sort var184 0)
(declare-sort var448 0)
(declare-sort var1505 0)
(declare-sort var3631 0)
(declare-sort var3543 0)
(declare-sort var478 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1505!class ClassObject)
(declare-fun var448_fillOptions/-926000568 (ClassObject var3519) void)
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun equals/1194252418 (var3631 var3543) Bool)
(declare-fun cast-from-var2682-to-var3631 (var2682) var3631)
(declare-fun cast-from-var2682-to-var3543 (var2682) var3543)
(declare-fun var478_setUp/-1798686479 (var3519) void)
(declare-const null-var3519 var3519)
(declare-const null-var2682 var2682)
(declare-const null-var184 var184)
(declare-const var1505-numWordsCompound String)
(declare-const var2682-SURFACE var2682)
(declare-const var2088 var3519) ; Statement: r0 := @parameter0: java.util.Properties 
(assert (not (= var2088 null-var3519)))
(declare-const var3230 var2682) ; Statement: r3 := @parameter1: edu.stanford.nlp.patterns.PatternFactory$PatternType 
(assert (not (= var3230 null-var2682)))
(declare-const var1610 var184) ; Statement: r15 := @parameter2: java.util.Set 
(assert (not (= var1610 null-var184)))
;(assert (var448_fillOptions/-926000568 var1505!class var2088)) ; Statement: staticinvoke <edu.stanford.nlp.util.ArgumentParser: void fillOptions(java.lang.Class,java.util.Properties)>(class "Ledu/stanford/nlp/patterns/PatternFactory;", r0) 

(declare-const var2764 ClassObject)
(declare-const var2088!1 var3519)
(define-const var87 Int 0) ; Statement: <edu.stanford.nlp.patterns.PatternFactory: int numWordsCompoundMax> = 0 
(define-const var3667 String var1505-numWordsCompound) ; Statement: $r1 = <edu.stanford.nlp.patterns.PatternFactory: java.lang.String numWordsCompound> 
(assert true)
(define-const var80 Bool (contains/1009244746 var3667 (cast-from-String-to-String ","))) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean contains(java.lang.CharSequence)>(",") 
 ; Statement: if $z0 != 0 goto $r2 = <edu.stanford.nlp.patterns.PatternFactory: java.lang.String numWordsCompound> 
(assert (not (= (ite var80 1 0) 0))) ; Cond: $z0 != 0 
(define-const var709 String var1505-numWordsCompound) ; Statement: $r2 = <edu.stanford.nlp.patterns.PatternFactory: java.lang.String numWordsCompound> 
; split operation: var3088 = var709.split(";") ; Statement: $r20 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(";") 
(define-const var1102 Int (get_split_length var709 ";" -1)) ; Statement: $i4 = lengthof $r20 
(define-const var3423 Int 0) ; Statement: i5 = 0 
(assert true) ; Non Conditional
 ; Statement: if i5 >= $i4 goto (branch) 
(assert (>= var3423 var1102)) ; Cond: i5 >= $i4 
 ; Statement: goto [?= $r4 = <edu.stanford.nlp.patterns.PatternFactory$PatternType: edu.stanford.nlp.patterns.PatternFactory$PatternType SURFACE>] 
(assert true) ; Non Conditional
(define-const var3304 var2682 var2682-SURFACE) ; Statement: $r4 = <edu.stanford.nlp.patterns.PatternFactory$PatternType: edu.stanford.nlp.patterns.PatternFactory$PatternType SURFACE> 
(assert true)
(define-const var1420 Bool (equals/1194252418 (cast-from-var2682-to-var3631 var3230) (cast-from-var2682-to-var3543 var3304))) ; Statement: $z1 = virtualinvoke r3.<edu.stanford.nlp.patterns.PatternFactory$PatternType: boolean equals(java.lang.Object)>($r4) 
 ; Statement: if $z1 == 0 goto $r5 = <edu.stanford.nlp.patterns.PatternFactory$PatternType: edu.stanford.nlp.patterns.PatternFactory$PatternType DEP> 
(assert (not (= (ite var1420 1 0) 0))) ; Negate: Cond: $z1 == 0  
;(assert (var478_setUp/-1798686479 var2088!1)) ; Statement: staticinvoke <edu.stanford.nlp.patterns.surface.SurfacePatternFactory: void setUp(java.util.Properties)>(r0) 

(declare-const var2088!2 var3519)
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {var448_fillOptions/-926000568=([java.lang.Class, java.util.Properties], void), contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), equals/1194252418=([java.lang.Enum, java.lang.Object], boolean), cast-from-var2682-to-var3631=([edu.stanford.nlp.patterns.PatternFactory$PatternType], java.lang.Enum), cast-from-var2682-to-var3543=([edu.stanford.nlp.patterns.PatternFactory$PatternType], java.lang.Object), var478_setUp/-1798686479=([java.util.Properties], void)}
; {var3519=java.util.Properties, var2088=r0, var2682=edu.stanford.nlp.patterns.PatternFactory$PatternType, var3230=r3, var184=java.util.Set, var1610=r15, var448=edu.stanford.nlp.util.ArgumentParser, var1505=edu.stanford.nlp.patterns.PatternFactory, var2764=class "Ledu/stanford/nlp/patterns/PatternFactory;", var87=<edu.stanford.nlp.patterns.PatternFactory: int numWordsCompoundMax>, var3667=$r1, var80=$z0, var709=$r2, var3088=$r20, var1102=$i4, var3423=i5, var3304=$r4, var3631=java.lang.Enum, var3543=java.lang.Object, var1420=$z1, var478=edu.stanford.nlp.patterns.surface.SurfacePatternFactory}
; {java.util.Properties=var3519, r0=var2088, edu.stanford.nlp.patterns.PatternFactory$PatternType=var2682, r3=var3230, java.util.Set=var184, r15=var1610, edu.stanford.nlp.util.ArgumentParser=var448, edu.stanford.nlp.patterns.PatternFactory=var1505, class "Ledu/stanford/nlp/patterns/PatternFactory;"=var2764, <edu.stanford.nlp.patterns.PatternFactory: int numWordsCompoundMax>=var87, $r1=var3667, $z0=var80, $r2=var709, $r20=var3088, $i4=var1102, i5=var3423, $r4=var3304, java.lang.Enum=var3631, java.lang.Object=var3543, $z1=var1420, edu.stanford.nlp.patterns.surface.SurfacePatternFactory=var478}
;seq <java.lang.String: boolean contains(java.lang.CharSequence)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: boolean contains(java.lang.CharSequence)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.util.Properties;	r3 := @parameter1: edu.stanford.nlp.patterns.PatternFactory$PatternType;	r15 := @parameter2: java.util.Set;	staticinvoke <edu.stanford.nlp.util.ArgumentParser: void fillOptions(java.lang.Class,java.util.Properties)>(class "Ledu/stanford/nlp/patterns/PatternFactory;", r0);	<edu.stanford.nlp.patterns.PatternFactory: int numWordsCompoundMax> = 0;	$r1 = <edu.stanford.nlp.patterns.PatternFactory: java.lang.String numWordsCompound>;	$z0 = virtualinvoke $r1.<java.lang.String: boolean contains(java.lang.CharSequence)>(",");	if $z0 != 0 goto $r2 = <edu.stanford.nlp.patterns.PatternFactory: java.lang.String numWordsCompound>;	$r2 = <edu.stanford.nlp.patterns.PatternFactory: java.lang.String numWordsCompound>;	$r20 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(";");	$i4 = lengthof $r20;	i5 = 0;	if i5 >= $i4 goto (branch);	goto [?= $r4 = <edu.stanford.nlp.patterns.PatternFactory$PatternType: edu.stanford.nlp.patterns.PatternFactory$PatternType SURFACE>];	$r4 = <edu.stanford.nlp.patterns.PatternFactory$PatternType: edu.stanford.nlp.patterns.PatternFactory$PatternType SURFACE>;	$z1 = virtualinvoke r3.<edu.stanford.nlp.patterns.PatternFactory$PatternType: boolean equals(java.lang.Object)>($r4);	if $z1 == 0 goto $r5 = <edu.stanford.nlp.patterns.PatternFactory$PatternType: edu.stanford.nlp.patterns.PatternFactory$PatternType DEP>;	staticinvoke <edu.stanford.nlp.patterns.surface.SurfacePatternFactory: void setUp(java.util.Properties)>(r0);	goto [?= return];	return
;block_num 7
(get-model)
