Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B21FEA14A5F
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 08:46:28 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YZBcq4V4vz3dK0
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Jan 2025 18:46:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737099977;
	cv=none; b=QcS0SQWEynhbhizp88Mo71jG9PGxqu+doXuc7UtIwSkLS+mQ2Dm8Ap2NDx3+bZApHJeVk18QMwAkERFaiIfVaCoDmSEeJXOeWT7YlTM8Kq2jNWZZKg79nwrI1sVfL/Tl2brPnS5ZNoTxOwZa/+sR1RpWXmD0CdZLMCkeCS+LzDQrMEzjPwSvbcVz+HP00utnoF0OH26dJFNRBkWHtUIR5L0Ssfy+9sJAdU5Vwjy1P05zU9ZgYbzLWC1LFr9oBDmlKX+XW1SXqTpiQNJZlikCPEjSWlt9dp1+ncKbZJg3Pu5LCJVPx5THOSKpCVLGT8Z1PXDllBgUxNKgx6HrlfA14g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737099977; c=relaxed/relaxed;
	bh=XhFhP7fBuUSCR5I5L9Gn8ogA+2PVDfja+MMYn4yzZeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqEUcihWm1sVqvsl10svbq3xFplTw6WDQSiyY8yD8VafUqMVr5fwgiS4IeT/fs6yyGXlIaBLbj5hm4lQ1CDHYNoIJlnNiJsfQB6wMsE0Hu6jZRsngmPSnVPZ471dm8GdBszSgozshQ8Ri2a2tscUWu+1T1jhq1w9MNIDT0pXsmnGldYFdFHgmc64ukgwVOIY3VyEoPZHZnNn+yp1YV/SvZhyx+lTvaqr2r1rDuyIPfnLeCs7GWxqN9TbWo7dHNvs/RVOr9WSdeWAMlQ3oT6RROnz68ZgdARN2ZcexrT3XR3aznSUSM0hT8OB/grwiqgOFlWsCFbKlOVJRQ7iTOujfw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MnQPqLJV; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MnQPqLJV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YZBcl3NFdz3chF
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Jan 2025 18:46:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737099970; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XhFhP7fBuUSCR5I5L9Gn8ogA+2PVDfja+MMYn4yzZeQ=;
	b=MnQPqLJVfg6yvIwfHe4TywdIx6oLxXA/eekAxMSosT2zBHsSI5eOIq6GysPcK0+i3KNSuYKycXwgq8E+2YZ53vIie1+U3vYPWvRZMSIB4Hws33njVopk2X3bJ+QVC5mWRq/n2SeOXeMItVYw+ojqkTnAuy8wmD4AGYHeMjI8eu4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNo5ScJ_1737099968 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Jan 2025 15:46:09 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/3] erofs-utils: lib: rework per-sb fragment generator
Date: Fri, 17 Jan 2025 15:46:01 +0800
Message-ID: <20250117074602.2223094-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250117074602.2223094-1-hsiangkao@linux.alibaba.com>
References: <20250117074602.2223094-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

It's also used for the upcoming fragment cache.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/fragments.h |  14 ++--
 include/erofs/internal.h  |   3 +
 include/erofs/xattr.h     |   2 +-
 lib/fragments.c           | 150 +++++++++++++++++++++++---------------
 lib/xattr.c               |   3 +-
 mkfs/main.c               |  20 ++---
 6 files changed, 109 insertions(+), 83 deletions(-)

diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
index 65910f5..e92b7c7 100644
--- a/include/erofs/fragments.h
+++ b/include/erofs/fragments.h
@@ -15,17 +15,17 @@ extern "C"
 extern const char *erofs_frags_packedname;
 #define EROFS_PACKED_INODE	erofs_frags_packedname
 
-FILE *erofs_packedfile_init(void);
-void erofs_packedfile_exit(void);
-int erofs_flush_packed_inode(struct erofs_sb_info *sbi);
-
 int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *tofcrc);
+
+void z_erofs_fragments_commit(struct erofs_inode *inode);
 int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofcrc);
 int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
 			   unsigned int len, u32 tofcrc);
