Return-Path: <linux-erofs+bounces-2506-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO/hAWwmqWkL2gAAu9opvQ
	(envelope-from <linux-erofs+bounces-2506-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 07:45:00 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A4B20BCDC
	for <lists+linux-erofs@lfdr.de>; Thu, 05 Mar 2026 07:44:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fRKlk3FDyz3c2k;
	Thu, 05 Mar 2026 17:44:50 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.218
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772693090;
	cv=none; b=mVd/GVHSj3wF9byfWC/ss4+XBoYj4Nv3AEXcrmn+5MH1h5irTuDIq+6VZV4UNL8oDkUrTV8dV55j0IjY3JjVllx92jZOse/77yWuV2TWkHnN3RV/TYp/OWhfkCXrY12I09+pQwm2f/Q3iUV7FDrQ6AB+odA+i8ZYeE3bDuXSVSVFIlO2QEigEgI6bc/MTv0gk2WsUS8J1WPBFs93Q4bCIM9k5UbTRrYTViEN3dc4iHiyGQpBYBc6F2FGimweV+icUffQOpnK+tqLmJf7D3nTUdV2c5uCTYrsvYwjuJAcm/ZiVPEmS0HGeznvQp2j15PQYwSh0XcUH+UwvhAeE3RMdw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772693090; c=relaxed/relaxed;
	bh=CdgpyTruSz0lkCGoGw+Mexu2uEf1R1zNw2yigg5yqd4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WSO2KbILBQTTKVRsbfBbXebCURDuNH6uE5KET0MV+btYROep/Id1FMuQ7ZROlOqDp6UF79Ywa7lFdeALUcpx3tUJw4REco+4FrqyjaKfg2By0rC/p9UdiCXxBpqFSZ4ZvTq50FZqO/+/KnqiQ9fg2erqMCFm24/H1SL2+eHYopM8niD1uS2se2NcWLofMJMFhoH4Dxj8014cSzIvh4RY+bQCoFlMMVsV7w8+EdG2X4K8K48i7/KO7q22V6E24oNY1QTLPITpHSmXB5K/ybkHCFfx3zExY/wjpulN24nRfsMhGUwhflr0aeQOB5xn+VvEjTa6yzxkIzpyJyOo9esE0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=5Cos5Q8v; dkim-atps=neutral; spf=pass (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=5Cos5Q8v;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.218; helo=canpmsgout03.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fRKlg2hGHz3c1T
	for <linux-erofs@lists.ozlabs.org>; Thu, 05 Mar 2026 17:44:45 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=CdgpyTruSz0lkCGoGw+Mexu2uEf1R1zNw2yigg5yqd4=;
	b=5Cos5Q8vtkEImuDCeU7xAhVGYt4gl+FEaHFV/r3FV8zDxPKkqwXEfQMjG5XKfVi4lRj28R7l7
	SlUNIPldtQJClKYj8Lci224kPfm6KscJyYFu25qsaqFU2NfnWRFZwz47RUOB8qdqen9PAhJ7oYK
	EH49UeTK1ZKUpZYqxsoKNXk=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fRKdh6zmrzpTJ3;
	Thu,  5 Mar 2026 14:39:36 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id E2EEB40363;
	Thu,  5 Mar 2026 14:44:37 +0800 (CST)
Received: from huawei.com (10.67.174.162) by kwepemr500015.china.huawei.com
 (7.202.195.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 5 Mar
 2026 14:44:37 +0800
From: Hongbo Li <lihongbo22@huawei.com>
To: <chao@kernel.org>, <hsiangkao@linux.alibaba.com>
CC: <lihongbo22@huawei.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2] erofs: using iomap mechanisms in fileio for reading unencoded data
Date: Thu, 5 Mar 2026 06:31:40 +0000
Message-ID: <20260305063140.47375-1-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20260305013146.46349-1-lihongbo22@huawei.com>
References: <20260305013146.46349-1-lihongbo22@huawei.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.67.174.162]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Queue-Id: 57A4B20BCDC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-2506-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:chao@kernel.org,m:hsiangkao@linux.alibaba.com,m:lihongbo22@huawei.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	HAS_XOIP(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,lists.ozlabs.org:rdns,lists.ozlabs.org:helo]
X-Rspamd-Action: no action

In EROFS file-backend mount mode, the whole folio may trigger
multiple backend file I/Os. The original read process mainly uses
the @erofs_fileio_scan_folio, which employs a custom iteration
mechanism on the folio and then to handle the I/Os. It requires
complex mechanisms to manage the synchronization of multiple
split file I/Os. This way couples the iteration operation with
the data reading operation. We can decouple these two steps by
using the iomap mechanism, thereby simplifying the implementation
of the read process.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
Changes from v1:
  - add folio release/invalidate hook.
---
 fs/erofs/data.c     |  11 +--
 fs/erofs/fileio.c   | 176 ++++++++++++++++++++++----------------------
 fs/erofs/internal.h |   8 ++
 3 files changed, 101 insertions(+), 94 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index f79ee80627d9..d1931fd6eed7 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -267,12 +267,6 @@ void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
 	folio_end_read(folio, !(v & BIT(EROFS_ONLINEFOLIO_EIO)));
 }
 
