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

(declare-sort var309 0)
(declare-sort var372 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var372-init () var372)
(declare-fun <init>/598147663 (var372) void)
(define-fun startsWith/-1785782452 ((s String) (prefix String)) Bool (str.prefixof prefix s))
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun substring/850833817 ((s String) (begin Int)) String (str.substr s begin (- (str.len s) begin)))
(declare-fun setTag/-302746546 (var372 String) void)
(declare-const null-String String)
(declare-const var3322 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3322 null-String)))
(define-const var1552 var372 var372-init) ; Statement: $r0 = new edu.stanford.nlp.ling.CoreLabel 
(assert true)
;(assert (<init>/598147663 var1552)) ; Statement: specialinvoke $r0.<edu.stanford.nlp.ling.CoreLabel: void <init>()>() 

(declare-const var1552!1 var372)
; split operation: var1843 = var3322.split("\u005c|\u005c|\u005c|") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\|\\|\\|") 
(define-const var1476 Int (get_split_length var3322 "\u005c|\u005c|\u005c|" -1)) ; Statement: i0 = lengthof r2 
(define-const var2369 Int 0) ; Statement: i8 = 0 
(assert true) ; Non Conditional
 ; Statement: if i8 >= i0 goto return $r0 
(assert (not (>= var2369 var1476))) ; Negate: Cond: i8 >= i0  
(define-const var1328 String (get_split_element var3322 "\u005c|\u005c|\u005c|" -1 var2369)) ; Statement: r3 = r2[i8] 
(assert true)
(define-const var708 Bool (startsWith/-1785782452 var1328 "word:::")) ; Statement: $z0 = virtualinvoke r3.<java.lang.String: boolean startsWith(java.lang.String)>("word:::") 
 ; Statement: if $z0 == 0 goto $z1 = virtualinvoke r3.<java.lang.String: boolean startsWith(java.lang.String)>("tag:::") 
(assert (= (ite var708 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var38 Bool (startsWith/-1785782452 var1328 "tag:::")) ; Statement: $z1 = virtualinvoke r3.<java.lang.String: boolean startsWith(java.lang.String)>("tag:::") 
 ; Statement: if $z1 == 0 goto $z2 = virtualinvoke r3.<java.lang.String: boolean startsWith(java.lang.String)>("lemma:::") 
(assert (not (= (ite var38 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var1302 String "tag:::") ; Statement: $r11 = "tag:::" 
(assert true)
(define-const var3735 Int (length/-134980193 var1302)) ; Statement: $i5 = virtualinvoke $r11.<java.lang.String: int length()>() 
(assert (and true (and (>= var3735 0) (>= (str.len var1328) var3735))))
(define-const var2455 String (substring/850833817 var1328 var3735)) ; Statement: $r12 = virtualinvoke r3.<java.lang.String: java.lang.String substring(int)>($i5) 
(assert true)
;(assert (setTag/-302746546 var1552!1 var2455)) ; Statement: virtualinvoke $r0.<edu.stanford.nlp.ling.CoreLabel: void setTag(java.lang.String)>($r12) 

(declare-const var1552!2 var372)
(declare-const var2455!1 String)
 ; Statement: goto [?= i8 = i8 + 1] 
(assert true) ; Non Conditional
(define-const var2369!1 Int (+ var2369 1)) ; Statement: i8 = i8 + 1 
 ; Statement: goto [?= (branch)] 
(assert true) ; Non Conditional
 ; Statement: if i8 >= i0 goto return $r0 
(assert (>= var2369!1 var1476)) ; Cond: i8 >= i0 
 ; Statement: return $r0 
(check-sat)
; {var372-init=([], edu.stanford.nlp.ling.CoreLabel), <init>/598147663=([edu.stanford.nlp.ling.CoreLabel], void), startsWith/-1785782452=([java.lang.String, java.lang.String], boolean), length/-134980193=([java.lang.String], int), substring/850833817=([java.lang.String, int], java.lang.String), setTag/-302746546=([edu.stanford.nlp.ling.CoreLabel, java.lang.String], void)}
; {var3322=r1, var309=null_type, var372=edu.stanford.nlp.ling.CoreLabel, var1552=$r0, var1843=r2, var1476=i0, var2369=i8, var1328=r3, var708=$z0, var38=$z1, var1302=$r11, var3735=$i5, var2455=$r12}
; {r1=var3322, null_type=var309, edu.stanford.nlp.ling.CoreLabel=var372, $r0=var1552, r2=var1843, i0=var1476, i8=var2369, r3=var1328, $z0=var708, $z1=var38, $r11=var1302, $i5=var3735, $r12=var2455}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.String: boolean startsWith(java.lang.String)>;	<java.lang.String: int length()>;	<java.lang.String: java.lang.String substring(int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: boolean startsWith(java.lang.String)>": 2,"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String substring(int)>": 1}
;stmts r1 := @parameter0: java.lang.String;	$r0 = new edu.stanford.nlp.ling.CoreLabel;	specialinvoke $r0.<edu.stanford.nlp.ling.CoreLabel: void <init>()>();	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\|\\|\\|");	i0 = lengthof r2;	i8 = 0;	if i8 >= i0 goto return $r0;	r3 = r2[i8];	$z0 = virtualinvoke r3.<java.lang.String: boolean startsWith(java.lang.String)>("word:::");	if $z0 == 0 goto $z1 = virtualinvoke r3.<java.lang.String: boolean startsWith(java.lang.String)>("tag:::");	$z1 = virtualinvoke r3.<java.lang.String: boolean startsWith(java.lang.String)>("tag:::");	if $z1 == 0 goto $z2 = virtualinvoke r3.<java.lang.String: boolean startsWith(java.lang.String)>("lemma:::");	$r11 = "tag:::";	$i5 = virtualinvoke $r11.<java.lang.String: int length()>();	$r12 = virtualinvoke r3.<java.lang.String: java.lang.String substring(int)>($i5);	virtualinvoke $r0.<edu.stanford.nlp.ling.CoreLabel: void setTag(java.lang.String)>($r12);	goto [?= i8 = i8 + 1];	i8 = i8 + 1;	goto [?= (branch)];	if i8 >= i0 goto return $r0;	return $r0
;block_num 8
(get-model)
