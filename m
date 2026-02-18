Return-Path: <linux-erofs+bounces-2329-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id youYDIVflWmYPwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2329-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Feb 2026 07:43:17 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB211537A7
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Feb 2026 07:43:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fG6Qg38cxz2yvy;
	Wed, 18 Feb 2026 17:43:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771396987;
	cv=none; b=n5P92D3ni/6V9k3tvkbquMpYkF/nZtuxjTYeFTQwO0mwzdVsXfrdamCfiDDVwuKci/VEgdM3gVM/sU6qAELD/99vKz43yTotAfKKqpS8T/EjK2x2X12bxb9WpJG7lFIGZeIDO3S79ljjo06JK18FHFIU4+pnR2tD5PbEpeg3T41/y0OpQSBonZN65vaMUjelG3rIKkU2l6aCT7NhyvjihjEigQcvonbsGGGWQGGsXnIcndK1eXjFko9aHyrMK6H59wGt2Vxk7W1IoBs9hD3qR12qSgr+Y06mersIeJM/7RNVcl2oFbnv6wZEP2qQXJlrXlwRDIkc8ZgUdQWsN7K2eA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771396987; c=relaxed/relaxed;
	bh=RP5+aWwv3jB5QJPs1EO11f2Y+2irb3Di142J2U7iRsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fj+TnmGBG+5dgx6+4tCZpsAmhzqXekxf8jtLaNzpTo44HeHkx8Fk/65g0IUr3ZyIFx1tx3JAKcL34PQl0IOJRzlUINjJrBH3FsitdExEf5aaifX6fSYLjxDHK7V5iPwY6WrCjWRpq+CpsbDlYjXNHrghRtkf2J74QtZz4faIkJuNBPO6IEdk9IWBYiblDcDVZWVcbUEzWjcAmdhBkcI1Lm3dLp3IiRpC37pmJbFkMURipz3qdXSaYe7jbJDvcILbsY5EqkJTHoj352qx7KU2MJr4dKwLMXvuthTvq0iBsz3moxv3JHTHvrFTh77UwFEa0SRYZXOepd5Bzj7dvrxaGw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WT2EKCCd; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WT2EKCCd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fG6Qd0Cwqz2xlq
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Feb 2026 17:43:03 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771396978; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=RP5+aWwv3jB5QJPs1EO11f2Y+2irb3Di142J2U7iRsg=;
	b=WT2EKCCdHjm8Xvo6YvSgjn/qProJrSSZuRIFXZjfMagDK+LUTKegsvSJB+VW6rM44zD4eGZcJPa8bPr2w7PPHsyuBuYMJIGjymv4iKGjQyzJoDhC3y9jvTTlElgdnNBjOPVqM7IdQzjWZlbJLtTwBKiCWmStIZ5042xCBLdlQYc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WzRx9RC_1771396976 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Feb 2026 14:42:57 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/3] erofs-utils: switch on-disk header `erofs_fs.h` to MIT license
Date: Wed, 18 Feb 2026 14:42:51 +0800
Message-ID: <20260218064252.3958518-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260218064252.3958518-1-hsiangkao@linux.alibaba.com>
References: <20260218064252.3958518-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2329-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 3BB211537A7
X-Rspamd-Action: no action

Source kernel commit: 0bdbf89a8bbeb155644b69dc2d071a1ce23414f8

[ Also align with the latest kernel `erofs_fs.h`. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 LICENSES/MIT             | 30 ++++++++++++++++++++++++++++++
 dump/main.c              |  2 +-
 include/erofs/internal.h |  2 +-
 include/erofs_fs.h       | 27 ++++++++++++++-------------
 mkfs/main.c              |  2 +-
 5 files changed, 47 insertions(+), 16 deletions(-)
 create mode 100644 LICENSES/MIT

diff --git a/LICENSES/MIT b/LICENSES/MIT
new file mode 100644
index 000000000000..f33a68ceb3ea
--- /dev/null
+++ b/LICENSES/MIT
@@ -0,0 +1,30 @@
+Valid-License-Identifier: MIT
+SPDX-URL: https://spdx.org/licenses/MIT.html
+Usage-Guide:
+  To use the MIT License put the following SPDX tag/value pair into a
+  comment according to the placement guidelines in the licensing rules
+  documentation:
+    SPDX-License-Identifier: MIT
+License-Text:
+
+MIT License
+
+Copyright (c) <year> <copyright holders>
+
+Permission is hereby granted, free of charge, to any person obtaining a
+copy of this software and associated documentation files (the "Software"),
+to deal in the Software without restriction, including without limitation
+the rights to use, copy, modify, merge, publish, distribute, sublicense,
+and/or sell copies of the Software, and to permit persons to whom the
+Software is furnished to do so, subject to the following conditions:
+
+The above copyright notice and this permission notice shall be included in
+all copies or substantial portions of the Software.
+
+THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+DEALINGS IN THE SOFTWARE.
diff --git a/dump/main.c b/dump/main.c
index 57ec3b7133ce..8422bb90afbb 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -96,7 +96,7 @@ static struct erofsdump_feature feature_lists[] = {
 	{  true,    0, EROFS_FEATURE_COMPAT_SB_CHKSUM, "sb_csum" },
 	{  true,    0, EROFS_FEATURE_COMPAT_MTIME, "mtime" },
 	{  true,    0, EROFS_FEATURE_COMPAT_XATTR_FILTER, "xattr_filter" },
-	{ false, 504U, EROFS_FEATURE_INCOMPAT_ZERO_PADDING, "0padding" },
+	{ false, 504U, EROFS_FEATURE_INCOMPAT_LZ4_0PADDING, "lz4_0padding" },
 	{ false, 513U, EROFS_FEATURE_INCOMPAT_COMPR_CFGS, "compr_cfgs" },
 	{ false, 513U, EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER, "big_pcluster" },
 	{ false, 515U, EROFS_FEATURE_INCOMPAT_CHUNKED_FILE, "chunked_file" },
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 0a5f6beeb14c..e741f1ce62f1 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -179,7 +179,7 @@ static inline void erofs_sb_clear_##name(struct erofs_sb_info *sbi) \
 	sbi->feature_##compat &= ~EROFS_FEATURE_##feature; \
 }
 
-EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_ZERO_PADDING)
+EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
 EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
 EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
 EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 8b0d155f8c4c..ff8ac78f2881 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -1,4 +1,4 @@
