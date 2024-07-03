Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FEA925581
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 10:37:51 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OwnqpZd6;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WDY7d2Lhjz3cY0
	for <lists+linux-erofs@lfdr.de>; Wed,  3 Jul 2024 18:37:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=OwnqpZd6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WDY7V5QW6z3cY0
	for <linux-erofs@lists.ozlabs.org>; Wed,  3 Jul 2024 18:37:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719995856; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=YUo14g3kmaZJ075YGEub9spJ8zAo44dOGeWa+8Wt2DQ=;
	b=OwnqpZd6/qOz/QgoiBdXGWp83ONTlJGBflWbeLumIkTlgrcT8gETM8o4GlIGCN4LKeo0r5nQqmBTGh9q9L5v58OsDBqBR9X+melaqFIRezIQy0EVE/yy7eD9xlnhaG2qvVEcBFHnkyTEny2SyORXk5x5yWyseKJjJLan33hPPvM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hongzhen@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W9llYjr_1719995854;
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0W9llYjr_1719995854)
          by smtp.aliyun-inc.com;
          Wed, 03 Jul 2024 16:37:35 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: lib: update function calls to align with per-sbi buffer
Date: Wed,  3 Jul 2024 16:37:21 +0800
Message-Id: <20240703083721.3585434-2-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240703083721.3585434-1-hongzhen@linux.alibaba.com>
References: <20240703083721.3585434-1-hongzhen@linux.alibaba.com>
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
Cc: Hongzhen Luo <hongzhen@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 lib/blobchunk.c | 20 ++++++++++----------
 lib/compress.c  | 40 ++++++++++++++++++++--------------------
 lib/inode.c     | 43 ++++++++++++++++++++++---------------------
 lib/xattr.c     | 10 +++++-----
 mkfs/main.c     | 22 ++++++++++++----------
 5 files changed, 69 insertions(+), 66 deletions(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 9af223d..1169288 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -496,8 +496,8 @@ int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi)
 		unsigned int i, ret;
 		erofs_blk_t nblocks;
 
-		nblocks = erofs_mapbh(NULL);
-		pos_out = erofs_btell(bh_devt, false);
+		nblocks = erofs_mapbh(sbi, NULL);
+		pos_out = erofs_btell(sbi, bh_devt, false);
 		i = 0;
 		do {
 			struct erofs_deviceslot dis = {
@@ -513,17 +513,17 @@ int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi)
 			nblocks += sbi->devs[i].blocks;
 		} while (++i < sbi->extra_devices);
 		bh_devt->op = &erofs_drop_directly_bhops;
-		erofs_bdrop(bh_devt, false);
+		erofs_bdrop(sbi, bh_devt, false);
 		return 0;
 	}
 
-	bh = erofs_balloc(DATA, datablob_size, 0, 0);
+	bh = erofs_balloc(sbi, DATA, datablob_size, 0, 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 
-	erofs_mapbh(bh->block);
+	erofs_mapbh(sbi, bh->block);
 
-	pos_out = erofs_btell(bh, false);
+	pos_out = erofs_btell(sbi, bh, false);
 	remapped_base = erofs_blknr(sbi, pos_out);
 	pos_out += sbi->bdev.offset;
 	if (blobfile) {
@@ -535,7 +535,7 @@ int erofs_mkfs_dump_blobs(struct erofs_sb_info *sbi)
 		ret = erofs_io_ftruncate(&sbi->bdev, pos_out + datablob_size);
 	}
 	bh->op = &erofs_drop_directly_bhops;
-	erofs_bdrop(bh, false);
+	erofs_bdrop(sbi, bh, false);
 	return ret;
 }
 
@@ -626,15 +626,15 @@ int erofs_mkfs_init_devices(struct erofs_sb_info *sbi, unsigned int devices)
 	if (!sbi->devs)
 		return -ENOMEM;
 
