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

(declare-sort var2539 0)
(declare-sort var318 0)
(declare-sort var127 0)
(declare-sort var105 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun this$0/1762336425 (var2539) var127)
(declare-fun getText/-791554220 (var127 var318) String)
(declare-fun doc/-1930180878 (var127) var105)
(declare-fun getLineHeight/1985812787 (var105) Float64)
(declare-fun nodeHeightPaddingAbove/-1930180878 (var127) Int)
(declare-fun cast-from-Int-to-Float64 (Int) Float64)
(declare-fun nodeHeightPaddingBelow/-1930180878 (var127) Int)
(declare-const null-var2539 var2539)
(declare-const null-var318 var318)
(declare-const var1488 var2539) ; Statement: r0 := @this: org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide 
(assert (not (= var1488 null-var2539)))
(declare-const var151 var318) ; Statement: r1 := @parameter0: org.antlr.v4.runtime.tree.Tree 
(assert (not (= var151 null-var318)))
(define-const var72 var127 (this$0/1762336425 var1488)) ; Statement: $r2 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0> 
(assert true)
(define-const var2316 String (getText/-791554220 var72 var151)) ; Statement: r3 = virtualinvoke $r2.<org.antlr.v4.gui.TreePostScriptGenerator: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1) 
(define-const var1050 var127 (this$0/1762336425 var1488)) ; Statement: $r4 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0> 
(define-const var3073 var105 (doc/-1930180878 var1050)) ; Statement: $r5 = $r4.<org.antlr.v4.gui.TreePostScriptGenerator: org.antlr.v4.gui.PostScriptDocument doc> 
(assert true)
(define-const var3169 Float64 (getLineHeight/1985812787 var3073)) ; Statement: $d1 = virtualinvoke $r5.<org.antlr.v4.gui.PostScriptDocument: double getLineHeight()>() 
(define-const var59 var127 (this$0/1762336425 var1488)) ; Statement: $r6 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0> 
(define-const var3342 Int (nodeHeightPaddingAbove/-1930180878 var59)) ; Statement: $i0 = $r6.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingAbove> 
(define-const var65 Float64 (cast-from-Int-to-Float64 var3342)) ; Statement: $d0 = (double) $i0 
(define-const var1208 Float64 (fp.add roundNearestTiesToEven var3169 var65)) ; Statement: $d3 = $d1 + $d0 
(define-const var3873 var127 (this$0/1762336425 var1488)) ; Statement: $r7 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0> 
(define-const var942 Int (nodeHeightPaddingBelow/-1930180878 var3873)) ; Statement: $i1 = $r7.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingBelow> 
(define-const var3680 Float64 (cast-from-Int-to-Float64 var942)) ; Statement: $d2 = (double) $i1 
(define-const var1083 Float64 (fp.add roundNearestTiesToEven var1208 var3680)) ; Statement: d4 = $d3 + $d2 
; split operation: var2460 = var2316.split("\n") ; Statement: r8 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(define-const var3863 Int (get_split_length var2316 "\n" -1)) ; Statement: $i2 = lengthof r8 
(define-const var3318 Float64 (cast-from-Int-to-Float64 var3863)) ; Statement: $d5 = (double) $i2 
(define-const var604 Float64 (fp.mul roundNearestTiesToEven var1083 var3318)) ; Statement: $d6 = d4 * $d5 
 ; Statement: return $d6 
(check-sat)
; {this$0/1762336425=([org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide], org.antlr.v4.gui.TreePostScriptGenerator), getText/-791554220=([org.antlr.v4.gui.TreePostScriptGenerator, org.antlr.v4.runtime.tree.Tree], java.lang.String), doc/-1930180878=([org.antlr.v4.gui.TreePostScriptGenerator], org.antlr.v4.gui.PostScriptDocument), getLineHeight/1985812787=([org.antlr.v4.gui.PostScriptDocument], double), nodeHeightPaddingAbove/-1930180878=([org.antlr.v4.gui.TreePostScriptGenerator], int), cast-from-Int-to-Float64=([int], double), nodeHeightPaddingBelow/-1930180878=([org.antlr.v4.gui.TreePostScriptGenerator], int)}
; {var2539=org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide, var1488=r0, var318=org.antlr.v4.runtime.tree.Tree, var151=r1, var127=org.antlr.v4.gui.TreePostScriptGenerator, var72=$r2, var2316=r3, var1050=$r4, var105=org.antlr.v4.gui.PostScriptDocument, var3073=$r5, var3169=$d1, var59=$r6, var3342=$i0, var65=$d0, var1208=$d3, var3873=$r7, var942=$i1, var3680=$d2, var1083=d4, var2460=r8, var3863=$i2, var3318=$d5, var604=$d6}
; {org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide=var2539, r0=var1488, org.antlr.v4.runtime.tree.Tree=var318, r1=var151, org.antlr.v4.gui.TreePostScriptGenerator=var127, $r2=var72, r3=var2316, $r4=var1050, org.antlr.v4.gui.PostScriptDocument=var105, $r5=var3073, $d1=var3169, $r6=var59, $i0=var3342, $d0=var65, $d3=var1208, $r7=var3873, $i1=var942, $d2=var3680, d4=var1083, r8=var2460, $i2=var3863, $d5=var3318, $d6=var604}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide;	r1 := @parameter0: org.antlr.v4.runtime.tree.Tree;	$r2 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0>;	r3 = virtualinvoke $r2.<org.antlr.v4.gui.TreePostScriptGenerator: java.lang.String getText(org.antlr.v4.runtime.tree.Tree)>(r1);	$r4 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0>;	$r5 = $r4.<org.antlr.v4.gui.TreePostScriptGenerator: org.antlr.v4.gui.PostScriptDocument doc>;	$d1 = virtualinvoke $r5.<org.antlr.v4.gui.PostScriptDocument: double getLineHeight()>();	$r6 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0>;	$i0 = $r6.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingAbove>;	$d0 = (double) $i0;	$d3 = $d1 + $d0;	$r7 = r0.<org.antlr.v4.gui.TreePostScriptGenerator$VariableExtentProvide: org.antlr.v4.gui.TreePostScriptGenerator this$0>;	$i1 = $r7.<org.antlr.v4.gui.TreePostScriptGenerator: int nodeHeightPaddingBelow>;	$d2 = (double) $i1;	d4 = $d3 + $d2;	r8 = virtualinvoke r3.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	$i2 = lengthof r8;	$d5 = (double) $i2;	$d6 = d4 * $d5;	return $d6
;block_num 1
(get-model)
