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

(declare-sort var2124 0)
(declare-sort var3026 0)
(declare-sort var327 0)
(declare-sort var1005 0)
(declare-sort var3933 0)
(declare-sort var1164 0)
(declare-sort var1810 0)
(declare-sort var1496 0)
(declare-sort var80 0)
(declare-sort var2633 0)
(declare-sort var3286 0)
(declare-sort var2924 0)
(declare-sort var2867 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getLocation/-2100520407 (var327) var3933)
(declare-fun x/-2076290636 (var3933) Int)
(declare-fun cast-from-Int-to-Float64 (Int) Float64)
(declare-fun getWidth/489074803 (var327) Float64)
(declare-fun cast-from-Float64-to-Int (Float64) Int)
(declare-fun y/-2076290636 (var3933) Int)
(declare-fun getHeight/714790842 (var327) Float64)
(declare-fun this$1/-329981954 (var2124) var1164)
(declare-fun this$0/1045148940 (var1164) var1810)
(declare-fun var1810_access$300/-62264586 (var1810) var1496)
(declare-fun var80_makePair/452216261 (var1005 var1005) var80)
(declare-fun get/791961573 (var1496 var1005) var1005)
(declare-fun cast-from-var80-to-var1005 (var80) var1005)
(declare-fun cast-from-var1005-to-Int (var1005) Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun toString/-522406933 (var1005) String)
(declare-fun append/-1031950772 (String var1005) String)
(declare-fun cast-from-Int-to-var1005 (Int) var1005)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun getFont/-1191561058 (var3286) var2633)
(declare-fun cast-from-var3026-to-var3286 (var3026) var3286)
(declare-fun getSize/1707555820 (var2633) Int)
(declare-fun cast-from-Int-to-Float32 (Int) Float32)
(declare-fun deriveFont/-816435095 (var2633 Float32) var2633)
(declare-fun setFont/-1113720754 (var3286 var2633) void)
(declare-fun setColor/1206064488 (var3286 var2924) void)
(declare-fun fill/1396239382 (var3026 var2867) void)
(declare-fun cast-from-var327-to-var2867 (var327) var2867)
(declare-const null-var2124 var2124)
(declare-const null-var3026 var3026)
(declare-const null-var327 var327)
(declare-const null-var1005 var1005)
(declare-const null-Int Int)
(declare-const var2924-WHITE var2924)
(declare-const var2924-BLACK var2924)
(declare-const var2113 var2124) ; Statement: r3 := @this: edu.stanford.nlp.util.ConfusionMatrix$ConfusionGrid$Grid 
(assert (not (= var2113 null-var2124)))
(declare-const var313 var3026) ; Statement: r20 := @parameter0: java.awt.Graphics2D 
(assert (not (= var313 null-var3026)))
(declare-const var2539 var327) ; Statement: r0 := @parameter1: java.awt.Rectangle 
(assert (not (= var2539 null-var327)))
(declare-const var1270 var1005) ; Statement: r6 := @parameter2: java.lang.Object 
(assert (not (= var1270 null-var1005)))
(declare-const var3745 var1005) ; Statement: r7 := @parameter3: java.lang.Object 
(assert (not (= var3745 null-var1005)))
(assert true)
(define-const var2066 var3933 (getLocation/-2100520407 var2539)) ; Statement: $r1 = virtualinvoke r0.<java.awt.Rectangle: java.awt.Point getLocation()>() 
(define-const var509 Int (x/-2076290636 var2066)) ; Statement: $i0 = $r1.<java.awt.Point: int x> 
(define-const var303 Float64 (cast-from-Int-to-Float64 var509)) ; Statement: $d2 = (double) $i0 
(assert true)
(define-const var3705 Float64 (getWidth/489074803 var2539)) ; Statement: $d0 = virtualinvoke r0.<java.awt.Rectangle: double getWidth()>() 
(define-const var2684 Float64 (fp.div roundNearestTiesToEven var3705 ((_ to_fp 11 53) #x4014000000000000))) ; Statement: $d1 = $d0 / 5.0 
(define-const var2928 Float64 (fp.add roundNearestTiesToEven var303 var2684)) ; Statement: $d3 = $d2 + $d1 
(define-const var1233 Int (cast-from-Float64-to-Int var2928)) ; Statement: i1 = (int) $d3 
(assert true)
(define-const var418 var3933 (getLocation/-2100520407 var2539)) ; Statement: $r2 = virtualinvoke r0.<java.awt.Rectangle: java.awt.Point getLocation()>() 
(define-const var2548 Int (y/-2076290636 var418)) ; Statement: $i2 = $r2.<java.awt.Point: int y> 
(define-const var503 Float64 (cast-from-Int-to-Float64 var2548)) ; Statement: $d6 = (double) $i2 
(assert true)
(define-const var1118 Float64 (getHeight/714790842 var2539)) ; Statement: $d4 = virtualinvoke r0.<java.awt.Rectangle: double getHeight()>() 
(define-const var2509 Float64 (fp.div roundNearestTiesToEven var1118 ((_ to_fp 11 53) #x4014000000000000))) ; Statement: $d5 = $d4 / 5.0 
(define-const var528 Float64 (fp.add roundNearestTiesToEven var503 var2509)) ; Statement: $d7 = $d6 + $d5 
(define-const var498 Int (cast-from-Float64-to-Int var528)) ; Statement: i7 = (int) $d7 
(define-const var2137 var1164 (this$1/-329981954 var2113)) ; Statement: $r4 = r3.<edu.stanford.nlp.util.ConfusionMatrix$ConfusionGrid$Grid: edu.stanford.nlp.util.ConfusionMatrix$ConfusionGrid this$1> 
(define-const var1046 var1810 (this$0/1045148940 var2137)) ; Statement: $r5 = $r4.<edu.stanford.nlp.util.ConfusionMatrix$ConfusionGrid: edu.stanford.nlp.util.ConfusionMatrix this$0> 
(define-const var1388 var1496 (var1810_access$300/-62264586 var1046)) ; Statement: $r9 = staticinvoke <edu.stanford.nlp.util.ConfusionMatrix: java.util.concurrent.ConcurrentHashMap access$300(edu.stanford.nlp.util.ConfusionMatrix)>($r5) 
(define-const var707 var80 (var80_makePair/452216261 var1270 var3745)) ; Statement: $r8 = staticinvoke <edu.stanford.nlp.util.Pair: edu.stanford.nlp.util.Pair makePair(java.lang.Object,java.lang.Object)>(r6, r7) 
(assert true)
(define-const var1221 var1005 (get/791961573 var1388 (cast-from-var80-to-var1005 var707))) ; Statement: $r10 = virtualinvoke $r9.<java.util.concurrent.ConcurrentHashMap: java.lang.Object get(java.lang.Object)>($r8) 
(define-const var2897 Int (cast-from-var1005-to-Int var1221)) ; Statement: r29 = (java.lang.Integer) $r10 
 ; Statement: if r29 != null goto $r11 = new java.lang.StringBuilder 
(assert (not (= var2897 null-Int))) ; Cond: r29 != null 
(define-const var1656 String String-init) ; Statement: $r11 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var1656)) ; Statement: specialinvoke $r11.<java.lang.StringBuilder: void <init>()>() 
(declare-const var1656!1 String)
(assert (= var1656!1 ""))
(assert true)
(define-const var2056 String (append/672562846 var1656!1 "Guess: ")) ; Statement: $r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Guess: ") 
(declare-const var1656!2 String)
(assert (= var1656!2 (str.++ var1656!1 "Guess: ")))
(assert true)
(define-const var3080 String (toString/-522406933 var1270)) ; Statement: $r12 = virtualinvoke r6.<java.lang.Object: java.lang.String toString()>() 
(assert true)
(define-const var3906 String (append/672562846 var2056 var3080)) ; Statement: $r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12) 
(declare-const var2056!1 String)
(assert (= var2056!1 (str.++ var2056 var3080)))
(assert true)
(define-const var579 String (append/672562846 var3906 "\nGold: ")) ; Statement: $r16 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\nGold: ") 
(declare-const var3906!1 String)
(assert (= var3906!1 (str.++ var3906 "\nGold: ")))
(assert true)
(define-const var2855 String (toString/-522406933 var3745)) ; Statement: $r15 = virtualinvoke r7.<java.lang.Object: java.lang.String toString()>() 
(assert true)
(define-const var2681 String (append/672562846 var579 var2855)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15) 
(declare-const var579!1 String)
(assert (= var579!1 (str.++ var579 var2855)))
(assert true)
(define-const var1919 String (append/672562846 var2681 "\nValue: ")) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\nValue: ") 
(declare-const var2681!1 String)
(assert (= var2681!1 (str.++ var2681 "\nValue: ")))
(assert true)
(define-const var2921 String (append/-1031950772 var1919 (cast-from-Int-to-var1005 var2897))) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r29) 
(declare-const var1919!1 String)
(assert (str.prefixof var1919 var1919!1))
(assert true)
(define-const var2043 String (toString/-2075883882 var2921)) ; Statement: $r26 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
(define-const var2988 var2633 (getFont/-1191561058 (cast-from-var3026-to-var3286 var313))) ; Statement: $r27 = virtualinvoke r20.<java.awt.Graphics2D: java.awt.Font getFont()>() 
(assert true)
(define-const var1560 Int (getSize/1707555820 var2988)) ; Statement: $i3 = virtualinvoke $r27.<java.awt.Font: int getSize()>() 
(define-const var1353 Float32 (cast-from-Int-to-Float32 var1560)) ; Statement: $f0 = (float) $i3 
(define-const var3425 Float32 (fp.mul roundNearestTiesToEven var1353 ((_ to_fp 8 24) #x40000000))) ; Statement: $f1 = $f0 * 2.0F 
(assert true)
(define-const var1542 var2633 (deriveFont/-816435095 var2988 var3425)) ; Statement: $r21 = virtualinvoke $r27.<java.awt.Font: java.awt.Font deriveFont(float)>($f1) 
(assert true)
;(assert (setFont/-1113720754 (cast-from-var3026-to-var3286 var313) var1542)) ; Statement: virtualinvoke r20.<java.awt.Graphics2D: void setFont(java.awt.Font)>($r21) 

(declare-const var313!1 var3026)
(declare-const var1542!1 var2633)
(define-const var864 var2924 var2924-WHITE) ; Statement: $r22 = <java.awt.Color: java.awt.Color WHITE> 
(assert true)
;(assert (setColor/1206064488 (cast-from-var3026-to-var3286 var313!1) var864)) ; Statement: virtualinvoke r20.<java.awt.Graphics2D: void setColor(java.awt.Color)>($r22) 

(declare-const var313!2 var3026)
(declare-const var864!1 var2924)
(assert true)
;(assert (fill/1396239382 var313!2 (cast-from-var327-to-var2867 var2539))) ; Statement: virtualinvoke r20.<java.awt.Graphics2D: void fill(java.awt.Shape)>(r0) 

(declare-const var313!3 var3026)
(declare-const var2539!1 var327)
(define-const var2843 var2924 var2924-BLACK) ; Statement: $r23 = <java.awt.Color: java.awt.Color BLACK> 
(assert true)
;(assert (setColor/1206064488 (cast-from-var3026-to-var3286 var313!3) var2843)) ; Statement: virtualinvoke r20.<java.awt.Graphics2D: void setColor(java.awt.Color)>($r23) 

(declare-const var313!4 var3026)
(declare-const var2843!1 var2924)
; split operation: var3522 = var2043.split("\n") ; Statement: $r28 = virtualinvoke $r26.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(define-const var1596 Int (get_split_length var2043 "\n" -1)) ; Statement: $i6 = lengthof $r28 
(define-const var888 Int 0) ; Statement: i8 = 0 
(assert true) ; Non Conditional
 ; Statement: if i8 >= $i6 goto virtualinvoke r20.<java.awt.Graphics2D: void setFont(java.awt.Font)>($r27) 
(assert (>= var888 var1596)) ; Cond: i8 >= $i6 
(assert true)
;(assert (setFont/-1113720754 (cast-from-var3026-to-var3286 var313!4) var2988)) ; Statement: virtualinvoke r20.<java.awt.Graphics2D: void setFont(java.awt.Font)>($r27) 

(declare-const var313!5 var3026)
(declare-const var2988!1 var2633)
 ; Statement: return 
(check-sat)
; {getLocation/-2100520407=([java.awt.Rectangle], java.awt.Point), x/-2076290636=([java.awt.Point], int), cast-from-Int-to-Float64=([int], double), getWidth/489074803=([java.awt.Rectangle], double), cast-from-Float64-to-Int=([double], int), y/-2076290636=([java.awt.Point], int), getHeight/714790842=([java.awt.Rectangle], double), this$1/-329981954=([edu.stanford.nlp.util.ConfusionMatrix$ConfusionGrid$Grid], edu.stanford.nlp.util.ConfusionMatrix$ConfusionGrid), this$0/1045148940=([edu.stanford.nlp.util.ConfusionMatrix$ConfusionGrid], edu.stanford.nlp.util.ConfusionMatrix), var1810_access$300/-62264586=([edu.stanford.nlp.util.ConfusionMatrix], java.util.concurrent.ConcurrentHashMap), var80_makePair/452216261=([java.lang.Object, java.lang.Object], edu.stanford.nlp.util.Pair), get/791961573=([java.util.concurrent.ConcurrentHashMap, java.lang.Object], java.lang.Object), cast-from-var80-to-var1005=([edu.stanford.nlp.util.Pair], java.lang.Object), cast-from-var1005-to-Int=([java.lang.Object], java.lang.Integer), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-522406933=([java.lang.Object], java.lang.String), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-Int-to-var1005=([java.lang.Integer], java.lang.Object), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), getFont/-1191561058=([java.awt.Graphics], java.awt.Font), cast-from-var3026-to-var3286=([java.awt.Graphics2D], java.awt.Graphics), getSize/1707555820=([java.awt.Font], int), cast-from-Int-to-Float32=([int], float), deriveFont/-816435095=([java.awt.Font, float], java.awt.Font), setFont/-1113720754=([java.awt.Graphics, java.awt.Font], void), setColor/1206064488=([java.awt.Graphics, java.awt.Color], void), fill/1396239382=([java.awt.Graphics2D, java.awt.Shape], void), cast-from-var327-to-var2867=([java.awt.Rectangle], java.awt.Shape)}
; {var2124=edu.stanford.nlp.util.ConfusionMatrix$ConfusionGrid$Grid, var2113=r3, var3026=java.awt.Graphics2D, var313=r20, var327=java.awt.Rectangle, var2539=r0, var1005=java.lang.Object, var1270=r6, var3745=r7, var3933=java.awt.Point, var2066=$r1, var509=$i0, var303=$d2, var3705=$d0, var2684=$d1, var2928=$d3, var1233=i1, var418=$r2, var2548=$i2, var503=$d6, var1118=$d4, var2509=$d5, var528=$d7, var498=i7, var1164=edu.stanford.nlp.util.ConfusionMatrix$ConfusionGrid, var2137=$r4, var1810=edu.stanford.nlp.util.ConfusionMatrix, var1046=$r5, var1496=java.util.concurrent.ConcurrentHashMap, var1388=$r9, var80=edu.stanford.nlp.util.Pair, var707=$r8, var1221=$r10, var2897=r29, var1656=$r11, var2056=$r13, var3080=$r12, var3906=$r14, var579=$r16, var2855=$r15, var2681=$r17, var1919=$r18, var2921=$r19, var2043=$r26, var2633=java.awt.Font, var3286=java.awt.Graphics, var2988=$r27, var1560=$i3, var1353=$f0, var3425=$f1, var1542=$r21, var2924=java.awt.Color, var864=$r22, var2867=java.awt.Shape, var2843=$r23, var3522=$r28, var1596=$i6, var888=i8}
; {edu.stanford.nlp.util.ConfusionMatrix$ConfusionGrid$Grid=var2124, r3=var2113, java.awt.Graphics2D=var3026, r20=var313, java.awt.Rectangle=var327, r0=var2539, java.lang.Object=var1005, r6=var1270, r7=var3745, java.awt.Point=var3933, $r1=var2066, $i0=var509, $d2=var303, $d0=var3705, $d1=var2684, $d3=var2928, i1=var1233, $r2=var418, $i2=var2548, $d6=var503, $d4=var1118, $d5=var2509, $d7=var528, i7=var498, edu.stanford.nlp.util.ConfusionMatrix$ConfusionGrid=var1164, $r4=var2137, edu.stanford.nlp.util.ConfusionMatrix=var1810, $r5=var1046, java.util.concurrent.ConcurrentHashMap=var1496, $r9=var1388, edu.stanford.nlp.util.Pair=var80, $r8=var707, $r10=var1221, r29=var2897, $r11=var1656, $r13=var2056, $r12=var3080, $r14=var3906, $r16=var579, $r15=var2855, $r17=var2681, $r18=var1919, $r19=var2921, $r26=var2043, java.awt.Font=var2633, java.awt.Graphics=var3286, $r27=var2988, $i3=var1560, $f0=var1353, $f1=var3425, $r21=var1542, java.awt.Color=var2924, $r22=var864, java.awt.Shape=var2867, $r23=var2843, $r28=var3522, $i6=var1596, i8=var888}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.Object: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.Object: java.lang.String toString()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.String toString()>;	<java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1,"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r3 := @this: edu.stanford.nlp.util.ConfusionMatrix$ConfusionGrid$Grid;	r20 := @parameter0: java.awt.Graphics2D;	r0 := @parameter1: java.awt.Rectangle;	r6 := @parameter2: java.lang.Object;	r7 := @parameter3: java.lang.Object;	$r1 = virtualinvoke r0.<java.awt.Rectangle: java.awt.Point getLocation()>();	$i0 = $r1.<java.awt.Point: int x>;	$d2 = (double) $i0;	$d0 = virtualinvoke r0.<java.awt.Rectangle: double getWidth()>();	$d1 = $d0 / 5.0;	$d3 = $d2 + $d1;	i1 = (int) $d3;	$r2 = virtualinvoke r0.<java.awt.Rectangle: java.awt.Point getLocation()>();	$i2 = $r2.<java.awt.Point: int y>;	$d6 = (double) $i2;	$d4 = virtualinvoke r0.<java.awt.Rectangle: double getHeight()>();	$d5 = $d4 / 5.0;	$d7 = $d6 + $d5;	i7 = (int) $d7;	$r4 = r3.<edu.stanford.nlp.util.ConfusionMatrix$ConfusionGrid$Grid: edu.stanford.nlp.util.ConfusionMatrix$ConfusionGrid this$1>;	$r5 = $r4.<edu.stanford.nlp.util.ConfusionMatrix$ConfusionGrid: edu.stanford.nlp.util.ConfusionMatrix this$0>;	$r9 = staticinvoke <edu.stanford.nlp.util.ConfusionMatrix: java.util.concurrent.ConcurrentHashMap access$300(edu.stanford.nlp.util.ConfusionMatrix)>($r5);	$r8 = staticinvoke <edu.stanford.nlp.util.Pair: edu.stanford.nlp.util.Pair makePair(java.lang.Object,java.lang.Object)>(r6, r7);	$r10 = virtualinvoke $r9.<java.util.concurrent.ConcurrentHashMap: java.lang.Object get(java.lang.Object)>($r8);	r29 = (java.lang.Integer) $r10;	if r29 != null goto $r11 = new java.lang.StringBuilder;	$r11 = new java.lang.StringBuilder;	specialinvoke $r11.<java.lang.StringBuilder: void <init>()>();	$r13 = virtualinvoke $r11.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Guess: ");	$r12 = virtualinvoke r6.<java.lang.Object: java.lang.String toString()>();	$r14 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r12);	$r16 = virtualinvoke $r14.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\nGold: ");	$r15 = virtualinvoke r7.<java.lang.Object: java.lang.String toString()>();	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r15);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("\nValue: ");	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>(r29);	$r26 = virtualinvoke $r19.<java.lang.StringBuilder: java.lang.String toString()>();	$r27 = virtualinvoke r20.<java.awt.Graphics2D: java.awt.Font getFont()>();	$i3 = virtualinvoke $r27.<java.awt.Font: int getSize()>();	$f0 = (float) $i3;	$f1 = $f0 * 2.0F;	$r21 = virtualinvoke $r27.<java.awt.Font: java.awt.Font deriveFont(float)>($f1);	virtualinvoke r20.<java.awt.Graphics2D: void setFont(java.awt.Font)>($r21);	$r22 = <java.awt.Color: java.awt.Color WHITE>;	virtualinvoke r20.<java.awt.Graphics2D: void setColor(java.awt.Color)>($r22);	virtualinvoke r20.<java.awt.Graphics2D: void fill(java.awt.Shape)>(r0);	$r23 = <java.awt.Color: java.awt.Color BLACK>;	virtualinvoke r20.<java.awt.Graphics2D: void setColor(java.awt.Color)>($r23);	$r28 = virtualinvoke $r26.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	$i6 = lengthof $r28;	i8 = 0;	if i8 >= $i6 goto virtualinvoke r20.<java.awt.Graphics2D: void setFont(java.awt.Font)>($r27);	virtualinvoke r20.<java.awt.Graphics2D: void setFont(java.awt.Font)>($r27);	return
;block_num 4
(get-model)
