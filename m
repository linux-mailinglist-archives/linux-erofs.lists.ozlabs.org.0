Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D51583E5B
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Jul 2022 14:09:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LtqGC1Zsgz2xJW
	for <lists+linux-erofs@lfdr.de>; Thu, 28 Jul 2022 22:09:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57; helo=out30-57.freemail.mail.aliyun.com; envelope-from=jnhuang@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LtqG31qFKz2xHg
	for <linux-erofs@lists.ozlabs.org>; Thu, 28 Jul 2022 22:09:45 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jnhuang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VKfZY1b_1659010162;
Received: from localhost.localdomain(mailfrom:jnhuang@linux.alibaba.com fp:SMTPD_---0VKfZY1b_1659010162)
          by smtp.aliyun-inc.com;
          Thu, 28 Jul 2022 20:09:24 +0800
From: Huang Jianan <jnhuang@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/2] erofs-utils: tests: add random test for xattrs
Date: Thu, 28 Jul 2022 20:09:10 +0800
Message-Id: <20220728120910.61636-2-jnhuang@linux.alibaba.com>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
In-Reply-To: <20220728120910.61636-1-jnhuang@linux.alibaba.com>
References: <20220728120910.61636-1-jnhuang@linux.alibaba.com>
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

Add random functional check for xattrs.

Signed-off-by: Huang Jianan <jnhuang@linux.alibaba.com>
---
 tests/Makefile.am   |  3 ++
 tests/erofs/020     | 72 +++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/020.out |  2 ++
 3 files changed, 77 insertions(+)
 create mode 100755 tests/erofs/020
 create mode 100644 tests/erofs/020.out

diff --git a/tests/Makefile.am b/tests/Makefile.am
index b85ae89..d486ce3 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -91,6 +91,9 @@ TESTS += erofs/018
 # 019 - check extended attribute functionality
 TESTS += erofs/019
 
+# 020 - test random extended attribute functionality for mkfs and fuse
+TESTS += erofs/020
+
 EXTRA_DIST = common/rc erofs
 
 clean-local: clean-local-check
diff --git a/tests/erofs/020 b/tests/erofs/020
new file mode 100755
index 0000000..77409dd
--- /dev/null
+++ b/tests/erofs/020
@@ -0,0 +1,72 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# 020 - check extended attribute functionality
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
+check_xattrs()
+{
+	_scratch_mount 2>>$seqres.full
+
+	# check xattrs
+	for d in $dirs; do
+		xattr1=`getfattr --absolute-names -d $localdir/$d | tail -n+2`
+		xattr2=`getfattr --absolute-names -d $SCRATCH_MNT/$d | tail -n+2`
+		[ "x$xattr1" = "x$xattr2" ] || _fail "-->check xattrs FAILED"
+	done
+
+	_scratch_unmount
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
+have_attr=`which setfattr`
+[ -z "$have_attr" ] && \
+	_notrun "attr isn't installed, skipped."
+
+if [ -z $SCRATCH_DEV ]; then
+	SCRATCH_DEV=$tmp/erofs_$seq.img
+	rm -f SCRATCH_DEV
+fi
+
+localdir="$tmp/$seq"
+rm -rf $localdir
+mkdir -p $localdir
+
+# set random xattrs
+cp -nR ../ $localdir
+dirs=`ls $localdir`
+for d in $dirs; do
+	for i in `seq $((RANDOM % 20))`; do
+		key=`head -20 /dev/urandom | cksum | cut -f1 -d " "`
+		val="0s"`head -3 /dev/urandom | base64 -w0`
+		setfattr -n user.$key -v $val $localdir/$d
+	done
+done
+
+_scratch_mkfs $localdir >> $seqres.full 2>&1 || _fail "failed to mkfs"
+check_xattrs
+
+FSTYP="erofsfuse"
+check_xattrs
+
+echo Silence is golden
+status=0
+exit 0
diff --git a/tests/erofs/020.out b/tests/erofs/020.out
new file mode 100644
index 0000000..20d7944
--- /dev/null
+++ b/tests/erofs/020.out
@@ -0,0 +1,2 @@
+QA output created by 020
+Silence is golden
-- 
2.34.1

