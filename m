Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3835C57DC56
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jul 2022 10:27:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lq2cc6mhfz3c7M
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jul 2022 18:27:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42; helo=out30-42.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Lq2cY49Svz302W
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Jul 2022 18:27:38 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VK4RflD_1658478452;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VK4RflD_1658478452)
          by smtp.aliyun-inc.com;
          Fri, 22 Jul 2022 16:27:32 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v4] erofs: update ctx->pos for every emitted dirent
Date: Fri, 22 Jul 2022 16:27:32 +0800
Message-Id: <20220722082732.30935-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
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

From: Hongnan Li <hongnan.li@linux.alibaba.com>

erofs_readdir update ctx->pos after filling a batch of dentries
and it may cause dir/files duplication for NFS readdirplus which
depends on ctx->pos to fill dir correctly. So update ctx->pos for
every emitted dirent in erofs_fill_dentries to fix it.

Also fix the update of ctx->pos when the initial file position has
exceeded nameoff.

Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/dir.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index 18e59821c597..47c85f1b80d8 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -22,10 +22,9 @@ static void debug_one_dentry(unsigned char d_type, const char *de_name,
 }
 
 static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
-			       void *dentry_blk, unsigned int *ofs,
+			       void *dentry_blk, struct erofs_dirent *de,
 			       unsigned int nameoff, unsigned int maxsize)
 {
-	struct erofs_dirent *de = dentry_blk + *ofs;
 	const struct erofs_dirent *end = dentry_blk + nameoff;
 
 	while (de < end) {
@@ -59,9 +58,8 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 			/* stopped by some reason */
 			return 1;
 		++de;
-		*ofs += sizeof(struct erofs_dirent);
+		ctx->pos += sizeof(struct erofs_dirent);
 	}
-	*ofs = maxsize;
 	return 0;
 }
 
@@ -95,7 +93,7 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 				  "invalid de[0].nameoff %u @ nid %llu",
 				  nameoff, EROFS_I(dir)->nid);
 			err = -EFSCORRUPTED;
-			goto skip_this;
+			break;
 		}
 
 		maxsize = min_t(unsigned int,
@@ -106,17 +104,17 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 			initial = false;
 
 			ofs = roundup(ofs, sizeof(struct erofs_dirent));
+			ctx->pos = blknr_to_addr(i) + ofs;
 			if (ofs >= nameoff)
 				goto skip_this;
 		}
 
-		err = erofs_fill_dentries(dir, ctx, de, &ofs,
+		err = erofs_fill_dentries(dir, ctx, de, (void *)de + ofs,
 					  nameoff, maxsize);
-skip_this:
-		ctx->pos = blknr_to_addr(i) + ofs;
-
 		if (err)
 			break;
+skip_this:
+		ctx->pos = blknr_to_addr(i) + maxsize;
 		++i;
 		ofs = 0;
 	}
-- 
2.27.0

