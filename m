Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A50888FE038
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 09:54:46 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jC2eCpOr;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VvxSM5Rzwz3d9T
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Jun 2024 17:54:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jC2eCpOr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=devnull+tao.zeng.amlogic.com@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VvxSG3yS8z3cyZ
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Jun 2024 17:54:38 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6964461BAD;
	Thu,  6 Jun 2024 07:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1175BC3277B;
	Thu,  6 Jun 2024 07:54:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717660446;
	bh=sHrlOe3NTCnAMCSmqGXcMGAKIgr/nza9djFfKUSo/+E=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=jC2eCpOr+/56KRQAX5Ypg5IEhTBXiRuZj9ALVdo58obnYFJeymlsME7ybc+JJsmf2
	 cpNh5mjmBqbweQEEuhRQQFAgWjZpgRTQ7w87nhp2dv8EuNv7D7INPPevOYcAEKpLKK
	 8nEdSwfvaZsXcbKcZ2NGggz+RQvOsZfnWHK9xRCxtol0XnavM36aV32swG3kzCTGnc
	 8Zgwe83nVYd+q6IWLF5HoTgW3C5fepyPFaD7zNSS5fgSUQ4NMInBGBJLIcqAaHoI2C
	 QGMpo4hhek9cUnFRnk9rcXIOr1AdmtEL8LgrNuqmDuDykZMUs5uQ1Ubf4J8kkxNyvf
	 fGjgonEWBhByA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED593C27C52;
	Thu,  6 Jun 2024 07:54:05 +0000 (UTC)
From: Tao Zeng via B4 Relay <devnull+tao.zeng.amlogic.com@kernel.org>
Date: Thu, 06 Jun 2024 15:53:39 +0800
Subject: [PATCH] erofs: support external crypto for decompression
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-erofs-decompression-v1-1-ec5f31396e04@amlogic.com>
X-B4-Tracking: v=1; b=H4sIAAJrYWYC/x2MywqAIBBFf0VmnaBS9viVaBE51izScCAC8d+zl
 od77snAmAgZJpEh4U1MMVTQjYDtWMOOklxlMMq0yiorMUXP0uEWzyshf770rkPjTa/HQUF91sH
 T81fnpZQXsGwrzmUAAAA=
To: Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
 Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
 Sandeep Dhavale <dhavale@google.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717660444; l=14972;
 i=tao.zeng@amlogic.com; s=20240606; h=from:subject:message-id;
 bh=UChEykSJC9STUyymjVQj6jbfmREBt7vm8tfAZME1FKw=;
 b=2gGclF2ugFsco0gYqxPr1SF0+TtG8Fkm2SwV9oxVem0hPIwRAaCmAFXxJ64MmvMVqgvLjHuGr
 eSDxVnvaPOWAqMOpV1bcV4w+vaZHI2KiVeDL+WYGTYVO6o54A2/xCw5
X-Developer-Key: i=tao.zeng@amlogic.com; a=ed25519;
 pk=TOPTYm9PlbErXLz0fwlAaBhc4HVp49Ki7eldqh1al1o=
X-Endpoint-Received: by B4 Relay for tao.zeng@amlogic.com/20240606 with
 auth_id=169
X-Original-From: Tao Zeng <tao.zeng@amlogic.com>
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
Reply-To: tao.zeng@amlogic.com
Cc: Tao Zeng <tao.zeng@amlogic.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Tao Zeng <tao.zeng@amlogic.com>

Some SoCs have hardware decompressors which using private algorithms,
which can be used for accelerating decompression for EROFS, but
current EROFS decompressor architecture do not support external
decompressors, this change adds a crypto layer interface for decompression
and can be used to hook SoC vendor's decompressor by crypto name. Soc
vendors can develop their own code which can be added to crypto layer.

Signed-off-by: Tao Zeng <tao.zeng@amlogic.com>
---
 fs/erofs/Kconfig                |  19 +++
 fs/erofs/Makefile               |   1 +
 fs/erofs/compress.h             |  28 ++++
 fs/erofs/decompressor.c         |   7 +
 fs/erofs/decompressor_cryptor.c | 306 ++++++++++++++++++++++++++++++++++++++++
 fs/erofs/erofs_fs.h             |  14 ++
 fs/erofs/internal.h             |   4 +
 fs/erofs/super.c                |   8 +-
 8 files changed, 386 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 7dcdce660cac..72e29041244b 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -127,6 +127,25 @@ config EROFS_FS_ZIP_ZSTD
 
 	  If unsure, say N.
 
