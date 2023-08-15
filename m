Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CCC77CA29
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 11:15:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQ5GT65b6z3cJm
	for <lists+linux-erofs@lfdr.de>; Tue, 15 Aug 2023 19:15:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RQ5GC0jnXz30NN
	for <linux-erofs@lists.ozlabs.org>; Tue, 15 Aug 2023 19:15:30 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VprO5Q7_1692090925;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VprO5Q7_1692090925)
          by smtp.aliyun-inc.com;
          Tue, 15 Aug 2023 17:15:26 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/3] erofs-utils: support long xattr name prefixes for erofsfuse
Date: Tue, 15 Aug 2023 17:15:21 +0800
Message-Id: <20230815091521.74661-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230815091521.74661-1-jefflexu@linux.alibaba.com>
References: <20230815091521.74661-1-jefflexu@linux.alibaba.com>
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

Make erofs_listxattr() and erofs_getxattr() routine support long xattr
name prefixes.

Although the on-disk format allows long xattr name prefixes to be placed
in the meta inode or packed inode, currently mkfs.erofs will place them
in packed inode by default.  Thus let's also read long xattr name prefixes
from packed inode by default.

Since we need to read the content of the packed inode from disk when
loading long xattr name prefixes, add dependency on zlib_LIBS for
mkfs.erofs to resolve the compiling dependency.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/internal.h |   6 ++
 include/erofs/xattr.h    |   2 +
 lib/super.c              |  14 +++-
 lib/xattr.c              | 139 ++++++++++++++++++++++++++++++++++++---
 mkfs/Makefile.am         |   3 +-
 5 files changed, 152 insertions(+), 12 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index a04e6a6..df8cd51 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -57,6 +57,11 @@ struct erofs_device_info {
 	u32 mapped_blkaddr;
 };
 
