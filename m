Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B7075DB86
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Jul 2023 11:46:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R7M4R555cz3cB2
	for <lists+linux-erofs@lfdr.de>; Sat, 22 Jul 2023 19:45:59 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R7M4D495dz2xsY
	for <linux-erofs@lists.ozlabs.org>; Sat, 22 Jul 2023 19:45:47 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R781e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VnxO2IX_1690019141;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VnxO2IX_1690019141)
          by smtp.aliyun-inc.com;
          Sat, 22 Jul 2023 17:45:42 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v6 2/2] erofs: boost negative xattr lookup with bloom filter
Date: Sat, 22 Jul 2023 17:45:38 +0800
Message-Id: <20230722094538.11754-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230722094538.11754-1-jefflexu@linux.alibaba.com>
References: <20230722094538.11754-1-jefflexu@linux.alibaba.com>
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
Cc: alexl@redhat.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Optimise the negative xattr lookup with bloom filter.

The bit value for the bloom filter map has a reverse semantics for
compatibility.  That is, the bit value of 0 indicates existence, while
the bit value of 1 indicates the absence of corresponding xattr.

The initial version is _only_ enabled when xattr_filter_reserved is
zero.  The filter map internals may change in the future, in which case
the reserved flag will be set non-zero and we don't need bothering the
compatible bits again at that time.  For now disable the optimization if
this reserved flag is non-zero.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/Kconfig    |  1 +
 fs/erofs/internal.h |  3 +++
 fs/erofs/super.c    |  1 +
 fs/erofs/xattr.c    | 14 ++++++++++++++
 4 files changed, 19 insertions(+)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index f259d92c9720..f49669def828 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -38,6 +38,7 @@ config EROFS_FS_DEBUG
 config EROFS_FS_XATTR
 	bool "EROFS extended attributes"
 	depends on EROFS_FS
+	select XXHASH
 	default y
 	help
 	  Extended attributes are name:value pairs associated with inodes by
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 36e32fa542f0..3c1f89d8421b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -151,6 +151,7 @@ struct erofs_sb_info {
 	u32 xattr_prefix_start;
 	u8 xattr_prefix_count;
 	struct erofs_xattr_prefix_item *xattr_prefixes;
+	unsigned int xattr_filter_reserved;
 #endif
 	u16 device_id_mask;	/* valid bits of device id to be used */
 
@@ -251,6 +252,7 @@ EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
+EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 
 /* atomic flag definitions */
 #define EROFS_I_EA_INITED_BIT	0
@@ -270,6 +272,7 @@ struct erofs_inode {
 	unsigned char inode_isize;
 	unsigned int xattr_isize;
 
+	unsigned int xattr_name_filter;
 	unsigned int xattr_shared_count;
 	unsigned int *xattr_shared_xattrs;
 
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9d6a3c6158bd..72122323300e 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -388,6 +388,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
 	sbi->xattr_prefix_start = le32_to_cpu(dsb->xattr_prefix_start);
 	sbi->xattr_prefix_count = dsb->xattr_prefix_count;
+	sbi->xattr_filter_reserved = dsb->xattr_filter_reserved;
 #endif
 	sbi->islotbits = ilog2(sizeof(struct erofs_inode_compact));
 	sbi->root_nid = le16_to_cpu(dsb->root_nid);
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 40178b6e0688..09d341675e89 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021-2022, Alibaba Cloud
  */
 #include <linux/security.h>
+#include <linux/xxhash.h>
 #include "xattr.h"
 
 struct erofs_xattr_iter {
@@ -87,6 +88,7 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	}
 
 	ih = it.kaddr + erofs_blkoff(sb, it.pos);
+	vi->xattr_name_filter = le32_to_cpu(ih->h_name_filter);
 	vi->xattr_shared_count = ih->h_shared_count;
 	vi->xattr_shared_xattrs = kmalloc_array(vi->xattr_shared_count,
 						sizeof(uint), GFP_KERNEL);
@@ -392,7 +394,10 @@ int erofs_getxattr(struct inode *inode, int index, const char *name,
 		   void *buffer, size_t buffer_size)
 {
 	int ret;
+	unsigned int hashbit;
 	struct erofs_xattr_iter it;
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 
 	if (!name)
 		return -EINVAL;
@@ -401,6 +406,15 @@ int erofs_getxattr(struct inode *inode, int index, const char *name,
 	if (ret)
 		return ret;
 
+	/* reserved flag is non-zero if there's any change of on-disk format */
+	if (erofs_sb_has_xattr_filter(sbi) && !sbi->xattr_filter_reserved) {
+		hashbit = xxh32(name, strlen(name),
+				EROFS_XATTR_FILTER_SEED + index);
+		hashbit &= EROFS_XATTR_FILTER_BITS - 1;
+		if (vi->xattr_name_filter & (1U << hashbit))
+			return -ENOATTR;
+	}
+
 	it.index = index;
 	it.name = (struct qstr)QSTR_INIT(name, strlen(name));
 	if (it.name.len > EROFS_NAME_LEN)
-- 
2.19.1.6.gb485710b

