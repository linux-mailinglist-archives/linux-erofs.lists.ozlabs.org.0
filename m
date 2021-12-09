Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3823B46E040
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Dec 2021 02:29:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J8c0H16NRz300S
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Dec 2021 12:29:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42;
 helo=out30-42.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J8c0866MXz2xWc
 for <linux-erofs@lists.ozlabs.org>; Thu,  9 Dec 2021 12:29:41 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0Uzzhg4q_1639013358; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uzzhg4q_1639013358) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 09 Dec 2021 09:29:23 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] erofs: clean up erofs_map_blocks tracepoints
Date: Thu,  9 Dec 2021 09:29:18 +0800
Message-Id: <20211209012918.30337-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Since the new type of chunk-based files is introduced, there is no
need to leave flatmode tracepoints.

Rename to erofs_map_blocks instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v1: https://lore.kernel.org/r/20210921143531.81356-2-hsiangkao@linux.alibaba.com
change since v1:
 - fix m_llen assignment issue pointed out by Chao;

 fs/erofs/data.c              | 39 ++++++++++++++++--------------------
 include/trace/events/erofs.h |  4 ++--
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 0e35ef3f9f3d..4f98c76ec043 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -26,20 +26,16 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 				     struct erofs_map_blocks *map,
 				     int flags)
 {
-	int err = 0;
 	erofs_blk_t nblocks, lastblk;
 	u64 offset = map->m_la;
 	struct erofs_inode *vi = EROFS_I(inode);
 	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
 
-	trace_erofs_map_blocks_flatmode_enter(inode, map, flags);
-
 	nblocks = DIV_ROUND_UP(inode->i_size, PAGE_SIZE);
 	lastblk = nblocks - tailendpacking;
 
 	/* there is no hole in flatmode */
 	map->m_flags = EROFS_MAP_MAPPED;
-
 	if (offset < blknr_to_addr(lastblk)) {
 		map->m_pa = blknr_to_addr(vi->raw_blkaddr) + map->m_la;
 		map->m_plen = blknr_to_addr(lastblk) - offset;
@@ -51,30 +47,23 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
 			vi->xattr_isize + erofs_blkoff(map->m_la);
 		map->m_plen = inode->i_size - offset;
 
-		/* inline data should be located in one meta block */
-		if (erofs_blkoff(map->m_pa) + map->m_plen > PAGE_SIZE) {
+		/* inline data should be located in the same meta block */
+		if (erofs_blkoff(map->m_pa) + map->m_plen > EROFS_BLKSIZ) {
 			erofs_err(inode->i_sb,
 				  "inline data cross block boundary @ nid %llu",
 				  vi->nid);
 			DBG_BUGON(1);
-			err = -EFSCORRUPTED;
-			goto err_out;
+			return -EFSCORRUPTED;
 		}
-
 		map->m_flags |= EROFS_MAP_META;
 	} else {
 		erofs_err(inode->i_sb,
 			  "internal error @ nid: %llu (size %llu), m_la 0x%llx",
 			  vi->nid, inode->i_size, map->m_la);
 		DBG_BUGON(1);
-		err = -EIO;
-		goto err_out;
+		return -EIO;
 	}
-
-	map->m_llen = map->m_plen;
-err_out:
-	trace_erofs_map_blocks_flatmode_exit(inode, map, flags, 0);
-	return err;
+	return 0;
 }
 
 static int erofs_map_blocks(struct inode *inode,
@@ -89,6 +78,7 @@ static int erofs_map_blocks(struct inode *inode,
 	erofs_off_t pos;
 	int err = 0;
 
+	trace_erofs_map_blocks_enter(inode, map, flags);
 	map->m_deviceid = 0;
 	if (map->m_la >= inode->i_size) {
 		/* leave out-of-bound access unmapped */
@@ -97,8 +87,10 @@ static int erofs_map_blocks(struct inode *inode,
 		goto out;
 	}
 
-	if (vi->datalayout != EROFS_INODE_CHUNK_BASED)
-		return erofs_map_blocks_flatmode(inode, map, flags);
+	if (vi->datalayout != EROFS_INODE_CHUNK_BASED) {
+		err = erofs_map_blocks_flatmode(inode, map, flags);
+		goto out;
+	}
 
 	if (vi->chunkformat & EROFS_CHUNK_FORMAT_INDEXES)
 		unit = sizeof(*idx);			/* chunk index */
@@ -110,9 +102,10 @@ static int erofs_map_blocks(struct inode *inode,
 		    vi->xattr_isize, unit) + unit * chunknr;
 
 	page = erofs_get_meta_page(inode->i_sb, erofs_blknr(pos));
-	if (IS_ERR(page))
-		return PTR_ERR(page);
-
+	if (IS_ERR(page)) {
+		err = PTR_ERR(page);
+		goto out;
+	}
 	map->m_la = chunknr << vi->chunkbits;
 	map->m_plen = min_t(erofs_off_t, 1UL << vi->chunkbits,
 			    roundup(inode->i_size - map->m_la, EROFS_BLKSIZ));
@@ -146,7 +139,9 @@ static int erofs_map_blocks(struct inode *inode,
 	unlock_page(page);
 	put_page(page);
 out:
-	map->m_llen = map->m_plen;
+	if (!err)
+		map->m_llen = map->m_plen;
+	trace_erofs_map_blocks_exit(inode, map, flags, 0);
 	return err;
 }
 
diff --git a/include/trace/events/erofs.h b/include/trace/events/erofs.h
index 16ae7b666810..57de057bd503 100644
--- a/include/trace/events/erofs.h
+++ b/include/trace/events/erofs.h
@@ -169,7 +169,7 @@ DECLARE_EVENT_CLASS(erofs__map_blocks_enter,
 		  __entry->flags ? show_map_flags(__entry->flags) : "NULL")
 );
 
-DEFINE_EVENT(erofs__map_blocks_enter, erofs_map_blocks_flatmode_enter,
+DEFINE_EVENT(erofs__map_blocks_enter, erofs_map_blocks_enter,
 	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
 		 unsigned flags),
 
@@ -221,7 +221,7 @@ DECLARE_EVENT_CLASS(erofs__map_blocks_exit,
 		  show_mflags(__entry->mflags), __entry->ret)
 );
 
-DEFINE_EVENT(erofs__map_blocks_exit, erofs_map_blocks_flatmode_exit,
+DEFINE_EVENT(erofs__map_blocks_exit, erofs_map_blocks_exit,
 	TP_PROTO(struct inode *inode, struct erofs_map_blocks *map,
 		 unsigned flags, int ret),
 
-- 
2.24.4

