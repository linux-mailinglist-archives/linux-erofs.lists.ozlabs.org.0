Return-Path: <linux-erofs+bounces-1978-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 81207D39C66
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Jan 2026 03:37:36 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dvZP93D9Vz2xS5;
	Mon, 19 Jan 2026 13:37:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1768790253;
	cv=none; b=P6MQRArv0AEL5PWQInHRBue6/Xnd8KsNIXfVnT6p0aKlki0mnjvaxRelQT9m9NpYX/R00vONdUkJccVhHW6cyU4ThcRoS7Y+nE47N1UWNv3m19oFBMTMm2AupmfLzjY2zv7JRgXGQdNxBY8zFXjqIIW8QswHX6+mo0coTtT5GzhRjd9i0TzpxXMeGYgH1FNWOYozB1dL8/K42WKhWRP6C7fGAmmE9f3Y4CQ+G99IWHqiJ8Qdy2q1ok9422g9BJqSvCvKQjnIXEVrfY41RBBAnbK/e/SGRz03gtUdeEw7Do/wdUP29o9i3oErGSG9P4+RMDy4BmVC0sntiBSaubBKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1768790253; c=relaxed/relaxed;
	bh=aFMYadfBvdGTnT+IGK4C4ZbalFaSMF5WDFzzNc/QTFA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TB6Zj9ZnDXXrbXr8gfdjFWglmcL7vOCOhNqFlddgOeBqu4Pl4ZJU8D0QhNIBohT7AuBgqGCspaIOfbH72P6X+Mem1Zl5GY/I+yGOrI18mCjl5S2NAAiAeaqHxblJT8gwq2/CM5YYOnepumnazbw9RiIXVCJQuz85ZB2wEO2LJBrEy5quaYMqqmb8UOmYI1jQe+QlTu5pg3gAvccaEZPfhIn/GoqByfDbBPFmzhrVf3naWsSrHV0cuLesW7h+CAnNe0b9OkD8AZ8t2FrH5RxQ4g4eiWZglMeXU2h64henqI46h5cLSsIAEUR/i04keCjHN0mMVJsyc9kfclLRf/u01w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aTumjhDg; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aTumjhDg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dvZP702F7z2xRm
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Jan 2026 13:37:29 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1768790243; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=aFMYadfBvdGTnT+IGK4C4ZbalFaSMF5WDFzzNc/QTFA=;
	b=aTumjhDgvDXMyR2KKHAZ3a9G+FrJtZyo+jh2k0KTOZVCZvdIMuarNK4HfmWVX6bl1zgijz1dnKCumU5q+U9RvnEZjZqfaY3w8v5VJGOyY/f7K/dX2K4q54z+flmOyxobUrsiV79cov0/oMY5TfGlGyyscUGBQ3oWVBgnRC2fHDI=
Received: from localhost.localdomain(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WxHPhLh_1768790237 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 19 Jan 2026 10:37:22 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: switch !bh cases in erofs_write_tail_end()
Date: Mon, 19 Jan 2026 10:37:05 +0800
Message-ID: <20260119023705.1784817-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

To use erofs_allocate_inode_bh_data().

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 55 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 3abc7c1..e3ee79a 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -635,6 +635,7 @@ static int erofs_write_unencoded_data(struct erofs_inode *inode,
 				      bool noseek, bool in_metazone)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
+	struct erofs_buffer_head *bh;
 	struct erofs_bufmgr *bmgr;
 	erofs_off_t remaining, pos;
 	unsigned int len;
@@ -663,16 +664,19 @@ static int erofs_write_unencoded_data(struct erofs_inode *inode,
 	if (ret)
 		return ret;
 
-	bmgr = in_metazone ? erofs_metadata_bmgr(sbi, false) : sbi->bmgr;
-	pos = erofs_pos(sbi, erofs_inode_dev_baddr(inode));
-	while (remaining) {
-		len = min_t(u64, round_down(UINT_MAX, 1U << sbi->blkszbits),
-			    remaining);
-		ret = erofs_io_xcopy(bmgr->vf, pos, vf, len, noseek);
-		if (ret)
-			return ret;
-		pos += len;
-		remaining -= len;
+	bh = inode->bh_data;
+	if (bh) {
+		bmgr = (struct erofs_bufmgr *)bh->block->buffers.fsprivate;
+		pos = erofs_btell(bh, false);
+		do {
+			len = min_t(u64, remaining,
+				    round_down(UINT_MAX, 1U << sbi->blkszbits));
+			ret = erofs_io_xcopy(bmgr->vf, pos, vf, len, noseek);
+			if (ret)
+				return ret;
+			pos += len;
+			remaining -= len;
+		} while (remaining);
 	}
 
 	/* read the tail-end data */
@@ -1071,9 +1075,11 @@ static struct erofs_bhops erofs_write_inline_bhops = {
 	.flush = erofs_bh_flush_write_inline,
 };
 
-static int erofs_write_tail_end(struct erofs_inode *inode)
+static int erofs_write_tail_end(struct erofs_importer *im,
+				struct erofs_inode *inode)
 {
 	static const u8 zeroed[EROFS_MAX_BLOCK_SIZE];
+	const struct erofs_importer_params *params = im->params;
 	struct erofs_sb_info *sbi = inode->sbi;
 	struct erofs_buffer_head *bh, *ibh;
 
@@ -1094,20 +1100,17 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 		struct iovec iov[2];
 		erofs_off_t pos;
 		int ret;
-		bool h0;
+		bool h0, in_metazone;
 
 		if (!bh) {
-			bh = erofs_balloc(sbi->bmgr,
-					  S_ISDIR(inode->i_mode) ? DIRA: DATA,
-					  erofs_blksiz(sbi), 0);
-			if (IS_ERR(bh))
-				return PTR_ERR(bh);
-			bh->op = &erofs_skip_write_bhops;
-
-			/* get blkaddr of bh */
-			ret = erofs_mapbh(NULL, bh->block);
-			inode->u.i_blkaddr = bh->block->blkaddr;
-			inode->bh_data = bh;
+			in_metazone = S_ISDIR(inode->i_mode) &&
+				params->dirdata_in_metazone;
+
+			ret = erofs_allocate_inode_bh_data(inode, 1,
+							   in_metazone);
+			if (ret)
+				return ret;
+			bh = inode->bh_data;
 		} else {
 			if (inode->lazy_tailblock) {
 				/* expend a tail block (should be successful) */
@@ -1545,7 +1548,7 @@ static int erofs_mkfs_handle_nondirectory(const struct erofs_mkfs_btctx *btctx,
 	if (ret)
 		return ret;
 	erofs_prepare_inode_buffer(btctx->im, inode);
-	erofs_write_tail_end(inode);
+	erofs_write_tail_end(btctx->im, inode);
 	return 0;
 }
 
@@ -1620,7 +1623,7 @@ static int erofs_mkfs_jobfn(const struct erofs_mkfs_btctx *ctx,
 		ret = erofs_write_dir_file(ctx->im, inode);
 		if (ret)
 			return ret;
-		erofs_write_tail_end(inode);
+		erofs_write_tail_end(ctx->im, inode);
 		inode->bh->op = &erofs_write_inode_bhops;
 		erofs_iput(inode);
 		return 0;
@@ -2372,7 +2375,7 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(struct erofs_importer *im,
 		return ERR_PTR(ret);
 out:
 	erofs_prepare_inode_buffer(im, inode);
-	erofs_write_tail_end(inode);
+	erofs_write_tail_end(im, inode);
 	return inode;
 }
 
-- 
2.43.0


