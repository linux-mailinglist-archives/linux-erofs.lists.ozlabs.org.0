Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6C13F404F
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Aug 2021 17:49:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gt0D85xc7z308f
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Aug 2021 01:49:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=PuUNl7P4;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532;
 helo=mail-pg1-x532.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=PuUNl7P4; dkim-atps=neutral
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com
 [IPv6:2607:f8b0:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gt0Cw0Fg5z2yLl
 for <linux-erofs@lists.ozlabs.org>; Mon, 23 Aug 2021 01:48:59 +1000 (AEST)
Received: by mail-pg1-x532.google.com with SMTP id q2so14247155pgt.6
 for <linux-erofs@lists.ozlabs.org>; Sun, 22 Aug 2021 08:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=OrSCRCv0VI1iqGdH75jtV0dM0GjNtAUDzmlrINAKhyM=;
 b=PuUNl7P4ebK5nwLwXiYDeEUHsWq1uTPqLFeQx1oZ3yrrPGC2QUR2JNTEvLQh4c50LP
 woGqwqA7GFao5bXaC4aFu2fHpaZZCJFruyqTEfBBwON+FdaHtv8X1EDPvd1GyttCVDDq
 AsWdgYfbl1msufc4fY8SvET5/XRNplEE67Wal6NMV42mTYWTzdDk+r80Ue6O2By0J8BY
 WwlS6rgzy6a3VxqTRffxYur+UsyQLI12NnaXdLahzs2E5AQV2Tf4rdTljszEVNFXzPav
 mnGCc2pAX9WdKlkswY3GwwNRMk9d3Ycj3FcXTxHkQlFEUdpA49rz+XqpbfLEUdnU280t
 d6Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=OrSCRCv0VI1iqGdH75jtV0dM0GjNtAUDzmlrINAKhyM=;
 b=DDAKTqmm9YbvpL/pNj0eQmg8AdJbgGLQUuVobdKD08GPenlovhmtntdx4l8dQ+yNh8
 wwkekCPbYsw/Mlr4AByHmaj/Tez9HHGr00ft81eGHk+WSsCQASLWkSZhAjdvn7ILtSyY
 uc166BoEVaWYp7MfKnxTvoY5PML4utpwsCmg+ZfsD3c0Q+o4jjP2cDSC/0rIw5YpVEEb
 WsF+TlFCTJR+HU5VtXGxezJ+8ya5D52z6rIvcqUvmwzNAKzaPkwU5b5YZIXpC+TrInBF
 qlaj3MQTzIRFlGWTzKNBaBevrhaxqyG3QuNAvjfLPWiKhuJs7uW0TJ5o2cQ7Hl3wAN5Z
 pExQ==
X-Gm-Message-State: AOAM531ZFKtZYCQ30fK/Ju3v60YRAbUt3GPh7ikJ9toIGB3O0J03d8g7
 rkrIMi0WMEl1SGKwCN7cHyA=
X-Google-Smtp-Source: ABdhPJyeHBNpC5pQMb2ME/pfxbEiKgoqxcT7VrANE0PRDCSpZjz7/U9KxFSQ5rUIX6154yTW/grzAQ==
X-Received: by 2002:a63:5a4a:: with SMTP id k10mr27889182pgm.379.1629647337283; 
 Sun, 22 Aug 2021 08:48:57 -0700 (PDT)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id fh19sm17161901pjb.27.2021.08.22.08.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Aug 2021 08:48:56 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
To: u-boot@lists.denx.de
Subject: [PATCH 3/3] fs/erofs: add lz4 decompression support
Date: Sun, 22 Aug 2021 23:48:43 +0800
Message-Id: <20210822154843.10971-3-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210822154843.10971-1-jnhuang95@gmail.com>
References: <20210822154843.10971-1-jnhuang95@gmail.com>
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Huang Jianan <huangjianan@oppo.com>

Support EROFS lz4 compressed files.

Signed-off-by: Huang Jianan <jnhuang95@gmail.com>
---
 fs/erofs/Makefile     |   4 +-
 fs/erofs/data.c       |  84 ++++++-
 fs/erofs/decompress.c |  74 ++++++
 fs/erofs/decompress.h |  29 +++
 fs/erofs/namei.c      |   2 +-
 fs/erofs/zmap.c       | 517 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 707 insertions(+), 3 deletions(-)
 create mode 100644 fs/erofs/decompress.c
 create mode 100644 fs/erofs/decompress.h
 create mode 100644 fs/erofs/zmap.c

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index c4fc5b794e..8f1f99a096 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -5,4 +5,6 @@ obj-$(CONFIG_$(SPL_)FS_EROFS) = fs.o \
 				super.o \
 				namei.o \
 				data.o \
-				lz4.o
+				lz4.o \
+				decompress.o \
+				zmap.o
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index a0f613264a..04ba9b5765 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 #include "internal.h"
+#include "decompress.h"
 
 static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
 				     struct erofs_map_blocks *map,
@@ -107,6 +108,87 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 	return 0;
 }
 
