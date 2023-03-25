Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F27726C8BA2
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Mar 2023 07:18:33 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Pk85z6bFVz3fhg
	for <lists+linux-erofs@lfdr.de>; Sat, 25 Mar 2023 17:18:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Pk7wD1fBzz3fTq
	for <linux-erofs@lists.ozlabs.org>; Sat, 25 Mar 2023 17:10:03 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VeZn9WA_1679724594;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VeZn9WA_1679724594)
          by smtp.aliyun-inc.com;
          Sat, 25 Mar 2023 14:09:55 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: tests: enhance erofs/019
Date: Sat, 25 Mar 2023 14:09:54 +0800
Message-Id: <20230325060954.63062-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Test xattr in following cases:

- multiple inline xattrs for one single file
- multiple share xattrs for one single file
- mixed inline and share xattrs for one single file
- name/value field of xattr crosses block boundary

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---

This is used to test the refactoring on xattr on kernel side[1].

This patch relies on the "-b #blocksize" feature, and thus it needs to
be rebased to "-b experimental" branch of erofs-utils.

[1] https://lore.kernel.org/all/20230323000949.57608-1-jefflexu@linux.alibaba.com/

---
 tests/erofs/019 | 38 +++++++++++++++++++++++++++++++-------
 1 file changed, 31 insertions(+), 7 deletions(-)

diff --git a/tests/erofs/019 b/tests/erofs/019
index dac2ae3..f733516 100755
--- a/tests/erofs/019
+++ b/tests/erofs/019
@@ -15,6 +15,11 @@ cleanup()
 	rm -rf $tmp.*
 }
 
+generate_random()
+{
+	head -20 /dev/urandom | base64 -w0 | head -c $1
+}
+
 _require_erofs
 
 # remove previous $seqres.full before test
@@ -37,18 +42,37 @@ rm -rf $localdir
 mkdir -p $localdir
 
 # set random xattrs
-cp -nR ../ $localdir
-dirs=`ls $localdir`
-for d in $dirs; do
-	key=`head -20 /dev/urandom | cksum | cut -f1 -d " "`
-	val="0s"`head -3 /dev/urandom | base64 -w0`
-	setfattr -n user.$key -v $val $localdir/$d
-done
 
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
+MKFS_OPTIONS="$MKFS_OPTIONS -b1024 -x1"
 _scratch_mkfs $localdir >> $seqres.full 2>&1 || _fail "failed to mkfs"
 _scratch_mount 2>>$seqres.full
 
 # check xattrs
+dirs=`ls $localdir`
 for d in $dirs; do
 	xattr1=`getfattr --absolute-names -d $localdir/$d | tail -n+2`
 	xattr2=`getfattr --absolute-names -d $SCRATCH_MNT/$d | tail -n+2`
-- 
1.8.3.1

