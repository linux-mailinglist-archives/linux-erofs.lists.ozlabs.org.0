Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF717921C0
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Sep 2023 12:02:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rg1K36Vjbz3c4V
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Sep 2023 20:02:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rg1Jr1hnCz30hh
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Sep 2023 20:02:34 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VrPmnGT_1693908148;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VrPmnGT_1693908148)
          by smtp.aliyun-inc.com;
          Tue, 05 Sep 2023 18:02:29 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v6 01/11] erofs-utils: lib: remove unneeded NULL checking for returned item
Date: Tue,  5 Sep 2023 18:02:17 +0800
Message-Id: <20230905100227.1072-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230905100227.1072-1-jefflexu@linux.alibaba.com>
References: <20230905100227.1072-1-jefflexu@linux.alibaba.com>
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

get_xattritem() will in no way return NULL.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 lib/xattr.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/lib/xattr.c b/lib/xattr.c
index 0cab29f..5acc1ae 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -437,8 +437,6 @@ int erofs_setxattr(struct erofs_inode *inode, char *key,
 	item = get_xattritem(prefix, kvbuf, len);
 	if (IS_ERR(item))
 		return PTR_ERR(item);
-	if (!item)
-		return 0;
 
 	return erofs_xattr_add(&inode->i_xattrs, item);
 }
@@ -473,8 +471,6 @@ static int erofs_droid_xattr_set_caps(struct erofs_inode *inode)
 	item = get_xattritem(EROFS_XATTR_INDEX_SECURITY, kvbuf, len);
 	if (IS_ERR(item))
 		return PTR_ERR(item);
-	if (!item)
-		return 0;
 
 	return erofs_xattr_add(&inode->i_xattrs, item);
 }
-- 
2.19.1.6.gb485710b

