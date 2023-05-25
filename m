Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D684871076A
	for <lists+linux-erofs@lfdr.de>; Thu, 25 May 2023 10:32:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QRhBH5DyJz3f8f
	for <lists+linux-erofs@lfdr.de>; Thu, 25 May 2023 18:32:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QRhB16Jr9z3f67
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 May 2023 18:32:08 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VjRUz-S_1685003523;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VjRUz-S_1685003523)
          by smtp.aliyun-inc.com;
          Thu, 25 May 2023 16:32:04 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/5] erofs-utils: tests: add test for xattrs
Date: Thu, 25 May 2023 16:31:58 +0800
Message-Id: <20230525083201.23740-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230525083201.23740-1-jefflexu@linux.alibaba.com>
References: <20230525083201.23740-1-jefflexu@linux.alibaba.com>
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

From: Huang Jianan <huangjianan@oppo.com>

Add basic functional check for xattrs.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 tests/Makefile.am   |  3 +++
 tests/erofs/019     | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/019.out |  2 ++
 3 files changed, 60 insertions(+)
 create mode 100755 tests/erofs/019
 create mode 100644 tests/erofs/019.out

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 3bd6ad5..b85ae89 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -88,6 +88,9 @@ TESTS += erofs/017
 # 018 - verify lzma compressed image
 TESTS += erofs/018
 
+# 019 - check extended attribute functionality
+TESTS += erofs/019
+
 EXTRA_DIST = common/rc erofs
 
 clean-local: clean-local-check
diff --git a/tests/erofs/019 b/tests/erofs/019
new file mode 100755
index 0000000..0b89b77
--- /dev/null
+++ b/tests/erofs/019
@@ -0,0 +1,55 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# 019 - check extended attribute functionality
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
+_require_xattr
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+echo "QA output created by $seq"
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
+	key=`head -20 /dev/urandom | cksum | cut -f1 -d " "`
+	val="0s"`head -3 /dev/urandom | base64 -w0`
+	setfattr -n user.$key -v $val $localdir/$d
+done
+
+_scratch_mkfs $localdir >> $seqres.full 2>&1 || _fail "failed to mkfs"
+_scratch_mount 2>>$seqres.full
+
+# check xattrs
+_check_xattrs $localdir $SCRATCH_MNT
+
+_scratch_unmount
+
+echo Silence is golden
+status=0
+exit 0
diff --git a/tests/erofs/019.out b/tests/erofs/019.out
new file mode 100644
index 0000000..163484b
--- /dev/null
+++ b/tests/erofs/019.out
@@ -0,0 +1,2 @@
+QA output created by 019
+Silence is golden
-- 
1.8.3.1

