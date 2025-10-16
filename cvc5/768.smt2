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

(declare-sort var3293 0)
(declare-sort var3586 0)
(declare-sort var1110 0)
(declare-sort var1444 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getText/-791554220 (var3293 var3586) String)
(declare-fun getBoundsOfNode/-1951447090 (var3293 var3586) var1110)
(declare-fun doc/-1930180878 (var3293) var1444)
(declare-fun x/-707491510 (var1110) Float64)
(declare-fun y/-707491510 (var1110) Float64)
(declare-fun width/-707491510 (var1110) Float64)
(declare-fun height/-707491510 (var1110) Float64)
(declare-fun highlight/-1835093399 (var1444 Float64 Float64 Float64 Float64) void)
(declare-fun nodeWidthPadding/-1930180878 (var3293) Int)
(declare-fun cast-from-Int-to-Float64 (Int) Float64)
(declare-fun nodeHeightPaddingBelow/-1930180878 (var3293) Int)
(declare-const null-var3293 var3293)
(declare-const null-var3586 var3586)
(declare-const var1203 var3293) ; Statement: r0 := @this: org.antlr.v4.gui.TreePostScriptGenerator 
(assert (not (= var1203 null-var3293)))
(declare-const var371 var3586) ; Statement: r1 := @parameter0: org.antlr.v4.runtime.tree.Tree 
(assert (not (= var371 null-var3586)))
(assert true)
(define-const var2493 String (getText/-791554220 var1203 var371)) ; Statement: $r2 = virtualinvoke r0.<org.antlr.v4.gui.TreePostScriptGenerator: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1) 
; split operation: var3587 = var2493.split("\n") ; Statement: r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(assert true)
(define-const var763 var1110 (getBoundsOfNode/-1951447090 var1203 var371)) ; Statement: r4 = virtualinvoke r0.<org.antlr.v4.gui.TreePostScriptGenerator: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1) 
(define-const var2982 Bool true) ; Statement: $z0 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode 
 ; Statement: if $z0 == 0 goto $d1 = r4.<java.awt.geom.Rectangle2D$Double: double x> 
