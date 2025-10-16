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

(declare-sort var1902 0)
(declare-sort var2060 0)
(declare-sort var198 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(declare-fun var198_max/1360571700 (Int Int) Int)
(declare-fun arr-Int-init () (Array Int Int))
(declare-const null-var1902 var1902)
(declare-const null-String String)
(declare-const null-__Array__Int__Int__ (Array Int Int))
(declare-const var1372 var1902) ; Statement: r7 := @this: org.jline.builtins.ScreenTerminal 
(assert (not (= var1372 null-var1902)))
(declare-const var921 String) ; Statement: r8 := @parameter0: java.lang.String 
(assert (not (= var921 null-String)))
(declare-const var3653 (Array Int Int)) ; Statement: r0 := @parameter1: int[] 
(assert (not (= var3653 null-__Array__Int__Int__)))
(define-const var2813 String "") ; Statement: r9 = "" 
 ; Statement: if r8 != null goto $r10 = r8 
(assert (not (= var921 null-String))) ; Cond: r8 != null 
(define-const var3463 String var921) ; Statement: $r10 = r8 
(assert true) ; Non Conditional
(define-const var853 String var3463) ; Statement: r11 = $r10 
(assert true)
(define-const var834 Int (length/-134980193 var3463)) ; Statement: $i0 = virtualinvoke $r10.<java.lang.String: int length()>() 
 ; Statement: if $i0 <= 0 goto $r12 = virtualinvoke r11.<java.lang.String: java.lang.String[] split(java.lang.String)>(";") 
(assert (<= var834 0)) ; Cond: $i0 <= 0 
; split operation: var3749 = var853.split(";") ; Statement: $r12 = virtualinvoke r11.<java.lang.String: java.lang.String[] split(java.lang.String)>(";") 
(define-const var2306 Int (get_split_length var853 ";" -1)) ; Statement: $i8 = lengthof $r12 
(define-const var1685 Int (getLength-Arr-Int-1 var3653)) ; Statement: $i9 = lengthof r0 
(define-const var2908 Int (var198_max/1360571700 var2306 var1685)) ; Statement: $i10 = staticinvoke <java.lang.Math: int max(int,int)>($i8, $i9) 
(define-const var3451 (Array Int Int) arr-Int-init) ; Statement: $r13 = newarray (int)[$i10] 
(define-const var3519 Int 0) ; Statement: i11 = 0 
(assert true) ; Non Conditional
 ; Statement: if i11 >= $i10 goto return $r13 
(assert (>= var3519 var2908)) ; Cond: i11 >= $i10 
 ; Statement: return $r13 
(check-sat)
; {length/-134980193=([java.lang.String], int), getLength-Arr-Int-1=([int[]], int), var198_max/1360571700=([int, int], int), arr-Int-init=([], int[])}
; {var1902=org.jline.builtins.ScreenTerminal, var1372=r7, var921=r8, var2060=null_type, var3653=r0, var2813=r9, var3463=$r10, var853=r11, var834=$i0, var3749=$r12, var2306=$i8, var1685=$i9, var198=java.lang.Math, var2908=$i10, var3451=$r13, var3519=i11}
; {org.jline.builtins.ScreenTerminal=var1902, r7=var1372, r8=var921, null_type=var2060, r0=var3653, r9=var2813, $r10=var3463, r11=var853, $i0=var834, $r12=var3749, $i8=var2306, $i9=var1685, java.lang.Math=var198, $i10=var2908, $r13=var3451, i11=var3519}
;seq <java.lang.String: int length()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: int length()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r7 := @this: org.jline.builtins.ScreenTerminal;	r8 := @parameter0: java.lang.String;	r0 := @parameter1: int[];	r9 = "";	if r8 != null goto $r10 = r8;	$r10 = r8;	r11 = $r10;	$i0 = virtualinvoke $r10.<java.lang.String: int length()>();	if $i0 <= 0 goto $r12 = virtualinvoke r11.<java.lang.String: java.lang.String[] split(java.lang.String)>(";");	$r12 = virtualinvoke r11.<java.lang.String: java.lang.String[] split(java.lang.String)>(";");	$i8 = lengthof $r12;	$i9 = lengthof r0;	$i10 = staticinvoke <java.lang.Math: int max(int,int)>($i8, $i9);	$r13 = newarray (int)[$i10];	i11 = 0;	if i11 >= $i10 goto return $r13;	return $r13
;block_num 6
(get-model)
