Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CA66DAEB6
	for <lists+linux-erofs@lfdr.de>; Fri,  7 Apr 2023 16:17:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PtL6g6gsJz3fTf
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Apr 2023 00:17:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PtL6T5z33z3fVm
	for <linux-erofs@lists.ozlabs.org>; Sat,  8 Apr 2023 00:17:21 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VfX7DEZ_1680877035;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfX7DEZ_1680877035)
          by smtp.aliyun-inc.com;
          Fri, 07 Apr 2023 22:17:15 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 4/7] erofs: introduce on-disk format for long xattr name prefixes
Date: Fri,  7 Apr 2023 22:17:07 +0800
Message-Id: <20230407141710.113882-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
References: <20230407141710.113882-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Besides the predefined xattr name prefixes, introduces long xattr name
prefixes, which work similarly as the predefined name prefixes, except
that they are user specified.

It is especially useful for use cases together with overlayfs like
Composefs model, which introduces diverse xattr values with only a few
common xattr names (trusted.overlay.redirect, trusted.overlay.digest,
and maybe more in the future).  That makes the existing predefined
prefixes ineffective in both image size and runtime performance.

When a user specified long xattr name prefix is used, only the trailing
part of the xattr name apart from the long xattr name prefix will be
stored in erofs_xattr_entry.e_name.  e_name is empty if the xattr name
matches exactly as the long xattr name prefix.  All long xattr prefixes
are stored in the packed or meta inode, which depends if fragments
feature is enabled or not.

For each long xattr name prefix, the on-disk format is kept as the same
as the unique metadata format: ALIGN({__le16 len, data}, 4), where len
represents the total size of struct erofs_xattr_long_prefix, followed
by data of struct erofs_xattr_long_prefix itself.

Each erofs_xattr_long_prefix keeps predefined prefixes (base_index)
and the remaining prefix string without the trailing '\0'.

Two fields are introduced to the on-disk superblock, where
xattr_prefix_count represents the total number of the long xattr name
prefixes recorded, and xattr_prefix_start represents the start offset of
recorded name prefixes in the packed/meta inode divided by 4.

When referring to a long xattr name prefix, the highest bit (bit 7) of
erofs_xattr_entry.e_name_index is set, while the lower bits (bit 0-6)
as a whole represents the index of the referred long name prefix among
all long xattr name prefixes.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/erofs_fs.h | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 44876a97cabd..ea62f83dac40 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -76,7 +76,8 @@ struct erofs_super_block {
 	__le16 extra_devices;	/* # of devices besides the primary device */
 	__le16 devt_slotoff;	/* startoff = devt_slotoff * devt_slotsize */
 	__u8 dirblkbits;	/* directory block size in bit shift */
-	__u8 reserved[5];
+	__u8 xattr_prefix_count;	/* # of long xattr name prefixes */
+	__le32 xattr_prefix_start;	/* start of long xattr prefixes */
 	__le64 packed_nid;	/* nid of the special packed inode */
 	__u8 reserved2[24];
 };
@@ -229,6 +230,13 @@ struct erofs_xattr_ibody_header {
 #define EROFS_XATTR_INDEX_LUSTRE            5
 #define EROFS_XATTR_INDEX_SECURITY          6
 
+/*
+ * bit 7 of e_name_index is set when it refers to a long xattr name prefix,
+ * while the remained lower bits represent the index of the prefix.
+ */
+#define EROFS_XATTR_LONG_PREFIX		0x80
+#define EROFS_XATTR_LONG_PREFIX_MASK	0x7f
+
 /* xattr entry (for both inline & shared xattrs) */
 struct erofs_xattr_entry {
 	__u8   e_name_len;      /* length of name */
@@ -238,6 +246,12 @@ struct erofs_xattr_entry {
 	char   e_name[];        /* attribute name */
 };
 
+/* long xattr name prefix */
+struct erofs_xattr_long_prefix {
+	__u8   base_index;	/* short xattr name prefix index */
+	char   infix[];		/* infix apart from short prefix */
+};
+
 static inline unsigned int erofs_xattr_ibody_size(__le16 i_xattr_icount)
 {
 	if (!i_xattr_icount)
-- 
2.19.1.6.gb485710b

