Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B966CA43A
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Mar 2023 14:39:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PlXSr757Wz3c7l
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Mar 2023 23:39:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PlXSk4k9lz2xH6
	for <linux-erofs@lists.ozlabs.org>; Mon, 27 Mar 2023 23:39:33 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VeocZaA_1679920766;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VeocZaA_1679920766)
          by smtp.aliyun-inc.com;
          Mon, 27 Mar 2023 20:39:27 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: tests: add test for xattrs in different layouts
Date: Mon, 27 Mar 2023 20:39:26 +0800
Message-Id: <20230327123926.92934-1-jefflexu@linux.alibaba.com>
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

Test xattr in following layouts:

- multiple inline xattrs for one single file
- multiple share xattrs for one single file
- mixed inline and share xattrs for one single file
- name/value field of xattr crossing block boundary

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
changes since v1:
- make this test a new testcase, aka. erofs/020
- make it compatible with erofs-utils that doesn't support '-b
  #blocksize' feature yet. Now the testcase will try mkfs with '-b 1024'
  first, and retry with '-b 1024' dropped if the previous attempt fails.
---
 tests/Makefile.am   |  3 ++
 tests/erofs/020     | 95 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/020.out |  2 ++
 3 files changed, 100 insertions(+)
 create mode 100755 tests/erofs/020
 create mode 100644 tests/erofs/020.out

diff --git a/tests/Makefile.am b/tests/Makefile.am
index b85ae89..67e2bbc 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -91,6 +91,9 @@ TESTS += erofs/018
 # 019 - check extended attribute functionality
 TESTS += erofs/019
 
+# 020 - check extended attribute in different layouts
+TESTS += erofs/020
+
 EXTRA_DIST = common/rc erofs
 
 clean-local: clean-local-check
diff --git a/tests/erofs/020 b/tests/erofs/020
new file mode 100755
index 0000000..8b345bf
--- /dev/null
+++ b/tests/erofs/020
@@ -0,0 +1,95 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# 020 - check extended attribute in different layouts
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
+# set random xattrs
+
+# file1: multiple inline xattrs
+touch $localdir/file1
+setfattr -n user.p$(generate_random 16) -v $(generate_random 16) $localdir/file1
+# inline xattr (large name/value crossing block boundary)
+setfattr -n user.p$(generate_random 249) -v $(generate_random 1024) $localdir/file1
+
+# file2: multiple share xattrs
+s_key_1=$(generate_random 16)
+s_key_2=$(generate_random 16)
+s_val=$(generate_random 16)
+
+touch $localdir/file2
+setfattr -n user.s$s_key_1 -v $s_val $localdir/file2
+setfattr -n user.s$s_key_2 -v $s_val $localdir/file2
+
+# file3: mixed inline and share xattrs
+touch $localdir/file3
+setfattr -n user.p$(generate_random 16) -v $(generate_random 16) $localdir/file3
+setfattr -n user.s$s_key_1 -v $s_val $localdir/file3
+
+# file4: share xattr
+touch $localdir/file4
+setfattr -n user.s$s_key_2 -v $s_val $localdir/file4
+
+# Specify 1024 blocksize explicitly so that the large name/value of file1
+# could cross the block boundary. Retry without '-b #blocksize' if mkfs.erofs
+# doesn't support this feature yet.
+BASE_MKFS_OPTIONS="$MKFS_OPTIONS -x1"
+MKFS_OPTIONS="$BASE_MKFS_OPTIONS -b1024"
+_scratch_mkfs $localdir >> $seqres.full 2>&1
+if [ $? -ne 0 ]; then
+	MKFS_OPTIONS="$BASE_MKFS_OPTIONS"
+	_scratch_mkfs $localdir >> $seqres.full 2>&1 || _fail "failed to mkfs"
+fi
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
diff --git a/tests/erofs/020.out b/tests/erofs/020.out
new file mode 100644
index 0000000..20d7944
--- /dev/null
+++ b/tests/erofs/020.out
@@ -0,0 +1,2 @@
+QA output created by 020
+Silence is golden
-- 
1.8.3.1

