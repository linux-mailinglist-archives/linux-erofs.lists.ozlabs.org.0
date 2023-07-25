Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABC47609EB
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jul 2023 08:00:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R95ws6tXyz3c82
	for <lists+linux-erofs@lfdr.de>; Tue, 25 Jul 2023 16:00:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R95wh3FfTz30fn
	for <linux-erofs@lists.ozlabs.org>; Tue, 25 Jul 2023 16:00:20 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VoBbDGd_1690264814;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VoBbDGd_1690264814)
          by smtp.aliyun-inc.com;
          Tue, 25 Jul 2023 14:00:15 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/3] erofs-utils: tests: enable test cases for tarfs mode
Date: Tue, 25 Jul 2023 14:00:12 +0800
Message-Id: <20230725060012.123661-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230725060012.123661-1-jefflexu@linux.alibaba.com>
References: <20230725060012.123661-1-jefflexu@linux.alibaba.com>
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

Now tarfs mode could be tested with "make check FSTYP=erofstar".

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 tests/common/rc | 24 ++++++++++++++++++++++--
 tests/erofs/006 |  2 +-
 tests/erofs/015 |  2 +-
 tests/erofs/016 |  2 +-
 4 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/tests/common/rc b/tests/common/rc
index f54b5c1..aab1926 100644
--- a/tests/common/rc
+++ b/tests/common/rc
@@ -90,6 +90,9 @@ _require_xattr()
 {
 	which setfattr >/dev/null 2>&1 ||
 		_notrun "attr isn't installed, skipped."
+
+	[ $FSTYP = "erofstar" ] &&
+		_notrun "erofstar doesn't support xattr yet, skipped."
 }
 
 _require_mkfs_blksize()
@@ -197,9 +200,26 @@ _mkfs()
 	return $mkfs_status
 }
 
+_scratch_mkfs_tar()
+{
+	local scratch_dir=${@:-1}
+	local mkfs_options=${@:1:$#-1}
+	local tarfile=${scratch_dir}.tar
+
+	pushd $scratch_dir
+	tar -cf $tarfile .
+	popd
+
+	_mkfs $SCRATCH_DEV --tar=f $mkfs_options $tarfile
+}
+
 _scratch_mkfs()
 {
-	_mkfs $SCRATCH_DEV "$*"
+	if [ "$FSTYP" = "erofstar" ]; then
+		_scratch_mkfs_tar "$*"
+	else
+		_mkfs $SCRATCH_DEV "$*"
+	fi
 }
 
 _test_mkfs()
@@ -216,7 +236,7 @@ _do_mount()
 	local tmp=`mktemp -u`
 	local mount_filter="awk '{print \$NF}' FS=":" | sed 's/^ *//g'"
 
-	eval "$MOUNT_PROG -t $FSTYP $extra_mount_options" \
+	eval "$MOUNT_PROG $extra_mount_options" \
 		1>$tmp.mountstd 2>$tmp.mounterr
 	mount_status=$?
 
diff --git a/tests/erofs/006 b/tests/erofs/006
index 18458b0..3a2c8c4 100755
--- a/tests/erofs/006
+++ b/tests/erofs/006
@@ -48,7 +48,7 @@ _scratch_mkfs $localdir >> $seqres.full 2>&1 || _fail "failed to mkfs"
 _scratch_mount 2>>$seqres.full
 
 FSSUM_OPTS="-MAC"
-[ $FSTYP = "erofsfuse" ] && FSSUM_OPTS="${FSSUM_OPTS}T"
+[ $FSTYP = "erofsfuse" -o $FSTYP = "erofstar" ] && FSSUM_OPTS="${FSSUM_OPTS}T"
 
 sum1=`$FSSUM_PROG $FSSUM_OPTS $localdir`
 echo "$localdir checksum is $sum1" >>$seqres.full
diff --git a/tests/erofs/015 b/tests/erofs/015
index 8e562f6..c2c0c99 100755
--- a/tests/erofs/015
+++ b/tests/erofs/015
@@ -45,7 +45,7 @@ _scratch_mount 2>>$seqres.full
 
 # verify the uncompressed image
 FSSUM_OPTS="-MAC"
-[ $FSTYP = "erofsfuse" ] && FSSUM_OPTS="${FSSUM_OPTS}T"
+[ $FSTYP = "erofsfuse" -o $FSTYP = "erofstar" ] && FSSUM_OPTS="${FSSUM_OPTS}T"
 
 sum1=`$FSSUM_PROG $FSSUM_OPTS $localdir`
 echo "$localdir checksum is $sum1" >>$seqres.full
diff --git a/tests/erofs/016 b/tests/erofs/016
index 3e84e2b..568aea6 100755
--- a/tests/erofs/016
+++ b/tests/erofs/016
@@ -51,7 +51,7 @@ _scratch_mount 2>>$seqres.full
 
 # verify the uncompressed image
 FSSUM_OPTS="-MAC"
-[ $FSTYP = "erofsfuse" ] && FSSUM_OPTS="${FSSUM_OPTS}T"
+[ $FSTYP = "erofsfuse" -o $FSTYP = "erofstar" ] && FSSUM_OPTS="${FSSUM_OPTS}T"
 
 sum1=`$FSSUM_PROG $FSSUM_OPTS $localdir`
 echo "$localdir checksum is $sum1" >>$seqres.full
-- 
2.19.1.6.gb485710b

