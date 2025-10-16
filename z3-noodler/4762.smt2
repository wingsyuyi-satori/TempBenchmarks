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

(declare-sort var1635 0)
(declare-sort var1267 0)
(declare-sort var66 0)
(declare-sort var2996 0)
(declare-sort var3923 0)
(declare-sort var1585 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun isLoggable/-616065502 (var2996 var3923) Bool)
(define-fun is-whitespace ((char String)) Bool (< (str.to_code char) 33))
(define-fun-rec trim-left ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s 0 1)) (trim-left (str.substr s 1 (- (str.len s) 1))) s)))
(define-fun-rec trim-right ((s String)) String (ite (= s "") "" (ite (is-whitespace (str.substr s (- (str.len s) 1) 1)) (trim-right (str.substr s 0 (- (str.len s) 1))) s)))
(define-fun trim/-847153721 ((s String)) String (trim-right (trim-left s)))
(declare-fun toLowerCase/1946809429 (String var1585) String)
(declare-fun hashCode/-467973558 (String) Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun warning/-1321853967 (var2996 String) void)
(declare-const null-var1635 var1635)
(declare-const null-var1267 var1267)
(declare-const null-String String)
(declare-const var1635-log var2996)
(declare-const var3923-FINEST var3923)
(declare-const var1585-US var1585)
(declare-const var2522 var1635) ; Statement: r41 := @this: org.jline.utils.StyleResolver 
(assert (not (= var2522 null-var1635)))
(declare-const var2804 var1267) ; Statement: r6 := @parameter0: org.jline.utils.AttributedStyle 
(assert (not (= var2804 null-var1267)))
(declare-const var189 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var189 null-String)))
(define-const var102 var2996 var1635-log) ; Statement: $r1 = <org.jline.utils.StyleResolver: java.util.logging.Logger log> 
(define-const var310 var3923 var3923-FINEST) ; Statement: $r0 = <java.util.logging.Level: java.util.logging.Level FINEST> 
(assert true)
(define-const var554 Bool (isLoggable/-616065502 var102 var310)) ; Statement: $z0 = virtualinvoke $r1.<java.util.logging.Logger: boolean isLoggable(java.util.logging.Level)>($r0) 
 ; Statement: if $z0 == 0 goto $r37 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", 2) 
(assert (= (ite var554 1 0) 0)) ; Cond: $z0 == 0 
; split operation: var2956 = var189.split(":", 2) ; Statement: $r37 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", 2) 
(define-const var335 String (get_split_element var189 ":" 2 0)) ; Statement: $r3 = $r37[0] 
(assert true)
(define-const var1548 String (trim/-847153721 var335)) ; Statement: $r38 = virtualinvoke $r3.<java.lang.String: java.lang.String trim()>() 
(define-const var2417 String (get_split_element var189 ":" 2 1)) ; Statement: $r4 = $r37[1] 
(assert true)
(define-const var3034 String (trim/-847153721 var2417)) ; Statement: $r39 = virtualinvoke $r4.<java.lang.String: java.lang.String trim()>() 
(define-const var2177 var1585 var1585-US) ; Statement: $r5 = <java.util.Locale: java.util.Locale US> 
(assert true)
(define-const var2373 String (toLowerCase/1946809429 var1548 var2177)) ; Statement: $r40 = virtualinvoke $r38.<java.lang.String: java.lang.String toLowerCase(java.util.Locale)>($r5) 
(define-const var345 Int -1) ; Statement: b9 = -1 
(assert true)
(define-const var1167 Int (hashCode/-467973558 var2373)) ; Statement: $i0 = virtualinvoke $r40.<java.lang.String: int hashCode()>() 
 ; Statement: lookupswitch($i0) {     case -1392734395: goto $z12 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("bg-rgb");     case -1332194002: goto $z11 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("background");     case -1278217791: goto $z10 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("fg-rgb");     case -575521469: goto $z9 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("foreground-rgb");     case 98: goto $z8 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("b");     case 102: goto $z7 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("f");     case 3141: goto $z6 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("bg");     case 3265: goto $z5 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("fg");     case 91958498: goto $z4 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("b-rgb");     case 95652582: goto $z3 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("f-rgb");     case 1426340782: goto $z2 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("background-rgb");     case 1984457027: goto $z1 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("foreground");     default: goto tableswitch(b9) {     case 0: goto r42 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 1: goto r42 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 2: goto r42 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 3: goto r44 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 4: goto r44 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 5: goto r44 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 6: goto r46 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     case 7: goto r46 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     case 8: goto r46 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     case 9: goto r48 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     case 10: goto r48 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     case 11: goto r48 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     default: goto $r28 = <org.jline.utils.StyleResolver: java.util.logging.Logger log>; }; } 
