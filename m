Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0F57999FA
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Sep 2023 18:33:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rjdnc5cDgz3cCw
	for <lists+linux-erofs@lfdr.de>; Sun, 10 Sep 2023 02:33:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RjdnP2D2xz2yVg
	for <linux-erofs@lists.ozlabs.org>; Sun, 10 Sep 2023 02:32:53 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VrfyqP7_1694277166;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VrfyqP7_1694277166)
          by smtp.aliyun-inc.com;
          Sun, 10 Sep 2023 00:32:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 01/13] erofs-utils: lib: remove unneeded NULL checks
Date: Sun, 10 Sep 2023 00:32:28 +0800
Message-Id: <20230909163240.42057-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230909163240.42057-1-hsiangkao@linux.alibaba.com>
References: <20230909163240.42057-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Jingbo Xu <jefflexu@linux.alibaba.com>

get_xattritem() will in no way return NULL.  Use DBG_BUGONs instead.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/xattr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 0cab29f..2b7c634 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -437,8 +437,7 @@ int erofs_setxattr(struct erofs_inode *inode, char *key,
 	item = get_xattritem(prefix, kvbuf, len);
 	if (IS_ERR(item))
 		return PTR_ERR(item);
-	if (!item)
-		return 0;
+	DBG_BUGON(!item);
 
 	return erofs_xattr_add(&inode->i_xattrs, item);
 }
@@ -473,8 +472,7 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 	item = get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len);
 	if (IS_ERR(item))
 		return PTR_ERR(item);
-	if (!item)
-		return 0;
+	DBG_BUGON(!item);
 
 	return erofs_xattr_add(&inode->i_xattrs, item);
 }
-- 
2.24.4

