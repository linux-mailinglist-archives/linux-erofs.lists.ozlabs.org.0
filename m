Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 61883430F24
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Oct 2021 06:41:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HXkjK5fGgz2yyv
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Oct 2021 15:41:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tTaexhN2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+653fb0268b18c2e086a8+6630+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=bombadil.20210309 header.b=tTaexhN2; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HXkj90VFGz2yQG
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Oct 2021 15:41:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=YezH57xXoPeRC6RlTJfNo/dArufy5KO88T9CE1nCunE=; b=tTaexhN24/qiyoJmnJ6E5C5ZZx
 U+OLbvsZP0BBytudBPt/UbZNCF21SQ/Sjm+cLP1Vnf5Pn6eu+h3U0V71xIlhrH6cTTBBWuSP6EB//
 7U9GGNii65ygkwdaDXhooidtR3QmmZ92Fy/ofBrTbwDaEjAUfx0a97ycZSrFcRO8ybMm0mm9taLLH
 Iu4waFlnUovAAXiSPv0E6Dxuu/yqOgVtvIE7+7VRqT4urJt3sMevOfsYxtGTJHS1Xjhhbe6DOLMs4
 g5oHWXIw/NW1WD/8ex73wNhE0NstGgspJiYk/4IJ6/bjpV8/rxTvoEjra7J/J4vbsFxRbhO0btBKd
 nhBWEegg==;
Received: from 089144211028.atnat0020.highway.a1.net ([89.144.211.28]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcKSK-00E3Fe-Lj; Mon, 18 Oct 2021 04:41:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: 
Subject: [PATCH 01/11] dm: make the DAX support dependend on CONFIG_FS_DAX
Date: Mon, 18 Oct 2021 06:40:44 +0200
Message-Id: <20211018044054.1779424-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018044054.1779424-1-hch@lst.de>
References: <20211018044054.1779424-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: nvdimm@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-s390@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 virtualization@lists.linux-foundation.org, linux-xfs@vger.kernel.org,
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org,
 Dan Williams <dan.j.williams@intel.com>, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The device mapper DAX support is all hanging off a block device and thus
can't be used with device dax.  Make it depend on CONFIG_FS_DAX instead
of CONFIG_DAX_DRIVER.  This also means that bdev_dax_pgoff only needs to
be built under CONFIG_FS_DAX now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/dax/super.c        | 6 ++----
 drivers/md/dm-linear.c     | 2 +-
 drivers/md/dm-log-writes.c | 2 +-
 drivers/md/dm-stripe.c     | 2 +-
 drivers/md/dm-writecache.c | 2 +-
 drivers/md/dm.c            | 2 +-
 6 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index b882cf8106ea3..e20d0cef10a18 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -63,7 +63,7 @@ static int dax_host_hash(const char *host)
 	return hashlen_hash(hashlen_string("DAX", host)) % DAX_HASH_SIZE;
 }
 
-#ifdef CONFIG_BLOCK
+#if defined(CONFIG_BLOCK) && defined(CONFIG_FS_DAX)
 #include <linux/blkdev.h>
 
 int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
@@ -80,7 +80,6 @@ int bdev_dax_pgoff(struct block_device *bdev, sector_t sector, size_t size,
 }
 EXPORT_SYMBOL(bdev_dax_pgoff);
 
-#if IS_ENABLED(CONFIG_FS_DAX)
 /**
  * dax_get_by_host() - temporary lookup mechanism for filesystem-dax
  * @host: alternate name for the device registered by a dax driver
@@ -219,8 +218,7 @@ bool dax_supported(struct dax_device *dax_dev, struct block_device *bdev,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dax_supported);
-#endif /* CONFIG_FS_DAX */
-#endif /* CONFIG_BLOCK */
+#endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
 
 enum dax_device_flags {
 	/* !alive + rcu grace period == no new operations / mappings */
diff --git a/drivers/md/dm-linear.c b/drivers/md/dm-linear.c
index 679b4c0a2eea1..32fbab11bf90c 100644
--- a/drivers/md/dm-linear.c
+++ b/drivers/md/dm-linear.c
@@ -163,7 +163,7 @@ static int linear_iterate_devices(struct dm_target *ti,
 	return fn(ti, lc->dev, lc->start, ti->len, data);
 }
 
-#if IS_ENABLED(CONFIG_DAX_DRIVER)
+#if IS_ENABLED(CONFIG_FS_DAX)
 static long linear_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, void **kaddr, pfn_t *pfn)
 {
diff --git a/drivers/md/dm-log-writes.c b/drivers/md/dm-log-writes.c
index d93a4db235124..6d694526881d0 100644
--- a/drivers/md/dm-log-writes.c
+++ b/drivers/md/dm-log-writes.c
@@ -903,7 +903,7 @@ static void log_writes_io_hints(struct dm_target *ti, struct queue_limits *limit
 	limits->io_min = limits->physical_block_size;
 }
 
-#if IS_ENABLED(CONFIG_DAX_DRIVER)
+#if IS_ENABLED(CONFIG_FS_DAX)
 static int log_dax(struct log_writes_c *lc, sector_t sector, size_t bytes,
 		   struct iov_iter *i)
 {
diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index 6660b6b53d5bf..f084607220293 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -300,7 +300,7 @@ static int stripe_map(struct dm_target *ti, struct bio *bio)
 	return DM_MAPIO_REMAPPED;
 }
 
-#if IS_ENABLED(CONFIG_DAX_DRIVER)
+#if IS_ENABLED(CONFIG_FS_DAX)
 static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
 		long nr_pages, void **kaddr, pfn_t *pfn)
 {
diff --git a/drivers/md/dm-writecache.c b/drivers/md/dm-writecache.c
index 18320444fb0a9..4c3a6e33604d3 100644
--- a/drivers/md/dm-writecache.c
+++ b/drivers/md/dm-writecache.c
@@ -38,7 +38,7 @@
 #define BITMAP_GRANULARITY	PAGE_SIZE
 #endif
 
-#if IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API) && IS_ENABLED(CONFIG_DAX_DRIVER)
+#if IS_ENABLED(CONFIG_ARCH_HAS_PMEM_API) && IS_ENABLED(CONFIG_FS_DAX)
 #define DM_WRITECACHE_HAS_PMEM
 #endif
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 7870e6460633f..79737aee516b1 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1783,7 +1783,7 @@ static struct mapped_device *alloc_dev(int minor)
 	md->disk->private_data = md;
 	sprintf(md->disk->disk_name, "dm-%d", minor);
 
-	if (IS_ENABLED(CONFIG_DAX_DRIVER)) {
+	if (IS_ENABLED(CONFIG_FS_DAX)) {
 		md->dax_dev = alloc_dax(md, md->disk->disk_name,
 					&dm_dax_ops, 0);
 		if (IS_ERR(md->dax_dev))
-- 
2.30.2