-	bh_devt = erofs_balloc(DEVT,
+	bh_devt = erofs_balloc(sbi, DEVT,
 		sizeof(struct erofs_deviceslot) * devices, 0, 0);
 	if (IS_ERR(bh_devt)) {
 		free(sbi->devs);
 		return PTR_ERR(bh_devt);
 	}
-	erofs_mapbh(bh_devt->block);
+	erofs_mapbh(sbi, bh_devt->block);
 	bh_devt->op = &erofs_skip_write_bhops;
-	sbi->devt_slotoff = erofs_btell(bh_devt, false) / EROFS_DEVT_SLOT_SIZE;
+	sbi->devt_slotoff = erofs_btell(sbi, bh_devt, false) / EROFS_DEVT_SLOT_SIZE;
 	sbi->extra_devices = devices;
 	erofs_sb_set_device_table(sbi);
 	return 0;
diff --git a/lib/compress.c b/lib/compress.c
index b473587..e74e58c 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1111,7 +1111,7 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 	}
 
 	if (compressed_blocks) {
-		ret = erofs_bh_balloon(bh, erofs_pos(sbi, compressed_blocks));
+		ret = erofs_bh_balloon(sbi, bh, erofs_pos(sbi, compressed_blocks));
 		DBG_BUGON(ret != erofs_blksiz(sbi));
 	} else {
 		if (!cfg.c_fragments && !cfg.c_dedupe)
@@ -1126,7 +1126,7 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 		bh->op = &erofs_skip_write_bhops;
 		inode->bh_data = bh;
 	} else {
-		erofs_bdrop(bh, false);
+		erofs_bdrop(sbi, bh, false);
 	}
 
 	inode->u.i_blocks = compressed_blocks;
@@ -1148,7 +1148,7 @@ err_free_meta:
 	free(compressmeta);
 	inode->compressmeta = NULL;
 err_free_idata:
-	erofs_bdrop(bh, true);	/* revoke buffer */
+	erofs_bdrop(sbi, bh, true);	/* revoke buffer */
 	if (inode->idata) {
 		free(inode->idata);
 		inode->idata = NULL;
@@ -1366,14 +1366,14 @@ int erofs_mt_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 		pthread_cond_wait(&ictx->cond, &ictx->mutex);
 	pthread_mutex_unlock(&ictx->mutex);
 
-	bh = erofs_balloc(DATA, 0, 0, 0);
+	bh = erofs_balloc(ictx->inode->sbi, DATA, 0, 0, 0);
 	if (IS_ERR(bh)) {
 		ret = PTR_ERR(bh);
 		goto out;
 	}
 
 	DBG_BUGON(!head);
-	blkaddr = erofs_mapbh(bh->block);
+	blkaddr = erofs_mapbh(ictx->inode->sbi, bh->block);
 
 	ret = 0;
 	do {
@@ -1531,12 +1531,12 @@ int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 #endif
 
 	/* allocate main data buffer */
-	bh = erofs_balloc(DATA, 0, 0, 0);
+	bh = erofs_balloc(inode->sbi, DATA, 0, 0, 0);
 	if (IS_ERR(bh)) {
 		ret = PTR_ERR(bh);
 		goto err_free_idata;
 	}
-	blkaddr = erofs_mapbh(bh->block); /* start_blkaddr */
+	blkaddr = erofs_mapbh(inode->sbi, bh->block); /* start_blkaddr */
 
 	ictx->seg_num = 1;
 	sctx = (struct z_erofs_compress_sctx) {
@@ -1560,7 +1560,7 @@ int erofs_write_compressed_file(struct z_erofs_compress_ictx *ictx)
 	goto out;
 
 err_free_idata:
-	erofs_bdrop(bh, true);	/* revoke buffer */
+	erofs_bdrop(inode->sbi, bh, true);	/* revoke buffer */
 	if (inode->idata) {
 		free(inode->idata);
 		inode->idata = NULL;
@@ -1596,13 +1596,13 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 			}
 		};
 
-		bh = erofs_battach(bh, META, sizeof(lz4alg));
+		bh = erofs_battach(sbi, bh, META, sizeof(lz4alg));
 		if (IS_ERR(bh)) {
 			DBG_BUGON(1);
 			return PTR_ERR(bh);
 		}
-		erofs_mapbh(bh->block);
-		ret = erofs_dev_write(sbi, &lz4alg, erofs_btell(bh, false),
+		erofs_mapbh(sbi, bh->block);
+		ret = erofs_dev_write(sbi, &lz4alg, erofs_btell(sbi, bh, false),
 				      sizeof(lz4alg));
 		bh->op = &erofs_drop_directly_bhops;
 	}
@@ -1620,13 +1620,13 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 			}
 		};
 
-		bh = erofs_battach(bh, META, sizeof(lzmaalg));
+		bh = erofs_battach(sbi, bh, META, sizeof(lzmaalg));
 		if (IS_ERR(bh)) {
 			DBG_BUGON(1);
 			return PTR_ERR(bh);
 		}
-		erofs_mapbh(bh->block);
-		ret = erofs_dev_write(sbi, &lzmaalg, erofs_btell(bh, false),
+		erofs_mapbh(sbi, bh->block);
+		ret = erofs_dev_write(sbi, &lzmaalg, erofs_btell(sbi, bh, false),
 				      sizeof(lzmaalg));
 		bh->op = &erofs_drop_directly_bhops;
 	}