(assert (and (not (= var1167 1984457027)) (and (not (= var1167 1426340782)) (and (not (= var1167 95652582)) (and (not (= var1167 91958498)) (and (not (= var1167 3265)) (and (not (= var1167 3141)) (and (not (= var1167 102)) (and (not (= var1167 98)) (and (not (= var1167 -575521469)) (and (not (= var1167 -1278217791)) (and (not (= var1167 -1332194002)) (and (not (= var1167 -1392734395)) true))))))))))))) ; Intersect: Negate: Cond: $i0 == 1984457027   and Intersect: Negate: Cond: $i0 == 1426340782   and Intersect: Negate: Cond: $i0 == 95652582   and Intersect: Negate: Cond: $i0 == 91958498   and Intersect: Negate: Cond: $i0 == 3265   and Intersect: Negate: Cond: $i0 == 3141   and Intersect: Negate: Cond: $i0 == 102   and Intersect: Negate: Cond: $i0 == 98   and Intersect: Negate: Cond: $i0 == -575521469   and Intersect: Negate: Cond: $i0 == -1278217791   and Intersect: Negate: Cond: $i0 == -1332194002   and Intersect: Negate: Cond: $i0 == -1392734395   and Non Conditional            
 ; Statement: tableswitch(b9) {     case 0: goto r42 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 1: goto r42 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 2: goto r42 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 3: goto r44 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 4: goto r44 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 5: goto r44 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 6: goto r46 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     case 7: goto r46 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     case 8: goto r46 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     case 9: goto r48 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     case 10: goto r48 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     case 11: goto r48 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     default: goto $r28 = <org.jline.utils.StyleResolver: java.util.logging.Logger log>; } 
(assert (and (not (= var345 11)) (and (not (= var345 10)) (and (not (= var345 9)) (and (not (= var345 8)) (and (not (= var345 7)) (and (not (= var345 6)) (and (not (= var345 5)) (and (not (= var345 4)) (and (not (= var345 3)) (and (not (= var345 2)) (and (not (= var345 1)) (and (not (= var345 0)) true))))))))))))) ; Intersect: Negate: Cond: b9 == 11   and Intersect: Negate: Cond: b9 == 10   and Intersect: Negate: Cond: b9 == 9   and Intersect: Negate: Cond: b9 == 8   and Intersect: Negate: Cond: b9 == 7   and Intersect: Negate: Cond: b9 == 6   and Intersect: Negate: Cond: b9 == 5   and Intersect: Negate: Cond: b9 == 4   and Intersect: Negate: Cond: b9 == 3   and Intersect: Negate: Cond: b9 == 2   and Intersect: Negate: Cond: b9 == 1   and Intersect: Negate: Cond: b9 == 0   and Non Conditional            
(define-const var2882 var2996 var1635-log) ; Statement: $r28 = <org.jline.utils.StyleResolver: java.util.logging.Logger log> 
(define-const var3065 String String-init) ; Statement: $r27 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3065)) ; Statement: specialinvoke $r27.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3065!1 String)
(assert (= var3065!1 ""))
(assert true)
(define-const var3890 String (append/672562846 var3065!1 "Invalid color-mode: ")) ; Statement: $r29 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid color-mode: ") 
(declare-const var3065!2 String)
(assert (= var3065!2 (str.++ var3065!1 "Invalid color-mode: ")))
(assert true)
(define-const var945 String (append/672562846 var3890 var1548)) ; Statement: $r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r38) 
(declare-const var3890!1 String)
(assert (= var3890!1 (str.++ var3890 var1548)))
(assert true)
(define-const var638 String (toString/-2075883882 var945)) ; Statement: $r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert true)
;(assert (warning/-1321853967 var2882 var638)) ; Statement: virtualinvoke $r28.<java.util.logging.Logger: void warning(java.lang.String)>($r31) 

(declare-const var2882!1 var2996)
(declare-const var638!1 String)
(assert true) ; Non Conditional
 ; Statement: return r6 
