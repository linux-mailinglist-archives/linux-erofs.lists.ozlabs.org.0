Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 515A872F30E
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jun 2023 05:26:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QgrSc1qh7z30gm
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jun 2023 13:26:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QgrST1M44z2y1Y
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Jun 2023 13:26:48 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vl4hYmn_1686713203;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vl4hYmn_1686713203)
          by smtp.aliyun-inc.com;
          Wed, 14 Jun 2023 11:26:44 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: tests: add test for xattrs in random layouts
Date: Wed, 14 Jun 2023 11:26:42 +0800
Message-Id: <20230614032642.8186-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230614032642.8186-1-jefflexu@linux.alibaba.com>
References: <20230614032642.8186-1-jefflexu@linux.alibaba.com>
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
Cc: huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Generate and check random xattrs.  Set xattrs on tested file as much
as possible until the number or size of xattrs has reached the upper
limit for single file, e.g. maximum one block size for xattrs for
single file in ext4.

The same xattr may be shared among multiple tested files or not.
Thus the layout of mixed inline and shared xattrs is tested.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 tests/Makefile.am   |   3 ++
 tests/erofs/023     | 104 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/erofs/023.out |   2 +
 3 files changed, 109 insertions(+)
 create mode 100755 tests/erofs/023
 create mode 100644 tests/erofs/023.out

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 6295964..b0e7806 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -100,6 +100,9 @@ TESTS += erofs/021
 # 022 - check long extended attribute name prefixes
 TESTS += erofs/022
 
+# 023 - check extended attributes in random layouts
+TESTS += erofs/023
+
 EXTRA_DIST = common/rc erofs
 
 clean-local: clean-local-check
diff --git a/tests/erofs/023 b/tests/erofs/023
new file mode 100755
index 0000000..7998705
--- /dev/null
+++ b/tests/erofs/023
@@ -0,0 +1,104 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0+
+#
+# 023 - check extended attributes in random layouts
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
+# feed random seed
+RANDOM=$$
+
+# build file list of all descendant files under the directory
+cp -nR ../ $localdir
+entries=`find $localdir -mindepth 1 -type f -not -path '*git*' -printf '%P\n'`
+i=0
+for file in $entries; do
+	files[$i]="$file"
+	i=$((i+1))
+done
+num_files=${#files[*]}
+[ $num_files -eq 0 ] && _notrun "empty file list"
+
+# set random xattrs
+for file in ${files[*]}; do
+	while true; do
+		key=$(_random $(($RANDOM%32)))
+		val=$(_random $(($RANDOM%32)))
+
+		# allow of xattrs with empty value
+		VAL_OPTIONS=""
+		if [ -n "$val" ]; then
+			VAL_OPTIONS="-v $val"
+		fi
+
+		# move to next file if the disk space for xattr has been consumed
+		# for the current file
+		setfattr -n user.$key $VAL_OPTIONS $localdir/$file >>$seqres.full 2>&1 \
+			|| break
+
+		# share this xattr or not?
+		if [ $(($RANDOM%2)) -ne 0 ]; then
+			# tag this xattr to other files to build shared xattrs
+			# generate a random step in [1, 64]
+			step=$(($(($RANDOM%64))+1))
+			i=0
+			while true; do
+				i=$(($i+$step))
+				if [ $i -lt $num_files ]; then
+					setfattr -n user.$key $VAL_OPTIONS $localdir/${files[$i]} \
+						>>$seqres.full 2>&1
+				else
+					break
+				fi
+			done
+		fi
+	done
+done
+
+# round 1: test mixed of inline and shared xattrs (default)
+_scratch_unmount
+MKFS_OPTIONS="$MKFS_OPTIONS"
+_scratch_mkfs $localdir >> $seqres.full 2>&1 || _fail "failed to mkfs"
+_scratch_mount 2>>$seqres.full
+_check_xattrs $localdir $SCRATCH_MNT
+
+# round 2: test shared xattrs
+_scratch_unmount
+MKFS_OPTIONS="$MKFS_OPTIONS -x1"
+_scratch_mkfs $localdir >> $seqres.full 2>&1 || _fail "failed to mkfs"
+_scratch_mount 2>>$seqres.full
+_check_xattrs $localdir $SCRATCH_MNT
+
+_scratch_unmount
+
+echo Silence is golden
+status=0
+exit 0
diff --git a/tests/erofs/023.out b/tests/erofs/023.out
new file mode 100644
index 0000000..5c4197b
--- /dev/null
+++ b/tests/erofs/023.out
@@ -0,0 +1,2 @@
+QA output created by 023
+Silence is golden
-- 
1.8.3.1

