Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0E18BF938
	for <lists+linux-erofs@lfdr.de>; Wed,  8 May 2024 11:04:12 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TT92/7K3;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VZ8Ms5Hrhz3cLk
	for <lists+linux-erofs@lfdr.de>; Wed,  8 May 2024 19:04:09 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TT92/7K3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VZ8Mj4pS8z30WV
	for <linux-erofs@lists.ozlabs.org>; Wed,  8 May 2024 19:03:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715159033; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=SZx+e9wmgw07dwf/9Z1IxqynR9ARV1IJtyL8bffJTYY=;
	b=TT92/7K33wirrFX1qfG9AQ+VxzOd6d18t6uCQt9vjlH60Odf7mHDJnZaWaPPanjZWrpLPRPyKwEdfU8JaXLiv7C2GBSRTp9WV/9wTKZYzd803Nlmd+ITU30Q0TT+StTxjqaqgHGI+1w7ZLANGBwfwOWHf5spNlzGuHjuzG0qXEI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0W638gUY_1715159027;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W638gUY_1715159027)
          by smtp.aliyun-inc.com;
          Wed, 08 May 2024 17:03:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: Zstandard compression support
Date: Wed,  8 May 2024 17:03:46 +0800
Message-Id: <20240508090346.2992116-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add Zstandard compression as the 4th supported algorithm since it
becomes more popular now and some end users have asked this for
quite a while [1][2].

Each EROFS physical cluster contains only one valid standard
Zstandard frame as described in [3] so that decompression can be
performed on a per-pcluster basis independently.

Currently, it just leverages multi-call stream decompression APIs with
internal sliding window buffers.  One-shot or bufferless decompression
could be implemented later for even better performance if needed.

[1] https://github.com/erofs/erofs-utils/issues/6
[2] https://lore.kernel.org/r/Y08h+z6CZdnS1XBm@B-P7TQMD6M-0146.lan
[3] https://www.rfc-editor.org/rfc/rfc8478.txt
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/Kconfig             |  15 ++
 fs/erofs/Makefile            |   1 +
 fs/erofs/compress.h          |   4 +
 fs/erofs/decompressor.c      |   7 +
 fs/erofs/decompressor_zstd.c | 279 +++++++++++++++++++++++++++++++++++
 fs/erofs/erofs_fs.h          |  10 ++
 fs/erofs/internal.h          |   8 +
 fs/erofs/super.c             |   7 +
 8 files changed, 331 insertions(+)
 create mode 100644 fs/erofs/decompressor_zstd.c

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index fffd3919343e..7dcdce660cac 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -112,6 +112,21 @@ config EROFS_FS_ZIP_DEFLATE
 
 	  If unsure, say N.
 
+config EROFS_FS_ZIP_ZSTD
+	bool "EROFS Zstandard compressed data support"
+	depends on EROFS_FS_ZIP
+	select ZSTD_DECOMPRESS
+	help
+	  Saying Y here includes support for reading EROFS file systems
+	  containing Zstandard compressed data.  It gives better compression
+	  ratios than the default LZ4 format, while it costs more CPU
+	  overhead.
+
+	  Zstandard support is an experimental feature for now and so most
+	  file systems will be readable without selecting this option.
+
+	  If unsure, say N.
+
 config EROFS_FS_ONDEMAND
 	bool "EROFS fscache-based on-demand read support"
 	depends on EROFS_FS
diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 20d1ec422443..097d672e6b14 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -6,4 +6,5 @@ erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
 erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o zutil.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
 erofs-$(CONFIG_EROFS_FS_ZIP_DEFLATE) += decompressor_deflate.o
+erofs-$(CONFIG_EROFS_FS_ZIP_ZSTD) += decompressor_zstd.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 333587ba6183..19d53c30c8af 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -90,8 +90,12 @@ int z_erofs_load_lzma_config(struct super_block *sb,
 			struct erofs_super_block *dsb, void *data, int size);
 int z_erofs_load_deflate_config(struct super_block *sb,
 			struct erofs_super_block *dsb, void *data, int size);
+int z_erofs_load_zstd_config(struct super_block *sb,
+			struct erofs_super_block *dsb, void *data, int size);
 int z_erofs_lzma_decompress(struct z_erofs_decompress_req *rq,
 			    struct page **pagepool);
 int z_erofs_deflate_decompress(struct z_erofs_decompress_req *rq,
 			       struct page **pagepool);
+int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
+			    struct page **pgpl);
 #endif
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index d2fe8130819e..9d85b6c11c6b 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -399,6 +399,13 @@ const struct z_erofs_decompressor erofs_decompressors[] = {
 		.name = "deflate"
 	},
 #endif
