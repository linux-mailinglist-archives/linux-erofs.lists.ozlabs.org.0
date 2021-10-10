Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9804283D8
	for <lists+linux-erofs@lfdr.de>; Sun, 10 Oct 2021 23:33:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HSFXN3f6Yz2yHV
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Oct 2021 08:33:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Ct8zXm0R;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=Ct8zXm0R; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HSFXJ3hb1z2xWl
 for <linux-erofs@lists.ozlabs.org>; Mon, 11 Oct 2021 08:33:04 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8311960F38;
 Sun, 10 Oct 2021 21:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1633901582;
 bh=REWL81PBmSzheDdbsiT+DK5bUkprOjrYJYUB7y22URw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ct8zXm0RCQo563Q1uxG8cXPl4Y3tmwmAxdzfp1k239mR776J8Wkiuk9d4bXebVjGn
 jJbXWs1PHEVsDdlcdQrI1ZwNqt6bngLSR90BjzKpiGvASTzCOqEwWwNhNGXfQub3HW
 tIczQVFSknjG2gs1pwLEz2CeS8H9f/fkr9es4ZMbjAx5BxkHOGPNdCL2nSNoduo6VY
 d3zzkWwjpDv8f+kU2Sl+VTXe7e3lLStTfcP+7j1lzymIuh49O6a1IOrk6LhYs47KHt
 ycjlGB4AqcBsj4PFcYCF7xl7ZBMvBa88gQoIytOOlNCE6wlYUbT2n8xLcWtjsPqbid
 IMBqae6oN5nww==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH 7/7] erofs: lzma compression support
Date: Mon, 11 Oct 2021 05:31:45 +0800
Message-Id: <20211010213145.17462-8-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211010213145.17462-1-xiang@kernel.org>
References: <20211010213145.17462-1-xiang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Lasse Collin <lasse.collin@tukaani.org>,
 Greg KH <gregkh@linuxfoundation.org>, Gao Xiang <hsiangkao@linux.alibaba.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Add MicroLZMA support in order to maximize compression ratios for
specific scenarios. For example, it's useful for low-end embedded
boards and as a secondary algorithm in a file for specific access
patterns.

MicroLZMA is a new container format for raw LZMA1, which was created
by Lasse Collin aiming to minimize old LZMA headers and get rid of
unnecessary EOPM (end of payload marker) as well as to enable
fixed-sized output compression, especially for 4KiB pclusters.

Similar to LZ4, inplace I/O approach is used to minimize runtime
memory footprint when dealing with I/O. Overlapped decompression is
handled with 1) bounced buffer for data under processing or 2) extra
short-lived pages from the on-stack pagepool which will be shared in
the same read request (128KiB for example).

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/Kconfig             |  16 ++
 fs/erofs/Makefile            |   1 +
 fs/erofs/compress.h          |  16 ++
 fs/erofs/decompressor.c      |  12 +-
 fs/erofs/decompressor_lzma.c | 290 +++++++++++++++++++++++++++++++++++
 fs/erofs/erofs_fs.h          |  14 +-
 fs/erofs/internal.h          |  22 +++
 fs/erofs/super.c             |  17 +-
 fs/erofs/zdata.c             |   4 +-
 fs/erofs/zdata.h             |   7 -
 fs/erofs/zmap.c              |   5 +-
 11 files changed, 383 insertions(+), 21 deletions(-)
 create mode 100644 fs/erofs/decompressor_lzma.c

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 14b747026742..fa6d1b7a73e6 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -76,3 +76,19 @@ config EROFS_FS_ZIP
 	  Enable fixed-sized output compression for EROFS.
 
 	  If you don't want to enable compression feature, say N.
+
+config EROFS_FS_ZIP_LZMA
+	bool "EROFS LZMA compressed data support"
+	depends on EROFS_FS_ZIP
+	select XZ_DEC
+	select XZ_DEC_MICROLZMA
+	help
+	  Saying Y here includes support for reading EROFS file systems
+	  containing LZMA compressed data, specifically called microLZMA. it
+	  gives better compression ratios than the LZ4 algorithm, at the
+	  expense of more CPU overhead.
+
+	  LZMA support is an experimental feature for now and so most file
+	  systems will be readable without selecting this option.
+
+	  If unsure, say N.
diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 1f9aced49070..756fe2d65272 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_EROFS_FS) += erofs.o
 erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
 erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
+erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index ad62d1b4d371..8ea6a9b14962 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -20,6 +20,12 @@ struct z_erofs_decompress_req {
 	bool inplace_io, partial_decoding;
 };
 
+struct z_erofs_decompressor {
+	int (*decompress)(struct z_erofs_decompress_req *rq,
+			  struct list_head *pagepool);
+	char *name;
+};
+
 /* some special page->private (unsigned long, see below) */
 #define Z_EROFS_SHORTLIVED_PAGE		(-1UL << 2)
 #define Z_EROFS_PREALLOCATED_PAGE	(-2UL << 2)
@@ -75,7 +81,17 @@ static inline bool z_erofs_put_shortlivedpage(struct list_head *pagepool,
 	return true;
 }
 
+#define MNGD_MAPPING(sbi)	((sbi)->managed_cache->i_mapping)
+static inline bool erofs_page_is_managed(const struct erofs_sb_info *sbi,
+					 struct page *page)
+{
+	return page->mapping == MNGD_MAPPING(sbi);
+}
+
 int z_erofs_decompress(struct z_erofs_decompress_req *rq,
 		       struct list_head *pagepool);
 
+/* prototypes for specific algorithms */
+int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
+			    struct list_head *pagepool);
 #endif
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index bceaa2b06b17..0e3b42311158 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -16,12 +16,6 @@
 #define LZ4_DECOMPRESS_INPLACE_MARGIN(srcsize)  (((srcsize) >> 8) + 32)
 #endif
 
-struct z_erofs_decompressor {
-	int (*decompress)(struct z_erofs_decompress_req *rq,
-			  struct list_head *pagepool);
-	char *name;
-};
-
 int z_erofs_load_lz4_config(struct super_block *sb,
 			    struct erofs_super_block *dsb,
 			    struct z_erofs_lz4_cfgs *lz4, int size)
@@ -396,6 +390,12 @@ static struct z_erofs_decompressor decompressors[] = {
 		.decompress = z_erofs_lz4_decompress,
 		.name = "lz4"
 	},
