Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A56D5B2C18
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Sep 2022 04:23:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MP0Cy5bZnz3bYS
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Sep 2022 12:23:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57; helo=out30-57.freemail.mail.aliyun.com; envelope-from=jnhuang@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MP0Cr6MSjz2yWl
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Sep 2022 12:23:36 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jnhuang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VP7G-q-_1662689909;
Received: from localhost.localdomain(mailfrom:jnhuang@linux.alibaba.com fp:SMTPD_---0VP7G-q-_1662689909)
          by smtp.aliyun-inc.com;
          Fri, 09 Sep 2022 10:18:29 +0800
From: Huang Jianan <jnhuang@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/4] erofs-utils: tests: add test for dump.erofs
Date: Fri,  9 Sep 2022 10:18:15 +0800
Message-Id: <20220909021816.10544-3-jnhuang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220909021816.10544-1-jnhuang@linux.alibaba.com>
References: <20220909021816.10544-1-jnhuang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add basic functional check for dump.erofs.

Signed-off-by: Huang Jianan <jnhuang@linux.alibaba.com>
---
 tests/Makefile.am   |  6 +++-
 tests/erofs/021     | 83 +++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/021.out |  2 ++
 3 files changed, 90 insertions(+), 1 deletion(-)
 create mode 100755 tests/erofs/021
 create mode 100644 tests/erofs/021.out

diff --git a/tests/Makefile.am b/tests/Makefile.am
index b85ae89..bb1624d 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -22,7 +22,8 @@ TESTS_ENVIRONMENT = \
 	fi; \
 	[ -z $$MKFS_EROFS_PROG ] && export MKFS_EROFS_PROG=../mkfs/mkfs.erofs; \
 	[ -z $$FSCK_EROFS_PROG ] && export FSCK_EROFS_PROG=../fsck/fsck.erofs; \
-	[ -z $$EROFSFUSE_PROG ] && export EROFSFUSE_PROG=../fuse/erofsfuse;
+	[ -z $$EROFSFUSE_PROG ] && export EROFSFUSE_PROG=../fuse/erofsfuse; \
+	[ -z $$DUMP_EROFS_PROG ] && export DUMP_EROFS_PROG=../dump/dump.erofs;
 
 if ENABLE_LZ4
 TESTS_ENVIRONMENT += export lz4_on=1;
@@ -91,6 +92,9 @@ TESTS += erofs/018
 # 019 - check extended attribute functionality
 TESTS += erofs/019
 
+# 021 - check dump basic functionality
+TESTS += erofs/021
+
 EXTRA_DIST = common/rc erofs
 
 clean-local: clean-local-check
diff --git a/tests/erofs/021 b/tests/erofs/021
new file mode 100755
index 0000000..2bb45e7
--- /dev/null
+++ b/tests/erofs/021
@@ -0,0 +1,83 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# 021 check dump basic functionality
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
+_require_erofs
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+echo "QA output created by $seq"
+
+[ -z "$lz4hc_on" ] && \
+	_notrun "lz4hc compression is disabled, skipped."
+
+if [ -z ]; then
+	SCRATCH_DEV=$tmp/erofs_$seq.img
+	rm -f SCRATCH_DEV
+fi
+
+localdir="$tmp/$seq"
+rm -rf $localdir
+mkdir -p $localdir
+
+# collect files pending for verification
+dirs=`find ../ -maxdepth 1 -type d -printf '%p:'`
+IFS=':'
+for d in $dirs; do
+	[ $d = '../' ] && continue
+	[ -z "${d##\.\./tests*}" ] && continue
+	[ -z "${d##\.\./\.*}" ] && continue
+	cp -nR $d $localdir
+done
+unset IFS
+
+uuid="98136b8d-d5a7-429c-b6ea-2021f19d7d93"
+timestamp="Thu Jan  1 08:00:00 1970"
+
+MKFS_OPTIONS="${MKFS_OPTIONS} -zlz4hc -T0 -U$uuid"
+_scratch_mkfs $localdir >> $seqres.full 2>&1 || _fail "failed to mkfs"
+_scratch_mount 2>>$seqres.full
+
+do_dump="$DUMP_EROFS_PROG $SCRATCH_DEV"
+echo "dump information for $SCRATCH_DEV" >>$seqres.full
+
+uuid_dump=`$do_dump |awk '/UUID/{print $3}'`
+echo "uuid: $uuid_dump" >>$seqres.full
+[ "x$uuid" = "x$uuid_dump" ] || _fail "check uuid fail"
+
+timestamp_dump=`$do_dump |awk -F"created:[ ]+" '/created:/{print $2}'`
+echo "timestamp: $timestamp_dump" >>$seqres.full
+[ "x$timestamp" = "x$timestamp_dump" ] || _fail "check timestamp fail"
+
+nid_sb=`$do_dump |awk '/root nid/{print $4}'`
+echo "root nid from superblock: $nid_sb" >>$seqres.full
+nid_ino=`$do_dump --path=/ |awk '/NID/{print $2}'`
+echo "root nid from inode: $nid_ino" >>$seqres.full
+[ "x$nid_sb" = "x$nid_ino" ] || _fail "check root nid fail"
+
+dirs_dump=`$do_dump --path=/ --ls |awk '/\s*[0-9]+\s+[0-9]+\s+/{print $3}'`
+echo "list root directory:\n$dirs_dump" >>$seqres.full
+dirs_ls=`ls -aU $SCRATCH_MNT`
+echo "list root directory for $SCRATCH_MNT:\n$dirs_ls" >>$seqres.full
+[ "x$dirs_dump" = "x$dirs_ls" ] || _fail "check ls fail"
+
+_scratch_unmount
+
+echo Silence is golden
+status=0
+exit 0
diff --git a/tests/erofs/021.out b/tests/erofs/021.out
new file mode 100644
index 0000000..09f4062
--- /dev/null
+++ b/tests/erofs/021.out
@@ -0,0 +1,2 @@
+QA output created by 021
+Silence is golden
-- 
2.34.1

