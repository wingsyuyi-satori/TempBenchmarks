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

(declare-sort var3277 0)
(declare-sort var2765 0)
(declare-sort var1102 0)
(declare-sort var348 0)
(declare-sort var3535 0)
(declare-sort var24 0)
(declare-sort var270 0)
(declare-sort var2299 0)
(declare-sort var3450 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-1890226404 (var3535 var2765 var1102 var348 var348 var348) void)
(declare-fun cast-from-var3277-to-var3535 (var3277) var3535)
(declare-fun learningRate/620388015 (var3277) Float32)
(declare-fun var24-init () var24)
(declare-fun <init>/-1553701343 (var24) void)
(declare-fun featureWeights/620388015 (var3277) var24)
(declare-fun featureFactoryClass/-870760670 (var2765) String)
(declare-fun arr-var270-init () (Array Int var270))
(declare-fun var2299_loadByReflection/-126565946 (String (Array Int var270)) var270)
(declare-fun cast-from-var270-to-var3450 (var270) var3450)
(declare-fun featureFactory/620388015 (var3277) var3450)
(declare-const null-var3277 var3277)
(declare-const null-var2765 var2765)
(declare-const null-var1102 var1102)
(declare-const null-var348 var348)
(declare-const var1718 var3277) ; Statement: r0 := @this: edu.stanford.nlp.parser.shiftreduce.PerceptronModel 
(assert (not (= var1718 null-var3277)))
(declare-const var3730 var2765) ; Statement: r1 := @parameter0: edu.stanford.nlp.parser.shiftreduce.ShiftReduceOptions 
(assert (not (= var3730 null-var2765)))
(declare-const var2441 var1102) ; Statement: r2 := @parameter1: edu.stanford.nlp.util.Index 
(assert (not (= var2441 null-var1102)))
(declare-const var3390 var348) ; Statement: r3 := @parameter2: java.util.Set 
(assert (not (= var3390 null-var348)))
(declare-const var3182 var348) ; Statement: r4 := @parameter3: java.util.Set 
(assert (not (= var3182 null-var348)))
(declare-const var2096 var348) ; Statement: r5 := @parameter4: java.util.Set 
(assert (not (= var2096 null-var348)))
(assert true)
;(assert (<init>/-1890226404 (cast-from-var3277-to-var3535 var1718) var3730 var2441 var3390 var3182 var2096)) ; Statement: specialinvoke r0.<edu.stanford.nlp.parser.shiftreduce.BaseModel: void <init>(edu.stanford.nlp.parser.shiftreduce.ShiftReduceOptions,edu.stanford.nlp.util.Index,java.util.Set,java.util.Set,java.util.Set)>(r1, r2, r3, r4, r5) 