+static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
+			     erofs_off_t size, erofs_off_t offset)
+{
+	erofs_off_t end, length, skip;
+	struct erofs_map_blocks map = {
+		.index = UINT_MAX,
+	};
+	bool partial;
+	unsigned int algorithmformat, bufsize;
+	char *raw = NULL;
+	int ret = 0;
+
+	end = offset + size;
+	bufsize = 0;
+	while (end > offset) {
+		map.m_la = end - 1;
+
+		ret = z_erofs_map_blocks_iter(inode, &map);
+		if (ret)
+			break;
+
+		/*
+		 * trim to the needed size if the returned extent is quite
+		 * larger than requested, and set up partial flag as well.
+		 */
+		if (end < map.m_la + map.m_llen) {
+			length = end - map.m_la;
+			partial = true;
+		} else {
+			DBG_BUGON(end != map.m_la + map.m_llen);
+			length = map.m_llen;
+			partial = !(map.m_flags & EROFS_MAP_FULL_MAPPED);
+		}
+
+		if (map.m_la < offset) {
+			skip = offset - map.m_la;
+			end = offset;
+		} else {
+			skip = 0;
+			end = map.m_la;
+		}
+
+		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+			memset(buffer + end - offset, 0, length);
+			end = map.m_la;
+			continue;
+		}
+
+		if (map.m_plen > bufsize) {
+			bufsize = map.m_plen;
+			raw = realloc(raw, bufsize);
+			if (!raw) {
+				ret = -ENOMEM;
+				break;
+			}
+		}
+		ret = erofs_dev_read(raw, map.m_pa, map.m_plen);
+		if (ret < 0)
+			break;
+
+		algorithmformat = map.m_flags & EROFS_MAP_ZIPPED ?
+						Z_EROFS_COMPRESSION_LZ4 :
+						Z_EROFS_COMPRESSION_SHIFTED;
+
+		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
+					.in = raw,
+					.out = buffer + end - offset,
+					.decodedskip = skip,
+					.inputsize = map.m_plen,
+					.decodedlength = length,
+					.alg = algorithmformat,
+					.partial_decoding = partial
+					 });
+		if (ret < 0)
+			break;
+	}
+	if (raw)
+		free(raw);
+	return ret < 0 ? ret : 0;
+}
+
 int erofs_pread(struct erofs_inode *inode, char *buf,
 		erofs_off_t count, erofs_off_t offset)
 {
@@ -116,7 +198,7 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
 		return erofs_read_raw_data(inode, buf, count, offset);
 	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
 	case EROFS_INODE_FLAT_COMPRESSION:
-		return -EOPNOTSUPP;
+		return z_erofs_read_data(inode, buf, count, offset);
 	default:
 		break;
 	}
