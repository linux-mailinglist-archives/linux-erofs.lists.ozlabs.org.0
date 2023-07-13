Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 643FF751507
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 02:15:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R1Zqw2B7Mz3by2
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jul 2023 10:15:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R1Zqq44gjz30dw
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jul 2023 10:15:02 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VnEY9LI_1689207285;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VnEY9LI_1689207285)
          by smtp.aliyun-inc.com;
          Thu, 13 Jul 2023 08:14:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs: DEFLATE compression support
Date: Thu, 13 Jul 2023 08:14:41 +0800
Message-Id: <20230713001441.30462-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add DEFLATE compression as the 3rd supported algorithm.

DEFLATE is a popular generic-purpose compression algorithm for quite
long time (many advanced formats like gzip, zlib, zip, png are all
based on that) as Apple documentation written "If you require
interoperability with non-Apple devices, use COMPRESSION_ZLIB. [1]".

Due to its popularity, there are several hardware on-market DEFLATE
accelerators, such as (s390) DFLTCC, (Intel) IAA/QAT, (HiSilicon) ZIP
accelerator, etc.  In addition, there are also several high-performence
IP cores and even open-source FPGA approches available for DEFLATE.
Therefore, it's useful to support DEFLATE compression in order to find
a way to utilize these accelerators for asynchronous I/Os and get
benefits from these later.

Besides, it's a good choice to trade off between compression ratios
and performance compared to LZ4 and LZMA.  The DEFLATE core format is
simple as well as easy to understand, therefore the code size of its
decompressor is small even for the bootloader use cases.  The runtime
memory consumption is quite limited too (e.g. 32K + ~7K for each zlib
stream).  As usual, EROFS ourperforms similar approaches too.

Alternatively, DEFLATE could still be used for some specific files
since EROFS supports multiple compression algorithms in one image.

[1] https://developer.apple.com/documentation/compression/compression_algorithm
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
change since v2:
 - fix typo "whileas" --> "while" suggested by Randy.

 fs/erofs/Kconfig                |  15 ++
 fs/erofs/Makefile               |   1 +
 fs/erofs/compress.h             |   2 +
 fs/erofs/decompressor.c         |   6 +
 fs/erofs/decompressor_deflate.c | 249 ++++++++++++++++++++++++++++++++
 fs/erofs/erofs_fs.h             |   7 +
 fs/erofs/internal.h             |  20 +++
 fs/erofs/super.c                |  10 ++
 fs/erofs/zmap.c                 |   5 +-
 9 files changed, 313 insertions(+), 2 deletions(-)
 create mode 100644 fs/erofs/decompressor_deflate.c

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index f259d92c9720..56a99ba8ce22 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -99,6 +99,21 @@ config EROFS_FS_ZIP_LZMA
 
 	  If unsure, say N.
 
+config EROFS_FS_ZIP_DEFLATE
+	bool "EROFS DEFLATE compressed data support"
+	depends on EROFS_FS_ZIP
+	select ZLIB_INFLATE
+	help
+	  Saying Y here includes support for reading EROFS file systems
+	  containing DEFLATE compressed data.  It gives better compression
+	  ratios than the default LZ4 format, while it costs more CPU
+	  overhead.
+
+	  DEFLATE support is an experimental feature for now and so most
+	  file systems will be readable without selecting this option.
+
+	  If unsure, say N.
+
 config EROFS_FS_ONDEMAND
 	bool "EROFS fscache-based on-demand read support"
 	depends on CACHEFILES_ONDEMAND && (EROFS_FS=m && FSCACHE || EROFS_FS=y && FSCACHE=y)
diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index a3a98fc3e481..994d0b9deddf 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -5,4 +5,5 @@ erofs-objs := super.o inode.o data.o namei.o dir.o utils.o sysfs.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
 erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o pcpubuf.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
+erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index b1b846504027..349c3316ae6b 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -94,4 +94,6 @@ extern const struct z_erofs_decompressor erofs_decompressors[];
 /* prototypes for specific algorithms */
 int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 			    struct page **pagepool);
+int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
+			       struct page **pagepool);
 #endif
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index cfad1eac7fd9..332ec5f74002 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -379,4 +379,10 @@ const struct z_erofs_decompressor erofs_decompressors[] = {
 		.name = "lzma"
 	},
 #endif
+#ifdef CONFIG_EROFS_FS_ZIP_DEFLATE
+	[Z_EROFS_COMPRESSION_DEFLATE] = {
+		.decompress = z_erofs_deflate_decompress,
+		.name = "deflate"
+	},
+#endif
 };
