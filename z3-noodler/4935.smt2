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

(declare-sort var1625 0)
(declare-sort var2132 0)
(declare-sort var419 0)
(declare-sort var2903 0)
(declare-sort var221 0)
(declare-sort var1633 0)
(declare-sort var3360 0)
(declare-sort var2247 0)
(declare-sort var367 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var419_asList/1779083644 ((Array Int var2903)) var2132)
(declare-fun cast-from-__Array__Int__String__-to-__Array__Int__var2903__ ((Array Int String)) (Array Int var2903))
(declare-fun var1633_bootstrap$/-666929012 () var221)
(declare-fun var3360_filterAsList/-1582513876 (var2247 var221) var2132)
(declare-fun cast-from-var2132-to-var2247 (var2132) var2247)
(declare-fun var2132_size/-959786421 (var2132) Int)
(declare-fun var2132_get/-1216255739 (var2132 Int) var2903)
(declare-fun cast-from-var2903-to-String (var2903) String)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun arr-Float64-2-init () (Array Int (Array Int Float64)))
(declare-fun var367-init () var367)
(declare-fun <init>/1181716069 (var367 (Array Int (Array Int Float64))) void)
(declare-const null-String String)
(declare-const var191 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var191 null-String)))
; split operation: var1011 = var191.split("\n") ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(declare-const var1011 (Array Int String))
(define-const var43 var2132 (var419_asList/1779083644 (cast-from-__Array__Int__String__-to-__Array__Int__var2903__ var1011))) ; Statement: $r3 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r1) 
(define-const var2858 var221 var1633_bootstrap$/-666929012) ; Statement: $r2 = staticinvoke <edu.stanford.nlp.neural.NeuralUtils$lambda_convertTextMatrix_0__282: java.util.function.Predicate bootstrap$()>() 
(define-const var2002 var2132 (var3360_filterAsList/-1582513876 (cast-from-var2132-to-var2247 var43) var2858)) ; Statement: r4 = staticinvoke <edu.stanford.nlp.util.CollectionUtils: java.util.List filterAsList(java.util.Collection,java.util.function.Predicate)>($r3, $r2) 
(define-const var3967 Int (var2132_size/-959786421 var2002)) ; Statement: i0 = interfaceinvoke r4.<java.util.List: int size()>() 
(define-const var744 var2903 (var2132_get/-1216255739 var2002 0)) ; Statement: $r5 = interfaceinvoke r4.<java.util.List: java.lang.Object get(int)>(0) 
(define-const var3363 String (cast-from-var2903-to-String var744)) ; Statement: $r6 = (java.lang.String) $r5 
(assert true)
(define-const var3142 String (trim/-847153721 var3363)) ; Statement: $r7 = virtualinvoke $r6.<java.lang.String: java.lang.String trim()>() 
; split operation: var1715 = var3142.split("\u005cs+") ; Statement: $r8 = virtualinvoke $r7.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+") 
(define-const var2357 Int (get_split_length var3142 "\u005cs+" -1)) ; Statement: i1 = lengthof $r8 
(define-const var3956 (Array Int (Array Int Float64)) arr-Float64-2-init) ; Statement: r9 = newmultiarray (double)[i0][i1] 
(define-const var2456 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i0 goto $r10 = new org.ejml.simple.SimpleMatrix 
(assert (>= var2456 var3967)) ; Cond: i3 >= i0 
(define-const var1994 var367 var367-init) ; Statement: $r10 = new org.ejml.simple.SimpleMatrix 
(assert true)
;(assert (<init>/1181716069 var1994 var3956)) ; Statement: specialinvoke $r10.<org.ejml.simple.SimpleMatrix: void <init>(double[][])>(r9) 

(declare-const var1994!1 var367)
(declare-const var3956!1 (Array Int (Array Int Float64)))
 ; Statement: return $r10 
(check-sat)
; {var419_asList/1779083644=([java.lang.Object[]], java.util.List), cast-from-__Array__Int__String__-to-__Array__Int__var2903__=([java.lang.String[]], java.lang.Object[]), var1633_bootstrap$/-666929012=([], java.util.function.Predicate), var3360_filterAsList/-1582513876=([java.util.Collection, java.util.function.Predicate], java.util.List), cast-from-var2132-to-var2247=([java.util.List], java.util.Collection), var2132_size/-959786421=([java.util.List], int), var2132_get/-1216255739=([java.util.List, int], java.lang.Object), cast-from-var2903-to-String=([java.lang.Object], java.lang.String), trim/-847153721=([java.lang.String], java.lang.String), arr-Float64-2-init=([], double[][]), var367-init=([], org.ejml.simple.SimpleMatrix), <init>/1181716069=([org.ejml.simple.SimpleMatrix, double[][]], void)}
; {var191=r0, var1625=null_type, var1011=$r1, var2132=java.util.List, var419=java.util.Arrays, var2903=java.lang.Object, var43=$r3, var221=java.util.function.Predicate, var1633=edu.stanford.nlp.neural.NeuralUtils$lambda_convertTextMatrix_0__282, var2858=$r2, var3360=edu.stanford.nlp.util.CollectionUtils, var2247=java.util.Collection, var2002=r4, var3967=i0, var744=$r5, var3363=$r6, var3142=$r7, var1715=$r8, var2357=i1, var3956=r9, var2456=i3, var367=org.ejml.simple.SimpleMatrix, var1994=$r10}
; {r0=var191, null_type=var1625, $r1=var1011, java.util.List=var2132, java.util.Arrays=var419, java.lang.Object=var2903, $r3=var43, java.util.function.Predicate=var221, edu.stanford.nlp.neural.NeuralUtils$lambda_convertTextMatrix_0__282=var1633, $r2=var2858, edu.stanford.nlp.util.CollectionUtils=var3360, java.util.Collection=var2247, r4=var2002, i0=var3967, $r5=var744, $r6=var3363, $r7=var3142, $r8=var1715, i1=var2357, r9=var3956, i3=var2456, org.ejml.simple.SimpleMatrix=var367, $r10=var1994}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 2,"<java.lang.String: java.lang.String trim()>": 1}
;stmts r0 := @parameter0: java.lang.String;	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	$r3 = staticinvoke <java.util.Arrays: java.util.List asList(java.lang.Object[])>($r1);	$r2 = staticinvoke <edu.stanford.nlp.neural.NeuralUtils$lambda_convertTextMatrix_0__282: java.util.function.Predicate bootstrap$()>();	r4 = staticinvoke <edu.stanford.nlp.util.CollectionUtils: java.util.List filterAsList(java.util.Collection,java.util.function.Predicate)>($r3, $r2);	i0 = interfaceinvoke r4.<java.util.List: int size()>();	$r5 = interfaceinvoke r4.<java.util.List: java.lang.Object get(int)>(0);	$r6 = (java.lang.String) $r5;	$r7 = virtualinvoke $r6.<java.lang.String: java.lang.String trim()>();	$r8 = virtualinvoke $r7.<java.lang.String: java.lang.String[] split(java.lang.String)>("\\s+");	i1 = lengthof $r8;	r9 = newmultiarray (double)[i0][i1];	i3 = 0;	if i3 >= i0 goto $r10 = new org.ejml.simple.SimpleMatrix;	$r10 = new org.ejml.simple.SimpleMatrix;	specialinvoke $r10.<org.ejml.simple.SimpleMatrix: void <init>(double[][])>(r9);	return $r10
;block_num 3
(get-model)
