Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9EF7D7AC9
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Oct 2023 04:16:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SG8Yp3ssDz2yQ8
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Oct 2023 13:16:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=mengferry@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SG8Yg53Kmz2xwD
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Oct 2023 13:16:38 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VuvzTZ6_1698286588;
Received: from localhost(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0VuvzTZ6_1698286588)
          by smtp.aliyun-inc.com;
          Thu, 26 Oct 2023 10:16:33 +0800
From: Ferry Meng <mengferry@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs: get rid of ROOT_NID()
Date: Thu, 26 Oct 2023 10:16:26 +0800
Message-Id: <20231026021627.23284-1-mengferry@linux.alibaba.com>
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
Cc: Ferry Meng <mengferry@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Let's open code this helper for simplicity.

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
 fs/erofs/internal.h | 2 --
 fs/erofs/super.c    | 6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4ff88d0dd980..ca7d85958450 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -228,8 +228,6 @@ struct erofs_buf {
 };
 #define __EROFS_BUF_INITIALIZER	((struct erofs_buf){ .page = NULL })
 
-#define ROOT_NID(sb)		((sb)->root_nid)
-
 #define erofs_blknr(sb, addr)	((addr) >> (sb)->s_blocksize_bits)
 #define erofs_blkoff(sb, addr)	((addr) & ((sb)->s_blocksize - 1))
 #define erofs_pos(sb, blk)	((erofs_off_t)(blk) << (sb)->s_blocksize_bits)
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3700af9ee173..019229eb2ef6 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -724,13 +724,13 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	xa_init(&sbi->managed_pslots);
 #endif
 
-	inode = erofs_iget(sb, ROOT_NID(sbi));
+	inode = erofs_iget(sb, sbi->root_nid);
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
 	if (!S_ISDIR(inode->i_mode)) {
 		erofs_err(sb, "rootino(nid %llu) is not a directory(i_mode %o)",
-			  ROOT_NID(sbi), inode->i_mode);
+			  sbi->root_nid, inode->i_mode);
 		iput(inode);
 		return -EINVAL;
 	}
@@ -760,7 +760,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (err)
 		return err;
 
-	erofs_info(sb, "mounted with root inode @ nid %llu.", ROOT_NID(sbi));
+	erofs_info(sb, "mounted with root inode @ nid %llu.", sbi->root_nid);
 	return 0;
 }
 
-- 
2.19.1.6.gb485710b