+struct erofs_xattr_prefix_item {
+	struct erofs_xattr_long_prefix *prefix;
+	u8 infix_len;
+};
+
 #define EROFS_PACKED_NID_UNALLOCATED	-1
 
 struct erofs_sb_info {
@@ -99,6 +104,7 @@ struct erofs_sb_info {
 
 	u32 xattr_prefix_start;
 	u8 xattr_prefix_count;
+	struct erofs_xattr_prefix_item *xattr_prefixes;
 
 	int devfd;
 	u64 devsz;
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index dc27cf6..748442a 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -82,6 +82,8 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 int erofs_xattr_insert_name_prefix(const char *prefix);
 void erofs_xattr_cleanup_name_prefixes(void);
 int erofs_xattr_write_name_prefixes(struct erofs_sb_info *sbi, FILE *f);
+void erofs_xattr_prefixes_cleanup(struct erofs_sb_info *sbi);
+int erofs_xattr_prefixes_init(struct erofs_sb_info *sbi);
 
 int erofs_setxattr(struct erofs_inode *inode, char *key,
 		   const void *value, size_t size);
diff --git a/lib/super.c b/lib/super.c
index e8e84aa..21dc51f 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include "erofs/io.h"
 #include "erofs/print.h"
+#include "erofs/xattr.h"
 
 static bool check_layout_compatibility(struct erofs_sb_info *sbi,
 				       struct erofs_super_block *dsb)
@@ -101,6 +102,8 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 	sbi->primarydevice_blocks = le32_to_cpu(dsb->blocks);
 	sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
 	sbi->xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
+	sbi->xattr_prefix_start = le32_to_cpu(dsb->xattr_prefix_start);
+	sbi->xattr_prefix_count = dsb->xattr_prefix_count;
 	sbi->islotbits = EROFS_ISLOTBITS;
 	sbi->root_nid = le16_to_cpu(dsb->root_nid);
 	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
@@ -117,11 +120,20 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 		sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
 	else
 		sbi->lz4_max_distance = le16_to_cpu(dsb->u1.lz4_max_distance);
-	return erofs_init_devices(sbi, dsb);
+
+	ret = erofs_init_devices(sbi, dsb);
+	if (ret)
+		return ret;
+
+	ret = erofs_xattr_prefixes_init(sbi);
+	if (ret)
+		free(sbi->devs);
+	return ret;
 }
 
 void erofs_put_super(struct erofs_sb_info *sbi)
 {
 	if (sbi->devs)
 		free(sbi->devs);
+	erofs_xattr_prefixes_cleanup(sbi);
 }
diff --git a/lib/xattr.c b/lib/xattr.c
index 4091fe6..074be52 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1093,19 +1093,47 @@ out:
 struct getxattr_iter {
 	struct xattr_iter it;
 
-	int buffer_size, index;
+	int buffer_size, index, infix_len;
 	char *buffer;
 	const char *name;
 	size_t len;
 };
 
+static int erofs_xattr_long_entrymatch(struct getxattr_iter *it,
+				       struct erofs_xattr_entry *entry)
+{
+	struct erofs_sb_info *sbi = it->it.sbi;
+	struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
+		(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
+
+	if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
+		return -ENOATTR;
+
+	if (it->index != pf->prefix->base_index ||
+	    it->len != entry->e_name_len + pf->infix_len)
+		return -ENOATTR;
+
+	if (memcmp(it->name, pf->prefix->infix, pf->infix_len))
+		return -ENOATTR;
+
+	it->infix_len = pf->infix_len;
+	return 0;
+}
+
 static int xattr_entrymatch(struct xattr_iter *_it,
 			    struct erofs_xattr_entry *entry)
 {
 	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
 
-	return (it->index != entry->e_name_index ||
-		it->len != entry->e_name_len) ? -ENOATTR : 0;
+	/* should also match the infix for long name prefixes */
+	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX)
+		return erofs_xattr_long_entrymatch(it, entry);
+
+	if (it->index != entry->e_name_index ||
+	    it->len != entry->e_name_len)
+		return -ENOATTR;
+	it->infix_len = 0;
+	return 0;
 }
 
 static int xattr_namematch(struct xattr_iter *_it,
@@ -1113,8 +1141,9 @@ static int xattr_namematch(struct xattr_iter *_it,
 {
 	struct getxattr_iter *it = container_of(_it, struct getxattr_iter, it);
 
-
-	return memcmp(buf, it->name + processed, len) ? -ENOATTR : 0;
+	if (memcmp(buf, it->name + it->infix_len + processed, len))
+		return -ENOATTR;
+	return 0;
 }
 
 static int xattr_checkbuffer(struct xattr_iter *_it,
@@ -1237,8 +1266,20 @@ static int xattr_entrylist(struct xattr_iter *_it,
 	struct listxattr_iter *it =
 		container_of(_it, struct listxattr_iter, it);
 	unsigned int base_index = entry->e_name_index;
-	unsigned int prefix_len;
-	const char *prefix;
+	unsigned int prefix_len, infix_len = 0;
+	const char *prefix, *infix = NULL;
+
+	if (entry->e_name_index & EROFS_XATTR_LONG_PREFIX) {
+		struct erofs_sb_info *sbi = _it->sbi;
+		struct erofs_xattr_prefix_item *pf = sbi->xattr_prefixes +
+			(entry->e_name_index & EROFS_XATTR_LONG_PREFIX_MASK);
+
+		if (pf >= sbi->xattr_prefixes + sbi->xattr_prefix_count)
+			return 1;
+		infix = pf->prefix->infix;
+		infix_len = pf->infix_len;
+		base_index = pf->prefix->base_index;
+	}
 
 	if (base_index >= ARRAY_SIZE(xattr_types))
 		return 1;
@@ -1246,16 +1287,18 @@ static int xattr_entrylist(struct xattr_iter *_it,
 	prefix_len = xattr_types[base_index].prefix_len;
 
 	if (!it->buffer) {
-		it->buffer_ofs += prefix_len + entry->e_name_len + 1;
+		it->buffer_ofs += prefix_len + infix_len +
+					entry->e_name_len + 1;
 		return 1;
 	}
 
-	if (it->buffer_ofs + prefix_len
+	if (it->buffer_ofs + prefix_len + infix_len
 		+ entry->e_name_len + 1 > it->buffer_size)
 		return -ERANGE;
 
 	memcpy(it->buffer + it->buffer_ofs, prefix, prefix_len);
-	it->buffer_ofs += prefix_len;
+	memcpy(it->buffer + it->buffer_ofs + prefix_len, infix, infix_len);
+	it->buffer_ofs += prefix_len + infix_len;
 	return 0;
 }
 
@@ -1404,3 +1447,79 @@ void erofs_xattr_cleanup_name_prefixes(void)
 		free(tnode);
 	}
 }
+
+void erofs_xattr_prefixes_cleanup(struct erofs_sb_info *sbi)
+{
+	int i;
+
+	if (sbi->xattr_prefixes) {
+		for (i = 0; i < sbi->xattr_prefix_count; i++)
+			free(sbi->xattr_prefixes[i].prefix);
+		free(sbi->xattr_prefixes);
+		sbi->xattr_prefixes = NULL;
+	}
+}
+
+int erofs_xattr_prefixes_init(struct erofs_sb_info *sbi)
+{
+	erofs_off_t pos = (erofs_off_t)sbi->xattr_prefix_start << 2;
+	struct erofs_inode vi;
+	struct erofs_xattr_prefix_item *pfs;
+	int ret = 0, i, len;
+	__le16 __len;
+
+	if (!sbi->xattr_prefix_count)
+		return 0;
+
+	if (!sbi->packed_nid) {
+		erofs_err("doesn't support xattr prefixes in meta inode yet");
+		return -EOPNOTSUPP;
+	}
+
+	pfs = calloc(sbi->xattr_prefix_count, sizeof(*pfs));
+	if (!pfs)
+		return -ENOMEM;
+
+	vi = (struct erofs_inode) {
+		.sbi = sbi,
+		.nid = sbi->packed_nid,
+	};
+
+	ret = erofs_read_inode_from_disk(&vi);
+	if (ret) {
+		free(pfs);
+		return ret;
+	}
+
+	for (i = 0; i < sbi->xattr_prefix_count; i++) {
+		pos = round_up(pos, 4);
+		ret = erofs_pread(&vi, (void *)&__len, sizeof(__le16), pos);
+		if (ret)
+			goto out;
+		len = le16_to_cpu(__len);
+		pos += sizeof(__le16);
+
+		pfs[i].prefix = calloc(1, len);
+		if (!pfs[i].prefix) {
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		ret = erofs_pread(&vi, (void *)pfs[i].prefix, len, pos);
+		if (ret)
+			goto out;
+		pos += len;
+
+		if (len < sizeof(*pfs->prefix) ||
+		    len > EROFS_NAME_LEN + sizeof(*pfs->prefix)) {
+			ret = -EFSCORRUPTED;
+			goto out;
+		}
+		pfs[i].infix_len = len - sizeof(struct erofs_xattr_long_prefix);
+	}
+out:
+	sbi->xattr_prefixes = pfs;
+	if (ret)
+		erofs_xattr_prefixes_cleanup(sbi);
+	return ret;
+}
diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index 603c2f3..dd75485 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -6,4 +6,5 @@ AM_CPPFLAGS = ${libselinux_CFLAGS}
 mkfs_erofs_SOURCES = main.c
 mkfs_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
-	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS} ${libdeflate_LIBS}
+	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} \
+	${libdeflate_LIBS}
-- 
2.19.1.6.gb485710b

