Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 390576CB52D
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Mar 2023 05:55:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PlwnP0d4Kz3fCp
	for <lists+linux-erofs@lfdr.de>; Tue, 28 Mar 2023 14:55:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PlwnD5sKvz3cRW
	for <linux-erofs@lists.ozlabs.org>; Tue, 28 Mar 2023 14:55:11 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R871e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VerNeOs_1679975697;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VerNeOs_1679975697)
          by smtp.aliyun-inc.com;
          Tue, 28 Mar 2023 11:55:06 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: fix missing tail blocks for directories
Date: Tue, 28 Mar 2023 11:54:55 +0800
Message-Id: <20230328035456.89831-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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

Currently directory blocks will be allocated after inode metadata
space is reserved, but miss to fix tail blocks.

Fixes: 21d84349e79a ("erofs-utils: rearrange on-disk metadata")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  1 +
 lib/inode.c              | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 1f1e730..641a795 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -180,6 +180,7 @@ struct erofs_inode {
 	/* inline tail-end packing size */
 	unsigned short idata_size;
 	bool compressed_idata;
+	bool lazy_tailblock;
 
 	unsigned int xattr_isize;
 	unsigned int extent_isize;
diff --git a/lib/inode.c b/lib/inode.c
index 9db84a8..871968d 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -608,7 +608,12 @@ static int erofs_prepare_tail_block(struct erofs_inode *inode)
 	if (bh) {
 		/* expend a block as the tail block (should be successful) */
 		ret = erofs_bh_balloon(bh, erofs_blksiz());
-		DBG_BUGON(ret != erofs_blksiz());
+		if (ret != erofs_blksiz()) {
+			DBG_BUGON(1);
+			return -EIO;
+		}
+	} else {
+		inode->lazy_tailblock = true;
 	}
 	return 0;
 }
@@ -743,6 +748,15 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 			inode->u.i_blkaddr = bh->block->blkaddr;
 			inode->bh_data = bh;
 		} else {
+			if (inode->lazy_tailblock) {
+				/* expend a tail block (should be successful) */
+				ret = erofs_bh_balloon(bh, erofs_blksiz());
+				if (ret != erofs_blksiz()) {
+					DBG_BUGON(1);
+					return -EIO;
+				}
+				inode->lazy_tailblock = false;
+			}
 			ret = erofs_mapbh(bh->block);
 		}
 		DBG_BUGON(ret < 0);
-- 
2.24.4

