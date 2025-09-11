Return-Path: <linux-erofs+bounces-1020-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2862FB53C44
	for <lists+linux-erofs@lfdr.de>; Thu, 11 Sep 2025 21:28:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cN6zp6zDtz2yrP;
	Fri, 12 Sep 2025 05:28:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1757618918;
	cv=none; b=bV0dcqEgxQsG62OSAtfItvydhDjJeOIJ3FuRHK53/ikcnXfb4FQxfNMWIx1mbqmezQqiQkfoVvx+ikfhX2Ujmux9PIJS4Hqolgsfvwvc4TrY9e6f5XOOOs+6p4GiSJvf1XqN1jSOyGwOSfvT/IlWYjVSDLiZscyA3vd8nwcU34cNxuZzFOP0fJ3rvpwNXufLMZH6YFYy9biSfwh5+/Mu8NpZlXOMLDC2LMb1P/DhfWHnk2srreZit+CLEyBmFc7t7w5E+i47zKkHnCM0PBguC3jKzu2jeI7wZxy77VWnOSMXd/mYdsWLUH/OLxLBGA9e/E63u15wZkGMv8YA4TybzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1757618918; c=relaxed/relaxed;
	bh=kMSjA4IeivR99b/1alIdtExkzAmrBX13qyN8e4zMEq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1TKa2Z5I/A6LyoZpp6dQlBlNyI9bnwhz2CTO/446QMhsyvEZTgSVGn0gn9Jm7g9ucw9Y5u9lsxFMpk3FJ6BUlV/4c+vVJZ3GbEPwnx/GF52XPKnQP3ucuZVx0qpgZkgHeoifNO7ZQsCjyYSgcgr59U40pQ6UYpgZOpo0BmuDq4LeWc6AkFqNNrtPu7epFBFfi7DL6dIFEE/DrTUIewW4dUuim3Bhb5u/LSXbCavgQkjfTyGa6ggcCK33LuTjLJWBn0a65fIGyWerM/wNAw3LODPMSL8grmo039EDIQ3aNX/Q82A2+PibsreWo8OW2YuKgVHBgM9fjm74R0vZyrBDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NIjf85KZ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=NIjf85KZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cN6zp1JNcz2yr6
	for <linux-erofs@lists.ozlabs.org>; Fri, 12 Sep 2025 05:28:37 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757618914; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kMSjA4IeivR99b/1alIdtExkzAmrBX13qyN8e4zMEq4=;
	b=NIjf85KZiVWrBAjSzeTm0dxL2dxKXgnj15vA2fP5tktA0S9RsbG5ot4KrQ0DDPXktMT0qqHrN3X4Bnp4erKfMWa13VuTcJJjI8t7Lzan08cxVLKsI2iZf+qRmK0hEM7dipNwI9BApb6rr1eeOXqmygeKrEOMjID/EsHNb8djeIs=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WnnX5Nd_1757618909 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 12 Sep 2025 03:28:32 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/2] erofs-utils: mkfs: fix location of xattr long prefixes
Date: Fri, 12 Sep 2025 03:28:27 +0800
Message-ID: <20250911192827.1774829-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250911192827.1774829-1-hsiangkao@linux.alibaba.com>
References: <20250911192827.1774829-1-hsiangkao@linux.alibaba.com>
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

Previously, xattr long prefixes were always kept in packed_inode
by mkfs.erofs [1], even when the fragments feature could be avoided.

This is messy, so let's fix the placement as follows:

 COMPAT_PLAIN_XATTR_PFX is not set:
  - If INCOMPAT_METABOX is set, place long prefixes into metabox_inode
    (since it should be treated as metadata);

  - If INCOMPAT_FRAGMENTS is set, place long prefixes into packed_inode
    (for compatibility only);

 Otherwise, always place long prefixes directly on disk.