+config EROFS_FS_ZIP_CRYPTO
+	bool "EROFS external crypto decompress support"
+	depends on EROFS_FS_ZIP
+	help
+	  Saying Y here to support external crypto for decompressing EROFS
+	  file systems. Some SoCs have hardware decompressor with private
+	  algorithm, which can be used for accelarating decompression of
+	  EROFS. This config enables external cryptos.
+
+	  If unsure, say N.
+
+config EROFS_CRYPTO_MAX_DISTANCE_PAGES
+	int "EROFS max distance pages for crypto usage"
+	default 32
+	help
+	  This config defines max distance pages for external crypto. Crypto
+	  layer will use this value to grow up PCP buffers.
+	  The default value is 128KB(32 pages).
+
 config EROFS_FS_ONDEMAND
 	bool "EROFS fscache-based on-demand read support"
 	depends on EROFS_FS
diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 097d672e6b14..d2dc5e2d20bd 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -7,4 +7,5 @@ erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o zutil.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
 erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
+erofs-$(CONFIG_EROFS_FS_ZIP_CRYPTO) += decompressor_cryptor.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 19d53c30c8af..8236775563a5 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -98,4 +98,32 @@ int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 			       struct page **pagepool);
 int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 			    struct page **pgpl);
+
+#ifdef CONFIG_EROFS_FS_ZIP_CRYPTO
+/* for external cryto decompress */
+int z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
+			      struct page **pagepool);
+int z_erofs_load_crypto_config(struct super_block *sb,
+			       struct erofs_super_block *dsb,
+			       void *data, int size);
+#else
+static inline int z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
+					    struct page **pagepool)
+{
+	return -EINVAL;
+}
+
+static inline int z_erofs_load_crypto_config(struct super_block *sb,
+					     struct erofs_super_block *dsb,
+					     void *data,
+					     int size);
+{
+	if (crypto) {
+		erofs_err(sb, "crypto algorithm isn't enabled");
+		return -EINVAL;
+	}
+	return 0;
+}
+#endif
+
 #endif
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 9d85b6c11c6b..83fde9e974e3 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -406,6 +406,13 @@ const struct z_erofs_decompressor erofs_decompressors[] = {
 		.name = "zstd"
 	},
 #endif
+#ifdef CONFIG_EROFS_FS_ZIP_CRYPTO
+	[Z_EROFS_COMPRESSION_CRYPTO] = {
+		.config = z_erofs_load_crypto_config,
+		.decompress = z_erofs_crypto_decompress,
+		.name = "crypto"
+	},
+#endif
 };
 
 int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
