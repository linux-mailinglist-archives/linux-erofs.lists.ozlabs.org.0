Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D825E77C6C8
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 06:55:55 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=jQGsnr7m;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RPzVd1737z30gB
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 14:55:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=jQGsnr7m;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::236; helo=mail-oi1-x236.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RPzVT6prgz2yZV
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Aug 2023 14:55:44 +1000 (AEST)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a3efebcc24so4303122b6e.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 14 Aug 2023 21:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692075341; x=1692680141;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=000mBz04eG88+Tt9FcwCV4H823dxRhmou5sI8a2duJs=;
        b=jQGsnr7mpOrfuUIdOiHUSXttGXJJUDk4xCaJqrdAVrvL0oD9jnI7yqAz+vK7GtaurN
         xfFU9ipIxz4dk9p/letMybTsRY0XPP+WU+ifRrMz+qgGIhXMnzMxve8bo4ej+jb6JULL
         PLlP4vj42HXzfp2D2bxSZhnoAW9IpVDl1FZfEMyPLw3NmqLKOtJPi9y35PTdNGRZjJRU
         lkVr7EWqR1ID7N9ve1V+KZtZZ7h20IZttuzdCq91NrvSUWlu3TqOHC4yLdjumHOHG0pq
         8zLjf2HQmyZt+Ej2Ae8JRE4JCdRQWAnD5WFhQyfShuyd9zT0+HcWbRxIU2SgENSyxC7S
         f02Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692075341; x=1692680141;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=000mBz04eG88+Tt9FcwCV4H823dxRhmou5sI8a2duJs=;
        b=byhz6oaIFoELvSHCrt0SAkyb+YwVol93/cKRxOqIAq9Nt3RKu/7vSSR3k42unYBE+p
         JAEy12Bt1CCXiTrruxoWQ+MAaJvFGIRNlTqskC38m5m+LrpX0o2wqCFD+qVUh67YctQv
         dmfgpYFMMJJKD7Me6Ve9/EuG0hAJxU3aNP/SgCO1dNTdgRzDT1BMl5lwmDUWibOwHxk9
         67zIMl7XgPNRUYHXZgJzpq1jJSB+DOTAVSgh9/OxcSd1cWS0AFzBn14pW96ykItJ4uw1
         5wTBUImR1Nxgm38ahp1+zQ7zQeBQBpvDQBKCMs1ENk136LXNtKTyZCe6xXx+AqAW1nMB
         QLgA==
X-Gm-Message-State: AOJu0YzA6RF/ecQWQPgT9UaCfcVmz0kEo0iwgLCJI3mvpQnozQmowKTX
	HHoNthhKss4MeoCBFy8dH7Pp7iMob38=
X-Google-Smtp-Source: AGHT+IHdS82TVEexpJaiglDhRqml8poLSpmSm2PkHUicaLg2rJlDvRLRFV/xRx+7JQpfhWqPHwj6HQ==
X-Received: by 2002:a05:6808:438f:b0:3a7:8fcd:3325 with SMTP id dz15-20020a056808438f00b003a78fcd3325mr11473013oib.17.1692075341691;
        Mon, 14 Aug 2023 21:55:41 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id v13-20020a63bf0d000000b00564b313d526sm8590942pgf.54.2023.08.14.21.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 21:55:41 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2 v2] AOSP: erofs-utils: pass a parameter to write tail end in block list
Date: Tue, 15 Aug 2023 12:55:24 +0800
Message-Id: <20230815045525.17990-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Yue Hu <huyue2@coolpad.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

We can determine whether the tail block is the first one or not during
the writing process.  Therefore, instead of internally checking the
block number for the tail block map, just simply pass the flag.

Also, add the missing sbi argument to macro erofs_blknr.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
v2: change commit message a bit

 include/erofs/block_list.h | 4 ++--
 lib/block_list.c           | 5 ++---
 lib/inode.c                | 9 +++++++--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
index 78fab44..e0dced8 100644
--- a/include/erofs/block_list.h
+++ b/include/erofs/block_list.h
@@ -19,7 +19,7 @@ void erofs_droid_blocklist_fclose(void);
 void erofs_droid_blocklist_write(struct erofs_inode *inode,
 				 erofs_blk_t blk_start, erofs_blk_t nblocks);
 void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
-					  erofs_blk_t blkaddr);
+					  erofs_blk_t blkaddr, bool first_block);
 void erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
 					erofs_blk_t blk_start, erofs_blk_t nblocks,
 					bool first_extent, bool last_extent);
@@ -28,7 +28,7 @@ static inline void erofs_droid_blocklist_write(struct erofs_inode *inode,
 				 erofs_blk_t blk_start, erofs_blk_t nblocks) {}
 static inline void
 erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
-					  erofs_blk_t blkaddr) {}
+				     erofs_blk_t blkaddr, bool first_block) {}
 static inline void
 erofs_droid_blocklist_write_extent(struct erofs_inode *inode,
 				   erofs_blk_t blk_start, erofs_blk_t nblocks,
diff --git a/lib/block_list.c b/lib/block_list.c
index 896fb01..a1c719d 100644
--- a/lib/block_list.c
+++ b/lib/block_list.c
@@ -85,7 +85,7 @@ void erofs_droid_blocklist_write(struct erofs_inode *inode,
 }
 
 void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
-					  erofs_blk_t blkaddr)
+					  erofs_blk_t blkaddr, bool first_block)
 {
 	if (!block_list_fp || !cfg.mount_point)
 		return;
@@ -94,8 +94,7 @@ void erofs_droid_blocklist_write_tail_end(struct erofs_inode *inode,
 	if (S_ISDIR(inode->i_mode) || S_ISLNK(inode->i_mode))
 		return;
 
-	/* XXX: another hack, which means it has been outputed before */
-	if (erofs_blknr(inode->i_size)) {
+	if (!first_block) {
 		if (blkaddr == NULL_ADDR)
 			fprintf(block_list_fp, "\n");
 		else
diff --git a/lib/inode.c b/lib/inode.c
index c4d1476..7cd3e69 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -734,12 +734,15 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
 	struct erofs_buffer_head *bh, *ibh;
+	bool first_block;
 
 	bh = inode->bh_data;
 
 	if (!inode->idata_size)
 		goto out;
 
+	first_block = !erofs_blknr(sbi, inode->i_size);
+
 	/* have enough room to inline data */
 	if (inode->bh_inline) {
 		ibh = inode->bh_inline;
@@ -747,7 +750,8 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 		ibh->fsprivate = erofs_igrab(inode);
 		ibh->op = &erofs_write_inline_bhops;
 
-		erofs_droid_blocklist_write_tail_end(inode, NULL_ADDR);
+		erofs_droid_blocklist_write_tail_end(inode, NULL_ADDR,
+						     first_block);
 	} else {
 		int ret;
 		erofs_off_t pos, zero_pos;
@@ -801,7 +805,8 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 		free(inode->idata);
 		inode->idata = NULL;
 
-		erofs_droid_blocklist_write_tail_end(inode, erofs_blknr(sbi, pos));
+		erofs_droid_blocklist_write_tail_end(inode, erofs_blknr(sbi, pos),
+						     first_block);
 	}
 out:
 	/* now bh_data can drop directly */
-- 
2.17.1

