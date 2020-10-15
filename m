Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A59028F384
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Oct 2020 15:41:35 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CBr6N219CzDqWx
	for <lists+linux-erofs@lfdr.de>; Fri, 16 Oct 2020 00:41:32 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::642;
 helo=mail-pl1-x642.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=UDaq0eYI; dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CBr573YtyzDqQr
 for <linux-erofs@lists.ozlabs.org>; Fri, 16 Oct 2020 00:40:27 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id p11so1652734pld.5
 for <linux-erofs@lists.ozlabs.org>; Thu, 15 Oct 2020 06:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=S97EsKR2pOn6ygli/IPSE8zdzC0t3nT2o0G8DB2rd/E=;
 b=UDaq0eYIJHNGgOg0M5/J2HJ6iyIQDsAqNRSz0Y1OWi/U+9BMwEcEP2DwVTMEIagAZb
 dlk/3LXR4biQ6ATN1awschGv7MT1PPQ1USsG96VlFjZM+4oWArpGkC9tuXEVNn7lD4Mx
 230BEbJerKG62L6X13J0yoUfeoYq/Bzqo5iBQaFv1mBKgoq4iDJAGw3yQh7ye2qA3I81
 RyMK20Wj3PDxpA0qQcWDWmBBiBz+3oMytqvPk8ERPPlPX2Db7ptTZWjp1yhotMFOFwB4
 Z1MWei/VQZBpDmSp+bEwwFtAIzdnFvQg7AfMv/NireTk0K9u3ppGafsEwTnqN91B+CEr
 Ep2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=S97EsKR2pOn6ygli/IPSE8zdzC0t3nT2o0G8DB2rd/E=;
 b=rNP/1i480RB4PEmQbFNRBtfjpH3EVOgHWSVL6Q57Jh7UY8T5CP3i20JEzyFla+UdMp
 J+aQ0Jc+rJalt4U2qnBz1dKpQGn5Tj8+apVKjGlL5cj/HKyQS293urMkCXX2NamW863u
 apjwxcWAyTrgbU7miFjPy1/jhJqcYhM5BCAR9iITEGtyGMQZLWiemkVYODMCgqdGz081
 /fFLMFhI6UyMfH8DbzwrV5tiahCGZhLQ/sweHAQEuo4icl3LpgoiUiWOeXcoubsmrdX5
 mEJVDWi5B3H80Ys0ZQ8+eIJK4Unp/WVLrd8b/yhj4hLnqcKyfJBQRshMkZf1zqFPfwP1
 mICA==
X-Gm-Message-State: AOAM5328xGLrEfmZvI5c70oX/4k23gcnCO+G88pY6f2IUG4G1JBDlk6a
 W4xhenfx9fspvkVazCQf2x3oycoqzr5pEfEF
X-Google-Smtp-Source: ABdhPJynKUCv02pJ7JnuHdyHvf8urU0Itg5czW0f/zkdBWKS3/2X/mxrOHOeWGlO++8NYIaNMeQfVQ==
X-Received: by 2002:a17:90b:1215:: with SMTP id
 gl21mr4139104pjb.132.1602769223524; 
 Thu, 15 Oct 2020 06:40:23 -0700 (PDT)
Received: from localhost.localdomain (69-172-89-151.static.imsbiz.com.
 [69.172.89.151])
 by smtp.gmail.com with ESMTPSA id a19sm3426058pjq.29.2020.10.15.06.40.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 06:40:22 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
X-Google-Original-From: Huang Jianan <huangjianan@oppo.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 5/5] erofs-utils: support read compressed file
Date: Thu, 15 Oct 2020 21:39:59 +0800
Message-Id: <20201015133959.61007-5-huangjianan@oppo.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201015133959.61007-1-huangjianan@oppo.com>
References: <20201015133959.61007-1-huangjianan@oppo.com>
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
Cc: guoweichao@oppo.com, zhangshiming@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
---
 fuse/Makefile.am         |   8 +-
 fuse/decompress.c        |  86 ++++++++
 fuse/decompress.h        |  37 ++++
 fuse/dentry.h            |   5 +-
 fuse/init.c              |  22 ++-
 fuse/init.h              |   2 +
 fuse/namei.c             |  11 +-
 fuse/read.c              |  71 ++++++-
 fuse/zmap.c              | 416 +++++++++++++++++++++++++++++++++++++++
 include/erofs/defs.h     |  13 ++
 include/erofs/internal.h |  43 +++-
 include/erofs_fs.h       |   4 +
 12 files changed, 710 insertions(+), 8 deletions(-)
 create mode 100644 fuse/decompress.c
 create mode 100644 fuse/decompress.h
 create mode 100644 fuse/zmap.c

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index fffd67a..052c716 100644
--- a/fuse/Makefile.am
+++ b/fuse/Makefile.am
@@ -3,12 +3,16 @@
 
 AUTOMAKE_OPTIONS = foreign
 bin_PROGRAMS     = erofsfuse