diff --git a/fs/erofs/decompressor_cryptor.c b/fs/erofs/decompressor_cryptor.c
new file mode 100644
index 000000000000..87df4d285ad1
--- /dev/null
+++ b/fs/erofs/decompressor_cryptor.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2024 Amlogic, Inc. All rights reserved.
+ */
+#include <linux/types.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/highmem.h>
+#include <linux/xz.h>
+#include <linux/module.h>
+#include <linux/crypto.h>
+#include "compress.h"
+#include "internal.h"
+
+static int crypto_max_distance_pages;
+
+int z_erofs_load_crypto_config(struct super_block *sb,
+			       struct erofs_super_block *dsb,
+			       void *data, int size)
+{
+	struct erofs_sb_info *sbi;
+	struct z_erofs_crypto_cfgs *crypto = (struct z_erofs_crypto_cfgs *)data;
+	int max_pages;
+
+	sbi = EROFS_SB(sb);
+	if (!sbi)
+		return -EINVAL;
+
+	if (sbi->crypto) {
+		erofs_err(sb, "already have crypto\n");
+		return -EINVAL;
+	}
+	if (crypto) {
+		max_pages = BIT(crypto->max_distance) / PAGE_SIZE;
+		if (max_pages > CONFIG_EROFS_CRYPTO_MAX_DISTANCE_PAGES) {
+			erofs_err(sb, "bad max distance:%d\n", max_pages);
+			return -EINVAL;
+		}
+
+		if (max_pages > crypto_max_distance_pages)
+			crypto_max_distance_pages = max_pages;
+		sbi->crypto = crypto_alloc_comp(crypto->crypto_name, 0, 0);
+		if (IS_ERR(sbi->crypto)) {
+			erofs_err(sb, "failed to alloc cryto %s\n",
+				  crypto->crypto_name);
+			return PTR_ERR(sbi->crypto);
+		}
+		erofs_info(sb, "max pcluster:%d, distance:%d, %d, crypto:%s\n",
+			   crypto->max_pclusterblks,
+			   crypto->max_distance, crypto_max_distance_pages,
+			   crypto->crypto_name);
+		return z_erofs_gbuf_growsize(crypto_max_distance_pages);
+	} else {
+		return -EINVAL;
+	}
+}
+
+static void *z_erofs_crypto_handle_inplace_io(struct z_erofs_decompress_req *rq,
+					      void *inpage,
+					      unsigned int *inputmargin,
+					      int *maptype,
+					      bool support_0padding)
+{
+	unsigned int nrpages_in, nrpages_out;
+	unsigned int ofull, oend, inputsize, total, i, j;
+	struct page **in;
+	void *src, *tmp;
+
+	inputsize = rq->inputsize;
+	nrpages_in = PAGE_ALIGN(inputsize) >> PAGE_SHIFT;
+	oend = rq->pageofs_out + rq->outputsize;
+	ofull = PAGE_ALIGN(oend);
+	nrpages_out = ofull >> PAGE_SHIFT;
+
+	if (rq->inplace_io) {
+		if (rq->partial_decoding)
+			goto docopy;
+
+		for (i = 0; i < nrpages_in; ++i) {
+			WARN_ON(!rq->in[i]);
+			for (j = 0; j < nrpages_out; ++j) {
+				if (rq->out[j] == rq->in[i])
+					goto docopy;
+			}
+		}
+	}
+
+	if (nrpages_in <= 1) {
+		*maptype = 0;
+		return inpage;
+	}
+	kunmap_local(inpage);
+	might_sleep();
+	src = erofs_vm_map_ram(rq->in, nrpages_in);
+	if (!src)
+		return ERR_PTR(-ENOMEM);
+	*maptype = 1;
+	return src;
+
+docopy:
+	/* Or copy compressed data which can be overlapped to per-CPU buffer */
+	in = rq->in;
+	src = z_erofs_get_gbuf(nrpages_in);
+	if (!src) {
+		WARN_ON(1);
+		kunmap_local(inpage);
+		return ERR_PTR(-EFAULT);
+	}
+
+	tmp = src;
+	total = rq->inputsize;
+	while (total) {
+		unsigned int page_copycnt =
+			min_t(unsigned int, total, PAGE_SIZE - *inputmargin);
+
+		if (!inpage)
+			inpage = kmap_local_page(*in);
+		memcpy(tmp, inpage + *inputmargin, page_copycnt);
+		kunmap_local(inpage);
+		inpage = NULL;
+		tmp += page_copycnt;
+		total -= page_copycnt;
+		++in;
+		*inputmargin = 0;
+	}
+	*maptype = 2;
+	return src;
+}
+
+static int z_erofs_crypto_decompress_mem(struct z_erofs_decompress_req *rq, u8 *out)
+{
+	unsigned int inputmargin;
+	u8 *src, *headpage;
+	int ret;
+	int maptype;
+	bool support_0padding = true;
+	struct erofs_sb_info *sbi;
+	int outsize;
+
+	WARN_ON(!*rq->in);
+	inputmargin = 0;
+	headpage = kmap_local_page(*rq->in);
+
+	sbi = EROFS_SB(rq->sb);
+
+	/* decompression inplace is only safe when 0padding is enabled */
+	if (erofs_sb_has_zero_padding(EROFS_SB(rq->sb))) {
+		support_0padding = true;
+
+		/* skip zero padding at beginning of page */
+		while (!headpage[inputmargin & ~PAGE_MASK])
+			if (!(++inputmargin & ~PAGE_MASK))
+				break;
+
+		if (inputmargin >= rq->inputsize) {
+			kunmap_local(headpage);
+			return -EIO;
+		}
+	}
+
+	rq->inputsize -= inputmargin;
+	src = z_erofs_crypto_handle_inplace_io(rq, headpage, &inputmargin,
+					       &maptype, support_0padding);
+	if (IS_ERR(src))
+		return PTR_ERR(src);
+
+	pr_debug("%s, type:%d, in:%p, out:%p, in page:%lx, out_page:%lx\n",
+		 __func__, maptype, src, out,
+		 page_to_pfn(*rq->in), page_to_pfn(*rq->out));
+
+	outsize = rq->outputsize;
+	ret = crypto_comp_decompress(sbi->crypto, src + inputmargin,
+				     rq->inputsize, out, &rq->outputsize);
+	if (ret < 0 || outsize != rq->outputsize) {
+		erofs_err(rq->sb, "failed to decompress %d in[%u, %u] out[%u]",
+			  ret, rq->inputsize, inputmargin, rq->outputsize);
+
+		print_hex_dump_debug("[ in]: ", DUMP_PREFIX_OFFSET,
+				     16, 1, src + inputmargin,
+				     rq->inputsize, true);
+		print_hex_dump_debug("[out]: ", DUMP_PREFIX_OFFSET,
+				     16, 1, out, rq->outputsize, true);
+
+		if (ret >= 0)
+			memset(out + ret, 0, rq->outputsize - ret);
+		ret = -EIO;
+	} else {
+		ret = 0;
+	}
+
+	if (maptype == 0) {
+		kunmap_local(src);
+	} else if (maptype == 1) {
+		vm_unmap_ram(src, PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT);
+	} else if (maptype == 2) {
+		z_erofs_put_gbuf(src);
+	} else {
+		WARN_ON(1);
+		return -EFAULT;
+	}
+	return ret;
+}
+
+/*
+ * Fill all gaps with bounce pages if it's a sparse page list. Also check if
+ * all physical pages are consecutive, which can be seen for moderate CR.
+ */
+static int z_erofs_crypto_prepare_dstpages(struct z_erofs_decompress_req *rq,
+					   struct page **pagepool)
+{
+	const unsigned int nr = PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
+	struct page *available[CONFIG_EROFS_CRYPTO_MAX_DISTANCE_PAGES] = { NULL };
+	unsigned long bounced[DIV_ROUND_UP(CONFIG_EROFS_CRYPTO_MAX_DISTANCE_PAGES, BITS_PER_LONG)];
+	void *kaddr = NULL;
+	unsigned int i, j, top;
+
+	memset(bounced, 0, sizeof(bounced));
+	top = 0;
+	for (i = j = 0; i < nr; ++i, ++j) {
+		struct page *const page = rq->out[i];
+		struct page *victim;
+
+		if (j >= crypto_max_distance_pages)
+			j = 0;
+
+		/* 'valid' bounced can only be tested after a complete round */
+		if (test_bit(j, bounced)) {
+			WARN_ON(i < crypto_max_distance_pages);
+			WARN_ON(top >= crypto_max_distance_pages);
+			available[top++] = rq->out[i - crypto_max_distance_pages];
+		}
+
+		if (page) {
+			__clear_bit(j, bounced);
+			if (!PageHighMem(page)) {
+				if (!i) {
+					kaddr = page_address(page);
+					continue;
+				}
+				if (kaddr &&
+				    kaddr + PAGE_SIZE == page_address(page)) {
+					kaddr += PAGE_SIZE;
+					continue;
+				}
+			}
+			kaddr = NULL;
+			continue;
+		}
+		kaddr = NULL;
+		__set_bit(j, bounced);
+
+		if (top) {
+			victim = available[--top];
+			get_page(victim);
+		} else {
+			victim = erofs_allocpage(pagepool,
+						 GFP_KERNEL | __GFP_NOFAIL);
+			set_page_private(victim, Z_EROFS_SHORTLIVED_PAGE);
+		}
+		rq->out[i] = victim;
+	}
+	return kaddr ? 1 : 0;
+}
+
+int z_erofs_crypto_decompress(struct z_erofs_decompress_req *rq,
+			      struct page **pagepool)
+{
+	const unsigned int nrpages_out =
+		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
+	unsigned int dst_maptype;
+	void *dst;
+	int ret;
+
+	/* one optimized fast path only for non bigpcluster cases yet */
+	if (rq->inputsize <= PAGE_SIZE && nrpages_out == 1 && !rq->inplace_io) {
+		WARN_ON(!*rq->out);
+		dst = kmap_local_page(*rq->out);
+		dst_maptype = 0;
+		goto dstmap_out;
+	}
+
+	ret = z_erofs_crypto_prepare_dstpages(rq, pagepool);
+	if (ret < 0)
+		return ret;
+
+	dst = erofs_vm_map_ram(rq->out, nrpages_out);
+	if (!dst)
+		return -ENOMEM;
+	dst_maptype = 2;
+
+dstmap_out:
+	pr_debug("%s, dst:%p, map:%d, pageofs_out:%d, outputsize:%d, inputsize:%d, inplace_io:%d, partial:%d\n",
+		 __func__, dst, dst_maptype,
+		 rq->pageofs_out, rq->outputsize, rq->inputsize,
+		 rq->inplace_io, rq->partial_decoding);
+
+	ret = z_erofs_crypto_decompress_mem(rq, dst + rq->pageofs_out);
+
+	if (!dst_maptype)
+		kunmap_local(dst);
+	else if (dst_maptype == 2)
+		vm_unmap_ram(dst, nrpages_out);
+
+	return ret;
+}
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 6c0c270c42e1..993b7a1b656f 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -297,6 +297,10 @@ enum {
 	Z_EROFS_COMPRESSION_LZMA	= 1,
 	Z_EROFS_COMPRESSION_DEFLATE	= 2,
 	Z_EROFS_COMPRESSION_ZSTD	= 3,
+#ifdef CONFIG_EROFS_FS_ZIP_CRYPTO
+	/* for generic crypto framework */
+	Z_EROFS_COMPRESSION_CRYPTO	= 4,
+#endif
 	Z_EROFS_COMPRESSION_MAX
 };
 #define Z_EROFS_ALL_COMPR_ALGS		((1 << Z_EROFS_COMPRESSION_MAX) - 1)
