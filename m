Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 85432305E9
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 02:51:34 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45FQr32K2YzDqWH
	for <lists+linux-erofs@lfdr.de>; Fri, 31 May 2019 10:51:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1559263891;
	bh=i00C7N2Z2k496gHqjGmq0JwREKd43pp5mL56zGubic4=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=iDTl6/ki93ztCw+DWwoNOnr8sHXzr/7CG/ogZYTzZbRmbwuap/FPacgaWvp1F8bLi
	 /amohYLry71j67pt1CkcjtBXdB+sW8LYYC/KUXX2WLWN95P1kLF3+Wbpv3olH0PAZT
	 40CLY3uvBvxwttwWV6L/xF/ZKXnwktmcyNKnUfQscj/DcgQaj6jsXw/o80+A5pO4S+
	 RjDR120mOvCF28l+0fMXgu2dYfN48CiJMuLTn2kBwUFMWnZ1G6ZoXUWD5AvSkKouJK
	 VDp1yT2+8bJkgE9fUQxH+DjyGp/L/zCgcFGUL3AiTCpnH+ewgtNpFJQQbKyHkAAei1
	 oyRtmAdxb4Pmg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=aol.com
 (client-ip=98.137.68.148; helo=sonic302-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.b="qktNE+iD"; 
 dkim-atps=neutral
Received: from sonic302-22.consmr.mail.gq1.yahoo.com
 (sonic302-22.consmr.mail.gq1.yahoo.com [98.137.68.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45FQqm0GJxzDqSv
 for <linux-erofs@lists.ozlabs.org>; Fri, 31 May 2019 10:51:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1559263871; bh=ksPytKncXaglsJ/RR2cUEGsOU6Cmuzu/nn0kFXcaRXo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=qktNE+iD8BOyKbZkyQUwuc6KIFkVUfYWPaS7w5TPBm+rfev9/3o49LVd1sT3gy1PYP87cbmhCbIEDz2ewcwweBpj7XCWy+g8wjw+IUy1Ru4lRDfNrPQK4wxqtguipdZYjM2kGAdMGvzXbFmJdQFmZA91chcfAH4xzlPKcA+WpR3JouFgZUnP2akjlerow7WhwgxJ5SvczcrnhKQVqQMM5TG73XRfQBwxc6QR9VFQZqgIMPUvIt6TDeBMyiIqBWIhi6rnEKC7vOPbnppS3mqgDS32skyaEkuF3JeB7NuRmRjS7AaSs2tQRiVyizHxrTOFCN1RC8QjrVWoBEXEToYyHg==
X-YMail-OSG: fmIcihwVM1m7pGdo5X5OjB0aM171sTLGmXoRL0yIXfTg_GkaDzINQCF254CXRQ9
 Az5laEQ6pA.YVMRamk2XYnHLdSQpau8ZyprNRr_8eHx56IOBqugIi.wU9ztZ2M9oFIxrtoa_fUet
 gpfDJuZBrFeUdvha9dVZu7opIULXOerTDhUeJcz_0v6BFGTKAwzfPxNKVloHn1eexN4DbJZ_uUA5
 6g1mjIOXsHd6Bt.rZM0QFVcHD_Es_nRpR5aB9djOzTnS4t6QmVUIkZSdV5sFuaSJfa1mDQK2giK9
 UXdNfZxr.SgxonjtJEQIK58pmxyPt9eRFiI_hGuIN4Vl8PPXC3hOQxI0wj3fivLdYqHlOVtKQlYS
 XZHo5HMS.cwUsshCHLmpavCAr40yYUyWPkO_Joa0oiibnd7kvw7cPhB7yWlNhagPqxzvICRiPxqH
 JOmKJiMHIGOjbE9sDqSJrGrBq17SjW7u.nZylYdmyl6HJvE3PMncEuo1UmrV.p.9_tVdQDsTMEK_
 t6RmNPkXuPfMeUarsxwjOIhTO7tx9MzZASSwzGKzUlL6ppwLjnSrDo.88CzzbxfLPpyVgs1m0Aho
 vx_MNw9.MTMR.DfzqwaRIQHe1Ej33TC8FyYf9oG0GBMTQ.D0Nfsj2T057XOifDHtOd3KoDRm4Qo6
 IHhBrNvHMmryn1nD6LRpD2yCb0UpQN.uP7LTGEdBxjcL20ohHDdiu8cUOgoEGoCzlmDcGkPcTQu9
 ZrVqdcGnzpjbIJz.1JIEtMdPmZDp4aXR79iswJOR5BIoAIBb8HSBIzpBmqV.YFw8g0OCAYqctLxL
 dm9FJ4v51Y7lf8zsjMvLl6ShUNpTX8_ruw7hMs8Y1uieKabmQKgAeTroEOQh5dpR6ik7nLoj.jx9
 0TNwfmv3UeoF05kSWtpexXvknQasfSwaWgBBzuRHGcKSn9HUZlYVIlbJQTcDd.4UvCob566Ep5ih
 8IkZcMyI9wAv_7YAPHF0F_1sSC9gH7C_fLJI.xYrlOVyxJAG5t9mJb.TlPUWMm6BhKAG5wF7I6jn
 aDuu5QKaM9UA2sbhsYO5TkxgkhGACdMx93SgUMNzEL2PS7SKwNN80V4KN2Mhsg33mcQgc.NHZLu3
 cVjRukEZd5WWJebgPskrt5OaPAx1R5zPMKs91vQEwx950bnn_GCVU7nUbNgZyByDqh7rkUdBIqk9
 IiTzmHiY29tCBecoeU9AmPfCyx93nTRAr06D7kWSOUdBB9AsDDOE-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic302.consmr.mail.gq1.yahoo.com with HTTP; Fri, 31 May 2019 00:51:11 +0000
Received: from 125.120.86.223 (EHLO localhost.localdomain) ([125.120.86.223])
 by smtp417.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA
 ID a9e989b6e54ef4fb7ecb5a20a6091749; 
 Fri, 31 May 2019 00:51:05 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 01/13] erofs-utils: add erofs on-disk layout
Date: Fri, 31 May 2019 08:50:35 +0800
Message-Id: <20190531005047.22093-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531005047.22093-1-hsiangkao@aol.com>
References: <20190531005047.22093-1-hsiangkao@aol.com>
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
Cc: Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Li Guifu <bluce.liguifu@huawei.com>

This patch adds a header file describing the erofs on-disk layout, which
should be kept in line with the kernel implementation all the time.

Signed-off-by: Li Guifu <bluce.liguifu@huawei.com>
Signed-off-by: Miao Xie <miaoxie@huawei.com>
Signed-off-by: Fang Wei <fangwei1@huawei.com>
Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
---
 include/erofs_fs.h | 275 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 275 insertions(+)
 create mode 100644 include/erofs_fs.h

diff --git a/include/erofs_fs.h b/include/erofs_fs.h
new file mode 100644
index 0000000..4b6c1d1
--- /dev/null
+++ b/include/erofs_fs.h
@@ -0,0 +1,275 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Apache-2.0 */
+/*
+ * erofs_utils/include/erofs_fs.h
+ *
+ * Copyright (C) 2017-2018 HUAWEI, Inc.
+ *             http://www.huawei.com/
+ * Created by Gao Xiang <gaoxiang25@huawei.com>
+ *
+ * This file is dual-licensed; you may select either the GNU General Public
+ * License version 2 or Apache License, Version 2.0. See the file COPYING
+ * in the main directory of the Linux distribution for more details.
+ */
+#ifndef __EROFS_FS_H
+#define __EROFS_FS_H
+
+/* Enhanced(Extended) ROM File System */
+#define EROFS_SUPER_MAGIC_V1    0xE0F5E1E2
+#define EROFS_SUPER_OFFSET      1024
+
+struct erofs_super_block {
+/*  0 */__le32 magic;           /* in the little endian */
+/*  4 */__le32 checksum;        /* crc32c(super_block) */
+/*  8 */__le32 features;
+/* 12 */__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
+/* 13 */__u8 reserved;
+
+/* 14 */__le16 root_nid;
+/* 16 */__le64 inos;            /* total valid ino # (== f_files - f_favail) */
+
+/* 24 */__le64 build_time;      /* inode v1 time derivation */
+/* 32 */__le32 build_time_nsec;
+/* 36 */__le32 blocks;          /* used for statfs */
+/* 40 */__le32 meta_blkaddr;
+/* 44 */__le32 xattr_blkaddr;
+/* 48 */__u8 uuid[16];          /* 128-bit uuid for volume */
+/* 64 */__u8 volume_name[16];   /* volume name */
+
+/* 80 */__u8 reserved2[48];     /* 128 bytes */
+} __packed;
+
+/*
+ * erofs inode data mapping:
+ * 0 - inode plain without inline data A:
+ * inode, [xattrs], ... | ... | no-holed data
+ * 1 - inode VLE compression B:
+ * inode, [xattrs], extents ... | ...
+ * 2 - inode plain with inline data C:
+ * inode, [xattrs], last_inline_data, ... | ... | no-holed data
+ * 3~7 - reserved
+ */
+enum {
+	EROFS_INODE_LAYOUT_PLAIN,
+	EROFS_INODE_LAYOUT_COMPRESSION,
+	EROFS_INODE_LAYOUT_INLINE,
+	EROFS_INODE_LAYOUT_MAX
+};
+
+/* bit definitions of inode i_advise */
+#define EROFS_I_VERSION_BITS            1
+#define EROFS_I_DATA_MAPPING_BITS       3
+
+#define EROFS_I_VERSION_BIT             0
+#define EROFS_I_DATA_MAPPING_BIT        1
+
+struct erofs_inode_v1 {
+/*  0 */__le16 i_advise;
+
+/* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
+/*  2 */__le16 i_xattr_icount;
+/*  4 */__le16 i_mode;
+/*  6 */__le16 i_nlink;
+/*  8 */__le32 i_size;
+/* 12 */__le32 i_reserved;
+/* 16 */union {
+		/* file total compressed blocks for data mapping 1 */
+		__le32 compressed_blocks;
+		__le32 raw_blkaddr;
+
+		/* for device files, used to indicate old/new device # */
+		__le32 rdev;
+	} i_u __packed;
+/* 20 */__le32 i_ino;           /* only used for 32-bit stat compatibility */
+/* 24 */__le16 i_uid;
+/* 26 */__le16 i_gid;
+/* 28 */__le32 i_checksum;
+} __packed;
+
+/* 32 bytes on-disk inode */
+#define EROFS_INODE_LAYOUT_V1   0
+/* 64 bytes on-disk inode */
+#define EROFS_INODE_LAYOUT_V2   1
+
+struct erofs_inode_v2 {
+	__le16 i_advise;
+
+	/* 1 header + n-1 * 4 bytes inline xattr to keep continuity */
+	__le16 i_xattr_icount;
+	__le16 i_mode;
+	__le16 i_reserved;      /* 8 bytes */
+	__le64 i_size;          /* 16 bytes */
+	union {
+		/* file total compressed blocks for data mapping 1 */
+		__le32 compressed_blocks;
+		__le32 raw_blkaddr;
+
+		/* for device files, used to indicate old/new device # */
+		__le32 rdev;
+	} i_u __packed;
+
+	/* only used for 32-bit stat compatibility */
+	__le32 i_ino;           /* 24 bytes */
+
+	__le32 i_uid;
+	__le32 i_gid;
+	__le64 i_ctime;         /* 32 bytes */
+	__le32 i_ctime_nsec;
+	__le32 i_nlink;
+	__u8   i_reserved2[12];
+	__le32 i_checksum;      /* 64 bytes */
+} __packed;
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
+	__le32 h_checksum;
+	__u8   h_shared_count;
+	__u8   h_reserved[7];
+	__le32 h_shared_xattrs[0];      /* shared xattr id array */
+} __packed;
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
+} __packed;
+
+#define ondisk_xattr_ibody_size(count)	({\
+	u32 __count = le16_to_cpu(count); \
+	((__count) == 0) ? 0 : \
+	sizeof(struct erofs_xattr_ibody_header) + \
+		sizeof(__u32) * ((__count) - 1); })
+
+#define EROFS_XATTR_ALIGN(size) round_up(size, sizeof(struct erofs_xattr_entry))
+#define EROFS_XATTR_ENTRY_SIZE(entry) EROFS_XATTR_ALIGN( \
+	sizeof(struct erofs_xattr_entry) + \
+	(entry)->e_name_len + le16_to_cpu((entry)->e_value_size))
+
+/* have to be aligned with 8 bytes on disk */
+struct erofs_extent_header {
+	__le32 eh_checksum;
+	__le32 eh_reserved[3];
+} __packed;
+
+/*
+ * Z_EROFS Variable-sized Logical Extent cluster type:
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
+	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN,
+	Z_EROFS_VLE_CLUSTER_TYPE_HEAD,
+	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD,
+	Z_EROFS_VLE_CLUSTER_TYPE_RESERVED,
+	Z_EROFS_VLE_CLUSTER_TYPE_MAX
+};
+
+#define Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS        2
+#define Z_EROFS_VLE_DI_CLUSTER_TYPE_BIT         0
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
+	} di_u __packed;		/* 8 bytes */
+} __packed;
+
+#define Z_EROFS_VLE_EXTENT_ALIGN(size) round_up(size, \
+	sizeof(struct z_erofs_vle_decompressed_index))
+
+/* dirent sorts in alphabet order, thus we can do binary search */
+struct erofs_dirent {
+	__le64 nid;     /*  0, node number */
+	__le16 nameoff; /*  8, start offset of file name */
+	__u8 file_type; /* 10, file type */
+	__u8 reserved;  /* 11, reserved */
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
+	BUILD_BUG_ON(sizeof(struct erofs_inode_v1) != 32);
+	BUILD_BUG_ON(sizeof(struct erofs_inode_v2) != 64);
+	BUILD_BUG_ON(sizeof(struct erofs_xattr_ibody_header) != 12);
+	BUILD_BUG_ON(sizeof(struct erofs_xattr_entry) != 4);
+	BUILD_BUG_ON(sizeof(struct erofs_extent_header) != 16);
+	BUILD_BUG_ON(sizeof(struct z_erofs_vle_decompressed_index) != 8);
+	BUILD_BUG_ON(sizeof(struct erofs_dirent) != 12);
+
+	BUILD_BUG_ON(BIT(Z_EROFS_VLE_DI_CLUSTER_TYPE_BITS) <
+		     Z_EROFS_VLE_CLUSTER_TYPE_MAX - 1);
+}
+
+#endif
+
-- 
2.17.1

