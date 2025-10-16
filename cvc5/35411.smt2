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

(declare-sort var2121 0)
(declare-sort var773 0)
(declare-sort var2726 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2726-init () var2726)
(declare-fun <init>/-325640736 (var2726) void)
(declare-const null-var2121 var2121)
(declare-const null-String String)
(declare-const var3924 var2121) ; Statement: r4 := @this: edu.stanford.nlp.sequences.ColumnDocumentReaderAndWriter$ColumnDocParser 
(assert (not (= var3924 null-var2121)))
(declare-const var1620 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1620 null-String)))
(define-const var529 var2726 var2726-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var529)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var529!1 var2726)
; split operation: var2196 = var1620.split("\n") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n") 
(define-const var19 Int (get_split_length var1620 "\n" -1)) ; Statement: i0 = lengthof r2 
(define-const var808 Int 0) ; Statement: i8 = 0 
(assert true) ; Non Conditional
 ; Statement: if i8 >= i0 goto return $r0 
(assert (>= var808 var19)) ; Cond: i8 >= i0 
 ; Statement: return $r0 
(check-sat)
; {var2726-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void)}
; {var2121=edu.stanford.nlp.sequences.ColumnDocumentReaderAndWriter$ColumnDocParser, var3924=r4, var1620=r1, var773=null_type, var2726=java.util.ArrayList, var529=$r0, var2196=r2, var19=i0, var808=i8}
; {edu.stanford.nlp.sequences.ColumnDocumentReaderAndWriter$ColumnDocParser=var2121, r4=var3924, r1=var1620, null_type=var773, java.util.ArrayList=var2726, $r0=var529, r2=var2196, i0=var19, i8=var808}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r4 := @this: edu.stanford.nlp.sequences.ColumnDocumentReaderAndWriter$ColumnDocParser;	r1 := @parameter0: java.lang.String;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>("\n");	i0 = lengthof r2;	i8 = 0;	if i8 >= i0 goto return $r0;	return $r0
;block_num 3
(get-model)
