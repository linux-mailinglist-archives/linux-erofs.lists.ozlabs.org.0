Return-Path: <linux-erofs+bounces-3351-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wLVcCqKy52no/gEAu9opvQ
	(envelope-from <linux-erofs+bounces-3351-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2026 19:23:46 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0259B43DE71
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Apr 2026 19:23:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0TjB1c1Lz30V0;
	Wed, 22 Apr 2026 03:23:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=103.117.158.51 arc.chain=zohomail.in
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776792222;
	cv=pass; b=HATDQFn1oELGTMF6y4SkQI4u5IB2HogTqO1RghIwe0suFhoi6jpmSEj+AWrgV850ybGeuBm7RM/kmt86wxb6Y6KOwpkZIfElcqcMaqFy3xRFJVgoIFaJjqVA7jV70GKYMxYkVMShOlxOVygJoHBn8OBWPvOXVI4JtgmVdRZ7CDoVmUGIRSGDmrSCbBCLaJ5wBPB6LCYkhAjcMNOlnV0D3e4MFI5u29qppidEnJdBS0c1qI4gJQsO2pzPn+n6q4MonBtYvCFeBpm77CCfXKzbazE03Tu4LLsXSJnVV15kh/6JQufiJDpgYLJHeHdS4d/gYRRxr79RZcMFTCITTJuIAA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776792222; c=relaxed/relaxed;
	bh=xz+aCVaGYZl0T5ncZzO2ZDAzxbzHN+Zt5kaZL6Ky8Dc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=odrfSTW34jLucZaoN5G4uCrfNDnQ1LgJJpHMvlVVwhSRQ2vN2cclVXN792upZqxzqMbms1s4cRniv1eMGqtiOUegMbZg1FXbgpahbI94fbFb3TC3nA/rH+MQyLV4ctC21hzva5Ynp08kXR2SwX4PBV3pGvFMGhw5PeTbK0fi+lFGm/kg8oHHEA98cN1mhXca6V0BMyj3ZQyN32GmOd3Ln7KI5gpkSPBqUj+9FGw5YaFhoggqJRrTeY2Rd91Sgkzg043O5SPHVzOORi8wCTlfIIuEmPv2t/1i17Svk0lUyHGSD3ukDXH+C1XJzGZWHXxhSU6E/arsSwDMNbkIiHwMxw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in; dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=T2Ffq5Oy; dkim-atps=neutral; spf=pass (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org) smtp.mailfrom=vnsh.in
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=T2Ffq5Oy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vnsh.in (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0Tj90TXYz30Tx
	for <linux-erofs@lists.ozlabs.org>; Wed, 22 Apr 2026 03:23:40 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1776792216; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=MT2LM/x17KM9NXMYcbshzSO/Pupsk9DRGh/unDvrb7daqujWBMpeBxUDAG2Nq2VVoY350bDX3q0R66EHUzzm6rkYQ1foUIhhgQC+ia9MxK/Nymp/Yt+hTCes9m8cd7K2E9Wf7F+2EBCO1N5QOoBkEh6Rw1cVyLkUK+EH+At7TRI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1776792216; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=xz+aCVaGYZl0T5ncZzO2ZDAzxbzHN+Zt5kaZL6Ky8Dc=; 
	b=Xp9kZ6ov4S/0JLjosO85AYE8BBw3RdIYPwPSByeyOZeuFCcil9d1LMXo+Hf1bJOwxG+P5Tn+7i8J4hufz43exemyNUEFe/OC+TGGdre6n84FSsuY2mOvSBkfMSrAdl/JQ+1or07Azw9xTi8veMVVmCVcgHKAVuv5OA4m0bqhBIM=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=vnsh.in;
	spf=pass  smtp.mailfrom=ch@vnsh.in;
	dmarc=pass header.from=<ch@vnsh.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776792216;
	s=zoho; d=vnsh.in; i=ch@vnsh.in;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=xz+aCVaGYZl0T5ncZzO2ZDAzxbzHN+Zt5kaZL6Ky8Dc=;
	b=T2Ffq5OyztFjOcS7ucMd5Y/0nKiNL2kZe5nPTSJPREx1l1U1Nndo0IXZZYCJth3V
	L5o3NLXfj4HE+9Gey+MThPKilea48pbFNp7fTbTm1yCcyrLwoM/CSATUvpSn27y/5tT
	cWkLBuJ3Oc4Zeki8yGYfY0fWMg1uOIbOmQ+uRCR8=
Received: by mx.zoho.in with SMTPS id 1776792212508110.28045043388033;
	Tue, 21 Apr 2026 22:53:32 +0530 (IST)
From: Vansh Choudhary <ch@vnsh.in>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: tests: add test for hardlink-to-root tar entries
Date: Tue, 21 Apr 2026 22:53:30 +0530
Message-ID: <20260421172330.142332-1-ch@vnsh.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <3b50f2bd-44ba-46e6-95ac-0331c3cfbc4c@linux.alibaba.com>
References: <3b50f2bd-44ba-46e6-95ac-0331c3cfbc4c@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[vnsh.in:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3351-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_ONE(0.00)[1];
	DMARC_NA(0.00)[vnsh.in];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[vnsh.in:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ch@vnsh.in,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 0259B43DE71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is a regression test for "erofs-utils: lib: check NULL from
erofs_rebuild_get_dentry()".

Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
 tests/Makefile.am   |  3 +++
 tests/erofs/031     | 58 +++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/031.out |  2 ++
 3 files changed, 63 insertions(+)
 create mode 100755 tests/erofs/031
 create mode 100644 tests/erofs/031.out

diff --git a/tests/Makefile.am b/tests/Makefile.am
index d8ac067..e7eacbe 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -126,6 +126,9 @@ TESTS += erofs/028
 # 029 - test FUSE daemon and kernel error handling on corrupted inodes
 TESTS += erofs/029
 
+# 031 - regression test for NULL dentry on hardlink-to-root tar entry
+TESTS += erofs/031
+
 # NEW TEST CASE HERE
 # TESTS += erofs/999
 
diff --git a/tests/erofs/031 b/tests/erofs/031
new file mode 100755
index 0000000..79f2a3e
--- /dev/null
+++ b/tests/erofs/031
@@ -0,0 +1,58 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+#
+# regression test for a NULL dentry crash in mkfs.erofs --tar when
+# a tar hardlink entry's linkname resolves to the root directory
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$(echo $0 | awk '{print $((NF-1))"/"$NF}' FS="/")
+
+# get standard environment, filters and checks
+. "${srcdir}/common/rc"
+
+cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+}
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+echo "QA output created by $seq"
+
+if [ -z $SCRATCH_DEV ]; then
+	SCRATCH_DEV=$tmp/erofs_$seq.img
+	rm -f $SCRATCH_DEV
+fi
+
+localdir="$tmp/$seq"
+rm -rf $localdir
+mkdir -p $localdir
+
+# two empty regular files; tar lays the second header at offset 512.
+: > $localdir/a
+: > $localdir/b
+(cd $localdir && tar --format=ustar -cf $tmp.tar a b) || \
+	_fail "failed to build input tar"
+
+# rewrite the second entry as a hardlink whose target is "."
+printf '1' | dd of=$tmp.tar bs=1 seek=668 count=1 conv=notrunc 2>/dev/null
+printf '.' | dd of=$tmp.tar bs=1 seek=669 count=1 conv=notrunc 2>/dev/null
+dd if=/dev/zero of=$tmp.tar bs=1 seek=670 count=99 conv=notrunc 2>/dev/null
+
+# recompute the ustar checksum (chksum field treated as 8 spaces)
+printf '        ' | dd of=$tmp.tar bs=1 seek=660 count=8 conv=notrunc 2>/dev/null
+sum=`dd if=$tmp.tar bs=512 skip=1 count=1 2>/dev/null | \
+	od -An -tu1 -v | awk '{for(i=1;i<=NF;i++)s+=$i}END{printf "%06o",s}'`
+printf '%s\000 ' "$sum" | dd of=$tmp.tar bs=1 seek=660 count=8 conv=notrunc 2>/dev/null
+
+$MKFS_EROFS_PROG --tar $SCRATCH_DEV $tmp.tar >> $seqres.full 2>&1
+rc=$?
+[ $rc -ge 128 ] && _fail "mkfs.erofs crashed on hardlink-to-root (rc=$rc)"
+[ $rc -eq 0 ] && _fail "mkfs.erofs unexpectedly accepted hardlink-to-root"
+
+echo Silence is golden
+status=0
+exit 0
diff --git a/tests/erofs/031.out b/tests/erofs/031.out
new file mode 100644
index 0000000..b3d0bb0
--- /dev/null
+++ b/tests/erofs/031.out
@@ -0,0 +1,2 @@
+QA output created by 031
+Silence is golden
-- 
2.43.0


