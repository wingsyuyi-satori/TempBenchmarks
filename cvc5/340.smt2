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

(declare-sort var1528 0)
(declare-sort var2979 0)
(declare-sort var1529 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun commander/-2133873678 (var1528) var1529)
(declare-fun getColumnSize/-165698927 (var1529) Int)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-const null-var1528 var1528)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1630 var1528) ; Statement: r0 := @this: com.beust.jcommander.DefaultUsageFormatter 
(assert (not (= var1630 null-var1528)))
(declare-const var3618 String) ; Statement: r5 := @parameter0: java.lang.StringBuilder 
(assert (not (= var3618 null-String)))
(declare-const var1331 Int) ; Statement: i10 := @parameter1: int 
(assert (not (= var1331 null-Int)))
(declare-const var381 Int) ; Statement: i1 := @parameter2: int 
(assert (not (= var381 null-Int)))
(declare-const var931 String) ; Statement: r2 := @parameter3: java.lang.String 
(assert (not (= var931 null-String)))
(define-const var267 var1529 (commander/-2133873678 var1630)) ; Statement: $r1 = r0.<com.beust.jcommander.DefaultUsageFormatter: com.beust.jcommander.JCommander commander> 
(assert true)
(define-const var2422 Int (getColumnSize/-165698927 var267)) ; Statement: i0 = virtualinvoke $r1.<com.beust.jcommander.JCommander: int getColumnSize()>() 
; split operation: var229 = var931.split(" ") ; Statement: r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ") 
(define-const var1703 Int var381) ; Statement: i14 = i1 
(define-const var3343 Int 0) ; Statement: i15 = 0 
(assert true) ; Non Conditional
(define-const var247 Int (get_split_length var931 " " -1)) ; Statement: $i2 = lengthof r3 
 ; Statement: if i15 >= $i2 goto return 
(assert (not (>= var3343 var247))) ; Negate: Cond: i15 >= $i2  
(define-const var1595 String (get_split_element var931 " " -1 var3343)) ; Statement: r4 = r3[i15] 
(assert true)
(define-const var268 Int (length/-134980193 var1595)) ; Statement: $i3 = virtualinvoke r4.<java.lang.String: int length()>() 
 ; Statement: if $i3 > i0 goto virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(assert (> var268 var2422)) ; Cond: $i3 > i0 
(assert true)
;(assert (append/672562846 var3618 var1595)) ; Statement: virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4) 
(declare-const var3618!1 String)
(assert (= var3618!1 (str.++ var3618 var1595)))
(assert true)
(define-const var2211 Int (length/-134980193 var1595)) ; Statement: $i4 = virtualinvoke r4.<java.lang.String: int length()>() 
(define-const var3035 Int (+ var1703 var2211)) ; Statement: $i13 = i14 + $i4 
(define-const var1703!1 Int var3035) ; Statement: i14 = $i13 
(define-const var814 Int (get_split_length var931 " " -1)) ; Statement: $i5 = lengthof r3 
(define-const var881 Int (- var814 1)) ; Statement: $i6 = $i5 - 1 
 ; Statement: if i15 == $i6 goto i15 = i15 + 1 
(assert (= var3343 var881)) ; Cond: i15 == $i6 
(define-const var3343!1 Int (+ var3343 1)) ; Statement: i15 = i15 + 1 
 ; Statement: goto [?= $i2 = lengthof r3] 
(assert true) ; Non Conditional
(define-const var247!1 Int (get_split_length var931 " " -1)) ; Statement: $i2 = lengthof r3 
 ; Statement: if i15 >= $i2 goto return 
(assert (>= var3343!1 var247!1)) ; Cond: i15 >= $i2 
 ; Statement: return 
(check-sat)
; {commander/-2133873678=([com.beust.jcommander.DefaultUsageFormatter], com.beust.jcommander.JCommander), getColumnSize/-165698927=([com.beust.jcommander.JCommander], int), length/-134980193=([java.lang.String], int), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder)}
; {var1528=com.beust.jcommander.DefaultUsageFormatter, var1630=r0, var3618=r5, var1331=i10, var381=i1, var931=r2, var2979=null_type, var1529=com.beust.jcommander.JCommander, var267=$r1, var2422=i0, var229=r3, var1703=i14, var3343=i15, var247=$i2, var1595=r4, var268=$i3, var2211=$i4, var3035=$i13, var814=$i5, var881=$i6}
; {com.beust.jcommander.DefaultUsageFormatter=var1528, r0=var1630, r5=var3618, i10=var1331, i1=var381, r2=var931, null_type=var2979, com.beust.jcommander.JCommander=var1529, $r1=var267, i0=var2422, r3=var229, i14=var1703, i15=var3343, $i2=var247, r4=var1595, $i3=var268, $i4=var2211, $i13=var3035, $i5=var814, $i6=var881}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>;	<java.lang.String: int length()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.String: int length()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1,"<java.lang.String: int length()>": 2,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 1}
;stmts r0 := @this: com.beust.jcommander.DefaultUsageFormatter;	r5 := @parameter0: java.lang.StringBuilder;	i10 := @parameter1: int;	i1 := @parameter2: int;	r2 := @parameter3: java.lang.String;	$r1 = r0.<com.beust.jcommander.DefaultUsageFormatter: com.beust.jcommander.JCommander commander>;	i0 = virtualinvoke $r1.<com.beust.jcommander.JCommander: int getColumnSize()>();	r3 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String)>(" ");	i14 = i1;	i15 = 0;	$i2 = lengthof r3;	if i15 >= $i2 goto return;	r4 = r3[i15];	$i3 = virtualinvoke r4.<java.lang.String: int length()>();	if $i3 > i0 goto virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	virtualinvoke r5.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r4);	$i4 = virtualinvoke r4.<java.lang.String: int length()>();	$i13 = i14 + $i4;	i14 = $i13;	$i5 = lengthof r3;	$i6 = $i5 - 1;	if i15 == $i6 goto i15 = i15 + 1;	i15 = i15 + 1;	goto [?= $i2 = lengthof r3];	$i2 = lengthof r3;	if i15 >= $i2 goto return;	return
;block_num 7
(get-model)
