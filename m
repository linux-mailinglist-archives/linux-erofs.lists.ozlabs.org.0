Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ACFA78EA34
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 12:30:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rby8s0r2gz30fF
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 20:30:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rby8k4hhdz2yVh
	for <linux-erofs@lists.ozlabs.org>; Thu, 31 Aug 2023 20:29:56 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VqxwZZY_1693477789;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VqxwZZY_1693477789)
          by smtp.aliyun-inc.com;
          Thu, 31 Aug 2023 18:29:50 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: mkfs: enable xattr name filter feature by default
Date: Thu, 31 Aug 2023 18:29:49 +0800
Message-Id: <20230831102949.119605-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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

From: Gao Xiang <hsiangkao@linux.alibaba.com>

Turn it on by default since it's a compatible feature.  Instead,
it can be disabled explicitly with "-E^xattr-name-filter".

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
changes: flush inode bhs prior to erofs_mkfs_update_super_block(),
otherwise the xattr filter feature bit may has not been set when
erofs_mkfs_update_super_block() is called.

v1: https://lore.kernel.org/all/ZO4z5%2Fl3bVC6aE+8@debian/
---
 include/erofs/xattr.h |  2 +-
 lib/inode.c           |  4 ++--
 lib/xattr.c           |  6 +++++-
 mkfs/main.c           | 19 +++++++++++++++++--
 4 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 748442a..cf02257 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -76,7 +76,7 @@ static inline unsigned int xattrblock_offset(struct erofs_inode *vi,
 
 int erofs_scan_file_xattrs(struct erofs_inode *inode);
 int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
-char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size);
+char *erofs_export_xattr_ibody(struct erofs_inode *inode);
 int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *path);
 
 int erofs_xattr_insert_name_prefix(const char *prefix);
diff --git a/lib/inode.c b/lib/inode.c
index d54f84f..85eacab 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -574,8 +574,8 @@ static bool erofs_bh_flush_write_inode(struct erofs_buffer_head *bh)
 	off += inode->inode_isize;
 
 	if (inode->xattr_isize) {
-		char *xattrs = erofs_export_xattr_ibody(&inode->i_xattrs,
-							inode->xattr_isize);
+		char *xattrs = erofs_export_xattr_ibody(inode);
+
 		if (IS_ERR(xattrs))
 			return false;
 
diff --git a/lib/xattr.c b/lib/xattr.c
index 65dd9a0..0cab29f 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -843,8 +843,10 @@ static u32 erofs_xattr_filter_map(struct list_head *ixattrs)
 	return EROFS_XATTR_FILTER_DEFAULT & ~name_filter;
 }
 
-char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size)
+char *erofs_export_xattr_ibody(struct erofs_inode *inode)
 {
+	struct list_head *ixattrs = &inode->i_xattrs;
+	unsigned int size = inode->xattr_isize;
 	struct inode_xattr_node *node, *n;
 	struct erofs_xattr_ibody_header *header;
 	LIST_HEAD(ilst);
@@ -860,6 +862,8 @@ char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int size)
 	if (cfg.c_xattr_name_filter) {
 		header->h_name_filter =
 			cpu_to_le32(erofs_xattr_filter_map(ixattrs));
+		if (header->h_name_filter)
+			erofs_sb_set_xattr_filter(inode->sbi);
 	}
 
 	p = sizeof(struct erofs_xattr_ibody_header);
diff --git a/mkfs/main.c b/mkfs/main.c
index fad80b1..843a658 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -145,6 +145,7 @@ static int parse_extended_opts(const char *opts)
 
 	value = NULL;
 	for (token = opts; *token != '\0'; token = next) {
+		bool clear = false;
 		const char *p = strchr(token, ',');
 
 		next = NULL;
@@ -168,6 +169,14 @@ static int parse_extended_opts(const char *opts)
 			vallen = 0;
 		}
 
+		if (token[0] == '^') {
+			if (keylen < 2)
+				return -EINVAL;
+			++token;
+			--keylen;
+			clear = true;
+		}
+
 		if (MATCH_EXTENTED_OPT("legacy-compress", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
@@ -249,8 +258,7 @@ handle_fragment:
 		if (MATCH_EXTENTED_OPT("xattr-name-filter", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			cfg.c_xattr_name_filter = true;
-			erofs_sb_set_xattr_filter(&sbi);
+			cfg.c_xattr_name_filter = !clear;
 		}
 	}
 	return 0;
@@ -695,6 +703,7 @@ static void erofs_mkfs_default_options(void)
 {
 	cfg.c_showprogress = true;
 	cfg.c_legacy_compress = false;
+	cfg.c_xattr_name_filter = true;
 	sbi.blkszbits = ilog2(EROFS_MAX_BLOCK_SIZE);
 	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_ZERO_PADDING;
 	sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
@@ -983,6 +992,12 @@ int main(int argc, char **argv)
 		erofs_iput(packed_inode);
 	}
 
+	/* flush all buffers except for the superblock */
+	if (!erofs_bflush(NULL)) {
+		err = -EIO;
+		goto exit;
+	}
+
 	err = erofs_mkfs_update_super_block(sb_bh, root_nid, &nblocks,
 					    packed_nid);
 	if (err)
-- 
2.19.1.6.gb485710b

