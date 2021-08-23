Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C535D3F4AC1
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Aug 2021 14:37:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GtWw33khnz2xv8
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Aug 2021 22:37:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=ls2mFJqJ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::433;
 helo=mail-pf1-x433.google.com; envelope-from=jnhuang95@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ls2mFJqJ; dkim-atps=neutral
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GtWvv2Nfcz2xrx
 for <linux-erofs@lists.ozlabs.org>; Mon, 23 Aug 2021 22:36:59 +1000 (AEST)
Received: by mail-pf1-x433.google.com with SMTP id v123so535459pfb.11
 for <linux-erofs@lists.ozlabs.org>; Mon, 23 Aug 2021 05:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=h/1VJZ29u4XqurpeYm9kPyaHxVhp2hMYz8l0lY3Ggo0=;
 b=ls2mFJqJZA3tIwzpM+DFxnT3NmdqyePPGohyic0vvblSRxaYyWUqlSRKOm9ea7ZQNG
 xMO2W9p4XBfwhl+C9Pj0mnplSaG1wDFr80q1elP7FrkEXdAgOHktvJXpS0edSARtgxN9
 a05oF06geodXTBOqz4RHkuf4cxWaTLe5GJzol1l14C1Pgdz/qwTrwnq3vV6hIPq2yLPv
 5HwDCqfpxIcgifIh/BY3Q9wPA8BJaeZnzwjXtqLfK6H3HS19R3SQjVkkHdPT8NjCnLHz
 SU57HefqALR5ohRuccSqm3pEFv+ZkqBwS8qSXp3oGyST+pYn5Do/bDulegDY+vIBtToO
 gqfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=h/1VJZ29u4XqurpeYm9kPyaHxVhp2hMYz8l0lY3Ggo0=;
 b=UorvOF0wYniTE19gFmeU8a3HwESYgSHQnp9K9pVgFm0SwkS86yJILV9DFRoobSWFcq
 bm/TujcrinXm/OBkAZkQJCgORRkd9QgU7VpYm8JqGjdGvPFX/VS+iUW5BseFNYeX8cyo
 /zAS+oh8scejkUQI5AXcRT45BmacZqT8e7axl6yt3yyzk+0gK87AbetWSzHSU2vlwgv0
 /Vc28Gibbr7fprDY8uikheJb2reYWck/u+dwMfvGD1dGDV+f63ircnFMaKidEeztoOo3
 sNWmj2wVuozB3XuoN2SF0u3b4ZXQ2GlfICV4/szT8BeR0N3zqheO2+GWi1Y9HguLeIgc
 hEHQ==
X-Gm-Message-State: AOAM531hvkxrP2AHHgm+Hochnpth0OwI2u/6XgcTTQBHnCsv1d43ypZc
 wdaw/FbNDD/gyDzUbrk1Kt0=
X-Google-Smtp-Source: ABdhPJxz2Z7qeaRv352oMdSnoeESnAqyOJ3USftTEwhjQA6KQfK/rAe3lndsKkCyfEoTyKaqsbbHHQ==
X-Received: by 2002:a62:d414:0:b0:3eb:13e2:eccd with SMTP id
 a20-20020a62d414000000b003eb13e2eccdmr10931052pfh.68.1629722216473; 
 Mon, 23 Aug 2021 05:36:56 -0700 (PDT)
Received: from hjn-PC.localdomain (li1080-207.members.linode.com.
 [45.33.61.207])
 by smtp.gmail.com with ESMTPSA id d15sm16376817pfd.115.2021.08.23.05.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Aug 2021 05:36:55 -0700 (PDT)
From: Huang Jianan <jnhuang95@gmail.com>
To: u-boot@lists.denx.de
Subject: [PATCH v2 1/3] fs/erofs: add erofs filesystem support
Date: Mon, 23 Aug 2021 20:36:44 +0800
Message-Id: <20210823123646.9765-2-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210823123646.9765-1-jnhuang95@gmail.com>
References: <20210822154843.10971-1-jnhuang95@gmail.com>
 <20210823123646.9765-1-jnhuang95@gmail.com>
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

This patch mainly deals with uncompressed files.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
---
 fs/Kconfig          |   1 +
 fs/Makefile         |   1 +
 fs/erofs/Kconfig    |  12 ++
 fs/erofs/Makefile   |   7 +
 fs/erofs/data.c     | 124 ++++++++++++++
 fs/erofs/erofs_fs.h | 384 ++++++++++++++++++++++++++++++++++++++++++++
 fs/erofs/fs.c       | 231 ++++++++++++++++++++++++++
 fs/erofs/internal.h | 203 +++++++++++++++++++++++
 fs/erofs/namei.c    | 238 +++++++++++++++++++++++++++
 fs/erofs/super.c    |  65 ++++++++
 fs/fs.c             |  22 +++
 include/erofs.h     |  19 +++
 include/fs.h        |   1 +
 13 files changed, 1308 insertions(+)
 create mode 100644 fs/erofs/Kconfig
 create mode 100644 fs/erofs/Makefile
 create mode 100644 fs/erofs/data.c
 create mode 100644 fs/erofs/erofs_fs.h
 create mode 100644 fs/erofs/fs.c
 create mode 100644 fs/erofs/internal.h
 create mode 100644 fs/erofs/namei.c
 create mode 100644 fs/erofs/super.c
 create mode 100644 include/erofs.h

diff --git a/fs/Kconfig b/fs/Kconfig
index 620af7f044..4d04c2c2ce 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -24,4 +24,5 @@ source "fs/yaffs2/Kconfig"
 
 source "fs/squashfs/Kconfig"
 
+source "fs/erofs/Kconfig"
 endmenu
diff --git a/fs/Makefile b/fs/Makefile
index 937cbcf6e8..f05a21c9e6 100644
--- a/fs/Makefile
+++ b/fs/Makefile
@@ -25,5 +25,6 @@ obj-$(CONFIG_CMD_UBIFS) += ubifs/
 obj-$(CONFIG_YAFFS2) += yaffs2/
 obj-$(CONFIG_CMD_ZFS) += zfs/
 obj-$(CONFIG_FS_SQUASHFS) += squashfs/
+obj-$(CONFIG_FS_EROFS) += erofs/
 endif
 obj-y += fs_internal.o
diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
new file mode 100644
index 0000000000..f4b2d51a23
--- /dev/null
+++ b/fs/erofs/Kconfig
@@ -0,0 +1,12 @@
+config FS_EROFS
+	bool "Enable EROFS filesystem support"
+	help
+	  This provides support for reading images from EROFS filesystem.
+	  EROFS (Enhanced Read-Only File System) is a lightweight read-only
+	  file system for scenarios which need high-performance read-only
+	  requirements.
+
+	  It also provides fixed-sized output compression support, which
+	  improves storage density, keeps relatively higher compression
+	  ratios, which is more useful to achieve high performance for
+	  embedded devices with limited memory.
diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
new file mode 100644
index 0000000000..7398ab7a36
--- /dev/null
+++ b/fs/erofs/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+
+obj-$(CONFIG_$(SPL_)FS_EROFS) = fs.o \
+				super.o \
+				namei.o \
+				data.o
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
new file mode 100644
index 0000000000..a0f613264a
--- /dev/null
+++ b/fs/erofs/data.c
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include "internal.h"
+
+static int erofs_map_blocks_flatmode(struct erofs_inode *inode,
+				     struct erofs_map_blocks *map,
+				     int flags)
+{
+	int err = 0;
+	erofs_blk_t nblocks, lastblk;
+	u64 offset = map->m_la;
+	struct erofs_inode *vi = inode;
+	bool tailendpacking = (vi->datalayout == EROFS_INODE_FLAT_INLINE);
+
+	nblocks = DIV_ROUND_UP(inode->i_size, EROFS_BLKSIZ);
+	lastblk = nblocks - tailendpacking;
+
+	if (offset >= inode->i_size) {
+		/* leave out-of-bound access unmapped */
+		map->m_flags = 0;
+		map->m_plen = 0;
+		goto out;
+	}
+
+	/* there is no hole in flatmode */
+	map->m_flags = EROFS_MAP_MAPPED;
+
+	if (offset < blknr_to_addr(lastblk)) {
+		map->m_pa = blknr_to_addr(vi->u.i_blkaddr) + map->m_la;
+		map->m_plen = blknr_to_addr(lastblk) - offset;
+	} else if (tailendpacking) {
+		/* 2 - inode inline B: inode, [xattrs], inline last blk... */
+		map->m_pa = iloc(vi->nid) + vi->inode_isize +
+			vi->xattr_isize + erofs_blkoff(map->m_la);
+		map->m_plen = inode->i_size - offset;
+
+		/* inline data should be located in one meta block */
+		if (erofs_blkoff(map->m_pa) + map->m_plen > PAGE_SIZE) {
+			erofs_err("inline data cross block boundary @ nid %" PRIu64,
+				  vi->nid);
+			DBG_BUGON(1);
+			err = -EFSCORRUPTED;
+			goto err_out;
+		}
+
+		map->m_flags |= EROFS_MAP_META;
+	} else {
+		erofs_err("internal error @ nid: %" PRIu64 " (size %llu), m_la 0x%" PRIx64,
+			  vi->nid, (unsigned long long)inode->i_size, map->m_la);
+		DBG_BUGON(1);
+		err = -EIO;
+		goto err_out;
+	}
+
+out:
+	map->m_llen = map->m_plen;
+
+err_out:
+	return err;
+}
+
+static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
+			       erofs_off_t size, erofs_off_t offset)
+{
+	struct erofs_map_blocks map = {
+		.index = UINT_MAX,
+	};
+	int ret;
+	erofs_off_t ptr = offset;
+
+	while (ptr < offset + size) {
+		char *const estart = buffer + ptr - offset;
+		erofs_off_t eend;
+
+		map.m_la = ptr;
+		ret = erofs_map_blocks_flatmode(inode, &map, 0);
+		if (ret)
+			return ret;
+
+		DBG_BUGON(map.m_plen != map.m_llen);
+
+		/* trim extent */
+		eend = min(offset + size, map.m_la + map.m_llen);
+		DBG_BUGON(ptr < map.m_la);
+
+		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+			if (!map.m_llen) {
+				/* reached EOF */
+				memset(estart, 0, offset + size - ptr);
+				ptr = offset + size;
+				continue;
+			}
+			memset(estart, 0, eend - ptr);
+			ptr = eend;
+			continue;
+		}
+
+		if (ptr > map.m_la) {
+			map.m_pa += ptr - map.m_la;
+			map.m_la = ptr;
+		}
+
+		ret = erofs_dev_read(estart, map.m_pa, eend - map.m_la);
+		if (ret < 0)
+			return -EIO;
+		ptr = eend;
+	}
+	return 0;
+}
+
+int erofs_pread(struct erofs_inode *inode, char *buf,
+		erofs_off_t count, erofs_off_t offset)
+{
+	switch (inode->datalayout) {
+	case EROFS_INODE_FLAT_PLAIN:
+	case EROFS_INODE_FLAT_INLINE:
+		return erofs_read_raw_data(inode, buf, count, offset);
+	case EROFS_INODE_FLAT_COMPRESSION_LEGACY:
+	case EROFS_INODE_FLAT_COMPRESSION:
+		return -EOPNOTSUPP;
+	default:
+		break;
+	}
+	return -EINVAL;
+}
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
new file mode 100644
index 0000000000..070087fa60
--- /dev/null
+++ b/fs/erofs/erofs_fs.h
@@ -0,0 +1,384 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
+/*
+ * EROFS (Enhanced ROM File System) on-disk format definition
+ *
+ * Copyright (C) 2017-2018 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ */
+#ifndef __EROFS_FS_H
+#define __EROFS_FS_H
+
+#include <asm/unaligned.h>
+#include <fs.h>
+#include <part.h>
+#include <stdint.h>
+
+#define EROFS_SUPER_MAGIC_V1    0xE0F5E1E2
+#define EROFS_SUPER_OFFSET      1024
+
+#define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
+
+/*
+ * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
+ * be incompatible with this kernel version.
+ */
+#define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
+#define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
+#define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
+#define EROFS_ALL_FEATURE_INCOMPAT		\
+	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
+	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
+	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER)
+
+#define EROFS_SB_EXTSLOT_SIZE	16
+
+/* erofs on-disk super block (currently 128 bytes) */
+struct erofs_super_block {
+	__le32 magic;           /* file system magic number */
+	__le32 checksum;        /* crc32c(super_block) */
+	__le32 feature_compat;
+	__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
+	__u8 sb_extslots;	/* superblock size = 128 + sb_extslots * 16 */
+
+	__le16 root_nid;	/* nid of root directory */
+	__le64 inos;            /* total valid ino # (== f_files - f_favail) */
+
+	__le64 build_time;      /* inode v1 time derivation */
+	__le32 build_time_nsec;	/* inode v1 time derivation in nano scale */
+	__le32 blocks;          /* used for statfs */
+	__le32 meta_blkaddr;	/* start block address of metadata area */
+	__le32 xattr_blkaddr;	/* start block address of shared xattr area */
+	__u8 uuid[16];          /* 128-bit uuid for volume */
+	__u8 volume_name[16];   /* volume name */
+	__le32 feature_incompat;
+	union {
+		/* bitmap for available compression algorithms */
+		__le16 available_compr_algs;
+		/* customized sliding window size instead of 64k by default */
+		__le16 lz4_max_distance;
+	} __packed u1;
+	__u8 reserved2[42];
+};
+
+/*
+ * erofs inode datalayout (i_format in on-disk inode):
+ * 0 - inode plain without inline data A:
+ * inode, [xattrs], ... | ... | no-holed data
+ * 1 - inode VLE compression B (legacy):
+ * inode, [xattrs], extents ... | ...
+ * 2 - inode plain with inline data C:
+ * inode, [xattrs], last_inline_data, ... | ... | no-holed data
+ * 3 - inode compression D:
+ * inode, [xattrs], map_header, extents ... | ...
+ * 4 - inode chunk-based E:
+ * inode, [xattrs], chunk indexes ... | ...
+ * 5~7 - reserved
+ */
+enum {
+	EROFS_INODE_FLAT_PLAIN			= 0,
+	EROFS_INODE_FLAT_COMPRESSION_LEGACY	= 1,
+	EROFS_INODE_FLAT_INLINE			= 2,
+	EROFS_INODE_FLAT_COMPRESSION		= 3,
+	EROFS_INODE_CHUNK_BASED			= 4,
+	EROFS_INODE_DATALAYOUT_MAX
+};
+
+static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
+{
+	return datamode == EROFS_INODE_FLAT_COMPRESSION ||
+		datamode == EROFS_INODE_FLAT_COMPRESSION_LEGACY;
+}
+
+/* bit definitions of inode i_advise */
+#define EROFS_I_VERSION_BITS            1
+#define EROFS_I_DATALAYOUT_BITS         3
+
+#define EROFS_I_VERSION_BIT             0
+#define EROFS_I_DATALAYOUT_BIT          1
+
+#define EROFS_I_ALL	\
+	((1 << (EROFS_I_DATALAYOUT_BIT + EROFS_I_DATALAYOUT_BITS)) - 1)
+
+/* indicate chunk blkbits, thus 'chunksize = blocksize << chunk blkbits' */
+#define EROFS_CHUNK_FORMAT_BLKBITS_MASK		0x001F
+/* with chunk indexes or just a 4-byte blkaddr array */
+#define EROFS_CHUNK_FORMAT_INDEXES		0x0020
+
+#define EROFS_CHUNK_FORMAT_ALL	\
+	(EROFS_CHUNK_FORMAT_BLKBITS_MASK | EROFS_CHUNK_FORMAT_INDEXES)
+
+struct erofs_inode_chunk_info {
+	__le16 format;		/* chunk blkbits, etc. */
+	__le16 reserved;
+};
+
+/* 32-byte reduced form of an ondisk inode */
+struct erofs_inode_compact {
+	__le16 i_format;	/* inode format hints */
+
+/* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
+	__le16 i_xattr_icount;
+	__le16 i_mode;
+	__le16 i_nlink;
+	__le32 i_size;
+	__le32 i_reserved;
+	union {
+		/* file total compressed blocks for data mapping 1 */
+		__le32 compressed_blocks;
+		__le32 raw_blkaddr;
+
+		/* for device files, used to indicate old/new device # */
+		__le32 rdev;
+
+		/* for chunk-based files, it contains the summary info */
+		struct erofs_inode_chunk_info c;
+	} i_u;
+	__le32 i_ino;           /* only used for 32-bit stat compatibility */
+	__le16 i_uid;
+	__le16 i_gid;
+	__le32 i_reserved2;
+};
+
+/* 32 bytes on-disk inode */
+#define EROFS_INODE_LAYOUT_COMPACT	0
+/* 64 bytes on-disk inode */
+#define EROFS_INODE_LAYOUT_EXTENDED	1
+
+/* 64-byte complete form of an ondisk inode */
+struct erofs_inode_extended {
+	__le16 i_format;	/* inode format hints */
+
+/* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
+	__le16 i_xattr_icount;
+	__le16 i_mode;
+	__le16 i_reserved;
+	__le64 i_size;
+	union {
+		/* file total compressed blocks for data mapping 1 */
+		__le32 compressed_blocks;
+		__le32 raw_blkaddr;
+
+		/* for device files, used to indicate old/new device # */
+		__le32 rdev;
+
+		/* for chunk-based files, it contains the summary info */
+		struct erofs_inode_chunk_info c;
+	} i_u;
+
+	/* only used for 32-bit stat compatibility */
+	__le32 i_ino;
+
+	__le32 i_uid;
+	__le32 i_gid;
+	__le64 i_ctime;
+	__le32 i_ctime_nsec;
+	__le32 i_nlink;
+	__u8   i_reserved2[16];
+};
+
+#define EROFS_MAX_SHARED_XATTRS         (128)
+/* h_shared_count between 129 ... 255 are special # */
+#define EROFS_SHARED_XATTR_EXTENT       (255)
+
+/*
+ * inline xattrs (n == i_xattr_icount):
+ * erofs_xattr_ibody_header(1) + (n - 1) * 4 bytes
+ *          12 bytes           /                   \
+ *                            /                     \
+ *                           /-----------------------\
+ *                           |  erofs_xattr_entries+ |
+ *                           +-----------------------+
+ * inline xattrs must starts in erofs_xattr_ibody_header,
+ * for read-only fs, no need to introduce h_refcount
+ */
+struct erofs_xattr_ibody_header {
+	__le32 h_reserved;
+	__u8   h_shared_count;
+	__u8   h_reserved2[7];
+	__le32 h_shared_xattrs[0];      /* shared xattr id array */
+};
+
+/* Name indexes */
+#define EROFS_XATTR_INDEX_USER              1
+#define EROFS_XATTR_INDEX_POSIX_ACL_ACCESS  2
+#define EROFS_XATTR_INDEX_POSIX_ACL_DEFAULT 3
+#define EROFS_XATTR_INDEX_TRUSTED           4
+#define EROFS_XATTR_INDEX_LUSTRE            5
+#define EROFS_XATTR_INDEX_SECURITY          6
+
+/* xattr entry (for both inline & shared xattrs) */
+struct erofs_xattr_entry {
+	__u8   e_name_len;      /* length of name */
+	__u8   e_name_index;    /* attribute name index */
+	__le16 e_value_size;    /* size of attribute value */
+	/* followed by e_name and e_value */
+	char   e_name[0];       /* attribute name */
+};
+
+static inline unsigned int erofs_xattr_ibody_size(__le16 i_xattr_icount)
+{
+	if (!i_xattr_icount)
+		return 0;
+
+	return sizeof(struct erofs_xattr_ibody_header) +
+		sizeof(__u32) * (le16_to_cpu(i_xattr_icount) - 1);
+}
+
+#define EROFS_XATTR_ALIGN(size) round_up(size, sizeof(struct erofs_xattr_entry))
+
+static inline unsigned int erofs_xattr_entry_size(struct erofs_xattr_entry *e)
+{
+	return EROFS_XATTR_ALIGN(sizeof(struct erofs_xattr_entry) +
+				 e->e_name_len + le16_to_cpu(e->e_value_size));
+}
+
+/* maximum supported size of a physical compression cluster */
+#define Z_EROFS_PCLUSTER_MAX_SIZE	(1024 * 1024)
+
+/* available compression algorithm types (for h_algorithmtype) */
+enum {
+	Z_EROFS_COMPRESSION_LZ4	= 0,
+	Z_EROFS_COMPRESSION_MAX
+};
+#define Z_EROFS_ALL_COMPR_ALGS		(1 << (Z_EROFS_COMPRESSION_MAX - 1))
+
+/* 14 bytes (+ length field = 16 bytes) */
+struct z_erofs_lz4_cfgs {
+	__le16 max_distance;
+	__le16 max_pclusterblks;
+	u8 reserved[10];
+} __packed;
+
+/*
+ * bit 0 : COMPACTED_2B indexes (0 - off; 1 - on)
+ *  e.g. for 4k logical cluster size,      4B        if compacted 2B is off;
+ *                                  (4B) + 2B + (4B) if compacted 2B is on.
+ * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
+ * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
+ */
+#define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
+#define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
+#define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
+
+struct z_erofs_map_header {
+	__le32	h_reserved1;
+	__le16	h_advise;
+	/*
+	 * bit 0-3 : algorithm type of head 1 (logical cluster type 01);
+	 * bit 4-7 : algorithm type of head 2 (logical cluster type 11).
+	 */
+	__u8	h_algorithmtype;
+	/*
+	 * bit 0-2 : logical cluster bits - 12, e.g. 0 for 4096;
+	 * bit 3-7 : reserved.
+	 */
+	__u8	h_clusterbits;
+};
+
+#define Z_EROFS_VLE_LEGACY_HEADER_PADDING       8
+
+/*
+ * Fixed-sized output compression ondisk Logical Extent cluster type:
+ *    0 - literal (uncompressed) cluster
+ *    1 - compressed cluster (for the head logical cluster)
+ *    2 - compressed cluster (for the other logical clusters)
+ *
+ * In detail,
+ *    0 - literal (uncompressed) cluster,
+ *        di_advise = 0
+ *        di_clusterofs = the literal data offset of the cluster
+ *        di_blkaddr = the blkaddr of the literal cluster
+ *
+ *    1 - compressed cluster (for the head logical cluster)
+ *        di_advise = 1
+ *        di_clusterofs = the decompressed data offset of the cluster
+ *        di_blkaddr = the blkaddr of the compressed cluster
+ *
+ *    2 - compressed cluster (for the other logical clusters)
+ *        di_advise = 2
+ *        di_clusterofs =
+ *           the decompressed data offset in its own head cluster
+ *        di_u.delta[0] = distance to its corresponding head cluster
+ *        di_u.delta[1] = distance to its corresponding tail cluster
+ *                (di_advise could be 0, 1 or 2)
+ */
+enum {
+	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN		= 0,
+	Z_EROFS_VLE_CLUSTER_TYPE_HEAD		= 1,
+	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD	= 2,
+	Z_EROFS_VLE_CLUSTER_TYPE_RESERVED	= 3,
+	Z_EROFS_VLE_CLUSTER_TYPE_MAX
+};
+
+#define Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS        2
+#define Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT         0
+
+/*
+ * D0_CBLKCNT will be marked _only_ at the 1st non-head lcluster to store the
+ * compressed block count of a compressed extent (in logical clusters, aka.
+ * block count of a pcluster).
+ */
+#define Z_EROFS_VLE_DI_D0_CBLKCNT		(1 << 11)
+
+struct z_erofs_vle_decompressed_index {
+	__le16 di_advise;
+	/* where to decompress in the head cluster */
+	__le16 di_clusterofs;
+
+	union {
+		/* for the head cluster */
+		__le32 blkaddr;
+		/*
+		 * for the rest clusters
+		 * eg. for 4k page-sized cluster, maximum 4K*64k = 256M)
+		 * [0] - pointing to the head cluster
+		 * [1] - pointing to the tail cluster
+		 */
+		__le16 delta[2];
+	} di_u;
+};
+
+#define Z_EROFS_VLE_LEGACY_INDEX_ALIGN(size) \
+	(round_up(size, sizeof(struct z_erofs_vle_decompressed_index)) + \
+	 sizeof(struct z_erofs_map_header) + Z_EROFS_VLE_LEGACY_HEADER_PADDING)
+
+/* dirent sorts in alphabet order, thus we can do binary search */
+struct erofs_dirent {
+	__le64 nid;     /* node number */
+	__le16 nameoff; /* start offset of file name */
+	__u8 file_type; /* file type */
+	__u8 reserved;  /* reserved */
+} __packed;
+
+/* file types used in inode_info->flags */
+enum {
+	EROFS_FT_UNKNOWN,
+	EROFS_FT_REG_FILE,
+	EROFS_FT_DIR,
+	EROFS_FT_CHRDEV,
+	EROFS_FT_BLKDEV,
+	EROFS_FT_FIFO,
+	EROFS_FT_SOCK,
+	EROFS_FT_SYMLINK,
+	EROFS_FT_MAX
+};
+
+#define EROFS_NAME_LEN      255
+
+/* check the EROFS on-disk layout strictly at compile time */
+static inline void erofs_check_ondisk_layout_definitions(void)
+{
+	BUILD_BUG_ON(sizeof(struct erofs_super_block) != 128);
+	BUILD_BUG_ON(sizeof(struct erofs_inode_compact) != 32);
+	BUILD_BUG_ON(sizeof(struct erofs_inode_extended) != 64);
+	BUILD_BUG_ON(sizeof(struct erofs_xattr_ibody_header) != 12);
+	BUILD_BUG_ON(sizeof(struct erofs_xattr_entry) != 4);
+	BUILD_BUG_ON(sizeof(struct z_erofs_map_header) != 8);
+	BUILD_BUG_ON(sizeof(struct z_erofs_vle_decompressed_index) != 8);
+	BUILD_BUG_ON(sizeof(struct erofs_dirent) != 12);
+
+	BUILD_BUG_ON(BIT(Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) <
+		     Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
+}
+
+#endif
diff --git a/fs/erofs/fs.c b/fs/erofs/fs.c
new file mode 100644
index 0000000000..0269492d8c
--- /dev/null
+++ b/fs/erofs/fs.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include "internal.h"
+#include <fs_internal.h>
+
+struct erofs_sb_info erofs_sbi;
+
+static struct erofs_ctxt {
+	struct disk_partition cur_part_info;
+	struct blk_desc *cur_dev;
+} ctxt;
+
+int erofs_dev_read(void *buf, u64 offset, size_t len)
+{
+	lbaint_t sect = offset >> ctxt.cur_dev->log2blksz;
+	int off = offset & (ctxt.cur_dev->blksz - 1);
+
+	if (!ctxt.cur_dev)
+		return -EIO;
+
+	if (fs_devread(ctxt.cur_dev, &ctxt.cur_part_info, sect,
+			 off, len, buf))
+		return 0;
+	return -EIO;
+}
+
+int erofs_blk_read(void *buf, erofs_blk_t start, u32 nblocks)
+{
+	return erofs_dev_read(buf, blknr_to_addr(start),
+			 blknr_to_addr(nblocks));
+}
+
+int erofs_probe(struct blk_desc *fs_dev_desc,
+		struct disk_partition *fs_partition)
+{
+	int ret;
+
+	ctxt.cur_dev = fs_dev_desc;
+	ctxt.cur_part_info = *fs_partition;
+
+	ret = erofs_read_superblock();
+	if (ret)
+		goto error;
+
+	return 0;
+error:
+	ctxt.cur_dev = NULL;
+	return ret;
+}
+
+struct erofs_dir_stream {
+	struct fs_dir_stream fs_dirs;
+	struct fs_dirent dirent;
+
+	struct erofs_inode inode;
+	char dblk[EROFS_BLKSIZ];
+	unsigned int maxsize, de_end;
+	erofs_off_t pos;
+};
+
+int erofs_opendir(const char *filename, struct fs_dir_stream **dirsp)
+{
+	struct erofs_dir_stream *dirs;
+	int err;
+
+	dirs = calloc(1, sizeof(*dirs));
+	if (!dirs)
+		return -ENOMEM;
+
+	err = erofs_ilookup(filename, &dirs->inode);
+	if (err)
+		goto err_out;
+
+	if (!S_ISDIR(dirs->inode.i_mode)) {
+		err = -ENOTDIR;
+		goto err_out;
+	}
+	*dirsp = (struct fs_dir_stream *)dirs;
+	return 0;
+err_out:
+	free(dirs);
+	return err;
+}
+
+int erofs_readdir(struct fs_dir_stream *fs_dirs, struct fs_dirent **dentp)
+{
+	struct erofs_dir_stream *dirs = (struct erofs_dir_stream *)fs_dirs;
+	struct fs_dirent *dent = &dirs->dirent;
+	erofs_off_t pos = dirs->pos;
+	unsigned int nameoff, de_namelen;
+	struct erofs_dirent *de;
+	char *de_name;
+	int err;
+
+	if (pos >= dirs->inode.i_size)
+		return 1;
+
+	if (!dirs->maxsize) {
+		dirs->maxsize = min_t(unsigned int, EROFS_BLKSIZ,
+				      dirs->inode.i_size - pos);
+
+		err = erofs_pread(&dirs->inode, dirs->dblk,
+				  dirs->maxsize, pos);
+		if (err)
+			return err;
+
+		de = (struct erofs_dirent *)dirs->dblk;
+		dirs->de_end = le16_to_cpu(de->nameoff);
+		if (dirs->de_end < sizeof(struct erofs_dirent) ||
+		    dirs->de_end >= EROFS_BLKSIZ) {
+			erofs_err("invalid de[0].nameoff %u @ nid %llu",
+				  nameoff, de->nid | 0ULL);
+			return -EFSCORRUPTED;
+		}
+	}
+
+	de = (struct erofs_dirent *)(dirs->dblk + erofs_blkoff(pos));
+	nameoff = le16_to_cpu(de->nameoff);
+	de_name = (char *)dirs->dblk + nameoff;
+
+	/* the last dirent in the block? */
+	if (de + 1 >= (struct erofs_dirent *)(dirs->dblk + dirs->de_end))
+		de_namelen = strnlen(de_name, dirs->maxsize - nameoff);
+	else
+		de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+
+	/* a corrupted entry is found */
+	if (nameoff + de_namelen > dirs->maxsize ||
+	    de_namelen > EROFS_NAME_LEN) {
+		erofs_err("bogus dirent @ nid %llu", de->nid | 0ULL);
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
+
+	memcpy(dent->name, de_name, de_namelen);
+	dent->name[de_namelen] = '\0';
+
+	if (de->file_type == EROFS_FT_DIR) {
+		dent->type = FS_DT_DIR;
+	} else if (de->file_type == EROFS_FT_SYMLINK) {
+		dent->type = FS_DT_LNK;
+	} else {
+		struct erofs_inode vi;
+
+		dent->type = FS_DT_REG;
+		vi.nid = de->nid;
+
+		err = erofs_read_inode_from_disk(&vi);
+		if (err)
+			return err;
+		dent->size = vi.i_size;
+	}
+	*dentp = dent;
+
+	pos += sizeof(*de);
+	if (erofs_blkoff(pos) >= dirs->de_end) {
+		pos = blknr_to_addr(erofs_blknr(pos) + 1);
+		dirs->maxsize = 0;
+	}
+	dirs->pos = pos;
+	return 0;
+}
+
+void erofs_closedir(struct fs_dir_stream *fs_dirs)
+{
+	free(fs_dirs);
+}
+
+int erofs_exists(const char *filename)
+{
+	struct erofs_inode vi;
+	int err;
+
+	err = erofs_ilookup(filename, &vi);
+	return err == 0;
+}
+
+int erofs_size(const char *filename, loff_t *size)
+{
+	struct erofs_inode vi;
+	int err;
+
+	err = erofs_ilookup(filename, &vi);
+	if (err)
+		return err;
+	*size = vi.i_size;
+	return 0;
+}
+
+int erofs_read(const char *filename, void *buf, loff_t offset, loff_t len,
+	      loff_t *actread)
+{
+	struct erofs_inode vi;
+	int err;
+
+	err = erofs_ilookup(filename, &vi);
+	if (err)
+		return err;
+
+	if (!len)
+		len = vi.i_size;
+
+	err = erofs_pread(&vi, buf, len, offset);
+	if (err) {
+		*actread = 0;
+		return err;
+	}
+
+	if (offset >= vi.i_size)
+		*actread = 0;
+	else if (offset + len > vi.i_size)
+		*actread = vi.i_size - offset;
+	else
+		*actread = len;
+	return 0;
+}
+
+void erofs_close(void)
+{
+	ctxt.cur_dev = NULL;
+}
+
+int erofs_uuid(char *uuid_str)
+{
+#ifdef CONFIG_LIB_UUID
+	if (ctxt.cur_dev)
+		uuid_bin_to_str(erofs_sbi.uuid, uuid_str,
+				UUID_STR_FORMAT_STD);
+	return 0;
+#endif
+	return -ENOSYS;
+}
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
new file mode 100644
index 0000000000..02dfd7ead4
--- /dev/null
+++ b/fs/erofs/internal.h
@@ -0,0 +1,203 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __EROFS_INTERNAL_H
+#define __EROFS_INTERNAL_H
+
+#define __packed __attribute__((__packed__))
+
+#include <linux/stat.h>
+#include <linux/bug.h>
+#include <linux/err.h>
+#include <linux/printk.h>
+#include <inttypes.h>
+#include "erofs_fs.h"
+
+#define erofs_err(fmt, ...)	\
+	pr_err(fmt "\n", ##__VA_ARGS__)
+
+#define erofs_info(fmt, ...)	\
+	pr_info(fmt "\n", ##__VA_ARGS__)
+
+#define erofs_dbg(fmt, ...)	\
+	pr_debug(fmt "\n", ##__VA_ARGS__)
+
+#define DBG_BUGON(condition)	BUG_ON(condition)
+
+/* no obvious reason to support explicit PAGE_SIZE != 4096 for now */
+#if PAGE_SIZE != 4096
+#error incompatible PAGE_SIZE is already defined
+#endif
+
+#define PAGE_MASK		(~(PAGE_SIZE-1))
+
+#define LOG_BLOCK_SIZE          (12)
+#define EROFS_BLKSIZ            (1U << LOG_BLOCK_SIZE)
+
+#define EROFS_ISLOTBITS		5
+#define EROFS_SLOTSIZE		(1U << EROFS_ISLOTBITS)
+
+typedef u64 erofs_off_t;
+typedef u64 erofs_nid_t;
+/* data type for filesystem-wide blocks number */
+typedef u32 erofs_blk_t;
+
+#define NULL_ADDR	((unsigned int)-1)
+#define NULL_ADDR_UL	((unsigned long)-1)
+
+#define erofs_blknr(addr)       ((addr) / EROFS_BLKSIZ)
+#define erofs_blkoff(addr)      ((addr) % EROFS_BLKSIZ)
+#define blknr_to_addr(nr)       ((erofs_off_t)(nr) * EROFS_BLKSIZ)
+
+#define BLK_ROUND_UP(addr)	DIV_ROUND_UP(addr, EROFS_BLKSIZ)
+
+struct erofs_sb_info {
+	u64 blocks;
+
+	erofs_blk_t meta_blkaddr;
+	erofs_blk_t xattr_blkaddr;
+
+	u32 feature_compat;
+	u32 feature_incompat;
+	u64 build_time;
+	u32 build_time_nsec;
+
+	unsigned char islotbits;
+
+	/* what we really care is nid, rather than ino.. */
+	erofs_nid_t root_nid;
+	/* used for statfs, f_files - f_favail */
+	u64 inos;
+
+	u8 uuid[16];
+
+	u16 available_compr_algs;
+	u16 lz4_max_distance;
+};
+
+/* global sbi */
+extern struct erofs_sb_info erofs_sbi;
+
+static inline erofs_off_t iloc(erofs_nid_t nid)
+{
+	return blknr_to_addr(erofs_sbi.meta_blkaddr) +
+		(nid << erofs_sbi.islotbits);
+}
+
+#define EROFS_FEATURE_FUNCS(name, compat, feature) \
+static inline bool erofs_sb_has_##name(void) \
+{ \
+	return erofs_sbi.feature_##compat & EROFS_FEATURE_##feature; \
+}
+
+EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
+EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
+EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
+EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
+
+#define EROFS_I_EA_INITED	(1 << 0)
+#define EROFS_I_Z_INITED	(1 << 1)
+
+struct erofs_inode {
+	unsigned int flags;
+	umode_t i_mode;
+	erofs_off_t i_size;
+
+	u64 i_ino[2];
+	u32 i_uid;
+	u32 i_gid;
+	u64 i_ctime;
+	u32 i_ctime_nsec;
+	u32 i_nlink;
+
+	union {
+		u32 i_blkaddr;
+		u32 i_blocks;
+		u32 i_rdev;
+	} u;
+
+	unsigned char datalayout;
+	unsigned char inode_isize;
+	unsigned int xattr_isize;
+	unsigned int extent_isize;
+
+	erofs_nid_t nid;
+
+	struct {
+		uint16_t z_advise;
+		uint8_t  z_algorithmtype[2];
+		uint8_t  z_logical_clusterbits;
+	};
+};
+
+static inline bool is_inode_layout_compression(struct erofs_inode *inode)
+{
+	return erofs_inode_is_data_compressed(inode->datalayout);
+}
+
+static inline unsigned int erofs_bitrange(unsigned int value, unsigned int bit,
+					  unsigned int bits)
+{
+	return (value >> bit) & ((1 << bits) - 1);
+}
+
+static inline unsigned int erofs_inode_version(unsigned int value)
+{
+	return erofs_bitrange(value, EROFS_I_VERSION_BIT,
+			      EROFS_I_VERSION_BITS);
+}
+
+static inline unsigned int erofs_inode_datalayout(unsigned int value)
+{
+	return erofs_bitrange(value, EROFS_I_DATALAYOUT_BIT,
+			      EROFS_I_DATALAYOUT_BITS);
+}
+
+#define IS_ROOT(x)	((x) == (x)->i_parent)
+
+static inline bool is_dot_dotdot(const char *name)
+{
+	if (name[0] != '.')
+		return false;
+
+	return name[1] == '\0' || (name[1] == '.' && name[2] == '\0');
+}
+
+enum {
+	BH_Meta,
+	BH_Mapped,
+	BH_Zipped,
+	BH_FullMapped,
+};
+
+/* Has a disk mapping */
+#define EROFS_MAP_MAPPED	(1 << BH_Mapped)
+/* Located in metadata (could be copied from bd_inode) */
+#define EROFS_MAP_META		(1 << BH_Meta)
+/* The extent has been compressed */
+#define EROFS_MAP_ZIPPED	(1 << BH_Zipped)
+/* The length of extent is full */
+#define EROFS_MAP_FULL_MAPPED	(1 << BH_FullMapped)
+
+struct erofs_map_blocks {
+	char mpage[EROFS_BLKSIZ];
+
+	erofs_off_t m_pa, m_la;
+	u64 m_plen, m_llen;
+
+	unsigned int m_flags;
+	erofs_blk_t index;
+};
+
+int erofs_blk_read(void *buf, erofs_blk_t start, u32 nblocks);
+int erofs_dev_read(void *buf, u64 offset, size_t len);
+
+int erofs_read_superblock(void);
+int erofs_read_inode_from_disk(struct erofs_inode *vi);
+int erofs_ilookup(const char *path, struct erofs_inode *vi);
+int erofs_pread(struct erofs_inode *inode, char *buf,
+		erofs_off_t count, erofs_off_t offset);
+int z_erofs_fill_inode(struct erofs_inode *vi);
+int z_erofs_map_blocks_iter(struct erofs_inode *vi,
+			    struct erofs_map_blocks *map);
+
+#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
+#endif
diff --git a/fs/erofs/namei.c b/fs/erofs/namei.c
new file mode 100644
index 0000000000..4c5d614483
--- /dev/null
+++ b/fs/erofs/namei.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include "internal.h"
+
+int erofs_read_inode_from_disk(struct erofs_inode *vi)
+{
+	int ret, ifmt;
+	char buf[sizeof(struct erofs_inode_extended)];
+	struct erofs_inode_compact *dic;
+	struct erofs_inode_extended *die;
+	const erofs_off_t inode_loc = iloc(vi->nid);
+
+	ret = erofs_dev_read(buf, inode_loc, sizeof(*dic));
+	if (ret < 0)
+		return -EIO;
+
+	dic = (struct erofs_inode_compact *)buf;
+	ifmt = le16_to_cpu(dic->i_format);
+
+	vi->datalayout = erofs_inode_datalayout(ifmt);
+	if (vi->datalayout >= EROFS_INODE_DATALAYOUT_MAX) {
+		erofs_err("unsupported datalayout %u of nid %llu",
+			  vi->datalayout, vi->nid | 0ULL);
+		return -EOPNOTSUPP;
+	}
+	switch (erofs_inode_version(ifmt)) {
+	case EROFS_INODE_LAYOUT_EXTENDED:
+		vi->inode_isize = sizeof(struct erofs_inode_extended);
+
+		ret = erofs_dev_read(buf + sizeof(*dic), inode_loc + sizeof(*dic),
+			       sizeof(*die) - sizeof(*dic));
+		if (ret < 0)
+			return -EIO;
+
+		die = (struct erofs_inode_extended *)buf;
+		vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
+		vi->i_mode = le16_to_cpu(die->i_mode);
+
+		switch (vi->i_mode & S_IFMT) {
+		case S_IFREG:
+		case S_IFDIR:
+		case S_IFLNK:
+			vi->u.i_blkaddr = le32_to_cpu(die->i_u.raw_blkaddr);
+			break;
+		case S_IFCHR:
+		case S_IFBLK:
+			vi->u.i_rdev = 0;
+			break;
+		case S_IFIFO:
+		case S_IFSOCK:
+			vi->u.i_rdev = 0;
+			break;
+		default:
+			goto bogusimode;
+		}
+
+		vi->i_uid = le32_to_cpu(die->i_uid);
+		vi->i_gid = le32_to_cpu(die->i_gid);
+		vi->i_nlink = le32_to_cpu(die->i_nlink);
+
+		vi->i_ctime = le64_to_cpu(die->i_ctime);
+		vi->i_ctime_nsec = le64_to_cpu(die->i_ctime_nsec);
+		vi->i_size = le64_to_cpu(die->i_size);
+		break;
+	case EROFS_INODE_LAYOUT_COMPACT:
+		vi->inode_isize = sizeof(struct erofs_inode_compact);
+		vi->xattr_isize = erofs_xattr_ibody_size(dic->i_xattr_icount);
+		vi->i_mode = le16_to_cpu(dic->i_mode);
+
+		switch (vi->i_mode & S_IFMT) {
+		case S_IFREG:
+		case S_IFDIR:
+		case S_IFLNK:
+			vi->u.i_blkaddr = le32_to_cpu(dic->i_u.raw_blkaddr);
+			break;
+		case S_IFCHR:
+		case S_IFBLK:
+			vi->u.i_rdev = 0;
+			break;
+		case S_IFIFO:
+		case S_IFSOCK:
+			vi->u.i_rdev = 0;
+			break;
+		default:
+			goto bogusimode;
+		}
+
+		vi->i_uid = le16_to_cpu(dic->i_uid);
+		vi->i_gid = le16_to_cpu(dic->i_gid);
+		vi->i_nlink = le16_to_cpu(dic->i_nlink);
+
+		vi->i_ctime = erofs_sbi.build_time;
+		vi->i_ctime_nsec = erofs_sbi.build_time_nsec;
+
+		vi->i_size = le32_to_cpu(dic->i_size);
+		break;
+	default:
+		erofs_err("unsupported on-disk inode version %u of nid %llu",
+			  erofs_inode_version(ifmt), vi->nid | 0ULL);
+		return -EOPNOTSUPP;
+	}
+
+	vi->flags = 0;
+	if (erofs_inode_is_data_compressed(vi->datalayout))
+		return -EOPNOTSUPP;
+	return 0;
+bogusimode:
+	erofs_err("bogus i_mode (%o) @ nid %llu", vi->i_mode, vi->nid | 0ULL);
+	return -EFSCORRUPTED;
+}
+
+struct erofs_dirent *find_target_dirent(erofs_nid_t pnid,
+					void *dentry_blk,
+					const char *name, unsigned int len,
+					unsigned int nameoff,
+					unsigned int maxsize)
+{
+	struct erofs_dirent *de = dentry_blk;
+	const struct erofs_dirent *end = dentry_blk + nameoff;
+
+	while (de < end) {
+		const char *de_name;
+		unsigned int de_namelen;
+
+		nameoff = le16_to_cpu(de->nameoff);
+		de_name = (char *)dentry_blk + nameoff;
+
+		/* the last dirent in the block? */
+		if (de + 1 >= end)
+			de_namelen = strnlen(de_name, maxsize - nameoff);
+		else
+			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
+
+		/* a corrupted entry is found */
+		if (nameoff + de_namelen > maxsize ||
+		    de_namelen > EROFS_NAME_LEN) {
+			erofs_err("bogus dirent @ nid %llu", pnid | 0ULL);
+			DBG_BUGON(1);
+			return ERR_PTR(-EFSCORRUPTED);
+		}
+
+		if (len == de_namelen && !memcmp(de_name, name, de_namelen))
+			return de;
+		++de;
+	}
+	return NULL;
+}
+
+struct nameidata {
+	erofs_nid_t	nid;
+	unsigned int	ftype;
+};
+
+int erofs_namei(struct nameidata *nd,
+		const char *name, unsigned int len)
+{
+	erofs_nid_t nid = nd->nid;
+	int ret;
+	char buf[EROFS_BLKSIZ];
+	struct erofs_inode vi = { .nid = nid };
+	erofs_off_t offset;
+
+	ret = erofs_read_inode_from_disk(&vi);
+	if (ret)
+		return ret;
+
+	offset = 0;
+	while (offset < vi.i_size) {
+		erofs_off_t maxsize = min_t(erofs_off_t,
+					    vi.i_size - offset, EROFS_BLKSIZ);
+		struct erofs_dirent *de = (void *)buf;
+		unsigned int nameoff;
+
+		ret = erofs_pread(&vi, buf, maxsize, offset);
+		if (ret)
+			return ret;
+
+		nameoff = le16_to_cpu(de->nameoff);
+		if (nameoff < sizeof(struct erofs_dirent) ||
+		    nameoff >= PAGE_SIZE) {
+			erofs_err("invalid de[0].nameoff %u @ nid %llu",
+				  nameoff, nid | 0ULL);
+			return -EFSCORRUPTED;
+		}
+
+		de = find_target_dirent(nid, buf, name, len,
+					nameoff, maxsize);
+		if (IS_ERR(de))
+			return PTR_ERR(de);
+
+		if (de) {
+			nd->nid = le64_to_cpu(de->nid);
+			return 0;
+		}
+		offset += maxsize;
+	}
+	return -ENOENT;
+}
+
+static int link_path_walk(const char *name, struct nameidata *nd)
+{
+	nd->nid = erofs_sbi.root_nid;
+
+	while (*name == '/')
+		name++;
+
+	/* At this point we know we have a real path component. */
+	while (*name != '\0') {
+		const char *p = name;
+		int ret;
+
+		do {
+			++p;
+		} while (*p != '\0' && *p != '/');
+
+		DBG_BUGON(p <= name);
+		ret = erofs_namei(nd, name, p - name);
+		if (ret)
+			return ret;
+
+		name = p;
+		/* Skip until no more slashes. */
+		for (name = p; *name == '/'; ++name);
+	}
+	return 0;
+}
+
+int erofs_ilookup(const char *path, struct erofs_inode *vi)
+{
+	int ret;
+	struct nameidata nd;
+
+	ret = link_path_walk(path, &nd);
+	if (ret)
+		return ret;
+
+	vi->nid = nd.nid;
+	return erofs_read_inode_from_disk(vi);
+}
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
new file mode 100644
index 0000000000..c58a826b4b
--- /dev/null
+++ b/fs/erofs/super.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0+
+#include "internal.h"
+
+static bool check_layout_compatibility(struct erofs_sb_info *sbi,
+				       struct erofs_super_block *dsb)
+{
+	const unsigned int feature = le32_to_cpu(dsb->feature_incompat);
+
+	sbi->feature_incompat = feature;
+
+	/* check if current kernel meets all mandatory requirements */
+	if (feature & (~EROFS_ALL_FEATURE_INCOMPAT)) {
+		erofs_err("unidentified incompatible feature %x, please upgrade kernel version",
+			  feature & ~EROFS_ALL_FEATURE_INCOMPAT);
+		return false;
+	}
+	return true;
+}
+
+int erofs_read_superblock(void)
+{
+	char data[EROFS_BLKSIZ];
+	struct erofs_super_block *dsb;
+	unsigned int blkszbits;
+	int ret;
+
+	ret = erofs_blk_read(data, 0, 1);
+	if (ret < 0) {
+		erofs_err("cannot read erofs superblock: %d", ret);
+		return -EIO;
+	}
+	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
+
+	ret = -EINVAL;
+	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
+		erofs_err("cannot find valid erofs superblock");
+		return ret;
+	}
+
+	erofs_sbi.feature_compat = le32_to_cpu(dsb->feature_compat);
+
+	blkszbits = dsb->blkszbits;
+	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
+	if (blkszbits != LOG_BLOCK_SIZE) {
+		erofs_err("blksize %u isn't supported on this platform",
+			  1 << blkszbits);
+		return ret;
+	}
+
+	if (!check_layout_compatibility(&erofs_sbi, dsb))
+		return ret;
+
+	erofs_sbi.blocks = le32_to_cpu(dsb->blocks);
+	erofs_sbi.meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
+	erofs_sbi.xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
+	erofs_sbi.islotbits = EROFS_ISLOTBITS;
+	erofs_sbi.root_nid = le16_to_cpu(dsb->root_nid);
+	erofs_sbi.inos = le64_to_cpu(dsb->inos);
+
+	erofs_sbi.build_time = le64_to_cpu(dsb->build_time);
+	erofs_sbi.build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
+
+	memcpy(&erofs_sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
+	return 0;
+}
diff --git a/fs/fs.c b/fs/fs.c
index 7c682582c8..3c06b0252b 100644
--- a/fs/fs.c
+++ b/fs/fs.c
@@ -26,6 +26,7 @@
 #include <linux/math64.h>
 #include <efi_loader.h>
 #include <squashfs.h>
+#include <erofs.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -304,6 +305,27 @@ static struct fstype_info fstypes[] = {
 		.unlink = fs_unlink_unsupported,
 		.mkdir = fs_mkdir_unsupported,
 	},
+#endif
+#if IS_ENABLED(CONFIG_FS_EROFS)
+	{
+		.fstype = FS_TYPE_EROFS,
+		.name = "erofs",
+		.null_dev_desc_ok = false,
+		.probe = erofs_probe,
+		.opendir = erofs_opendir,
+		.readdir = erofs_readdir,
+		.ls = fs_ls_generic,
+		.read = erofs_read,
+		.size = erofs_size,
+		.close = erofs_close,
+		.closedir = erofs_closedir,
+		.exists = erofs_exists,
+		.uuid = fs_uuid_unsupported,
+		.write = fs_write_unsupported,
+		.ln = fs_ln_unsupported,
+		.unlink = fs_unlink_unsupported,
+		.mkdir = fs_mkdir_unsupported,
+	},
 #endif
 	{
 		.fstype = FS_TYPE_ANY,
diff --git a/include/erofs.h b/include/erofs.h
new file mode 100644
index 0000000000..79de78257f
--- /dev/null
+++ b/include/erofs.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _EROFS_H_
+#define _EROFS_H_
+
+struct disk_partition;
+
+int erofs_opendir(const char *filename, struct fs_dir_stream **dirsp);
+int erofs_readdir(struct fs_dir_stream *dirs, struct fs_dirent **dentp);
+int erofs_probe(struct blk_desc *fs_dev_desc,
+	       struct disk_partition *fs_partition);
+int erofs_read(const char *filename, void *buf, loff_t offset,
+	      loff_t len, loff_t *actread);
+int erofs_size(const char *filename, loff_t *size);
+int erofs_exists(const char *filename);
+void erofs_close(void);
+void erofs_closedir(struct fs_dir_stream *dirs);
+int erofs_uuid(char *uuid_str);
+
+#endif /* _EROFS_H  */
diff --git a/include/fs.h b/include/fs.h
index 1c79e299fd..f96afc4c89 100644
--- a/include/fs.h
+++ b/include/fs.h
@@ -17,6 +17,7 @@ struct cmd_tbl;
 #define FS_TYPE_UBIFS	4
 #define FS_TYPE_BTRFS	5
 #define FS_TYPE_SQUASHFS 6
+#define FS_TYPE_EROFS   7
 
 struct blk_desc;
 
-- 
2.25.1

