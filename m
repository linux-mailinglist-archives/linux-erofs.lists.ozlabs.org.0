Return-Path: <linux-erofs+bounces-770-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E43AB1B03B
	for <lists+linux-erofs@lfdr.de>; Tue,  5 Aug 2025 10:31:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bx68w0T3kz2yLJ;
	Tue,  5 Aug 2025 18:31:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1754382704;
	cv=none; b=XqvxrvAYum6/YGcjEY3NJHJgLUqsXkLV1HociBRHQpZLlSLmqcYGi10KhhONEir8+k3neg0XhxvpVwZwBCZJ2Pe3GrkAgaTnDJ/UJSSVnDagobkNEiHJB6CHE5ETo9trpHP1FBTTfNxH46qPE2VvLau0plUgdMx8P31t3/v00AgKN9pO7qfBaoCHlItksFtgxFTEMKRSid7aShhXQmL4B+VXkez8MaHctf2rupFFkZ8U7zQ9vv4HwPQODq5Nk21bwaHFvm4Xh2ZXfuhsZejNd2GSHzylSkMxliTQHNZT8xWF1utV5uZzUla0ONWWuasMzGxqGfvnsXe0n4F4hXvvFA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1754382704; c=relaxed/relaxed;
	bh=m/2WG1MsiS3vveskuc4ysLskd28Ro+N83f5WZ7DgcCY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NT5ysPRPL68/fmDMMh6VjB/OWes3vrudvdir2+aeMH3A5opksypfoqRBRgztzwqDS0kw2E+KrVfbqMhaY3RwnUhU3a3RRSaXIYp1SgIz0uMo/5kGibP9i6scgXb3ZzNbF4NCdwESXKsAShZT4ERFZXk7qLB0VmYKBhr1YONLEum/sYe7NYJRnAwfiBZmugi1o9uTw7GnhvAKZ3ml451OImRFiwMLplRfxqSXvU7ysD9AdbD5tUpObSEPuO4Xht0YDnIyBcy+RPehFQ3hXsKWF9mcSu8wnOCMRrA3ODGxgZA8+DXR/k6J3b+nJ6WZq8krM0dk2qSfidfLua5qFpEo6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eUx8wAX9; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=eUx8wAX9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bx68s2lvvz3bh6
	for <linux-erofs@lists.ozlabs.org>; Tue,  5 Aug 2025 18:31:39 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1754382694; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=m/2WG1MsiS3vveskuc4ysLskd28Ro+N83f5WZ7DgcCY=;
	b=eUx8wAX9TPGSp5DftPa0K4c9bcMIgx2ZYJgMtmVdcBXMK08uylZUTWrAPNVvIwI2vaWHurtVAIy4T3uL/KL6nt1CgKtxN07LTPlVSQoDbzKNdmmcS2uBcCsBzEJQDaq2u5OCjbl//3qyTOxTElYm3FfK+os3QtWzLQ0bPcNByyQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wl4aK.j_1754382681 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Aug 2025 16:31:33 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2 1/2] erofs-utils: dump,fsck,fuse: support metadata compression
Date: Tue,  5 Aug 2025 16:31:20 +0800
Message-ID: <20250805083121.3479866-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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

Source kernel commit: 3f59153f08cc7ab3d6686f6ee1960232fd0426d3
Source kernel commit: c1fed66045986c0f0153912a87b0de511f8781a7

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v1: https://lore.kernel.org/r/20250718065419.3338307-10-hsiangkao@linux.alibaba.com
changes since v1:
 - Fill up the final commit ids;
 - BIT() -> BIT_ULL().

 dump/main.c              | 10 +++++++++-
 fsck/main.c              | 25 ++++++++++++++---------
 include/erofs/internal.h | 19 ++++++++++++------
 include/erofs_fs.h       | 12 ++++++++---
 lib/data.c               | 43 ++++++++++++++++++++++++++++++++++------
 lib/namei.c              |  5 +++--
 lib/super.c              | 29 +++++++++++++++++++++------
 lib/xattr.c              | 12 +++++------
 lib/zmap.c               | 15 ++++++++------
 9 files changed, 125 insertions(+), 45 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index f0dab02..38cc8a2 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -105,6 +105,7 @@ static struct erofsdump_feature feature_lists[] = {
 	{ false, EROFS_FEATURE_INCOMPAT_DEDUPE, "dedupe" },
 	{ false, EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES, "xattr_prefixes" },
 	{ false, EROFS_FEATURE_INCOMPAT_48BIT, "48bit" },
+	{ false, EROFS_FEATURE_INCOMPAT_METABOX, "metabox" },
 };
 
 static int erofsdump_readdir(struct erofs_dir_context *ctx);
