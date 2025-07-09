Return-Path: <linux-erofs+bounces-568-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 28461AFDE8B
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Jul 2025 05:46:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bcP6G57ktz2ymc;
	Wed,  9 Jul 2025 13:46:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752032790;
	cv=none; b=Isb8DFpI4+dXqtc+IOPoL1AzFVVhRUjguGNd2dN7CmA4vL/ZibfYiOGWz3pO6XBBMrtfv8nZgoaE5lvLR55GKYJ1WDMJ6fATjfuUzwkOQCcdjhHewoo5v6/D+JbCSlk4yzel71bjZE33NzdlC3TaiUBK3DoSIA4u5xtoOTmKO2A20Jm/2ZAIxiLKKgdBD8SzNfFnNO+RNIcGTVtkqvlBdaBG6N8i/Bt7gY4+zT2UKWpg+5pO8r/yQMjK8yoDqlOHjpJFvz1uS4fOTCLONRWOJhEWsIuDhvRvTeWmzPr5isaEhwblyHNxqOJRIkfxbDBcDO2JbYUPD4tM2Oie7BnnKg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752032790; c=relaxed/relaxed;
	bh=RCPUNcH/l8uKBA1YktD52CFmxzEpu6D/gXFjilY9O1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C2KP2SAFO6Qc5OyrAzpyFQiJjyUgdm4J1OB9wOoKGjYfraWJwft73c17V27Rb1vO5EW8uqVrymGyPJd9iYEnd8i4q3bm2rBRHjz041Wnb9LJzZHuj8Ozsp5eEymdJgsmAG3vZPy7WTC3Lw013ljKdaEoJyU0mp2HKnf6/hzTZVTxyzsacB+BOb/xPgF1uegzmQVktvIqUPHPAqin37BgLxlRtXeGKTZdrLjPzX24y11CjRllikmFijcMbRCVtVNEFWVwZcCL7dwNHtrezO51gd9qH0wtW0JKAEyVu6a4y/+GAY5M3WwBZnEGX9HIfTvIvSwfcu4Pi6IGNVLSahjLXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aL9QW0Mm; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aL9QW0Mm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bcP6D59dLz2y8p
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Jul 2025 13:46:27 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752032783; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RCPUNcH/l8uKBA1YktD52CFmxzEpu6D/gXFjilY9O1A=;
	b=aL9QW0MmNK2Q6eQKcyZOttomJoyESxyjNoETBdB2cdiqjhYD+VGxu8eL1uyUdq4IYg5cvFvsNkgt/hjgXuYcxttue2z4WKL0djCGDqqFeeJ93Nw6IsskF2QQodP3n7/O3jidb34AImE2Kq2fWLlvIXNLtCPqTmV3EMAdcu8R5lQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiW0kJ4_1752032781 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 09 Jul 2025 11:46:22 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Stefan Kerkmann <s.kerkmann@pengutronix.de>
Subject: [PATCH 2/2] erofs: address D-cache aliasing
Date: Wed,  9 Jul 2025 11:46:14 +0800
Message-ID: <20250709034614.2780117-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250709034614.2780117-1-hsiangkao@linux.alibaba.com>
References: <20250709034614.2780117-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Flush the D-cache before unlocking folios for compressed inodes, as
they are dirtied during decompression.

Avoid calling flush_dcache_folio() on every CPU write, since it's more
like playing whack-a-mole without real benefit.

It has no impact on x86 and arm64/risc-v: on x86, flush_dcache_folio()
is a no-op, and on arm64/risc-v, PG_dcache_clean (PG_arch_1) is clear
for new page cache folios.  However, certain ARM boards are affected,
as reported.

Fixes: 3883a79abd02 ("staging: erofs: introduce VLE decompression support")
Closes: https://lore.kernel.org/r/c1e51e16-6cc6-49d0-a63e-4e9ff6c4dd53@pengutronix.de
Closes: https://lore.kernel.org/r/38d43fae-1182-4155-9c5b-ffc7382d9917@siemens.com
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Stefan Kerkmann <s.kerkmann@pengutronix.de>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Hi Jan and Stefan,

if possible, please help test this patch on your arm devices,
many thanks!  I will submit this later but if it's urgent you
could also apply this locally in advance.

Thanks,
Gao Xiang
 fs/erofs/data.c         | 16 +++++++++++-----
 fs/erofs/decompressor.c | 12 ++++--------
 fs/erofs/fileio.c       |  4 ++--
 fs/erofs/internal.h     |  2 +-
 fs/erofs/zdata.c        |  6 +++---
 5 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 221e0ff1ed0d..16e4a6bd9b97 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -214,9 +214,11 @@ int erofs_map_dev(struct super_block *sb, struct erofs_map_dev *map)
 
 /*
  * bit 30: I/O error occurred on this folio
+ * bit 29: CPU has dirty data in D-cache (needs aliasing handling);
  * bit 0 - 29: remaining parts to complete this folio
  */
-#define EROFS_ONLINEFOLIO_EIO			(1 << 30)
+#define EROFS_ONLINEFOLIO_EIO		30
+#define EROFS_ONLINEFOLIO_DIRTY		29
 
 void erofs_onlinefolio_init(struct folio *folio)
 {
@@ -233,19 +235,23 @@ void erofs_onlinefolio_split(struct folio *folio)
 	atomic_inc((atomic_t *)&folio->private);
 }
 
