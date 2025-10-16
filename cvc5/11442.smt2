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

(declare-sort var1577 0)
(declare-sort var314 0)
(declare-sort var2691 0)
(declare-sort var1708 0)
(declare-sort var150 0)
(declare-sort var285 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun this$0/-508771627 (var1577) var2691)
(declare-fun var2691_access$000/1195809519 (var2691) Bool)
(declare-fun var2691_access$200/3554864 (var2691) String)
(declare-fun var2691_access$300/-390947598 (var2691) Bool)
(declare-fun var1708-init () var1708)
(declare-fun <init>/1228603609 (var1708 Int) void)
(declare-fun var150_quote/811834350 (String) String)
(declare-fun var285-init () var285)
(declare-fun <init>/-208190597 (var285) void)
(declare-const null-var1577 var1577)
(declare-const null-String String)
(declare-const var1577-$assertionsDisabled Bool)
(declare-const var843 var1577) ; Statement: r0 := @this: edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter$1 
(assert (not (= var843 null-var1577)))
(declare-const var2994 String) ; Statement: r84 := @parameter0: java.lang.String 
(assert (not (= var2994 null-String)))
(define-const var2077 String "") ; Statement: r85 = "" 
(define-const var3777 var2691 (this$0/-508771627 var843)) ; Statement: $r1 = r0.<edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter$1: edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter this$0> 
(define-const var1221 Bool (var2691_access$000/1195809519 var3777)) ; Statement: $z0 = staticinvoke <edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter: boolean access$000(edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter)>($r1) 
 ; Statement: if $z0 == 0 goto $r2 = r0.<edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter$1: edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter this$0> 