@@ -330,6 +334,16 @@ struct z_erofs_zstd_cfgs {
 	u8 reserved[4];
 } __packed;
 
+#ifdef CONFIG_EROFS_FS_ZIP_CRYPTO
+/* 16 bytes */
+struct z_erofs_crypto_cfgs {
+	char   crypto_name[8];
+	__le16 max_distance;
+	__le16 max_pclusterblks;
+	u8     reserved[4];
+} __packed;
+#endif
+
 #define Z_EROFS_ZSTD_MAX_DICT_SIZE      Z_EROFS_PCLUSTER_MAX_SIZE
 
 /*
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 0c1b44ac9524..ecf49c260ed4 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -129,6 +129,10 @@ struct erofs_sb_info {
 	struct inode *managed_cache;
 
 	struct erofs_sb_lz4_info lz4;
+#ifdef CONFIG_EROFS_FS_ZIP_CRYPTO
+	/* decompress crypto for other algorithms except lz4/lzma */
+	struct crypto_comp *crypto;
+#endif
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	struct inode *packed_inode;
 	struct erofs_dev_context *devs;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index c93bd24d2771..c7bc852dbc96 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -10,6 +10,9 @@
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/exportfs.h>
+#ifdef CONFIG_EROFS_FS_ZIP_CRYPTO
+#include <linux/crypto.h>
+#endif
 #include "xattr.h"
 
 #define CREATE_TRACE_POINTS
@@ -793,7 +796,10 @@ static void erofs_kill_sb(struct super_block *sb)
 		kill_anon_super(sb);
 	else
 		kill_block_super(sb);
-
+#ifdef CONFIG_EROFS_FS_ZIP_CRYPTO
+	if (sbi->crypto)
+		crypto_free_comp(sbi->crypto);
+#endif
 	erofs_free_dev_context(sbi->devs);
 	fs_put_dax(sbi->dax_dev, NULL);
 	erofs_fscache_unregister_fs(sb);

---
base-commit: ee78a17615ad0cfdbbc27182b1047cd36c9d4d5f
change-id: 20240606-erofs-decompression-fd5e2f271980

Best regards,
-- 
Tao Zeng <tao.zeng@amlogic.com>


