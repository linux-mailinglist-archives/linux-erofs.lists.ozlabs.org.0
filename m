Return-Path: <linux-erofs+bounces-3208-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJEREaRz1GmyuAcAu9opvQ
	(envelope-from <linux-erofs+bounces-3208-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 05:01:56 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD663A94B2
	for <lists+linux-erofs@lfdr.de>; Tue, 07 Apr 2026 05:01:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqWFC1N2kz2ydq;
	Tue, 07 Apr 2026 13:01:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775530911;
	cv=none; b=GdHz5BrkqlXR3rYPS3i7cAS9+wBc4uyWvcPNhD106N+MSL/jKqsP6L3B7xlgUoqqf0tT1ORr7oVCXOxWggeT/YgEBZHJFCD/88ZMGwEbCx14dg4jIqoATeLNB1gtzx4Tw3QCVUHuoMYeEKKDhRXm9iEDURMn1snU7uR9wfcS+RmH+maZh5npEwsl/TSSNVsECeA8LwLiBt2njIzKAx2PHyjF4vhzziDSadL5S9F5iid9yBh8nWkRnRcR3oiSBHs1KdmVb+6VkXBqshtkkCg10xJGvldhCXmYtOjOlQXxT9/rSCxaAjOAO3lVx0BqcSN+CQ+0v30uAQDauLVHVT483w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775530911; c=relaxed/relaxed;
	bh=wdiDY3ug5VJyz5aABp3FVkIBuAvMJjN78schmqcc56U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T31XjDiwh3xHIUWWKJ3TAAaPyijmRhzdQpObVELYxJOjURH27q/OOEyxoPryHiT8/6shqNf6FCXJ9FgT3WASYE5qwa4UfpD7cg/cfdXGtln1CVnKFhrG/fCFHCwsYbTZlDFhzXdg8UAhpwZCnfHVZQHb10imEEYCgwgUwjDVsU1022IIJRpW98dpDeO59XeCf0c3OANA/VIXW7srIZnUgnjlviOuO+o8Pxj3c2galYtAdLC8eK+BqnJhIcJq85cPDyPHdDBkHiY/CAL2MUkS7odh3Um2+pCwVEVyK/DhY92ukOzk1CDyUP/qsZ/dAqDgwoS3lbbo745FBl7SHdmEZA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wa6WnolF; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wa6WnolF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqWF71KZFz2xQs
	for <linux-erofs@lists.ozlabs.org>; Tue, 07 Apr 2026 13:01:44 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1775530900; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wdiDY3ug5VJyz5aABp3FVkIBuAvMJjN78schmqcc56U=;
	b=wa6WnolF9kg9rCsvNt5L4+CxmdI8Q0Ko2Y1UVp/kQ/x72+QkKvh69EmlPeWZg2HAyek5eYBuR2PKiW4jpzr3xQ8dS3U2zkwgNAJb2YyagB9tG80fklxK5omf8X9FO4aEEOK+HcrLfr6QoDprteN04pHS8THjUFSpdZbLrd21gYo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X0aPESZ_1775530893;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X0aPESZ_1775530893 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 07 Apr 2026 11:01:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Nithurshen <nithurshen.dev@gmail.com>,
	Gao Xiang <xiang@kernel.org>
Subject: [PATCH v6 experimental-tests] erofs-utils: tests: test FUSE error handling on corrupted inodes
Date: Tue,  7 Apr 2026 11:01:32 +0800
Message-ID: <20260407030132.2606768-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260403003452.4626-1-nithurshen.dev@gmail.com>
References: <20260403003452.4626-1-nithurshen.dev@gmail.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3208-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: CDD663A94B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Nithurshen <nithurshen.dev@gmail.com>

This patch introduces a regression test to verify that the FUSE daemon
gracefully handles corrupted inodes without crashing or violating the
FUSE protocol.

Recently, a bug was identified where erofs_read_inode_from_disk()
would fail, but erofsfuse_getattr() lacked a return statement
after sending an error reply. This caused a fall-through, sending
a second reply via fuse_reply_attr() and triggering a libfuse
segmentation fault.

To prevent future regressions, this test:
1. Creates a valid EROFS image.
2. Uses dump.erofs to dynamically determine the root directory's
   inode NID and metadata block address.
3. Deterministically corrupts the root inode by injecting 32 bytes
   of 0xFF, invalidating its layout while leaving the superblock intact.
4. Mounts the image in the foreground to capture daemon stderr.
5. Runs `stat` on the root directory to trigger the inode read failure.
6. Evaluates the stderr log to ensure no segfaults, aborts, or
   "multiple replies" warnings are emitted by libfuse.

Signed-off-by: Nithurshen <nithurshen.dev@gmail.com>
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
I will apply this refined version.

 tests/Makefile.am   |  4 ++
 tests/erofs/029     | 93 +++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/029.out |  2 +
 3 files changed, 99 insertions(+)
 create mode 100755 tests/erofs/029
 create mode 100644 tests/erofs/029.out

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 226955cdccbd..d8ac067805e8 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -22,6 +22,7 @@ TESTS_ENVIRONMENT = \
 	fi; \
 	[ -z $$MKFS_EROFS_PROG ] && export MKFS_EROFS_PROG=../mkfs/mkfs.erofs; \
 	[ -z $$FSCK_EROFS_PROG ] && export FSCK_EROFS_PROG=../fsck/fsck.erofs; \
+	[ -z $$DUMP_EROFS_PROG ] && export DUMP_EROFS_PROG=../dump/dump.erofs; \
 	[ -z $$EROFSFUSE_PROG ] && export EROFSFUSE_PROG=../fuse/erofsfuse;
 
 if ENABLE_LZ4
@@ -122,6 +123,9 @@ TESTS += erofs/027
 # 028 - test inode page cache sharing functionality
 TESTS += erofs/028
 
+# 029 - test FUSE daemon and kernel error handling on corrupted inodes
+TESTS += erofs/029
+
 # NEW TEST CASE HERE
 # TESTS += erofs/999
 
diff --git a/tests/erofs/029 b/tests/erofs/029
new file mode 100755
index 000000000000..82fdd5d01892
--- /dev/null
+++ b/tests/erofs/029
@@ -0,0 +1,93 @@
+#!/bin/sh
+# SPDX-License-Identifier: MIT
+#
+# Test FUSE daemon and kernel error handling on corrupted inodes
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$(echo $0 | awk '{print $((NF-1))"/"$NF}' FS="/")
+
+# get standard environment, filters and checks
+. "${srcdir}/common/rc"
+
+_cleanup()
+{
+	cd /
+	rm -rf $tmp.*
+	# Ensure we kill our background daemon if it's still alive
+	[ -n "$fuse_pid" ] && kill -9 $fuse_pid 2>/dev/null
+}
+
+_require_erofs
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+echo "QA output created by $seq"
+
+if [ -z "$SCRATCH_DEV" ]; then
+	SCRATCH_DEV=$tmp/erofs_$seq.img
+	rm -f $SCRATCH_DEV
+fi
+
+localdir="$tmp/$seq"
+rm -rf $localdir
+mkdir -p $localdir
+
+echo "test data" > $localdir/testfile
+
+_scratch_mkfs -T0 --all-time -Enosbcrc $localdir >> $seqres.full 2>&1 || _fail "failed to mkfs"
+
+sbdump=$($DUMP_EROFS_PROG $SCRATCH_DEV)
+meta_blkaddr=$(printf "$sbdump" | grep -i "meta_blkaddr" | grep -oE '[0-9]+' | head -n 1)
+[ -n "$meta_blkaddr" ] && _fail "failed get get meta_blkaddr"
+blocksize=$(printf "$sbdump" | grep -i "block size" | grep -oE '[0-9]+' | head -n 1)
+[ -n "$blocksize" ] && _fail "failed to get block size"
+
+victim=$($DUMP_EROFS_PROG --path=/ $SCRATCH_DEV | grep -iE 'nid\s*[:=]?\s*[0-9]+' -o | grep -oE '[0-9]+' | head -n 1)
+[ -z "$victim" ] && _fail "failed to find root NID"
+
+seeko=$((meta_blkaddr*blocksize+victim*32))
+
+# Deterministically corrupt the root inode's layout by writing 32 bytes of 0xFF
+awk 'BEGIN { for(i=0;i<32;i++) printf "\377" }' | \
+	dd of=$SCRATCH_DEV bs=1 seek=$seeko count=32 conv=notrunc >> $seqres.full 2>&1
+
+if [ "$FSTYP" = "erofsfuse" ]; then
+	[ -z "$EROFSFUSE_PROG" ] && _notrun "erofsfuse is not available"
+	# Run erofsfuse in the foreground to capture libfuse's internal stderr
+	$EROFSFUSE_PROG -f $SCRATCH_DEV $SCRATCH_MNT > $tmp/erofsfuse.log 2>&1 &
+	fuse_pid=$!
+	# Wait for the mount to establish
+	sleep 1
+elif ! _try_scratch_mount >> $seqres.full 2>&1; then
+	echo Silence is golden
+	status=0
+	exit 0
+fi
+
+# Attempt to stat the root directory to directly trigger getattr without a lookup
+timeout 5 stat $SCRATCH_MNT >> $seqres.full 2>&1
+res=$?
+[ $res -eq 124 ] && _fail "stat command timed out (kernel hung?)"
+[ $res -eq 0 ] && _fail "stat unexpectedly succeeded on a corrupted image"
+
+if [ "$FSTYP" = "erofsfuse" ]; then
+	_scratch_unmount >> $seqres.full 2>&1
+	# Wait for the daemon to cleanly exit, or kill it if stuck
+	kill $fuse_pid 2>/dev/null
+	wait $fuse_pid 2>/dev/null
+	cat $tmp/erofsfuse.log >> $seqres.full
+
+	if grep -q -i "multiple replies" $tmp/erofsfuse.log; then
+		_fail "Bug detected: libfuse reported multiple replies to request"
+	elif grep -q -i "segmentation fault\|aborted" $tmp/erofsfuse.log; then
+		_fail "Bug detected: FUSE daemon crashed"
+	fi
+else
+	_scratch_unmount >> $seqres.full 2>&1
+fi
+
+echo Silence is golden
+status=0
+exit 0
diff --git a/tests/erofs/029.out b/tests/erofs/029.out
new file mode 100644
index 000000000000..8ee6db49fd4d
--- /dev/null
+++ b/tests/erofs/029.out
@@ -0,0 +1,2 @@
+QA output created by 029
+Silence is golden
-- 
2.43.5


