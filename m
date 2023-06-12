Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DA3D72C47A
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jun 2023 14:38:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QfrnY12mrz30Mv
	for <lists+linux-erofs@lfdr.de>; Mon, 12 Jun 2023 22:38:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QfrnH1LL3z30BQ
	for <linux-erofs@lists.ozlabs.org>; Mon, 12 Jun 2023 22:37:54 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VkzU.DN_1686573469;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VkzU.DN_1686573469)
          by smtp.aliyun-inc.com;
          Mon, 12 Jun 2023 20:37:50 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 3/5] erofs: make the size of read data stored in buffer_ofs
Date: Mon, 12 Jun 2023 20:37:43 +0800
Message-Id: <20230612123745.36323-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230612123745.36323-1-jefflexu@linux.alibaba.com>
References: <20230612123745.36323-1-jefflexu@linux.alibaba.com>
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

Since now xattr_iter structures have been unified, make the size of the
read data stored in buffer_ofs.  Don't bother reusing buffer_size for
this use, which may be confusing.

This is in preparation for the following further cleanup.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/xattr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index b2802121e3aa..8a114c7b6c66 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -315,7 +315,7 @@ static int xattr_checkbuffer(struct erofs_xattr_iter *it,
 {
 	int err = it->buffer_size < value_sz ? -ERANGE : 0;
 
-	it->buffer_size = value_sz;
+	it->buffer_ofs = value_sz;
 	return !it->buffer ? 1 : err;
 }
 
@@ -348,7 +348,7 @@ static int inline_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
 		if (ret != -ENOATTR)
 			break;
 	}
-	return ret ? ret : it->buffer_size;
+	return ret ? ret : it->buffer_ofs;
 }
 
 static int shared_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
@@ -371,7 +371,7 @@ static int shared_getxattr(struct inode *inode, struct erofs_xattr_iter *it)
 		if (ret != -ENOATTR)
 			break;
 	}
-	return ret ? ret : it->buffer_size;
+	return ret ? ret : it->buffer_ofs;
 }
 
 static bool erofs_xattr_user_list(struct dentry *dentry)
-- 
2.19.1.6.gb485710b

