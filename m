Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF9D71076D
	for <lists+linux-erofs@lfdr.de>; Thu, 25 May 2023 10:32:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QRhBP1cKkz3fDH
	for <lists+linux-erofs@lfdr.de>; Thu, 25 May 2023 18:32:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QRhB4023mz3f6n
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 May 2023 18:32:11 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VjRUz.s_1685003525;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VjRUz.s_1685003525)
          by smtp.aliyun-inc.com;
          Thu, 25 May 2023 16:32:06 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/5] erofs-utils: tests: add test for xattr crossing block boundary
Date: Thu, 25 May 2023 16:32:00 +0800
Message-Id: <20230525083201.23740-5-jefflexu@linux.alibaba.com>
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

Test the extended attribute which crosses block boundary.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 tests/Makefile.am   |  3 +++
 tests/common/rc     |  6 ++++++
 tests/erofs/021     | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/021.out |  2 ++
 4 files changed, 71 insertions(+)
 create mode 100755 tests/erofs/021
 create mode 100644 tests/erofs/021.out

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 1d6ea5c..61bbb4d 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -94,6 +94,9 @@ TESTS += erofs/019
 # 020 - check extended attributes in different layouts
 TESTS += erofs/020
 
+# 021 - check extended attributes crossing block boundary
+TESTS += erofs/021
+
 EXTRA_DIST = common/rc erofs
 
 clean-local: clean-local-check
diff --git a/tests/common/rc b/tests/common/rc
index 293e556..0361c68 100644
--- a/tests/common/rc
+++ b/tests/common/rc
@@ -92,6 +92,12 @@ _require_xattr()
 		_notrun "attr isn't installed, skipped."
 }
 
+_require_mkfs_blksize()
+{
+	"$MKFS_EROFS_PROG" --help 2>&1 | grep -q -- '-b#' ||
+		_notrun "-b# feature needed for mkfs.erofs"
+}
+
 # this test requires erofs kernel support
 _require_erofs()
 {
diff --git a/tests/erofs/021 b/tests/erofs/021
new file mode 100755
index 0000000..d36aa56
--- /dev/null
+++ b/tests/erofs/021
@@ -0,0 +1,60 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# 021 - check extended attributes crossing block boundary
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
+_require_mkfs_blksize
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
+# set inline xattr (large name/value crossing block boundary)
+# given blksize will be set to 512 later, it is ensured that xattr values
+# cross the block boundary; besides set three xattrs to ensure at least
+# one xattr name crosses the block boundary
+touch $localdir/file1
+for i in {1..3}; do
+	setfattr -n user.p$(_random 249) -v $(_random 512) $localdir/file1 \
+		|| _notrun "no space for xattrs"
+done
+
+# specify 512 blocksize explicitly so that the large name/value of file1
+# could cross the block boundary
+MKFS_OPTIONS="$MKFS_OPTIONS -b512"
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
diff --git a/tests/erofs/021.out b/tests/erofs/021.out
new file mode 100644
index 0000000..09f4062
--- /dev/null
+++ b/tests/erofs/021.out
@@ -0,0 +1,2 @@
+QA output created by 021
+Silence is golden
-- 
1.8.3.1

