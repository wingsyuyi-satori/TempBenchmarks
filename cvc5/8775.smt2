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

(declare-sort var3173 0)
(declare-sort var3355 0)
(declare-sort var1425 0)
(declare-sort var1376 0)
(declare-sort var1468 0)
(declare-sort var335 0)
(declare-sort var3950 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun arr-Int-init () (Array Int Int))
(declare-fun var1376-init () var1376)
(declare-fun <init>/-55681307 (var1376 (Array Int Int) Int) void)
(declare-fun var1425_write/-459365051 (var1425 var1376) void)
(declare-fun var3173_hasEntryCaseInsensitive/-240204854 (var3173 String) Bool)
(declare-fun getWriteIndex/-178493442 (var1376) Int)
(declare-fun var335_bootstrap$/-1224113051 ((Array Int Int)) var1468)
(declare-fun var3173_createDocument/-450016166 (var3173 String Int var1468) var3950)
(declare-const null-var3173 var3173)
(declare-const null-String String)
(declare-const null-var1425 var1425)
(declare-const var1404 var3173) ; Statement: r12 := @parameter0: org.apache.poi.poifs.filesystem.DirectoryEntry 
(assert (not (= var1404 null-var3173)))
(declare-const var1012 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var1012 null-String)))
(declare-const var1827 var1425) ; Statement: r3 := @parameter2: org.apache.poi.poifs.crypt.standard.EncryptionRecord 
(assert (not (= var1827 null-var1425)))
; split operation: var293 = var1012.split("/") ; Statement: r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/") 
(define-const var1115 Int 0) ; Statement: i5 = 0 
(assert true) ; Non Conditional
(define-const var1606 Int (get_split_length var1012 "/" -1)) ; Statement: $i0 = lengthof r1 
(define-const var2675 Int (- var1606 1)) ; Statement: $i1 = $i0 - 1 
 ; Statement: if i5 >= $i1 goto r14 = newarray (byte)[5000] 
(assert (>= var1115 var2675)) ; Cond: i5 >= $i1 
(define-const var2635 (Array Int Int) arr-Int-init) ; Statement: r14 = newarray (byte)[5000] 
(define-const var740 var1376 var1376-init) ; Statement: $r2 = new org.apache.poi.util.LittleEndianByteArrayOutputStream 
(assert true)
;(assert (<init>/-55681307 var740 var2635 0)) ; Statement: specialinvoke $r2.<org.apache.poi.util.LittleEndianByteArrayOutputStream: void <init>(byte[],int)>(r14, 0) 

(declare-const var740!1 var1376)
(declare-const var2635!1 (Array Int Int))
(declare-const var543 Int)
;(assert (var1425_write/-459365051 var1827 var740!1)) ; Statement: interfaceinvoke r3.<org.apache.poi.poifs.crypt.standard.EncryptionRecord: void write(org.apache.poi.util.LittleEndianByteArrayOutputStream)>($r2) 

(declare-const var1827!1 var1425)
(declare-const var740!2 var1376)
(define-const var69 Int (get_split_length var1012 "/" -1)) ; Statement: $i2 = lengthof r1 
(define-const var1355 Int (- var69 1)) ; Statement: $i3 = $i2 - 1 
(define-const var236 String (get_split_element var1012 "/" -1 var1355)) ; Statement: r4 = r1[$i3] 
(define-const var908 Bool (var3173_hasEntryCaseInsensitive/-240204854 var1404 var236)) ; Statement: $z0 = interfaceinvoke r12.<org.apache.poi.poifs.filesystem.DirectoryEntry: boolean hasEntryCaseInsensitive(java.lang.String)>(r4) 
 ; Statement: if $z0 == 0 goto $i4 = virtualinvoke $r2.<org.apache.poi.util.LittleEndianByteArrayOutputStream: int getWriteIndex()>() 