-erofsfuse_SOURCES = main.c dentry.c getattr.c logging.c namei.c read.c disk_io.c init.c open.c readir.c
+erofsfuse_SOURCES = main.c dentry.c getattr.c logging.c namei.c read.c disk_io.c init.c open.c readir.c zmap.c
+if ENABLE_LZ4
+erofsfuse_SOURCES += decompress.c
+endif
 erofsfuse_CFLAGS = -Wall -Werror -Wextra \
+                   -Wno-implicit-fallthrough \
                    -I$(top_srcdir)/include \
                    $(shell pkg-config fuse --cflags) \
                    -DFUSE_USE_VERSION=26 \
                    -std=gnu99
 LDFLAGS += $(shell pkg-config fuse --libs)
-erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la -ldl
+erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la -ldl ${LZ4_LIBS}
 
diff --git a/fuse/decompress.c b/fuse/decompress.c
new file mode 100644
index 0000000..e2df3ce
--- /dev/null
+++ b/fuse/decompress.c
@@ -0,0 +1,86 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
+ * Created by Huang Jianan <huangjianan@oppo.com>
+ */
+
+#include <stdlib.h>
+#include <lz4.h>
+
+#include "erofs/internal.h"
+#include "erofs/err.h"
+#include "decompress.h"
+#include "logging.h"
+#include "init.h"
+
+static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq)
+{
+	char *dest = rq->out + rq->ofs_out;
+	char *src = rq->in + rq->ofs_head;
+
+	memcpy(dest, src, rq->outputsize - rq->ofs_head);
+
+	return 0;
+}
+
+static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq)
+{
+	int ret = 0;
+	char *dest = rq->out + rq->ofs_out;
+	char *src = rq->in;
+	char *buff = NULL;
+	bool support_0padding = false;
+	unsigned int inputmargin = 0;
+
+	if (sbk->feature_incompat & EROFS_FEATURE_INCOMPAT_LZ4_0PADDING) {
+		support_0padding = true;
+
+		while (!src[inputmargin & ~PAGE_MASK])
+			if (!(++inputmargin & ~PAGE_MASK))
+				break;
+
+		if (inputmargin >= rq->inputsize)
+			return -EIO;
+	}
+
+	if (rq->ofs_head) {
+		buff = malloc(rq->outputsize);
+		if (!buff)
+			return -ENOMEM;
+		dest = buff;
+	}
+
+	if (rq->partial_decoding || !support_0padding)
+		ret = LZ4_decompress_safe_partial(src + inputmargin, dest,
+						  rq->inputsize - inputmargin,
+						  rq->outputsize, rq->outputsize);
+	else
+		ret = LZ4_decompress_safe(src + inputmargin, dest,
+					  rq->inputsize - inputmargin,
+					  rq->outputsize);
+
+	if (ret != (int)rq->outputsize) {
+		ret = -EIO;
+		goto out;
+	}
+
+	if (rq->ofs_head) {
+		src = dest + rq->ofs_head;
+		dest = rq->out + rq->ofs_out;
+		memcpy(dest, src, rq->outputsize - rq->ofs_head);
+	}
+
+out:
+	if (buff)
+		free(buff);
+
+	return ret;
+}
+
+int z_erofs_decompress(struct z_erofs_decompress_req *rq)
+{
+	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED)
+		return z_erofs_shifted_transform(rq);
+
+	return z_erofs_decompress_generic(rq);
+}
diff --git a/fuse/decompress.h b/fuse/decompress.h
new file mode 100644
index 0000000..cd395c3
--- /dev/null
+++ b/fuse/decompress.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C), 2008-2020, OPPO Mobile Comm Corp., Ltd.
+ * Created by Huang Jianan <huangjianan@oppo.com>
+ */
+
+#ifndef __EROFS_DECOMPRESS_H
+#define __EROFS_DECOMPRESS_H
+
+#include "erofs/internal.h"
+
+enum {
+	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
+	Z_EROFS_COMPRESSION_RUNTIME_MAX
+};
+
+struct z_erofs_decompress_req {
+	char *in, *out;
+
+	size_t ofs_out, ofs_head;
+	unsigned int inputsize, outputsize;
+
+	/* indicate the algorithm will be used for decompression */
+	unsigned int alg;
+	bool partial_decoding;
+};
+
+#ifdef LZ4_ENABLED
+int z_erofs_decompress(struct z_erofs_decompress_req *rq);
+#else
+int z_erofs_decompress(struct z_erofs_decompress_req *rq)
+{
+	return -EOPNOTSUPP;
+}
+#endif
+
+#endif
diff --git a/fuse/dentry.h b/fuse/dentry.h
index ee2144d..f89c506 100644
--- a/fuse/dentry.h
+++ b/fuse/dentry.h
@@ -10,10 +10,11 @@
 #include <stdint.h>
 #include "erofs/internal.h"
 