+#ifdef CONFIG_EROFS_FS_ZIP_LZMA
+	[Z_EROFS_COMPRESSION_LZMA] = {
+		.decompress = z_erofs_lzma_decompress,
+		.name = "lzma"
+	},
+#endif
 };
 
 int z_erofs_decompress(struct z_erofs_decompress_req *rq,
diff --git a/fs/erofs/decompressor_lzma.c b/fs/erofs/decompressor_lzma.c
new file mode 100644
index 000000000000..bd7d9809ecf7
--- /dev/null
+++ b/fs/erofs/decompressor_lzma.c
@@ -0,0 +1,290 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/xz.h>
+#include <linux/module.h>
+#include "compress.h"
+
+struct z_erofs_lzma {
+	struct z_erofs_lzma *next;
+	struct xz_dec_microlzma *state;
+	struct xz_buf buf;
+	u8 bounce[PAGE_SIZE];
+};
+
+/* considering the LZMA performance, no need to use a lockless list for now */
+static DEFINE_SPINLOCK(z_erofs_lzma_lock);
+static unsigned int z_erofs_lzma_max_dictsize;
+static unsigned int z_erofs_lzma_nstrms, z_erofs_lzma_avail_strms;
+static struct z_erofs_lzma *z_erofs_lzma_head;
+static DECLARE_WAIT_QUEUE_HEAD(z_erofs_lzma_wq);
+
+module_param_named(lzma_streams, z_erofs_lzma_nstrms, uint, 0444);
+
+void z_erofs_lzma_exit(void)
+{
+	/* there should be no running fs instance */
+	while (z_erofs_lzma_avail_strms) {
+		struct z_erofs_lzma *strm;
+
+		spin_lock(&z_erofs_lzma_lock);
+		strm = z_erofs_lzma_head;
+		if (!strm) {
+			spin_unlock(&z_erofs_lzma_lock);
+			DBG_BUGON(1);
+			return;
+		}
+		z_erofs_lzma_head = NULL;
+		spin_unlock(&z_erofs_lzma_lock);
+
+		while (strm) {
+			struct z_erofs_lzma *n = strm->next;
+
+			if (strm->state)
+				xz_dec_microlzma_end(strm->state);
+			kfree(strm);
+			--z_erofs_lzma_avail_strms;
+			strm = n;
+		}
+	}
+}
+
+int z_erofs_lzma_init(void)
+{
+	unsigned int i;
+
+	/* by default, use # of possible CPUs instead */
+	if (!z_erofs_lzma_nstrms)
+		z_erofs_lzma_nstrms = num_possible_cpus();
+
+	for (i = 0; i < z_erofs_lzma_nstrms; ++i) {
+		struct z_erofs_lzma *strm = kzalloc(sizeof(*strm), GFP_KERNEL);
+
+		if (!strm) {
+			z_erofs_lzma_exit();
+			return -ENOMEM;
+		}
+		spin_lock(&z_erofs_lzma_lock);
+		strm->next = z_erofs_lzma_head;
+		z_erofs_lzma_head = strm;
+		spin_unlock(&z_erofs_lzma_lock);
+		++z_erofs_lzma_avail_strms;
+	}
+	return 0;
+}
+
+int z_erofs_load_lzma_config(struct super_block *sb,
+			     struct erofs_super_block *dsb,
+			     struct z_erofs_lzma_cfgs *lzma, int size)
+{
+	static DEFINE_MUTEX(lzma_resize_mutex);
+	unsigned int dict_size, i;
+	struct z_erofs_lzma *strm, *head = NULL;
+	int err;
+
+	if (!lzma || size < sizeof(struct z_erofs_lzma_cfgs)) {
+		erofs_err(sb, "invalid lzma cfgs, size=%u", size);
+		return -EINVAL;
+	}
+	if (lzma->format) {
+		erofs_err(sb, "unidentified lzma format %x, please check kernel version",
+			  le16_to_cpu(lzma->format));
+		return -EINVAL;
+	}
+	dict_size = le32_to_cpu(lzma->dict_size);
+	if (dict_size > Z_EROFS_LZMA_MAX_DICT_SIZE || dict_size < 4096) {
+		erofs_err(sb, "unsupported lzma dictionary size %u",
+			  dict_size);
+		return -EINVAL;
+	}
+
+	erofs_info(sb, "EXPERIMENTAL MicroLZMA in use. Use at your own risk!");
+
+	/* in case 2 z_erofs_load_lzma_config() race to avoid deadlock */
+	mutex_lock(&lzma_resize_mutex);
+
+	if (z_erofs_lzma_max_dictsize >= dict_size) {
+		mutex_unlock(&lzma_resize_mutex);
+		return 0;
+	}
+
+	/* 1. collect/isolate all streams for the following check */
+	for (i = 0; i < z_erofs_lzma_avail_strms; ++i) {
+		struct z_erofs_lzma *last;
+
+again:
+		spin_lock(&z_erofs_lzma_lock);
+		strm = z_erofs_lzma_head;
+		if (!strm) {
+			spin_unlock(&z_erofs_lzma_lock);
+			wait_event(z_erofs_lzma_wq,
+				   READ_ONCE(z_erofs_lzma_head));
+			goto again;
+		}
+		z_erofs_lzma_head = NULL;
+		spin_unlock(&z_erofs_lzma_lock);
+
+		for (last = strm; last->next; last = last->next)
+			++i;
+		last->next = head;
+		head = strm;
+	}
+
+	err = 0;
+	/* 2. walk each isolated stream and grow max dict_size if needed */
+	for (strm = head; strm; strm = strm->next) {
+		if (strm->state)
+			xz_dec_microlzma_end(strm->state);
+		strm->state = xz_dec_microlzma_alloc(XZ_PREALLOC, dict_size);
+		if (!strm->state)
+			err = -ENOMEM;
+	}
+
+	/* 3. push back all to the global list and update max dict_size */
+	spin_lock(&z_erofs_lzma_lock);
+	DBG_BUGON(z_erofs_lzma_head);
+	z_erofs_lzma_head = head;
+	spin_unlock(&z_erofs_lzma_lock);
+
+	z_erofs_lzma_max_dictsize = dict_size;
+	mutex_unlock(&lzma_resize_mutex);
+	return err;
+}
+
+int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
+			    struct list_head *pagepool)
+{
+	const unsigned int nrpages_out =
+		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
+	const unsigned int nrpages_in =
+		PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT;
+	unsigned int inputmargin, inlen, outlen, pageofs;
+	struct z_erofs_lzma *strm;
+	u8 *kin;
+	bool bounced = false;
+	int no, ni, j, err = 0;
+
+	/* 1. get the exact LZMA compressed size */
+	kin = kmap(*rq->in);
+	inputmargin = 0;
+	while (!kin[inputmargin & ~PAGE_MASK])
+		if (!(++inputmargin & ~PAGE_MASK))
+			break;
+
+	if (inputmargin >= PAGE_SIZE) {
+		kunmap(*rq->in);
+		return -EFSCORRUPTED;
+	}
+	rq->inputsize -= inputmargin;
+
+	/* 2. get an available lzma context */
+again:
+	spin_lock(&z_erofs_lzma_lock);
+	strm = z_erofs_lzma_head;
+	if (!strm) {
+		spin_unlock(&z_erofs_lzma_lock);
+		wait_event(z_erofs_lzma_wq, READ_ONCE(z_erofs_lzma_head));
+		goto again;
+	}
+	z_erofs_lzma_head = strm->next;
+	spin_unlock(&z_erofs_lzma_lock);
+
+	/* 3. multi-call decompress */
+	inlen = rq->inputsize;
+	outlen = rq->outputsize;
+	xz_dec_microlzma_reset(strm->state, inlen, outlen,
+			       !rq->partial_decoding);
+	pageofs = rq->pageofs_out;
+	strm->buf.in = kin + inputmargin;
+	strm->buf.in_pos = 0;
+	strm->buf.in_size = min_t(u32, inlen, PAGE_SIZE - inputmargin);
+	inlen -= strm->buf.in_size;
+	strm->buf.out = NULL;
+	strm->buf.out_pos = 0;
+	strm->buf.out_size = 0;
+
+	for (ni = 0, no = -1;;) {
+		enum xz_ret xz_err;
+
+		if (strm->buf.out_pos == strm->buf.out_size) {
+			if (strm->buf.out) {
+				kunmap(rq->out[no]);
+				strm->buf.out = NULL;
+			}
+
+			if (++no >= nrpages_out || !outlen) {
+				erofs_err(rq->sb, "decompressed buf out of bound");
+				err = -EFSCORRUPTED;
+				break;
+			}
+			strm->buf.out_pos = 0;
+			strm->buf.out_size = min_t(u32, outlen,
+						   PAGE_SIZE - pageofs);
+			outlen -= strm->buf.out_size;
+			if (rq->out[no])
+				strm->buf.out = kmap(rq->out[no]) + pageofs;
+			pageofs = 0;
+		} else if (strm->buf.in_pos == strm->buf.in_size) {
+			kunmap(rq->in[ni]);
+
+			if (++ni >= nrpages_in || !inlen) {
+				erofs_err(rq->sb, "compressed buf out of bound");
+				err = -EFSCORRUPTED;
+				break;
+			}
+			strm->buf.in_pos = 0;
+			strm->buf.in_size = min_t(u32, inlen, PAGE_SIZE);
+			inlen -= strm->buf.in_size;
+			kin = kmap(rq->in[ni]);
+			strm->buf.in = kin;
+			bounced = false;
+		}
+
+		/*
+		 * Handle overlapping: Use bounced buffer if the compressed
+		 * data is under processing; Otherwise, Use short-lived pages
+		 * from the on-stack pagepool where pages share with the same
+		 * request.
+		 */
+		if (!bounced && rq->out[no] == rq->in[ni]) {
+			memcpy(strm->bounce, strm->buf.in, strm->buf.in_size);
+			strm->buf.in = strm->bounce;
+			bounced = true;
+		}
+		for (j = ni + 1; j < nrpages_in; ++j) {
+			struct page *tmppage;
+
+			if (rq->out[no] != rq->in[j])
+				continue;
+
+			DBG_BUGON(erofs_page_is_managed(EROFS_SB(rq->sb),
+							rq->in[j]));
+			tmppage = erofs_allocpage(pagepool,
+						  GFP_KERNEL | __GFP_NOFAIL);
+			set_page_private(tmppage, Z_EROFS_SHORTLIVED_PAGE);
+			copy_highpage(tmppage, rq->in[j]);
+			rq->in[j] = tmppage;
+		}
+		xz_err = xz_dec_microlzma_run(strm->state, &strm->buf);
+		DBG_BUGON(strm->buf.out_pos > strm->buf.out_size);
+		DBG_BUGON(strm->buf.in_pos > strm->buf.in_size);
+
+		if (xz_err != XZ_OK) {
+			if (xz_err == XZ_STREAM_END && !outlen)
+				break;
+			erofs_err(rq->sb, "failed to decompress %d in[%u] out[%u]",
+				  xz_err, rq->inputsize, rq->outputsize);
+			err = -EFSCORRUPTED;
+			break;
+		}
+	}
+	if (no < nrpages_out && strm->buf.out)
+		kunmap(rq->in[no]);
+	if (ni < nrpages_in)
+		kunmap(rq->in[ni]);
+	/* 4. push back LZMA stream context to the global list */
+	spin_lock(&z_erofs_lzma_lock);
+	strm->next = z_erofs_lzma_head;
+	z_erofs_lzma_head = strm;
+	spin_unlock(&z_erofs_lzma_lock);
+	wake_up(&z_erofs_lzma_wq);
+	return err;
+}
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index f579c8c78fff..e6337a4a2d13 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -249,10 +249,11 @@ struct erofs_inode_chunk_index {
 
 /* available compression algorithm types (for h_algorithmtype) */
 enum {
-	Z_EROFS_COMPRESSION_LZ4	= 0,
+	Z_EROFS_COMPRESSION_LZ4		= 0,
+	Z_EROFS_COMPRESSION_LZMA	= 1,
 	Z_EROFS_COMPRESSION_MAX
 };
-#define Z_EROFS_ALL_COMPR_ALGS		(1 << (Z_EROFS_COMPRESSION_MAX - 1))
+#define Z_EROFS_ALL_COMPR_ALGS		((1 << Z_EROFS_COMPRESSION_MAX) - 1)
 
 /* 14 bytes (+ length field = 16 bytes) */
 struct z_erofs_lz4_cfgs {
@@ -261,6 +262,15 @@ struct z_erofs_lz4_cfgs {
 	u8 reserved[10];
 } __packed;
 
+/* 14 bytes (+ length field = 16 bytes) */
+struct z_erofs_lzma_cfgs {
+	__le32 dict_size;
+	__le16 format;
+	u8 reserved[8];
+} __packed;
+
+#define Z_EROFS_LZMA_MAX_DICT_SIZE	(8 * Z_EROFS_PCLUSTER_MAX_SIZE)
+
 /*
  * bit 0 : COMPACTED_2B indexes (0 - off; 1 - on)
  *  e.g. for 4k logical cluster size,      4B        if compacted 2B is off;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 7f96265ccbdb..8c04c3ce7af6 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -381,6 +381,8 @@ struct erofs_map_blocks {
  * approach instead if possible since it's more metadata lightweight.)
  */
 #define EROFS_GET_BLOCKS_FIEMAP	0x0002
+/* Used to map the whole extent if non-negligible data is requested for LZMA */
+#define EROFS_GET_BLOCKS_READMORE	0x0004
 
 enum {
 	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
@@ -502,6 +504,26 @@ static inline int z_erofs_load_lz4_config(struct super_block *sb,
 }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
+#ifdef CONFIG_EROFS_FS_ZIP_LZMA
+int z_erofs_lzma_init(void);
+void z_erofs_lzma_exit(void);
+int z_erofs_load_lzma_config(struct super_block *sb,
+			     struct erofs_super_block *dsb,
+			     struct z_erofs_lzma_cfgs *lzma, int size);
+#else
+static inline int z_erofs_lzma_init(void) { return 0; }
+static inline int z_erofs_lzma_exit(void) { return 0; }
+static inline int z_erofs_load_lzma_config(struct super_block *sb,
+			     struct erofs_super_block *dsb,
+			     struct z_erofs_lzma_cfgs *lzma, int size) {
+	if (lzma) {
+		erofs_err(sb, "lzma algorithm isn't enabled");
+		return -EINVAL;
+	}
+	return 0;
+}
+#endif	/* !CONFIG_EROFS_FS_ZIP */
+
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
 
 #endif	/* __EROFS_INTERNAL_H */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 11b88559f8bf..7c2ace97e94e 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -225,6 +225,9 @@ static int erofs_load_compr_cfgs(struct super_block *sb,
 		case Z_EROFS_COMPRESSION_LZ4:
 			ret = z_erofs_load_lz4_config(sb, dsb, data, size);
 			break;
+		case Z_EROFS_COMPRESSION_LZMA:
+			ret = z_erofs_load_lzma_config(sb, dsb, data, size);
+			break;
 		default:
 			DBG_BUGON(1);
 			ret = -EFAULT;
@@ -706,6 +709,10 @@ static int __init erofs_module_init(void)
 	if (err)
 		goto shrinker_err;
 
+	err = z_erofs_lzma_init();
+	if (err)
+		goto lzma_err;
+
 	erofs_pcpubuf_init();
 	err = z_erofs_init_zip_subsystem();
 	if (err)
@@ -720,6 +727,8 @@ static int __init erofs_module_init(void)
 fs_err:
 	z_erofs_exit_zip_subsystem();
 zip_err:
+	z_erofs_lzma_exit();
+lzma_err:
 	erofs_exit_shrinker();
 shrinker_err:
 	kmem_cache_destroy(erofs_inode_cachep);
@@ -730,11 +739,13 @@ static int __init erofs_module_init(void)
 static void __exit erofs_module_exit(void)
 {
 	unregister_filesystem(&erofs_fs_type);
-	z_erofs_exit_zip_subsystem();
-	erofs_exit_shrinker();
 
-	/* Ensure all RCU free inodes are safe before cache is destroyed. */
+	/* Ensure all RCU free inodes / pclusters are safe to be destroyed. */
 	rcu_barrier();
+
+	z_erofs_exit_zip_subsystem();
+	z_erofs_lzma_exit();
+	erofs_exit_shrinker();
 	kmem_cache_destroy(erofs_inode_cachep);
 	erofs_pcpubuf_exit();
 }
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index febb018e10a7..159e1dc56be6 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1394,8 +1394,8 @@ static void z_erofs_pcluster_readmore(struct z_erofs_decompress_frontend *f,
 
 	if (backmost) {
 		map->m_la = end;
-		/* TODO: pass in EROFS_GET_BLOCKS_READMORE for LZMA later */
-		err = z_erofs_map_blocks_iter(inode, map, 0);
+		err = z_erofs_map_blocks_iter(inode, map,
+					      EROFS_GET_BLOCKS_READMORE);
 		if (err)
 			return;
 
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index 3a008f1b9f78..879df5362777 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -94,13 +94,6 @@ struct z_erofs_decompressqueue {
 	} u;
 };
 
-#define MNGD_MAPPING(sbi)	((sbi)->managed_cache->i_mapping)
-static inline bool erofs_page_is_managed(const struct erofs_sb_info *sbi,
-					 struct page *page)
-{
-	return page->mapping == MNGD_MAPPING(sbi);
-}
-
 #define Z_EROFS_ONLINEPAGE_COUNT_BITS   2
 #define Z_EROFS_ONLINEPAGE_COUNT_MASK   ((1 << Z_EROFS_ONLINEPAGE_COUNT_BITS) - 1)
 #define Z_EROFS_ONLINEPAGE_INDEX_SHIFT  (Z_EROFS_ONLINEPAGE_COUNT_BITS)
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 864d9d5474d5..6cc055807e27 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -671,7 +671,10 @@ int z_erofs_map_blocks_iter(struct inode *inode,
 	else
 		map->m_algorithmformat = vi->z_algorithmtype[0];
 
-	if (flags & EROFS_GET_BLOCKS_FIEMAP) {
+	if ((flags & EROFS_GET_BLOCKS_FIEMAP) ||
+	    ((flags & EROFS_GET_BLOCKS_READMORE) &&
+	     map->m_algorithmformat == Z_EROFS_COMPRESSION_LZMA &&
+	     map->m_llen >= EROFS_BLKSIZ)) {
 		err = z_erofs_get_extent_decompressedlen(&m);
 		if (!err)
 			map->m_flags |= EROFS_MAP_FULL_MAPPED;
-- 
2.20.1