-struct erofs_iomap_iter_ctx {
-	struct page *page;
-	void *base;
-	struct inode *realinode;
-};
-
 static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		unsigned int flags, struct iomap *iomap, struct iomap *srcmap)
 {
@@ -313,6 +307,9 @@ static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		else
 			iomap->bdev = mdev.m_bdev;
 		iomap->addr = mdev.m_dif->fsoff + mdev.m_pa;
+		/* keep device context when mapping to device */
+		if (ctx)
+			ctx->dif = mdev.m_dif;
 		if (flags & IOMAP_DAX)
 			iomap->addr += mdev.m_dif->dax_part_off;
 	}
@@ -357,7 +354,7 @@ static int erofs_iomap_end(struct inode *inode, loff_t pos, loff_t length,
 	return written;
 }
 
-static const struct iomap_ops erofs_iomap_ops = {
+const struct iomap_ops erofs_iomap_ops = {
 	.iomap_begin = erofs_iomap_begin,
 	.iomap_end = erofs_iomap_end,
 };
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index abe873f01297..bdf086a992a7 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -13,10 +13,9 @@ struct erofs_fileio_rq {
 	refcount_t ref;
 };
 
-struct erofs_fileio {
-	struct erofs_map_blocks map;
-	struct erofs_map_dev dev;
+struct erofs_fileio_ctx {
 	struct erofs_fileio_rq *rq;
+	struct erofs_device_info *dif;
 };
 
 static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
@@ -32,7 +31,8 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 	if (!rq->bio.bi_end_io) {
 		bio_for_each_folio_all(fi, &rq->bio) {
 			DBG_BUGON(folio_test_uptodate(fi.folio));
-			erofs_onlinefolio_end(fi.folio, ret < 0, false);
+			iomap_finish_folio_read(fi.folio, fi.offset, fi.length,
+						ret < 0 ? ret : 0);
 		}
 	} else if (ret < 0 && !rq->bio.bi_status) {
 		rq->bio.bi_status = errno_to_blk_status(ret);
@@ -88,111 +88,113 @@ void erofs_fileio_submit_bio(struct bio *bio)
 						   bio));
 }
 
