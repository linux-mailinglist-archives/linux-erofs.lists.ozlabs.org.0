Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B16E4CFEAD
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Mar 2022 13:33:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KByYY3wZCz3bTs
	for <lists+linux-erofs@lfdr.de>; Mon,  7 Mar 2022 23:33:37 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KByYK1GL1z30Q9
 for <linux-erofs@lists.ozlabs.org>; Mon,  7 Mar 2022 23:33:24 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R171e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=15; SR=0; TI=SMTPD_---0V6VlXwW_1646656397; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V6VlXwW_1646656397) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 07 Mar 2022 20:33:18 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v4 08/21] erofs: export erofs_map_blocks()
Date: Mon,  7 Mar 2022 20:32:52 +0800
Message-Id: <20220307123305.79520-9-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
References: <20220307123305.79520-1-jefflexu@linux.alibaba.com>
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
Cc: gregkh@linuxfoundation.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
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
index 226a57c57ee6..6e2a28242453 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -104,8 +104,8 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 	return 0;
 }
 
-static int erofs_map_blocks(struct inode *inode,
-			    struct erofs_map_blocks *map, int flags)
+int erofs_map_blocks(struct inode *inode,
+		     struct erofs_map_blocks *map, int flags)
 {
 	struct super_block *sb = inode->i_sb;
 	struct erofs_inode *vi = EROFS_I(inode);
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b8272fb95fd6..f9f94d63d40f 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -484,6 +484,8 @@ void *erofs_read_metabuf(struct erofs_buf *buf, struct super_block *sb,
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *dev);
 int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		 u64 start, u64 len);
+int erofs_map_blocks(struct inode *inode,
+		     struct erofs_map_blocks *map, int flags);
 
 /* inode.c */
 static inline unsigned long erofs_inode_hash(erofs_nid_t nid)
-- 
2.27.0

