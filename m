Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA044676F
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Jun 2019 20:18:59 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45QTQ85dGZzDrnj
	for <lists+linux-erofs@lfdr.de>; Sat, 15 Jun 2019 04:18:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.191; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45QTNQ4xK8zDrnN
 for <linux-erofs@lists.ozlabs.org>; Sat, 15 Jun 2019 04:17:26 +1000 (AEST)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 73CA778964032139EC6E;
 Sat, 15 Jun 2019 02:17:23 +0800 (CST)
Received: from architecture4.huawei.com (10.140.130.215) by smtp.huawei.com
 (10.3.19.208) with Microsoft SMTP Server (TLS) id 14.3.439.0; Sat, 15 Jun
 2019 02:17:12 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: <chao@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 <devel@driverdev.osuosl.org>
Subject: [RFC PATCH 7/8] staging: erofs: switch to new decompression backend
Date: Sat, 15 Jun 2019 02:16:18 +0800
Message-ID: <20190614181619.64905-8-gaoxiang25@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190614181619.64905-1-gaoxiang25@huawei.com>
References: <20190614181619.64905-1-gaoxiang25@huawei.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 weidu.du@huawei.com, linux-fsdevel@vger.kernel.org,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This patch integrates new decompression framework to
erofs decompression path, and remove the old
decompression implementation as well.

On kirin980 platform, sequential read is slightly
improved to 778MiB/s after the new decompression
backend is used.

Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 drivers/staging/erofs/Makefile        |   2 +-
 drivers/staging/erofs/unzip_vle.c     |  59 +++----
 drivers/staging/erofs/unzip_vle.h     |  13 --
 drivers/staging/erofs/unzip_vle_lz4.c | 216 --------------------------
 4 files changed, 22 insertions(+), 268 deletions(-)
 delete mode 100644 drivers/staging/erofs/unzip_vle_lz4.c

diff --git a/drivers/staging/erofs/Makefile b/drivers/staging/erofs/Makefile
index adeb5d6e2668..e704d9e51514 100644
--- a/drivers/staging/erofs/Makefile
+++ b/drivers/staging/erofs/Makefile
@@ -9,5 +9,5 @@ obj-$(CONFIG_EROFS_FS) += erofs.o
 ccflags-y += -I $(srctree)/$(src)/include
 erofs-objs := super.o inode.o data.o namei.o dir.o utils.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
-erofs-$(CONFIG_EROFS_FS_ZIP) += unzip_vle.o unzip_vle_lz4.o zmap.o decompressor.o
+erofs-$(CONFIG_EROFS_FS_ZIP) += unzip_vle.o zmap.o decompressor.o
 
diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index d95f985936b6..cb870b83f3c8 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -897,12 +897,12 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	unsigned int sparsemem_pages = 0;
 	struct page *pages_onstack[Z_EROFS_VLE_VMAP_ONSTACK_PAGES];
 	struct page **pages, **compressed_pages, *page;
-	unsigned int i, llen;
+	unsigned int algorithm;
+	unsigned int i, outputsize;
 
 	enum z_erofs_page_type page_type;
 	bool overlapped;
 	struct z_erofs_vle_work *work;
-	void *vout;
 	int err;
 
 	might_sleep();
