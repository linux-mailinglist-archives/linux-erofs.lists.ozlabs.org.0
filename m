Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F71F4C544B
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Feb 2022 08:06:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K5Hjx6Hx0z3bb4
	for <lists+linux-erofs@lfdr.de>; Sat, 26 Feb 2022 18:06:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Fzh7xAeC;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535;
 helo=mail-pg1-x535.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=Fzh7xAeC; dkim-atps=neutral
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K5Hjn6R4Mz30L1
 for <linux-erofs@lists.ozlabs.org>; Sat, 26 Feb 2022 18:06:05 +1100 (AEDT)
Received: by mail-pg1-x535.google.com with SMTP id o23so6643145pgk.13
 for <linux-erofs@lists.ozlabs.org>; Fri, 25 Feb 2022 23:06:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rqCFGLHgexYuxh94n4X8+5l82SBVUjCxxiHF4fVAP/Q=;
 b=Fzh7xAeCnT1cbI5t3tuncdukUhtM2cAhiE1P50HEvFRkAS1M3PHiKWjjfMlu6joeRH
 V00NyD0gvvolMPinNY6n18TQTnyUat8Suh63x0Zx9k05H2s1Mql8pwGT+L7f3RmLBDsB
 wxezn+OrkAC3YeOKgXYorcWl0WlRpSGi8kzUc8NuQX5qEd3n+3hRgVXNMzwA2smZ+lbe
 teTnAmqY2U3aD+g7TWUOk91kyhy5gfZSK8VW8UQzR7vSZ1BX6fHVGOgM91Tu4QpXvo2n
 2pWnDdz01r+32Gg2wXDB+Bs394ng/Fl619fhvTD7535KkaonfL9zwU3S594xALp/2fNo
 fTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rqCFGLHgexYuxh94n4X8+5l82SBVUjCxxiHF4fVAP/Q=;
 b=TNxeKP+z7S8WhEpMU+VEr0/PJPYh3SBw6XxiU5snCHOhZxh13DUNxDxVmfq0aL15Sw
 U4qAota1aw6L3KSzmJRAjaCdKgNTzR3LI1GTV2k3PptNBJ7ZBl0zLG/tBw44citEhZn4
 ctkhq6UJP1sUDu/BNo8YHSbusAR5NpW7EJ3dYWBViQJ1ros+0nlLD+iuOB8sK+GBdhKa
 BwXAYeVsKLqIQ24Uv0JzkUGZdm6YkvmvBck01z4r1pXmC4Ok0xqA62ParjVUZD+PpYNs
 vt30T8FVfnSXWRHWOqZm4SS5pOPQO5HHbc0Xrq74jT76h/Xg/GBMwGiCuFaV1X5bBPRj
 MuLQ==
X-Gm-Message-State: AOAM533X2EIqxSNnnCETICZwdL4il6RmxLareku3eKBB3kLmgk7F8U7e
 eB2lA5wYk5DbF9RAUEAxc/M=
X-Google-Smtp-Source: ABdhPJxo1aNThDBzcslk9oVdWAzBPEvEKXAikL4w/WfIt9u485cAOQf9KPfn2L1sprFyPBNp+E1RxQ==
X-Received: by 2002:a63:2004:0:b0:375:ed63:ab4c with SMTP id
 g4-20020a632004000000b00375ed63ab4cmr7402885pgg.255.1645859164304; 
 Fri, 25 Feb 2022 23:06:04 -0800 (PST)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207]) by smtp.gmail.com with ESMTPSA id
 e20-20020a17090ab39400b001bc4f9ad3cbsm11044489pjr.3.2022.02.25.23.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Feb 2022 23:06:04 -0800 (PST)
From: Huang Jianan <jnhuang95@gmail.com>
To: u-boot@lists.denx.de,
	trini@konsulko.com
Subject: [PATCH v4 3/5] fs/erofs: add lz4 decompression support
Date: Sat, 26 Feb 2022 15:05:49 +0800
Message-Id: <20220226070551.9833-4-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220226070551.9833-1-jnhuang95@gmail.com>
References: <20220226070551.9833-1-jnhuang95@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Support EROFS lz4 compressed files.

Signed-off-by: Huang Jianan <jnhuang95@gmail.com>
---
 fs/erofs/Kconfig      |   9 +
 fs/erofs/Makefile     |   4 +-
 fs/erofs/data.c       |  90 ++++++-
 fs/erofs/decompress.c |  78 ++++++
 fs/erofs/decompress.h |  24 ++
 fs/erofs/namei.c      |   2 +-
 fs/erofs/zmap.c       | 601 ++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 805 insertions(+), 3 deletions(-)
 create mode 100644 fs/erofs/decompress.c
 create mode 100644 fs/erofs/decompress.h
 create mode 100644 fs/erofs/zmap.c

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index f4b2d51a23..ee4e777c5c 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -10,3 +10,12 @@ config FS_EROFS
 	  improves storage density, keeps relatively higher compression
 	  ratios, which is more useful to achieve high performance for
 	  embedded devices with limited memory.