@@ -1644,13 +1644,13 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 			}
 		};
 
-		bh = erofs_battach(bh, META, sizeof(zalg));
+		bh = erofs_battach(sbi, bh, META, sizeof(zalg));
 		if (IS_ERR(bh)) {
 			DBG_BUGON(1);
 			return PTR_ERR(bh);
 		}
-		erofs_mapbh(bh->block);
-		ret = erofs_dev_write(sbi, &zalg, erofs_btell(bh, false),
+		erofs_mapbh(sbi, bh->block);
+		ret = erofs_dev_write(sbi, &zalg, erofs_btell(sbi, bh, false),
 				      sizeof(zalg));
 		bh->op = &erofs_drop_directly_bhops;
 	}
@@ -1667,13 +1667,13 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
 			}
 		};
 
-		bh = erofs_battach(bh, META, sizeof(zalg));
+		bh = erofs_battach(sbi, bh, META, sizeof(zalg));
 		if (IS_ERR(bh)) {
 			DBG_BUGON(1);
 			return PTR_ERR(bh);
 		}
-		erofs_mapbh(bh->block);
-		ret = erofs_dev_write(sbi, &zalg, erofs_btell(bh, false),
+		erofs_mapbh(sbi, bh->block);
+		ret = erofs_dev_write(sbi, &zalg, erofs_btell(sbi, bh, false),
 				      sizeof(zalg));
 		bh->op = &erofs_drop_directly_bhops;
 	}
diff --git a/lib/inode.c b/lib/inode.c
index 3e82af7..95047f5 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -186,7 +186,8 @@ static int __allocate_inode_bh_data(struct erofs_inode *inode,
 	}
 
 	/* allocate main data buffer */