[1] ff160922e94a ("erofs-utils: introduce on-disk format for long xattr name prefixes")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h |  1 +
 include/erofs/xattr.h    |  2 +-
 include/erofs_fs.h       |  1 +
 lib/xattr.c              | 71 +++++++++++++++++++++++++++++++---------
 mkfs/main.c              |  7 +++-
 5 files changed, 65 insertions(+), 17 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 3e1000d..cea6420 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -186,6 +186,7 @@ EROFS_FEATURE_FUNCS(48bit, incompat, INCOMPAT_48BIT)
 EROFS_FEATURE_FUNCS(metabox, incompat, INCOMPAT_METABOX)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
+EROFS_FEATURE_FUNCS(plain_xattr_pfx, compat, COMPAT_PLAIN_XATTR_PFX)
 
 #define EROFS_I_EA_INITED_BIT	0
 #define EROFS_I_Z_INITED_BIT	1
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 81604b6..769791a 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -50,7 +50,7 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 
 int erofs_xattr_insert_name_prefix(const char *prefix);
 void erofs_xattr_cleanup_name_prefixes(void);
-int erofs_xattr_flush_name_prefixes(struct erofs_sb_info *sbi);
+int erofs_xattr_flush_name_prefixes(struct erofs_sb_info *sbi, bool plain);
 void erofs_xattr_prefixes_cleanup(struct erofs_sb_info *sbi);
 int erofs_xattr_prefixes_init(struct erofs_sb_info *sbi);
 
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index df1af98..887f37f 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -16,6 +16,7 @@
 #define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
 #define EROFS_FEATURE_COMPAT_MTIME              0x00000002
 #define EROFS_FEATURE_COMPAT_XATTR_FILTER	0x00000004
