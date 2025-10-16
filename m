Return-Path: <linux-erofs+bounces-1190-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 87827BE14FF
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Oct 2025 04:48:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnC7f6qVBz3bvd;
	Thu, 16 Oct 2025 13:48:30 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760582910;
	cv=none; b=lM9xilr9i+pm12FWVO/ckcIcbYychDGctQD/qQgUDGO+j1q/5JOnVA4Dnvwg+ihhQIkwpkrP8iaPEknHndcJzIHIO1qpN9PSX+mLwvIRMfMXGhXzUR6HkCmbtu9Bgb8oMMUrM3ZdJ/UY1/SqFwoZskonnWCsIu6gNHa7XGgvFY09VDb9xEgLHDK7ecmeY3N8TJLABIEOmYp2xC72MxjmZobu19fvSI7Vkv/6RqR76HFcDW3CYebsuAwe65C+BIDcwZ7bSpyVtTIxpn2J0gYLNCOazLPf8+U0/p6jZcp2P3FbW3s7KKZ+TqXAhzHDq2X20mzNmIu/W4NcFyk42Mxq2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760582910; c=relaxed/relaxed;
	bh=Rdm87C0A0dqZo0dgBUeLZX+tLVYRQ/EB35lW679LbuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JjxT2liyq0cNqJPW0ySXlLso99vNdFPk/+R7h2JjLkxLOEp3qc7fItkfu/CRAyTeeWRCg72o556jnkKsyETaEZGQvKNYp66dhKa7NOyHiyNfmsoKWhXtXMBaTPYzStUyl5PQetORUhH6rbooePaf15hbo8xbUDWDVUNJXIeRU+BiBlvW64tRNrHpxHRy+1wulBq+FDN1KFfbGx5aiMLADPCCn8pWZ0Fs9l+XmxtoXU7TW4UN3N7EBsc55RLYyR8OmqkqD1IRDgV3AQ4xu1nwNeOWGG5UdbYtnT46qRUS5eGAmdvCAWq6ACTsfReYe0MTG7guPEiUgR9oU3hgSFkw0A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=c2qBaebe; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=c2qBaebe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnC7c1Yfzz306d
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Oct 2025 13:48:27 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760582903; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Rdm87C0A0dqZo0dgBUeLZX+tLVYRQ/EB35lW679LbuA=;
	b=c2qBaebe0kme12DvDaqctzZUt3b2quJDAP9Hhy8tOc/xJhRyq4yC5F9nIBkQvtNTRuz9CEwbD5weCU7Ti4ajNKBSYLUOPiGBBXK+a/llXSCOb3Mty+C4r35QlkWbApd+I5IDfeybvPhru2J3/gY8YvXsFIggVvvJDFoeDXWrLHw=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqIZVjf_1760582902 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Oct 2025 10:48:22 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 4/7] erofs-utils: lib: switch to vfile interfaces for fragments
Date: Thu, 16 Oct 2025 10:48:12 +0800
Message-ID: <20251016024815.2750927-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251016024815.2750927-1-hsiangkao@linux.alibaba.com>
References: <20251016024815.2750927-1-hsiangkao@linux.alibaba.com>
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

Avoid using raw FDs for the upcoming directory data compression.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c           | 21 ++++++++------
 lib/fragments.c          | 62 ++++++++++++++++++----------------------
 lib/liberofs_fragments.h | 10 ++++---
 3 files changed, 47 insertions(+), 46 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 20f511e..74d40b1 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1258,13 +1258,14 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 	bool frag = params->fragments && !erofs_is_packed_inode(inode) &&
 		!erofs_is_metabox_inode(inode) &&
 		ctx->seg_idx >= ictx->seg_num - 1;
-	int fd = ictx->fd;
+	struct erofs_vfile vf = { .fd = ictx->fd };
 	int ret;
 
 	DBG_BUGON(offset != -1 && frag && inode->fragment_size);
 	if (offset != -1 && frag && !inode->fragment_size &&
 	    params->fragdedupe != EROFS_FRAGDEDUPE_OFF) {
-		ret = erofs_fragment_findmatch(inode, fd, ictx->tofh);
+		ret = erofs_fragment_findmatch(inode,
+					       &vf, ictx->fpos, ictx->tofh);
 		if (ret < 0)
 			return ret;
 		if (inode->fragment_size > ctx->remaining)
@@ -1280,9 +1281,9 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 		int ret;
 
 		ret = (offset == -1 ?
-			read(fd, ctx->queue + ctx->tail, rx) :
-			pread(fd, ctx->queue + ctx->tail, rx,
-			      ictx->fpos + offset));
+			erofs_io_read(&vf, ctx->queue + ctx->tail, rx) :
+			erofs_io_pread(&vf, ctx->queue + ctx->tail, rx,
+				       ictx->fpos + offset));
 		if (ret != rx)
 			return -errno;
 
