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

(declare-sort var1627 0)
(declare-sort var257 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun initialized/615252293 (var1627) Bool)
(declare-fun docId/615252293 (var1627) String)
(declare-const null-var1627 var1627)
(declare-const null-String String)
(declare-const var1881 var1627) ; Statement: r7 := @this: edu.stanford.nlp.time.SUTimeMain$TimebankSent 
(assert (not (= var1881 null-var1627)))
(declare-const var552 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var552 null-String)))
; split operation: var1703 = var552.split("\u005cs*\u005c|\u005cs*", 9) ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\s*\\|\\s*", 9) 
(define-const var2298 String (get_split_element var552 "\u005cs*\u005c|\u005cs*" 9 0)) ; Statement: r2 = r1[0] 
(define-const var70 String (get_split_element var552 "\u005cs*\u005c|\u005cs*" 9 1)) ; Statement: r3 = r1[1] 
(define-const var2047 String (get_split_element var552 "\u005cs*\u005c|\u005cs*" 9 2)) ; Statement: r4 = r1[2] 
(define-const var3605 String (get_split_element var552 "\u005cs*\u005c|\u005cs*" 9 3)) ; Statement: r5 = r1[3] 
(define-const var2149 String (get_split_element var552 "\u005cs*\u005c|\u005cs*" 9 8)) ; Statement: r6 = r1[8] 
(define-const var459 Bool (initialized/615252293 var1881)) ; Statement: $z0 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: boolean initialized> 
 ; Statement: if $z0 == 0 goto r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docId> = r2 
(assert (not (= (ite var459 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var601 String (docId/615252293 var1881)) ; Statement: $r11 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docId> 
(assert true)
(define-const var2771 Bool (= var2298 var601)) ; Statement: $z1 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>($r11) 
 ; Statement: if $z1 == 0 goto return 0 
(assert (= (ite var2771 1 0) 0)) ; Cond: $z1 == 0 
 ; Statement: return 0 
(check-sat)
; {initialized/615252293=([edu.stanford.nlp.time.SUTimeMain$TimebankSent], boolean), docId/615252293=([edu.stanford.nlp.time.SUTimeMain$TimebankSent], java.lang.String)}
; {var1627=edu.stanford.nlp.time.SUTimeMain$TimebankSent, var1881=r7, var552=r0, var257=null_type, var1703=r1, var2298=r2, var70=r3, var2047=r4, var3605=r5, var2149=r6, var459=$z0, var601=$r11, var2771=$z1}
; {edu.stanford.nlp.time.SUTimeMain$TimebankSent=var1627, r7=var1881, r0=var552, null_type=var257, r1=var1703, r2=var2298, r3=var70, r4=var2047, r5=var3605, r6=var2149, $z0=var459, $r11=var601, $z1=var2771}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r7 := @this: edu.stanford.nlp.time.SUTimeMain$TimebankSent;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\s*\\|\\s*", 9);	r2 = r1[0];	r3 = r1[1];	r4 = r1[2];	r5 = r1[3];	r6 = r1[8];	$z0 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: boolean initialized>;	if $z0 == 0 goto r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docId> = r2;	$r11 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docId>;	$z1 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>($r11);	if $z1 == 0 goto return 0;	return 0
;block_num 3
(get-model)
