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

(declare-sort var2525 0)
(declare-sort var1951 0)
(declare-sort var1121 0)
(declare-sort var3936 0)
(declare-sort var3077 0)
(declare-sort var902 0)
(declare-sort var1120 0)
(declare-sort var338 0)
(declare-sort var1983 0)
(declare-sort var3293 0)
(declare-sort var350 0)
(declare-sort var1501 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun buildCharacterMapPerAnnotation/-1031716714 (var2525) Bool)
(declare-fun var1121-init () var1121)
(declare-fun <init>/964458484 (var1121) void)
(declare-fun setProperty/703705272 (var1121 String String) var1501)
(declare-fun var3936-init () var3936)
(declare-fun <init>/1273068990 (var3936 var1121 Bool) void)
(declare-fun annotate/-1213120409 (var3936 var1951) void)
(declare-fun characterMap/-1031716714 (var2525) var3077)
(declare-fun var902_setupCoref/-491369574 (String var3077 var1951) var3077)
(declare-fun var1120-init () var1120)
(declare-fun <init>/865666258 (var1120) void)
(declare-fun annotate/-1676560150 (var1120 var1951) void)
(declare-fun parser/-1031716714 (var2525) var338)
(declare-fun var902_addEnhancedSentences/-1856196795 (var1951 var338) void)
(declare-fun var902_annotateForDependencyParse/2124179671 (var1951 var338) void)
(declare-fun getQMMapping/361786175 (var2525 var1951 var3077) var3077)
(declare-fun qmSieveList/-1031716714 (var2525) String)
(declare-fun getMSMapping/592998345 (var2525 var1951 var3077) var3077)
(declare-fun msSieveList/-1031716714 (var2525) String)
(declare-fun var3293_gatherQuotes/-846678570 (var350) var1983)
(declare-fun cast-from-var1951-to-var350 (var1951) var350)
(declare-fun var1983_iterator/-912451715 (var1983) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-const null-var2525 var2525)
(declare-const null-var1951 var1951)
(declare-const var2525-COREF_PATH String)
(declare-const var3733 var2525) ; Statement: r0 := @this: edu.stanford.nlp.pipeline.QuoteAttributionAnnotator 
(assert (not (= var3733 null-var2525)))
(declare-const var1220 var1951) ; Statement: r1 := @parameter0: edu.stanford.nlp.pipeline.Annotation 
(assert (not (= var1220 null-var1951)))
(define-const var360 Bool (buildCharacterMapPerAnnotation/-1031716714 var3733)) ; Statement: $z0 = r0.<edu.stanford.nlp.pipeline.QuoteAttributionAnnotator: boolean buildCharacterMapPerAnnotation> 
 ; Statement: if $z0 == 0 goto $r34 = new java.util.Properties 
(assert (= (ite var360 1 0) 0)) ; Cond: $z0 == 0 
(define-const var136 var1121 var1121-init) ; Statement: $r34 = new java.util.Properties 
(assert true)
;(assert (<init>/964458484 var136)) ; Statement: specialinvoke $r34.<java.util.Properties: void <init>()>() 

(declare-const var136!1 var1121)
(assert true)
;(assert (setProperty/703705272 var136!1 "paragraphBreak" "one")) ; Statement: virtualinvoke $r34.<java.util.Properties: java.lang.Object setProperty(java.lang.String,java.lang.String)>("paragraphBreak", "one") 

(declare-const var136!2 var1121)
(declare-const var1329 String)
(declare-const var1587 String)
(define-const var3317 var3936 var3936-init) ; Statement: $r35 = new edu.stanford.nlp.paragraphs.ParagraphAnnotator 
(assert true)
;(assert (<init>/1273068990 var3317 var136!2 (ite (= 1 0) true false))) ; Statement: specialinvoke $r35.<edu.stanford.nlp.paragraphs.ParagraphAnnotator: void <init>(java.util.Properties,boolean)>($r34, 0) 

