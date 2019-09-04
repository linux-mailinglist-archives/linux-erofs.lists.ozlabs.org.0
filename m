Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B79A789B
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 04:12:18 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46NS4t6tkJzDqnc
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Sep 2019 12:12:14 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.32; helo=huawei.com; envelope-from=gaoxiang25@huawei.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46NS355MFnzDqlR
 for <linux-erofs@lists.ozlabs.org>; Wed,  4 Sep 2019 12:10:41 +1000 (AEST)
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 00D1C8FEB033617DA992;
 Wed,  4 Sep 2019 10:10:39 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 4 Sep 2019
 10:10:27 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Christoph Hellwig <hch@lst.de>,
 <devel@driverdev.osuosl.org>
Subject: [PATCH v2 20/25] erofs: kill use_vmap module parameter
Date: Wed, 4 Sep 2019 10:09:07 +0800
Message-ID: <20190904020912.63925-21-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904020912.63925-1-gaoxiang25@huawei.com>
References: <20190901055130.30572-1-hsiangkao@aol.com>
 <20190904020912.63925-1-gaoxiang25@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.140.130.215]
X-CFilter-Loop: Reflected
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
Cc: linux-fsdevel@vger.kernel.org, Miao Xie <miaoxie@huawei.com>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As Christoph said [1],
"vm_map_ram is supposed to generally behave better.  So if
it doesn't please report that that to the arch maintainer
and linux-mm so that they can look into the issue.  Having
user make choices of deep down kernel internals is just
a horrible interface.

Please talk to maintainers of other bits of the kernel
if you see issues and / or need enhancements. "

Let's redo the previous conclusion and kill the vmap
approach.

[1] https://lore.kernel.org/r/20190830165533.GA10909@infradead.org/
Reported-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 Documentation/filesystems/erofs.txt |  4 ---
 fs/erofs/decompressor.c             | 46 ++++++++---------------------
 2 files changed, 13 insertions(+), 37 deletions(-)

diff --git a/Documentation/filesystems/erofs.txt b/Documentation/filesystems/erofs.txt
index c3b5f603b2b6..b0c085326e2e 100644
--- a/Documentation/filesystems/erofs.txt
+++ b/Documentation/filesystems/erofs.txt
@@ -67,10 +67,6 @@ cache_strategy=%s      Select a strategy for cached decompression from now on:
                                    It still does in-place I/O decompression
                                    for the rest compressed physical clusters.
 
-Module parameters
-=================
-use_vmap=[0|1]         Use vmap() instead of vm_map_ram() (default 0).
-
 On-disk details
 ===============
 
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 8ed38504a9f1..37177d49d125 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -28,10 +28,6 @@ struct z_erofs_decompressor {
 	char *name;
 };
 
-static bool use_vmap;
-module_param(use_vmap, bool, 0444);
-MODULE_PARM_DESC(use_vmap, "Use vmap() instead of vm_map_ram() (default 0)");
-
 static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 					 struct list_head *pagepool)
 {
@@ -221,32 +217,6 @@ static void copy_from_pcpubuf(struct page **out, const char *dst,
 	}
 }
 
-static void *erofs_vmap(struct page **pages, unsigned int count)
-{
-	int i = 0;
-
-	if (use_vmap)
-		return vmap(pages, count, VM_MAP, PAGE_KERNEL);
-
-	while (1) {
-		void *addr = vm_map_ram(pages, count, -1, PAGE_KERNEL);
-
-		/* retry two more times (totally 3 times) */
-		if (addr || ++i >= 3)
-			return addr;
-		vm_unmap_aliases();
-	}
-	return NULL;
-}
-
-static void erofs_vunmap(const void *mem, unsigned int count)
-{
-	if (!use_vmap)
-		vm_unmap_ram(mem, count);
-	else
-		vunmap(mem);
-}
-
 static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 				      struct list_head *pagepool)
 {
@@ -255,7 +225,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	const struct z_erofs_decompressor *alg = decompressors + rq->alg;
 	unsigned int dst_maptype;
 	void *dst;
-	int ret;
+	int ret, i;
 
 	if (nrpages_out == 1 && !rq->inplace_io) {
 		DBG_BUGON(!*rq->out);
@@ -293,9 +263,19 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 		goto dstmap_out;
 	}
 
-	dst = erofs_vmap(rq->out, nrpages_out);
+	i = 0;
+	while (1) {
+		dst = vm_map_ram(rq->out, nrpages_out, -1, PAGE_KERNEL);
+
+		/* retry two more times (totally 3 times) */
+		if (dst || ++i >= 3)
+			break;
+		vm_unmap_aliases();
+	}
+
 	if (!dst)
 		return -ENOMEM;
+
 	dst_maptype = 2;
 
 dstmap_out:
@@ -304,7 +284,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	if (!dst_maptype)
 		kunmap_atomic(dst);
 	else if (dst_maptype == 2)
-		erofs_vunmap(dst, nrpages_out);
+		vm_unmap_ram(dst, nrpages_out);
 	return ret;
 }
 
-- 
2.17.1

