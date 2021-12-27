Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3017047FD02
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 13:55:44 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JMyML1Hqxz3bbF
	for <lists+linux-erofs@lfdr.de>; Mon, 27 Dec 2021 23:55:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.88.44.36;
 helo=out4436.biz.mail.alibaba.com; envelope-from=jefflexu@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JMyMC4RRvz30BM
 for <linux-erofs@lists.ozlabs.org>; Mon, 27 Dec 2021 23:55:35 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R911e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=12; SR=0; TI=SMTPD_---0V.wf8nA_1640609691; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V.wf8nA_1640609691) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 27 Dec 2021 20:54:52 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v1 06/23] erofs: export erofs_map_blocks()
Date: Mon, 27 Dec 2021 20:54:27 +0800
Message-Id: <20211227125444.21187-7-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
References: <20211227125444.21187-1-jefflexu@linux.alibaba.com>
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
Cc: tao.peng@linux.alibaba.com, linux-kernel@vger.kernel.org,
 joseph.qi@linux.alibaba.com, bo.liu@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, eguan@linux.alibaba.com,
 gerry@linux.alibaba.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

... so that it can be used in the following introduced fs/erofs/fscache.c.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/data.c     | 4 ++--
 fs/erofs/internal.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 0e35ef3f9f3d..477aaff0c832 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -77,8 +77,8 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 	return err;
 }
 
-static int erofs_map_blocks(struct inode *inode,
-			    struct erofs_map_blocks *map, int flags)
+int erofs_map_blocks(struct inode *inode,
+		     struct erofs_map_blocks *map, int flags)
 {
 	struct super_block *sb = inode->i_sb;
 	struct erofs_inode *vi = EROFS_I(inode);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3265688af7f9..45fb6f5d11b5 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -447,6 +447,8 @@ struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr);
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 u64 start, u64 len);
+int erofs_map_blocks(struct inode *inode,
+		     struct erofs_map_blocks *map, int flags);
 
 /* inode.c */
 static inline unsigned long erofs_inode_hash(erofs_nid_t nid)
-- 
2.27.0

