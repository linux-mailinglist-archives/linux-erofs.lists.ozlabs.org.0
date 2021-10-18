Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF915430F47
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Oct 2021 06:41:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HXkjl32VDz2ypL
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Oct 2021 15:41:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=1d8cXQVX;
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
 header.s=bombadil.20210309 header.b=1d8cXQVX; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HXkjZ6Rg4z2ywb
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Oct 2021 15:41:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=NWRSaBjXDrc58K1oj+PE/wR9vn+9X0aQXm/bAOg12tE=; b=1d8cXQVXjk+JGdcI/anFzyAIB+
 jgB3oMIkS682cycJDTMPg4gPEB3/UnsmiLecgvLUw9Ajih6dFsVYlAJNXr39QLXQx55yPJvt4ci4i
 ECGp50OerwpW6muAkWZxKjOhppD4FBGWZIWzq3zTd/NIdoHfdANyRQLEYs5l4j6w/hIO46IfrsWCG
 De9Rt5dzKHh3HIWGA0Wyvl8zgk05HIKasE9OdehfasxF2JNJKXglz5/7bxaXkQpJhu2ZEo5xioeZ5
 5X8XdkB9I86u11AycCppr1InCFSpK4nFDVxZgzu69RSpqtGxvlhcjrX9ZumEhVNy6f9UAHj3vTQsJ
 xXuTwgrA==;
Received: from 089144211028.atnat0020.highway.a1.net ([89.144.211.28]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcKSn-00E3Tr-Rc; Mon, 18 Oct 2021 04:41:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: 
Subject: [PATCH 10/11] dm-stripe: add a stripe_dax_pgoff helper
Date: Mon, 18 Oct 2021 06:40:53 +0200
Message-Id: <20211018044054.1779424-11-hch@lst.de>
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

Add a helper to perform the entire remapping for DAX accesses.  This
helper open codes bdev_dax_pgoff given that the alignment checks have
already been done by the submitting file system and don't need to be
repeated.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/dm-stripe.c | 63 ++++++++++--------------------------------
 1 file changed, 15 insertions(+), 48 deletions(-)

diff --git a/drivers/md/dm-stripe.c b/drivers/md/dm-stripe.c
index f084607220293..50dba3f39274c 100644
--- a/drivers/md/dm-stripe.c
+++ b/drivers/md/dm-stripe.c
@@ -301,83 +301,50 @@ static int stripe_map(struct dm_target *ti, struct bio *bio)
 }
 
 #if IS_ENABLED(CONFIG_FS_DAX)
-static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
-		long nr_pages, void **kaddr, pfn_t *pfn)
+static struct dax_device *stripe_dax_pgoff(struct dm_target *ti, pgoff_t *pgoff)
 {
-	sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
 	struct stripe_c *sc = ti->private;
-	struct dax_device *dax_dev;
 	struct block_device *bdev;
+	sector_t dev_sector;
 	uint32_t stripe;
-	long ret;
 
-	stripe_map_sector(sc, sector, &stripe, &dev_sector);
+	stripe_map_sector(sc, *pgoff * PAGE_SECTORS, &stripe, &dev_sector);
 	dev_sector += sc->stripe[stripe].physical_start;
-	dax_dev = sc->stripe[stripe].dev->dax_dev;
 	bdev = sc->stripe[stripe].dev->bdev;
 
-	ret = bdev_dax_pgoff(bdev, dev_sector, nr_pages * PAGE_SIZE, &pgoff);
-	if (ret)
-		return ret;
+	*pgoff = (get_start_sect(bdev) + dev_sector) >> PAGE_SECTORS_SHIFT;
+	return sc->stripe[stripe].dev->dax_dev;
+}
+
+static long stripe_dax_direct_access(struct dm_target *ti, pgoff_t pgoff,
+		long nr_pages, void **kaddr, pfn_t *pfn)
+{
+	struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
+
 	return dax_direct_access(dax_dev, pgoff, nr_pages, kaddr, pfn);
 }
 
 static size_t stripe_dax_copy_from_iter(struct dm_target *ti, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *i)
 {
-	sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
-	struct stripe_c *sc = ti->private;
-	struct dax_device *dax_dev;
-	struct block_device *bdev;
-	uint32_t stripe;
-
-	stripe_map_sector(sc, sector, &stripe, &dev_sector);
-	dev_sector += sc->stripe[stripe].physical_start;
-	dax_dev = sc->stripe[stripe].dev->dax_dev;
-	bdev = sc->stripe[stripe].dev->bdev;
+	struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
 
-	if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
-		return 0;
 	return dax_copy_from_iter(dax_dev, pgoff, addr, bytes, i);
 }
 
 static size_t stripe_dax_copy_to_iter(struct dm_target *ti, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *i)
 {
-	sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
-	struct stripe_c *sc = ti->private;
-	struct dax_device *dax_dev;
-	struct block_device *bdev;
-	uint32_t stripe;
-
-	stripe_map_sector(sc, sector, &stripe, &dev_sector);
-	dev_sector += sc->stripe[stripe].physical_start;
-	dax_dev = sc->stripe[stripe].dev->dax_dev;
-	bdev = sc->stripe[stripe].dev->bdev;
+	struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
 
-	if (bdev_dax_pgoff(bdev, dev_sector, ALIGN(bytes, PAGE_SIZE), &pgoff))
-		return 0;
 	return dax_copy_to_iter(dax_dev, pgoff, addr, bytes, i);
 }
 
 static int stripe_dax_zero_page_range(struct dm_target *ti, pgoff_t pgoff,
 				      size_t nr_pages)
 {
-	int ret;
-	sector_t dev_sector, sector = pgoff * PAGE_SECTORS;
-	struct stripe_c *sc = ti->private;
-	struct dax_device *dax_dev;
-	struct block_device *bdev;
-	uint32_t stripe;
+	struct dax_device *dax_dev = stripe_dax_pgoff(ti, &pgoff);
 
-	stripe_map_sector(sc, sector, &stripe, &dev_sector);
-	dev_sector += sc->stripe[stripe].physical_start;
-	dax_dev = sc->stripe[stripe].dev->dax_dev;
-	bdev = sc->stripe[stripe].dev->bdev;
-
-	ret = bdev_dax_pgoff(bdev, dev_sector, nr_pages << PAGE_SHIFT, &pgoff);
-	if (ret)
-		return ret;
 	return dax_zero_page_range(dax_dev, pgoff, nr_pages);
 }
 
-- 
2.30.2

