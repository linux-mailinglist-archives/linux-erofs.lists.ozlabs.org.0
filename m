Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D43F710769
	for <lists+linux-erofs@lfdr.de>; Thu, 25 May 2023 10:32:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QRhB8221Vz3f8L
	for <lists+linux-erofs@lfdr.de>; Thu, 25 May 2023 18:32:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QRhB14v57z3bcT
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 May 2023 18:32:08 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VjRZXOL_1685003522;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VjRZXOL_1685003522)
          by smtp.aliyun-inc.com;
          Thu, 25 May 2023 16:32:03 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/5] erofs-utils: tests: add generic helper for xattrs
Date: Thu, 25 May 2023 16:31:57 +0800
Message-Id: <20230525083201.23740-2-jefflexu@linux.alibaba.com>
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

Add a helper checking if xattr progs are available.

Add helpers generating random strings which could be used as
key/value of xattr.

Add a helper checking if same named files under two directories have
same xattrs.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 tests/common/rc | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tests/common/rc b/tests/common/rc
index a9ae369..293e556 100644
--- a/tests/common/rc
+++ b/tests/common/rc
@@ -86,6 +86,12 @@ _require_root()
 	[ "$(id -u)" = "0" ] || _notrun "must be run as root"
 }
 
+_require_xattr()
+{
+	which setfattr >/dev/null 2>&1 ||
+		_notrun "attr isn't installed, skipped."
+}
+
 # this test requires erofs kernel support
 _require_erofs()
 {
@@ -315,6 +321,32 @@ _require_fssum()
 	[ -x $FSSUM_PROG ] || _notrun "fssum not built"
 }
 
+# generate random string with maximum $1 length
+_random()
+{
+	head -20 /dev/urandom | base64 -w0 | head -c $1
+}
+
+# generate short random string
+_srandom()
+{
+	_random 16
+}
+
+# check xattrs of same files under two directories
+_check_xattrs()
+{
+	local dir1="$1"
+	local dir2="$2"
+	local dirs=`ls $dir1`
+
+	for d in $dirs; do
+		xattr1=`getfattr --absolute-names -d $dir1/$d | tail -n+2`
+		xattr2=`getfattr --absolute-names -d $dir2/$d | tail -n+2`
+		[ "x$xattr1" = "x$xattr2" ] || _fail "-->check xattrs FAILED"
+	done
+}
+
 _check_results()
 {
 	[ -z $srcdir ] && return 0
-- 
1.8.3.1

