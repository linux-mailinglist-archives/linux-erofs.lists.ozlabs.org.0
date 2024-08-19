Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A733956140
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Aug 2024 04:52:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WnHFb2wMnz2xxp
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Aug 2024 12:52:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=IqaaXMEi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WnHFT5KJxz2xQH
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Aug 2024 12:52:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724035943; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=fSBui4eXgKDMvdVfyLpBwQeHWqC9sk1dCBk95MEHyoA=;
	b=IqaaXMEixzi3BerVkVFjV5KrNmXKgUbRykYUbVITdIqvV5A3GjjR50GNFCMidB2L+C6MtfB1wAZmBzx/EubARRkqqpsO5ZkJpTmYnGLPl4O0HyxOFbQ5WGwnX1YWMvuv9yeh7hUoS+B6W3urPTum5nwpmR4JsYGHOgBBy4ULJxU=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WD4y1IG_1724035928)
          by smtp.aliyun-inc.com;
          Mon, 19 Aug 2024 10:52:22 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] erofs: allow large folios for compressed files
Date: Mon, 19 Aug 2024 10:52:07 +0800
Message-ID: <20240819025207.3808649-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Barry Song <21cnbao@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Matthew Wilcox <willy@infradead.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As commit 2e6506e1c4ee ("mm/migrate: fix deadlock in
migrate_pages_batch() on large folios") already landed upstream,
large folios can be safely enabled for compressed inodes since all
prerequisites already landed in 6.11-rc1.

Stress tests has been working on my fleet for > 20 days without any
regression.  Besides, users [1] has requested it for months.  Let's
allow large folios for EROFS full cases upstream now for wider testing.

[1] https://lore.kernel.org/r/CAGsJ_4wtE8OcpinuqVwG4jtdx6Qh5f+TON6wz+4HMCq=A2qFcA@mail.gmail.com
Cc: Barry Song <21cnbao@gmail.com>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 Documentation/filesystems/erofs.rst |  2 +-
 fs/erofs/inode.c                    | 18 ++++++++----------
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/Documentation/filesystems/erofs.rst b/Documentation/filesystems/erofs.rst
index cc4626d6ee4f..c293f8e37468 100644
--- a/Documentation/filesystems/erofs.rst
+++ b/Documentation/filesystems/erofs.rst
@@ -75,7 +75,7 @@ Here are the main features of EROFS:
 
  - Support merging tail-end data into a special inode as fragments.
 
- - Support large folios for uncompressed files.
+ - Support large folios to make use of THPs (Transparent Hugepages);
 
  - Support direct I/O on uncompressed files to avoid double caching for loop
    devices;
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 43c09aae2afc..419432be3223 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -257,25 +257,23 @@ static int erofs_fill_inode(struct inode *inode)
 		goto out_unlock;
 	}
 
+	mapping_set_large_folios(inode->i_mapping);
 	if (erofs_inode_is_data_compressed(vi->datalayout)) {
 #ifdef CONFIG_EROFS_FS_ZIP
 		DO_ONCE_LITE_IF(inode->i_blkbits != PAGE_SHIFT,
 			  erofs_info, inode->i_sb,
 			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
 		inode->i_mapping->a_ops = &z_erofs_aops;
-		err = 0;
-		goto out_unlock;
-#endif
+#else
 		err = -EOPNOTSUPP;
-		goto out_unlock;
-	}
-	inode->i_mapping->a_ops = &erofs_raw_access_aops;
-	mapping_set_large_folios(inode->i_mapping);
+#endif
+	} else {
+		inode->i_mapping->a_ops = &erofs_raw_access_aops;
 #ifdef CONFIG_EROFS_FS_ONDEMAND
-	if (erofs_is_fscache_mode(inode->i_sb))
-		inode->i_mapping->a_ops = &erofs_fscache_access_aops;
+		if (erofs_is_fscache_mode(inode->i_sb))
+			inode->i_mapping->a_ops = &erofs_fscache_access_aops;
 #endif
-
+	}
 out_unlock:
 	erofs_put_metabuf(&buf);
 	return err;
-- 
2.43.5