(declare-const var3317!1 var3936)
(declare-const var136!3 var1121)
(declare-const var1064 Int)
(assert true)
;(assert (annotate/-1213120409 var3317!1 var1220)) ; Statement: virtualinvoke $r35.<edu.stanford.nlp.paragraphs.ParagraphAnnotator: void annotate(edu.stanford.nlp.pipeline.Annotation)>(r1) 

(declare-const var3317!2 var3936)
(declare-const var1220!1 var1951)
(define-const var751 String var2525-COREF_PATH) ; Statement: $r36 = <edu.stanford.nlp.pipeline.QuoteAttributionAnnotator: java.lang.String COREF_PATH> 
(define-const var3366 var3077 (characterMap/-1031716714 var3733)) ; Statement: $r37 = r0.<edu.stanford.nlp.pipeline.QuoteAttributionAnnotator: java.util.Map characterMap> 
(define-const var1399 var3077 (var902_setupCoref/-491369574 var751 var3366 var1220!1)) ; Statement: $r38 = staticinvoke <edu.stanford.nlp.quoteattribution.QuoteAttributionUtils: java.util.Map setupCoref(java.lang.String,java.util.Map,edu.stanford.nlp.pipeline.Annotation)>($r36, $r37, r1) 
(define-const var3213 var1120 var1120-init) ; Statement: $r39 = new edu.stanford.nlp.quoteattribution.ChapterAnnotator 
(assert true)
;(assert (<init>/865666258 var3213)) ; Statement: specialinvoke $r39.<edu.stanford.nlp.quoteattribution.ChapterAnnotator: void <init>()>() 

(declare-const var3213!1 var1120)
(assert true)
;(assert (annotate/-1676560150 var3213!1 var1220!1)) ; Statement: virtualinvoke $r39.<edu.stanford.nlp.quoteattribution.ChapterAnnotator: void annotate(edu.stanford.nlp.pipeline.Annotation)>(r1) 

(declare-const var3213!2 var1120)
(declare-const var1220!2 var1951)
(define-const var151 var338 (parser/-1031716714 var3733)) ; Statement: $r40 = r0.<edu.stanford.nlp.pipeline.QuoteAttributionAnnotator: edu.stanford.nlp.parser.nndep.DependencyParser parser> 
;(assert (var902_addEnhancedSentences/-1856196795 var1220!2 var151)) ; Statement: staticinvoke <edu.stanford.nlp.quoteattribution.QuoteAttributionUtils: void addEnhancedSentences(edu.stanford.nlp.pipeline.Annotation,edu.stanford.nlp.parser.nndep.DependencyParser)>(r1, $r40) 

(declare-const var1220!3 var1951)
(declare-const var151!1 var338)
(define-const var2852 var338 (parser/-1031716714 var3733)) ; Statement: $r41 = r0.<edu.stanford.nlp.pipeline.QuoteAttributionAnnotator: edu.stanford.nlp.parser.nndep.DependencyParser parser> 
;(assert (var902_annotateForDependencyParse/2124179671 var1220!3 var2852)) ; Statement: staticinvoke <edu.stanford.nlp.quoteattribution.QuoteAttributionUtils: void annotateForDependencyParse(edu.stanford.nlp.pipeline.Annotation,edu.stanford.nlp.parser.nndep.DependencyParser)>(r1, $r41) 

(declare-const var1220!4 var1951)
(declare-const var2852!1 var338)
(assert true)
(define-const var2811 var3077 (getQMMapping/361786175 var3733 var1220!4 var1399)) ; Statement: $r42 = specialinvoke r0.<edu.stanford.nlp.pipeline.QuoteAttributionAnnotator: java.util.Map getQMMapping(edu.stanford.nlp.pipeline.Annotation,java.util.Map)>(r1, $r38) 
(define-const var638 String (qmSieveList/-1031716714 var3733)) ; Statement: $r43 = r0.<edu.stanford.nlp.pipeline.QuoteAttributionAnnotator: java.lang.String qmSieveList> 
; split operation: var3504 = var638.split(",") ; Statement: $r44 = virtualinvoke $r43.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var120 Int (get_split_length var638 "," -1)) ; Statement: $i5 = lengthof $r44 
(define-const var1513 Int 0) ; Statement: i6 = 0 
(assert true) ; Non Conditional
 ; Statement: if i6 >= $i5 goto r46 = specialinvoke r0.<edu.stanford.nlp.pipeline.QuoteAttributionAnnotator: java.util.Map getMSMapping(edu.stanford.nlp.pipeline.Annotation,java.util.Map)>(r1, $r38) 