-static int erofs_fileio_scan_folio(struct erofs_fileio *io,
-				   struct inode *inode, struct folio *folio)
+static int erofs_fileio_read_folio_range(const struct iomap_iter *iter,
+					 struct iomap_read_folio_ctx *ctx, size_t len)
 {
-	struct erofs_map_blocks *map = &io->map;
-	unsigned int cur = 0, end = folio_size(folio), len, attached = 0;
-	loff_t pos = folio_pos(folio), ofs;
-	int err = 0;
-
-	erofs_onlinefolio_init(folio);
-	while (cur < end) {
-		if (!in_range(pos + cur, map->m_la, map->m_llen)) {
-			map->m_la = pos + cur;
-			map->m_llen = end - cur;
-			err = erofs_map_blocks(inode, map);
-			if (err)
-				break;
-		}
+	struct erofs_iomap_iter_ctx *iter_ctx = iter->private;
+	struct erofs_device_info *dif = iter_ctx->dif;
+	struct inode *realinode = iter_ctx ? iter_ctx->realinode : iter->inode;
+	struct folio *folio = ctx->cur_folio;
+	struct erofs_fileio_ctx *fileio_ctx = ctx->read_ctx;
+	struct iomap *iomap = (struct iomap *)&iter->iomap;
+	size_t poff = offset_in_folio(folio, iter->pos);
+	loff_t pos = iter->pos;
+	int ret = 0;
+
+	if (iomap->type == IOMAP_HOLE) {
+		folio_zero_range(folio, poff, len);
+		return 0;
+	}
 
-		ofs = folio_pos(folio) + cur - map->m_la;
-		len = min_t(loff_t, map->m_llen - ofs, end - cur);
-		if (map->m_flags & EROFS_MAP_META) {
-			struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
-			void *src;
-
-			src = erofs_read_metabuf(&buf, inode->i_sb,
-				map->m_pa + ofs, erofs_inode_in_metabox(inode));
-			if (IS_ERR(src)) {
-				err = PTR_ERR(src);
-				break;
-			}
-			memcpy_to_folio(folio, cur, src, len);
-			erofs_put_metabuf(&buf);
-		} else if (!(map->m_flags & EROFS_MAP_MAPPED)) {
-			folio_zero_segment(folio, cur, cur + len);
-			attached = 0;
-		} else {
-			if (io->rq && (map->m_pa + ofs != io->dev.m_pa ||
-				       map->m_deviceid != io->dev.m_deviceid)) {
-io_retry:
-				erofs_fileio_rq_submit(io->rq);
-				io->rq = NULL;
-			}
-
-			if (!io->rq) {
-				io->dev = (struct erofs_map_dev) {
-					.m_pa = io->map.m_pa + ofs,
-					.m_deviceid = io->map.m_deviceid,
-				};
-				err = erofs_map_dev(inode->i_sb, &io->dev);
-				if (err)
-					break;
-				io->rq = erofs_fileio_rq_alloc(&io->dev);
-				io->rq->bio.bi_iter.bi_sector =
-					(io->dev.m_dif->fsoff + io->dev.m_pa) >> 9;
-				attached = 0;
-			}
-			if (!bio_add_folio(&io->rq->bio, folio, len, cur))
-				goto io_retry;
-			if (!attached++)
-				erofs_onlinefolio_split(folio);
-			io->dev.m_pa += len;
+	while (len > 0) {
+		sector_t sector = iomap_sector(iomap, pos);
+		unsigned int off = offset_in_folio(folio, pos);
+		unsigned int n = min(len, folio_size(folio) - off);
+		struct erofs_map_dev mdev = {};
+
+		if (!n)
+			break;
+		if (!fileio_ctx->rq ||
+		    fileio_ctx->dif != dif ||
+		    bio_end_sector(&fileio_ctx->rq->bio) != sector) {
+			erofs_fileio_rq_submit(fileio_ctx->rq);
+			mdev = (struct erofs_map_dev) {
+				.m_dif = dif,
+				.m_sb = realinode->i_sb,
+				.m_pa = (sector << SECTOR_SHIFT) + off,
+			};
+			fileio_ctx->dif = mdev.m_dif;
+			fileio_ctx->rq = erofs_fileio_rq_alloc(&mdev);
+			fileio_ctx->rq->bio.bi_iter.bi_sector =
+				(mdev.m_dif->fsoff + mdev.m_pa) >> SECTOR_SHIFT;
+		}
+		if (!bio_add_folio(&fileio_ctx->rq->bio, folio, n, off)) {
+			erofs_fileio_rq_submit(fileio_ctx->rq);
+			fileio_ctx->rq = NULL;
+			continue;
 		}
-		cur += len;
+		pos += n;
+		len -= n;
 	}
-	erofs_onlinefolio_end(folio, err, false);
-	return err;
+	return ret;
+}
+
+static void erofs_fileio_submit_read(struct iomap_read_folio_ctx *ctx)
+{
+	struct erofs_fileio_ctx *fileio_ctx = ctx->read_ctx;
+
+	erofs_fileio_rq_submit(fileio_ctx->rq);
+	fileio_ctx->rq = NULL;
 }
 
+static const struct iomap_read_ops erofs_fileio_read_ops = {
+	.read_folio_range = erofs_fileio_read_folio_range,
+	.submit_read = erofs_fileio_submit_read,
+};
+
 static int erofs_fileio_read_folio(struct file *file, struct folio *folio)
 {
+	struct erofs_fileio_ctx fileio_ctx = {};
+	struct iomap_read_folio_ctx read_ctx = {
+		.ops = &erofs_fileio_read_ops,
+		.cur_folio = folio,
+		.read_ctx = &fileio_ctx,
+	};
 	bool need_iput;
-	struct inode *realinode = erofs_real_inode(folio_inode(folio), &need_iput);
-	struct erofs_fileio io = {};
-	int err;
+	struct erofs_iomap_iter_ctx iter_ctx = {
+		.realinode = erofs_real_inode(folio_inode(folio), &need_iput),
+	};
 
-	trace_erofs_read_folio(realinode, folio, true);
-	err = erofs_fileio_scan_folio(&io, realinode, folio);
-	erofs_fileio_rq_submit(io.rq);
+	trace_erofs_read_folio(iter_ctx.realinode, folio, true);
+	iomap_read_folio(&erofs_iomap_ops, &read_ctx, &iter_ctx);
 	if (need_iput)
-		iput(realinode);
-	return err;
+		iput(iter_ctx.realinode);
+	return 0;
 }
 
 static void erofs_fileio_readahead(struct readahead_control *rac)
 {
+	struct erofs_fileio_ctx fileio_ctx = {};
+	struct iomap_read_folio_ctx read_ctx = {
+		.ops = &erofs_fileio_read_ops,
+		.rac = rac,
+		.read_ctx = &fileio_ctx,
+	};
 	bool need_iput;
-	struct inode *realinode = erofs_real_inode(rac->mapping->host, &need_iput);
-	struct erofs_fileio io = {};
-	struct folio *folio;
-	int err;
+	struct erofs_iomap_iter_ctx iter_ctx = {
+		.realinode = erofs_real_inode(rac->mapping->host, &need_iput),
+	};
 
-	trace_erofs_readahead(realinode, readahead_index(rac),
+	trace_erofs_readahead(iter_ctx.realinode, readahead_index(rac),
 			      readahead_count(rac), true);
-	while ((folio = readahead_folio(rac))) {
-		err = erofs_fileio_scan_folio(&io, realinode, folio);
-		if (err && err != -EINTR)
-			erofs_err(realinode->i_sb, "readahead error at folio %lu @ nid %llu",
-				  folio->index, EROFS_I(realinode)->nid);
-	}
-	erofs_fileio_rq_submit(io.rq);
+	iomap_readahead(&erofs_iomap_ops, &read_ctx, &iter_ctx);
 	if (need_iput)
-		iput(realinode);
+		iput(iter_ctx.realinode);
 }
 
 const struct address_space_operations erofs_fileio_aops = {
 	.read_folio = erofs_fileio_read_folio,
 	.readahead = erofs_fileio_readahead,
+	.release_folio = iomap_release_folio,
+	.invalidate_folio = iomap_invalidate_folio,
 };
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index a4f0a42cf8c3..cda927225b9a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -411,6 +411,13 @@ struct erofs_map_dev {
 	unsigned int m_deviceid;
 };
 
+struct erofs_iomap_iter_ctx {
+	struct page *page;
+	void *base;
+	struct inode *realinode;
+	struct erofs_device_info *dif;
+};
+
 extern const struct super_operations erofs_sops;
 
 extern const struct address_space_operations erofs_aops;
@@ -427,6 +434,7 @@ extern const struct file_operations erofs_file_fops;
 extern const struct file_operations erofs_dir_fops;
 extern const struct file_operations erofs_ishare_fops;
 
+extern const struct iomap_ops erofs_iomap_ops;
 extern const struct iomap_ops z_erofs_iomap_report_ops;
 
 /* flags for erofs_fscache_register_cookie() */
-- 
2.22.0