@@ -1009,43 +1009,26 @@ static int z_erofs_vle_unzip(struct super_block *sb,
 	if (unlikely(err))
 		goto out;
 
-	llen = (nr_pages << PAGE_SHIFT) - work->pageofs;
-
-	if (z_erofs_vle_workgrp_fmt(grp) == Z_EROFS_VLE_WORKGRP_FMT_PLAIN) {
-		err = z_erofs_vle_plain_copy(compressed_pages, clusterpages,
-					     pages, nr_pages, work->pageofs);
-		goto out;
-	}
-
-	if (llen > grp->llen)
-		llen = grp->llen;
-
-	err = z_erofs_vle_unzip_fast_percpu(compressed_pages, clusterpages,
-					    pages, llen, work->pageofs);
-	if (err != -ENOTSUPP)
-		goto out;
-
-	if (sparsemem_pages >= nr_pages)
-		goto skip_allocpage;
-
-	for (i = 0; i < nr_pages; ++i) {
-		if (pages[i])
-			continue;
-
-		pages[i] = __stagingpage_alloc(page_pool, GFP_NOFS);
-	}
-
-skip_allocpage:
-	vout = erofs_vmap(pages, nr_pages);
-	if (!vout) {
-		err = -ENOMEM;
-		goto out;
-	}
-
-	err = z_erofs_vle_unzip_vmap(compressed_pages, clusterpages, vout,
-				     llen, work->pageofs, overlapped);
+	if (nr_pages << PAGE_SHIFT >= work->pageofs + grp->llen)
+		outputsize = grp->llen;
+	else
+		outputsize = (nr_pages << PAGE_SHIFT) - work->pageofs;
 
-	erofs_vunmap(vout, nr_pages);
+	if (z_erofs_vle_workgrp_fmt(grp) == Z_EROFS_VLE_WORKGRP_FMT_PLAIN)
+		algorithm = Z_EROFS_COMPRESSION_SHIFTED;
+	else
+		algorithm = Z_EROFS_COMPRESSION_LZ4;
+
+	err = z_erofs_decompress(&(struct z_erofs_decompress_req) {
+					.sb = sb,
+					.in = compressed_pages,
+					.out = pages,
+					.pageofs_out = work->pageofs,
+					.inputsize = PAGE_SIZE,
+					.outputsize = outputsize,
+					.alg = algorithm,
+					.inplace_io = overlapped,
+					.partial_decoding = true }, page_pool);
 
 out:
 	/* must handle all compressed pages before endding pages */
diff --git a/drivers/staging/erofs/unzip_vle.h b/drivers/staging/erofs/unzip_vle.h
index 6c3e0deb63e7..2abde53d09d7 100644
--- a/drivers/staging/erofs/unzip_vle.h
+++ b/drivers/staging/erofs/unzip_vle.h
@@ -189,18 +189,5 @@ static inline void z_erofs_onlinepage_endio(struct page *page)
 	min_t(unsigned int, THREAD_SIZE / 8 / sizeof(struct page *), 96U)
 #define Z_EROFS_VLE_VMAP_GLOBAL_PAGES	2048
 
-/* unzip_vle_lz4.c */
-int z_erofs_vle_plain_copy(struct page **compressed_pages,
-			   unsigned int clusterpages, struct page **pages,
-			   unsigned int nr_pages, unsigned short pageofs);
-int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
-				  unsigned int clusterpages,
-				  struct page **pages, unsigned int outlen,
-				  unsigned short pageofs);
-int z_erofs_vle_unzip_vmap(struct page **compressed_pages,
-			   unsigned int clusterpages,
-			   void *vaddr, unsigned int llen,
-			   unsigned short pageofs, bool overlapped);
-
 #endif
 