+/* fixme: Deal with names that exceed the allocated size */
 #ifdef __64BITS
-#define DCACHE_ENTRY_NAME_LEN       40
+#define DCACHE_ENTRY_NAME_LEN       EROFS_NAME_LEN
 #else
-#define DCACHE_ENTRY_NAME_LEN       48
+#define DCACHE_ENTRY_NAME_LEN       EROFS_NAME_LEN
 #endif
 
 /* This struct declares a node of a k-tree.  Every node has a pointer to one of
diff --git a/fuse/init.c b/fuse/init.c
index 8198fa7..e9cc9f8 100644
--- a/fuse/init.c
+++ b/fuse/init.c
@@ -17,7 +17,23 @@
 
 
 struct erofs_super_block super;
-static struct erofs_super_block *sbk = &super;
+struct erofs_super_block *sbk = &super;
+
+static bool check_layout_compatibility(struct erofs_super_block *sb,
+				       struct erofs_super_block *dsb)
+{
+	const unsigned int feature = le32_to_cpu(dsb->feature_incompat);
+
+	sb->feature_incompat = feature;
+
+	/* check if current kernel meets all mandatory requirements */
+	if (feature & (~EROFS_ALL_FEATURE_INCOMPAT)) {
+		loge("unidentified incompatible feature %x, please upgrade kernel version",
+		     feature & ~EROFS_ALL_FEATURE_INCOMPAT);
+		return false;
+	}
+	return true;
+}
 
 int erofs_init_super(void)
 {
@@ -40,6 +56,9 @@ int erofs_init_super(void)
 		return -EINVAL;
 	}
 
+	if (!check_layout_compatibility(sbk, sb))
+		return -EINVAL;
+
 	sbk->checksum = le32_to_cpu(sb->checksum);
 	sbk->feature_compat = le32_to_cpu(sb->feature_compat);
 	sbk->blkszbits = sb->blkszbits;
@@ -56,6 +75,7 @@ int erofs_init_super(void)
 	sbk->root_nid = le16_to_cpu(sb->root_nid);
 
 	logp("%-15s:0x%X", STR(magic), SUPER_MEM(magic));
+	logp("%-15s:0x%X", STR(feature_incompat), SUPER_MEM(feature_incompat));
 	logp("%-15s:0x%X", STR(feature_compat), SUPER_MEM(feature_compat));
 	logp("%-15s:%u",   STR(blkszbits), SUPER_MEM(blkszbits));
 	logp("%-15s:%u",   STR(root_nid), SUPER_MEM(root_nid));
diff --git a/fuse/init.h b/fuse/init.h
index d7a97b5..3fc4eb5 100644
--- a/fuse/init.h
+++ b/fuse/init.h
@@ -13,6 +13,8 @@
 
 #define BOOT_SECTOR_SIZE	0x400
 
+extern struct erofs_super_block *sbk;
+
 int erofs_init_super(void);
 erofs_nid_t erofs_get_root_nid(void);
 erofs_off_t nid2addr(erofs_nid_t nid);
