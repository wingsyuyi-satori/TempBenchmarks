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

(declare-sort var1098 0)
(declare-sort var2080 0)
(declare-sort var3002 0)
(declare-sort var3010 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getPhrase/-292787131 (var3002) String)
(declare-fun var2080_containsKey/1421819118 (var2080 var3010) Bool)
(declare-fun cast-from-var3002-to-var3010 (var3002) var3010)
(declare-const null-var1098 var1098)
(declare-const null-var2080 var2080)
(declare-const null-var3002 var3002)
(declare-const null-Float64 Float64)
(declare-const var1889 var1098) ; Statement: r3 := @this: edu.stanford.nlp.patterns.PhraseScorer 
(assert (not (= var1889 null-var1098)))
(declare-const var3981 var2080) ; Statement: r6 := @parameter0: edu.stanford.nlp.stats.Counter 
(assert (not (= var3981 null-var2080)))
(declare-const var2772 var3002) ; Statement: r0 := @parameter1: edu.stanford.nlp.patterns.CandidatePhrase 
(assert (not (= var2772 null-var3002)))
(declare-const var1986 Float64) ; Statement: d2 := @parameter2: double 
(assert (not (= var1986 null-Float64)))
(assert true)
(define-const var1172 String (getPhrase/-292787131 var2772)) ; Statement: $r1 = virtualinvoke r0.<edu.stanford.nlp.patterns.CandidatePhrase: java.lang.String getPhrase()>() 
; split operation: var3189 = var1172.split("\u005cs+") ; Statement: r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var1276 Int (get_split_length var1172 "\u005cs+" -1)) ; Statement: $i0 = lengthof r2 
 ; Statement: if $i0 >= 2 goto d4 = 0.0 
(assert (not (>= var1276 2))) ; Negate: Cond: $i0 >= 2  
(define-const var2585 Bool (var2080_containsKey/1421819118 var3981 (cast-from-var3002-to-var3010 var2772))) ; Statement: $z2 = interfaceinvoke r6.<edu.stanford.nlp.stats.Counter: boolean containsKey(java.lang.Object)>(r0) 
 ; Statement: if $z2 == 0 goto return d2 
(assert (= (ite var2585 1 0) 0)) ; Cond: $z2 == 0 
 ; Statement: return d2 
(check-sat)
; {getPhrase/-292787131=([edu.stanford.nlp.patterns.CandidatePhrase], java.lang.String), var2080_containsKey/1421819118=([edu.stanford.nlp.stats.Counter, java.lang.Object], boolean), cast-from-var3002-to-var3010=([edu.stanford.nlp.patterns.CandidatePhrase], java.lang.Object)}
; {var1098=edu.stanford.nlp.patterns.PhraseScorer, var1889=r3, var2080=edu.stanford.nlp.stats.Counter, var3981=r6, var3002=edu.stanford.nlp.patterns.CandidatePhrase, var2772=r0, var1986=d2, var1172=$r1, var3189=r2, var1276=$i0, var3010=java.lang.Object, var2585=$z2}
; {edu.stanford.nlp.patterns.PhraseScorer=var1098, r3=var1889, edu.stanford.nlp.stats.Counter=var2080, r6=var3981, edu.stanford.nlp.patterns.CandidatePhrase=var3002, r0=var2772, d2=var1986, $r1=var1172, r2=var3189, $i0=var1276, java.lang.Object=var3010, $z2=var2585}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r3 := @this: edu.stanford.nlp.patterns.PhraseScorer;	r6 := @parameter0: edu.stanford.nlp.stats.Counter;	r0 := @parameter1: edu.stanford.nlp.patterns.CandidatePhrase;	d2 := @parameter2: double;	$r1 = virtualinvoke r0.<edu.stanford.nlp.patterns.CandidatePhrase: java.lang.String getPhrase()>();	r2 = virtualinvoke $r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	$i0 = lengthof r2;	if $i0 >= 2 goto d4 = 0.0;	$z2 = interfaceinvoke r6.<edu.stanford.nlp.stats.Counter: boolean containsKey(java.lang.Object)>(r0);	if $z2 == 0 goto return d2;	return d2
;block_num 3
(get-model)