diff --git a/drivers/staging/erofs/unzip_vle_lz4.c b/drivers/staging/erofs/unzip_vle_lz4.c
deleted file mode 100644
index 399c3e3a3ff3..000000000000
--- a/drivers/staging/erofs/unzip_vle_lz4.c
+++ /dev/null
@@ -1,216 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * linux/drivers/staging/erofs/unzip_vle_lz4.c
- *
- * Copyright (C) 2018 HUAWEI, Inc.
- *             http://www.huawei.com/
- * Created by Gao Xiang <gaoxiang25@huawei.com>
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of the Linux
- * distribution for more details.
- */
-#include "unzip_vle.h"
-#include <linux/lz4.h>
-
-static int z_erofs_unzip_lz4(void *in, void *out, size_t inlen, size_t outlen)
-{
-	int ret = LZ4_decompress_safe_partial(in, out, inlen, outlen, outlen);
-
-	if (ret >= 0)
-		return ret;
-
-	/*
-	 * LZ4_decompress_safe_partial will return an error code
-	 * (< 0) if decompression failed
-	 */
-	errln("%s, failed to decompress, in[%p, %zu] outlen[%p, %zu]",
-	      __func__, in, inlen, out, outlen);
-	WARN_ON(1);
-	print_hex_dump(KERN_DEBUG, "raw data [in]: ", DUMP_PREFIX_OFFSET,
-		       16, 1, in, inlen, true);
-	print_hex_dump(KERN_DEBUG, "raw data [out]: ", DUMP_PREFIX_OFFSET,
-		       16, 1, out, outlen, true);
-	return -EIO;
-}
-
-int z_erofs_vle_plain_copy(struct page **compressed_pages,
-			   unsigned int clusterpages,
-			   struct page **pages,
-			   unsigned int nr_pages,
-			   unsigned short pageofs)
-{
-	unsigned int i, j;
-	void *src = NULL;
-	const unsigned int righthalf = PAGE_SIZE - pageofs;
-	char *percpu_data;
-	bool mirrored[Z_EROFS_CLUSTER_MAX_PAGES] = { 0 };
-
-	percpu_data = erofs_get_pcpubuf(0);
-
-	j = 0;
-	for (i = 0; i < nr_pages; j = i++) {
-		struct page *page = pages[i];
-		void *dst;
-
-		if (!page) {
-			if (src) {
-				if (!mirrored[j])
-					kunmap_atomic(src);
-				src = NULL;
-			}
-			continue;
-		}
-
-		dst = kmap_atomic(page);
-
-		for (; j < clusterpages; ++j) {
-			if (compressed_pages[j] != page)
-				continue;
-
-			DBG_BUGON(mirrored[j]);
-			memcpy(percpu_data + j * PAGE_SIZE, dst, PAGE_SIZE);
-			mirrored[j] = true;
-			break;
-		}
-
-		if (i) {
-			if (!src)
-				src = mirrored[i - 1] ?
-					percpu_data + (i - 1) * PAGE_SIZE :
-					kmap_atomic(compressed_pages[i - 1]);
-
-			memcpy(dst, src + righthalf, pageofs);
-
-			if (!mirrored[i - 1])
-				kunmap_atomic(src);
-
-			if (unlikely(i >= clusterpages)) {
-				kunmap_atomic(dst);
-				break;
-			}
-		}
-
-		if (!righthalf) {
-			src = NULL;
-		} else {
-			src = mirrored[i] ? percpu_data + i * PAGE_SIZE :
-				kmap_atomic(compressed_pages[i]);
-
-			memcpy(dst + pageofs, src, righthalf);
-		}
-
-		kunmap_atomic(dst);
-	}
-
-	if (src && !mirrored[j])
-		kunmap_atomic(src);
-
-	erofs_put_pcpubuf(percpu_data);
-	return 0;
-}
-
-int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
-				  unsigned int clusterpages,
-				  struct page **pages,
-				  unsigned int outlen,
-				  unsigned short pageofs)
-{
-	void *vin, *vout;
-	unsigned int nr_pages, i, j;
-	int ret;
-
-	if (outlen + pageofs > EROFS_PCPUBUF_NR_PAGES * PAGE_SIZE)
-		return -ENOTSUPP;
-
-	nr_pages = DIV_ROUND_UP(outlen + pageofs, PAGE_SIZE);
-
-	if (clusterpages == 1) {
-		vin = kmap_atomic(compressed_pages[0]);
-	} else {
-		vin = erofs_vmap(compressed_pages, clusterpages);
-		if (!vin)
-			return -ENOMEM;
-	}
-
-	vout = erofs_get_pcpubuf(0);
-
-	ret = z_erofs_unzip_lz4(vin, vout + pageofs,
-				clusterpages * PAGE_SIZE, outlen);
-
-	if (ret < 0)
-		goto out;
-	ret = 0;
-
-	for (i = 0; i < nr_pages; ++i) {
-		j = min((unsigned int)PAGE_SIZE - pageofs, outlen);
-
-		if (pages[i]) {
-			if (clusterpages == 1 &&
-			    pages[i] == compressed_pages[0]) {
-				memcpy(vin + pageofs, vout + pageofs, j);
-			} else {
-				void *dst = kmap_atomic(pages[i]);
-
-				memcpy(dst + pageofs, vout + pageofs, j);
-				kunmap_atomic(dst);
-			}
-		}
-		vout += PAGE_SIZE;
-		outlen -= j;
-		pageofs = 0;
-	}
-
-out:
-	erofs_put_pcpubuf(vout);
-
-	if (clusterpages == 1)
-		kunmap_atomic(vin);
-	else
-		erofs_vunmap(vin, clusterpages);
-
-	return ret;
-}
-
-int z_erofs_vle_unzip_vmap(struct page **compressed_pages,
-			   unsigned int clusterpages,
-			   void *vout,
-			   unsigned int llen,
-			   unsigned short pageofs,
-			   bool overlapped)
-{
-	void *vin;
-	unsigned int i;
-	int ret;
-
-	if (overlapped) {
-		vin = erofs_get_pcpubuf(0);
-
-		for (i = 0; i < clusterpages; ++i) {
-			void *t = kmap_atomic(compressed_pages[i]);
-
-			memcpy(vin + PAGE_SIZE * i, t, PAGE_SIZE);
-			kunmap_atomic(t);
-		}
-	} else if (clusterpages == 1) {
-		vin = kmap_atomic(compressed_pages[0]);
-	} else {
-		vin = erofs_vmap(compressed_pages, clusterpages);
-	}
-
-	ret = z_erofs_unzip_lz4(vin, vout + pageofs,
-				clusterpages * PAGE_SIZE, llen);
-	if (ret > 0)
-		ret = 0;
-
-	if (overlapped) {
-		erofs_put_pcpubuf(vin);
-	} else {
-		if (clusterpages == 1)
-			kunmap_atomic(vin);
-		else
-			erofs_vunmap(vin, clusterpages);
-	}
-	return ret;
-}
-
-- 
2.17.1

