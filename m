Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9990C69DCB6
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Feb 2023 10:17:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PLYbS3Hk2z3cBq
	for <lists+linux-erofs@lfdr.de>; Tue, 21 Feb 2023 20:17:40 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PLYbB51Zgz309V
	for <linux-erofs@lists.ozlabs.org>; Tue, 21 Feb 2023 20:17:26 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VcBjLWD_1676971041;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VcBjLWD_1676971041)
          by smtp.aliyun-inc.com;
          Tue, 21 Feb 2023 17:17:22 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs: set blksize to on-disk blksize for fscache mode
Date: Tue, 21 Feb 2023 17:17:19 +0800
Message-Id: <20230221091719.126127-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230221091719.126127-1-jefflexu@linux.alibaba.com>
References: <20230221091719.126127-1-jefflexu@linux.alibaba.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Since fscache mode has supported PAGE_SIZE other than 4KB, remove the
constraint and set to on-disk blksize.

We need to initialize the fscache context for the bootstrap before
setting the initial blksize as it will also update anonymous inode's
i_blkbits for the bootstrap.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/super.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 89011a4ed274..130e0f6db3c7 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -709,6 +709,17 @@ static int erofs_fc_fill_pseudo_super(struct super_block *sb, struct fs_context
 	return simple_fill_super(sb, EROFS_SUPER_MAGIC, &empty_descr);
 }
 
+static bool erofs_set_block_size(struct super_block *sb, unsigned int blkszbits)
+{
+	if (!erofs_is_fscache_mode(sb))
+		return sb_set_blocksize(sb, 1 << blkszbits);
+
+	sb->s_blocksize = 1 << blkszbits;
+	sb->s_blocksize_bits = blkszbits;
+	EROFS_SB(sb)->s_fscache->inode->i_blkbits = blkszbits;
+	return true;
+}
+
 static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct inode *inode;
@@ -734,11 +745,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	sbi->domain_id = ctx->domain_id;
 	ctx->domain_id = NULL;
 
-	sbi->blkszbits = PAGE_SHIFT;
 	if (erofs_is_fscache_mode(sb)) {
-		sb->s_blocksize = PAGE_SIZE;
-		sb->s_blocksize_bits = PAGE_SHIFT;
-
 		err = erofs_fscache_register_fs(sb);
 		if (err)
 			return err;
@@ -747,29 +754,24 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		if (err)
 			return err;
 	} else {
-		if (!sb_set_blocksize(sb, PAGE_SIZE)) {
-			errorfc(fc, "failed to set initial blksize");
-			return -EINVAL;
-		}
-
 		sbi->dax_dev = fs_dax_get_by_bdev(sb->s_bdev,
 						  &sbi->dax_part_off,
 						  NULL, NULL);
 	}
 
+	if (!erofs_set_block_size(sb, PAGE_SHIFT)) {
+		errorfc(fc, "failed to set initial blksize");
+		return -EINVAL;
+	}
+
 	err = erofs_read_superblock(sb);
 	if (err)
 		return err;
 
-	if (sb->s_blocksize_bits != sbi->blkszbits) {
-		if (erofs_is_fscache_mode(sb)) {
-			errorfc(fc, "unsupported blksize for fscache mode");
-			return -EINVAL;
-		}
-		if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
-			errorfc(fc, "failed to set erofs blksize");
-			return -EINVAL;
-		}
+	if (sb->s_blocksize_bits != sbi->blkszbits &&
+	    !erofs_set_block_size(sb, sbi->blkszbits)) {
+		errorfc(fc, "failed to set erofs blksize");
+		return -EINVAL;
 	}
 
 	if (test_opt(&sbi->opt, DAX_ALWAYS)) {
-- 
2.19.1.6.gb485710b

