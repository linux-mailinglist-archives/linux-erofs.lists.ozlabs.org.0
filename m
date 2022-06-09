Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C60EC54420A
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jun 2022 05:40:23 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LJVGs4Z36z3blX
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Jun 2022 13:40:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.57; helo=out30-57.freemail.mail.aliyun.com; envelope-from=hongnan.li@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LJVGn1pjtz3bdy
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 Jun 2022 13:40:14 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hongnan.li@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VFqInsP_1654746006;
Received: from localhost(mailfrom:hongnan.li@linux.alibaba.com fp:SMTPD_---0VFqInsP_1654746006)
          by smtp.aliyun-inc.com;
          Thu, 09 Jun 2022 11:40:06 +0800
From: Hongnan Li <hongnan.li@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH v2] erofs: update ctx->pos for every emitted dirent
Date: Thu,  9 Jun 2022 11:40:06 +0800
Message-Id: <20220609034006.76649-1-hongnan.li@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20220527072536.68516-1-hongnan.li@linux.alibaba.com>
References: <20220527072536.68516-1-hongnan.li@linux.alibaba.com>
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

erofs_readdir update ctx->pos after filling a batch of dentries
and it may cause dir/files duplication for NFS readdirplus which
depends on ctx->pos to fill dir correctly. So update ctx->pos for
every emitted dirent in erofs_fill_dentries to fix it.

Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>
---
 fs/erofs/dir.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index 18e59821c597..94ef5287237a 100644
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
@@ -106,17 +104,19 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 			initial = false;
 
 			ofs = roundup(ofs, sizeof(struct erofs_dirent));
-			if (ofs >= nameoff)
+			if (ofs >= nameoff) {
+				ctx->pos = blknr_to_addr(i) + ofs;
 				goto skip_this;
+			}
 		}
 
-		err = erofs_fill_dentries(dir, ctx, de, &ofs,
-					  nameoff, maxsize);
-skip_this:
 		ctx->pos = blknr_to_addr(i) + ofs;
-
+		err = erofs_fill_dentries(dir, ctx, de, (void *)de + ofs,
+					  nameoff, maxsize);
 		if (err)
 			break;
+		ctx->pos = blknr_to_addr(i) + maxsize;
+skip_this:
 		++i;
 		ofs = 0;
 	}
-- 
2.35.3

