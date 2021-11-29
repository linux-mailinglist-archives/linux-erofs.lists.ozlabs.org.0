Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D407A46123D
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Nov 2021 11:23:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J2hJj57JNz3cTX
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Nov 2021 21:23:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=UPg4+6wF;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+13c9c90cf431a9f4f7f6+6672+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=UPg4+6wF; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J2hHY6Ctvz2ybL
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Nov 2021 21:22:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=yI4WYLi1IHh9BmFM+7DHlvjAkunDCriWi1z/fNDCM88=; b=UPg4+6wFh4W1KliYaQr6EByJSo
 lqHbf7UcpT2lg6RHD0j+Q0QVjS6G7hStj2qPUMHjFXNHDYcNOYZ5nvwpAxCUmrXcLqkSGhuVhLV+O
 RhNt1iXkpbq5mUGexqC5SzzLZ7dEl7nxX628VKQrz7loeUQW7q9obNXxwPcC3Iqqn9S+DnWSItZi8
 lvGHyQCIdDKVkUHu0BS4lKJv7TxAUBY5c4qvE5bE47RQgwkyZFXeHdMz8xjRXgFWEeQB04AoXPdhO
 XBuC87h5D/rXubDZne2zzQy3U+VqoIIyPxLWLdUhWnjfAU7lYXmJNS70wvzfkvk4AalAifhzJKb0E
 9gv4y55Q==;
Received: from [2001:4bb8:184:4a23:724a:c057:c7bf:4643] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrdnh-0073OX-KF; Mon, 29 Nov 2021 10:22:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 13/29] fsdax: use a saner calling convention for
 copy_cow_page_dax
Date: Mon, 29 Nov 2021 11:21:47 +0100
Message-Id: <20211129102203.2243509-14-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211129102203.2243509-1-hch@lst.de>
References: <20211129102203.2243509-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
 dm-devel@redhat.com, "Darrick J . Wong" <djwong@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Just pass the vm_fault and iomap_iter structures, and figure out the rest
locally.  Note that this requires moving dax_iomap_sector up in the file.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/dax.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 73bd1439d8089..e51b4129d1b65 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -709,26 +709,31 @@ int dax_invalidate_mapping_entry_sync(struct address_space *mapping,
 	return __dax_invalidate_entry(mapping, index, false);
 }
 
-static int copy_cow_page_dax(struct block_device *bdev, struct dax_device *dax_dev,
-			     sector_t sector, struct page *to, unsigned long vaddr)
+static sector_t dax_iomap_sector(const struct iomap *iomap, loff_t pos)
 {
+	return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
+}
+
+static int copy_cow_page_dax(struct vm_fault *vmf, const struct iomap_iter *iter)
+{
+	sector_t sector = dax_iomap_sector(&iter->iomap, iter->pos);
 	void *vto, *kaddr;
 	pgoff_t pgoff;
 	long rc;
 	int id;
 
-	rc = bdev_dax_pgoff(bdev, sector, PAGE_SIZE, &pgoff);
+	rc = bdev_dax_pgoff(iter->iomap.bdev, sector, PAGE_SIZE, &pgoff);
 	if (rc)
 		return rc;
 
 	id = dax_read_lock();
-	rc = dax_direct_access(dax_dev, pgoff, 1, &kaddr, NULL);
+	rc = dax_direct_access(iter->iomap.dax_dev, pgoff, 1, &kaddr, NULL);
 	if (rc < 0) {
 		dax_read_unlock(id);
 		return rc;
 	}
-	vto = kmap_atomic(to);
-	copy_user_page(vto, kaddr, vaddr, to);
+	vto = kmap_atomic(vmf->cow_page);
+	copy_user_page(vto, kaddr, vmf->address, vmf->cow_page);
 	kunmap_atomic(vto);
 	dax_read_unlock(id);
 	return 0;
@@ -1005,11 +1010,6 @@ int dax_writeback_mapping_range(struct address_space *mapping,
 }
 EXPORT_SYMBOL_GPL(dax_writeback_mapping_range);
 
-static sector_t dax_iomap_sector(const struct iomap *iomap, loff_t pos)
-{
-	return (iomap->addr + (pos & PAGE_MASK) - iomap->offset) >> 9;
-}
-
 static int dax_iomap_pfn(const struct iomap *iomap, loff_t pos, size_t size,
 			 pfn_t *pfnp)
 {
@@ -1332,19 +1332,16 @@ static vm_fault_t dax_fault_synchronous_pfnp(pfn_t *pfnp, pfn_t pfn)
 static vm_fault_t dax_fault_cow_page(struct vm_fault *vmf,
 		const struct iomap_iter *iter)
 {
-	sector_t sector = dax_iomap_sector(&iter->iomap, iter->pos);
-	unsigned long vaddr = vmf->address;
 	vm_fault_t ret;
 	int error = 0;
 
 	switch (iter->iomap.type) {
 	case IOMAP_HOLE:
 	case IOMAP_UNWRITTEN:
-		clear_user_highpage(vmf->cow_page, vaddr);
+		clear_user_highpage(vmf->cow_page, vmf->address);
 		break;
 	case IOMAP_MAPPED:
-		error = copy_cow_page_dax(iter->iomap.bdev, iter->iomap.dax_dev,
-					  sector, vmf->cow_page, vaddr);
+		error = copy_cow_page_dax(vmf, iter);
 		break;
 	default:
 		WARN_ON_ONCE(1);
-- 
2.30.2