(assert (= (ite var908 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2971 Int (getWriteIndex/-178493442 var740!2)) ; Statement: $i4 = virtualinvoke $r2.<org.apache.poi.util.LittleEndianByteArrayOutputStream: int getWriteIndex()>() 
(define-const var1043 var1468 (var335_bootstrap$/-1224113051 var2635!1)) ; Statement: $r5 = staticinvoke <org.apache.poi.poifs.crypt.DataSpaceMapUtils$lambda_createEncryptionEntry_0__1076: org.apache.poi.poifs.filesystem.POIFSWriterListener bootstrap$(byte[])>(r14) 
(define-const var1872 var3950 (var3173_createDocument/-450016166 var1404 var236 var2971 var1043)) ; Statement: $r6 = interfaceinvoke r12.<org.apache.poi.poifs.filesystem.DirectoryEntry: org.apache.poi.poifs.filesystem.DocumentEntry createDocument(java.lang.String,int,org.apache.poi.poifs.filesystem.POIFSWriterListener)>(r4, $i4, $r5) 
 ; Statement: return $r6 
(check-sat)
; {arr-Int-init=([], byte[]), var1376-init=([], org.apache.poi.util.LittleEndianByteArrayOutputStream), <init>/-55681307=([org.apache.poi.util.LittleEndianByteArrayOutputStream, byte[], int], void), var1425_write/-459365051=([org.apache.poi.poifs.crypt.standard.EncryptionRecord, org.apache.poi.util.LittleEndianByteArrayOutputStream], void), var3173_hasEntryCaseInsensitive/-240204854=([org.apache.poi.poifs.filesystem.DirectoryEntry, java.lang.String], boolean), getWriteIndex/-178493442=([org.apache.poi.util.LittleEndianByteArrayOutputStream], int), var335_bootstrap$/-1224113051=([byte[]], org.apache.poi.poifs.filesystem.POIFSWriterListener), var3173_createDocument/-450016166=([org.apache.poi.poifs.filesystem.DirectoryEntry, java.lang.String, int, org.apache.poi.poifs.filesystem.POIFSWriterListener], org.apache.poi.poifs.filesystem.DocumentEntry)}
; {var3173=org.apache.poi.poifs.filesystem.DirectoryEntry, var1404=r12, var1012=r0, var3355=null_type, var1425=org.apache.poi.poifs.crypt.standard.EncryptionRecord, var1827=r3, var293=r1, var1115=i5, var1606=$i0, var2675=$i1, var2635=r14, var1376=org.apache.poi.util.LittleEndianByteArrayOutputStream, var740=$r2, var543=0, var69=$i2, var1355=$i3, var236=r4, var908=$z0, var2971=$i4, var1468=org.apache.poi.poifs.filesystem.POIFSWriterListener, var335=org.apache.poi.poifs.crypt.DataSpaceMapUtils$lambda_createEncryptionEntry_0__1076, var1043=$r5, var3950=org.apache.poi.poifs.filesystem.DocumentEntry, var1872=$r6}
; {org.apache.poi.poifs.filesystem.DirectoryEntry=var3173, r12=var1404, r0=var1012, null_type=var3355, org.apache.poi.poifs.crypt.standard.EncryptionRecord=var1425, r3=var1827, r1=var293, i5=var1115, $i0=var1606, $i1=var2675, r14=var2635, org.apache.poi.util.LittleEndianByteArrayOutputStream=var1376, $r2=var740, 0=var543, $i2=var69, $i3=var1355, r4=var236, $z0=var908, $i4=var2971, org.apache.poi.poifs.filesystem.POIFSWriterListener=var1468, org.apache.poi.poifs.crypt.DataSpaceMapUtils$lambda_createEncryptionEntry_0__1076=var335, $r5=var1043, org.apache.poi.poifs.filesystem.DocumentEntry=var3950, $r6=var1872}
;seq <java.lang.String: java.lang.String[] split(java.lang.String)>
;cnt {"<java.lang.String: java.lang.String[] split(java.lang.String)>": 1}
;stmts r12 := @parameter0: org.apache.poi.poifs.filesystem.DirectoryEntry;	r0 := @parameter1: java.lang.String;	r3 := @parameter2: org.apache.poi.poifs.crypt.standard.EncryptionRecord;	r1 = virtualinvoke r0.<java.lang.String: java.lang.String[] split(java.lang.String)>("/");	i5 = 0;	$i0 = lengthof r1;	$i1 = $i0 - 1;	if i5 >= $i1 goto r14 = newarray (byte)[5000];	r14 = newarray (byte)[5000];	$r2 = new org.apache.poi.util.LittleEndianByteArrayOutputStream;	specialinvoke $r2.<org.apache.poi.util.LittleEndianByteArrayOutputStream: void <init>(byte[],int)>(r14, 0);	interfaceinvoke r3.<org.apache.poi.poifs.crypt.standard.EncryptionRecord: void write(org.apache.poi.util.LittleEndianByteArrayOutputStream)>($r2);	$i2 = lengthof r1;	$i3 = $i2 - 1;	r4 = r1[$i3];	$z0 = interfaceinvoke r12.<org.apache.poi.poifs.filesystem.DirectoryEntry: boolean hasEntryCaseInsensitive(java.lang.String)>(r4);	if $z0 == 0 goto $i4 = virtualinvoke $r2.<org.apache.poi.util.LittleEndianByteArrayOutputStream: int getWriteIndex()>();	$i4 = virtualinvoke $r2.<org.apache.poi.util.LittleEndianByteArrayOutputStream: int getWriteIndex()>();	$r5 = staticinvoke <org.apache.poi.poifs.crypt.DataSpaceMapUtils$lambda_createEncryptionEntry_0__1076: org.apache.poi.poifs.filesystem.POIFSWriterListener bootstrap$(byte[])>(r14);	$r6 = interfaceinvoke r12.<org.apache.poi.poifs.filesystem.DirectoryEntry: org.apache.poi.poifs.filesystem.DocumentEntry createDocument(java.lang.String,int,org.apache.poi.poifs.filesystem.POIFSWriterListener)>(r4, $i4, $r5);	return $r6
;block_num 4
(get-model)
