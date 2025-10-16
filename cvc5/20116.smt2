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

(declare-sort var1865 0)
(declare-sort var3072 0)
(declare-sort var1969 0)
(declare-sort var797 0)
(declare-sort var58 0)
(declare-sort var2715 0)
(declare-sort var327 0)
(declare-sort var2513 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var1969) void)
(declare-fun cast-from-var1865-to-var1969 (var1865) var1969)
(declare-fun var797-init () var797)
(declare-fun <init>/272540643 (var797) void)
(declare-fun var2715_newHashMap/701256970 () var58)
(declare-fun lexicon/-613054603 (var1865) var58)
(declare-fun var327-init () var327)
(declare-fun <init>/-1681595970 (var327 String) void)
(declare-fun var2513_getLineIterator/915635313 (var327) var2513)
(declare-fun iterator/1890858564 (var2513) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun var58_getOrDefault/-573460120 (var58 var1969 var1969) var1969)
(declare-fun cast-from-String-to-var1969 (String) var1969)
(declare-fun cast-from-var1969-to-String (var1969) String)
(declare-fun unk/-613054603 (var1865) String)
(declare-const null-var1865 var1865)
(declare-const null-String String)
(declare-const var1994 var1865) ; Statement: r0 := @this: edu.stanford.nlp.tagger.maxent.Distsim 
(assert (not (= var1994 null-var1865)))
(declare-const var1279 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1279 null-String)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var1865-to-var1969 var1994))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var1994!1 var1865)
; split operation: var2492 = var1279.split(";") ; Statement: r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(";") 
(define-const var929 String (get_split_element var1279 ";" -1 0)) ; Statement: r3 = r2[0] 
(define-const var3705 Int 1) ; Statement: i1 = 1 
(assert true) ; Non Conditional
(define-const var851 Int (get_split_length var1279 ";" -1)) ; Statement: $i0 = lengthof r2 
 ; Statement: if i1 >= $i0 goto $r4 = new edu.stanford.nlp.util.Interner 
(assert (>= var3705 var851)) ; Cond: i1 >= $i0 
(define-const var859 var797 var797-init) ; Statement: $r4 = new edu.stanford.nlp.util.Interner 
(assert true)
;(assert (<init>/272540643 var859)) ; Statement: specialinvoke $r4.<edu.stanford.nlp.util.Interner: void <init>()>() 

(declare-const var859!1 var797)
(define-const var1014 var58 var2715_newHashMap/701256970) ; Statement: $r5 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Map newHashMap()>() 
(declare-const var1994!2 var1865)
(assert (not (= var1994!2 null-var1865)))
(assert (= (lexicon/-613054603 var1994!2) var1014)) ; Statement: r0.<edu.stanford.nlp.tagger.maxent.Distsim: java.util.Map lexicon> = $r5 
(define-const var2149 var327 var327-init) ; Statement: $r6 = new java.io.File 
(assert true)
;(assert (<init>/-1681595970 var2149 var929)) ; Statement: specialinvoke $r6.<java.io.File: void <init>(java.lang.String)>(r3) 