(assert (>= var1513 var120)) ; Cond: i6 >= $i5 
(assert true)
(define-const var2042 var3077 (getMSMapping/592998345 var3733 var1220!4 var1399)) ; Statement: r46 = specialinvoke r0.<edu.stanford.nlp.pipeline.QuoteAttributionAnnotator: java.util.Map getMSMapping(edu.stanford.nlp.pipeline.Annotation,java.util.Map)>(r1, $r38) 
(define-const var10 String (msSieveList/-1031716714 var3733)) ; Statement: $r2 = r0.<edu.stanford.nlp.pipeline.QuoteAttributionAnnotator: java.lang.String msSieveList> 
; split operation: var11 = var10.split(",") ; Statement: r47 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var2608 Int (get_split_length var10 "," -1)) ; Statement: i7 = lengthof r47 
(define-const var89 Int 0) ; Statement: i8 = 0 
(assert true) ; Non Conditional
 ; Statement: if i8 >= i7 goto $r3 = staticinvoke <edu.stanford.nlp.pipeline.QuoteAnnotator: java.util.List gatherQuotes(edu.stanford.nlp.util.CoreMap)>(r1) 
(assert (>= var89 var2608)) ; Cond: i8 >= i7 
(define-const var1278 var1983 (var3293_gatherQuotes/-846678570 (cast-from-var1951-to-var350 var1220!4))) ; Statement: $r3 = staticinvoke <edu.stanford.nlp.pipeline.QuoteAnnotator: java.util.List gatherQuotes(edu.stanford.nlp.util.CoreMap)>(r1) 
(define-const var1532 Iterator (var1983_iterator/-912451715 var1278)) ; Statement: r49 = interfaceinvoke $r3.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var2062 Bool (Iterator_hasNext/-1669924200 var1532)) ; Statement: $z1 = interfaceinvoke r49.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z1 == 0 goto return 
(assert (= (ite var2062 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return 
(check-sat)
; {buildCharacterMapPerAnnotation/-1031716714=([edu.stanford.nlp.pipeline.QuoteAttributionAnnotator], boolean), var1121-init=([], java.util.Properties), <init>/964458484=([java.util.Properties], void), setProperty/703705272=([java.util.Properties, java.lang.String, java.lang.String], java.lang.Object), var3936-init=([], edu.stanford.nlp.paragraphs.ParagraphAnnotator), <init>/1273068990=([edu.stanford.nlp.paragraphs.ParagraphAnnotator, java.util.Properties, boolean], void), annotate/-1213120409=([edu.stanford.nlp.paragraphs.ParagraphAnnotator, edu.stanford.nlp.pipeline.Annotation], void), characterMap/-1031716714=([edu.stanford.nlp.pipeline.QuoteAttributionAnnotator], java.util.Map), var902_setupCoref/-491369574=([java.lang.String, java.util.Map, edu.stanford.nlp.pipeline.Annotation], java.util.Map), var1120-init=([], edu.stanford.nlp.quoteattribution.ChapterAnnotator), <init>/865666258=([edu.stanford.nlp.quoteattribution.ChapterAnnotator], void), annotate/-1676560150=([edu.stanford.nlp.quoteattribution.ChapterAnnotator, edu.stanford.nlp.pipeline.Annotation], void), parser/-1031716714=([edu.stanford.nlp.pipeline.QuoteAttributionAnnotator], edu.stanford.nlp.parser.nndep.DependencyParser), var902_addEnhancedSentences/-1856196795=([edu.stanford.nlp.pipeline.Annotation, edu.stanford.nlp.parser.nndep.DependencyParser], void), var902_annotateForDependencyParse/2124179671=([edu.stanford.nlp.pipeline.Annotation, edu.stanford.nlp.parser.nndep.DependencyParser], void), getQMMapping/361786175=([edu.stanford.nlp.pipeline.QuoteAttributionAnnotator, edu.stanford.nlp.pipeline.Annotation, java.util.Map], java.util.Map), qmSieveList/-1031716714=([edu.stanford.nlp.pipeline.QuoteAttributionAnnotator], java.lang.String), getMSMapping/592998345=([edu.stanford.nlp.pipeline.QuoteAttributionAnnotator, edu.stanford.nlp.pipeline.Annotation, java.util.Map], java.util.Map), msSieveList/-1031716714=([edu.stanford.nlp.pipeline.QuoteAttributionAnnotator], java.lang.String), var3293_gatherQuotes/-846678570=([edu.stanford.nlp.util.CoreMap], java.util.List), cast-from-var1951-to-var350=([edu.stanford.nlp.pipeline.Annotation], edu.stanford.nlp.util.CoreMap), var1983_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean)}
; {var2525=edu.stanford.nlp.pipeline.QuoteAttributionAnnotator, var3733=r0, var1951=edu.stanford.nlp.pipeline.Annotation, var1220=r1, var360=$z0, var1121=java.util.Properties, var136=$r34, var1329="paragraphBreak", var1587="one", var3936=edu.stanford.nlp.paragraphs.ParagraphAnnotator, var3317=$r35, var1064=0, var751=$r36, var3077=java.util.Map, var3366=$r37, var902=edu.stanford.nlp.quoteattribution.QuoteAttributionUtils, var1399=$r38, var1120=edu.stanford.nlp.quoteattribution.ChapterAnnotator, var3213=$r39, var338=edu.stanford.nlp.parser.nndep.DependencyParser, var151=$r40, var2852=$r41, var2811=$r42, var638=$r43, var3504=$r44, var120=$i5, var1513=i6, var2042=r46, var10=$r2, var11=r47, var2608=i7, var89=i8, var1983=java.util.List, var3293=edu.stanford.nlp.pipeline.QuoteAnnotator, var350=edu.stanford.nlp.util.CoreMap, var1278=$r3, var1532=r49, var2062=$z1, var1501=java.lang.Object}
; {edu.stanford.nlp.pipeline.QuoteAttributionAnnotator=var2525, r0=var3733, edu.stanford.nlp.pipeline.Annotation=var1951, r1=var1220, $z0=var360, java.util.Properties=var1121, $r34=var136, "paragraphBreak"=var1329, "one"=var1587, edu.stanford.nlp.paragraphs.ParagraphAnnotator=var3936, $r35=var3317, 0=var1064, $r36=var751, java.util.Map=var3077, $r37=var3366, edu.stanford.nlp.quoteattribution.QuoteAttributionUtils=var902, $r38=var1399, edu.stanford.nlp.quoteattribution.ChapterAnnotator=var1120, $r39=var3213, edu.stanford.nlp.parser.nndep.DependencyParser=var338, $r40=var151, $r41=var2852, $r42=var2811, $r43=var638, $r44=var3504, $i5=var120, i6=var1513, r46=var2042, $r2=var10, r47=var11, i7=var2608, i8=var89, java.util.List=var1983, edu.stanford.nlp.pipeline.QuoteAnnotator=var3293, edu.stanford.nlp.util.CoreMap=var350, $r3=var1278, r49=var1532, $z1=var2062, java.lang.Object=var1501}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r0 := @this: edu.stanford.nlp.pipeline.QuoteAttributionAnnotator;	r1 := @parameter0: edu.stanford.nlp.pipeline.Annotation;	$z0 = r0.<edu.stanford.nlp.pipeline.QuoteAttributionAnnotator: boolean buildCharacterMapPerAnnotation>;	if $z0 == 0 goto $r34 = new java.util.Properties;	$r34 = new java.util.Properties;	specialinvoke $r34.<java.util.Properties: void <init>()>();	virtualinvoke $r34.<java.util.Properties: java.lang.Object setProperty(java.lang.String,java.lang.String)>("paragraphBreak", "one");	$r35 = new edu.stanford.nlp.paragraphs.ParagraphAnnotator;	specialinvoke $r35.<edu.stanford.nlp.paragraphs.ParagraphAnnotator: void <init>(java.util.Properties,boolean)>($r34, 0);	virtualinvoke $r35.<edu.stanford.nlp.paragraphs.ParagraphAnnotator: void annotate(edu.stanford.nlp.pipeline.Annotation)>(r1);	$r36 = <edu.stanford.nlp.pipeline.QuoteAttributionAnnotator: java.lang.String COREF_PATH>;	$r37 = r0.<edu.stanford.nlp.pipeline.QuoteAttributionAnnotator: java.util.Map characterMap>;	$r38 = staticinvoke <edu.stanford.nlp.quoteattribution.QuoteAttributionUtils: java.util.Map setupCoref(java.lang.String,java.util.Map,edu.stanford.nlp.pipeline.Annotation)>($r36, $r37, r1);	$r39 = new edu.stanford.nlp.quoteattribution.ChapterAnnotator;	specialinvoke $r39.<edu.stanford.nlp.quoteattribution.ChapterAnnotator: void <init>()>();	virtualinvoke $r39.<edu.stanford.nlp.quoteattribution.ChapterAnnotator: void annotate(edu.stanford.nlp.pipeline.Annotation)>(r1);	$r40 = r0.<edu.stanford.nlp.pipeline.QuoteAttributionAnnotator: edu.stanford.nlp.parser.nndep.DependencyParser parser>;	staticinvoke <edu.stanford.nlp.quoteattribution.QuoteAttributionUtils: void addEnhancedSentences(edu.stanford.nlp.pipeline.Annotation,edu.stanford.nlp.parser.nndep.DependencyParser)>(r1, $r40);	$r41 = r0.<edu.stanford.nlp.pipeline.QuoteAttributionAnnotator: edu.stanford.nlp.parser.nndep.DependencyParser parser>;	staticinvoke <edu.stanford.nlp.quoteattribution.QuoteAttributionUtils: void annotateForDependencyParse(edu.stanford.nlp.pipeline.Annotation,edu.stanford.nlp.parser.nndep.DependencyParser)>(r1, $r41);	$r42 = specialinvoke r0.<edu.stanford.nlp.pipeline.QuoteAttributionAnnotator: java.util.Map getQMMapping(edu.stanford.nlp.pipeline.Annotation,java.util.Map)>(r1, $r38);	$r43 = r0.<edu.stanford.nlp.pipeline.QuoteAttributionAnnotator: java.lang.String qmSieveList>;	$r44 = virtualinvoke $r43.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	$i5 = lengthof $r44;	i6 = 0;	if i6 >= $i5 goto r46 = specialinvoke r0.<edu.stanford.nlp.pipeline.QuoteAttributionAnnotator: java.util.Map getMSMapping(edu.stanford.nlp.pipeline.Annotation,java.util.Map)>(r1, $r38);	r46 = specialinvoke r0.<edu.stanford.nlp.pipeline.QuoteAttributionAnnotator: java.util.Map getMSMapping(edu.stanford.nlp.pipeline.Annotation,java.util.Map)>(r1, $r38);	$r2 = r0.<edu.stanford.nlp.pipeline.QuoteAttributionAnnotator: java.lang.String msSieveList>;	r47 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	i7 = lengthof r47;	i8 = 0;	if i8 >= i7 goto $r3 = staticinvoke <edu.stanford.nlp.pipeline.QuoteAnnotator: java.util.List gatherQuotes(edu.stanford.nlp.util.CoreMap)>(r1);	$r3 = staticinvoke <edu.stanford.nlp.pipeline.QuoteAnnotator: java.util.List gatherQuotes(edu.stanford.nlp.util.CoreMap)>(r1);	r49 = interfaceinvoke $r3.<java.util.List: java.util.Iterator iterator()>();	$z1 = interfaceinvoke r49.<java.util.Iterator: boolean hasNext()>();	if $z1 == 0 goto return;	return
;block_num 8
(get-model)
