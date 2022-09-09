Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963735B2C1A
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Sep 2022 04:24:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MP0Dy23WCz3bYS
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Sep 2022 12:24:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jnhuang@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MP0Ds74s3z2xGn
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Sep 2022 12:24:29 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jnhuang@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VP7G-q4_1662689909;
Received: from localhost.localdomain(mailfrom:jnhuang@linux.alibaba.com fp:SMTPD_---0VP7G-q4_1662689909)
          by smtp.aliyun-inc.com;
          Fri, 09 Sep 2022 10:18:29 +0800
From: Huang Jianan <jnhuang@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/4] erofs-utils: tests: add test for fsck.erofs
Date: Fri,  9 Sep 2022 10:18:16 +0800
Message-Id: <20220909021816.10544-4-jnhuang@linux.alibaba.com>
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

Add basic functional check for fsck.erofs.

Signed-off-by: Huang Jianan <jnhuang@linux.alibaba.com>
---
 tests/Makefile.am   |  3 +++
 tests/common/rc     | 46 +++++++++++++++++++++++++++++++++
 tests/erofs/022     | 62 +++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/022.out |  2 ++
 4 files changed, 113 insertions(+)
 create mode 100755 tests/erofs/022
 create mode 100644 tests/erofs/022.out

diff --git a/tests/Makefile.am b/tests/Makefile.am
index bb1624d..25c1400 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -95,6 +95,9 @@ TESTS += erofs/019
 # 021 - check dump basic functionality
 TESTS += erofs/021
 
+# 021 - check fsck basic functionality
+TESTS += erofs/022
+
 EXTRA_DIST = common/rc erofs
 
 clean-local: clean-local-check
diff --git a/tests/common/rc b/tests/common/rc
index a9ae369..7b72573 100644
--- a/tests/common/rc
+++ b/tests/common/rc
@@ -189,6 +189,52 @@ _test_mkfs()
 	_mkfs $TEST_DEV "$*"
 }
 
+_do_fsck()
+{
+	local fsck_cmd=$1
+	local fsck_filter=$2
+	local fsck_dev=$3
+	shift 3
+	local extra_fsck_options="$*"
+	local fsck_status
+	local tmp=`mktemp -u`
+
+	eval "$fsck_cmd $FSCK_OPTIONS $fsck_dev $extra_fsck_options" \
+		1>$tmp.fsckstd 2>$tmp.fsckerr
+	fsck_status=$?
+
+	# output stored fsck output, filtering unnecessary output from stderr
+	cat $tmp.fsckstd
+	eval "cat $tmp.fsckerr | $fsck_filter" >&2
+
+	rm -f $tmp.fsckerr $tmp.fsckstd
+	return $fsck_status
+}
+
+_fsck()
+{
+	local fsck_dev=$1
+	shift 1
+	local extra_fsck_options="$*"
+	local fsck_cmd="$FSCK_EROFS_PROG"
+	local fsck_filter="true"
+
+	_do_fsck "$fsck_cmd" "$fsck_filter" "$fsck_dev" "$extra_fsck_options" \
+		2>$tmp.fsckerr 1>$tmp.fsckstd
+	fsck_status=$?
+
+	# output fsck stdout and stderr
+	cat $tmp.fsckstd
+	cat $tmp.fsckerr >&2
+	rm -f $tmp.fsckerr $tmp.fsckstd
+
+	return $fsck_status
+}
+
+_scratch_fsck()
+{
+	_fsck $SCRATCH_DEV "$*"
+}
 
 # Do the actual mount work.
 _do_mount()
diff --git a/tests/erofs/022 b/tests/erofs/022
new file mode 100755
index 0000000..d3baf7a
--- /dev/null
+++ b/tests/erofs/022
@@ -0,0 +1,62 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# 022 check fsck basic functionality
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
+_require_fssum
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
+_scratch_mkfs $localdir >> $seqres.full 2>&1 || _fail "failed to mkfs"
+
+extradir="$tmp/extra$seq"
+mkdir -p $extradir
+FSCK_OPTIONS="$FSCK_OPTIONS --extract=$extradir --preserve"
+_scratch_fsck >> $seqres.full 2>&1 || _fail "failed to fsck"
+
+sum1=`$FSSUM_PROG $FSSUM_OPTS $localdir`
+echo "$localdir checksum is $sum1" >>$seqres.full
+sum2=`$FSSUM_PROG $FSSUM_OPTS $extradir`
+echo "$extradir checksum is $sum2" >>$seqres.full
+
+[ "x$sum1" = "x$sum2" ] || _fail "-->checkMD5 FAILED"
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
2.34.1