-/* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */
+/* SPDX-License-Identifier: MIT */
 /*
  * EROFS (Enhanced ROM File System) on-disk format definition
  *
@@ -13,17 +13,18 @@
 /* to allow for x86 boot sectors and other oddities. */
 #define EROFS_SUPER_OFFSET      1024
 
-#define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
-#define EROFS_FEATURE_COMPAT_MTIME              0x00000002
-#define EROFS_FEATURE_COMPAT_XATTR_FILTER	0x00000004
-#define EROFS_FEATURE_COMPAT_PLAIN_XATTR_PFX	0x00000010
-#define EROFS_FEATURE_COMPAT_ISHARE_XATTRS	0x00000020
+#define EROFS_FEATURE_COMPAT_SB_CHKSUM			0x00000001
+#define EROFS_FEATURE_COMPAT_MTIME			0x00000002
+#define EROFS_FEATURE_COMPAT_XATTR_FILTER		0x00000004
+#define EROFS_FEATURE_COMPAT_SHARED_EA_IN_METABOX	0x00000008
+#define EROFS_FEATURE_COMPAT_PLAIN_XATTR_PFX		0x00000010
+#define EROFS_FEATURE_COMPAT_ISHARE_XATTRS		0x00000020
 
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
  * be incompatible with this kernel version.
  */
-#define EROFS_FEATURE_INCOMPAT_ZERO_PADDING	0x00000001
+#define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
 #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
 #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
 #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
@@ -50,7 +51,7 @@ struct erofs_deviceslot {
 };
 #define EROFS_DEVT_SLOT_SIZE	sizeof(struct erofs_deviceslot)
 
-/* erofs on-disk super block (currently 128 bytes) */
+/* erofs on-disk super block (currently 144 bytes at maximum) */
 struct erofs_super_block {
 	__le32 magic;           /* file system magic number */
 	__le32 checksum;        /* crc32c to avoid unexpected on-disk overlap */
@@ -60,7 +61,7 @@ struct erofs_super_block {
 	union {
 		__le16 rootnid_2b;	/* nid of root directory */
 		__le16 blocks_hi;	/* (48BIT on) blocks count MSB */
-	} rb;
+	} __packed rb;
 	__le64 inos;            /* total valid ino # (== f_files - f_favail) */
 	__le64 epoch;		/* base seconds used for compact inodes */
 	__le32 fixed_nsec;	/* fixed nanoseconds for compact inodes */
@@ -89,7 +90,7 @@ struct erofs_super_block {
 	__le64 rootnid_8b;	/* (48BIT on) nid of root directory */
 	__le64 reserved2;
 	__le64 metabox_nid;	/* (METABOX on) nid of the metabox inode */
-	__le64 reserved3;
+	__le64 reserved3;	/* [align to extslot 1] */
 };
 
 /*
@@ -155,7 +156,7 @@ union erofs_inode_i_nb {
 	__le16 nlink;		/* if EROFS_I_NLINK_1_BIT is unset */
 	__le16 blocks_hi;	/* total blocks count MSB */
 	__le16 startblk_hi;	/* starting block number MSB */
-};
+} __packed;
 
 /* 32-byte reduced form of an ondisk inode */
 struct erofs_inode_compact {
@@ -386,9 +387,9 @@ struct z_erofs_map_header {
 			 * bit 7   : pack the whole file into packed inode
 			 */
 			__u8	h_clusterbits;
-		};
+		} __packed;
 		__le16 h_extents_hi;	/* extent count MSB */
-	};
+	} __packed;
 };
 
 enum {
diff --git a/mkfs/main.c b/mkfs/main.c
index 7333f1f03146..aaf5358fc735 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1678,7 +1678,7 @@ static void erofs_mkfs_default_options(struct erofs_importer_params *params)
 	mkfs_blkszbits = ilog2(min_t(u32, getpagesize(), EROFS_MAX_BLOCK_SIZE));
 	params->pclusterblks_max = 1U;
 	params->pclusterblks_def = 1U;
-	g_sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_ZERO_PADDING;
+	g_sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
 	g_sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
 			     EROFS_FEATURE_COMPAT_MTIME;
 }
-- 
2.43.5


