Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A746DD7F3
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Apr 2023 12:30:15 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PwhtY2dmxz3cLx
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Apr 2023 20:30:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PwhtV45djz3bjb
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Apr 2023 20:30:09 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vfrzwwx_1681209004;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vfrzwwx_1681209004)
          by smtp.aliyun-inc.com;
          Tue, 11 Apr 2023 18:30:05 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: tests: add test for long xattr name prefixes
Date: Tue, 11 Apr 2023 18:30:04 +0800
Message-Id: <20230411103004.104064-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
v2: test the scenario where normal xattrs and long prefix xattrs mixed in
one file
---
 tests/Makefile.am   |  3 ++
 tests/erofs/021     | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/021.out |  2 ++
 3 files changed, 99 insertions(+)
 create mode 100755 tests/erofs/021
 create mode 100644 tests/erofs/021.out

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 67e2bbc..be2dfd9 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -94,6 +94,9 @@ TESTS += erofs/019
 # 020 - check extended attribute in different layouts
 TESTS += erofs/020
 
+# 021 - check long extended attribute name prefixes
+TESTS += erofs/021
+
 EXTRA_DIST = common/rc erofs
 
 clean-local: clean-local-check
diff --git a/tests/erofs/021 b/tests/erofs/021
new file mode 100755
index 0000000..3d598a8
--- /dev/null
+++ b/tests/erofs/021
@@ -0,0 +1,94 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# 021 - check long extended attribute name prefixes
+#
+set -x
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
+generate_random()
+{
+	head -20 /dev/urandom | base64 -w0 | head -c $1
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
+# set random xattrs (mix of normal xattrs and long prefix xattrs)
+
+# file1: multiple inline xattrs
+touch $localdir/file1
+setfattr -n user.infix.p$(generate_random 16) -v $(generate_random 16) $localdir/file1
+setfattr -n user.infix.p$(generate_random 16) -v $(generate_random 16) $localdir/file1
+setfattr -n user.p$(generate_random 16) -v $(generate_random 16) $localdir/file1
+setfattr -n user.p$(generate_random 16) -v $(generate_random 16) $localdir/file1
+
+# file2: multiple share xattrs
+s_key_1=$(generate_random 16)
+s_key_2=$(generate_random 16)
+s_val=$(generate_random 16)
+
+touch $localdir/file2
+setfattr -n user.infix.s$s_key_1 -v $s_val $localdir/file2
+setfattr -n user.infix.s$s_key_2 -v $s_val $localdir/file2
+setfattr -n user.s$s_key_1 -v $s_val $localdir/file2
+setfattr -n user.s$s_key_2 -v $s_val $localdir/file2
+
+# file3: mixed inline and share xattrs
+touch $localdir/file3
+setfattr -n user.infix.p$(generate_random 16) -v $(generate_random 16) $localdir/file3
+setfattr -n user.infix.s$s_key_1 -v $s_val $localdir/file3
+setfattr -n user.p$(generate_random 16) -v $(generate_random 16) $localdir/file3
+setfattr -n user.s$s_key_1 -v $s_val $localdir/file3
+
+# file4: share xattr
+touch $localdir/file4
+setfattr -n user.infix.s$s_key_2 -v $s_val $localdir/file4
+setfattr -n user.s$s_key_2 -v $s_val $localdir/file4
+
+# specify long xattr name prefix through "--xattr-prefix"
+MKFS_OPTIONS="$MKFS_OPTIONS -x1 --xattr-prefix=user.infix."
+_scratch_mkfs $localdir >> $seqres.full 2>&1 || _fail "failed to mkfs"
+_scratch_mount 2>>$seqres.full
+
+# check xattrs
+dirs=`ls $localdir`
+for d in $dirs; do
+	xattr1=`getfattr --absolute-names -d $localdir/$d | tail -n+2`
+	xattr2=`getfattr --absolute-names -d $SCRATCH_MNT/$d | tail -n+2`
+	[ "x$xattr1" = "x$xattr2" ] || _fail "-->check xattrs FAILED"
+done
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

