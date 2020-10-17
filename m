Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 312C5290F04
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 07:17:32 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCrqs4sM1zDr1X
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 16:17:29 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602911849;
	bh=mqD26kCkHyHHugjSPySvNIGl6omINeShZm4tb7jp+dg=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Ps0S3Et4x4wkvIVZVVjT9IsuiYOjGyxd09DiTQsUSJY5xN1q+qYyeEzQ6jPQXwRXq
	 LF0hLxD886UFtGUuyi9NypxP3OIixhTD/y6G0tDsR0kdacWM+V7FkptRO3f2depHEw
	 rz7dMswprziSWlptD8JOKGWsi4kfs/pnynGQLVsypllBf3Hs9fJ5Q7WZlhKQVl0Izu
	 TQc7AgqEiyNnezJs1WYEwqWvGIp04Ws45iIzvnvyWUE8em1veMwFLc2htzTmrVkxnw
	 tvzltD/LCXFGJs2kYRPQiZVvhxV9bUdCalruqhQCxLW6qDiG8Cg8CAfUWEbSDEILuj
	 gwLxIb7dKkatg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.69.148; helo=sonic310-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=m93AjFmM; dkim-atps=neutral
Received: from sonic310-22.consmr.mail.gq1.yahoo.com
 (sonic310-22.consmr.mail.gq1.yahoo.com [98.137.69.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCrqj3r2QzDr09
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Oct 2020 16:17:21 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1602911838; bh=lRqw8c/49BC05qU/fE3Ssb7wXXmNulkP7V3jarEuvWA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=m93AjFmM2rmK4y+w4GtQC5u9L/Ld8lzH44KJSwlzjrHUnTZ7uAzZf4M0+guA44/P8NTt38a3j5ncgIAeO8HWFxl4xKNgNwxwM0i1lFQViBZK7DIXP60TO2OZ9iMeeItuq6Svn8LaPP0qeykUju6Y3ZnLKWl6sgnpT6gYql9fgynbQyIDhm59HgUU4AskOqM2FuyRXe0y1aD/x66Ay9/JkjzhD0R4Gzq4wU+eAVzTM8zx9ElBS7n2ant/D5DOdcuxGCEqmAjGQTCC0pHWavEk2o6+Dsk+G5hw1JyBHLgOr4Q+82MqvvfRXHUwZGtugfGviktVUi89v67fcRjO4sTicA==
X-YMail-OSG: vd8mIwAVM1nxsmzM7XUzalVU9r.6huoaOGR5pxmuAHnKn7huPNcw_0nputCBSlu
 gQFGzLLDC3uq9v1vKDo71uSKmJJqr1o2io2MK09LOe6sYXxImcTQIjL3xB0yDo.ugkyUIEqfvGdL
 lJpdAwB0x5U9BIYVoz4ZUD11dmYbhaiL6zcIXMwAUvP2TlWopliMyqLNqL2WPedddSjV5xi1OMy9
 DhxauzQaMlAj1bKFREBi9YyFKxXn60Nlk1.vue18HzCegSde_S.FZIXsIJbXY6FEKlqiTmOFkQLI
 jON2.xs2OEG.Cp1u0V4ZVVYQs4VZrdOsikua5XmCewioBf7GiiNpMTFLTUxCcra8FV7bonljOIXj
 J4hKJRqO0ygWWMSNzeRIv6KWOrNxs37qVy9EFH9Tg61EIhw06JGRrHVxUFvec7AZYXWuEnIeJY0i
 UYjwF5u7A251BM6dAsV796_ZZ6S9fs1H3_EzRmSV5HMuX5Ha4Jfzadjl5rCCWtDQiEvmmlWzHI_T
 0kluoMt2n6_m9lqWQghcRu63IRShiMrUFa5xfeEKfpF0BA9LtDQp2GU05KuGUcpoHAWPdy5Wg1qU
 .zkReI542C5ieCdCVtybgb.PmQURXcn.OG8cAEWD3Lh6zErRSxLHghMjoMdfK9U4uKW9nlEBoFpz
 PuF4C07gbM6QVRezCkATOydmhNvY3_TLdNM1ti8Oc_upiCh3ec5urQyQoNAsyKVmorXTt7cVGsH4
 dbYMuzSs71m_LxKPE4nhxLM3kh3GG5sgDISDhKuZLefJae3egkpKZceJuKMyvXdFHy9lsaRkL4uN
 GRRwXksQMudHTQsWO9Gg8OGIDhwOiHherUHDsPfoqn.tjVKzAeOfve_3kEUSCHFnH6bAMODDTNZw
 Hn9zqfDl2YQm0sxZOiDdGcaHFX65vVBHKbbqluEhIub3FdzSOUpexlqyECUJjHrn8.bULIxRUfqF
 1njqgRnYBGhHzg2p3159nPcJQnJvlzLwWz6XWEjqCmgjwt.JRuEYEmNyTA_bDXwuAgZGIn_NQTzV
 VrUaWzNa5lzZJMNyQBH5YK8H1lsuSfsgiiHf6qt.7UGR3slWSH8RpKnAJwzHmjC6ZeySHdZMDyA0
 dwXXv4ob4EuWaBms8Lqa7.2xLKqCi00UueO0xKyA6GC1zB02xnDymwiDYbb8ZtItJ9cs4vHmy7hX
 .7Lqu7VGjQyyNbqqvC5lXMPH6QBT0KtypbJGGKt8H.TiozH.mJKF.gOJQOoQt_rB5IN4v9DXkCY3
 9Pl2oRTwoy1ujq82YjplqaVX.dW.2fR0wE1mdptTurDJ367g.GfxYlsDTImPa7sfXtrLbqVVzOS3
 bUdaTWDhC64aFSU.Wo5ZoA0XWFmtmsbCBw42Q5ACPNXBsPQ2XEsMBTsar5WwsbYvTsvtkM8BB6gx
 zAtPyPOpe2tFIRBhxZqKXELEsztekPah_V0kYvjwEa026jM_WUckEl2ZX3I1lq6Abn8He2RR0W.O
 I1O.XLTU1535Q8kgRW25kqQyV_0GhBM9u3VSyAKkHTBYcq2sb6cPkUJvc_asm67L0bJ5sHSISMhD
 4Kq4pbrUexg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic310.consmr.mail.gq1.yahoo.com with HTTP; Sat, 17 Oct 2020 05:17:18 +0000
Received: by smtp424.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 9d3dc137a63e5241cc606f3cba181f35; 
 Sat, 17 Oct 2020 05:17:14 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH 03/12] erofs-utils: fuse: support read compressed file
Date: Sat, 17 Oct 2020 13:16:12 +0800
Message-Id: <20201017051621.7810-4-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201017051621.7810-1-hsiangkao@aol.com>
References: <20201017051621.7810-1-hsiangkao@aol.com>
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: Zhang Shiming <zhangshiming@oppo.com>, Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Huang Jianan <huangjianan@oppo.com>

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/Makefile.am         |   8 +-
 fuse/decompress.c        |  86 ++++++++
 fuse/decompress.h        |  37 ++++
 fuse/dentry.h            |   5 +-
 fuse/init.c              |  22 ++-
 fuse/init.h              |   2 +
 fuse/namei.c             |  11 +-
 fuse/read.c              |  73 ++++++-
 fuse/zmap.c              | 416 +++++++++++++++++++++++++++++++++++++++
 include/erofs/defs.h     |  13 ++
 include/erofs/internal.h |  43 +++-
 include/erofs_fs.h       |   4 +
 12 files changed, 711 insertions(+), 9 deletions(-)
 create mode 100644 fuse/decompress.c
 create mode 100644 fuse/decompress.h
 create mode 100644 fuse/zmap.c

diff --git a/fuse/Makefile.am b/fuse/Makefile.am
index fffd67a53fe1..052c7163dff7 100644
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
index 000000000000..e2df3cea78f7
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
index 000000000000..cd395c3d6b3f
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
index ee2144de8a89..f89c50646fb5 100644
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
index 8198fa78da96..e9cc9f81d4c7 100644
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
index d7a97b5ee043..3fc4eb548dda 100644
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
index 7ed1168fc14f..510fcfda5a76 100644
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
index 3ce5c4f2911e..0d0e3b0fa468 100644
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
@@ -137,4 +206,4 @@ int erofs_readlink(const char *path, char *buffer, size_t size)
 
 	logi("path:%s link=%s size=%llu", path, buffer, lnksz);
 	return 0;
-}
\ No newline at end of file
+}
diff --git a/fuse/zmap.c b/fuse/zmap.c
new file mode 100644
index 000000000000..022ca1b9e437
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
index a9c769ec88ae..06d29a9575da 100644
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
index 47ad96d0488c..5807b67637c8 100644
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
index bcc4f0c630ad..0c70897d2113 100644
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
2.24.0