@@ -1848,14 +1849,17 @@ void *erofs_begin_compressed_file(struct erofs_importer *im,
 		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
 
 	if (frag) {
-		ictx->tofh = z_erofs_fragments_tofh(inode, fd, fpos);
+		struct erofs_vfile vf = { .fd = fd };
+
+		ictx->tofh = z_erofs_fragments_tofh(inode, &vf, fpos);
 		if (ictx == &g_ictx &&
 		    params->fragdedupe != EROFS_FRAGDEDUPE_OFF) {
 			/*
 			 * Handle tails in advance to avoid writing duplicated
 			 * parts into the packed inode.
 			 */
-			ret = erofs_fragment_findmatch(inode, fd, ictx->tofh);
+			ret = erofs_fragment_findmatch(inode,
+						       &vf, fpos, ictx->tofh);
 			if (ret < 0)
 				goto err_free_ictx;
 
@@ -1874,7 +1878,8 @@ void *erofs_begin_compressed_file(struct erofs_importer *im,
 	ictx->dedupe = false;
 
 	if (all_fragments && !inode->fragment_size) {
-		ret = erofs_pack_file_from_fd(inode, fd, ictx->tofh);
+		ret = erofs_pack_file_from_fd(inode,
+			&((struct erofs_vfile){ .fd = fd }), fpos, ictx->tofh);
 		if (ret)
 			goto err_free_idata;
 	}
diff --git a/lib/fragments.c b/lib/fragments.c
index 244608f..15092e1 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -53,7 +53,8 @@ struct erofs_packed_inode {
 
 const char *erofs_frags_packedname = "packed_file";
 
-u32 z_erofs_fragments_tofh(struct erofs_inode *inode, int fd, erofs_off_t fpos)
+u32 z_erofs_fragments_tofh(struct erofs_inode *inode,
+			   struct erofs_vfile *vf, erofs_off_t fpos)
 {
 	u8 data_to_hash[EROFS_TOF_HASHLEN];
 	u32 hash;
@@ -62,10 +63,10 @@ u32 z_erofs_fragments_tofh(struct erofs_inode *inode, int fd, erofs_off_t fpos)
 	if (inode->i_size <= EROFS_TOF_HASHLEN)
 		return ~0U;
 
-	ret = pread(fd, data_to_hash, EROFS_TOF_HASHLEN,
-		    fpos + inode->i_size - EROFS_TOF_HASHLEN);
+	ret = erofs_io_pread(vf, data_to_hash, EROFS_TOF_HASHLEN,
+			     fpos + inode->i_size - EROFS_TOF_HASHLEN);
 	if (ret < 0)
-		return -errno;
+		return ret;
 	if (ret != EROFS_TOF_HASHLEN) {
 		DBG_BUGON(1);
 		return -EIO;
@@ -76,7 +77,9 @@ u32 z_erofs_fragments_tofh(struct erofs_inode *inode, int fd, erofs_off_t fpos)
 
 static erofs_off_t erofs_fragment_longmatch(struct erofs_inode *inode,
 					    struct erofs_fragmentitem *fi,
-					    erofs_off_t matched, int fd)
+					    erofs_off_t matched,
+					    struct erofs_vfile *vf,
+					    erofs_off_t fpos)
 {
 	struct erofs_packed_inode *epi = inode->sbi->packedinode;
 	erofs_off_t total = min_t(erofs_off_t, fi->length, inode->i_size);
@@ -99,7 +102,8 @@ static erofs_off_t erofs_fragment_longmatch(struct erofs_inode *inode,
 			return matched;
 		}
 		sz = min_t(u64, total - matched, sizeof(buf[0]));
-		if (pread(fd, buf[0], sz, inode->i_size - matched - sz) != sz)
+		if (erofs_io_pread(vf, buf[0], sz,
+				   fpos + inode->i_size - matched - sz) != sz)
 			break;
 
 		if (!inmem) {
@@ -116,7 +120,8 @@ static erofs_off_t erofs_fragment_longmatch(struct erofs_inode *inode,
 	return matched;
 }
 
-int erofs_fragment_findmatch(struct erofs_inode *inode, int fd, u32 tofh)
+int erofs_fragment_findmatch(struct erofs_inode *inode,
+			     struct erofs_vfile *vf, erofs_off_t fpos, u32 tofh)
 {
 	struct erofs_packed_inode *epi = inode->sbi->packedinode;
 	struct erofs_fragmentitem *cur, *fi = NULL;
@@ -136,7 +141,7 @@ int erofs_fragment_findmatch(struct erofs_inode *inode, int fd, u32 tofh)
 	if (!data)
 		return -ENOMEM;
 
-	ret = pread(fd, data, s1, inode->i_size - s1);
+	ret = erofs_io_pread(vf, data, s1, fpos + inode->i_size - s1);
 	if (ret != s1) {
 		free(data);
 		return -errno;
@@ -167,7 +172,7 @@ int erofs_fragment_findmatch(struct erofs_inode *inode, int fd, u32 tofh)
 		i += EROFS_TOF_HASHLEN;
 		if (i >= s1) {		/* full short match */
 			DBG_BUGON(i > s1);
-			i = erofs_fragment_longmatch(inode, cur, s1, fd);
+			i = erofs_fragment_longmatch(inode, cur, s1, vf, fpos);
 		}
 
 		if (i <= deduped)
@@ -229,7 +234,8 @@ int erofs_fragment_pack(struct erofs_inode *inode, void *data,
 	return 0;
 }
 
-int erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofh)
+int erofs_pack_file_from_fd(struct erofs_inode *inode,
+			    struct erofs_vfile *vf, erofs_off_t fpos, u32 tofh)
 {
 	struct erofs_packed_inode *epi = inode->sbi->packedinode;
 	s64 offset, rc, sz;
@@ -243,33 +249,27 @@ int erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofh)
 	if (offset < 0)
 		return -errno;
 
-	memblock = mmap(NULL, inode->i_size, PROT_READ, MAP_SHARED, fd, 0);
+	if (vf->ops)
+		memblock = NULL;
+	else
+		memblock = mmap(NULL, inode->i_size, PROT_READ,
+				MAP_SHARED, vf->fd, fpos);
 	if (memblock == MAP_FAILED || !memblock) {
 		erofs_off_t remaining = inode->i_size;
-		struct erofs_vfile vin = { .fd = fd };
+		struct erofs_vfile vout = { .fd = epi->fd };
+		off_t pos = fpos;
 
-#if defined(HAVE_SYS_SENDFILE_H) && defined(HAVE_SENDFILE)
 		do {
 			sz = min_t(u64, remaining, UINT_MAX);
-			rc = sendfile(epi->fd, fd, NULL, sz);
+			rc = erofs_io_sendfile(&vout, vf, &pos, sz);
 			if (rc <= 0)
 				break;
 			remaining -= rc;
 		} while (remaining);
-#endif
-		while (remaining) {
-			char buf[32768];
-
-			sz = min_t(u64, remaining, sizeof(buf));
-			rc = erofs_io_read(&vin, buf, sz);
-			if (rc < 0)
-				goto out;
-			if (rc > 0) {
-				rc = write(epi->fd, buf, rc);
-				if (rc < 0)
-					goto out;
-			}
-			remaining -= rc;
+
+		if (remaining && rc >= 0) {
+			rc = -EIO;
+			goto out;
 		}
 
 		sz = min_t(u64, inode->i_size, EROFS_FRAGMENT_INMEM_SZ_MAX);
@@ -288,12 +288,6 @@ int erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofh)
 			}
 			goto out;
 		}
-
-		rc = lseek(fd, 0, SEEK_SET);
-		if (rc < 0) {
-			rc = -errno;
-			goto out;
-		}
 	} else {
 		rc = __erofs_io_write(epi->fd, memblock, inode->i_size);
 		if (rc != inode->i_size) {
diff --git a/lib/liberofs_fragments.h b/lib/liberofs_fragments.h
index ca71e52..11833eb 100644
--- a/lib/liberofs_fragments.h
+++ b/lib/liberofs_fragments.h
@@ -10,10 +10,12 @@
 
 struct erofs_importer;
 
-u32 z_erofs_fragments_tofh(struct erofs_inode *inode, int fd, erofs_off_t fpos);
-int erofs_fragment_findmatch(struct erofs_inode *inode, int fd, u32 tofh);
-
-int erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofcrc);
+u32 z_erofs_fragments_tofh(struct erofs_inode *inode,
+			   struct erofs_vfile *vf, erofs_off_t fpos);
+int erofs_fragment_findmatch(struct erofs_inode *inode,
+			     struct erofs_vfile *vf, erofs_off_t fpos, u32 tofh);
+int erofs_pack_file_from_fd(struct erofs_inode *inode,
+			    struct erofs_vfile *vf, erofs_off_t fpos, u32 tofh);
 int erofs_fragment_pack(struct erofs_inode *inode, void *data,
 			erofs_off_t pos, erofs_off_t len, u32 tofh, bool tail);
 int erofs_fragment_commit(struct erofs_inode *inode, u32 tofh);
-- 
2.43.5