+
+config FS_EROFS_ZIP
+	bool "EROFS Data Compression Support"
+	depends on FS_EROFS
+	select LZ4
+	default y
+	help
+	  Enable fixed-sized output compression for EROFS.
+	  If you don't want to enable compression feature, say N.
diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 7398ab7a36..58af6a68e4 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -4,4 +4,6 @@
 obj-$(CONFIG_$(SPL_)FS_EROFS) = fs.o \
 				super.o \
 				namei.o \
-				data.o
+				data.o \
+				decompress.o \
+				zmap.o
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 699975c1be..761896054c 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0+
 #include "internal.h"
+#include "decompress.h"
 
 static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
 				     struct erofs_map_blocks *map,
@@ -205,6 +206,93 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 	return 0;
 }
 
+static int z_erofs_read_data(struct erofs_inode *inode, char *buffer,
+			     erofs_off_t size, erofs_off_t offset)
+{
+	erofs_off_t end, length, skip;
+	struct erofs_map_blocks map = {
+		.index = UINT_MAX,
+	};
+	struct erofs_map_dev mdev;
+	bool partial;
+	unsigned int bufsize = 0;
+	char *raw = NULL;
+	int ret = 0;
+
+	end = offset + size;
+	while (end > offset) {
+		map.m_la = end - 1;
+
+		ret = z_erofs_map_blocks_iter(inode, &map, 0);
+		if (ret)
+			break;
+
+		/* no device id here, thus it will always succeed */
+		mdev = (struct erofs_map_dev) {
+			.m_pa = map.m_pa,
+		};
+		ret = erofs_map_dev(&sbi, &mdev);
+		if (ret) {
+			DBG_BUGON(1);
+			break;
+		}
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
+		ret = erofs_dev_read(mdev.m_deviceid, raw, mdev.m_pa, map.m_plen);
+		if (ret < 0)
+			break;
+
+		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
+					.in = raw,
+					.out = buffer + end - offset,
+					.decodedskip = skip,
+					.inputsize = map.m_plen,
+					.decodedlength = length,
+					.alg = map.m_algorithmformat,
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
@@ -215,7 +303,7 @@ int erofs_pread(struct erofs_inode *inode, char *buf,
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
index 0000000000..2be3b844cf
--- /dev/null
+++ b/fs/erofs/decompress.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include "decompress.h"
+
+#if IS_ENABLED(CONFIG_LZ4)
+#include <u-boot/lz4.h>
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
+						  rq->inputsize - inputmargin,
+						  rq->decodedlength, rq->decodedlength);
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
+#endif
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
+#if IS_ENABLED(CONFIG_LZ4)
+	if (rq->alg == Z_EROFS_COMPRESSION_LZ4)
+		return z_erofs_decompress_lz4(rq);
+#endif
+	return -EOPNOTSUPP;
+}
diff --git a/fs/erofs/decompress.h b/fs/erofs/decompress.h
new file mode 100644
index 0000000000..81d5fb84f6
--- /dev/null
+++ b/fs/erofs/decompress.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __EROFS_DECOMPRESS_H
+#define __EROFS_DECOMPRESS_H
+
+#include "internal.h"
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
index f1195a09ea..d1d4757c50 100644
--- a/fs/erofs/namei.c
+++ b/fs/erofs/namei.c
@@ -114,7 +114,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 		vi->u.chunkbits = LOG_BLOCK_SIZE +
 			(vi->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	} else if (erofs_inode_is_data_compressed(vi->datalayout))
-		return -EOPNOTSUPP;
+		z_erofs_fill_inode(vi);
 	return 0;
 bogusimode:
 	erofs_err("bogus i_mode (%o) @ nid %llu", vi->i_mode, vi->nid | 0ULL);
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
new file mode 100644
index 0000000000..be2599ac4f
--- /dev/null
+++ b/fs/erofs/zmap.c
@@ -0,0 +1,601 @@
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
+	ret = erofs_dev_read(0, buf, pos, sizeof(buf));
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
+		erofs_err("big pcluster head1/2 of compact indexes should be consistent for nid %llu",
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
+	u8  type, headtype;
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
+static int get_compacted_la_distance(unsigned int lclusterbits,
+				     unsigned int encodebits,
+				     unsigned int vcnt, u8 *in, int i)
+{
+	const unsigned int lomask = (1 << lclusterbits) - 1;
+	unsigned int lo, d1 = 0;
+	u8 type;
+
+	DBG_BUGON(i >= vcnt);
+
+	do {
+		lo = decode_compactedbits(lclusterbits, lomask,
+					  in, encodebits * i, &type);
+
+		if (type != Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD)
+			return d1;
+		++d1;
+	} while (++i < vcnt);
+
+	/* vcnt - 1 (Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) item */
+	if (!(lo & Z_EROFS_VLE_DI_D0_CBLKCNT))
+		d1 += lo - 1;
+	return d1;
+}
+
+static int unpack_compacted_index(struct z_erofs_maprecorder *m,
+				  unsigned int amortizedshift,
+				  unsigned int eofs, bool lookahead)
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
+
+		/* figure out lookahead_distance: delta[1] if needed */
+		if (lookahead)
+			m->delta[1] = get_compacted_la_distance(lclusterbits,
+								encodebits,
+								vcnt, in, i);
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
+					    unsigned long lcn, bool lookahead)
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
+	return unpack_compacted_index(m, amortizedshift, erofs_blkoff(pos),
+				      lookahead);
+}
+
+static int z_erofs_load_cluster_from_disk(struct z_erofs_maprecorder *m,
+					  unsigned int lcn, bool lookahead)
+{
+	const unsigned int datamode = m->inode->datalayout;
+
+	if (datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY)
+		return legacy_load_cluster_from_disk(m, lcn);
+
+	if (datamode == EROFS_INODE_FLAT_COMPRESSION)
+		return compacted_load_cluster_from_disk(m, lcn, lookahead);
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
+	err = z_erofs_load_cluster_from_disk(m, lcn, false);
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
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+		m->headtype = m->type;
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
+	if (m->headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
+	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1)) {
+		map->m_plen = 1 << lclusterbits;
+		return 0;
+	}
+
+	lcn = m->lcn + 1;
+	if (m->compressedlcs)
+		goto out;
+
+	err = z_erofs_load_cluster_from_disk(m, lcn, false);
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
+static int z_erofs_get_extent_decompressedlen(struct z_erofs_maprecorder *m)
+{
+	struct erofs_inode *const vi = m->inode;
+	struct erofs_map_blocks *map = m->map;
+	unsigned int lclusterbits = vi->z_logical_clusterbits;
+	u64 lcn = m->lcn, headlcn = map->m_la >> lclusterbits;
+	int err;
+
+	do {
+		/* handle the last EOF pcluster (no next HEAD lcluster) */
+		if ((lcn << lclusterbits) >= vi->i_size) {
+			map->m_llen = vi->i_size - map->m_la;
+			return 0;
+		}
+
+		err = z_erofs_load_cluster_from_disk(m, lcn, true);
+		if (err)
+			return err;
+
+		if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD) {
+			DBG_BUGON(!m->delta[1] &&
+				  m->clusterofs != 1 << lclusterbits);
+		} else if (m->type == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN ||
+			   m->type == Z_EROFS_VLE_CLUSTER_TYPE_HEAD) {
+			/* go on until the next HEAD lcluster */
+			if (lcn != headlcn)
+				break;
+			m->delta[1] = 1;
+		} else {
+			erofs_err("unknown type %u @ lcn %llu of nid %llu",
+				  m->type, lcn | 0ULL,
+				  (unsigned long long)vi->nid);
+			DBG_BUGON(1);
+			return -EOPNOTSUPP;
+		}
+		lcn += m->delta[1];
+	} while (m->delta[1]);
+
+	map->m_llen = (lcn << lclusterbits) + m->clusterofs - map->m_la;
+	return 0;
+}
+
+int z_erofs_map_blocks_iter(struct erofs_inode *vi,
+			    struct erofs_map_blocks *map,
+			    int flags)
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
+	err = z_erofs_load_cluster_from_disk(&m, initial_lcn, false);
+	if (err)
+		goto out;
+
+	map->m_flags = EROFS_MAP_MAPPED | EROFS_MAP_ENCODED;
+	end = (m.lcn + 1ULL) << lclusterbits;
+	switch (m.type) {
+	case Z_EROFS_VLE_CLUSTER_TYPE_PLAIN:
+	case Z_EROFS_VLE_CLUSTER_TYPE_HEAD:
+		if (endoff >= m.clusterofs) {
+			m.headtype = m.type;
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
+		/* fallthrough */
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
+
+	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN)
+		map->m_algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
+	else
+		map->m_algorithmformat = vi->z_algorithmtype[0];
+
+	if (flags & EROFS_GET_BLOCKS_FIEMAP) {
+		err = z_erofs_get_extent_decompressedlen(&m);
+		if (!err)
+			map->m_flags |= EROFS_MAP_FULL_MAPPED;
+	}
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

