Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D37CB94C8EE
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Aug 2024 05:38:09 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=alHDRqsG;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wg8kl0K3Tz2yhZ
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Aug 2024 13:38:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=alHDRqsG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wg8kd0rFKz2xYp
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Aug 2024 13:37:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723174674; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=vbw+cx1jiLGMJq7a1OIkAaXq4P3EJsEA93E8guL6sR4=;
	b=alHDRqsGgnYL77cYUL/UGk+CZ9VsXwNW/XX0LZou+S1lkH4p4LSs+/WJCIpiHdArKTYkH6AJgF/uCUCrMZ7rv+U5D/h3c7e+fa3zOo4xDPgLfrb5W6vTGmQPoBPaXlycLAHv2QcS3J9w/qDelLRkWqbGYAic9Nt8HBOUJCNMouY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WCORoSa_1723174668;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WCORoSa_1723174668)
          by smtp.aliyun-inc.com;
          Fri, 09 Aug 2024 11:37:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: fix truncated uncompressed files
Date: Fri,  9 Aug 2024 11:37:47 +0800
Message-ID: <20240809033747.3178912-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

Some uncompressed files which are more than 4GiB can be truncated
incorrectly.

Fixes: 358177730598 ("erofs-utils: optimize write_uncompressed_file_from_fd()")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
(sigh, I need to fix this issue right now as erofs-utils 1.8.1.
 and I will add a large file test for this although it may not be
 friendly for small test runners. )

 lib/inode.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index b3547bf..b9dbbd6 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -515,7 +515,8 @@ static bool erofs_file_is_compressible(struct erofs_inode *inode)
 static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 {
 	int ret;
-	unsigned int nblocks;
+	erofs_blk_t nblocks, i;
+	unsigned int len;
 	struct erofs_sb_info *sbi = inode->sbi;
 
 	inode->datalayout = EROFS_INODE_FLAT_INLINE;
@@ -525,12 +526,16 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 	if (ret)
 		return ret;
 
-	ret = erofs_io_xcopy(&sbi->bdev, erofs_pos(sbi, inode->u.i_blkaddr),
-			     &((struct erofs_vfile){ .fd = fd }),
-			     erofs_pos(sbi, nblocks),
+	for (i = 0; i < nblocks; i += (len >> sbi->blkszbits)) {
+		len = min_t(u64, round_down(UINT_MAX, 1U << sbi->blkszbits),
+			    erofs_pos(sbi, nblocks - i));
+		ret = erofs_io_xcopy(&sbi->bdev,
+				     erofs_pos(sbi, inode->u.i_blkaddr + i),
+				     &((struct erofs_vfile){ .fd = fd }), len,
 			inode->datasource == EROFS_INODE_DATA_SOURCE_DISKBUF);
-	if (ret)
-		return ret;
+		if (ret)
+			return ret;
+	}
 
 	/* read the tail-end data */
 	inode->idata_size = inode->i_size % erofs_blksiz(sbi);
-- 
2.43.5