diff --git a/fs/erofs/decompress.c b/fs/erofs/decompress.c
new file mode 100644
index 0000000000..f960f6442a
--- /dev/null
+++ b/fs/erofs/decompress.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include "decompress.h"
+#include "lz4.h"
+
+static int z_erofs_decompress_lz4(struct z_erofs_decompress_req *rq)
+{
+	int ret = 0;
+	char *dest = rq->out;
+	char *src = rq->in;
+	char *buff = NULL;
+	bool support_0padding = false;
+	unsigned int inputmargin = 0;
+
+	if (erofs_sb_has_lz4_0padding()) {
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
+	if (rq->decodedskip) {
+		buff = malloc(rq->decodedlength);
+		if (!buff)
+			return -ENOMEM;
+		dest = buff;
+	}
+
+	if (rq->partial_decoding || !support_0padding)
+		ret = LZ4_decompress_safe_partial(src + inputmargin, dest,
+				rq->inputsize - inputmargin,
+				rq->decodedlength, rq->decodedlength);
+	else
+		ret = LZ4_decompress_safe(src + inputmargin, dest,
+					  rq->inputsize - inputmargin,
+					  rq->decodedlength);
+
+	if (ret != (int)rq->decodedlength) {
+		ret = -EIO;
+		goto out;
+	}
+
+	if (rq->decodedskip)
+		memcpy(rq->out, dest + rq->decodedskip,
+		       rq->decodedlength - rq->decodedskip);
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
+	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
+		if (rq->inputsize != EROFS_BLKSIZ)
+			return -EFSCORRUPTED;
+
+		DBG_BUGON(rq->decodedlength > EROFS_BLKSIZ);
+		DBG_BUGON(rq->decodedlength < rq->decodedskip);
+
+		memcpy(rq->out, rq->in + rq->decodedskip,
+		       rq->decodedlength - rq->decodedskip);
+		return 0;
+	}
+
+	if (rq->alg == Z_EROFS_COMPRESSION_LZ4)
+		return z_erofs_decompress_lz4(rq);
+	return -EOPNOTSUPP;
+}
diff --git a/fs/erofs/decompress.h b/fs/erofs/decompress.h
new file mode 100644
index 0000000000..a12e11f386
--- /dev/null
+++ b/fs/erofs/decompress.h
@@ -0,0 +1,29 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __EROFS_DECOMPRESS_H
+#define __EROFS_DECOMPRESS_H
+
+#include "internal.h"
+
+enum {
+	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
+	Z_EROFS_COMPRESSION_RUNTIME_MAX
+};
+
+struct z_erofs_decompress_req {
+	char *in, *out;
+
+	/*
+	 * initial decompressed bytes that need to be skipped
+	 * when finally copying to output buffer
+	 */
+	unsigned int decodedskip;
+	unsigned int inputsize, decodedlength;
+
+	/* indicate the algorithm will be used for decompression */
+	unsigned int alg;
+	bool partial_decoding;
+};
+
+int z_erofs_decompress(struct z_erofs_decompress_req *rq);
+
+#endif
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
index 4c5d614483..7a0fbe2bc1 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -101,7 +101,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 
 	vi->flags = 0;
 	if (erofs_inode_is_data_compressed(vi->datalayout))