(declare-const var2149!1 var327)
(declare-const var929!1 String)
(define-const var3707 var2513 (var2513_getLineIterator/915635313 var2149!1)) ; Statement: $r7 = staticinvoke <edu.stanford.nlp.objectbank.ObjectBank: edu.stanford.nlp.objectbank.ObjectBank getLineIterator(java.io.File)>($r6) 
(assert true)
(define-const var484 Iterator (iterator/1890858564 var3707)) ; Statement: r8 = virtualinvoke $r7.<edu.stanford.nlp.objectbank.ObjectBank: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var1684 Bool (Iterator_hasNext/-1669924200 var484)) ; Statement: $z0 = interfaceinvoke r8.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto $r9 = r0.<edu.stanford.nlp.tagger.maxent.Distsim: java.util.Map lexicon> 
(assert (= (ite var1684 1 0) 0)) ; Cond: $z0 == 0 
(define-const var679 var58 (lexicon/-613054603 var1994!2)) ; Statement: $r9 = r0.<edu.stanford.nlp.tagger.maxent.Distsim: java.util.Map lexicon> 
(define-const var1649 var1969 (var58_getOrDefault/-573460120 var679 (cast-from-String-to-var1969 "<unk>") (cast-from-String-to-var1969 "null"))) ; Statement: $r10 = interfaceinvoke $r9.<java.util.Map: java.lang.Object getOrDefault(java.lang.Object,java.lang.Object)>("<unk>", "null") 
(define-const var863 String (cast-from-var1969-to-String var1649)) ; Statement: $r11 = (java.lang.String) $r10 
(declare-const var1994!3 var1865)
(assert (not (= var1994!3 null-var1865)))
(assert (= (unk/-613054603 var1994!3) var863)) ; Statement: r0.<edu.stanford.nlp.tagger.maxent.Distsim: java.lang.String unk> = $r11 
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var1865-to-var1969=([edu.stanford.nlp.tagger.maxent.Distsim], java.lang.Object), var797-init=([], edu.stanford.nlp.util.Interner), <init>/272540643=([edu.stanford.nlp.util.Interner], void), var2715_newHashMap/701256970=([], java.util.Map), lexicon/-613054603=([edu.stanford.nlp.tagger.maxent.Distsim], java.util.Map), var327-init=([], java.io.File), <init>/-1681595970=([java.io.File, java.lang.String], void), var2513_getLineIterator/915635313=([java.io.File], edu.stanford.nlp.objectbank.ObjectBank), iterator/1890858564=([edu.stanford.nlp.objectbank.ObjectBank], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), var58_getOrDefault/-573460120=([java.util.Map, java.lang.Object, java.lang.Object], java.lang.Object), cast-from-String-to-var1969=([java.lang.String], java.lang.Object), cast-from-var1969-to-String=([java.lang.Object], java.lang.String), unk/-613054603=([edu.stanford.nlp.tagger.maxent.Distsim], java.lang.String)}
; {var1865=edu.stanford.nlp.tagger.maxent.Distsim, var1994=r0, var1279=r1, var3072=null_type, var1969=java.lang.Object, var2492=r2, var929=r3, var3705=i1, var851=$i0, var797=edu.stanford.nlp.util.Interner, var859=$r4, var58=java.util.Map, var2715=edu.stanford.nlp.util.Generics, var1014=$r5, var327=java.io.File, var2149=$r6, var2513=edu.stanford.nlp.objectbank.ObjectBank, var3707=$r7, var484=r8, var1684=$z0, var679=$r9, var1649=$r10, var863=$r11}
; {edu.stanford.nlp.tagger.maxent.Distsim=var1865, r0=var1994, r1=var1279, null_type=var3072, java.lang.Object=var1969, r2=var2492, r3=var929, i1=var3705, $i0=var851, edu.stanford.nlp.util.Interner=var797, $r4=var859, java.util.Map=var58, edu.stanford.nlp.util.Generics=var2715, $r5=var1014, java.io.File=var327, $r6=var2149, edu.stanford.nlp.objectbank.ObjectBank=var2513, $r7=var3707, r8=var484, $z0=var1684, $r9=var679, $r10=var1649, $r11=var863}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r0 := @this: edu.stanford.nlp.tagger.maxent.Distsim;	r1 := @parameter0: java.lang.String;	specialinvoke r0.<java.lang.Object: void <init>()>();	r2 = virtualinvoke r1.<java.lang.String: java.lang.String[] split(java.lang.String)>(";");	r3 = r2[0];	i1 = 1;	$i0 = lengthof r2;	if i1 >= $i0 goto $r4 = new edu.stanford.nlp.util.Interner;	$r4 = new edu.stanford.nlp.util.Interner;	specialinvoke $r4.<edu.stanford.nlp.util.Interner: void <init>()>();	$r5 = staticinvoke <edu.stanford.nlp.util.Generics: java.util.Map newHashMap()>();	r0.<edu.stanford.nlp.tagger.maxent.Distsim: java.util.Map lexicon> = $r5;	$r6 = new java.io.File;	specialinvoke $r6.<java.io.File: void <init>(java.lang.String)>(r3);	$r7 = staticinvoke <edu.stanford.nlp.objectbank.ObjectBank: edu.stanford.nlp.objectbank.ObjectBank getLineIterator(java.io.File)>($r6);	r8 = virtualinvoke $r7.<edu.stanford.nlp.objectbank.ObjectBank: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r8.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto $r9 = r0.<edu.stanford.nlp.tagger.maxent.Distsim: java.util.Map lexicon>;	$r9 = r0.<edu.stanford.nlp.tagger.maxent.Distsim: java.util.Map lexicon>;	$r10 = interfaceinvoke $r9.<java.util.Map: java.lang.Object getOrDefault(java.lang.Object,java.lang.Object)>("<unk>", "null");	$r11 = (java.lang.String) $r10;	r0.<edu.stanford.nlp.tagger.maxent.Distsim: java.lang.String unk> = $r11;	return
;block_num 5
(get-model)