-	bh = erofs_balloc(type, erofs_pos(inode->sbi, nblocks), 0, 0);
+	bh = erofs_balloc(inode->sbi, type, erofs_pos(inode->sbi, nblocks),
+					0, 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 
@@ -194,7 +195,7 @@ static int __allocate_inode_bh_data(struct erofs_inode *inode,
 	inode->bh_data = bh;
 
 	/* get blkaddr of the bh */
-	ret = erofs_mapbh(bh->block);
+	ret = erofs_mapbh(inode->sbi, bh->block);
 	DBG_BUGON(ret < 0);
 
 	/* write blocks except for the tail-end block */
@@ -314,8 +315,8 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
 	erofs_off_t off, meta_offset;
 
 	if (bh && (long long)inode->nid <= 0) {
-		erofs_mapbh(bh->block);
-		off = erofs_btell(bh, false);
+		erofs_mapbh(sbi, bh->block);
+		off = erofs_btell(sbi, bh, false);
 
 		meta_offset = erofs_pos(sbi, sbi->meta_blkaddr);
 		DBG_BUGON(off < meta_offset);
@@ -576,7 +577,7 @@ int erofs_iflush(struct erofs_inode *inode)
 	int ret;
 
 	if (inode->bh)
-		off = erofs_btell(inode->bh, false);
+		off = erofs_btell(sbi, inode->bh, false);
 	else
 		off = erofs_iloc(inode);
 
@@ -724,7 +725,7 @@ static int erofs_prepare_tail_block(struct erofs_inode *inode)
 	bh = inode->bh_data;
 	if (bh) {
 		/* expend a block as the tail block (should be successful) */
-		ret = erofs_bh_balloon(bh, erofs_blksiz(sbi));
+		ret = erofs_bh_balloon(sbi, bh, erofs_blksiz(sbi));
 		if (ret != erofs_blksiz(sbi)) {
 			DBG_BUGON(1);
 			return -EIO;
@@ -768,7 +769,7 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 			inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 	}
 
-	bh = erofs_balloc(INODE, inodesize, 0, inode->idata_size);
+	bh = erofs_balloc(inode->sbi, INODE, inodesize, 0, inode->idata_size);
 	if (bh == ERR_PTR(-ENOSPC)) {
 		int ret;
 
@@ -781,7 +782,7 @@ noinline:
 		ret = erofs_prepare_tail_block(inode);
 		if (ret)
 			return ret;
-		bh = erofs_balloc(INODE, inodesize, 0, 0);
+		bh = erofs_balloc(inode->sbi, INODE, inodesize, 0, 0);
 		if (IS_ERR(bh))
 			return PTR_ERR(bh);
 		DBG_BUGON(inode->bh_inline);
@@ -801,7 +802,7 @@ noinline:
 		}
 
 		/* allocate inline buffer */
-		ibh = erofs_battach(bh, META, inode->idata_size);
+		ibh = erofs_battach(inode->sbi, bh, META, inode->idata_size);
 		if (IS_ERR(ibh))
 			return PTR_ERR(ibh);
 
@@ -818,7 +819,7 @@ noinline:
 static int erofs_bh_flush_write_inline(struct erofs_buffer_head *bh)
 {
 	struct erofs_inode *const inode = bh->fsprivate;
-	const erofs_off_t off = erofs_btell(bh, false);
+	const erofs_off_t off = erofs_btell(inode->sbi, bh, false);
 	int ret;
 
 	ret = erofs_dev_write(inode->sbi, inode->idata, off, inode->idata_size);
@@ -860,29 +861,29 @@ static int erofs_write_tail_end(struct erofs_inode *inode)
 		erofs_off_t pos, zero_pos;
 
 		if (!bh) {
-			bh = erofs_balloc(DATA, erofs_blksiz(sbi), 0, 0);
+			bh = erofs_balloc(sbi, DATA, erofs_blksiz(sbi), 0, 0);
 			if (IS_ERR(bh))
 				return PTR_ERR(bh);
 			bh->op = &erofs_skip_write_bhops;
 
 			/* get blkaddr of bh */
-			ret = erofs_mapbh(bh->block);
+			ret = erofs_mapbh(sbi, bh->block);
 			inode->u.i_blkaddr = bh->block->blkaddr;
 			inode->bh_data = bh;
 		} else {
 			if (inode->lazy_tailblock) {
 				/* expend a tail block (should be successful) */
-				ret = erofs_bh_balloon(bh, erofs_blksiz(sbi));
+				ret = erofs_bh_balloon(sbi, bh, erofs_blksiz(sbi));
 				if (ret != erofs_blksiz(sbi)) {
 					DBG_BUGON(1);
 					return -EIO;
 				}
 				inode->lazy_tailblock = false;
 			}
-			ret = erofs_mapbh(bh->block);
+			ret = erofs_mapbh(sbi, bh->block);
 		}
 		DBG_BUGON(ret < 0);
-		pos = erofs_btell(bh, true) - erofs_blksiz(sbi);
+		pos = erofs_btell(sbi, bh, true) - erofs_blksiz(sbi);
 
 		/* 0'ed data should be padded at head for 0padding conversion */
 		if (erofs_sb_has_lz4_0padding(sbi) && inode->compressed_idata) {
@@ -917,7 +918,7 @@ out:
 		 * Don't leave DATA buffers which were written in the global
 		 * buffer list. It will make balloc() slowly.
 		 */
-		erofs_bdrop(bh, false);
+		erofs_bdrop(sbi, bh, false);
 		inode->bh_data = NULL;
 	}
 	return 0;
@@ -1157,8 +1158,8 @@ static void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
 	struct erofs_sb_info *sbi = rootdir->sbi;
 	erofs_off_t off, meta_offset;
 
-	erofs_mapbh(bh->block);
-	off = erofs_btell(bh, false);
+	erofs_mapbh(sbi, bh->block);
+	off = erofs_btell(sbi, bh, false);
 
 	if (off > rootnid_maxoffset)
 		meta_offset = round_up(off - rootnid_maxoffset, erofs_blksiz(sbi));
@@ -1176,16 +1177,16 @@ static int erofs_inode_reserve_data_blocks(struct erofs_inode *inode)
 	struct erofs_buffer_head *bh;
 
 	/* allocate data blocks */
-	bh = erofs_balloc(DATA, alignedsz, 0, 0);
+	bh = erofs_balloc(sbi, DATA, alignedsz, 0, 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
 
 	/* get blkaddr of the bh */
-	(void)erofs_mapbh(bh->block);
+	(void)erofs_mapbh(sbi, bh->block);
 
 	/* write blocks except for the tail-end block */
 	inode->u.i_blkaddr = bh->block->blkaddr;
-	erofs_bdrop(bh, false);
+	erofs_bdrop(sbi, bh, false);
 
 	inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 	tarerofs_blocklist_write(inode->u.i_blkaddr, nblocks, inode->i_ino[1]);
diff --git a/lib/xattr.c b/lib/xattr.c
index b0f80e9..3356c3e 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -906,7 +906,7 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 		return -ENOMEM;
 	}
 
-	bh = erofs_balloc(XATTR, shared_xattrs_size, 0, 0);
+	bh = erofs_balloc(sbi, XATTR, shared_xattrs_size, 0, 0);
 	if (IS_ERR(bh)) {
 		free(sorted_n);
 		free(buf);
@@ -914,8 +914,8 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 	}
 	bh->op = &erofs_skip_write_bhops;
 
-	erofs_mapbh(bh->block);
-	off = erofs_btell(bh, false);
+	erofs_mapbh(sbi, bh->block);
+	off = erofs_btell(sbi, bh, false);
 
 	sbi->xattr_blkaddr = off / erofs_blksiz(sbi);
 	off %= erofs_blksiz(sbi);
@@ -930,9 +930,9 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 	shared_xattrs_list = sorted_n[0];
 	free(sorted_n);
 	bh->op = &erofs_drop_directly_bhops;
-	ret = erofs_dev_write(sbi, buf, erofs_btell(bh, false), shared_xattrs_size);
+	ret = erofs_dev_write(sbi, buf, erofs_btell(sbi, bh, false), shared_xattrs_size);
 	free(buf);
-	erofs_bdrop(bh, false);
+	erofs_bdrop(sbi, bh, false);
 out:
 	erofs_cleanxattrs(true);
 	return ret;
diff --git a/mkfs/main.c b/mkfs/main.c
index bfd6d60..77b2a4b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1105,7 +1105,8 @@ static int erofs_mkfs_rebuild_load_trees(struct erofs_inode *root)
 	return 0;
 }
 
-static void erofs_mkfs_showsummaries(erofs_blk_t nblocks)
+static void erofs_mkfs_showsummaries(struct erofs_sb_info *sbi,
+				     erofs_blk_t nblocks)
 {
 	char uuid_str[37] = {};
 	char *incr = incremental_mode ? "new" : "total";
@@ -1113,16 +1114,16 @@ static void erofs_mkfs_showsummaries(erofs_blk_t nblocks)
 	if (!(cfg.c_dbg_lvl > EROFS_ERR && cfg.c_showprogress))
 		return;
 
-	erofs_uuid_unparse_lower(sbi.uuid, uuid_str);
+	erofs_uuid_unparse_lower(sbi->uuid, uuid_str);
 
 	fprintf(stdout, "------\nFilesystem UUID: %s\n"
 		"Filesystem total blocks: %u (of %u-byte blocks)\n"
 		"Filesystem total inodes: %llu\n"
 		"Filesystem %s metadata blocks: %u\n"
 		"Filesystem %s deduplicated bytes (of source files): %llu\n",
-		uuid_str, nblocks, 1U << sbi.blkszbits, sbi.inos | 0ULL,
-		incr, erofs_total_metablocks(),
-		incr, sbi.saved_by_deduplication | 0ULL);
+		uuid_str, nblocks, 1U << sbi->blkszbits, sbi->inos | 0ULL,
+		incr, erofs_total_metablocks(sbi),
+		incr, sbi->saved_by_deduplication | 0ULL);
 }
 
 int main(int argc, char **argv)
@@ -1245,7 +1246,7 @@ int main(int argc, char **argv)
 	}
 
 	if (!incremental_mode) {
-		sb_bh = erofs_reserve_sb();
+		sb_bh = erofs_reserve_sb(&sbi);
 		if (IS_ERR(sb_bh)) {
 			err = PTR_ERR(sb_bh);
 			goto exit;
@@ -1270,7 +1271,7 @@ int main(int argc, char **argv)
 			u.startblk = DIV_ROUND_UP(u.st.st_size, erofs_blksiz(&sbi));
 		else
 			u.startblk = sbi.primarydevice_blocks;
-		erofs_buffer_init(u.startblk);
+		erofs_buffer_init(&sbi, u.startblk);
 		sb_bh = NULL;
 	}
 
@@ -1392,7 +1393,7 @@ int main(int argc, char **argv)
 	}
 
 	/* flush all buffers except for the superblock */
-	err = erofs_bflush(NULL);
+	err = erofs_bflush(&sbi, NULL);
 	if (err)
 		goto exit;
 
@@ -1405,7 +1406,7 @@ int main(int argc, char **argv)
 		goto exit;
 
 	/* flush all remaining buffers */
-	err = erofs_bflush(NULL);
+	err = erofs_bflush(&sbi, NULL);
 	if (err)
 		goto exit;
 
@@ -1448,6 +1449,7 @@ exit:
 		return 1;
 	}
 	erofs_update_progressinfo("Build completed.\n");
-	erofs_mkfs_showsummaries(nblocks);
+	erofs_mkfs_showsummaries(&sbi, nblocks);
+	erofs_put_super(&sbi);
 	return 0;
 }
-- 
2.39.3