-		return -EOPNOTSUPP;
+		z_erofs_fill_inode(vi);
 	return 0;
 bogusimode:
 	erofs_err("bogus i_mode (%o) @ nid %llu", vi->i_mode, vi->nid | 0ULL);
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
new file mode 100644
index 0000000000..ff7f89f40c
--- /dev/null
+++ b/fs/erofs/zmap.c
@@ -0,0 +1,517 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include "internal.h"
+
+int z_erofs_fill_inode(struct erofs_inode *vi)
+{
+	if (!erofs_sb_has_big_pcluster() &&
+	    vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY) {
+		vi->z_advise = 0;
+		vi->z_algorithmtype[0] = 0;
+		vi->z_algorithmtype[1] = 0;
+		vi->z_logical_clusterbits = LOG_BLOCK_SIZE;
+
+		vi->flags |= EROFS_I_Z_INITED;
+	}
+	return 0;
+}
+
+static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
+{
+	int ret;
+	erofs_off_t pos;
+	struct z_erofs_map_header *h;
+	char buf[sizeof(struct z_erofs_map_header)];
+
+	if (vi->flags & EROFS_I_Z_INITED)
+		return 0;
+
+	DBG_BUGON(!erofs_sb_has_big_pcluster() &&
+		  vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
+	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
+
+	ret = erofs_dev_read(buf, pos, sizeof(buf));
+	if (ret < 0)
+		return -EIO;
+
+	h = (struct z_erofs_map_header *)buf;
+	vi->z_advise = le16_to_cpu(h->h_advise);
+	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
+	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
+
+	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX) {
+		erofs_err("unknown compression format %u for nid %llu",
+			  vi->z_algorithmtype[0], (unsigned long long)vi->nid);
+		return -EOPNOTSUPP;
+	}
+
+	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
+	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
+	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
+	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
+		erofs_err(
+"big pcluster head1/2 of compact indexes should be consistent for nid %llu",
+			  vi->nid * 1ULL);
+		return -EFSCORRUPTED;
+	}
+	vi->flags |= EROFS_I_Z_INITED;
+	return 0;
+}
+
+struct z_erofs_maprecorder {
+	struct erofs_inode *inode;
+	struct erofs_map_blocks *map;
+	void *kaddr;
+
+	unsigned long lcn;
+	/* compression extent information gathered */
+	u8  type;
+	u16 clusterofs;
+	u16 delta[2];
+	erofs_blk_t pblk, compressedlcs;
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
+	ret = erofs_blk_read(mpage, eblk, 1);
+	if (ret < 0)
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
+	struct erofs_inode *const vi = m->inode;
+	const erofs_off_t ibase = iloc(vi->nid);
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
+		if (m->delta[0] & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+			if (!(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
+				DBG_BUGON(1);
+				return -EFSCORRUPTED;
+			}
+			m->compressedlcs = m->delta[0] &
+				~Z_EROFS_VLE_DI_D0_CBLKCNT;
+			m->delta[0] = 1;
+		}
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
+	struct erofs_inode *const vi = m->inode;
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	const unsigned int lomask = (1 << lclusterbits) - 1;
+	unsigned int vcnt, base, lo, encodebits, nblk;
+	int i;
+	u8 *in, type;
+	bool big_pcluster;
+
+	if (1 << amortizedshift == 4)
+		vcnt = 2;
+	else if (1 << amortizedshift == 2 && lclusterbits == 12)
+		vcnt = 16;
+	else
+		return -EOPNOTSUPP;
+
+	big_pcluster = vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1;
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
+		if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+			if (!big_pcluster) {
+				DBG_BUGON(1);
+				return -EFSCORRUPTED;
+			}
+			m->compressedlcs = lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
+			m->delta[0] = 1;
+			return 0;
+		} else if (i + 1 != (int)vcnt) {
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
+		else if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT)
+			lo = 1;
+		m->delta[0] = lo + 1;
+		return 0;
+	}
+	m->clusterofs = lo;
+	m->delta[0] = 0;
+	/* figout out blkaddr (pblk) for HEAD lclusters */
+	if (!big_pcluster) {
+		nblk = 1;
+		while (i > 0) {
+			--i;
+			lo = decode_compactedbits(lclusterbits, lomask,
+						  in, encodebits * i, &type);
+			if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+				i -= lo;
+
+			if (i >= 0)
+				++nblk;
+		}
+	} else {
+		nblk = 0;
+		while (i > 0) {
+			--i;
+			lo = decode_compactedbits(lclusterbits, lomask,
+						  in, encodebits * i, &type);
+			if (type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
+				if (lo & Z_EROFS_VLE_DI_D0_CBLKCNT) {
+					--i;
+					nblk += lo & ~Z_EROFS_VLE_DI_D0_CBLKCNT;
+					continue;
+				}
+				if (lo == 1) {
+					DBG_BUGON(1);
+					/* --i; ++nblk;	continue; */
+					return -EFSCORRUPTED;
+				}
+				i -= lo - 2;
+				continue;
+			}
+			++nblk;
+		}
+	}
+	in += (vcnt << amortizedshift) - sizeof(__le32);
+	m->pblk = le32_to_cpu(*(__le32 *)in) + nblk;
+	return 0;
+}
+
+static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
+					    unsigned long lcn)
+{
+	struct erofs_inode *const vi = m->inode;
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	const erofs_off_t ebase = round_up(iloc(vi->nid) + vi->inode_isize +
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
+	const unsigned int datamode = m->inode->datalayout;
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
+	struct erofs_inode *const vi = m->inode;
+	struct erofs_map_blocks *const map = m->map;
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	unsigned long lcn = m->lcn;
+	int err;
+
+	if (lcn < lookback_distance) {
+		erofs_err("bogus lookback distance @ nid %llu",
+			  (unsigned long long)vi->nid);
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
+			erofs_err("invalid lookback distance 0 @ nid %llu",
+				  (unsigned long long)vi->nid);
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
+		erofs_err("unknown type %u @ lcn %lu of nid %llu",
+			  m->type, lcn, (unsigned long long)vi->nid);
+		DBG_BUGON(1);
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int z_erofs_get_extent_compressedlen(struct z_erofs_maprecorder *m,
+					    unsigned int initial_lcn)
+{
+	struct erofs_inode *const vi = m->inode;
+	struct erofs_map_blocks *const map = m->map;
+	const unsigned int lclusterbits = vi->z_logical_clusterbits;
+	unsigned long lcn;
+	int err;
+
+	DBG_BUGON(m->type != Z_EROFS_VLE_CLUSTER_TYPE_PLAIN &&
+		  m->type != Z_EROFS_VLE_CLUSTER_TYPE_HEAD);
+	if (!(map->m_flags & EROFS_MAP_ZIPPED) ||
+	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
+		map->m_plen = 1 << lclusterbits;
+		return 0;
+	}
+
+	lcn = m->lcn + 1;
+	if (m->compressedlcs)
+		goto out;
+
+	err = z_erofs_load_cluster_from_disk(m, lcn);
+	if (err)
+		return err;
+
+	/*
+	 * If the 1st NONHEAD lcluster has already been handled initially w/o
+	 * valid compressedlcs, which means at least it mustn't be CBLKCNT, or
+	 * an internal implemenatation error is detected.
+	 *
+	 * The following code can also handle it properly anyway, but let's
+	 * BUG_ON in the debugging mode only for developers to notice that.
+	 */
+	DBG_BUGON(lcn == initial_lcn &&
+		  m->type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD);
+
+	switch (m->type) {
+	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+		/*
+		 * if the 1st NONHEAD lcluster is actually PLAIN or HEAD type
+		 * rather than CBLKCNT, it's a 1 lcluster-sized pcluster.
+		 */
+		m->compressedlcs = 1;
+		break;
+	case Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD:
+		if (m->delta[0] != 1)
+			goto err_bonus_cblkcnt;
+		if (m->compressedlcs)
+			break;
+		/* fallthrough */
+	default:
+		erofs_err("cannot found CBLKCNT @ lcn %lu of nid %llu",
+			  lcn, vi->nid | 0ULL);
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
+out:
+	map->m_plen = m->compressedlcs << lclusterbits;
+	return 0;
+err_bonus_cblkcnt:
+	erofs_err("bogus CBLKCNT @ lcn %lu of nid %llu",
+		  lcn, vi->nid | 0ULL);
+	DBG_BUGON(1);
+	return -EFSCORRUPTED;
+}
+
+int z_erofs_map_blocks_iter(struct erofs_inode *vi,
+			    struct erofs_map_blocks *map)
+{
+	struct z_erofs_maprecorder m = {
+		.inode = vi,
+		.map = map,
+		.kaddr = map->mpage,
+	};
+	int err = 0;
+	unsigned int lclusterbits, endoff;
+	unsigned long initial_lcn;
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
+	initial_lcn = ofs >> lclusterbits;
+	endoff = ofs & ((1 << lclusterbits) - 1);
+
+	err = z_erofs_load_cluster_from_disk(&m, initial_lcn);
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
+			erofs_err("invalid logical cluster 0 at nid %llu",
+				  (unsigned long long)vi->nid);
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
+		erofs_err("unknown type %u @ offset %llu of nid %llu",
+			  m.type, ofs, (unsigned long long)vi->nid);
+		err = -EOPNOTSUPP;
+		goto out;
+	}
+
+	map->m_llen = end - map->m_la;
+	map->m_pa = blknr_to_addr(m.pblk);
+
+	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
+	if (err)
+		goto out;
+	map->m_flags |= EROFS_MAP_MAPPED;
+
+out:
+	erofs_dbg("m_la %" PRIu64 " m_pa %" PRIu64 " m_llen %" PRIu64 " m_plen %" PRIu64 " m_flags 0%o",
+		  map->m_la, map->m_pa,
+		  map->m_llen, map->m_plen, map->m_flags);
+
+	DBG_BUGON(err < 0 && err != -ENOMEM);
+	return err;
+}
-- 
2.25.1

