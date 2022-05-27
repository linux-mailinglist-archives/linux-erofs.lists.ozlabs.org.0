Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0B3535A4B
	for <lists+linux-erofs@lfdr.de>; Fri, 27 May 2022 09:25:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L8bv05l21z3bkF
	for <lists+linux-erofs@lfdr.de>; Fri, 27 May 2022 17:25:48 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hongnan.li@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4L8btw3Gkkz2x9J
	for <linux-erofs@lists.ozlabs.org>; Fri, 27 May 2022 17:25:43 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=hongnan.li@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VEW7hpz_1653636336;
Received: from localhost(mailfrom:hongnan.li@linux.alibaba.com fp:SMTPD_---0VEW7hpz_1653636336)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 27 May 2022 15:25:36 +0800
From: Hongnan Li <hongnan.li@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH] erofs: update ctx->pos for every emitted dirent
Date: Fri, 27 May 2022 15:25:36 +0800
Message-Id: <20220527072536.68516-1-hongnan.li@linux.alibaba.com>
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

erofs_readdir update ctx->pos after filling a batch of dentries
and it may cause dir/files duplication for NFS readdirplus which
depends on ctx->pos to fill dir correctly. So update ctx->pos for
every emitted dirent in erofs_fill_dentries to fix it.

Fixes: 3e917cc305c6 ("erofs: make filesystem exportable")
Signed-off-by: Hongnan Li <hongnan.li@linux.alibaba.com>
---
 fs/erofs/dir.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/dir.c b/fs/erofs/dir.c
index 18e59821c597..3015974fe2ff 100644
--- a/fs/erofs/dir.c
+++ b/fs/erofs/dir.c
@@ -22,11 +22,12 @@ static void debug_one_dentry(unsigned char d_type, const char *de_name,
 }
 
 static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
-			       void *dentry_blk, unsigned int *ofs,
+			       void *dentry_blk, void *dentry_begin,
 			       unsigned int nameoff, unsigned int maxsize)
 {
-	struct erofs_dirent *de = dentry_blk + *ofs;
+	struct erofs_dirent *de = dentry_begin;
 	const struct erofs_dirent *end = dentry_blk + nameoff;
+	loff_t begin_pos = ctx->pos;
 
 	while (de < end) {
 		const char *de_name;
@@ -59,9 +60,9 @@ static int erofs_fill_dentries(struct inode *dir, struct dir_context *ctx,
 			/* stopped by some reason */
 			return 1;
 		++de;
-		*ofs += sizeof(struct erofs_dirent);
+		ctx->pos += sizeof(struct erofs_dirent);
 	}
-	*ofs = maxsize;
+	ctx->pos = begin_pos + maxsize;
 	return 0;
 }
 
@@ -110,11 +111,9 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 				goto skip_this;
 		}
 
-		err = erofs_fill_dentries(dir, ctx, de, &ofs,
+		err = erofs_fill_dentries(dir, ctx, de, de + ofs,
 					  nameoff, maxsize);
 skip_this:
-		ctx->pos = blknr_to_addr(i) + ofs;
-
 		if (err)
 			break;
 		++i;
-- 
2.35.1