diff --git a/fuse/namei.c b/fuse/namei.c
index 7ed1168..510fcfd 100644
--- a/fuse/namei.c
+++ b/fuse/namei.c
@@ -49,7 +49,7 @@ static inline dev_t new_decode_dev(u32 dev)
 
 int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 {
-	int ret;
+	int ret, ifmt;
 	char buf[EROFS_BLKSIZ];
 	struct erofs_inode_compact *v1;
 	const erofs_off_t addr = nid2addr(nid);
@@ -60,6 +60,11 @@ int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 		return -EIO;
 
 	v1 = (struct erofs_inode_compact *)buf;
+	/* fixme: support extended inode */
+	ifmt = le16_to_cpu(v1->i_format);
+	if (__inode_version(ifmt) != EROFS_INODE_LAYOUT_COMPACT)
+		return -EOPNOTSUPP;
+
 	vi->datalayout = __inode_data_mapping(le16_to_cpu(v1->i_format));
 	vi->inode_isize = sizeof(struct erofs_inode_compact);
 	vi->xattr_isize = erofs_xattr_ibody_size(v1->i_xattr_icount);
@@ -88,6 +93,10 @@ int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 		return -EIO;
 	}
 
+	vi->z_inited = false;
+	if (erofs_inode_is_data_compressed(vi->datalayout))
+		z_erofs_fill_inode(vi);
+
 	return 0;
 }
 
diff --git a/fuse/read.c b/fuse/read.c
index 3ce5c4f..cc0781f 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -16,6 +16,7 @@
 #include "namei.h"
 #include "disk_io.h"
 #include "init.h"
+#include "decompress.h"
 
 size_t erofs_read_data(struct erofs_vnode *vnode, char *buffer,
 		       size_t size, off_t offset)
@@ -78,6 +79,73 @@ finished:
 
 }
 
+size_t erofs_read_data_compression(struct erofs_vnode *vnode, char *buffer,
+		       size_t size, off_t offset)
+{
+	int ret;
+	size_t end, count, ofs, sum = size;
+	struct erofs_map_blocks map = {
+		.index = UINT_MAX,
+	};
+	bool partial;
+	unsigned int algorithmformat;
+	char raw[EROFS_BLKSIZ];
+
+	while (sum) {
+		end = offset + sum;
+		map.m_la = end - 1;
+
+		ret = z_erofs_map_blocks_iter(vnode, &map);
+		if (ret)
+			return ret;
+
+		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+			sum -= map.m_llen;
+			continue;
+		}
+
+		ret = dev_read(raw, EROFS_BLKSIZ, map.m_pa);
+		if (ret < 0 || (size_t)ret != EROFS_BLKSIZ)
+			return -EIO;
+
+		algorithmformat = map.m_flags & EROFS_MAP_ZIPPED ?
+						Z_EROFS_COMPRESSION_LZ4 :
+						Z_EROFS_COMPRESSION_SHIFTED;
+
+		if (end >= map.m_la + map.m_llen) {
+			count = map.m_llen;
+			partial = !(map.m_flags & EROFS_MAP_FULL_MAPPED);
+		} else {
+			count = end - map.m_la;
+			partial = true;
+		}
+
+		if ((off_t)map.m_la < offset) {
+			ofs = offset - map.m_la;
+			sum = 0;
+		} else {
+			ofs = 0;
+			sum -= count;
+		}
+
+		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
+					.in = raw,
+					.out = buffer,
+					.ofs_out = sum,
+					.ofs_head = ofs,
+					.inputsize = EROFS_BLKSIZ,
+					.outputsize = count,
+					.alg = algorithmformat,
+					.partial_decoding = partial
+					 });
+		if (ret < 0)
+			return ret;
+	}
+
+	logi("nid:%u size=%zd offset=%llu done",
+	     vnode->nid, size, (long long)offset);
+	return size;
+}
 
 int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 	       struct fuse_file_info *fi)
@@ -107,7 +175,8 @@ int erofs_read(const char *path, char *buffer, size_t size, off_t offset,
 
 	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
 	case EROFS_INODE_FLAT_COMPRESSION:
-		/* Fixme: */
+		return erofs_read_data_compression(&v, buffer, size, offset);
+
 	default:
 		return -EINVAL;
 	}