(declare-const var1718!1 var3277)
(declare-const var3730!1 var2765)
(declare-const var2441!1 var1102)
(declare-const var3390!1 var348)
(declare-const var3182!1 var348)
(declare-const var2096!1 var348)
(declare-const var1718!2 var3277)
(assert (not (= var1718!2 null-var3277)))
(assert (= (learningRate/620388015 var1718!2) ((_ to_fp 8 24) #x3f800000))) ; Statement: r0.<edu.stanford.nlp.parser.shiftreduce.PerceptronModel: float learningRate> = 1.0F 
(define-const var1483 var24 var24-init) ; Statement: $r6 = new edu.stanford.nlp.parser.shiftreduce.WeightMap 
(assert true)
;(assert (<init>/-1553701343 var1483)) ; Statement: specialinvoke $r6.<edu.stanford.nlp.parser.shiftreduce.WeightMap: void <init>()>() 

(declare-const var1483!1 var24)
(declare-const var1718!3 var3277)
(assert (not (= var1718!3 null-var3277)))
(assert (= (featureWeights/620388015 var1718!3) var1483!1)) ; Statement: r0.<edu.stanford.nlp.parser.shiftreduce.PerceptronModel: edu.stanford.nlp.parser.shiftreduce.WeightMap featureWeights> = $r6 
(define-const var2810 String (featureFactoryClass/-870760670 var3730!1)) ; Statement: $r7 = r1.<edu.stanford.nlp.parser.shiftreduce.ShiftReduceOptions: java.lang.String featureFactoryClass> 
; split operation: var239 = var2810.split(";") ; Statement: r8 = virtualinvoke $r7.<java.lang.String: java.lang.String[] split(java.lang.String)>(";") 
(define-const var1202 Int (get_split_length var2810 ";" -1)) ; Statement: $i0 = lengthof r8 
 ; Statement: if $i0 != 1 goto $i1 = lengthof r8 
(assert (not (not (= var1202 1)))) ; Negate: Cond: $i0 != 1  
(define-const var3569 String (get_split_element var2810 ";" -1 0)) ; Statement: $r25 = r8[0] 
(define-const var3153 (Array Int var270) arr-var270-init) ; Statement: $r24 = newarray (java.lang.Object)[0] 
(define-const var2914 var270 (var2299_loadByReflection/-126565946 var3569 var3153)) ; Statement: $r26 = staticinvoke <edu.stanford.nlp.util.ReflectionLoading: java.lang.Object loadByReflection(java.lang.String,java.lang.Object[])>($r25, $r24) 
(define-const var3989 var3450 (cast-from-var270-to-var3450 var2914)) ; Statement: $r27 = (edu.stanford.nlp.parser.shiftreduce.FeatureFactory) $r26 
(declare-const var1718!4 var3277)
(assert (not (= var1718!4 null-var3277)))
(assert (= (featureFactory/620388015 var1718!4) var3989)) ; Statement: r0.<edu.stanford.nlp.parser.shiftreduce.PerceptronModel: edu.stanford.nlp.parser.shiftreduce.FeatureFactory featureFactory> = $r27 
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {<init>/-1890226404=([edu.stanford.nlp.parser.shiftreduce.BaseModel, edu.stanford.nlp.parser.shiftreduce.ShiftReduceOptions, edu.stanford.nlp.util.Index, java.util.Set, java.util.Set, java.util.Set], void), cast-from-var3277-to-var3535=([edu.stanford.nlp.parser.shiftreduce.PerceptronModel], edu.stanford.nlp.parser.shiftreduce.BaseModel), learningRate/620388015=([edu.stanford.nlp.parser.shiftreduce.PerceptronModel], float), var24-init=([], edu.stanford.nlp.parser.shiftreduce.WeightMap), <init>/-1553701343=([edu.stanford.nlp.parser.shiftreduce.WeightMap], void), featureWeights/620388015=([edu.stanford.nlp.parser.shiftreduce.PerceptronModel], edu.stanford.nlp.parser.shiftreduce.WeightMap), featureFactoryClass/-870760670=([edu.stanford.nlp.parser.shiftreduce.ShiftReduceOptions], java.lang.String), arr-var270-init=([], java.lang.Object[]), var2299_loadByReflection/-126565946=([java.lang.String, java.lang.Object[]], java.lang.Object), cast-from-var270-to-var3450=([java.lang.Object], edu.stanford.nlp.parser.shiftreduce.FeatureFactory), featureFactory/620388015=([edu.stanford.nlp.parser.shiftreduce.PerceptronModel], edu.stanford.nlp.parser.shiftreduce.FeatureFactory)}
; {var3277=edu.stanford.nlp.parser.shiftreduce.PerceptronModel, var1718=r0, var2765=edu.stanford.nlp.parser.shiftreduce.ShiftReduceOptions, var3730=r1, var1102=edu.stanford.nlp.util.Index, var2441=r2, var348=java.util.Set, var3390=r3, var3182=r4, var2096=r5, var3535=edu.stanford.nlp.parser.shiftreduce.BaseModel, var24=edu.stanford.nlp.parser.shiftreduce.WeightMap, var1483=$r6, var2810=$r7, var239=r8, var1202=$i0, var3569=$r25, var270=java.lang.Object, var3153=$r24, var2299=edu.stanford.nlp.util.ReflectionLoading, var2914=$r26, var3450=edu.stanford.nlp.parser.shiftreduce.FeatureFactory, var3989=$r27}
; {edu.stanford.nlp.parser.shiftreduce.PerceptronModel=var3277, r0=var1718, edu.stanford.nlp.parser.shiftreduce.ShiftReduceOptions=var2765, r1=var3730, edu.stanford.nlp.util.Index=var1102, r2=var2441, java.util.Set=var348, r3=var3390, r4=var3182, r5=var2096, edu.stanford.nlp.parser.shiftreduce.BaseModel=var3535, edu.stanford.nlp.parser.shiftreduce.WeightMap=var24, $r6=var1483, $r7=var2810, r8=var239, $i0=var1202, $r25=var3569, java.lang.Object=var270, $r24=var3153, edu.stanford.nlp.util.ReflectionLoading=var2299, $r26=var2914, edu.stanford.nlp.parser.shiftreduce.FeatureFactory=var3450, $r27=var3989}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: edu.stanford.nlp.parser.shiftreduce.PerceptronModel;	r1 := @parameter0: edu.stanford.nlp.parser.shiftreduce.ShiftReduceOptions;	r2 := @parameter1: edu.stanford.nlp.util.Index;	r3 := @parameter2: java.util.Set;	r4 := @parameter3: java.util.Set;	r5 := @parameter4: java.util.Set;	specialinvoke r0.<edu.stanford.nlp.parser.shiftreduce.BaseModel: void <init>(edu.stanford.nlp.parser.shiftreduce.ShiftReduceOptions,edu.stanford.nlp.util.Index,java.util.Set,java.util.Set,java.util.Set)>(r1, r2, r3, r4, r5);	r0.<edu.stanford.nlp.parser.shiftreduce.PerceptronModel: float learningRate> = 1.0F;	$r6 = new edu.stanford.nlp.parser.shiftreduce.WeightMap;	specialinvoke $r6.<edu.stanford.nlp.parser.shiftreduce.WeightMap: void <init>()>();	r0.<edu.stanford.nlp.parser.shiftreduce.PerceptronModel: edu.stanford.nlp.parser.shiftreduce.WeightMap featureWeights> = $r6;	$r7 = r1.<edu.stanford.nlp.parser.shiftreduce.ShiftReduceOptions: java.lang.String featureFactoryClass>;	r8 = virtualinvoke $r7.<java.lang.String: java.lang.String[] split(java.lang.String)>(";");	$i0 = lengthof r8;	if $i0 != 1 goto $i1 = lengthof r8;	$r25 = r8[0];	$r24 = newarray (java.lang.Object)[0];	$r26 = staticinvoke <edu.stanford.nlp.util.ReflectionLoading: java.lang.Object loadByReflection(java.lang.String,java.lang.Object[])>($r25, $r24);	$r27 = (edu.stanford.nlp.parser.shiftreduce.FeatureFactory) $r26;	r0.<edu.stanford.nlp.parser.shiftreduce.PerceptronModel: edu.stanford.nlp.parser.shiftreduce.FeatureFactory featureFactory> = $r27;	goto [?= return];	return
;block_num 3
(get-model)
