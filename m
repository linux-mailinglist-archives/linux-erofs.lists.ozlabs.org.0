Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 111F1710774
	for <lists+linux-erofs@lfdr.de>; Thu, 25 May 2023 10:32:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QRhBR6cJbz3fBX
	for <lists+linux-erofs@lfdr.de>; Thu, 25 May 2023 18:32:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QRhB40SQ2z3f7D
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 May 2023 18:32:11 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VjRUz0r_1685003527;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VjRUz0r_1685003527)
          by smtp.aliyun-inc.com;
          Thu, 25 May 2023 16:32:07 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 5/5] erofs-utils: tests: add test for long xattr name prefixes
Date: Thu, 25 May 2023 16:32:01 +0800
Message-Id: <20230525083201.23740-6-jefflexu@linux.alibaba.com>
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

mkfs.erofs supports user specified long xattr name prefix through
"--xattr_prefix" option.

Add test case for this feature.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 tests/Makefile.am   |  3 +++
 tests/common/rc     |  6 +++++
 tests/erofs/022     | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/022.out |  2 ++
 4 files changed, 88 insertions(+)
 create mode 100755 tests/erofs/022
 create mode 100644 tests/erofs/022.out

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 61bbb4d..6295964 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -97,6 +97,9 @@ TESTS += erofs/020
 # 021 - check extended attributes crossing block boundary
 TESTS += erofs/021
 
+# 022 - check long extended attribute name prefixes
+TESTS += erofs/022
+
 EXTRA_DIST = common/rc erofs
 
 clean-local: clean-local-check
diff --git a/tests/common/rc b/tests/common/rc
index 0361c68..dcd63a9 100644
--- a/tests/common/rc
+++ b/tests/common/rc
@@ -98,6 +98,12 @@ _require_mkfs_blksize()
 		_notrun "-b# feature needed for mkfs.erofs"
 }
 
+_require_mkfs_long_prefix()
+{
+	"$MKFS_EROFS_PROG" --help 2>&1 | grep -q -- '--xattr-prefix' ||
+		_notrun "long name prefix feature needed for mkfs.erofs"
+}
+
 # this test requires erofs kernel support
 _require_erofs()
 {
diff --git a/tests/erofs/022 b/tests/erofs/022
new file mode 100755
index 0000000..0ca4785
--- /dev/null
+++ b/tests/erofs/022
@@ -0,0 +1,77 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# 022 - check long extended attribute name prefixes
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
+_require_mkfs_long_prefix
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
+# set random xattrs (mix of normal xattrs and long prefix xattrs)
+
+# preapre key/value of shared xattrs
+s_key_1=$(_srandom)
+s_key_2=$(_srandom)
+s_val=$(_srandom)
+
+# file1: multiple inline xattrs
+touch $localdir/file1
+setfattr -n user.infix.p$(_srandom) -v $(_srandom) $localdir/file1
+setfattr -n user.infix.p$(_srandom) -v $(_srandom) $localdir/file1
+setfattr -n user.p$(_srandom) -v $(_srandom) $localdir/file1
+setfattr -n user.p$(_srandom) -v $(_srandom) $localdir/file1
+
+# file2: multiple share xattrs
+touch $localdir/file2
+setfattr -n user.infix.s$s_key_1 -v $s_val $localdir/file2
+setfattr -n user.infix.s$s_key_2 -v $s_val $localdir/file2
+setfattr -n user.s$s_key_1 -v $s_val $localdir/file2
+setfattr -n user.s$s_key_2 -v $s_val $localdir/file2
+
+# file3: mixed inline and share xattrs
+touch $localdir/file3
+setfattr -n user.infix.p$(_srandom) -v $(_srandom) $localdir/file3
+setfattr -n user.infix.s$s_key_1 -v $s_val $localdir/file3
+setfattr -n user.p$(_srandom) -v $(_srandom) $localdir/file3
+setfattr -n user.s$s_key_1 -v $s_val $localdir/file3
+
+# specify long xattr name prefix through "--xattr-prefix"
+MKFS_OPTIONS="$MKFS_OPTIONS -x1 --xattr-prefix=user.infix."
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
diff --git a/tests/erofs/022.out b/tests/erofs/022.out
new file mode 100644
index 0000000..394c6a7
--- /dev/null
+++ b/tests/erofs/022.out
@@ -0,0 +1,2 @@
+QA output created by 022
+Silence is golden
-- 
1.8.3.1

