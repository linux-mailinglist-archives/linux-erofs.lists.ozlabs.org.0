Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BE46D5A2D
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 10:02:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrKxT6CV5z3cMw
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 18:02:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrKxP3N94z3bWq
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Apr 2023 18:02:32 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VfL0.ye_1680595347;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfL0.ye_1680595347)
          by smtp.aliyun-inc.com;
          Tue, 04 Apr 2023 16:02:27 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	hsiangkao@linux.alibaba.com
Subject: [PATCH 3/6] erofs-utils: introduce on-disk format for extra xattr name prefix
Date: Tue,  4 Apr 2023 16:02:20 +0800
Message-Id: <20230404080224.77577-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230404080224.77577-1-jefflexu@linux.alibaba.com>
References: <20230404080224.77577-1-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Besides the predefined xattr name prefixes, introduces extra xattr name
prefixes, which works similarly as the predefined xattr name prefixees,
except that they are user specified.

When matched with a user specified extra xattr name prefix, only the
trailing part of the xattr name except the xattr name prefix will be
stored in erofs_xattr_entry.e_name.  e_name is empty if the xattr name
matches exactly as the extra xattr name prefix.

All extra xattr name prefixes are stored in the packed file.  For each
extra xattr name prefix, the on-disk format in packed file can be shown
as (u8 prefix_len, prefix string), where the first u8 represents the
length of the prefix string (excluding '\0'), followed by the content of
the prefix string (including '\0').

Two fields are introduced to the on-disk superblock, where
ea_prefix_count represents the total number of the extra xattr name
prefixes recorded in the packed file, and ea_prefix_off represents the
start offset of recorded name prefixes in the packed file.

When referring to an extra xattr name prefix, the highest bit (bit 7) of
erofs_xattr_entry.e_name_index is set, while the lower bits (bit 0-6)
as a whole represents the index of the referred name prefix among all
extra xattr name prefixes in the packed file.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs_fs.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 8835a76..3d8eb5f 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -77,7 +77,9 @@ struct erofs_super_block {
 	} __packed u1;
 	__le16 extra_devices;	/* # of devices besides the primary device */
 	__le16 devt_slotoff;	/* startoff = devt_slotoff * devt_slotsize */
-	__u8 reserved[6];
+	__u8 reserved;
+	__u8 ea_prefix_count;	/* # of extra xattr name prefix */
+	__le32 ea_prefix_off;	/* start offset of extra prefixes in packed inode */
 	__le64 packed_nid;	/* nid of the special packed inode */
 	__u8 reserved2[24];
 };
@@ -228,6 +230,9 @@ struct erofs_xattr_ibody_header {
 #define EROFS_XATTR_INDEX_LUSTRE            5
 #define EROFS_XATTR_INDEX_SECURITY          6
 
+#define EROFS_XATTR_EA_FLAG	(1 << 7)
+#define EROFS_XATTR_EA_MASK	(EROFS_XATTR_EINDEX_FLAG - 1)
+
 /* xattr entry (for both inline & shared xattrs) */
 struct erofs_xattr_entry {
 	__u8   e_name_len;      /* length of name */
-- 
2.19.1.6.gb485710b