(check-sat)
; {isLoggable/-616065502=([java.util.logging.Logger, java.util.logging.Level], boolean), trim/-847153721=([java.lang.String], java.lang.String), toLowerCase/1946809429=([java.lang.String, java.util.Locale], java.lang.String), hashCode/-467973558=([java.lang.String], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), warning/-1321853967=([java.util.logging.Logger, java.lang.String], void)}
; {var1635=org.jline.utils.StyleResolver, var2522=r41, var1267=org.jline.utils.AttributedStyle, var2804=r6, var189=r2, var66=null_type, var2996=java.util.logging.Logger, var102=$r1, var3923=java.util.logging.Level, var310=$r0, var554=$z0, var2956=$r37, var335=$r3, var1548=$r38, var2417=$r4, var3034=$r39, var1585=java.util.Locale, var2177=$r5, var2373=$r40, var345=b9, var1167=$i0, var2882=$r28, var3065=$r27, var3890=$r29, var945=$r30, var638=$r31}
; {org.jline.utils.StyleResolver=var1635, r41=var2522, org.jline.utils.AttributedStyle=var1267, r6=var2804, r2=var189, null_type=var66, java.util.logging.Logger=var2996, $r1=var102, java.util.logging.Level=var3923, $r0=var310, $z0=var554, $r37=var2956, $r3=var335, $r38=var1548, $r4=var2417, $r39=var3034, java.util.Locale=var1585, $r5=var2177, $r40=var2373, b9=var345, $i0=var1167, $r28=var2882, $r27=var3065, $r29=var3890, $r30=var945, $r31=var638}
;seq <java.lang.String: java.lang.String[] split(java.lang.String,int)>;	<java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String trim()>;	<java.lang.String: java.lang.String toLowerCase(java.util.Locale)>;	<java.lang.String: int hashCode()>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String,int)>": 1,"<java.lang.String: java.lang.String trim()>": 2,"<java.lang.String: java.lang.String toLowerCase(java.util.Locale)>": 1,"<java.lang.String: int hashCode()>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r41 := @this: org.jline.utils.StyleResolver;	r6 := @parameter0: org.jline.utils.AttributedStyle;	r2 := @parameter1: java.lang.String;	$r1 = <org.jline.utils.StyleResolver: java.util.logging.Logger log>;	$r0 = <java.util.logging.Level: java.util.logging.Level FINEST>;	$z0 = virtualinvoke $r1.<java.util.logging.Logger: boolean isLoggable(java.util.logging.Level)>($r0);	if $z0 == 0 goto $r37 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", 2);	$r37 = virtualinvoke r2.<java.lang.String: java.lang.String[] split(java.lang.String,int)>(":", 2);	$r3 = $r37[0];	$r38 = virtualinvoke $r3.<java.lang.String: java.lang.String trim()>();	$r4 = $r37[1];	$r39 = virtualinvoke $r4.<java.lang.String: java.lang.String trim()>();	$r5 = <java.util.Locale: java.util.Locale US>;	$r40 = virtualinvoke $r38.<java.lang.String: java.lang.String toLowerCase(java.util.Locale)>($r5);	b9 = -1;	$i0 = virtualinvoke $r40.<java.lang.String: int hashCode()>();	lookupswitch($i0) {     case -1392734395: goto $z12 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("bg-rgb");     case -1332194002: goto $z11 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("background");     case -1278217791: goto $z10 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("fg-rgb");     case -575521469: goto $z9 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("foreground-rgb");     case 98: goto $z8 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("b");     case 102: goto $z7 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("f");     case 3141: goto $z6 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("bg");     case 3265: goto $z5 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("fg");     case 91958498: goto $z4 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("b-rgb");     case 95652582: goto $z3 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("f-rgb");     case 1426340782: goto $z2 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("background-rgb");     case 1984457027: goto $z1 = virtualinvoke $r40.<java.lang.String: boolean equals(java.lang.Object)>("foreground");     default: goto tableswitch(b9) {     case 0: goto r42 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 1: goto r42 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 2: goto r42 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 3: goto r44 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 4: goto r44 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 5: goto r44 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 6: goto r46 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     case 7: goto r46 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     case 8: goto r46 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     case 9: goto r48 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     case 10: goto r48 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     case 11: goto r48 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     default: goto $r28 = <org.jline.utils.StyleResolver: java.util.logging.Logger log>; }; };	tableswitch(b9) {     case 0: goto r42 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 1: goto r42 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 2: goto r42 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 3: goto r44 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 4: goto r44 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 5: goto r44 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer color(java.lang.String)>($r39);     case 6: goto r46 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     case 7: goto r46 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     case 8: goto r46 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     case 9: goto r48 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     case 10: goto r48 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     case 11: goto r48 = staticinvoke <org.jline.utils.StyleResolver: java.lang.Integer colorRgb(java.lang.String)>($r39);     default: goto $r28 = <org.jline.utils.StyleResolver: java.util.logging.Logger log>; };	$r28 = <org.jline.utils.StyleResolver: java.util.logging.Logger log>;	$r27 = new java.lang.StringBuilder;	specialinvoke $r27.<java.lang.StringBuilder: void <init>()>();	$r29 = virtualinvoke $r27.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Invalid color-mode: ");	$r30 = virtualinvoke $r29.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r38);	$r31 = virtualinvoke $r30.<java.lang.StringBuilder: java.lang.String toString()>();	virtualinvoke $r28.<java.util.logging.Logger: void warning(java.lang.String)>($r31);	return r6
;block_num 5
(get-model)