@@ -163,7 +164,11 @@ static int erofsdump_parse_options_cfg(int argc, char **argv)
 			exit(0);
 		case 2:
 			dumpcfg.show_inode = true;
-			dumpcfg.nid = (erofs_nid_t)atoll(optarg);
+			dumpcfg.nid = strtoull(optarg, &endptr, 0);
+			if (*endptr != '\0') {
+				erofs_err("invalid NID %s", optarg);
+				return -EINVAL;
+			}
 			++dumpcfg.totalshow;
 			break;
 		case 'h':
@@ -643,6 +648,9 @@ static void erofsdump_show_superblock(void)
 	if (erofs_sb_has_fragments(&g_sbi) && g_sbi.packed_nid > 0)
 		fprintf(stdout, "Filesystem packed nid:                        %llu\n",
 			g_sbi.packed_nid | 0ULL);
+	if (erofs_sb_has_metabox(&g_sbi))
+		fprintf(stdout, "Filesystem metabox nid:                       %llu\n",
+			g_sbi.metabox_nid | 0ULL);
 	if (erofs_sb_has_compr_cfgs(&g_sbi)) {
 		fprintf(stdout, "Filesystem compr_algs:                        ");
 		erofsdump_print_supported_compressors(stdout,
diff --git a/fsck/main.c b/fsck/main.c
index 44719b9..d4f0fea 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -333,12 +333,14 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 	struct erofs_sb_info *sbi = inode->sbi;
 	unsigned int xattr_hdr_size = sizeof(struct erofs_xattr_ibody_header);
 	unsigned int xattr_entry_size = sizeof(struct erofs_xattr_entry);
-	erofs_off_t addr;
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	unsigned int ofs, xattr_shared_count;
 	struct erofs_xattr_ibody_header *ih;
 	struct erofs_xattr_entry *entry;
-	int i, remaining = inode->xattr_isize, ret = 0;
-	char buf[EROFS_MAX_BLOCK_SIZE];
+	int remaining = inode->xattr_isize, ret = 0;
+	erofs_off_t addr;
+	char *ptr;
+	int i;
 
 	if (inode->xattr_isize == xattr_hdr_size) {
 		erofs_err("xattr_isize %d of nid %llu is not supported yet",
@@ -355,13 +357,15 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 	}
 
 	addr = erofs_iloc(inode) + inode->inode_isize;
-	ret = erofs_dev_read(sbi, 0, buf, addr, xattr_hdr_size);
-	if (ret < 0) {
+	ptr = erofs_read_metabuf(&buf, sbi, addr,
+				 erofs_inode_in_metabox(inode));
+	if (IS_ERR(ptr)) {
+		ret = PTR_ERR(ptr);
 		erofs_err("failed to read xattr header @ nid %llu: %d",
 			  inode->nid | 0ULL, ret);
 		goto out;
 	}
-	ih = (struct erofs_xattr_ibody_header *)buf;
+	ih = (struct erofs_xattr_ibody_header *)ptr;
 	xattr_shared_count = ih->h_shared_count;
 
 	ofs = erofs_blkoff(sbi, addr) + xattr_hdr_size;
@@ -385,14 +389,16 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 	while (remaining > 0) {
 		unsigned int entry_sz;
 
-		ret = erofs_dev_read(sbi, 0, buf, addr, xattr_entry_size);
-		if (ret) {
+		ptr = erofs_read_metabuf(&buf, sbi, addr,
+				 erofs_inode_in_metabox(inode));
+		if (IS_ERR(ptr)) {
+			ret = PTR_ERR(ptr);
 			erofs_err("failed to read xattr entry @ nid %llu: %d",
 				  inode->nid | 0ULL, ret);
 			goto out;
 		}
 
-		entry = (struct erofs_xattr_entry *)buf;
+		entry = (struct erofs_xattr_entry *)ptr;
 		entry_sz = erofs_xattr_entry_size(entry);
 		if (remaining < entry_sz) {
 			erofs_err("xattr on-disk corruption: xattr entry beyond xattr_isize @ nid %llu",
@@ -404,6 +410,7 @@ static int erofs_verify_xattr(struct erofs_inode *inode)
 		remaining -= entry_sz;
 	}
 out:
+	erofs_put_metabuf(&buf);
 	return ret;
 }
 
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 3439a18..de6f4ea 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -126,6 +126,7 @@ struct erofs_sb_info {
 		u16 device_id_mask;		/* used for others */
 	};
 	erofs_nid_t packed_nid;
+	erofs_nid_t metabox_nid;
 
 	u32 xattr_prefix_start;
 	u8 xattr_prefix_count;
@@ -153,8 +154,6 @@ struct erofs_sb_info {
 	bool useqpl;
 };
 
-#define EROFS_SUPER_END (EROFS_SUPER_OFFSET + sizeof(struct erofs_super_block))
-
 /* make sure that any user of the erofs headers has atleast 64bit off_t type */
 extern int erofs_assert_largefile[sizeof(off_t)-8];
 
@@ -182,6 +181,7 @@ EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
 EROFS_FEATURE_FUNCS(48bit, incompat, INCOMPAT_48BIT)
+EROFS_FEATURE_FUNCS(metabox, incompat, INCOMPAT_METABOX)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 
@@ -295,12 +295,18 @@ struct erofs_inode {
 #endif
 };
 
+static inline bool erofs_inode_in_metabox(struct erofs_inode *inode)
+{
+	return inode->nid >> EROFS_DIRENT_NID_METABOX_BIT;
+}
+
 static inline erofs_off_t erofs_iloc(struct erofs_inode *inode)
 {
 	struct erofs_sb_info *sbi = inode->sbi;
+	erofs_off_t base = erofs_inode_in_metabox(inode) ? 0 :
+			erofs_pos(sbi, sbi->meta_blkaddr);
 
-	return erofs_pos(sbi, sbi->meta_blkaddr) +
-			(inode->nid << EROFS_ISLOTBITS);
+	return base + ((inode->nid & EROFS_DIRENT_NID_MASK) << EROFS_ISLOTBITS);
 }
 
 static inline bool is_inode_layout_compression(struct erofs_inode *inode)
@@ -437,9 +443,10 @@ int erofs_ilookup(const char *path, struct erofs_inode *vi);
 static inline void erofs_unmap_metabuf(struct erofs_buf *buf) {}
 static inline void erofs_put_metabuf(struct erofs_buf *buf) {}
 void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap);
-void erofs_init_metabuf(struct erofs_buf *buf, struct erofs_sb_info *sbi);
+void erofs_init_metabuf(struct erofs_buf *buf, struct erofs_sb_info *sbi,
+			bool in_mbox);
 void *erofs_read_metabuf(struct erofs_buf *buf, struct erofs_sb_info *sbi,
-			 erofs_off_t offset);
+			 erofs_off_t offset, bool in_mbox);
 int erofs_iopen(struct erofs_vfile *vf, struct erofs_inode *inode);
 int erofs_map_blocks(struct erofs_inode *inode,
 		struct erofs_map_blocks *map, int flags);
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index e180c5d..df1af98 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -32,8 +32,9 @@
 #define EROFS_FEATURE_INCOMPAT_DEDUPE		0x00000020
 #define EROFS_FEATURE_INCOMPAT_XATTR_PREFIXES	0x00000040
 #define EROFS_FEATURE_INCOMPAT_48BIT		0x00000080
+#define EROFS_FEATURE_INCOMPAT_METABOX		0x00000100
 #define EROFS_ALL_FEATURE_INCOMPAT		\
-	((EROFS_FEATURE_INCOMPAT_48BIT << 1) - 1)
+	((EROFS_FEATURE_INCOMPAT_METABOX << 1) - 1)
 
 #define EROFS_SB_EXTSLOT_SIZE	16
 
@@ -83,7 +84,9 @@ struct erofs_super_block {
 	__u8 reserved[3];
 	__le32 build_time;	/* seconds added to epoch for mkfs time */
 	__le64 rootnid_8b;	/* (48BIT on) nid of root directory */
-	__u8 reserved2[8];
+	__le64 reserved2;
+	__le64 metabox_nid;	/* (METABOX on) nid of the metabox inode */
+	__le64 reserved3;
 };
 
 /*
@@ -268,6 +271,9 @@ struct erofs_inode_chunk_index {
 	__le32 startblk_lo;	/* starting block number of this chunk */
 };
 
+#define EROFS_DIRENT_NID_METABOX_BIT	63
+#define EROFS_DIRENT_NID_MASK	(BIT_ULL(EROFS_DIRENT_NID_METABOX_BIT) - 1)
+
 /* dirent sorts in alphabet order, thus we can do binary search */
 struct erofs_dirent {
 	__le64 nid;     /* node number */
@@ -448,7 +454,7 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 	};
 #endif
 
-	BUILD_BUG_ON(sizeof(struct erofs_super_block) != 128);
+	BUILD_BUG_ON(sizeof(struct erofs_super_block) != 144);
 	BUILD_BUG_ON(sizeof(struct erofs_inode_compact) != 32);
 	BUILD_BUG_ON(sizeof(struct erofs_inode_extended) != 64);
 	BUILD_BUG_ON(sizeof(struct erofs_xattr_ibody_header) != 12);
diff --git a/lib/data.c b/lib/data.c
index 87ced24..6791fda 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -14,6 +14,8 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 {
 	struct erofs_sb_info *sbi = buf->sbi;
 	u32 blksiz = erofs_blksiz(sbi);
+	struct erofs_vfile vfm, *vf;
+	struct erofs_inode vi;
 	erofs_blk_t blknr;
 	int err;
 
@@ -22,7 +24,22 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 	blknr = erofs_blknr(sbi, offset);
 	if (blknr != buf->blocknr) {
 		buf->blocknr = ~0ULL;
-		err = erofs_pread(buf->vf, buf->base, blksiz,
+		vf = buf->vf;
+		/*
+		 * TODO: introduce a metabox cache like the current fragment
+		 *       cache to improve userspace metadata performance.
+		 */
+		if (!vf) {
+			vi = (struct erofs_inode) { .sbi = sbi,
+						    .nid = sbi->metabox_nid };
+			err = erofs_read_inode_from_disk(&vi);
+			if (!err)
+				err = erofs_iopen(&vfm, &vi);
+			if (err)
+				return ERR_PTR(err);
+			vf = &vfm;
+		}
+		err = erofs_pread(vf, buf->base, blksiz,
 				  round_down(offset, blksiz));
 		if (err)
 			return ERR_PTR(err);
@@ -31,16 +48,17 @@ void *erofs_bread(struct erofs_buf *buf, erofs_off_t offset, bool need_kmap)
 	return buf->base + erofs_blkoff(sbi, offset);
 }
 
-void erofs_init_metabuf(struct erofs_buf *buf, struct erofs_sb_info *sbi)
+void erofs_init_metabuf(struct erofs_buf *buf, struct erofs_sb_info *sbi,
+			bool in_mbox)
 {
 	buf->sbi = sbi;
-	buf->vf = &sbi->bdev;
+	buf->vf = in_mbox ? NULL : &sbi->bdev;
 }
 
 void *erofs_read_metabuf(struct erofs_buf *buf, struct erofs_sb_info *sbi,
-			 erofs_off_t offset)
+			 erofs_off_t offset, bool in_mbox)
 {
-	erofs_init_metabuf(buf, sbi);
+	erofs_init_metabuf(buf, sbi, in_mbox);
 	return erofs_bread(buf, offset, true);
 }
 
@@ -215,7 +233,20 @@ static int erofs_read_raw_data(struct erofs_inode *inode, char *buffer,
 		eend = min(offset + size, map.m_la + map.m_llen);
 		DBG_BUGON(ptr < map.m_la);
 
-		if (!(map.m_flags & EROFS_MAP_MAPPED)) {
+		if ((map.m_flags & EROFS_MAP_META) &&
+		    erofs_inode_in_metabox(inode)) {
+			struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+			void *src;
+
+			src = erofs_read_metabuf(&buf, inode->sbi,
+						 map.m_pa, true);
+			if (IS_ERR(src))
+				return PTR_ERR(src);
+			memcpy(estart, src, eend - ptr);
+			erofs_put_metabuf(&buf);
+			ptr = eend;
+			continue;
+		} else if (!(map.m_flags & EROFS_MAP_MAPPED)) {
 			if (!map.m_llen) {
 				/* reached EOF */
 				memset(estart, 0, offset + size - ptr);
diff --git a/lib/namei.c b/lib/namei.c
index 8de0a90..e0a6085 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -27,6 +27,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	struct erofs_sb_info *sbi = vi->sbi;
 	erofs_blk_t blkaddr = erofs_blknr(sbi, erofs_iloc(vi));
 	unsigned int ofs = erofs_blkoff(sbi, erofs_iloc(vi));
+	bool in_mbox = erofs_inode_in_metabox(vi);
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	erofs_blk_t addrmask = BIT_ULL(48) - 1;
 	struct erofs_inode_extended *die, copied;
@@ -35,7 +36,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	void *ptr;
 	int err = 0;
 
-	ptr = erofs_read_metabuf(&buf, sbi, erofs_pos(sbi, blkaddr));
+	ptr = erofs_read_metabuf(&buf, sbi, erofs_pos(sbi, blkaddr), in_mbox);
 	if (IS_ERR(ptr)) {
 		err = PTR_ERR(ptr);
 		erofs_err("failed to get inode (nid: %llu) page, err %d",
@@ -74,7 +75,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 
 			memcpy(&copied, dic, gotten);
 			ptr = erofs_read_metabuf(&buf, sbi,
-					erofs_pos(sbi, blkaddr + 1));
+					erofs_pos(sbi, blkaddr + 1), in_mbox);
 			if (IS_ERR(ptr)) {
 				err = PTR_ERR(ptr);
 				erofs_err("failed to get inode payload block (nid: %llu), err %d",
diff --git a/lib/super.c b/lib/super.c
index 1d13e6e..57849fb 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -79,7 +79,7 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 	int read, ret;
 
 	read = erofs_io_pread(&sbi->bdev, data, EROFS_MAX_BLOCK_SIZE, 0);
-	if (read < EROFS_SUPER_END) {
+	if (read < EROFS_SUPER_OFFSET + sizeof(*dsb)) {
 		ret = read < 0 ? read : -EIO;
 		erofs_err("cannot read erofs superblock: %s",
 			  erofs_strerror(ret));
@@ -123,6 +123,12 @@ int erofs_read_superblock(struct erofs_sb_info *sbi)
 		sbi->root_nid = le16_to_cpu(dsb->rb.rootnid_2b);
 	}
 	sbi->packed_nid = le64_to_cpu(dsb->packed_nid);
+	if (erofs_sb_has_metabox(sbi)) {
+		if (sbi->sb_size <= offsetof(struct erofs_super_block,
+					     metabox_nid))
+			return -EFSCORRUPTED;
+		sbi->metabox_nid = le64_to_cpu(dsb->metabox_nid);
+	}
 	sbi->inos = le64_to_cpu(dsb->inos);
 	sbi->checksum = le32_to_cpu(dsb->checksum);
 
@@ -187,7 +193,6 @@ int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh)
 		.devt_slotoff = cpu_to_le16(sbi->devt_slotoff),
 		.packed_nid = cpu_to_le64(sbi->packed_nid),
 	};
-	const u32 sb_blksize = round_up(EROFS_SUPER_END, erofs_blksiz(sbi));
 	char *buf;
 	int ret;
 
@@ -205,16 +210,21 @@ int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh)
 	else
 		sb.u1.lz4_max_distance = cpu_to_le16(sbi->lz4.max_distance);
 
-	buf = calloc(sb_blksize, 1);
+	if (erofs_sb_has_metabox(sbi))
+		sb.metabox_nid = cpu_to_le64(sbi->metabox_nid);
+	sb.sb_extslots = (sbi->sb_size - 128) >> 4;
+
+	buf = calloc(round_up(EROFS_SUPER_OFFSET + sbi->sb_size,
+			      erofs_blksiz(sbi)), 1);
 	if (!buf) {
 		erofs_err("failed to allocate memory for sb: %s",
 			  erofs_strerror(-errno));
 		return -ENOMEM;
 	}
-	memcpy(buf + EROFS_SUPER_OFFSET, &sb, sizeof(sb));
+	memcpy(buf + EROFS_SUPER_OFFSET, &sb, sbi->sb_size);
 
 	ret = erofs_dev_write(sbi, buf, sb_bh ? erofs_btell(sb_bh, false) : 0,
-			      EROFS_SUPER_END);
+			      EROFS_SUPER_OFFSET + sbi->sb_size);
 	free(buf);
 	if (sb_bh)
 		erofs_bdrop(sb_bh, false);
@@ -223,9 +233,16 @@ int erofs_writesb(struct erofs_sb_info *sbi, struct erofs_buffer_head *sb_bh)
 
 struct erofs_buffer_head *erofs_reserve_sb(struct erofs_bufmgr *bmgr)
 {
+	struct erofs_sb_info *sbi = bmgr->sbi;
 	struct erofs_buffer_head *bh;
+	unsigned int sb_size = 128;
 	int err;
 
+	if (erofs_sb_has_metabox(sbi) &&
+	    sb_size <= offsetof(struct erofs_super_block, metabox_nid))
+		sb_size = offsetof(struct erofs_super_block, metabox_nid) + 8;
+	sbi->sb_size = round_up(sb_size, 16);
+
 	bh = erofs_balloc(bmgr, META, 0, 0);
 	if (IS_ERR(bh)) {
 		erofs_err("failed to allocate super: %s",
@@ -233,7 +250,7 @@ struct erofs_buffer_head *erofs_reserve_sb(struct erofs_bufmgr *bmgr)
 		return bh;
 	}
 	bh->op = &erofs_skip_write_bhops;
-	err = erofs_bh_balloon(bh, EROFS_SUPER_END);
+	err = erofs_bh_balloon(bh, EROFS_SUPER_OFFSET + sbi->sb_size);
 	if (err < 0) {
 		erofs_err("failed to balloon super: %s", erofs_strerror(err));
 		goto err_bdrop;
diff --git a/lib/xattr.c b/lib/xattr.c
index a2ef8d2..1f6a83f 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -1079,7 +1079,7 @@ static int init_inode_xattrs(struct erofs_inode *vi)
 	it.ofs = erofs_blkoff(sbi, erofs_iloc(vi) + vi->inode_isize);
 
 	/* read in shared xattr array (non-atomic, see kmalloc below) */
-	it.kaddr = erofs_read_metabuf(&it.buf, sbi, erofs_pos(sbi, it.blkaddr));
+	it.kaddr = erofs_read_metabuf(&it.buf, sbi, erofs_pos(sbi, it.blkaddr), false);
 	if (IS_ERR(it.kaddr))
 		return PTR_ERR(it.kaddr);
 
@@ -1101,7 +1101,7 @@ static int init_inode_xattrs(struct erofs_inode *vi)
 			DBG_BUGON(it.ofs != erofs_blksiz(sbi));
 
 			it.kaddr = erofs_read_metabuf(&it.buf, sbi,
-					erofs_pos(sbi, ++it.blkaddr));
+					erofs_pos(sbi, ++it.blkaddr), false);
 			if (IS_ERR(it.kaddr)) {
 				free(vi->xattr_shared_xattrs);
 				vi->xattr_shared_xattrs = NULL;
@@ -1143,7 +1143,7 @@ static inline int xattr_iter_fixup(struct xattr_iter *it)
 
 	it->blkaddr += erofs_blknr(sbi, it->ofs);
 	it->kaddr = erofs_read_metabuf(&it->buf, sbi,
-				       erofs_pos(sbi, it->blkaddr));
+				       erofs_pos(sbi, it->blkaddr), false);
 	if (IS_ERR(it->kaddr))
 		return PTR_ERR(it->kaddr);
 	it->ofs = erofs_blkoff(sbi, it->ofs);
@@ -1168,7 +1168,7 @@ static int inline_xattr_iter_begin(struct xattr_iter *it,
 	it->ofs = erofs_blkoff(sbi, erofs_iloc(vi) + inline_xattr_ofs);
 
 	it->kaddr = erofs_read_metabuf(&it->buf, sbi,
-				       erofs_pos(sbi, it->blkaddr));
+				       erofs_pos(sbi, it->blkaddr), false);
 	if (IS_ERR(it->kaddr))
 		return PTR_ERR(it->kaddr);
 	return vi->xattr_isize - xattr_header_sz;
@@ -1393,7 +1393,7 @@ static int shared_getxattr(struct erofs_inode *vi, struct getxattr_iter *it)
 
 		it->it.ofs = xattrblock_offset(vi, vi->xattr_shared_xattrs[i]);
 		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sbi,
-						  erofs_pos(sbi, blkaddr));
+						  erofs_pos(sbi, blkaddr), false);
 		if (IS_ERR(it->it.kaddr))
 			return PTR_ERR(it->it.kaddr);
 		it->it.blkaddr = blkaddr;
@@ -1548,7 +1548,7 @@ static int shared_listxattr(struct erofs_inode *vi, struct listxattr_iter *it)
 
 		it->it.ofs = xattrblock_offset(vi, vi->xattr_shared_xattrs[i]);
 		it->it.kaddr = erofs_read_metabuf(&it->it.buf, sbi,
-						  erofs_pos(sbi, blkaddr));
+						  erofs_pos(sbi, blkaddr), false);
 		if (IS_ERR(it->it.kaddr))
 			return PTR_ERR(it->it.kaddr);
 		it->it.blkaddr = blkaddr;
diff --git a/lib/zmap.c b/lib/zmap.c
index db8561b..916b0d2 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -35,7 +35,8 @@ static int z_erofs_load_full_lcluster(struct z_erofs_maprecorder *m,
 	struct z_erofs_lcluster_index *di;
 	unsigned int advise;
 
-	di = erofs_read_metabuf(&m->map->buf, sbi, pos);
+	di = erofs_read_metabuf(&m->map->buf, sbi, pos,
+				erofs_inode_in_metabox(vi));
 	if (IS_ERR(di))
 		return PTR_ERR(di);
 	m->lcn = lcn;
@@ -150,7 +151,8 @@ static int z_erofs_load_compact_lcluster(struct z_erofs_maprecorder *m,
 	else
 		return -EOPNOTSUPP;
 
-	in = erofs_read_metabuf(&m->map->buf, sbi, pos);
+	in = erofs_read_metabuf(&m->map->buf, sbi, pos,
+				erofs_inode_in_metabox(vi));
 	if (IS_ERR(in))
 		return PTR_ERR(in);
 
@@ -541,6 +543,7 @@ static int z_erofs_map_blocks_ext(struct erofs_inode *vi,
 	unsigned int recsz = z_erofs_extent_recsize(vi->z_advise);
 	erofs_off_t pos = round_up(Z_EROFS_MAP_HEADER_END(erofs_iloc(vi) +
 				   vi->inode_isize + vi->xattr_isize), recsz);
+	bool in_mbox = erofs_inode_in_metabox(vi);
 	erofs_off_t lend = vi->i_size;
 	erofs_off_t l, r, mid, pa, la, lstart;
 	struct z_erofs_extent *ext;
@@ -550,7 +553,7 @@ static int z_erofs_map_blocks_ext(struct erofs_inode *vi,
 	map->m_flags = 0;
 	if (recsz <= offsetof(struct z_erofs_extent, pstart_hi)) {
 		if (recsz <= offsetof(struct z_erofs_extent, pstart_lo)) {
-			ext = erofs_read_metabuf(&map->buf, sbi, pos);
+			ext = erofs_read_metabuf(&map->buf, sbi, pos, in_mbox);
 			if (IS_ERR(ext))
 				return PTR_ERR(ext);
 			pa = le64_to_cpu(*(__le64 *)ext);
@@ -562,7 +565,7 @@ static int z_erofs_map_blocks_ext(struct erofs_inode *vi,
 		}
 
 		for (; lstart <= map->m_la; lstart += 1 << vi->z_lclusterbits) {
-			ext = erofs_read_metabuf(&map->buf, sbi, pos);
+			ext = erofs_read_metabuf(&map->buf, sbi, pos, in_mbox);
 			if (IS_ERR(ext))
 				return PTR_ERR(ext);
 			map->m_plen = le32_to_cpu(ext->plen);
@@ -582,7 +585,7 @@ static int z_erofs_map_blocks_ext(struct erofs_inode *vi,
 		for (l = 0, r = vi->z_extents; l < r; ) {
 			mid = l + (r - l) / 2;
 			ext = erofs_read_metabuf(&map->buf, sbi,
-						 pos + mid * recsz);
+						 pos + mid * recsz, in_mbox);
 			if (IS_ERR(ext))
 				return PTR_ERR(ext);
 
@@ -651,7 +654,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_inode *vi)
 		return 0;
 
 	pos = round_up(erofs_iloc(vi) + vi->inode_isize + vi->xattr_isize, 8);
-	h = erofs_read_metabuf(&buf, sbi, pos);
+	h = erofs_read_metabuf(&buf, sbi, pos, erofs_inode_in_metabox(vi));
 	if (IS_ERR(h))
 		return PTR_ERR(h);
 
-- 
2.43.5