-void z_erofs_fragments_commit(struct erofs_inode *inode);
-int z_erofs_fragments_init(void);
-void z_erofs_fragments_exit(void);
+int erofs_flush_packed_inode(struct erofs_sb_info *sbi);
+FILE *erofs_packedfile(struct erofs_sb_info *sbi);
+
+int erofs_packedfile_init(struct erofs_sb_info *sbi, bool fragments_mkfs);
+void erofs_packedfile_exit(struct erofs_sb_info *sbi);
 
 #ifdef __cplusplus
 }
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 5d7d022..eb665e2 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -81,6 +81,8 @@ struct erofs_xattr_prefix_item {
 #define EROFS_PACKED_NID_UNALLOCATED	-1
 
 struct erofs_mkfs_dfops;
+struct erofs_packed_inode;
+
 struct erofs_sb_info {
 	struct erofs_sb_lz4_info lz4;
 	struct erofs_device_info *devs;
@@ -139,6 +141,7 @@ struct erofs_sb_info {
 	struct erofs_mkfs_dfops *mkfs_dfops;
 #endif
 	struct erofs_bufmgr *bmgr;
+	struct erofs_packed_inode *packedinode;
 	bool useqpl;
 };
 
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
index 804f565..81604b6 100644
--- a/include/erofs/xattr.h
+++ b/include/erofs/xattr.h
@@ -50,7 +50,7 @@ int erofs_build_shared_xattrs_from_path(struct erofs_sb_info *sbi, const char *p
 
 int erofs_xattr_insert_name_prefix(const char *prefix);
 void erofs_xattr_cleanup_name_prefixes(void);
-int erofs_xattr_write_name_prefixes(struct erofs_sb_info *sbi, FILE *f);
+int erofs_xattr_flush_name_prefixes(struct erofs_sb_info *sbi);
 void erofs_xattr_prefixes_cleanup(struct erofs_sb_info *sbi);
 int erofs_xattr_prefixes_init(struct erofs_sb_info *sbi);
 
diff --git a/lib/fragments.c b/lib/fragments.c
index e2d3343..43cebe0 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -37,8 +37,11 @@ struct erofs_fragment_dedupe_item {
 #define FRAGMENT_HASHSIZE		65536
 #define FRAGMENT_HASH(c)		((c) & (FRAGMENT_HASHSIZE - 1))
 
-static struct list_head dupli_frags[FRAGMENT_HASHSIZE];
-static FILE *packedfile;
+struct erofs_packed_inode {
+	struct list_head *hash;
+	FILE *file;
+};
+
 const char *erofs_frags_packedname = "packed_file";
 
 #ifndef HAVE_LSEEK64
@@ -50,14 +53,14 @@ const char *erofs_frags_packedname = "packed_file";
 static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
 					 u32 crc)
 {
+	struct erofs_packed_inode *epi = inode->sbi->packedinode;
 	struct erofs_fragment_dedupe_item *cur, *di = NULL;
-	struct list_head *head;
+	struct list_head *head = &epi->hash[FRAGMENT_HASH(crc)];
 	u8 *data;
 	unsigned int length, e2, deduped;
 	erofs_off_t pos;
 	int ret;
 
-	head = &dupli_frags[FRAGMENT_HASH(crc)];
 	if (list_empty(head))
 		return 0;
 
@@ -115,14 +118,14 @@ static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
 	pos = di->pos + di->length - deduped;
 	/* let's read more to dedupe as long as we can */
 	if (deduped == di->length) {
-		fflush(packedfile);
+		fflush(epi->file);
 
 		while(deduped < inode->i_size && pos) {
 			char buf[2][16384];
 			unsigned int sz = min_t(unsigned int, pos,
 						sizeof(buf[0]));
 
-			if (pread(fileno(packedfile), buf[0], sz,
+			if (pread(fileno(epi->file), buf[0], sz,
 				  pos - sz) != sz)
 				break;
 			if (pread(fd, buf[1], sz,
@@ -170,8 +173,8 @@ int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *tofcrc)
 	return 0;
 }
 
-static int z_erofs_fragments_dedupe_insert(void *data, unsigned int len,
-					   erofs_off_t pos, u32 crc)
+static int z_erofs_fragments_dedupe_insert(struct list_head *hash, void *data,
+					   unsigned int len, erofs_off_t pos)
 {
 	struct erofs_fragment_dedupe_item *di;
 
@@ -190,33 +193,10 @@ static int z_erofs_fragments_dedupe_insert(void *data, unsigned int len,
 	di->length = len;
 	di->pos = pos;
 
-	list_add_tail(&di->list, &dupli_frags[FRAGMENT_HASH(crc)]);
+	list_add_tail(&di->list, hash);
 	return 0;
 }
 
-int z_erofs_fragments_init(void)
-{
-	unsigned int i;
-
-	for (i = 0; i < FRAGMENT_HASHSIZE; ++i)
-		init_list_head(&dupli_frags[i]);
-	return 0;
-}
-
-void z_erofs_fragments_exit(void)
-{
-	struct erofs_fragment_dedupe_item *di, *n;
-	struct list_head *head;
-	unsigned int i;
-
-	for (i = 0; i < FRAGMENT_HASHSIZE; ++i) {
-		head = &dupli_frags[i];
-
-		list_for_each_entry_safe(di, n, head, list)
-			free(di);
-	}
-}
-
 void z_erofs_fragments_commit(struct erofs_inode *inode)
 {
 	if (!inode->fragment_size)
@@ -232,13 +212,13 @@ void z_erofs_fragments_commit(struct erofs_inode *inode)
 	erofs_sb_set_fragments(inode->sbi);
 }
 
-int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd,
-			      u32 tofcrc)
+int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofcrc)
 {
+	struct erofs_packed_inode *epi = inode->sbi->packedinode;
 #ifdef HAVE_FTELLO64
-	off64_t offset = ftello64(packedfile);
+	off64_t offset = ftello64(epi->file);
 #else
-	off_t offset = ftello(packedfile);
+	off_t offset = ftello(epi->file);
 #endif
 	char *memblock;
 	int rc;
@@ -267,7 +247,7 @@ int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd,
 					rc = -EAGAIN;
 				goto out;
 			}
-			if (fwrite(buf, sz, 1, packedfile) != 1) {
+			if (fwrite(buf, sz, 1, epi->file) != 1) {
 				rc = -EIO;
 				goto out;
 			}
@@ -278,7 +258,7 @@ int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd,
 			rc = -errno;
 			goto out;
 		}
-	} else if (fwrite(memblock, inode->fragment_size, 1, packedfile) != 1) {
+	} else if (fwrite(memblock, inode->fragment_size, 1, epi->file) != 1) {
 		rc = -EIO;
 		goto out;
 	}
@@ -287,8 +267,9 @@ int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd,
 		  inode->fragment_size | 0ULL, inode->fragmentoff | 0ULL);
 
 	if (memblock)
-		rc = z_erofs_fragments_dedupe_insert(memblock,
-			inode->fragment_size, inode->fragmentoff, tofcrc);
+		rc = z_erofs_fragments_dedupe_insert(
+			&epi->hash[FRAGMENT_HASH(tofcrc)], memblock,
+			inode->fragment_size, inode->fragmentoff);
 	else
 		rc = 0;
 out:
@@ -300,10 +281,11 @@ out:
 int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
 			   unsigned int len, u32 tofcrc)
 {
+	struct erofs_packed_inode *epi = inode->sbi->packedinode;
 #ifdef HAVE_FTELLO64
-	off64_t offset = ftello64(packedfile);
+	off64_t offset = ftello64(epi->file);
 #else
-	off_t offset = ftello(packedfile);
+	off_t offset = ftello(epi->file);
 #endif
 	int ret;
 
@@ -313,14 +295,14 @@ int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
 	inode->fragmentoff = (erofs_off_t)offset;
 	inode->fragment_size = len;
 
-	if (fwrite(data, len, 1, packedfile) != 1)
+	if (fwrite(data, len, 1, epi->file) != 1)
 		return -EIO;
 
 	erofs_dbg("Recording %llu fragment data at %llu",
 		  inode->fragment_size | 0ULL, inode->fragmentoff | 0ULL);
 
-	ret = z_erofs_fragments_dedupe_insert(data, len, inode->fragmentoff,
-					      tofcrc);
+	ret = z_erofs_fragments_dedupe_insert(&epi->hash[FRAGMENT_HASH(tofcrc)],
+					      data, len, inode->fragmentoff);
 	if (ret)
 		return ret;
 	return len;
@@ -328,35 +310,85 @@ int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
 
 int erofs_flush_packed_inode(struct erofs_sb_info *sbi)
 {
+	struct erofs_packed_inode *epi = sbi->packedinode;
 	struct erofs_inode *inode;
 
-	if (!erofs_sb_has_fragments(sbi))
+	if (!epi || !erofs_sb_has_fragments(sbi))
 		return -EINVAL;
-	fflush(packedfile);
-	if (!ftello(packedfile))
-		return 0;
 
-	inode = erofs_mkfs_build_special_from_fd(sbi, fileno(packedfile),
+	fflush(epi->file);
+	if (!ftello(epi->file))
+		return 0;
+	inode = erofs_mkfs_build_special_from_fd(sbi, fileno(epi->file),
 						 EROFS_PACKED_INODE);
 	sbi->packed_nid = erofs_lookupnid(inode);
 	erofs_iput(inode);
 	return 0;
 }
 
-void erofs_packedfile_exit(void)
+FILE *erofs_packedfile(struct erofs_sb_info *sbi)
+{
+	return sbi->packedinode->file;
+}
+
+void erofs_packedfile_exit(struct erofs_sb_info *sbi)
 {
-	if (packedfile)
-		fclose(packedfile);
+	struct erofs_packed_inode *epi = sbi->packedinode;
+	struct erofs_fragment_dedupe_item *di, *n;
+	int i;
+
+	if (!epi)
+		return;
+
+	if (epi->hash) {
+		for (i = 0; i < FRAGMENT_HASHSIZE; ++i)
+			list_for_each_entry_safe(di, n, &epi->hash[i], list)
+				free(di);
+		free(epi->hash);
+	}
+
+	if (epi->file)
+		fclose(epi->file);
+	free(epi);
+	sbi->packedinode = NULL;
 }
 
-FILE *erofs_packedfile_init(void)
+int erofs_packedfile_init(struct erofs_sb_info *sbi, bool fragments_mkfs)
 {
+	struct erofs_packed_inode *epi;
+	int err, i;
+
+	if (sbi->packedinode)
+		return -EINVAL;
+
+	epi = calloc(1, sizeof(*epi));
+	if (!epi)
+		return -ENOMEM;
+
+	sbi->packedinode = epi;
+	if (fragments_mkfs) {
+		epi->hash = malloc(sizeof(*epi->hash) * FRAGMENT_HASHSIZE);
+		if (!epi->hash) {
+			err = -ENOMEM;
+			goto err_out;
+		}
+		for (i = 0; i < FRAGMENT_HASHSIZE; ++i)
+			init_list_head(&epi->hash[i]);
+	}
+
+	epi->file =
 #ifdef HAVE_TMPFILE64
-	packedfile = tmpfile64();
+		tmpfile64();
 #else
-	packedfile = tmpfile();
+		tmpfile();
 #endif
-	if (!packedfile)
-		return ERR_PTR(-ENOMEM);
-	return packedfile;
+	if (!epi->file) {
+		err = -errno;
+		goto err_out;
+	}
+	return 0;
+
+err_out:
+	erofs_packedfile_exit(sbi);
+	return err;
 }
diff --git a/lib/xattr.c b/lib/xattr.c
index c20c9a2..063b01a 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -809,8 +809,9 @@ static int comp_shared_xattr_item(const void *a, const void *b)
 	return la > lb;
 }
 
-int erofs_xattr_write_name_prefixes(struct erofs_sb_info *sbi, FILE *f)
+int erofs_xattr_flush_name_prefixes(struct erofs_sb_info *sbi)
 {
+	FILE *f = erofs_packedfile(sbi);
 	struct ea_type_node *tnode;
 	off_t offset;
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 624b191..a0fce35 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1197,7 +1197,6 @@ int main(int argc, char **argv)
 	struct erofs_inode *root = NULL;
 	erofs_blk_t nblocks = 0;
 	struct timeval t;
-	FILE *packedfile = NULL;
 	FILE *blklst = NULL;
 	u32 crc;
 
@@ -1253,17 +1252,10 @@ int main(int argc, char **argv)
 		if (!cfg.c_mkfs_pclustersize_packed)
 			cfg.c_mkfs_pclustersize_packed = cfg.c_mkfs_pclustersize_def;
 
-		packedfile = erofs_packedfile_init();
-		if (IS_ERR(packedfile)) {
-			erofs_err("failed to initialize packedfile");
-			return 1;
-		}
-	}
-
-	if (cfg.c_fragments) {
-		err = z_erofs_fragments_init();
+		err = erofs_packedfile_init(&g_sbi, cfg.c_fragments);
 		if (err) {
-			erofs_err("failed to initialize fragments");
+			erofs_err("failed to initialize packedfile: %s",
+				  strerror(-err));
 			return 1;
 		}
 	}
@@ -1445,7 +1437,7 @@ int main(int argc, char **argv)
 		}
 
 		if (cfg.c_extra_ea_name_prefixes)
-			erofs_xattr_write_name_prefixes(&g_sbi, packedfile);
+			erofs_xattr_flush_name_prefixes(&g_sbi);
 
 		root = erofs_mkfs_build_tree_from_path(&g_sbi, cfg.c_src_path);
 		if (IS_ERR(root)) {
@@ -1510,9 +1502,7 @@ exit:
 	erofs_cleanup_exclude_rules();
 	if (cfg.c_chunkbits)
 		erofs_blob_exit();
-	if (cfg.c_fragments)
-		z_erofs_fragments_exit();
-	erofs_packedfile_exit();
+	erofs_packedfile_exit(&g_sbi);
 	erofs_xattr_cleanup_name_prefixes();
 	erofs_rebuild_cleanup();
 	erofs_diskbuf_exit();
-- 
2.43.5