-void erofs_onlinefolio_end(struct folio *folio, int err)
+void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty)
 {
 	int orig, v;
 
 	do {
 		orig = atomic_read((atomic_t *)&folio->private);
-		v = (orig - 1) | (err ? EROFS_ONLINEFOLIO_EIO : 0);
+		DBG_BUGON(orig <= 0);
+		v = dirty << EROFS_ONLINEFOLIO_DIRTY;
+		v |= (orig - 1) | (!!err << EROFS_ONLINEFOLIO_EIO);
 	} while (atomic_cmpxchg((atomic_t *)&folio->private, orig, v) != orig);
 
-	if (v & ~EROFS_ONLINEFOLIO_EIO)
+	if (v & (BIT(EROFS_ONLINEFOLIO_DIRTY) - 1))
 		return;
 	folio->private = 0;
-	folio_end_read(folio, !(v & EROFS_ONLINEFOLIO_EIO));
+	if (v & BIT(EROFS_ONLINEFOLIO_DIRTY))
+		flush_dcache_folio(folio);
+	folio_end_read(folio, !(v & BIT(EROFS_ONLINEFOLIO_EIO)));
 }
 
 static int erofs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index bf62e2836b60..358061d7b660 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -301,13 +301,11 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 		cur = min(cur, rq->outputsize);
 		if (cur && rq->out[0]) {
 			kin = kmap_local_page(rq->in[nrpages_in - 1]);
-			if (rq->out[0] == rq->in[nrpages_in - 1]) {
+			if (rq->out[0] == rq->in[nrpages_in - 1])
 				memmove(kin + rq->pageofs_out, kin + pi, cur);
-				flush_dcache_page(rq->out[0]);
-			} else {
+			else
 				memcpy_to_page(rq->out[0], rq->pageofs_out,
 					       kin + pi, cur);
-			}
 			kunmap_local(kin);
 		}
 		rq->outputsize -= cur;
@@ -325,14 +323,12 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 			po = (rq->pageofs_out + cur + pi) & ~PAGE_MASK;
 			DBG_BUGON(no >= nrpages_out);
 			cnt = min(insz - pi, PAGE_SIZE - po);
-			if (rq->out[no] == rq->in[ni]) {
+			if (rq->out[no] == rq->in[ni])
 				memmove(kin + po,
 					kin + rq->pageofs_in + pi, cnt);
-				flush_dcache_page(rq->out[no]);
-			} else if (rq->out[no]) {
+			else if (rq->out[no])
 				memcpy_to_page(rq->out[no], po,
 					       kin + rq->pageofs_in + pi, cnt);
-			}
 			pi += cnt;
 		} while (pi < insz);
 		kunmap_local(kin);
diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index fe2cd2982b4b..91781718199e 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -38,7 +38,7 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 	} else {
 		bio_for_each_folio_all(fi, &rq->bio) {
 			DBG_BUGON(folio_test_uptodate(fi.folio));
-			erofs_onlinefolio_end(fi.folio, ret);
+			erofs_onlinefolio_end(fi.folio, ret, false);
 		}
 	}
 	bio_uninit(&rq->bio);
@@ -154,7 +154,7 @@ static int erofs_fileio_scan_folio(struct erofs_fileio *io, struct folio *folio)
 		}
 		cur += len;
 	}
-	erofs_onlinefolio_end(folio, err);
+	erofs_onlinefolio_end(folio, err, false);
 	return err;
 }
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index a32c03a80c70..0d19bde8c094 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -390,7 +390,7 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 int erofs_map_blocks(struct inode *inode, struct erofs_map_blocks *map);
 void erofs_onlinefolio_init(struct folio *folio);
 void erofs_onlinefolio_split(struct folio *folio);
-void erofs_onlinefolio_end(struct folio *folio, int err);
+void erofs_onlinefolio_end(struct folio *folio, int err, bool dirty);
 struct inode *erofs_iget(struct super_block *sb, erofs_nid_t nid);
 int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 		  struct kstat *stat, u32 request_mask,
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index d80e3bf4fa79..6f8402ed5b28 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1090,7 +1090,7 @@ static int z_erofs_scan_folio(struct z_erofs_frontend *f,
 			tight = (bs == PAGE_SIZE);
 		}
 	} while ((end = cur) > 0);
-	erofs_onlinefolio_end(folio, err);
+	erofs_onlinefolio_end(folio, err, false);
 	return err;
 }
 
@@ -1195,7 +1195,7 @@ static void z_erofs_fill_other_copies(struct z_erofs_backend *be, int err)
 			cur += len;
 		}
 		kunmap_local(dst);
-		erofs_onlinefolio_end(page_folio(bvi->bvec.page), err);
+		erofs_onlinefolio_end(page_folio(bvi->bvec.page), err, true);
 		list_del(p);
 		kfree(bvi);
 	}
@@ -1353,7 +1353,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_backend *be, int err)
 
 		DBG_BUGON(z_erofs_page_is_invalidated(page));
 		if (!z_erofs_is_shortlived_page(page)) {
-			erofs_onlinefolio_end(page_folio(page), err);
+			erofs_onlinefolio_end(page_folio(page), err, true);
 			continue;
 		}
 		if (pcl->algorithmformat != Z_EROFS_COMPRESSION_LZ4) {
-- 
2.43.5


