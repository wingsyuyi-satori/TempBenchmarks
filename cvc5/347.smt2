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

(declare-sort var3135 0)
(declare-sort var3284 0)
(declare-sort var28 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun commander/-2133873678 (var3135) var28)
(declare-fun getColumnSize/-165698927 (var28) Int)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-const null-var3135 var3135)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var3498 var3135) ; Statement: r0 := @this: com.beust.jcommander.DefaultUsageFormatter 
(assert (not (= var3498 null-var3135)))
(declare-const var2208 String) ; Statement: r5 := @parameter0: java.lang.StringBuilder 
(assert (not (= var2208 null-String)))
(declare-const var3405 Int) ; Statement: i10 := @parameter1: int 
(assert (not (= var3405 null-Int)))
(declare-const var1881 Int) ; Statement: i1 := @parameter2: int 
(assert (not (= var1881 null-Int)))
(declare-const var2549 String) ; Statement: r2 := @parameter3: java.lang.String 
(assert (not (= var2549 null-String)))
(define-const var2525 var28 (commander/-2133873678 var3498)) ; Statement: $r1 = r0.<com.beust.jcommander.DefaultUsageFormatter: com.beust.jcommander.JCommander commander> 
(assert true)
(define-const var653 Int (getColumnSize/-165698927 var2525)) ; Statement: i0 = virtualinvoke $r1.<com.beust.jcommander.JCommander: int getColumnSize()>() 
; split operation: var2153 = var2549.split(" ") ; Statement: r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ") 
(define-const var3076 Int var1881) ; Statement: i14 = i1 
(define-const var3246 Int 0) ; Statement: i15 = 0 
(assert true) ; Non Conditional
(define-const var2125 Int (get_split_length var2549 " " -1)) ; Statement: $i2 = lengthof r3 
 ; Statement: if i15 >= $i2 goto return 
(assert (not (>= var3246 var2125))) ; Negate: Cond: i15 >= $i2  
(define-const var3656 String (get_split_element var2549 " " -1 var3246)) ; Statement: r4 = r3[i15] 
(assert true)
(define-const var1943 Int (length/-134980193 var3656)) ; Statement: $i3 = virtualinvoke r4.<java.lang.String: int length()>() 
 ; Statement: if $i3 > i0 goto virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(assert (not (> var1943 var653))) ; Negate: Cond: $i3 > i0  
(define-const var992 Int (+ var3076 1)) ; Statement: $i8 = i14 + 1 
(assert true)
(define-const var325 Int (length/-134980193 var3656)) ; Statement: $i7 = virtualinvoke r4.<java.lang.String: int length()>() 
(define-const var203 Int (+ var992 var325)) ; Statement: $i9 = $i8 + $i7 
 ; Statement: if $i9 > i0 goto $r7 = virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n") 
(assert (not (> var203 var653))) ; Negate: Cond: $i9 > i0  
(assert true)
;(assert (append/672562846 var2208 var3656)) ; Statement: virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var2208!1 String)
(assert (= var2208!1 (str.++ var2208 var3656)))
(assert true)
(define-const var2753 Int (length/-134980193 var3656)) ; Statement: $i4 = virtualinvoke r4.<java.lang.String: int length()>() 
(define-const var367 Int (+ var3076 var2753)) ; Statement: $i13 = i14 + $i4 
(define-const var3076!1 Int var367) ; Statement: i14 = $i13 
(define-const var2971 Int (get_split_length var2549 " " -1)) ; Statement: $i5 = lengthof r3 
(define-const var533 Int (- var2971 1)) ; Statement: $i6 = $i5 - 1 
 ; Statement: if i15 == $i6 goto i15 = i15 + 1 
(assert (= var3246 var533)) ; Cond: i15 == $i6 
(define-const var3246!1 Int (+ var3246 1)) ; Statement: i15 = i15 + 1 
 ; Statement: goto [?= $i2 = lengthof r3] 
(assert true) ; Non Conditional
(define-const var2125!1 Int (get_split_length var2549 " " -1)) ; Statement: $i2 = lengthof r3 
 ; Statement: if i15 >= $i2 goto return 
(assert (>= var3246!1 var2125!1)) ; Cond: i15 >= $i2 
 ; Statement: return 
(check-sat)
; {commander/-2133873678=([com.beust.jcommander.DefaultUsageFormatter], com.beust.jcommander.JCommander), getColumnSize/-165698927=([com.beust.jcommander.JCommander], int), length/-134980193=([java.lang.String], int), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder)}
; {var3135=com.beust.jcommander.DefaultUsageFormatter, var3498=r0, var2208=r5, var3405=i10, var1881=i1, var2549=r2, var3284=null_type, var28=com.beust.jcommander.JCommander, var2525=$r1, var653=i0, var2153=r3, var3076=i14, var3246=i15, var2125=$i2, var3656=r4, var1943=$i3, var992=$i8, var325=$i7, var203=$i9, var2753=$i4, var367=$i13, var2971=$i5, var533=$i6}
; {com.beust.jcommander.DefaultUsageFormatter=var3135, r0=var3498, r5=var2208, i10=var3405, i1=var1881, r2=var2549, null_type=var3284, com.beust.jcommander.JCommander=var28, $r1=var2525, i0=var653, r3=var2153, i14=var3076, i15=var3246, $i2=var2125, r4=var3656, $i3=var1943, $i8=var992, $i7=var325, $i9=var203, $i4=var2753, $i13=var367, $i5=var2971, $i6=var533}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: int length()>;	<java.lang.String: int length()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: int length()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: int length()>": 3,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1}
;stmts r0 := @this: com.beust.jcommander.DefaultUsageFormatter;	r5 := @parameter0: java.lang.StringBuilder;	i10 := @parameter1: int;	i1 := @parameter2: int;	r2 := @parameter3: java.lang.String;	$r1 = r0.<com.beust.jcommander.DefaultUsageFormatter: com.beust.jcommander.JCommander commander>;	i0 = virtualinvoke $r1.<com.beust.jcommander.JCommander: int getColumnSize()>();	r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	i14 = i1;	i15 = 0;	$i2 = lengthof r3;	if i15 >= $i2 goto return;	r4 = r3[i15];	$i3 = virtualinvoke r4.<java.lang.String: int length()>();	if $i3 > i0 goto virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$i8 = i14 + 1;	$i7 = virtualinvoke r4.<java.lang.String: int length()>();	$i9 = $i8 + $i7;	if $i9 > i0 goto $r7 = virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\n");	virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$i4 = virtualinvoke r4.<java.lang.String: int length()>();	$i13 = i14 + $i4;	i14 = $i13;	$i5 = lengthof r3;	$i6 = $i5 - 1;	if i15 == $i6 goto i15 = i15 + 1;	i15 = i15 + 1;	goto [?= $i2 = lengthof r3];	$i2 = lengthof r3;	if i15 >= $i2 goto return;	return
;block_num 8
(get-model)
