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

(declare-sort var1923 0)
(declare-sort var420 0)
(declare-sort var423 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-fun var423_max/1360571700 (Int Int) Int)
(declare-fun arr-String-init () (Array Int String))
(declare-const null-var1923 var1923)
(declare-const null-String String)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var841 var1923) ; Statement: r9 := @this: org.jline.builtins.ScreenTerminal 
(assert (not (= var841 null-var1923)))
(declare-const var3243 String) ; Statement: r10 := @parameter0: java.lang.String 
(assert (not (= var3243 null-String)))
(declare-const var3242 (Array Int String)) ; Statement: r0 := @parameter1: java.lang.String[] 
(assert (not (= var3242 null-__Array__Int__String__)))
(define-const var1350 String "") ; Statement: r11 = "" 
(assert true)
(define-const var2207 Int (length/-134980193 var3243)) ; Statement: $i0 = virtualinvoke r10.<java.lang.String: int length()>() 
 ; Statement: if $i0 <= 0 goto $r12 = virtualinvoke r10.<java.lang.String: java.lang.String[] split(java.lang.String)>(";") 
(assert (<= var2207 0)) ; Cond: $i0 <= 0 
; split operation: var1338 = var3243.split(";") ; Statement: $r12 = virtualinvoke r10.<java.lang.String: java.lang.String[] split(java.lang.String)>(";") 
(define-const var766 Int (get_split_length var3243 ";" -1)) ; Statement: $i7 = lengthof $r12 
(define-const var2096 Int (getLength-Arr-String-1 var3242)) ; Statement: $i8 = lengthof r0 
(define-const var1242 Int (var423_max/1360571700 var766 var2096)) ; Statement: $i9 = staticinvoke <java.lang.Math: int max(int,int)>($i7, $i8) 
(define-const var1256 (Array Int String) arr-String-init) ; Statement: $r13 = newarray (java.lang.String)[$i9] 
(define-const var3036 Int 0) ; Statement: i10 = 0 
(assert true) ; Non Conditional
 ; Statement: if i10 >= $i9 goto return $r13 
(assert (>= var3036 var1242)) ; Cond: i10 >= $i9 
 ; Statement: return $r13 
(check-sat)
; {length/-134980193=([java.lang.String], int), getLength-Arr-String-1=([java.lang.String[]], int), var423_max/1360571700=([int, int], int), arr-String-init=([], java.lang.String[])}
; {var1923=org.jline.builtins.ScreenTerminal, var841=r9, var3243=r10, var420=null_type, var3242=r0, var1350=r11, var2207=$i0, var1338=$r12, var766=$i7, var2096=$i8, var423=java.lang.Math, var1242=$i9, var1256=$r13, var3036=i10}
; {org.jline.builtins.ScreenTerminal=var1923, r9=var841, r10=var3243, null_type=var420, r0=var3242, r11=var1350, $i0=var2207, $r12=var1338, $i7=var766, $i8=var2096, java.lang.Math=var423, $i9=var1242, $r13=var1256, i10=var3036}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r9 := @this: org.jline.builtins.ScreenTerminal;	r10 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.String[];	r11 = "";	$i0 = virtualinvoke r10.<java.lang.String: int length()>();	if $i0 <= 0 goto $r12 = virtualinvoke r10.<java.lang.String: java.lang.String[] split(java.lang.String)>(";");	$r12 = virtualinvoke r10.<java.lang.String: java.lang.String[] split(java.lang.String)>(";");	$i7 = lengthof $r12;	$i8 = lengthof r0;	$i9 = staticinvoke <java.lang.Math: int max(int,int)>($i7, $i8);	$r13 = newarray (java.lang.String)[$i9];	i10 = 0;	if i10 >= $i9 goto return $r13;	return $r13
;block_num 4
(get-model)
