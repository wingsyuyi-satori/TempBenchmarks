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

(declare-sort var1240 0)
(declare-sort var298 0)
(declare-sort var436 0)
(declare-sort var2772 0)
(declare-sort var1479 0)
(declare-sort var2585 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var436) void)
(declare-fun cast-from-var1240-to-var436 (var1240) var436)
(declare-fun var2772-init () var2772)
(declare-fun <init>/613807010 (var2772 Int) void)
(declare-fun corefPairs/74865948 (var1240) var2772)
(declare-fun var1479-init () var1479)
(declare-fun <init>/1228603609 (var1479 Int) void)
(declare-fun cast-from-var1479-to-var2585 (var1479) var2585)
(declare-fun tokens/74865948 (var1240) var2585)
(declare-fun pronouns/74865948 (var1240) var2585)
(declare-const null-var1240 var1240)
(declare-const null-String String)
(declare-const var937 var1240) ; Statement: r0 := @this: edu.stanford.nlp.scenegraph.AbstractPronounResolver$TestExample 
(assert (not (= var937 null-var1240)))
(declare-const var1269 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var1269 null-String)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var1240-to-var436 var937))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var937!1 var1240)
(define-const var2947 var2772 var2772-init) ; Statement: $r28 = new java.util.HashMap 
(assert true)
;(assert (<init>/613807010 var2947 2)) ; Statement: specialinvoke $r28.<java.util.HashMap: void <init>(int)>(2) 

(declare-const var2947!1 var2772)
(declare-const var1235 Int)
(declare-const var937!2 var1240)
(assert (not (= var937!2 null-var1240)))
(assert (= (corefPairs/74865948 var937!2) var2947!1)) ; Statement: r0.<edu.stanford.nlp.scenegraph.AbstractPronounResolver$TestExample: java.util.HashMap corefPairs> = $r28 
; split operation: var1274 = var1269.split("\u005ct") ; Statement: r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\t") 
(define-const var421 String (get_split_element var1269 "\u005ct" -1 0)) ; Statement: $r4 = r3[0] 
; split operation: var2846 = var421.split("\u005cs+") ; Statement: r5 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var755 var1479 var1479-init) ; Statement: $r29 = new java.util.ArrayList 
(define-const var3916 Int (get_split_length var421 "\u005cs+" -1)) ; Statement: $i0 = lengthof r5 
(assert true)
;(assert (<init>/1228603609 var755 var3916)) ; Statement: specialinvoke $r29.<java.util.ArrayList: void <init>(int)>($i0) 

(declare-const var755!1 var1479)
(declare-const var3916!1 Int)
(declare-const var937!3 var1240)
(assert (not (= var937!3 null-var1240)))
(assert (= (tokens/74865948 var937!3) (cast-from-var1479-to-var2585 var755!1))) ; Statement: r0.<edu.stanford.nlp.scenegraph.AbstractPronounResolver$TestExample: java.util.List tokens> = $r29 
(define-const var1130 var1479 var1479-init) ; Statement: $r30 = new java.util.ArrayList 
(assert true)
;(assert (<init>/1228603609 var1130 1)) ; Statement: specialinvoke $r30.<java.util.ArrayList: void <init>(int)>(1) 

(declare-const var1130!1 var1479)
(declare-const var3736 Int)
(declare-const var937!4 var1240)
(assert (not (= var937!4 null-var1240)))
(assert (= (pronouns/74865948 var937!4) (cast-from-var1479-to-var2585 var1130!1))) ; Statement: r0.<edu.stanford.nlp.scenegraph.AbstractPronounResolver$TestExample: java.util.List pronouns> = $r30 
(define-const var1182 Int (get_split_length var421 "\u005cs+" -1)) ; Statement: i6 = lengthof r5 
(define-const var409 Int 0) ; Statement: i7 = 0 
(assert true) ; Non Conditional
 ; Statement: if i7 >= i6 goto $i1 = lengthof r3 
(assert (>= var409 var1182)) ; Cond: i7 >= i6 
(define-const var451 Int (get_split_length var1269 "\u005ct" -1)) ; Statement: $i1 = lengthof r3 
 ; Statement: if $i1 <= 1 goto return 
(assert (<= var451 1)) ; Cond: $i1 <= 1 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var1240-to-var436=([edu.stanford.nlp.scenegraph.AbstractPronounResolver$TestExample], java.lang.Object), var2772-init=([], java.util.HashMap), <init>/613807010=([java.util.HashMap, int], void), corefPairs/74865948=([edu.stanford.nlp.scenegraph.AbstractPronounResolver$TestExample], java.util.HashMap), var1479-init=([], java.util.ArrayList), <init>/1228603609=([java.util.ArrayList, int], void), cast-from-var1479-to-var2585=([java.util.ArrayList], java.util.List), tokens/74865948=([edu.stanford.nlp.scenegraph.AbstractPronounResolver$TestExample], java.util.List), pronouns/74865948=([edu.stanford.nlp.scenegraph.AbstractPronounResolver$TestExample], java.util.List)}
; {var1240=edu.stanford.nlp.scenegraph.AbstractPronounResolver$TestExample, var937=r0, var1269=r2, var298=null_type, var436=java.lang.Object, var2772=java.util.HashMap, var2947=$r28, var1235=2, var1274=r3, var421=$r4, var2846=r5, var1479=java.util.ArrayList, var755=$r29, var3916=$i0, var2585=java.util.List, var1130=$r30, var3736=1, var1182=i6, var409=i7, var451=$i1}
; {edu.stanford.nlp.scenegraph.AbstractPronounResolver$TestExample=var1240, r0=var937, r2=var1269, null_type=var298, java.lang.Object=var436, java.util.HashMap=var2772, $r28=var2947, 2=var1235, r3=var1274, $r4=var421, r5=var2846, java.util.ArrayList=var1479, $r29=var755, $i0=var3916, java.util.List=var2585, $r30=var1130, 1=var3736, i6=var1182, i7=var409, $i1=var451}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2}
;stmts r0 := @this: edu.stanford.nlp.scenegraph.AbstractPronounResolver$TestExample;	r2 := @parameter0: java.lang.String;	specialinvoke r0.<java.lang.Object: void <init>()>();	$r28 = new java.util.HashMap;	specialinvoke $r28.<java.util.HashMap: void <init>(int)>(2);	r0.<edu.stanford.nlp.scenegraph.AbstractPronounResolver$TestExample: java.util.HashMap corefPairs> = $r28;	r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\t");	$r4 = r3[0];	r5 = virtualinvoke $r4.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$r29 = new java.util.ArrayList;	$i0 = lengthof r5;	specialinvoke $r29.<java.util.ArrayList: void <init>(int)>($i0);	r0.<edu.stanford.nlp.scenegraph.AbstractPronounResolver$TestExample: java.util.List tokens> = $r29;	$r30 = new java.util.ArrayList;	specialinvoke $r30.<java.util.ArrayList: void <init>(int)>(1);	r0.<edu.stanford.nlp.scenegraph.AbstractPronounResolver$TestExample: java.util.List pronouns> = $r30;	i6 = lengthof r5;	i7 = 0;	if i7 >= i6 goto $i1 = lengthof r3;	$i1 = lengthof r3;	if $i1 <= 1 goto return;	return
;block_num 4
(get-model)
