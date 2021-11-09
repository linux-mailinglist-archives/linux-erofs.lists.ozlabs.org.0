Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19D244A917
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 09:34:50 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpLrS5CVMz304y
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 19:34:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Ce+9Re7F;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record)
 smtp.mailfrom=casper.srs.infradead.org (client-ip=2001:8b0:10b:1236::1;
 helo=casper.infradead.org;
 envelope-from=batv+ffbfd99345897bc8db8d+6652+infradead.org+hch@casper.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=casper.20170209 header.b=Ce+9Re7F; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpLqn0l3mz3015
 for <linux-erofs@lists.ozlabs.org>; Tue,  9 Nov 2021 19:34:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=dGumlXA8bKenaWXczMrz5P/DlTIFWU6uPrJEsJbZBpA=; b=Ce+9Re7FrclwSe+nEL2ezM+LO2
 4kPTB/AeeMDNXfabLJp4oiZ67cCSpUhrKxzjZP+ob/SX+cVOYo207D22qv0/Am61QvuKpaDUXqRnV
 WaXroLBuaJ/pnSTL/TL8HrZN1ri2P3m2NiPIuMF24pMEbz2G5CwkwnCrgfkSSH9+F3c57VJlSR0dT
 4afAjUP+gtO4JQ1MB3yZQ/qsrmDMmsCNkdotlQXn8YRxVP/2EywmUtgt+KpNH32EWB24MtMdYBqop
 2Tqx8YAhAiibk6OpbICNHDnOfkjcf7BeCI8ti7Jboagd2CJ7s/3AX+Hd6d+l4S++Asy+fJOUBTGwc
 DlMRam9g==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkMZr-000sDM-MC; Tue, 09 Nov 2021 08:34:00 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 27/29] dax: fix up some of the block device related ifdefs
Date: Tue,  9 Nov 2021 09:33:07 +0100
Message-Id: <20211109083309.584081-28-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211109083309.584081-1-hch@lst.de>
References: <20211109083309.584081-1-hch@lst.de>
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
 dm-devel@redhat.com, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Ira Weiny <ira.weiny@intel.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The DAX device <-> block device association is only enabled if
CONFIG_BLOCK is enabled.  Update dax.h to account for that and use
the right conditions for the fs_put_dax stub as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/dax.h | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/include/linux/dax.h b/include/linux/dax.h
index 90f95deff504d..5568d3dca941b 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -108,28 +108,15 @@ static inline bool daxdev_mapping_supported(struct vm_area_struct *vma,
 #endif
 
 struct writeback_control;
-#if IS_ENABLED(CONFIG_FS_DAX)
+#if defined(CONFIG_BLOCK) && defined(CONFIG_FS_DAX)
 int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk);
 void dax_remove_host(struct gendisk *disk);
-
+struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
+		u64 *start_off);
 static inline void fs_put_dax(struct dax_device *dax_dev)
 {
 	put_dax(dax_dev);
 }
-
-struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
-		u64 *start_off);
-int dax_writeback_mapping_range(struct address_space *mapping,
-		struct dax_device *dax_dev, struct writeback_control *wbc);
-
-struct page *dax_layout_busy_page(struct address_space *mapping);
-struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
-dax_entry_t dax_lock_page(struct page *page);
-void dax_unlock_page(struct page *page, dax_entry_t cookie);
-int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
-		const struct iomap_ops *ops);
-int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops);
 #else
 static inline int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk)
 {
@@ -138,17 +125,29 @@ static inline int dax_add_host(struct dax_device *dax_dev, struct gendisk *disk)
 static inline void dax_remove_host(struct gendisk *disk)
 {
 }
-
-static inline void fs_put_dax(struct dax_device *dax_dev)
-{
-}
-
 static inline struct dax_device *fs_dax_get_by_bdev(struct block_device *bdev,
 		u64 *start_off)
 {
 	return NULL;
 }
+static inline void fs_put_dax(struct dax_device *dax_dev)
+{
+}
+#endif /* CONFIG_BLOCK && CONFIG_FS_DAX */
+
+#if IS_ENABLED(CONFIG_FS_DAX)
+int dax_writeback_mapping_range(struct address_space *mapping,
+		struct dax_device *dax_dev, struct writeback_control *wbc);
 
+struct page *dax_layout_busy_page(struct address_space *mapping);
+struct page *dax_layout_busy_page_range(struct address_space *mapping, loff_t start, loff_t end);
+dax_entry_t dax_lock_page(struct page *page);
+void dax_unlock_page(struct page *page, dax_entry_t cookie);
+int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
+		const struct iomap_ops *ops);
+int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
+		const struct iomap_ops *ops);
+#else
 static inline struct page *dax_layout_busy_page(struct address_space *mapping)
 {
 	return NULL;
-- 
2.30.2

