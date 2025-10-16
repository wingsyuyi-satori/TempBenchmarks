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

(declare-sort var1877 0)
(declare-sort var1321 0)
(declare-sort var527 0)
(declare-sort var3561 0)
(declare-sort var996 0)
(declare-sort var900 0)
(declare-sort var3296 0)
(declare-sort var1295 0)
(declare-sort var363 0)
(declare-sort var1901 0)
(declare-sort var3082 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-String-init () (Array Int String))
(declare-fun var527_arraycopy/-325913181 (var3561 Int var3561 Int Int) void)
(declare-fun cast-from-__Array__Int__String__-to-var3561 ((Array Int String)) var3561)
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-fun var900_getEncoding/-422666462 (var1877) String)
(declare-fun var900_getTagSeparator/-1758988662 (var1877) String)
(declare-fun var900-init () var900)
(declare-fun <init>/921971027 (var900 String var996 String String var3296 var1295 var363 var1901 var3082 Int Int Bool) void)
(declare-const null-var1877 var1877)
(declare-const null-String String)
(declare-const var996-TEXT var996)
(declare-const null-var3296 var3296)
(declare-const null-var1295 var1295)
(declare-const null-var363 var363)
(declare-const null-var1901 var1901)
(declare-const null-var3082 var3082)
(declare-const null-Int Int)
(declare-const var2055 var1877) ; Statement: r4 := @parameter0: java.util.Properties 
(assert (not (= var2055 null-var1877)))
(declare-const var3045 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var3045 null-String)))
; split operation: var2247 = var3045.split(",") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var1234 Int (get_split_length var3045 "," -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 != 1 goto $i1 = lengthof r1 
(assert (not (= var1234 1))) ; Cond: $i0 != 1 
(define-const var2799 Int (get_split_length var3045 "," -1)) ; Statement: $i1 = lengthof r1 
(define-const var2063 Int (- var2799 1)) ; Statement: $i2 = $i1 - 1 
(define-const var1116 (Array Int String) arr-String-init) ; Statement: r2 = newarray (java.lang.String)[$i2] 
(define-const var283 Int (get_split_length var3045 "," -1)) ; Statement: $i3 = lengthof r1 
(define-const var720 Int (- var283 1)) ; Statement: $i4 = $i3 - 1 
;(assert (var527_arraycopy/-325913181 (cast-from-__Array__Int__String__-to-var3561 var2247) 0 (cast-from-__Array__Int__String__-to-var3561 var1116) 0 var720)) ; Statement: staticinvoke <java.lang.System: void arraycopy(java.lang.Object,int,java.lang.Object,int,int)>(r1, 0, r2, 0, $i4) 

(declare-const var2247!1 (Array Int String))
(declare-const var1091 Int)
(declare-const var1116!1 (Array Int String))
(declare-const var1091!1 Int)
(declare-const var720!1 Int)
(define-const var2014 Int (getLength-Arr-String-1 var2247!1)) ; Statement: $i5 = lengthof r1 
(define-const var3723 Int (- var2014 1)) ; Statement: $i6 = $i5 - 1 
(define-const var2242 String (select var2247!1 var3723)) ; Statement: r3 = r1[$i6] 
(define-const var3442 var996 var996-TEXT) ; Statement: r56 = <edu.stanford.nlp.tagger.io.TaggedFileRecord$Format: edu.stanford.nlp.tagger.io.TaggedFileRecord$Format TEXT> 
(define-const var2745 String (var900_getEncoding/-422666462 var2055)) ; Statement: r57 = staticinvoke <edu.stanford.nlp.tagger.io.TaggedFileRecord: java.lang.String getEncoding(java.util.Properties)>(r4) 
(define-const var2489 String (var900_getTagSeparator/-1758988662 var2055)) ; Statement: r58 = staticinvoke <edu.stanford.nlp.tagger.io.TaggedFileRecord: java.lang.String getTagSeparator(java.util.Properties)>(r4) 
(define-const var993 var3296 null-var3296) ; Statement: r59 = null 
(define-const var3090 var1295 null-var1295) ; Statement: r60 = null 
(define-const var1571 var363 null-var363) ; Statement: r61 = null 
(define-const var1075 var1901 null-var1901) ; Statement: r62 = null 
(define-const var209 var3082 null-var3082) ; Statement: r63 = null 
(define-const var1060 Int null-Int) ; Statement: r64 = null 
(define-const var3474 Int null-Int) ; Statement: r65 = null 
(define-const var1919 Bool (ite (= 1 0) true false)) ; Statement: z11 = 0 
(define-const var2524 Int (getLength-Arr-String-1 var1116!1)) ; Statement: i7 = lengthof r2 
(define-const var2495 Int 0) ; Statement: i9 = 0 
(assert true) ; Non Conditional
 ; Statement: if i9 >= i7 goto $r5 = new edu.stanford.nlp.tagger.io.TaggedFileRecord 
(assert (>= var2495 var2524)) ; Cond: i9 >= i7 
(define-const var2653 var900 var900-init) ; Statement: $r5 = new edu.stanford.nlp.tagger.io.TaggedFileRecord 
(assert true)
;(assert (<init>/921971027 var2653 var2242 var3442 var2745 var2489 var993 var3090 var1571 var1075 var209 var1060 var3474 var1919)) ; Statement: specialinvoke $r5.<edu.stanford.nlp.tagger.io.TaggedFileRecord: void <init>(java.lang.String,edu.stanford.nlp.tagger.io.TaggedFileRecord$Format,java.lang.String,java.lang.String,edu.stanford.nlp.trees.TreeTransformer,edu.stanford.nlp.trees.TreeNormalizer,edu.stanford.nlp.trees.TreeReaderFactory,edu.stanford.nlp.io.NumberRangesFileFilter,java.util.function.Predicate,java.lang.Integer,java.lang.Integer,boolean)>(r3, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, z11) 

(declare-const var2653!1 var900)
(declare-const var2242!1 String)
(declare-const var3442!1 var996)
(declare-const var2745!1 String)
(declare-const var2489!1 String)
(declare-const var993!1 var3296)
(declare-const var3090!1 var1295)
(declare-const var1571!1 var363)
(declare-const var1075!1 var1901)
(declare-const var209!1 var3082)
(declare-const var1060!1 Int)
(declare-const var3474!1 Int)
(declare-const var1919!1 Bool)
 ; Statement: return $r5 
(check-sat)
; {arr-String-init=([], java.lang.String[]), var527_arraycopy/-325913181=([java.lang.Object, int, java.lang.Object, int, int], void), cast-from-__Array__Int__String__-to-var3561=([java.lang.String[]], java.lang.Object), getLength-Arr-String-1=([java.lang.String[]], int), var900_getEncoding/-422666462=([java.util.Properties], java.lang.String), var900_getTagSeparator/-1758988662=([java.util.Properties], java.lang.String), var900-init=([], edu.stanford.nlp.tagger.io.TaggedFileRecord), <init>/921971027=([edu.stanford.nlp.tagger.io.TaggedFileRecord, java.lang.String, edu.stanford.nlp.tagger.io.TaggedFileRecord$Format, java.lang.String, java.lang.String, edu.stanford.nlp.trees.TreeTransformer, edu.stanford.nlp.trees.TreeNormalizer, edu.stanford.nlp.trees.TreeReaderFactory, edu.stanford.nlp.io.NumberRangesFileFilter, java.util.function.Predicate, java.lang.Integer, java.lang.Integer, boolean], void)}
; {var1877=java.util.Properties, var2055=r4, var3045=r0, var1321=null_type, var2247=r1, var1234=$i0, var2799=$i1, var2063=$i2, var1116=r2, var283=$i3, var720=$i4, var527=java.lang.System, var3561=java.lang.Object, var1091=0, var2014=$i5, var3723=$i6, var2242=r3, var996=edu.stanford.nlp.tagger.io.TaggedFileRecord$Format, var3442=r56, var900=edu.stanford.nlp.tagger.io.TaggedFileRecord, var2745=r57, var2489=r58, var3296=edu.stanford.nlp.trees.TreeTransformer, var993=r59, var1295=edu.stanford.nlp.trees.TreeNormalizer, var3090=r60, var363=edu.stanford.nlp.trees.TreeReaderFactory, var1571=r61, var1901=edu.stanford.nlp.io.NumberRangesFileFilter, var1075=r62, var3082=java.util.function.Predicate, var209=r63, var1060=r64, var3474=r65, var1919=z11, var2524=i7, var2495=i9, var2653=$r5}
; {java.util.Properties=var1877, r4=var2055, r0=var3045, null_type=var1321, r1=var2247, $i0=var1234, $i1=var2799, $i2=var2063, r2=var1116, $i3=var283, $i4=var720, java.lang.System=var527, java.lang.Object=var3561, 0=var1091, $i5=var2014, $i6=var3723, r3=var2242, edu.stanford.nlp.tagger.io.TaggedFileRecord$Format=var996, r56=var3442, edu.stanford.nlp.tagger.io.TaggedFileRecord=var900, r57=var2745, r58=var2489, edu.stanford.nlp.trees.TreeTransformer=var3296, r59=var993, edu.stanford.nlp.trees.TreeNormalizer=var1295, r60=var3090, edu.stanford.nlp.trees.TreeReaderFactory=var363, r61=var1571, edu.stanford.nlp.io.NumberRangesFileFilter=var1901, r62=var1075, java.util.function.Predicate=var3082, r63=var209, r64=var1060, r65=var3474, z11=var1919, i7=var2524, i9=var2495, $r5=var2653}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r4 := @parameter0: java.util.Properties;	r0 := @parameter1: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$i0 = lengthof r1;	if $i0 != 1 goto $i1 = lengthof r1;	$i1 = lengthof r1;	$i2 = $i1 - 1;	r2 = newarray (java.lang.String)[$i2];	$i3 = lengthof r1;	$i4 = $i3 - 1;	staticinvoke <java.lang.System: void arraycopy(java.lang.Object,int,java.lang.Object,int,int)>(r1, 0, r2, 0, $i4);	$i5 = lengthof r1;	$i6 = $i5 - 1;	r3 = r1[$i6];	r56 = <edu.stanford.nlp.tagger.io.TaggedFileRecord$Format: edu.stanford.nlp.tagger.io.TaggedFileRecord$Format TEXT>;	r57 = staticinvoke <edu.stanford.nlp.tagger.io.TaggedFileRecord: java.lang.String getEncoding(java.util.Properties)>(r4);	r58 = staticinvoke <edu.stanford.nlp.tagger.io.TaggedFileRecord: java.lang.String getTagSeparator(java.util.Properties)>(r4);	r59 = null;	r60 = null;	r61 = null;	r62 = null;	r63 = null;	r64 = null;	r65 = null;	z11 = 0;	i7 = lengthof r2;	i9 = 0;	if i9 >= i7 goto $r5 = new edu.stanford.nlp.tagger.io.TaggedFileRecord;	$r5 = new edu.stanford.nlp.tagger.io.TaggedFileRecord;	specialinvoke $r5.<edu.stanford.nlp.tagger.io.TaggedFileRecord: void <init>(java.lang.String,edu.stanford.nlp.tagger.io.TaggedFileRecord$Format,java.lang.String,java.lang.String,edu.stanford.nlp.trees.TreeTransformer,edu.stanford.nlp.trees.TreeNormalizer,edu.stanford.nlp.trees.TreeReaderFactory,edu.stanford.nlp.io.NumberRangesFileFilter,java.util.function.Predicate,java.lang.Integer,java.lang.Integer,boolean)>(r3, r56, r57, r58, r59, r60, r61, r62, r63, r64, r65, z11);	return $r5
;block_num 4
(get-model)