(assert (not (= (ite var2982 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var411 var1444 (doc/-1930180878 var1203)) ; Statement: $r8 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: org.antlr.v4.gui.PostScriptDocument doc> 
(define-const var2167 Float64 (x/-707491510 var763)) ; Statement: $d8 = r4.<java.awt.geom.Rectangle2D$Double: double x> 
(define-const var3462 Float64 (y/-707491510 var763)) ; Statement: $d7 = r4.<java.awt.geom.Rectangle2D$Double: double y> 
(define-const var2596 Float64 (width/-707491510 var763)) ; Statement: $d6 = r4.<java.awt.geom.Rectangle2D$Double: double width> 
(define-const var2799 Float64 (height/-707491510 var763)) ; Statement: $d5 = r4.<java.awt.geom.Rectangle2D$Double: double height> 
(assert true)
;(assert (highlight/-1835093399 var411 var2167 var3462 var2596 var2799)) ; Statement: virtualinvoke $r8.<org.antlr.v4.gui.PostScriptDocument: void highlight(double,double,double,double)>($d8, $d7, $d6, $d5) 

(declare-const var411!1 var1444)
(declare-const var2167!1 Float64)
(declare-const var3462!1 Float64)
(declare-const var2596!1 Float64)
(declare-const var2799!1 Float64)
(assert true) ; Non Conditional
(define-const var1050 Float64 (x/-707491510 var763)) ; Statement: $d1 = r4.<java.awt.geom.Rectangle2D$Double: double x> 
(define-const var374 Int (nodeWidthPadding/-1930180878 var1203)) ; Statement: $i0 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeWidthPadding> 
(define-const var1345 Float64 (cast-from-Int-to-Float64 var374)) ; Statement: $d0 = (double) $i0 
(define-const var2607 Float64 (fp.add roundNearestTiesToEven var1050 var1345)) ; Statement: $d9 = $d1 + $d0 
(define-const var2967 Float64 (y/-707491510 var763)) ; Statement: $d3 = r4.<java.awt.geom.Rectangle2D$Double: double y> 
(define-const var3888 Int (nodeHeightPaddingBelow/-1930180878 var1203)) ; Statement: $i1 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingBelow> 
(define-const var3870 Float64 (cast-from-Int-to-Float64 var3888)) ; Statement: $d2 = (double) $i1 
(define-const var2130 Float64 (fp.add roundNearestTiesToEven var2967 var3870)) ; Statement: d10 = $d3 + $d2 
(define-const var3757 Int 0) ; Statement: i2 = 0 
(assert true) ; Non Conditional
(define-const var1027 Int (get_split_length var2493 "\n" -1)) ; Statement: $i3 = lengthof r3 
 ; Statement: if i2 >= $i3 goto return 
(assert (>= var3757 var1027)) ; Cond: i2 >= $i3 
 ; Statement: return 
(check-sat)
; {getText/-791554220=([org.antlr.v4.gui.TreePostScriptGenerator, org.antlr.v4.runtime.tree.Tree], java.lang.String), getBoundsOfNode/-1951447090=([org.antlr.v4.gui.TreePostScriptGenerator, org.antlr.v4.runtime.tree.Tree], java.awt.geom.Rectangle2D$Double), doc/-1930180878=([org.antlr.v4.gui.TreePostScriptGenerator], org.antlr.v4.gui.PostScriptDocument), x/-707491510=([java.awt.geom.Rectangle2D$Double], double), y/-707491510=([java.awt.geom.Rectangle2D$Double], double), width/-707491510=([java.awt.geom.Rectangle2D$Double], double), height/-707491510=([java.awt.geom.Rectangle2D$Double], double), highlight/-1835093399=([org.antlr.v4.gui.PostScriptDocument, double, double, double, double], void), nodeWidthPadding/-1930180878=([org.antlr.v4.gui.TreePostScriptGenerator], int), cast-from-Int-to-Float64=([int], double), nodeHeightPaddingBelow/-1930180878=([org.antlr.v4.gui.TreePostScriptGenerator], int)}
; {var3293=org.antlr.v4.gui.TreePostScriptGenerator, var1203=r0, var3586=org.antlr.v4.runtime.tree.Tree, var371=r1, var2493=$r2, var3587=r3, var1110=java.awt.geom.Rectangle2D$Double, var763=r4, var2982=$z0, var1444=org.antlr.v4.gui.PostScriptDocument, var411=$r8, var2167=$d8, var3462=$d7, var2596=$d6, var2799=$d5, var1050=$d1, var374=$i0, var1345=$d0, var2607=$d9, var2967=$d3, var3888=$i1, var3870=$d2, var2130=d10, var3757=i2, var1027=$i3}
; {org.antlr.v4.gui.TreePostScriptGenerator=var3293, r0=var1203, org.antlr.v4.runtime.tree.Tree=var3586, r1=var371, $r2=var2493, r3=var3587, java.awt.geom.Rectangle2D$Double=var1110, r4=var763, $z0=var2982, org.antlr.v4.gui.PostScriptDocument=var1444, $r8=var411, $d8=var2167, $d7=var3462, $d6=var2596, $d5=var2799, $d1=var1050, $i0=var374, $d0=var1345, $d9=var2607, $d3=var2967, $i1=var3888, $d2=var3870, d10=var2130, i2=var3757, $i3=var1027}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.TreePostScriptGenerator;	r1 := @parameter0: org.antlr.v4.runtime.tree.Tree;	$r2 = virtualinvoke r0.<org.antlr.v4.gui.TreePostScriptGenerator: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1);	r3 = virtualinvoke $r2.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	r4 = virtualinvoke r0.<org.antlr.v4.gui.TreePostScriptGenerator: java.awt.geom.Rectangle2D$Double getBoundsOfNode(org.antlr.v4.runtime.tree.Tree)>(r1);	$z0 = r1 instanceof org.antlr.v4.runtime.tree.ErrorNode;	if $z0 == 0 goto $d1 = r4.<java.awt.geom.Rectangle2D$Double: double x>;	$r8 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: org.antlr.v4.gui.PostScriptDocument doc>;	$d8 = r4.<java.awt.geom.Rectangle2D$Double: double x>;	$d7 = r4.<java.awt.geom.Rectangle2D$Double: double y>;	$d6 = r4.<java.awt.geom.Rectangle2D$Double: double width>;	$d5 = r4.<java.awt.geom.Rectangle2D$Double: double height>;	virtualinvoke $r8.<org.antlr.v4.gui.PostScriptDocument: void highlight(double,double,double,double)>($d8, $d7, $d6, $d5);	$d1 = r4.<java.awt.geom.Rectangle2D$Double: double x>;	$i0 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeWidthPadding>;	$d0 = (double) $i0;	$d9 = $d1 + $d0;	$d3 = r4.<java.awt.geom.Rectangle2D$Double: double y>;	$i1 = r0.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingBelow>;	$d2 = (double) $i1;	d10 = $d3 + $d2;	i2 = 0;	$i3 = lengthof r3;	if i2 >= $i3 goto return;	return
;block_num 5
(get-model)