(assert (= (ite var1221 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3205 var2691 (this$0/-508771627 var843)) ; Statement: $r2 = r0.<edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter$1: edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter this$0> 
(define-const var2077!1 String (var2691_access$200/3554864 var3205)) ; Statement: r85 = staticinvoke <edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter: java.lang.String access$200(edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter)>($r2) 
(assert true) ; Non Conditional
(define-const var757 var2691 (this$0/-508771627 var843)) ; Statement: $r3 = r0.<edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter$1: edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter this$0> 
(define-const var1233 Bool (var2691_access$300/-390947598 var757)) ; Statement: $z1 = staticinvoke <edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter: boolean access$300(edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter)>($r3) 
 ; Statement: if $z1 == 0 goto $r4 = r0.<edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter$1: edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter this$0> 
(assert (not (= (ite var1233 1 0) 0))) ; Negate: Cond: $z1 == 0  
; split operation: var1014 = var2994.split("\u005cs+") ; Statement: r87 = virtualinvoke r84.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var2082 var1708 var1708-init) ; Statement: $r18 = new java.util.ArrayList 
(define-const var740 Int (get_split_length var2994 "\u005cs+" -1)) ; Statement: $i0 = lengthof r87 
(assert true)
;(assert (<init>/1228603609 var2082 var740)) ; Statement: specialinvoke $r18.<java.util.ArrayList: void <init>(int)>($i0) 

(declare-const var2082!1 var1708)
(declare-const var740!1 Int)
(define-const var2100 String (var150_quote/811834350 "|||")) ; Statement: r19 = staticinvoke <java.util.regex.Pattern: java.lang.String quote(java.lang.String)>("|||") 
(define-const var2801 String (var150_quote/811834350 ">>>")) ; Statement: r20 = staticinvoke <java.util.regex.Pattern: java.lang.String quote(java.lang.String)>(">>>") 
(define-const var3458 Int (get_split_length var2994 "\u005cs+" -1)) ; Statement: i1 = lengthof r87 
(define-const var2522 Int 0) ; Statement: i10 = 0 
(assert true) ; Non Conditional
 ; Statement: if i10 >= i1 goto $r21 = r0.<edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter$1: edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter this$0> 
(assert (not (>= var2522 var3458))) ; Negate: Cond: i10 >= i1  
(define-const var537 String (get_split_element var2994 "\u005cs+" -1 var2522)) ; Statement: r24 = r87[i10] 
; split operation: var185 = var537.split(var2100) ; Statement: r25 = virtualinvoke r24.<java.lang.String: java.lang.String[] split(java.lang.String)>(r19) 
(define-const var1867 Bool var1577-$assertionsDisabled) ; Statement: $z5 = <edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter$1: boolean $assertionsDisabled> 
 ; Statement: if $z5 != 0 goto $r26 = r25[0] 
(assert (not (not (= (ite var1867 1 0) 0)))) ; Negate: Cond: $z5 != 0  
(define-const var1164 Int (get_split_length var537 var2100 -1)) ; Statement: $i8 = lengthof r25 
 ; Statement: if $i8 == 2 goto $r26 = r25[0] 
(assert (not (= var1164 2))) ; Negate: Cond: $i8 == 2  
(define-const var569 var285 var285-init) ; Statement: $r79 = new java.lang.AssertionError 
(assert true)
;(assert (<init>/-208190597 var569)) ; Statement: specialinvoke $r79.<java.lang.AssertionError: void <init>()>() 

(declare-const var569!1 var285)
 ; Statement: throw $r79 
(check-sat)
; {this$0/-508771627=([edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter$1], edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter), var2691_access$000/1195809519=([edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter], boolean), var2691_access$200/3554864=([edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter], java.lang.String), var2691_access$300/-390947598=([edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter], boolean), var1708-init=([], java.util.ArrayList), <init>/1228603609=([java.util.ArrayList, int], void), var150_quote/811834350=([java.lang.String], java.lang.String), var285-init=([], java.lang.AssertionError), <init>/-208190597=([java.lang.AssertionError], void)}
; {var1577=edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter$1, var843=r0, var2994=r84, var314=null_type, var2077=r85, var2691=edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter, var3777=$r1, var1221=$z0, var3205=$r2, var757=$r3, var1233=$z1, var1014=r87, var1708=java.util.ArrayList, var2082=$r18, var740=$i0, var150=java.util.regex.Pattern, var2100=r19, var2801=r20, var3458=i1, var2522=i10, var537=r24, var185=r25, var1867=$z5, var1164=$i8, var285=java.lang.AssertionError, var569=$r79}
; {edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter$1=var1577, r0=var843, r84=var2994, null_type=var314, r85=var2077, edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter=var2691, $r1=var3777, $z0=var1221, $r2=var3205, $r3=var757, $z1=var1233, r87=var1014, java.util.ArrayList=var1708, $r18=var2082, $i0=var740, java.util.regex.Pattern=var150, r19=var2100, r20=var2801, i1=var3458, i10=var2522, r24=var537, r25=var185, $z5=var1867, $i8=var1164, java.lang.AssertionError=var285, $r79=var569}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r0 := @this: edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter$1;	r84 := @parameter0: java.lang.String;	r85 = "";	$r1 = r0.<edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter$1: edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter this$0>;	$z0 = staticinvoke <edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter: boolean access$000(edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter)>($r1);	if $z0 == 0 goto $r2 = r0.<edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter$1: edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter this$0>;	$r2 = r0.<edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter$1: edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter this$0>;	r85 = staticinvoke <edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter: java.lang.String access$200(edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter)>($r2);	$r3 = r0.<edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter$1: edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter this$0>;	$z1 = staticinvoke <edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter: boolean access$300(edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter)>($r3);	if $z1 == 0 goto $r4 = r0.<edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter$1: edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter this$0>;	r87 = virtualinvoke r84.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r18 = new java.util.ArrayList;	$i0 = lengthof r87;	specialinvoke $r18.<java.util.ArrayList: void <init>(int)>($i0);	r19 = staticinvoke <java.util.regex.Pattern: java.lang.String quote(java.lang.String)>("|||");	r20 = staticinvoke <java.util.regex.Pattern: java.lang.String quote(java.lang.String)>(">>>");	i1 = lengthof r87;	i10 = 0;	if i10 >= i1 goto $r21 = r0.<edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter$1: edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter this$0>;	r24 = r87[i10];	r25 = virtualinvoke r24.<java.lang.String: java.lang.String[] split(java.lang.String)>(r19);	$z5 = <edu.stanford.nlp.international.arabic.process.ArabicDocumentReaderAndWriter$1: boolean $assertionsDisabled>;	if $z5 != 0 goto $r26 = r25[0];	$i8 = lengthof r25;	if $i8 == 2 goto $r26 = r25[0];	$r79 = new java.lang.AssertionError;	specialinvoke $r79.<java.lang.AssertionError: void <init>()>();	throw $r79
;block_num 8
(get-model)
