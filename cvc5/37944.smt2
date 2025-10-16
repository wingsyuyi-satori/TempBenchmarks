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

(declare-sort var3342 0)
(declare-sort var2098 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun initialized/615252293 (var3342) Bool)
(declare-fun docId/615252293 (var3342) String)
(declare-fun sentId/615252293 (var3342) String)
(declare-const null-var3342 var3342)
(declare-const null-String String)
(declare-const var1639 var3342) ; Statement: r7 := @this: edu.stanford.nlp.time.SUTimeMain$TimebankSent 
(assert (not (= var1639 null-var3342)))
(declare-const var1786 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1786 null-String)))
; split operation: var2215 = var1786.split("\u005cs*\u005c|\u005cs*", 9) ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\s*\\|\\s*", 9) 
(define-const var1417 String (get_split_element var1786 "\u005cs*\u005c|\u005cs*" 9 0)) ; Statement: r2 = r1[0] 
(define-const var1398 String (get_split_element var1786 "\u005cs*\u005c|\u005cs*" 9 1)) ; Statement: r3 = r1[1] 
(define-const var1950 String (get_split_element var1786 "\u005cs*\u005c|\u005cs*" 9 2)) ; Statement: r4 = r1[2] 
(define-const var2986 String (get_split_element var1786 "\u005cs*\u005c|\u005cs*" 9 3)) ; Statement: r5 = r1[3] 
(define-const var1599 String (get_split_element var1786 "\u005cs*\u005c|\u005cs*" 9 8)) ; Statement: r6 = r1[8] 
(define-const var2617 Bool (initialized/615252293 var1639)) ; Statement: $z0 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: boolean initialized> 
 ; Statement: if $z0 == 0 goto r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docId> = r2 
(assert (not (= (ite var2617 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2627 String (docId/615252293 var1639)) ; Statement: $r11 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docId> 
(assert true)
(define-const var953 Bool (= var1417 var2627)) ; Statement: $z1 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>($r11) 
 ; Statement: if $z1 == 0 goto return 0 
(assert (not (= (ite var953 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var3903 String (sentId/615252293 var1639)) ; Statement: $r12 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String sentId> 
(assert true)
(define-const var42 Bool (= var2986 var3903)) ; Statement: $z2 = virtualinvoke r5.<java.lang.String: boolean equals(java.lang.Object)>($r12) 
 ; Statement: if $z2 != 0 goto $r8 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.util.List origItems> 
(assert (not (not (= (ite var42 1 0) 0)))) ; Negate: Cond: $z2 != 0  
 ; Statement: return 0 
(check-sat)
; {initialized/615252293=([edu.stanford.nlp.time.SUTimeMain$TimebankSent], boolean), docId/615252293=([edu.stanford.nlp.time.SUTimeMain$TimebankSent], java.lang.String), sentId/615252293=([edu.stanford.nlp.time.SUTimeMain$TimebankSent], java.lang.String)}
; {var3342=edu.stanford.nlp.time.SUTimeMain$TimebankSent, var1639=r7, var1786=r0, var2098=null_type, var2215=r1, var1417=r2, var1398=r3, var1950=r4, var2986=r5, var1599=r6, var2617=$z0, var2627=$r11, var953=$z1, var3903=$r12, var42=$z2}
; {edu.stanford.nlp.time.SUTimeMain$TimebankSent=var3342, r7=var1639, r0=var1786, null_type=var2098, r1=var2215, r2=var1417, r3=var1398, r4=var1950, r5=var2986, r6=var1599, $z0=var2617, $r11=var2627, $z1=var953, $r12=var3903, $z2=var42}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>;	<java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1,"<java.lang.String: boolean equals(java.lang.Object)>": 2}
;stmts r7 := @this: edu.stanford.nlp.time.SUTimeMain$TimebankSent;	r0 := @parameter0: java.lang.String;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String,int)>("\\s*\\|\\s*", 9);	r2 = r1[0];	r3 = r1[1];	r4 = r1[2];	r5 = r1[3];	r6 = r1[8];	$z0 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: boolean initialized>;	if $z0 == 0 goto r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docId> = r2;	$r11 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String docId>;	$z1 = virtualinvoke r2.<java.lang.String: boolean equals(java.lang.Object)>($r11);	if $z1 == 0 goto return 0;	$r12 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.lang.String sentId>;	$z2 = virtualinvoke r5.<java.lang.String: boolean equals(java.lang.Object)>($r12);	if $z2 != 0 goto $r8 = r7.<edu.stanford.nlp.time.SUTimeMain$TimebankSent: java.util.List origItems>;	return 0
;block_num 4
(get-model)