diff --git a/fuse/zmap.c b/fuse/zmap.c
new file mode 100644
index 0000000..022ca1b
--- /dev/null
+++ b/fuse/zmap.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Many parts of codes are copied from Linux kernel/fs/erofs.
+ *
+ * Copyright (C) 2018-2019 HUAWEI, Inc.
+ *             https://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ * Modified by Huang Jianan <huangjianan@oppo.com>
+ */
+
+#include "init.h"
+#include "disk_io.h"
+#include "logging.h"
+
+int z_erofs_fill_inode(struct erofs_vnode *vi)
+{
+	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
+		vi->z_advise = 0;
+		vi->z_algorithmtype[0] = 0;
+		vi->z_algorithmtype[1] = 0;
+		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
+		vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits;
+		vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits;
+		vi->z_inited = true;
+	}
+
+	return 0;
+}
+
+static int z_erofs_fill_inode_lazy(struct erofs_vnode *vi)
+{
+	int ret;
+	erofs_off_t pos;
+	struct z_erofs_map_header *h;
+	char buf[8];
+
+	if (vi->z_inited)
+		return 0;
+
+	DBG_BUGON(vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
+
+	pos = round_up(nid2addr(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
+
+	ret = dev_read(buf, 8, pos);
+	if (ret < 0 && (uint32_t)ret != 8)
+		return -EIO;
+
+	h = (struct z_erofs_map_header *)buf;
+	vi->z_advise = le16_to_cpu(h->h_advise);
+	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
+	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
+
+	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
+		loge("unknown compression format %u for nid %llu",
+		     vi->z_algorithmtype[0], vi->nid);
+		return -EOPNOTSUPP;
+	}
+
+	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
+	vi->z_physical_clusterbits[0] = vi->z_logical_clusterbits +
+					((h->h_clusterbits >> 3) & 3);
+
+	if (vi->z_physical_clusterbits[0] != LOG_BLOCK_SIZE) {
+		loge("unsupported physical clusterbits %u for nid %llu",
+		     vi->z_physical_clusterbits[0], vi->nid);
+		return -EOPNOTSUPP;
+	}
+
+	vi->z_physical_clusterbits[1] = vi->z_logical_clusterbits +
+					((h->h_clusterbits >> 5) & 7);
+	vi->z_inited = true;
+
+	return 0;
+}
+
+struct z_erofs_maprecorder {
+	struct erofs_vnode *vnode;
+	struct erofs_map_blocks *map;
+	void *kaddr;
+
+	unsigned long lcn;
+	/* compression extent information gathered */
+	u8  type;
+	u16 clusterofs;
+	u16 delta[2];
+	erofs_blk_t pblk;
+};
+
+static int z_erofs_reload_indexes(struct z_erofs_maprecorder *m,
+				  erofs_blk_t eblk)
+{
+	int ret;
+	struct erofs_map_blocks *const map = m->map;
+	char *mpage = map->mpage;
+
+	if (map->index == eblk)
+		return 0;
+
+	ret = dev_read(mpage, EROFS_BLKSIZ, blknr_to_addr(eblk));
+	if (ret < 0 && (uint32_t)ret != EROFS_BLKSIZ)
+		return -EIO;
+
+	map->index = eblk;
+
+	return 0;
+}
+
+static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
+					 unsigned long lcn)
+{
+	struct erofs_vnode *const vi = m->vnode;
+	const erofs_off_t ibase = nid2addr(vi->nid);
+	const erofs_off_t pos =
+		Z_EROFS_VLE_LEGACY_INDEX_ALIGN(ibase + vi->inode_isize +
+					       vi->xattr_isize) +
+		lcn * sizeof(struct z_erofs_vle_decompressed_index);
+	struct z_erofs_vle_decompressed_index *di;
+	unsigned int advise, type;
+	int err;
+
+	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
+	if (err)
+		return err;
+
+	m->lcn = lcn;
+	di = m->kaddr + erofs_blkoff(pos);
+
+	advise = le16_to_cpu(di->di_advise);
+	type = (advise >> Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT) &
+		((1 << Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) - 1);
+	switch (type) {
+	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		m->clusterofs = 1 << vi->z_logical_clusterbits;
+		m->delta[0] = le16_to_cpu(di->di_u.delta[0]);
+		m->delta[1] = le16_to_cpu(di->di_u.delta[1]);
+		break;
+	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+		m->clusterofs = le16_to_cpu(di->di_clusterofs);
+		m->pblk = le32_to_cpu(di->di_u.blkaddr);
+		break;
+	default:
+		DBG_BUGON(1);
+		return -EOPNOTSUPP;
+	}
+	m->type = type;
+	return 0;
+}
+
+static unsigned int decode_compactedbits(unsigned int lobits,
+					 unsigned int lomask,
+					 u8 *in, unsigned int pos, u8 *type)
+{
+	const unsigned int v = get_unaligned_le32(in + pos / 8) >> (pos & 7);
+	const unsigned int lo = v & lomask;
+
+	*type = (v >> lobits) & 3;
+	return lo;
+}
+
+static int unpack_compacted_index(struct z_erofs_maprecorder *m,
+				  unsigned int amortizedshift,
+				  unsigned int eofs)
+{
+	struct erofs_vnode *const vi = m->vnode;
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	const unsigned int lomask = (1 << lclusterbits) - 1;
+	unsigned int vcnt, base, lo, encodebits, nblk;
+	int i;
+	u8 *in, type;
+
+	if (1 << amortizedshift == 4)
+		vcnt = 2;
+	else if (1 << amortizedshift == 2 && lclusterbits == 12)
+		vcnt = 16;
+	else
+		return -EOPNOTSUPP;
+
+	encodebits = ((vcnt << amortizedshift) - sizeof(__le32)) * 8 / vcnt;
+	base = round_down(eofs, vcnt << amortizedshift);
+	in = m->kaddr + base;
+
+	i = (eofs - base) >> amortizedshift;
+
+	lo = decode_compactedbits(lclusterbits, lomask,
+				  in, encodebits * i, &type);
+	m->type = type;
+	if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
+		m->clusterofs = 1 << lclusterbits;
+		if (i + 1 != (int)vcnt) {
+			m->delta[0] = lo;
+			return 0;
+		}
+		/*
+		 * since the last lcluster in the pack is special,
+		 * of which lo saves delta[1] rather than delta[0].
+		 * Hence, get delta[0] by the previous lcluster indirectly.
+		 */
+		lo = decode_compactedbits(lclusterbits, lomask,
+					  in, encodebits * (i - 1), &type);
+		if (type != Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+			lo = 0;
+		m->delta[0] = lo + 1;
+		return 0;
+	}
+	m->clusterofs = lo;
+	m->delta[0] = 0;
+	/* figout out blkaddr (pblk) for HEAD lclusters */
+	nblk = 1;
+	while (i > 0) {
+		--i;
+		lo = decode_compactedbits(lclusterbits, lomask,
+					  in, encodebits * i, &type);
+		if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+			i -= lo;
+
+		if (i >= 0)
+			++nblk;
+	}
+	in += (vcnt << amortizedshift) - sizeof(__le32);
+	m->pblk = le32_to_cpu(*(__le32 *)in) + nblk;
+	return 0;
+}
+
+static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
+					    unsigned long lcn)
+{
+	struct erofs_vnode *const vi = m->vnode;
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	const erofs_off_t ebase = round_up(nid2addr(vi->nid) + vi->inode_isize +
+					   vi->xattr_isize, 8) +
+		sizeof(struct z_erofs_map_header);
+	const unsigned int totalidx = DIV_ROUND_UP(vi->i_size, EROFS_BLKSIZ);
+	unsigned int compacted_4b_initial, compacted_2b;
+	unsigned int amortizedshift;
+	erofs_off_t pos;
+	int err;
+
+	if (lclusterbits != 12)
+		return -EOPNOTSUPP;
+
+	if (lcn >= totalidx)
+		return -EINVAL;
+
+	m->lcn = lcn;
+	/* used to align to 32-byte (compacted_2b) alignment */
+	compacted_4b_initial = (32 - ebase % 32) / 4;
+	if (compacted_4b_initial == 32 / 4)
+		compacted_4b_initial = 0;
+
+	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
+		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
+	else
+		compacted_2b = 0;
+
+	pos = ebase;
+	if (lcn < compacted_4b_initial) {
+		amortizedshift = 2;
+		goto out;
+	}
+	pos += compacted_4b_initial * 4;
+	lcn -= compacted_4b_initial;
+
+	if (lcn < compacted_2b) {
+		amortizedshift = 1;
+		goto out;
+	}
+	pos += compacted_2b * 2;
+	lcn -= compacted_2b;
+	amortizedshift = 2;
+out:
+	pos += lcn * (1 << amortizedshift);
+	err = z_erofs_reload_indexes(m, erofs_blknr(pos));
+	if (err)
+		return err;
+	return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos));
+}
+
+static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
+					  unsigned int lcn)
+{
+	const unsigned int datamode = m->vnode->datalayout;
+
+	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
+		return legacy_load_cluster_from_disk(m, lcn);
+
+	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
+		return compacted_load_cluster_from_disk(m, lcn);
+
+	return -EINVAL;
+}
+
+static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
+				   unsigned int lookback_distance)
+{
+	struct erofs_vnode *const vi = m->vnode;
+	struct erofs_map_blocks *const map = m->map;
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	unsigned long lcn = m->lcn;
+	int err;
+
+	if (lcn < lookback_distance) {
+		loge("bogus lookback distance @ nid %llu", vi->nid);
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
+
+	/* load extent head logical cluster if needed */
+	lcn -= lookback_distance;
+	err = z_erofs_load_cluster_from_disk(m, lcn);
+	if (err)
+		return err;
+
+	switch (m->type) {
+	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		if (!m->delta[0]) {
+			loge("invalid lookback distance 0 @ nid %llu",
+				  vi->nid);
+			DBG_BUGON(1);
+			return -EFSCORRUPTED;
+		}
+		return z_erofs_extent_lookback(m, m->delta[0]);
+	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
+		map->m_flags &= ~EROFS_MAP_ZIPPED;
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+		map->m_la = (lcn << lclusterbits) | m->clusterofs;
+		break;
+	default:
+		loge("unknown type %u @ lcn %lu of nid %llu",
+		     m->type, lcn, vi->nid);
+		DBG_BUGON(1);
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+int z_erofs_map_blocks_iter(struct erofs_vnode *vi,
+			    struct erofs_map_blocks *map)
+{
+	struct z_erofs_maprecorder m = {
+		.vnode = vi,
+		.map = map,
+		.kaddr = map->mpage,
+	};
+	int err = 0;
+	unsigned int lclusterbits, endoff;
+	unsigned long long ofs, end;
+
+	/* when trying to read beyond EOF, leave it unmapped */
+	if (map->m_la >= vi->i_size) {
+		map->m_llen = map->m_la + 1 - vi->i_size;
+		map->m_la = vi->i_size;
+		map->m_flags = 0;
+		goto out;
+	}
+
+	err = z_erofs_fill_inode_lazy(vi);
+	if (err)
+		goto out;
+
+	lclusterbits = vi->z_logical_clusterbits;
+	ofs = map->m_la;
+	m.lcn = ofs >> lclusterbits;
+	endoff = ofs & ((1 << lclusterbits) - 1);
+
+	err = z_erofs_load_cluster_from_disk(&m, m.lcn);
+	if (err)
+		goto out;
+
+	map->m_flags = EROFS_MAP_ZIPPED;	/* by default, compressed */
+	end = (m.lcn + 1ULL) << lclusterbits;
+	switch (m.type) {
+	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
+		if (endoff >= m.clusterofs)
+			map->m_flags &= ~EROFS_MAP_ZIPPED;
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+		if (endoff >= m.clusterofs) {
+			map->m_la = (m.lcn << lclusterbits) | m.clusterofs;
+			break;
+		}
+		/* m.lcn should be >= 1 if endoff < m.clusterofs */
+		if (!m.lcn) {
+			loge("invalid logical cluster 0 at nid %llu",
+			     vi->nid);
+			err = -EFSCORRUPTED;
+			goto out;
+		}
+		end = (m.lcn << lclusterbits) | m.clusterofs;
+		map->m_flags |= EROFS_MAP_FULL_MAPPED;
+		m.delta[0] = 1;
+	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		/* get the correspoinding first chunk */
+		err = z_erofs_extent_lookback(&m, m.delta[0]);
+		if (err)
+			goto out;
+		break;
+	default:
+		loge("unknown type %u @ offset %llu of nid %llu",
+		     m.type, ofs, vi->nid);
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	map->m_llen = end - map->m_la;
+	map->m_plen = 1 << lclusterbits;
+	map->m_pa = blknr_to_addr(m.pblk);
+	map->m_flags |= EROFS_MAP_MAPPED;
+
+out:
+	logd("m_la %llu m_pa %llu m_llen %llu m_plen %llu m_flags 0%o",
+	     map->m_la, map->m_pa,
+	     map->m_llen, map->m_plen, map->m_flags);
+
+	DBG_BUGON(err < 0 && err != -ENOMEM);
+	return err;
+}
diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index a9c769e..06d29a9 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -173,5 +173,18 @@ typedef int64_t         s64;
 #define __maybe_unused      __attribute__((__unused__))
 #endif
 
+struct __una_u32 { u32 x; } __packed;
+
+static inline u32 __get_unaligned_cpu32(const void *p)
+{
+	const struct __una_u32 *ptr = (const struct __una_u32 *)p;
+	return ptr->x;
+}
+
+static inline u32 get_unaligned_le32(const void *p)
+{
+	return __get_unaligned_cpu32((const u8 *)p);
+}
+
 #endif
 
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 47ad96d..5807b67 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -36,6 +36,8 @@ typedef unsigned short umode_t;
 #error incompatible PAGE_SIZE is already defined
 #endif
 
+#define PAGE_MASK		(~(PAGE_SIZE-1))
+
 #define LOG_BLOCK_SIZE          (12)
 #define EROFS_BLKSIZ            (1U << LOG_BLOCK_SIZE)
 
@@ -145,7 +147,15 @@ struct erofs_vnode {
 	uint16_t xattr_shared_count;
 	char *xattr_shared_xattrs;
 
-	erofs_blk_t raw_blkaddr;
+	union {
+		erofs_blk_t raw_blkaddr;
+		struct {
+			uint16_t z_advise;
+			uint8_t  z_algorithmtype[2];
+			uint8_t  z_logical_clusterbits;
+			uint8_t  z_physical_clusterbits[2];
+		};
+	};
 	erofs_nid_t nid;
 	uint32_t i_ino;
 
@@ -155,6 +165,7 @@ struct erofs_vnode {
 	uint16_t i_nlink;
 	uint32_t i_rdev;
 
+	bool z_inited;
 	/* if file is inline read inline data witch inode */
 	char *idata;
 };
@@ -207,5 +218,35 @@ static inline const char *erofs_strerror(int err)
 	return msg;
 }
 
+enum {
+	BH_Mapped ,
+	BH_Zipped ,
+	BH_FullMapped,
+};
+
+/* Has a disk mapping */
+#define EROFS_MAP_MAPPED	(1 << BH_Mapped)
+/* The extent has been compressed */
+#define EROFS_MAP_ZIPPED	(1 << BH_Zipped)
+/* The length of extent is full */
+#define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
+
+struct erofs_map_blocks {
+	erofs_off_t m_pa, m_la;
+	u64 m_plen, m_llen;
+
+	unsigned int m_flags;
+
+	char mpage[EROFS_BLKSIZ];
+	erofs_blk_t index;
+};
+
+/* zmap.c */
+int z_erofs_fill_inode(struct erofs_vnode *vi);
+int z_erofs_map_blocks_iter(struct erofs_vnode *vi,
+			    struct erofs_map_blocks *map);
+
+#define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
+
 #endif
 
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index bcc4f0c..0c70897 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -279,6 +279,10 @@ struct z_erofs_vle_decompressed_index {
 	} di_u;
 };
 
+#define Z_EROFS_VLE_LEGACY_INDEX_ALIGN(size) \
+	(round_up(size, sizeof(struct z_erofs_vle_decompressed_index)) + \
+	 sizeof(struct z_erofs_map_header) + Z_EROFS_VLE_LEGACY_HEADER_PADDING)
+
 #define Z_EROFS_VLE_EXTENT_ALIGN(size) round_up(size, \
 	sizeof(struct z_erofs_vle_decompressed_index))
 
-- 
2.25.1

