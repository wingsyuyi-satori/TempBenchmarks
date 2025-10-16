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

(declare-sort var2171 0)
(declare-sort var3996 0)
(declare-sort var1939 0)
(declare-sort var3492 0)
(declare-sort var1980 0)
(declare-sort var2009 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var1939!class ClassObject)
(declare-fun remove/1441186265 (var3492 ClassObject) var2009)
(declare-fun cast-from-var3996-to-var3492 (var3996) var3492)
(declare-fun word/-864359544 (var3996) String)
(declare-fun replaceAll/1692887130 (String String String) String)
(declare-fun compoundBuffer/893453587 (var2171) var1980)
(declare-fun var1980_remove/1853576941 (var1980 Int) var2009)
(declare-fun cast-from-var2009-to-var3996 (var2009) var3996)
(declare-const null-var2171 var2171)
(declare-const null-var3996 var3996)
(declare-const var3624 var2171) ; Statement: r4 := @this: edu.stanford.nlp.international.french.process.FrenchTokenizer 
(assert (not (= var3624 null-var2171)))
(declare-const var2902 var3996) ; Statement: r0 := @parameter0: edu.stanford.nlp.ling.CoreLabel 
(assert (not (= var2902 null-var3996)))
(assert true)
;(assert (remove/1441186265 (cast-from-var3996-to-var3492 var2902) var1939!class)) ; Statement: virtualinvoke r0.<edu.stanford.nlp.ling.CoreLabel: java.lang.Object remove(java.lang.Class)>(class "Ledu/stanford/nlp/ling/CoreAnnotations$ParentAnnotation;") 

(declare-const var2902!1 var3996)
(declare-const var1607 ClassObject)
(assert true)
(define-const var3784 String (word/-864359544 var2902!1)) ; Statement: $r1 = virtualinvoke r0.<edu.stanford.nlp.ling.CoreLabel: java.lang.String word()>() 
(assert true)
(define-const var32 String (replaceAll/1692887130 var3784 "-" " - ")) ; Statement: $r2 = virtualinvoke $r1.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("-", " - ") 
(assert (= (replaceAll/1692887130 var3784 "-" " - ") (str.replace_re_all var3784 (str.to_re "-") " - ")))
; split operation: var742 = var32.split("\u005cs+") ; Statement: r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var1421 Int (get_split_length var32 "\u005cs+" -1)) ; Statement: i0 = lengthof r3 
(define-const var1112 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto $r5 = r4.<edu.stanford.nlp.international.french.process.FrenchTokenizer: java.util.List compoundBuffer> 
(assert (>= var1112 var1421)) ; Cond: i1 >= i0 
(define-const var2122 var1980 (compoundBuffer/893453587 var3624)) ; Statement: $r5 = r4.<edu.stanford.nlp.international.french.process.FrenchTokenizer: java.util.List compoundBuffer> 
(define-const var569 var2009 (var1980_remove/1853576941 var2122 0)) ; Statement: $r6 = interfaceinvoke $r5.<java.util.List: java.lang.Object remove(int)>(0) 
(define-const var1149 var3996 (cast-from-var2009-to-var3996 var569)) ; Statement: $r7 = (edu.stanford.nlp.ling.CoreLabel) $r6 
 ; Statement: return $r7 
(check-sat)
; {remove/1441186265=([edu.stanford.nlp.util.ArrayCoreMap, java.lang.Class], java.lang.Object), cast-from-var3996-to-var3492=([edu.stanford.nlp.ling.CoreLabel], edu.stanford.nlp.util.ArrayCoreMap), word/-864359544=([edu.stanford.nlp.ling.CoreLabel], java.lang.String), replaceAll/1692887130=([java.lang.String, java.lang.String, java.lang.String], java.lang.String), compoundBuffer/893453587=([edu.stanford.nlp.international.french.process.FrenchTokenizer], java.util.List), var1980_remove/1853576941=([java.util.List, int], java.lang.Object), cast-from-var2009-to-var3996=([java.lang.Object], edu.stanford.nlp.ling.CoreLabel)}
; {var2171=edu.stanford.nlp.international.french.process.FrenchTokenizer, var3624=r4, var3996=edu.stanford.nlp.ling.CoreLabel, var2902=r0, var1939=edu.stanford.nlp.ling.CoreAnnotations$ParentAnnotation, var3492=edu.stanford.nlp.util.ArrayCoreMap, var1607=class "Ledu/stanford/nlp/ling/CoreAnnotations$ParentAnnotation;", var3784=$r1, var32=$r2, var742=r3, var1421=i0, var1112=i1, var1980=java.util.List, var2122=$r5, var2009=java.lang.Object, var569=$r6, var1149=$r7}
; {edu.stanford.nlp.international.french.process.FrenchTokenizer=var2171, r4=var3624, edu.stanford.nlp.ling.CoreLabel=var3996, r0=var2902, edu.stanford.nlp.ling.CoreAnnotations$ParentAnnotation=var1939, edu.stanford.nlp.util.ArrayCoreMap=var3492, class "Ledu/stanford/nlp/ling/CoreAnnotations$ParentAnnotation;"=var1607, $r1=var3784, $r2=var32, r3=var742, i0=var1421, i1=var1112, java.util.List=var1980, $r5=var2122, java.lang.Object=var2009, $r6=var569, $r7=var1149}
;seq <java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r4 := @this: edu.stanford.nlp.international.french.process.FrenchTokenizer;	r0 := @parameter0: edu.stanford.nlp.ling.CoreLabel;	virtualinvoke r0.<edu.stanford.nlp.ling.CoreLabel: java.lang.Object remove(java.lang.Class)>(class "Ledu/stanford/nlp/ling/CoreAnnotations$ParentAnnotation;");	$r1 = virtualinvoke r0.<edu.stanford.nlp.ling.CoreLabel: java.lang.String word()>();	$r2 = virtualinvoke $r1.<java.lang.String: java.lang.String replaceAll(java.lang.String,java.lang.String)>("-", " - ");	r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	i0 = lengthof r3;	i1 = 0;	if i1 >= i0 goto $r5 = r4.<edu.stanford.nlp.international.french.process.FrenchTokenizer: java.util.List compoundBuffer>;	$r5 = r4.<edu.stanford.nlp.international.french.process.FrenchTokenizer: java.util.List compoundBuffer>;	$r6 = interfaceinvoke $r5.<java.util.List: java.lang.Object remove(int)>(0);	$r7 = (edu.stanford.nlp.ling.CoreLabel) $r6;	return $r7
;block_num 3
(get-model)