+#ifdef CONFIG_EROFS_FS_ZIP_ZSTD
+	[Z_EROFS_COMPRESSION_ZSTD] = {
+		.config = z_erofs_load_zstd_config,
+		.decompress = z_erofs_zstd_decompress,
+		.name = "zstd"
+	},
+#endif
 };
 
 int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
diff --git a/fs/erofs/decompressor_zstd.c b/fs/erofs/decompressor_zstd.c
new file mode 100644
index 000000000000..24279511db3b
--- /dev/null
+++ b/fs/erofs/decompressor_zstd.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/zstd.h>
+#include "compress.h"
+
+struct z_erofs_zstd {
+	struct z_erofs_zstd *next;
+	u8 bounce[PAGE_SIZE];
+	void *wksp;
+	unsigned int wkspsz;
+};
+
+static DEFINE_SPINLOCK(z_erofs_zstd_lock);
+static unsigned int z_erofs_zstd_max_dictsize;
+static unsigned int z_erofs_zstd_nstrms, z_erofs_zstd_avail_strms;
+static struct z_erofs_zstd *z_erofs_zstd_head;
+static DECLARE_WAIT_QUEUE_HEAD(z_erofs_zstd_wq);
+
+module_param_named(zstd_streams, z_erofs_zstd_nstrms, uint, 0444);
+
+static struct z_erofs_zstd *z_erofs_isolate_strms(bool all)
+{
+	struct z_erofs_zstd *strm;
+
+again:
+	spin_lock(&z_erofs_zstd_lock);
+	strm = z_erofs_zstd_head;
+	if (!strm) {
+		spin_unlock(&z_erofs_zstd_lock);
+		wait_event(z_erofs_zstd_wq, READ_ONCE(z_erofs_zstd_head));
+		goto again;
+	}
+	z_erofs_zstd_head = all ? NULL : strm->next;
+	spin_unlock(&z_erofs_zstd_lock);
+	return strm;
+}
+
+void z_erofs_zstd_exit(void)
+{
+	while (z_erofs_zstd_avail_strms) {
+		struct z_erofs_zstd *strm, *n;
+
+		for (strm = z_erofs_isolate_strms(true); strm; strm = n) {
+			n = strm->next;
+
+			kvfree(strm->wksp);
+			kfree(strm);
+			--z_erofs_zstd_avail_strms;
+		}
+	}
+}
+
+int __init z_erofs_zstd_init(void)
+{
+	/* by default, use # of possible CPUs instead */
+	if (!z_erofs_zstd_nstrms)
+		z_erofs_zstd_nstrms = num_possible_cpus();
+
+	for (; z_erofs_zstd_avail_strms < z_erofs_zstd_nstrms;
+	     ++z_erofs_zstd_avail_strms) {
+		struct z_erofs_zstd *strm;
+
+		strm = kzalloc(sizeof(*strm), GFP_KERNEL);
+		if (!strm) {
+			z_erofs_zstd_exit();
+			return -ENOMEM;
+		}
+		spin_lock(&z_erofs_zstd_lock);
+		strm->next = z_erofs_zstd_head;
+		z_erofs_zstd_head = strm;
+		spin_unlock(&z_erofs_zstd_lock);
+	}
+	return 0;
+}
+
+int z_erofs_load_zstd_config(struct super_block *sb,
+			struct erofs_super_block *dsb, void *data, int size)
+{
+	static DEFINE_MUTEX(zstd_resize_mutex);
+	struct z_erofs_zstd_cfgs *zstd = data;
+	unsigned int dict_size, wkspsz;
+	struct z_erofs_zstd *strm, *head = NULL;
+	void *wksp;
+
+	if (!zstd || size < sizeof(struct z_erofs_zstd_cfgs) || zstd->format) {
+		erofs_err(sb, "unsupported zstd format, size=%u", size);
+		return -EINVAL;
+	}
+
+	if (zstd->windowlog > ilog2(Z_EROFS_ZSTD_MAX_DICT_SIZE) - 10) {
+		erofs_err(sb, "unsupported zstd dictionary size %u", dict_size);
+		return -EINVAL;
+	}
+	dict_size = 1U << (zstd->windowlog + 10);
+
+	/* in case 2 z_erofs_load_zstd_config() race to avoid deadlock */
+	mutex_lock(&zstd_resize_mutex);
+	if (z_erofs_zstd_max_dictsize >= dict_size) {
+		mutex_unlock(&zstd_resize_mutex);
+		return 0;
+	}
+
+	/* 1. collect/isolate all streams for the following check */
+	while (z_erofs_zstd_avail_strms) {
+		struct z_erofs_zstd *n;
+
+		for (strm = z_erofs_isolate_strms(true); strm; strm = n) {
+			n = strm->next;
+			strm->next = head;
+			head = strm;
+			--z_erofs_zstd_avail_strms;
+		}
+	}
+
+	/* 2. walk each isolated stream and grow max dict_size if needed */
+	wkspsz = zstd_dstream_workspace_bound(dict_size);
+	for (strm = head; strm; strm = strm->next) {
+		wksp = kvmalloc(wkspsz, GFP_KERNEL);
+		if (!wksp)
+			break;
+		kvfree(strm->wksp);
+		strm->wksp = wksp;
+		strm->wkspsz = wkspsz;
+	}
+
+	/* 3. push back all to the global list and update max dict_size */
+	spin_lock(&z_erofs_zstd_lock);
+	DBG_BUGON(z_erofs_zstd_head);
+	z_erofs_zstd_head = head;
+	spin_unlock(&z_erofs_zstd_lock);
+	z_erofs_zstd_avail_strms = z_erofs_zstd_nstrms;
+	wake_up_all(&z_erofs_zstd_wq);
+	if (!strm)
+		z_erofs_zstd_max_dictsize = dict_size;
+	mutex_unlock(&zstd_resize_mutex);
+	return strm ? -ENOMEM : 0;
+}
+
+int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
+			    struct page **pgpl)
+{
+	const unsigned int nrpages_out =
+		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
+	const unsigned int nrpages_in =
+		PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT;
+	zstd_dstream *stream;
+	struct super_block *sb = rq->sb;
+	unsigned int insz, outsz, pofs;
+	struct z_erofs_zstd *strm;
+	zstd_in_buffer in_buf = { NULL, 0, 0 };
+	zstd_out_buffer out_buf = { NULL, 0, 0 };
+	u8 *kin, *kout = NULL;
+	bool bounced = false;
+	int no = -1, ni = 0, j = 0, zerr, err;
+
+	/* 1. get the exact compressed size */
+	kin = kmap_local_page(*rq->in);
+	err = z_erofs_fixup_insize(rq, kin + rq->pageofs_in,
+			min_t(unsigned int, rq->inputsize,
+			      sb->s_blocksize - rq->pageofs_in));
+	if (err) {
+		kunmap_local(kin);
+		return err;
+	}
+
+	/* 2. get an available ZSTD context */
+	strm = z_erofs_isolate_strms(false);
+
+	/* 3. multi-call decompress */
+	insz = rq->inputsize;
+	outsz = rq->outputsize;
+	stream = zstd_init_dstream(z_erofs_zstd_max_dictsize, strm->wksp, strm->wkspsz);
+	if (!stream) {
+		err = -EIO;
+		goto failed_zinit;
+	}
+
+	pofs = rq->pageofs_out;
+	in_buf.size = min_t(u32, insz, PAGE_SIZE - rq->pageofs_in);
+	insz -= in_buf.size;
+	in_buf.src = kin + rq->pageofs_in;
+	do {
+		if (out_buf.size == out_buf.pos) {
+			if (++no >= nrpages_out || !outsz) {
+				erofs_err(sb, "insufficient space for decompressed data");
+				err = -EFSCORRUPTED;
+				break;
+			}
+
+			if (kout)
+				kunmap_local(kout);
+			out_buf.size = min_t(u32, outsz, PAGE_SIZE - pofs);
+			outsz -= out_buf.size;
+			if (!rq->out[no]) {
+				rq->out[no] = erofs_allocpage(pgpl, rq->gfp);
+				if (!rq->out[no]) {
+					kout = NULL;
+					err = -ENOMEM;
+					break;
+				}
+				set_page_private(rq->out[no],
+						 Z_EROFS_SHORTLIVED_PAGE);
+			}
+			kout = kmap_local_page(rq->out[no]);
+			out_buf.dst = kout + pofs;
+			out_buf.pos = 0;
+			pofs = 0;
+		}
+
+		if (in_buf.size == in_buf.pos && insz) {
+			if (++ni >= nrpages_in) {
+				erofs_err(sb, "invalid compressed data");
+				err = -EFSCORRUPTED;
+				break;
+			}
+
+			if (kout) /* unlike kmap(), take care of the orders */
+				kunmap_local(kout);
+			kunmap_local(kin);
+			in_buf.size = min_t(u32, insz, PAGE_SIZE);
+			insz -= in_buf.size;
+			kin = kmap_local_page(rq->in[ni]);
+			in_buf.src = kin;
+			in_buf.pos = 0;
+			bounced = false;
+			if (kout) {
+				j = (u8 *)out_buf.dst - kout;
+				kout = kmap_local_page(rq->out[no]);
+				out_buf.dst = kout + j;
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
+			memcpy(strm->bounce, in_buf.src, in_buf.size);
+			in_buf.src = strm->bounce;
+			bounced = true;
+		}
+
+		for (j = ni + 1; j < nrpages_in; ++j) {
+			struct page *tmppage;
+
+			if (rq->out[no] != rq->in[j])
+				continue;
+			tmppage = erofs_allocpage(pgpl, rq->gfp);
+			if (!tmppage) {
+				err = -ENOMEM;
+				goto failed;
+			}
+			set_page_private(tmppage, Z_EROFS_SHORTLIVED_PAGE);
+			copy_highpage(tmppage, rq->in[j]);
+			rq->in[j] = tmppage;
+		}
+		zerr = zstd_decompress_stream(stream, &out_buf, &in_buf);
+		if (zstd_is_error(zerr) || (!zerr && outsz)) {
+			erofs_err(sb, "failed to decompress in[%u] out[%u]: %s",
+				  rq->inputsize, rq->outputsize,
+				  zerr ? zstd_get_error_name(zerr) : "unexpected end of stream");
+			err = -EFSCORRUPTED;
+			break;
+		}
+	} while (outsz || out_buf.pos < out_buf.size);
+failed:
+	if (kout)
+		kunmap_local(kout);
+failed_zinit:
+	kunmap_local(kin);
+	/* 4. push back ZSTD stream context to the global list */
+	spin_lock(&z_erofs_zstd_lock);
+	strm->next = z_erofs_zstd_head;
+	z_erofs_zstd_head = strm;
+	spin_unlock(&z_erofs_zstd_lock);
+	wake_up(&z_erofs_zstd_wq);
+	return err;
+}
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index a03ec70ba6f2..4bc11602aac8 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -296,6 +296,7 @@ enum {
 	Z_EROFS_COMPRESSION_LZ4		= 0,
 	Z_EROFS_COMPRESSION_LZMA	= 1,
 	Z_EROFS_COMPRESSION_DEFLATE	= 2,
+	Z_EROFS_COMPRESSION_ZSTD	= 3,
 	Z_EROFS_COMPRESSION_MAX
 };
 #define Z_EROFS_ALL_COMPR_ALGS		((1 << Z_EROFS_COMPRESSION_MAX) - 1)
@@ -322,6 +323,15 @@ struct z_erofs_deflate_cfgs {
 	u8 reserved[5];
 } __packed;
 
+/* 6 bytes (+ length field = 8 bytes) */
+struct z_erofs_zstd_cfgs {
+	u8 format;
+	u8 windowlog;           /* windowLog - ZSTD_WINDOWLOG_ABSOLUTEMIN(10) */
+	u8 reserved[4];
+} __packed;
+
+#define Z_EROFS_ZSTD_MAX_DICT_SIZE      Z_EROFS_PCLUSTER_MAX_SIZE
+
 /*
  * bit 0 : COMPACTED_2B indexes (0 - off; 1 - on)
  *  e.g. for 4k logical cluster size,      4B        if compacted 2B is off;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 63891d90e4b1..14988da62856 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -502,6 +502,14 @@ static inline int z_erofs_deflate_init(void) { return 0; }
 static inline int z_erofs_deflate_exit(void) { return 0; }
 #endif	/* !CONFIG_EROFS_FS_ZIP_DEFLATE */
 
+#ifdef CONFIG_EROFS_FS_ZIP_ZSTD
+int __init z_erofs_zstd_init(void);
+void z_erofs_zstd_exit(void);
+#else
+static inline int z_erofs_zstd_init(void) { return 0; }
+static inline int z_erofs_zstd_exit(void) { return 0; }
+#endif	/* !CONFIG_EROFS_FS_ZIP_ZSTD */
+
 #ifdef CONFIG_EROFS_FS_ONDEMAND
 int erofs_fscache_register_fs(struct super_block *sb);
 void erofs_fscache_unregister_fs(struct super_block *sb);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index e9ab554c8471..e9bd1eee7b02 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -857,6 +857,10 @@ static int __init erofs_module_init(void)
 	if (err)
 		goto deflate_err;
 
+	err = z_erofs_zstd_init();
+	if (err)
+		goto zstd_err;
+
 	err = z_erofs_gbuf_init();
 	if (err)
 		goto gbuf_err;
@@ -882,6 +886,8 @@ static int __init erofs_module_init(void)
 zip_err:
 	z_erofs_gbuf_exit();
 gbuf_err:
+	z_erofs_zstd_exit();
+zstd_err:
 	z_erofs_deflate_exit();
 deflate_err:
 	z_erofs_lzma_exit();
@@ -901,6 +907,7 @@ static void __exit erofs_module_exit(void)
 
 	erofs_exit_sysfs();
 	z_erofs_exit_zip_subsystem();
+	z_erofs_zstd_exit();
 	z_erofs_deflate_exit();
 	z_erofs_lzma_exit();
 	erofs_exit_shrinker();
-- 
2.39.3

