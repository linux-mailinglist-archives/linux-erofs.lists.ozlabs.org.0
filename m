Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 767AB72F30D
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jun 2023 05:26:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QgrSY1Y3dz2xwc
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Jun 2023 13:26:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QgrST0fh1z2xwc
	for <linux-erofs@lists.ozlabs.org>; Wed, 14 Jun 2023 13:26:48 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vl4hA0C_1686713202;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vl4hA0C_1686713202)
          by smtp.aliyun-inc.com;
          Wed, 14 Jun 2023 11:26:43 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: tests: check xattrs for all descendants under target directory
Date: Wed, 14 Jun 2023 11:26:41 +0800
Message-Id: <20230614032642.8186-1-jefflexu@linux.alibaba.com>
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
Cc: huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Enhance _check_xattrs() helper checking all descendants under the
target directory.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 tests/common/rc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/common/rc b/tests/common/rc
index dcd63a9..f234fdc 100644
--- a/tests/common/rc
+++ b/tests/common/rc
@@ -350,11 +350,11 @@ _check_xattrs()
 {
 	local dir1="$1"
 	local dir2="$2"
-	local dirs=`ls $dir1`
+	local entries=`find $dir1 -mindepth 1 -printf '%P\n' -type f`
 
-	for d in $dirs; do
-		xattr1=`getfattr --absolute-names -d $dir1/$d | tail -n+2`
-		xattr2=`getfattr --absolute-names -d $dir2/$d | tail -n+2`
+	for entry in $entries; do
+		xattr1=`getfattr --absolute-names -d $dir1/$entry | tail -n+2`
+		xattr2=`getfattr --absolute-names -d $dir2/$entry | tail -n+2`
 		[ "x$xattr1" = "x$xattr2" ] || _fail "-->check xattrs FAILED"
 	done
 }
-- 
1.8.3.1

