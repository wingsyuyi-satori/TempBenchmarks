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

(declare-sort var163 0)
(declare-sort var292 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var292-init () var292)
(declare-fun <init>/598147663 (var292) void)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-fun setWord/-781399982 (var292 String) void)
(declare-fun setValue/611793815 (var292 String) void)
(declare-const null-String String)
(declare-const var2942 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2942 null-String)))
(define-const var2656 var292 var292-init) ; Statement: $r0 = new edu.stanford.nlp.ling.CoreLabel 
(assert true)
;(assert (<init>/598147663 var2656)) ; Statement: specialinvoke $r0.<edu.stanford.nlp.ling.CoreLabel: void <init>()>() 

(declare-const var2656!1 var292)
; split operation: var890 = var2942.split("\u005c|\u005c|\u005c|") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\|\\|\\|") 
(define-const var3374 Int (get_split_length var2942 "\u005c|\u005c|\u005c|" -1)) ; Statement: i0 = lengthof r2 
(define-const var1106 Int 0) ; Statement: i8 = 0 
(assert true) ; Non Conditional
 ; Statement: if i8 >= i0 goto return $r0 
(assert (not (>= var1106 var3374))) ; Negate: Cond: i8 >= i0  
(define-const var2287 String (get_split_element var2942 "\u005c|\u005c|\u005c|" -1 var1106)) ; Statement: r3 = r2[i8] 
(assert true)
(define-const var2604 Bool (startsWith/-1785782452 var2287 "word:::")) ; Statement: $z0 = virtualinvoke r3.<java.lang.String: boolean startsWith(java.lang.String)>("word:::") 
 ; Statement: if $z0 == 0 goto $z1 = virtualinvoke r3.<java.lang.String: boolean startsWith(java.lang.String)>("tag:::") 
(assert (not (= (ite var2604 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var2311 String "word:::") ; Statement: $r13 = "word:::" 
(assert true)
(define-const var2776 Int (length/-134980193 var2311)) ; Statement: $i6 = virtualinvoke $r13.<java.lang.String: int length()>() 
(assert (and true (and (>= var2776 0) (>= (str.len var2287) var2776))))
(define-const var805 String (substring/850833817 var2287 var2776)) ; Statement: $r14 = virtualinvoke r3.<java.lang.String: java.lang.String substring(int)>($i6) 
(assert true)
;(assert (setWord/-781399982 var2656!1 var805)) ; Statement: virtualinvoke $r0.<edu.stanford.nlp.ling.CoreLabel: void setWord(java.lang.String)>($r14) 

(declare-const var2656!2 var292)
(declare-const var805!1 String)
(define-const var2568 String "word:::") ; Statement: $r15 = "word:::" 
(assert true)
(define-const var1006 Int (length/-134980193 var2568)) ; Statement: $i7 = virtualinvoke $r15.<java.lang.String: int length()>() 
(assert (and true (and (>= var1006 0) (>= (str.len var2287) var1006))))
(define-const var1781 String (substring/850833817 var2287 var1006)) ; Statement: $r16 = virtualinvoke r3.<java.lang.String: java.lang.String substring(int)>($i7) 
(assert true)
;(assert (setValue/611793815 var2656!2 var1781)) ; Statement: virtualinvoke $r0.<edu.stanford.nlp.ling.CoreLabel: void setValue(java.lang.String)>($r16) 

(declare-const var2656!3 var292)
(declare-const var1781!1 String)
 ; Statement: goto [?= i8 = i8 + 1] 
(assert true) ; Non Conditional
(define-const var1106!1 Int (+ var1106 1)) ; Statement: i8 = i8 + 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if i8 >= i0 goto return $r0 
(assert (>= var1106!1 var3374)) ; Cond: i8 >= i0 
 ; Statement: return $r0 
(check-sat)
; {var292-init=([], edu.stanford.nlp.ling.CoreLabel), <init>/598147663=([edu.stanford.nlp.ling.CoreLabel], void), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), length/-134980193=([java.lang.String], int), substring/850833817=([java.lang.String, int], java.lang.String), setWord/-781399982=([edu.stanford.nlp.ling.CoreLabel, java.lang.String], void), setValue/611793815=([edu.stanford.nlp.ling.CoreLabel, java.lang.String], void)}
; {var2942=r1, var163=null_type, var292=edu.stanford.nlp.ling.CoreLabel, var2656=$r0, var890=r2, var3374=i0, var1106=i8, var2287=r3, var2604=$z0, var2311=$r13, var2776=$i6, var805=$r14, var2568=$r15, var1006=$i7, var1781=$r16}
; {r1=var2942, null_type=var163, edu.stanford.nlp.ling.CoreLabel=var292, $r0=var2656, r2=var890, i0=var3374, i8=var1106, r3=var2287, $z0=var2604, $r13=var2311, $i6=var2776, $r14=var805, $r15=var2568, $i7=var1006, $r16=var1781}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int)>;	<java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: boolean startsWith(java.lang.String)>": 1,"<java.lang.String: int length()>": 2,"<java.lang.String: java.lang.String substring(int)>": 2}
;stmts r1 := @parameter0: java.lang.String;	$r0 = new edu.stanford.nlp.ling.CoreLabel;	specialinvoke $r0.<edu.stanford.nlp.ling.CoreLabel: void <init>()>();	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\|\\|\\|");	i0 = lengthof r2;	i8 = 0;	if i8 >= i0 goto return $r0;	r3 = r2[i8];	$z0 = virtualinvoke r3.<java.lang.String: boolean startsWith(java.lang.String)>("word:::");	if $z0 == 0 goto $z1 = virtualinvoke r3.<java.lang.String: boolean startsWith(java.lang.String)>("tag:::");	$r13 = "word:::";	$i6 = virtualinvoke $r13.<java.lang.String: int length()>();	$r14 = virtualinvoke r3.<java.lang.String: java.lang.String substring(int)>($i6);	virtualinvoke $r0.<edu.stanford.nlp.ling.CoreLabel: void setWord(java.lang.String)>($r14);	$r15 = "word:::";	$i7 = virtualinvoke $r15.<java.lang.String: int length()>();	$r16 = virtualinvoke r3.<java.lang.String: java.lang.String substring(int)>($i7);	virtualinvoke $r0.<edu.stanford.nlp.ling.CoreLabel: void setValue(java.lang.String)>($r16);	goto [?= i8 = i8 + 1];	i8 = i8 + 1;	goto [?= (branch)];	if i8 >= i0 goto return $r0;	return $r0
;block_num 7
(get-model)
