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

(declare-sort var2290 0)
(declare-sort var3589 0)
(declare-sort var306 0)
(declare-sort var187 0)
(declare-sort var3956 0)
(declare-sort var3093 0)
(declare-sort var1915 0)
(declare-sort var2475 0)
(declare-sort var3867 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var306-init () var306)
(declare-fun var306_getEncoding/-422666462 (var2290) String)
(declare-fun var306_getTagSeparator/-1758988662 (var2290) String)
(declare-fun <init>/921971027 (var306 String var187 String String var3956 var3093 var1915 var2475 var3867 Int Int Bool) void)
(declare-const null-var2290 var2290)
(declare-const null-String String)
(declare-const var187-TEXT var187)
(declare-const null-NullType var3589)
(declare-const null-var3956 var3956)
(declare-const null-var3093 var3093)
(declare-const null-var1915 var1915)
(declare-const null-var2475 var2475)
(declare-const null-var3867 var3867)
(declare-const null-Int Int)
(declare-const var818 var2290) ; Statement: r4 := @parameter0: java.util.Properties 
(assert (not (= var818 null-var2290)))
(declare-const var2305 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var2305 null-String)))
; split operation: var1847 = var2305.split(",") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var2388 Int (get_split_length var2305 "," -1)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 != 1 goto $i1 = lengthof r1 
(assert (not (not (= var2388 1)))) ; Negate: Cond: $i0 != 1  
(define-const var3431 var306 var306-init) ; Statement: $r52 = new edu.stanford.nlp.tagger.io.TaggedFileRecord 
(define-const var1240 var187 var187-TEXT) ; Statement: $r53 = <edu.stanford.nlp.tagger.io.TaggedFileRecord$Format: edu.stanford.nlp.tagger.io.TaggedFileRecord$Format TEXT> 
(define-const var923 String (var306_getEncoding/-422666462 var818)) ; Statement: $r55 = staticinvoke <edu.stanford.nlp.tagger.io.TaggedFileRecord: java.lang.String getEncoding(java.util.Properties)>(r4) 
(define-const var1884 String (var306_getTagSeparator/-1758988662 var818)) ; Statement: $r54 = staticinvoke <edu.stanford.nlp.tagger.io.TaggedFileRecord: java.lang.String getTagSeparator(java.util.Properties)>(r4) 
(assert true)
;(assert (<init>/921971027 var3431 var2305 var1240 var923 var1884 null-var3956 null-var3093 null-var1915 null-var2475 null-var3867 null-Int null-Int (ite (= 1 0) true false))) ; Statement: specialinvoke $r52.<edu.stanford.nlp.tagger.io.TaggedFileRecord: void <init>(java.lang.String,edu.stanford.nlp.tagger.io.TaggedFileRecord$Format,java.lang.String,java.lang.String,edu.stanford.nlp.trees.TreeTransformer,edu.stanford.nlp.trees.TreeNormalizer,edu.stanford.nlp.trees.TreeReaderFactory,edu.stanford.nlp.io.NumberRangesFileFilter,java.util.function.Predicate,java.lang.Integer,java.lang.Integer,boolean)>(r0, $r53, $r55, $r54, null, null, null, null, null, null, null, 0) 

(declare-const var3431!1 var306)
(declare-const var2305!1 String)
(declare-const var1240!1 var187)
(declare-const var923!1 String)
(declare-const var1884!1 String)
(declare-const var1142 var3589)
(declare-const var1142!1 var3589)
(declare-const var1142!2 var3589)
(declare-const var1142!3 var3589)
(declare-const var1142!4 var3589)
(declare-const var1142!5 var3589)
(declare-const var1142!6 var3589)
(declare-const var2652 Int)
 ; Statement: return $r52 
(check-sat)
; {var306-init=([], edu.stanford.nlp.tagger.io.TaggedFileRecord), var306_getEncoding/-422666462=([java.util.Properties], java.lang.String), var306_getTagSeparator/-1758988662=([java.util.Properties], java.lang.String), <init>/921971027=([edu.stanford.nlp.tagger.io.TaggedFileRecord, java.lang.String, edu.stanford.nlp.tagger.io.TaggedFileRecord$Format, java.lang.String, java.lang.String, edu.stanford.nlp.trees.TreeTransformer, edu.stanford.nlp.trees.TreeNormalizer, edu.stanford.nlp.trees.TreeReaderFactory, edu.stanford.nlp.io.NumberRangesFileFilter, java.util.function.Predicate, java.lang.Integer, java.lang.Integer, boolean], void)}
; {var2290=java.util.Properties, var818=r4, var2305=r0, var3589=null_type, var1847=r1, var2388=$i0, var306=edu.stanford.nlp.tagger.io.TaggedFileRecord, var3431=$r52, var187=edu.stanford.nlp.tagger.io.TaggedFileRecord$Format, var1240=$r53, var923=$r55, var1884=$r54, var3956=edu.stanford.nlp.trees.TreeTransformer, var3093=edu.stanford.nlp.trees.TreeNormalizer, var1915=edu.stanford.nlp.trees.TreeReaderFactory, var2475=edu.stanford.nlp.io.NumberRangesFileFilter, var3867=java.util.function.Predicate, var1142=null, var2652=0}
; {java.util.Properties=var2290, r4=var818, r0=var2305, null_type=var3589, r1=var1847, $i0=var2388, edu.stanford.nlp.tagger.io.TaggedFileRecord=var306, $r52=var3431, edu.stanford.nlp.tagger.io.TaggedFileRecord$Format=var187, $r53=var1240, $r55=var923, $r54=var1884, edu.stanford.nlp.trees.TreeTransformer=var3956, edu.stanford.nlp.trees.TreeNormalizer=var3093, edu.stanford.nlp.trees.TreeReaderFactory=var1915, edu.stanford.nlp.io.NumberRangesFileFilter=var2475, java.util.function.Predicate=var3867, null=var1142, 0=var2652}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r4 := @parameter0: java.util.Properties;	r0 := @parameter1: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$i0 = lengthof r1;	if $i0 != 1 goto $i1 = lengthof r1;	$r52 = new edu.stanford.nlp.tagger.io.TaggedFileRecord;	$r53 = <edu.stanford.nlp.tagger.io.TaggedFileRecord$Format: edu.stanford.nlp.tagger.io.TaggedFileRecord$Format TEXT>;	$r55 = staticinvoke <edu.stanford.nlp.tagger.io.TaggedFileRecord: java.lang.String getEncoding(java.util.Properties)>(r4);	$r54 = staticinvoke <edu.stanford.nlp.tagger.io.TaggedFileRecord: java.lang.String getTagSeparator(java.util.Properties)>(r4);	specialinvoke $r52.<edu.stanford.nlp.tagger.io.TaggedFileRecord: void <init>(java.lang.String,edu.stanford.nlp.tagger.io.TaggedFileRecord$Format,java.lang.String,java.lang.String,edu.stanford.nlp.trees.TreeTransformer,edu.stanford.nlp.trees.TreeNormalizer,edu.stanford.nlp.trees.TreeReaderFactory,edu.stanford.nlp.io.NumberRangesFileFilter,java.util.function.Predicate,java.lang.Integer,java.lang.Integer,boolean)>(r0, $r53, $r55, $r54, null, null, null, null, null, null, null, 0);	return $r52
;block_num 2
(get-model)