diff --git a/fs/erofs/decompressor_deflate.c b/fs/erofs/decompressor_deflate.c
new file mode 100644
index 000000000000..5b389ed0501e
--- /dev/null
+++ b/fs/erofs/decompressor_deflate.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/module.h>
+#include <linux/zlib.h>
+#include "compress.h"
+
+struct z_erofs_deflate {
+	struct z_erofs_deflate *next;
+	struct z_stream_s z;
+	u8 bounce[PAGE_SIZE];
+};
+
+static DEFINE_SPINLOCK(z_erofs_deflate_lock);
+static unsigned int z_erofs_deflate_nstrms, z_erofs_deflate_avail_strms;
+static struct z_erofs_deflate *z_erofs_deflate_head;
+static DECLARE_WAIT_QUEUE_HEAD(z_erofs_deflate_wq);
+
+module_param_named(deflate_streams, z_erofs_deflate_nstrms, uint, 0444);
+
+void z_erofs_deflate_exit(void)
+{
+	/* there should be no running fs instance */
+	while (z_erofs_deflate_avail_strms) {
+		struct z_erofs_deflate *strm;
+
+		spin_lock(&z_erofs_deflate_lock);
+		strm = z_erofs_deflate_head;
+		if (!strm) {
+			spin_unlock(&z_erofs_deflate_lock);
+			DBG_BUGON(1);
+			return;
+		}
+		z_erofs_deflate_head = NULL;
+		spin_unlock(&z_erofs_deflate_lock);
+
+		while (strm) {
+			struct z_erofs_deflate *n = strm->next;
+
+			vfree(strm->z.workspace);
+			kfree(strm);
+			--z_erofs_deflate_avail_strms;
+			strm = n;
+		}
+	}
+}
+
+int __init z_erofs_deflate_init(void)
+{
+	/* by default, use # of possible CPUs instead */
+	if (!z_erofs_deflate_nstrms)
+		z_erofs_deflate_nstrms = num_possible_cpus();
+
+	for (; z_erofs_deflate_avail_strms < z_erofs_deflate_nstrms;
+	     ++z_erofs_deflate_avail_strms) {
+		struct z_erofs_deflate *strm;
+
+		strm = kzalloc(sizeof(*strm), GFP_KERNEL);
+		if (!strm)
+			goto out_failed;
+
+		/* XXX: in-kernel zlib cannot shrink windowbits currently */
+		strm->z.workspace = vmalloc(zlib_inflate_workspacesize());
+		if (!strm->z.workspace)
+			goto out_failed;
+
+		spin_lock(&z_erofs_deflate_lock);
+		strm->next = z_erofs_deflate_head;
+		z_erofs_deflate_head = strm;
+		spin_unlock(&z_erofs_deflate_lock);
+	}
+	return 0;
+
+out_failed:
+	pr_err("failed to allocate zlib workspace\n");
+	z_erofs_deflate_exit();
+	return -ENOMEM;
+}
+
+int z_erofs_load_deflate_config(struct super_block *sb,
+				struct erofs_super_block *dsb,
+				struct z_erofs_deflate_cfgs *dfl, int size)
+{
+	if (!dfl || size < sizeof(struct z_erofs_deflate_cfgs)) {
+		erofs_err(sb, "invalid deflate cfgs, size=%u", size);
+		return -EINVAL;
+	}
+
+	if (dfl->windowbits > MAX_WBITS) {
+		erofs_err(sb, "unsupported windowbits %u", dfl->windowbits);
+		return -EOPNOTSUPP;
+	}
+
+	erofs_info(sb, "EXPERIMENTAL DEFLATE feature in use. Use at your own risk!");
+	return 0;
+}
+
+int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
+			       struct page **pagepool)
+{
+	static u8 skipped[PAGE_SIZE];
+	const unsigned int nrpages_out =
+		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
+	const unsigned int nrpages_in =
+		PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT;
+	struct super_block *sb = rq->sb;
+	unsigned int insz, outsz, pofs;
+	struct z_erofs_deflate *strm;
+	u8 *kin, *kout = NULL;
+	bool bounced = false;
+	int no = -1, ni = 0, j = 0, zerr, err;
+
+	/* 1. get the exact DEFLATE compressed size */
+	kin = kmap_local_page(*rq->in);
+	err = z_erofs_fixup_insize(rq, kin + rq->pageofs_in,
+			min_t(unsigned int, rq->inputsize,
+			      sb->s_blocksize - rq->pageofs_in));
+	if (err) {
+		kunmap_local(kin);
+		return err;
+	}
+
+	/* 2. get an available DEFLATE context */
+again:
+	spin_lock(&z_erofs_deflate_lock);
+	strm = z_erofs_deflate_head;
+	if (!strm) {
+		spin_unlock(&z_erofs_deflate_lock);
+		wait_event(z_erofs_deflate_wq, READ_ONCE(z_erofs_deflate_head));
+		goto again;
+	}
+	z_erofs_deflate_head = strm->next;
+	spin_unlock(&z_erofs_deflate_lock);
+
+	/* 3. multi-call decompress */
+	insz = rq->inputsize;
+	outsz = rq->outputsize;
+	zerr = zlib_inflateInit2(&strm->z, -MAX_WBITS);
+	if (zerr != Z_OK) {
+		err = -EIO;
+		goto failed_zinit;
+	}
+
+	pofs = rq->pageofs_out;
+	strm->z.avail_in = min_t(u32, insz, PAGE_SIZE - rq->pageofs_in);
+	strm->z.next_in = kin + rq->pageofs_in;
+	strm->z.avail_out = 0;
+
+	while (1) {
+		if (!strm->z.avail_out) {
+			if (++no >= nrpages_out || !outsz) {
+				erofs_err(sb, "insufficient space for decompressed data");
+				err = -EFSCORRUPTED;
+				break;
+			}
+
+			if (kout)
+				kunmap_local(kout);
+			strm->z.avail_out = min_t(u32, outsz, PAGE_SIZE - pofs);
+			outsz -= strm->z.avail_out;
+			if (rq->out[no] && rq->fillgaps) /* deduped data */
+				rq->out[no] = erofs_allocpage(pagepool,
+						GFP_KERNEL | __GFP_NOFAIL);
+			if (rq->out[no]) {
+				kout = kmap_local_page(rq->out[no]) + pofs;
+				strm->z.next_out = kout;
+			} else {
+				kout = NULL;
+				strm->z.next_out = skipped;
+			}
+			pofs = 0;
+		}
+
+		if (!strm->z.avail_in) {
+			if (++ni >= nrpages_in || !insz) {
+				erofs_err(sb, "compressed data was invalid");
+				err = -EFSCORRUPTED;
+				break;
+			}
+
+			if (kout) { /* unlike kmap(), take care of the orders */
+				j = strm->z.next_out - kout;
+				kunmap_local(kout);
+			}
+			kunmap_local(kin);
+			strm->z.avail_in = min_t(u32, insz, PAGE_SIZE);
+			insz -= strm->z.avail_in;
+			kin = kmap_local_page(rq->in[ni]);
+			strm->z.next_in = kin;
+			bounced = false;
+			if (kout) {
+				kout = kmap_local_page(rq->out[no]);
+				strm->z.next_out = kout + j;
+			}
+		}
+
+		/*
+		 * Handle overlapping: Use bounced buffer if the compressed
+		 * data is under processing; Or use short-lived pages from the
+		 * on-stack pagepool where pages share among the same request
+		 * and not _all_ inplace I/O pages are needed to be doubled.
+		 */
+		if (!bounced && rq->out[no] == rq->in[ni]) {
+			memcpy(strm->bounce, strm->z.next_in, strm->z.avail_in);
+			strm->z.next_in = strm->bounce;
+			bounced = true;
+		}
+
+		for (j = ni + 1; j < nrpages_in; ++j) {
+			struct page *tmppage;
+
+			if (rq->out[no] != rq->in[j])
+				continue;
+
+			DBG_BUGON(erofs_page_is_managed(EROFS_SB(sb),
+							rq->in[j]));
+			tmppage = erofs_allocpage(pagepool,
+						  GFP_KERNEL | __GFP_NOFAIL);
+			set_page_private(tmppage, Z_EROFS_SHORTLIVED_PAGE);
+			copy_highpage(tmppage, rq->in[j]);
+			rq->in[j] = tmppage;
+		}
+
+		zerr = zlib_inflate(&strm->z, Z_SYNC_FLUSH);
+		if (zerr != Z_OK || !outsz) {
+			if (zerr == Z_OK && rq->partial_decoding)
+				break;
+			if (zerr == Z_STREAM_END && !outsz)
+				break;
+			erofs_err(sb, "failed to decompress %d in[%u] out[%u]",
+				  zerr, rq->inputsize, rq->outputsize);
+			err = -EFSCORRUPTED;
+			break;
+		}
+	}
+
+	if (zlib_inflateEnd(&strm->z) != Z_OK && !err)
+		err = -EIO;
+	if (kout)
+		kunmap_local(kout);
+failed_zinit:
+	if (kin)
+		kunmap_local(kin);
+	/* 4. push back DEFLATE stream context to the global list */
+	spin_lock(&z_erofs_deflate_lock);
+	strm->next = z_erofs_deflate_head;
+	z_erofs_deflate_head = strm;
+	spin_unlock(&z_erofs_deflate_lock);
+	wake_up(&z_erofs_deflate_wq);
+	return err;
+}
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 2c7b16e340fe..364f51171c13 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -289,6 +289,7 @@ struct erofs_dirent {
 enum {
 	Z_EROFS_COMPRESSION_LZ4		= 0,
 	Z_EROFS_COMPRESSION_LZMA	= 1,
+	Z_EROFS_COMPRESSION_DEFLATE	= 2,
 	Z_EROFS_COMPRESSION_MAX
 };
 #define Z_EROFS_ALL_COMPR_ALGS		((1 << Z_EROFS_COMPRESSION_MAX) - 1)
@@ -309,6 +310,12 @@ struct z_erofs_lzma_cfgs {
 
 #define Z_EROFS_LZMA_MAX_DICT_SIZE	(8 * Z_EROFS_PCLUSTER_MAX_SIZE)
 
+/* 6 bytes (+ length field = 8 bytes) */
+struct z_erofs_deflate_cfgs {
+	u8 windowbits;			/* 8..15 for DEFLATE */
+	u8 reserved[5];
+} __packed;
+
 /*
  * bit 0 : COMPACTED_2B indexes (0 - off; 1 - on)
  *  e.g. for 4k logical cluster size,      4B        if compacted 2B is off;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 36e32fa542f0..fb45855cfd5d 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -519,6 +519,26 @@ static inline int z_erofs_load_lzma_config(struct super_block *sb,
 }
 #endif	/* !CONFIG_EROFS_FS_ZIP_LZMA */
 
+#ifdef CONFIG_EROFS_FS_ZIP_DEFLATE
+int __init z_erofs_deflate_init(void);
+void z_erofs_deflate_exit(void);
+int z_erofs_load_deflate_config(struct super_block *sb,
+				struct erofs_super_block *dsb,
+				struct z_erofs_deflate_cfgs *dfl, int size);
+#else
+static inline int z_erofs_deflate_init(void) { return 0; }
+static inline int z_erofs_deflate_exit(void) { return 0; }
+static inline int z_erofs_load_deflate_config(struct super_block *sb,
+			struct erofs_super_block *dsb,
+			struct z_erofs_deflate_cfgs *dfl, int size) {
+	if (dfl) {
+		erofs_err(sb, "deflate algorithm isn't enabled");
+		return -EINVAL;
+	}
+	return 0;
+}
+#endif	/* !CONFIG_EROFS_FS_ZIP_DEFLATE */
+
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 int erofs_fscache_register_fs(struct super_block *sb);
 void erofs_fscache_unregister_fs(struct super_block *sb);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9d6a3c6158bd..832f9fdef712 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -201,6 +201,9 @@ static int erofs_load_compr_cfgs(struct super_block *sb,
 		case Z_EROFS_COMPRESSION_LZMA:
 			ret = z_erofs_load_lzma_config(sb, dsb, data, size);
 			break;
+		case Z_EROFS_COMPRESSION_DEFLATE:
+			ret = z_erofs_load_deflate_config(sb, dsb, data, size);
+			break;
 		default:
 			DBG_BUGON(1);
 			ret = -EFAULT;
@@ -966,6 +969,10 @@ static int __init erofs_module_init(void)
 	if (err)
 		goto lzma_err;
 
+	err = z_erofs_deflate_init();
+	if (err)
+		goto deflate_err;
+
 	erofs_pcpubuf_init();
 	err = z_erofs_init_zip_subsystem();
 	if (err)
@@ -986,6 +993,8 @@ static int __init erofs_module_init(void)
 sysfs_err:
 	z_erofs_exit_zip_subsystem();
 zip_err:
+	z_erofs_deflate_exit();
+deflate_err:
 	z_erofs_lzma_exit();
 lzma_err:
 	erofs_exit_shrinker();
@@ -1003,6 +1012,7 @@ static void __exit erofs_module_exit(void)
 
 	erofs_exit_sysfs();
 	z_erofs_exit_zip_subsystem();
+	z_erofs_deflate_exit();
 	z_erofs_lzma_exit();
 	erofs_exit_shrinker();
 	kmem_cache_destroy(erofs_inode_cachep);
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 1909ddafd9c7..7b55111fd533 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -561,8 +561,9 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 
 	if ((flags & EROFS_GET_BLOCKS_FIEMAP) ||
 	    ((flags & EROFS_GET_BLOCKS_READMORE) &&
-	     map->m_algorithmformat == Z_EROFS_COMPRESSION_LZMA &&
-	     map->m_llen >= i_blocksize(inode))) {
+	     (map->m_algorithmformat == Z_EROFS_COMPRESSION_LZMA ||
+	      map->m_algorithmformat == Z_EROFS_COMPRESSION_DEFLATE) &&
+	      map->m_llen >= i_blocksize(inode))) {
 		err = z_erofs_get_extent_decompressedlen(&m);
 		if (!err)
 			map->m_flags |= EROFS_MAP_FULL_MAPPED;
-- 
2.24.4

