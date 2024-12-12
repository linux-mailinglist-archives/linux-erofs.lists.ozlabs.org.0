Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 326F29F008F
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 00:54:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Y8TpS3H7hz30hf
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Dec 2024 10:54:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1734047663;
	cv=none; b=oFt4SlnqCDONuYzCNSiQPiLGwX3WnVACJGmARKnOPnVcLXDxGII+F6KNLQNnOAQ39KwYhn8YbmprgfJF91Cz6ufNR3s9B57wv5S0JKYcXT8dJ6+/EKwc2+6ZqhwBpGYA+gzwjUpnvP7Lhc+5aCK8XeNAjyaFqL/3HLRMQqJrza2R0T27emkIdWkUXGZn5RYoqG1HWY0+UJh6oMFfwd6M2ispqwr6iithxikW1ysWD68wv9MxadJBGdT+BIqSGo3JLDnZ9x7WDQeWnc0JZthE2LCRWmvnTsFaGGIhuUjmUiqnIfkzRdd1qGKGkrK0TvLQz+2oOi8gdHbnvFTvgPCqCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1734047663; c=relaxed/relaxed;
	bh=FeYdsUpn0dY/Q8/xoFmnr0FsNiLZelBubzVe7z+i9+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jPLb37w1qVlprLmHH+DSkZZYcLG6awStbkoEvWMcMe9VKd3JSUbC/HaN8G6/7phyTT5oX/xPovePxf/okqWpoAMX2iMzlJsmOYuYixmXjN+M7cOHp4Hb/SYiViFGY87nUobJi2nLeDGTIP829txoquFT07VQ0l8gFW8EQPDwkAB+Nh7Wki/QHdtNG0Sa8pNlliKxLK4nvgeJr9AkU+89O7WUKwNcI5Kn6Z37six0ccrnL3H1pR6sc6dbIo3Cq2P8XVHGMN6Uo5jqkGpn+SUPNMdYqTn5BpAr80TgMWT5GCtsPLOwvN3cPo71vVnyhdJwNeosLryXEFYFdsOY4Y9Ypg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=x5tme4Kn; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=x5tme4Kn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Y8TpN5TLvz2yF0
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Dec 2024 10:54:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1734047653; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=FeYdsUpn0dY/Q8/xoFmnr0FsNiLZelBubzVe7z+i9+8=;
	b=x5tme4KnE8kdiw0WeukjwCLYRmctyUZ+8DetmdB7Sz9aQttuSvMSb4f6JrOq88RcPRyeUsUYxLB7lUXZFK9JNf453w6SfoPml3T191fSYaTSk45lIPWlVU0PFsDtoUDDy6xzk4B06ZIG0+6eutH5hg6KOx94erV1sJUaLlOUMKI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WLMwTxB_1734047643 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 13 Dec 2024 07:54:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 3/4] erofs: reference `struct erofs_device_info` for erofs_map_dev
Date: Fri, 13 Dec 2024 07:54:01 +0800
Message-ID: <20241212235401.2857246-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241212133504.2047178-3-hsiangkao@linux.alibaba.com>
References: <20241212133504.2047178-3-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

Record `m_sb` and `m_dif` to replace `m_fscache`, `m_daxdev`, `m_fp`
and `m_dax_part_off` in order to simplify the codebase.

Note that `m_bdev` is still left since it can be assigned from
`sb->s_bdev` directly.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v1: https://lore.kernel.org/r/20241212133504.2047178-3-hsiangkao@linux.alibaba.com
changes since v1:
 - fix fscache build.

 fs/erofs/data.c     | 26 ++++++++++----------------
 fs/erofs/fileio.c   |  2 +-
 fs/erofs/fscache.c  |  4 ++--
 fs/erofs/internal.h |  6 ++----
 4 files changed, 15 insertions(+), 23 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 0b0385fa3025..63840971976c 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -179,19 +179,13 @@ int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map)
 }
 
 static void erofs_fill_from_devinfo(struct erofs_map_dev *map,
-				    struct erofs_device_info *dif)
+		struct super_block *sb, struct erofs_device_info *dif)
 {
+	map->m_sb = sb;
+	map->m_dif = dif;
 	map->m_bdev = NULL;
-	map->m_fp = NULL;
-	if (dif->file) {
-		if (S_ISBLK(file_inode(dif->file)->i_mode))
-			map->m_bdev = file_bdev(dif->file);
-		else
-			map->m_fp = dif->file;
-	}
-	map->m_daxdev = dif->dax_dev;
-	map->m_dax_part_off = dif->dax_part_off;
-	map->m_fscache = dif->fscache;
+	if (dif->file && S_ISBLK(file_inode(dif->file)->i_mode))
+		map->m_bdev = file_bdev(dif->file);
 }
 
 int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
