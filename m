Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F83444A89D
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 09:33:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpLqH3RPKz2yfb
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 19:33:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=rdR1iIJU;
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
 header.s=casper.20170209 header.b=rdR1iIJU; 
 dkim-atps=neutral
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpLq45rpZz2yHb
 for <linux-erofs@lists.ozlabs.org>; Tue,  9 Nov 2021 19:33:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=/UOhk+aCjmw4IcKFQxJFjUhaacfvQMsVGHtw6Oh0pgU=; b=rdR1iIJUysmE8nRJhVw9bNqNcp
 8echW5oA/94avlJbwg/FA9CdiX+4EB8Uscv9tIdbDEZPSzHUThgHJr/VpORs7fHOLVLmbHm6FSnCa
 c3p/0Zwb54leaozWprP8d+hr4t/bdbofDGxBNHnWcwDsiNHBK9RcdMfr1C2NIWBAUUKVlg4d4xG0q
 C/5EaO5wXfo4kT/HsbD82Gju/ex+0pI9PnUZVuRzsDnTqPqkyx5F5yZMJ3ULme8b0+IcHCSeBcVzA
 2Ix9scM8foqKqTHFSUXzLvvhTp+JKBiBJkvU/icgDP2UGaG4sBE31/3zDeOGp9n6KHXlBemoMny1o
 X75Qcpug==;
Received: from [2001:4bb8:19a:7ee7:fb46:2fe1:8652:d9d4] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mkMZD-000ryI-IK; Tue, 09 Nov 2021 08:33:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 03/29] dax: remove CONFIG_DAX_DRIVER
Date: Tue,  9 Nov 2021 09:32:43 +0100
Message-Id: <20211109083309.584081-4-hch@lst.de>
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

CONFIG_DAX_DRIVER only selects CONFIG_DAX now, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/dax/Kconfig        | 4 ----
 drivers/nvdimm/Kconfig     | 2 +-
 drivers/s390/block/Kconfig | 2 +-
 fs/fuse/Kconfig            | 2 +-
 4 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/dax/Kconfig b/drivers/dax/Kconfig
index d2834c2cfa10d..954ab14ba7778 100644
--- a/drivers/dax/Kconfig
+++ b/drivers/dax/Kconfig
@@ -1,8 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-config DAX_DRIVER
-	select DAX
-	bool
-
 menuconfig DAX
 	tristate "DAX: direct access to differentiated memory"
 	select SRCU
diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
index b7d1eb38b27d4..347fe7afa5830 100644
--- a/drivers/nvdimm/Kconfig
+++ b/drivers/nvdimm/Kconfig
@@ -22,7 +22,7 @@ if LIBNVDIMM
 config BLK_DEV_PMEM
 	tristate "PMEM: Persistent memory block device support"
 	default LIBNVDIMM
-	select DAX_DRIVER
+	select DAX
 	select ND_BTT if BTT
 	select ND_PFN if NVDIMM_PFN
 	help
diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
index d0416dbd0cd81..e3710a762abae 100644
--- a/drivers/s390/block/Kconfig
+++ b/drivers/s390/block/Kconfig
@@ -5,7 +5,7 @@ comment "S/390 block device drivers"
 config DCSSBLK
 	def_tristate m
 	select FS_DAX_LIMITED
-	select DAX_DRIVER
+	select DAX
 	prompt "DCSSBLK support"
 	depends on S390 && BLOCK
 	help
diff --git a/fs/fuse/Kconfig b/fs/fuse/Kconfig
index 40ce9a1c12e5d..038ed0b9aaa5d 100644
--- a/fs/fuse/Kconfig
+++ b/fs/fuse/Kconfig
@@ -45,7 +45,7 @@ config FUSE_DAX
 	select INTERVAL_TREE
 	depends on VIRTIO_FS
 	depends on FS_DAX
-	depends on DAX_DRIVER
+	depends on DAX
 	help
 	  This allows bypassing guest page cache and allows mapping host page
 	  cache directly in guest address space.
-- 
2.30.2