+#define EROFS_FEATURE_COMPAT_PLAIN_XATTR_PFX	0x00000010
 
 /*
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
diff --git a/lib/xattr.c b/lib/xattr.c
index 114e2bb..977031d 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -17,6 +17,7 @@
 #include "erofs/xattr.h"
 #include "erofs/fragments.h"
 #include "liberofs_cache.h"
+#include "liberofs_metabox.h"
 #include "liberofs_xxhash.h"
 #include "liberofs_private.h"
 
@@ -804,23 +805,48 @@ static int comp_shared_xattr_item(const void *a, const void *b)
 	return la > lb;
 }
 
-int erofs_xattr_flush_name_prefixes(struct erofs_sb_info *sbi)
+int erofs_xattr_flush_name_prefixes(struct erofs_sb_info *sbi, bool plain)
 {
-	int fd = erofs_packedfile(sbi);
+	bool may_fragments = cfg.c_fragments || erofs_sb_has_fragments(sbi);
+	struct erofs_vfile *vf = &sbi->bdev;
+	struct erofs_bufmgr *bmgr = sbi->bmgr;
+	struct erofs_buffer_head *bh = NULL;
+	struct erofs_vfile _vf;
 	struct ea_type_node *tnode;
-	s64 offset;
+	s64 start, offset = 0;
 	int err;
 
 	if (!ea_prefix_count)
 		return 0;
-	offset = lseek(fd, 0, SEEK_CUR);
-	if (offset < 0)
-		return -errno;
-	offset = round_up(offset, 4);
+
+	if (plain) {
+		erofs_sb_set_plain_xattr_pfx(sbi);
+		if (may_fragments)
+			erofs_sb_set_metabox(sbi);
+	} else if (erofs_sb_has_metabox(sbi)) {
+		bmgr = erofs_metabox_bmgr(sbi);
+		vf = bmgr->vf;
+	} else if (may_fragments) {
+		erofs_sb_set_fragments(sbi);
+		_vf = (struct erofs_vfile){ .fd = erofs_packedfile(sbi) };
+		vf = &_vf;
+		offset = lseek(vf->fd, 0, SEEK_CUR);
+		if (offset < 0)
+			return -errno;
+		bmgr = NULL;
+	}
+
+	if (bmgr) {
+		bh = erofs_balloc(bmgr, XATTR, 0, 0);
+		if (IS_ERR(bh))
+			return PTR_ERR(bh);
+		(void)erofs_mapbh(bmgr, bh->block);
+		offset = erofs_btell(bh, false);
+	}
+
 	if ((offset >> 2) > UINT32_MAX)
 		return -EOVERFLOW;
-	if (lseek(fd, offset, SEEK_SET) < 0)
-		return -errno;
+	start = offset;
 
 	sbi->xattr_prefix_start = (u32)offset >> 2;
 	sbi->xattr_prefix_count = ea_prefix_count;
@@ -842,17 +868,27 @@ int erofs_xattr_flush_name_prefixes(struct erofs_sb_info *sbi)
 		       infix_len);
 		len = sizeof(struct erofs_xattr_long_prefix) + infix_len;
 		u.s.size = cpu_to_le16(len);
-		err = __erofs_io_write(fd, &u.s, sizeof(__le16) + len);
+		err = erofs_io_pwrite(vf, &u.s, offset, sizeof(__le16) + len);
 		if (err != sizeof(__le16) + len) {
 			if (err < 0)
-				return -errno;
+				return err;
 			return -EIO;
 		}
 		offset = round_up(offset + sizeof(__le16) + len, 4);
-		if (lseek(fd, offset, SEEK_SET) < 0)
+	}
+
+	if (bh) {
+		bh->op = &erofs_drop_directly_bhops;
+		err = erofs_bh_balloon(bh, offset - start);
+		if (err < 0)
+			return err;
+		bh->op = &erofs_drop_directly_bhops;
+		erofs_bdrop(bh, false);
+	} else {
+		DBG_BUGON(bmgr);
+		if (lseek(vf->fd, offset, SEEK_CUR) < 0)
 			return -errno;
 	}
-	erofs_sb_set_fragments(sbi);
 	erofs_sb_set_xattr_prefixes(sbi);
 	return 0;
 }
@@ -1641,6 +1677,7 @@ void erofs_xattr_prefixes_cleanup(struct erofs_sb_info *sbi)
 
 int erofs_xattr_prefixes_init(struct erofs_sb_info *sbi)
 {
+	bool plain = erofs_sb_has_plain_xattr_pfx(sbi);
 	erofs_off_t pos = (erofs_off_t)sbi->xattr_prefix_start << 2;
 	struct erofs_xattr_prefix_item *pfs;
 	erofs_nid_t nid = 0;
@@ -1650,8 +1687,12 @@ int erofs_xattr_prefixes_init(struct erofs_sb_info *sbi)
 	if (!sbi->xattr_prefix_count)
 		return 0;
 
-	if (sbi->packed_nid)
-		nid = sbi->packed_nid;
+	if (!plain) {
+		if (sbi->metabox_nid)
+			nid = sbi->metabox_nid;
+		else if (sbi->packed_nid)
+			nid = sbi->packed_nid;
+	}
 
 	pfs = calloc(sbi->xattr_prefix_count, sizeof(*pfs));
 	if (!pfs)
diff --git a/mkfs/main.c b/mkfs/main.c
index c328e0a..a8208d4 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -415,6 +415,7 @@ static struct {
 };
 
 static bool mkfs_no_datainline;
+static bool mkfs_plain_xattr_pfx;
 
 static int parse_extended_opts(const char *opts)
 {
@@ -491,6 +492,10 @@ static int parse_extended_opts(const char *opts)
 			if (vallen)
 				return -EINVAL;
 			cfg.c_xattr_name_filter = !clear;
+		} else if (MATCH_EXTENTED_OPT("plain-xattr-prefixes", token, keylen)) {
+			if (vallen)
+				return -EINVAL;
+			mkfs_plain_xattr_pfx = true;
 		} else {
 			int i, err;
 
@@ -1788,7 +1793,7 @@ int main(int argc, char **argv)
 		}
 
 		if (cfg.c_extra_ea_name_prefixes)
-			erofs_xattr_flush_name_prefixes(&g_sbi);
+			erofs_xattr_flush_name_prefixes(&g_sbi, mkfs_plain_xattr_pfx);
 
 		root = erofs_new_inode(&g_sbi);
 		if (IS_ERR(root)) {
-- 
2.43.5


