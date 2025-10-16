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

(declare-sort var1395 0)
(declare-sort var2214 0)
(declare-sort var3543 0)
(declare-sort var2163 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(declare-fun arr-var3543-init () (Array Int var3543))
(declare-fun cast-from-String-to-var3543 (String) var3543)
(declare-fun var2163_log/2127824580 ((Array Int var3543)) void)
(declare-fun info/114590825 (var2214 String) void)
(declare-const null-String String)
(declare-const null-var2214 var2214)
(declare-const null-Bool Bool)
(declare-const null-__Array__Int__var3543__ (Array Int var3543))
(declare-const var3808 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3808 null-String)))
(declare-const var1791 var2214) ; Statement: r5 := @parameter1: java.util.logging.Logger 
(assert (not (= var1791 null-var2214)))
(declare-const var3185 Bool) ; Statement: z0 := @parameter2: boolean 
(assert (not (= var3185 null-Bool)))
; split operation: var2454 = var3808.split("\n") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
 ; Statement: if z0 != 0 goto $r2 = new java.lang.StringBuilder 
(assert (not (not (= (ite var3185 1 0) 0)))) ; Negate: Cond: z0 != 0  
(define-const var3211 Int (get_split_length var3808 "\n" -1)) ; Statement: i0 = lengthof r1 
(define-const var1496 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
 ; Statement: if i1 >= i0 goto (branch) 
(assert (not (>= var1496 var3211))) ; Negate: Cond: i1 >= i0  
(define-const var3098 String (get_split_element var3808 "\n" -1 var1496)) ; Statement: r10 = r1[i1] 
(assert true)
(define-const var3766 Bool (startsWith/-1785782452 var3098 "Identification of Mentions")) ; Statement: $z4 = virtualinvoke r10.<java.lang.String: boolean startsWith(java.lang.String)>("Identification of Mentions") 
 ; Statement: if $z4 == 0 goto i1 = i1 + 1 
(assert (not (= (ite var3766 1 0) 0))) ; Negate: Cond: $z4 == 0  
(define-const var951 (Array Int var3543) arr-var3543-init) ; Statement: $r9 = newarray (java.lang.Object)[1] 
(declare-const var951!1 (Array Int var3543))
(assert (not (= var951!1 null-__Array__Int__var3543__)))
(assert (= (select var951!1 0) (cast-from-String-to-var3543 var3098))) ; Statement: $r9[0] = r10 
;(assert (var2163_log/2127824580 var951!1)) ; Statement: staticinvoke <edu.stanford.nlp.util.logging.Redwood: void log(java.lang.Object[])>($r9) 

(declare-const var951!2 (Array Int var3543))
(assert true)
;(assert (info/114590825 var1791 var3098)) ; Statement: virtualinvoke r5.<java.util.logging.Logger: void info(java.lang.String)>(r10) 

(declare-const var1791!1 var2214)
(declare-const var3098!1 String)
 ; Statement: return 
(check-sat)
; {startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), arr-var3543-init=([], java.lang.Object[]), cast-from-String-to-var3543=([java.lang.String], java.lang.Object), var2163_log/2127824580=([java.lang.Object[]], void), info/114590825=([java.util.logging.Logger, java.lang.String], void)}
; {var3808=r0, var1395=null_type, var2214=java.util.logging.Logger, var1791=r5, var3185=z0, var2454=r1, var3211=i0, var1496=i1, var3098=r10, var3766=$z4, var3543=java.lang.Object, var951=$r9, var2163=edu.stanford.nlp.util.logging.Redwood}
; {r0=var3808, null_type=var1395, java.util.logging.Logger=var2214, r5=var1791, z0=var3185, r1=var2454, i0=var3211, i1=var1496, r10=var3098, $z4=var3766, java.lang.Object=var3543, $r9=var951, edu.stanford.nlp.util.logging.Redwood=var2163}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: boolean startsWith(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: boolean startsWith(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r5 := @parameter1: java.util.logging.Logger;	z0 := @parameter2: boolean;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	if z0 != 0 goto $r2 = new java.lang.StringBuilder;	i0 = lengthof r1;	i1 = 0;	if i1 >= i0 goto (branch);	r10 = r1[i1];	$z4 = virtualinvoke r10.<java.lang.String: boolean startsWith(java.lang.String)>("Identification of Mentions");	if $z4 == 0 goto i1 = i1 + 1;	$r9 = newarray (java.lang.Object)[1];	$r9[0] = r10;	staticinvoke <edu.stanford.nlp.util.logging.Redwood: void log(java.lang.Object[])>($r9);	virtualinvoke r5.<java.util.logging.Logger: void info(java.lang.String)>(r10);	return
;block_num 5
(get-model)
