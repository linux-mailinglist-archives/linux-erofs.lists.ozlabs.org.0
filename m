Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C18456DD78E
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Apr 2023 12:11:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PwhSc4Xgmz3cLh
	for <lists+linux-erofs@lfdr.de>; Tue, 11 Apr 2023 20:11:12 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PwhSS3Yqvz3c8T
	for <linux-erofs@lists.ozlabs.org>; Tue, 11 Apr 2023 20:11:03 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vfrtabo_1681207847;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vfrtabo_1681207847)
          by smtp.aliyun-inc.com;
          Tue, 11 Apr 2023 18:10:59 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: get rid of z_erofs_fill_inode()
Date: Tue, 11 Apr 2023 18:10:45 +0800
Message-Id: <20230411101045.35762-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Prior to big pclusters, non-compact compression indexes could have
empty headers.

Let's just avoid the legacy path since it can be handled properly
as a specific compression header with z_erofs_fill_inode_lazy() too.

Tested with erofs-utils exist versions.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c    |  8 +++++---
 fs/erofs/internal.h |  2 --
 fs/erofs/zmap.c     | 18 ------------------
 3 files changed, 5 insertions(+), 23 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 7ca9aafb7471..4438ed5b08be 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -292,10 +292,12 @@ static int erofs_fill_inode(struct inode *inode)
 
 	if (erofs_inode_is_data_compressed(vi->datalayout)) {
 		if (!erofs_is_fscache_mode(inode->i_sb) &&
-		    inode->i_sb->s_blocksize_bits == PAGE_SHIFT)
-			err = z_erofs_fill_inode(inode);
-		else
+		    inode->i_sb->s_blocksize_bits == PAGE_SHIFT) {
+			inode->i_mapping->a_ops = &z_erofs_aops;
+			err = 0;
+		} else {
 			err = -EOPNOTSUPP;
+		}
 		goto out_unlock;
 	}
 	inode->i_mapping->a_ops = &erofs_raw_access_aops;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index f675050af2bb..f1268cb6a37c 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -522,7 +522,6 @@ int erofs_try_to_free_cached_page(struct page *page);
 int z_erofs_load_lz4_config(struct super_block *sb,
 			    struct erofs_super_block *dsb,
 			    struct z_erofs_lz4_cfgs *lz4, int len);
-int z_erofs_fill_inode(struct inode *inode);
 int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			    int flags);
 #else
@@ -542,7 +541,6 @@ static inline int z_erofs_load_lz4_config(struct super_block *sb,
 	}
 	return 0;
 }
-static inline int z_erofs_fill_inode(struct inode *inode) { return -EOPNOTSUPP; }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 #ifdef CONFIG_EROFS_FS_ZIP_LZMA
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 7ca108c3834c..14c21284d019 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -7,24 +7,6 @@
 #include <asm/unaligned.h>
 #include <trace/events/erofs.h>
 
-int z_erofs_fill_inode(struct inode *inode)
-{
-	struct erofs_inode *const vi = EROFS_I(inode);
-	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
-
-	if (!erofs_sb_has_big_pcluster(sbi) &&
-	    !erofs_sb_has_ztailpacking(sbi) && !erofs_sb_has_fragments(sbi) &&
-	    vi->datalayout == EROFS_INODE_COMPRESSED_FULL) {
-		vi->z_advise = 0;
-		vi->z_algorithmtype[0] = 0;
-		vi->z_algorithmtype[1] = 0;
-		vi->z_logical_clusterbits = inode->i_sb->s_blocksize_bits;
-		set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
-	}
-	inode->i_mapping->a_ops = &z_erofs_aops;
-	return 0;
-}
-
 struct z_erofs_maprecorder {
 	struct inode *inode;
 	struct erofs_map_blocks *map;
-- 
2.24.4