@@ -201,7 +195,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 	erofs_off_t startoff, length;
 	int id;
 
-	erofs_fill_from_devinfo(map, &EROFS_SB(sb)->dif0);
+	erofs_fill_from_devinfo(map, sb, &EROFS_SB(sb)->dif0);
 	map->m_bdev = sb->s_bdev;	/* use s_bdev for the primary device */
 	if (map->m_deviceid) {
 		down_read(&devs->rwsem);
@@ -215,7 +209,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			up_read(&devs->rwsem);
 			return 0;
 		}
-		erofs_fill_from_devinfo(map, dif);
+		erofs_fill_from_devinfo(map, sb, dif);
 		up_read(&devs->rwsem);
 	} else if (devs->extra_devices && !devs->flatdev) {
 		down_read(&devs->rwsem);
@@ -228,7 +222,7 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 			if (map->m_pa >= startoff &&
 			    map->m_pa < startoff + length) {
 				map->m_pa -= startoff;
-				erofs_fill_from_devinfo(map, dif);
+				erofs_fill_from_devinfo(map, sb, dif);
 				break;
 			}
 		}
@@ -298,7 +292,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 
 	iomap->offset = map.m_la;
 	if (flags & IOMAP_DAX)
-		iomap->dax_dev = mdev.m_daxdev;
+		iomap->dax_dev = mdev.m_dif->dax_dev;
 	else
 		iomap->bdev = mdev.m_bdev;
 	iomap->length = map.m_llen;
@@ -327,7 +321,7 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->type = IOMAP_MAPPED;
 		iomap->addr = mdev.m_pa;
 		if (flags & IOMAP_DAX)
-			iomap->addr += mdev.m_dax_part_off;
+			iomap->addr += mdev.m_dif->dax_part_off;
 	}
 	return 0;
 }
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index 3af96b1e2c2a..a61b8faec651 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -67,7 +67,7 @@ static struct erofs_fileio_rq *erofs_fileio_rq_alloc(struct erofs_map_dev *mdev)
 					     GFP_KERNEL | __GFP_NOFAIL);
 
 	bio_init(&rq->bio, NULL, rq->bvecs, BIO_MAX_VECS, REQ_OP_READ);
-	rq->iocb.ki_filp = mdev->m_fp;
+	rq->iocb.ki_filp = mdev->m_dif->file;
 	return rq;
 }
 
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index fda16eedafb5..1268baa2ecc4 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -198,7 +198,7 @@ struct bio *erofs_fscache_bio_alloc(struct erofs_map_dev *mdev)
 
 	io = kmalloc(sizeof(*io), GFP_KERNEL | __GFP_NOFAIL);
 	bio_init(&io->bio, NULL, io->bvecs, BIO_MAX_VECS, REQ_OP_READ);
-	io->io.private = mdev->m_fscache->cookie;
+	io->io.private = mdev->m_dif->fscache->cookie;
 	io->io.end_io = erofs_fscache_bio_endio;
 	refcount_set(&io->io.ref, 1);
 	return &io->bio;
@@ -316,7 +316,7 @@ static int erofs_fscache_data_read_slice(struct erofs_fscache_rq *req)
 	if (!io)
 		return -ENOMEM;
 	iov_iter_xarray(&io->iter, ITER_DEST, &mapping->i_pages, pos, count);
-	ret = erofs_fscache_read_io_async(mdev.m_fscache->cookie,
+	ret = erofs_fscache_read_io_async(mdev.m_dif->fscache->cookie,
 			mdev.m_pa + (pos - map.m_la), io);
 	erofs_fscache_req_io_put(io);
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 6e91fcdeba94..59e7739b7c3b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -354,11 +354,9 @@ enum {
 };
 
 struct erofs_map_dev {
-	struct erofs_fscache *m_fscache;
+	struct super_block *m_sb;
+	struct erofs_device_info *m_dif;
 	struct block_device *m_bdev;
-	struct dax_device *m_daxdev;
-	struct file *m_fp;
-	u64 m_dax_part_off;
 
 	erofs_off_t m_pa;
 	unsigned int m_deviceid;
-- 
2.43.5

