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

(declare-sort var1761 0)
(declare-sort var609 0)
(declare-sort var512 0)
(declare-sort var447 0)
(declare-sort var158 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var609!class ClassObject)
(declare-fun arr-var1761-init () (Array Int var1761))
(declare-fun cast-from-ClassObject-to-var1761 (ClassObject) var1761)
(declare-fun var447_channels/-1873906782 ((Array Int var1761)) var512)
(declare-fun var158-init () var158)
(declare-fun <init>/964458484 (var158) void)
(declare-const null-__Array__Int__var1761__ (Array Int var1761))
(define-const var538 (Array Int var1761) arr-var1761-init) ; Statement: $r0 = newarray (java.lang.Object)[1] 
(declare-const var538!1 (Array Int var1761))
(assert (not (= var538!1 null-__Array__Int__var1761__)))
(assert (= (select var538!1 0) (cast-from-ClassObject-to-var1761 var609!class))) ; Statement: $r0[0] = class "Ledu/stanford/nlp/international/arabic/process/ArabicTokenizer;" 
(define-const var1042 var512 (var447_channels/-1873906782 var538!1)) ; Statement: $r1 = staticinvoke <edu.stanford.nlp.util.logging.Redwood: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels channels(java.lang.Object[])>($r0) 
(define-const var382 var512 var1042) ; Statement: <edu.stanford.nlp.international.arabic.process.ArabicTokenizer: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels log> = $r1 
(define-const var218 var158 var158-init) ; Statement: $r2 = new java.util.Properties 
(assert true)
;(assert (<init>/964458484 var218)) ; Statement: specialinvoke $r2.<java.util.Properties: void <init>()>() 

(declare-const var218!1 var158)
(define-const var3442 var158 var218!1) ; Statement: <edu.stanford.nlp.international.arabic.process.ArabicTokenizer: java.util.Properties atbOptions> = $r2 
(define-const var116 String "normArDigits,normArPunc,normAlif,removeDiacritics,removeTatweel,removeQuranChars") ; Statement: r3 = "normArDigits,normArPunc,normAlif,removeDiacritics,removeTatweel,removeQuranChars" 
; split operation: var1453 = var116.split(",") ; Statement: r4 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(",") 
(define-const var3733 Int (get_split_length var116 "," -1)) ; Statement: i0 = lengthof r4 
(define-const var1048 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto return 
(assert (>= var1048 var3733)) ; Cond: i1 >= i0 
 ; Statement: return 
(check-sat)
; {arr-var1761-init=([], java.lang.Object[]), cast-from-ClassObject-to-var1761=([java.lang.Class], java.lang.Object), var447_channels/-1873906782=([java.lang.Object[]], edu.stanford.nlp.util.logging.Redwood$RedwoodChannels), var158-init=([], java.util.Properties), <init>/964458484=([java.util.Properties], void)}
; {var1761=java.lang.Object, var538=$r0, var609=edu.stanford.nlp.international.arabic.process.ArabicTokenizer, var512=edu.stanford.nlp.util.logging.Redwood$RedwoodChannels, var447=edu.stanford.nlp.util.logging.Redwood, var1042=$r1, var382=<edu.stanford.nlp.international.arabic.process.ArabicTokenizer: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels log>, var158=java.util.Properties, var218=$r2, var3442=<edu.stanford.nlp.international.arabic.process.ArabicTokenizer: java.util.Properties atbOptions>, var116=r3, var1453=r4, var3733=i0, var1048=i1}
; {java.lang.Object=var1761, $r0=var538, edu.stanford.nlp.international.arabic.process.ArabicTokenizer=var609, edu.stanford.nlp.util.logging.Redwood$RedwoodChannels=var512, edu.stanford.nlp.util.logging.Redwood=var447, $r1=var1042, <edu.stanford.nlp.international.arabic.process.ArabicTokenizer: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels log>=var382, java.util.Properties=var158, $r2=var218, <edu.stanford.nlp.international.arabic.process.ArabicTokenizer: java.util.Properties atbOptions>=var3442, r3=var116, r4=var1453, i0=var3733, i1=var1048}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts $r0 = newarray (java.lang.Object)[1];	$r0[0] = class "Ledu/stanford/nlp/international/arabic/process/ArabicTokenizer;";	$r1 = staticinvoke <edu.stanford.nlp.util.logging.Redwood: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels channels(java.lang.Object[])>($r0);	<edu.stanford.nlp.international.arabic.process.ArabicTokenizer: edu.stanford.nlp.util.logging.Redwood$RedwoodChannels log> = $r1;	$r2 = new java.util.Properties;	specialinvoke $r2.<java.util.Properties: void <init>()>();	<edu.stanford.nlp.international.arabic.process.ArabicTokenizer: java.util.Properties atbOptions> = $r2;	r3 = "normArDigits,normArPunc,normAlif,removeDiacritics,removeTatweel,removeQuranChars";	r4 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String)>(",");	i0 = lengthof r4;	i1 = 0;	if i1 >= i0 goto return;	return
;block_num 3
(get-model)
