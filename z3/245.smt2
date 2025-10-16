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

(declare-sort var544 0)
(declare-sort var2706 0)
(declare-sort var25 0)
(declare-sort var3353 0)
(declare-sort var2420 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun evalValueList/1368122213 (var544) var3353)
(declare-fun is/1027769019 (var3353) Bool)
(declare-fun separator/1368122213 (var544) var2420)
(declare-fun get/637268509 (var2420) String)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun arr-__Array__Int__String__-init () (Array Int (Array Int String)))
(declare-const null-var544 var544)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-var25 var25)
(declare-const var2068 var544) ; Statement: r0 := @this: javax0.jamal.builtins.ForState 
(assert (not (= var2068 null-var544)))
(declare-const var3668 String) ; Statement: r17 := @parameter0: java.lang.String 
(assert (not (= var3668 null-String)))
(declare-const var1694 (Array Int String)) ; Statement: r6 := @parameter1: java.lang.String[] 
(assert (not (= var1694 null-__Array__Int__String__)))
(declare-const var2720 var25) ; Statement: r13 := @parameter2: javax0.jamal.api.Position 
(assert (not (= var2720 null-var25)))
(define-const var453 var3353 (evalValueList/1368122213 var2068)) ; Statement: $r1 = r0.<javax0.jamal.builtins.ForState: javax0.jamal.tools.param.BooleanParameter evalValueList> 
(assert true)
(define-const var784 Bool (is/1027769019 var453)) ; Statement: $z0 = virtualinvoke $r1.<javax0.jamal.tools.param.BooleanParameter: boolean is()>() 
 ; Statement: if $z0 == 0 goto $r19 = r0.<javax0.jamal.builtins.ForState: javax0.jamal.tools.param.StringParameter separator> 
(assert (= (ite var784 1 0) 0)) ; Cond: $z0 == 0 
(define-const var3683 var2420 (separator/1368122213 var2068)) ; Statement: $r19 = r0.<javax0.jamal.builtins.ForState: javax0.jamal.tools.param.StringParameter separator> 
(assert true)
(define-const var2112 String (get/637268509 var3683)) ; Statement: $r20 = virtualinvoke $r19.<javax0.jamal.tools.param.StringParameter: java.lang.String get()>() 
(define-const var3922 Int (cast-from-Int-to-Int -1)) ; Statement: $i8 = (int) -1 
; split operation: var1194 = var3668.split(var2112, var3922) ; Statement: $r21 = virtualinvoke r17.<java.lang.String: java.lang.String[] split(java.lang.String,int)>($r20, $i8) 
(define-const var3479 Int (get_split_length var3668 var2112 var3922)) ; Statement: $i3 = lengthof $r21 
(define-const var1184 (Array Int (Array Int String)) arr-__Array__Int__String__-init) ; Statement: $r22 = newarray (java.lang.String[])[$i3] 
(define-const var855 Int 0) ; Statement: i4 = 0 
(assert true) ; Non Conditional
(define-const var2262 Int (get_split_length var3668 var2112 var3922)) ; Statement: $i5 = lengthof $r21 
 ; Statement: if i4 >= $i5 goto return $r22 
(assert (>= var855 var2262)) ; Cond: i4 >= $i5 
 ; Statement: return $r22 
(check-sat)
; {evalValueList/1368122213=([javax0.jamal.builtins.ForState], javax0.jamal.tools.param.BooleanParameter), is/1027769019=([javax0.jamal.tools.param.BooleanParameter], boolean), separator/1368122213=([javax0.jamal.builtins.ForState], javax0.jamal.tools.param.StringParameter), get/637268509=([javax0.jamal.tools.param.StringParameter], java.lang.String), cast-from-Int-to-Int=([int], int), arr-__Array__Int__String__-init=([], java.lang.String[][])}
; {var544=javax0.jamal.builtins.ForState, var2068=r0, var3668=r17, var2706=null_type, var1694=r6, var25=javax0.jamal.api.Position, var2720=r13, var3353=javax0.jamal.tools.param.BooleanParameter, var453=$r1, var784=$z0, var2420=javax0.jamal.tools.param.StringParameter, var3683=$r19, var2112=$r20, var3922=$i8, var1194=$r21, var3479=$i3, var1184=$r22, var855=i4, var2262=$i5}
; {javax0.jamal.builtins.ForState=var544, r0=var2068, r17=var3668, null_type=var2706, r6=var1694, javax0.jamal.api.Position=var25, r13=var2720, javax0.jamal.tools.param.BooleanParameter=var3353, $r1=var453, $z0=var784, javax0.jamal.tools.param.StringParameter=var2420, $r19=var3683, $r20=var2112, $i8=var3922, $r21=var1194, $i3=var3479, $r22=var1184, i4=var855, $i5=var2262}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1}
;stmts r0 := @this: javax0.jamal.builtins.ForState;	r17 := @parameter0: java.lang.String;	r6 := @parameter1: java.lang.String[];	r13 := @parameter2: javax0.jamal.api.Position;	$r1 = r0.<javax0.jamal.builtins.ForState: javax0.jamal.tools.param.BooleanParameter evalValueList>;	$z0 = virtualinvoke $r1.<javax0.jamal.tools.param.BooleanParameter: boolean is()>();	if $z0 == 0 goto $r19 = r0.<javax0.jamal.builtins.ForState: javax0.jamal.tools.param.StringParameter separator>;	$r19 = r0.<javax0.jamal.builtins.ForState: javax0.jamal.tools.param.StringParameter separator>;	$r20 = virtualinvoke $r19.<javax0.jamal.tools.param.StringParameter: java.lang.String get()>();	$i8 = (int) -1;	$r21 = virtualinvoke r17.<java.lang.String: java.lang.String[] split(java.lang.String,int)>($r20, $i8);	$i3 = lengthof $r21;	$r22 = newarray (java.lang.String[])[$i3];	i4 = 0;	$i5 = lengthof $r21;	if i4 >= $i5 goto return $r22;	return $r22
;block_num 4
(get-model)
