Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690656D5A32
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 10:02:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrKxl1xL7z3f3c
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 18:02:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrKxP67VJz3cG7
	for <linux-erofs@lists.ozlabs.org>; Tue,  4 Apr 2023 18:02:33 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R991e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VfKztQ2_1680595349;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VfKztQ2_1680595349)
          by smtp.aliyun-inc.com;
          Tue, 04 Apr 2023 16:02:29 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org,
	hsiangkao@linux.alibaba.com
Subject: [PATCH 5/6] erofs-utils: build erofs_xattr_entry upon extra xattr name prefix
Date: Tue,  4 Apr 2023 16:02:22 +0800
Message-Id: <20230404080224.77577-6-jefflexu@linux.alibaba.com>
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

Build the xattr entry also considering the extra xattr name prefix.  The
user specified extra xattr name prefix takes precedence over the
predefined xattr name prefix.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/internal.h |  3 +++
 lib/xattr.c              | 44 ++++++++++++++++++++++++++++++++++++++++
 mkfs/main.c              |  2 ++
 3 files changed, 49 insertions(+)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 641a795..f441429 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -102,6 +102,9 @@ struct erofs_sb_info {
 		u16 device_id_mask;		/* used for others */
 	};
 	erofs_nid_t packed_nid;
+
+	u32 ea_prefix_off;
+	u8 ea_prefix_count;
 };
 
 /* make sure that any user of the erofs headers has atleast 64bit off_t type */
diff --git a/lib/xattr.c b/lib/xattr.c
index ec40aad..f1db8bf 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -17,6 +17,7 @@
 #include "erofs/xattr.h"
 #include "erofs/cache.h"
 #include "erofs/io.h"
+#include "erofs/fragments.h"
 #include "liberofs_private.h"
 
 #define EA_HASHTABLE_BITS 16
@@ -138,7 +139,16 @@ static struct xattr_item *get_xattritem(u8 prefix, char *kvbuf,
 static bool match_prefix(const char *key, u8 *index, u16 *len)
 {
 	struct xattr_prefix *p;
+	struct ea_type_node *tnode;
 
+	list_for_each_entry(tnode, &ea_types, list) {
+		p = &tnode->type;
+		if (p->prefix && !strncmp(p->prefix, key, p->prefix_len)) {
+			*len = p->prefix_len;
+			*index = tnode->index;
+			return true;
+		}
+	}
 	for (p = xattr_types; p < xattr_types + ARRAY_SIZE(xattr_types); ++p) {
 		if (p->prefix && !strncmp(p->prefix, key, p->prefix_len)) {
 			*len = p->prefix_len;
@@ -587,6 +597,34 @@ static int comp_xattr_item(const void *a, const void *b)
 	return la > lb;
 }
 
+static int erofs_xattr_write_ea_prefix(void)
+{
+	struct ea_type_node *tnode;
+	struct xattr_prefix *p;
+#ifdef HAVE_FTELLO64
+	off64_t offset = ftello64(packedfile);
+#else
+	off_t offset = ftello(packedfile);
+#endif
+
+	if (offset < 0)
+		return -errno;
+	if (offset > UINT32_MAX)
+		return -EOVERFLOW;
+
+	sbi.ea_prefix_count = ea_types_count;
+	sbi.ea_prefix_off = (u32)offset;
+
+	list_for_each_entry(tnode, &ea_types, list) {
+		p = &tnode->type;
+		if (fwrite(&p->prefix_len, sizeof(u8), 1, packedfile) != 1)
+			return -EIO;
+		if (fwrite(p->prefix, p->prefix_len + 1, 1, packedfile) != 1)
+			return -EIO;
+	}
+	return 0;
+}
+
 int erofs_build_shared_xattrs_from_path(const char *path)
 {
 	int ret;
@@ -610,6 +648,12 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 	if (ret)
 		return ret;
 
+	if (ea_types_count) {
+		ret = erofs_xattr_write_ea_prefix();
+		if (ret)
+			return ret;
+	}
+
 	if (!shared_xattrs_size)
 		goto out;
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 50fd908..56b100c 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -574,6 +574,8 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.blocks = 0,
 		.meta_blkaddr  = sbi.meta_blkaddr,
 		.xattr_blkaddr = sbi.xattr_blkaddr,
+		.ea_prefix_count = sbi.ea_prefix_count,
+		.ea_prefix_off = cpu_to_le32(sbi.ea_prefix_off),
 		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
 		.feature_compat = cpu_to_le32(sbi.feature_compat &
 					      ~EROFS_FEATURE_COMPAT_SB_CHKSUM),
-- 
2.19.1.6.gb485710b

