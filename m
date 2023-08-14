Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8131477B672
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 12:19:12 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=nY0rJfnE;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RPVk62s9xz307s
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 20:19:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=nY0rJfnE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RPVk26xdcz303d
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Aug 2023 20:19:06 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bc0d39b52cso24293735ad.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 14 Aug 2023 03:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692008341; x=1692613141;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vm7sv6ZxKCw6lJEOWIlbSRKSHLtdctNopMhaNebjyZw=;
        b=nY0rJfnE7dvtLLQLOLCDqH6AsVS2sdJBYSXPRiyLBj3jwQmcNPfXAuBuC3GCwtg31p
         hm6i/ODIAMUTc7pSFZ823D7Ueoe6+BZoZT1ueCSJJ7ua3eUljKjzsCvBnmYDYbWGtMDU
         c8N5JRpT5WWQHRXgQhZX4JUdnA0KWfnwvvFhswj5pkxRORk/9clHpvEMb9ZxYW8kAy7J
         whuM6Zm+z0i8fgPEOXe+CmdK3pDcLLCExxBrDg5QaJUUTRSyLmr3UAufXXOS9QTLWut6
         5cNxzku5T0hjZk1TazobnTpsabU2pjx//cATjRWYCvp9WwQl4BxgBBvEcSjvKgKh/AZt
         mIGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692008341; x=1692613141;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vm7sv6ZxKCw6lJEOWIlbSRKSHLtdctNopMhaNebjyZw=;
        b=QcYQbBtIzeH8pNZBcF845tYXZa/c4EChgahuSJZyf2/Yc+Oljm+TfvlRmw1DKIdQ6d
         p+eV+FZneE9NIhMueTJSmuV1MtbxlIG6cMP15FImLLT1hsaRE8fI7m0xmvmX2YEyXiy/
         eyNfqzhbsNvkcH+owguiuqTDbh/OCQgxg9EjpA36joYVUzFfnNe54/JCrVECQ0W4s6+S
         w5XTu+73i+46UUZBqUX+JjHB5GVD5/fEhGVtF32jgcuoELAQKUSv42LnLPNspVDWhxua
         jHUuCLR8fRyksBbhuwOkqo7yahbLHNw5VDL1rC+SHqv/PeAHX79ors/NYZKgeMs1yicG
         qn9A==
X-Gm-Message-State: AOJu0Yw4UOqjRnr7S27iLy+HHHxJhDFUVNdY5SrHRGlpDQBokpOcsCz8
	11KD+M0K7A+fHc+MfnCHDsYOCt525o4=
X-Google-Smtp-Source: AGHT+IGbllq6kUbPvX+FawJDx62s0hsZFTZMpgh56qPc6KTfFI1/w1dov3J4hLgMpDF85F76BrhPZw==
X-Received: by 2002:a17:902:c60a:b0:1bc:5924:2da2 with SMTP id r10-20020a170902c60a00b001bc59242da2mr6677312plr.56.1692008341258;
        Mon, 14 Aug 2023 03:19:01 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.163])
        by smtp.gmail.com with ESMTPSA id n10-20020a170902e54a00b001b66a71a4a0sm9015193plf.32.2023.08.14.03.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 03:19:00 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] AOSP: erofs-utils: pass `first_block` to the tail block map in block list
Date: Mon, 14 Aug 2023 18:18:13 +0800
Message-Id: <235c626c925f8eed2548aa88afeb75920b2ab733.1692008092.git.huyue2@coolpad.com>
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
Cc: huyue2@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

We can determine whether the tail block is the first one or not during
the writing process.  Therefore, instead of internally checking the
block number in the block list, just simply pass the flag.

Also, add the missing sbi argument to macro "erofs_blknr".

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
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

