Return-Path: <linux-erofs+bounces-386-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFEAACBF01
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Jun 2025 05:57:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bBH3C5Bdbz2yQJ;
	Tue,  3 Jun 2025 13:57:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1748923031;
	cv=none; b=MdrtdSHYR17X++nKEkCZ5vLNEuKm4ON5dKgnyCTYe7mv6USH3hTz1f5dc/WTE3WYT4fUdeR5VoVzAfydKPbU0hrP0/lIaCecB5AKtWfBxxRET5o2CeU2apZYmm8er5VzoQ2l62DVp8H4YV+zONNJDGapA97YTFM2pQ8w3IlGIbZPGrxqXHqGABS7W98ziZsfuZQgge9aEcb+u0frNa0WE6MZoZgzMX0wFTR2P1YJSuqIhrxZ4u5PC15FSaKUioRaRB0Ds7C0mvbAPy3Bbn/0meu5vY9XjWu/gh0uU1j7HNJDnJn/1agDED9sxbsUmceB8LEwO7vl1DbI7/MsNdtTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1748923031; c=relaxed/relaxed;
	bh=ypPwaHw5FsS4oIY4rqOT9k7fIk3FLhHLifCXWX9P4uc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FGKEgcl9PQphUD1wXADXlupfKqkSANyKX/8N9R5VtbJce8LomNVcqLJ6OyDVVGbuybq5zhmjNKt0r1/O2tYt78owpSXswuOdsnqF3+oHvASn5tY8zcH0KNt9BDmyyZIEd3ceUU0khG+PzfN6Wch8/0MbS7X4ANEnbHUv8fAX5fXtWFOvbkVyGDrzsm3rp6VPwi07SoWSWNacIG2MkivM9htG3zhpWHDZeNHD5Qv5IwPuQsdgrd6gTsyPgO3mnFmRNvE41vhiC2aF/y7qGeAmSx5/oJvjeQbDqjrGfZtnVhMmjzV85ExgglQa1+sSw659tk9inBz8/EU19JUqdtQ6QQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yTA5gCgm; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yTA5gCgm;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bBH380bspz2yN1
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Jun 2025 13:57:07 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748923023; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ypPwaHw5FsS4oIY4rqOT9k7fIk3FLhHLifCXWX9P4uc=;
	b=yTA5gCgmDZoYxhCjfuuROJ7JfK1b/1WPI5U0+udZ5sQW0xg3lLGREkfXirxPuCqHJmSuLU5H+33mG977z6zpCrYOPNATDfLA/x8eClFtUXD9eWW8NpoW4CFnTpzzuxgJ57AITsyluJ41jxEWnqiZCaAbK3EhRF/yJRbQkcAJI3U=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WchYNIR_1748923022 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Jun 2025 11:57:03 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/5] erofs-utils: lib: keep full data until the fragment is committed
Date: Tue,  3 Jun 2025 11:56:54 +0800
Message-ID: <20250603035657.2092012-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250603035657.2092012-1-hsiangkao@linux.alibaba.com>
References: <20250603035657.2092012-1-hsiangkao@linux.alibaba.com>
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

In order to fulfill reproducible builds, let's write all fragments to
disk in a specific order, which strictly follows to the committing
order.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/fragments.h |   9 +-
 include/erofs/internal.h  |   1 +
 lib/compress.c            |  26 ++-
 lib/fragments.c           | 345 ++++++++++++++++++++++++--------------
 4 files changed, 241 insertions(+), 140 deletions(-)

diff --git a/include/erofs/fragments.h b/include/erofs/fragments.h
index 75f1055..112f002 100644
--- a/include/erofs/fragments.h
+++ b/include/erofs/fragments.h
@@ -16,11 +16,12 @@ extern const char *erofs_frags_packedname;
 #define EROFS_PACKED_INODE	erofs_frags_packedname
 
 u32 z_erofs_fragments_tofh(struct erofs_inode *inode, int fd, erofs_off_t fpos);
-int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 tofh);
+int erofs_fragment_findmatch(struct erofs_inode *inode, int fd, u32 tofh);
 
-int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofcrc);
-int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
-			   unsigned int len, u32 tofcrc);
+int erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofcrc);
+int erofs_fragment_pack(struct erofs_inode *inode, void *data,
+			erofs_off_t pos, erofs_off_t len, u32 tofh, bool tail);
+int erofs_fragment_commit(struct erofs_inode *inode, u32 tofh);
 int erofs_flush_packed_inode(struct erofs_sb_info *sbi);
 int erofs_packedfile(struct erofs_sb_info *sbi);
 
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 90bee07..73845f1 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -272,6 +272,7 @@ struct erofs_inode {
 			union {
 				unsigned int z_idataoff;
 				erofs_off_t fragmentoff;
+				void *fragment;
 			};
 #define z_idata_size	idata_size
 		};
diff --git a/lib/compress.c b/lib/compress.c
index a260dc4..706a756 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -526,11 +526,8 @@ static bool z_erofs_fixup_deduped_fragment(struct z_erofs_compress_sctx *ctx)
 		return false;
 	}
 
-	inode->fragmentoff += inode->fragment_size - newsize;
 	inode->fragment_size = newsize;
-
-	erofs_dbg("Reducing fragment size to %llu at %llu",
-		  inode->fragment_size | 0ULL, inode->fragmentoff | 0ULL);
+	erofs_dbg("Reducing fragment size to %llu", inode->fragment_size | 0ULL);
 
 	/* it's the end */
 	DBG_BUGON(ctx->tail - ctx->head + ctx->remaining != newsize);
@@ -625,8 +622,8 @@ nocompression:
 		   compressedsize < ctx->pclustersize &&
 		   (!inode->fragment_size || ictx->fix_dedupedfrag)) {
 frag_packing:
-		ret = z_erofs_pack_fragments(inode, ctx->queue + ctx->head,
-					     len, ictx->tofh);
+		ret = erofs_fragment_pack(inode, ctx->queue + ctx->head,
+					  ~0ULL, len, ictx->tofh, false);
 		if (ret < 0)
 			return ret;
 		e->plen = 0;	/* indicate a fragment */
@@ -1103,7 +1100,7 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 	DBG_BUGON(offset != -1 && frag && inode->fragment_size);
 	if (offset != -1 && frag && !inode->fragment_size &&
 	    cfg.c_fragdedupe != FRAGDEDUPE_OFF) {
-		ret = z_erofs_fragments_dedupe(inode, fd, ictx->tofh);
+		ret = erofs_fragment_findmatch(inode, fd, ictx->tofh);
 		if (ret < 0)
 			return ret;
 		if (inode->fragment_size > ctx->remaining)
@@ -1172,6 +1169,9 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 	int ret;
 
 	if (inode->fragment_size) {
+		ret = erofs_fragment_commit(inode, ictx->tofh);
+		if (ret)
+			goto err_free_idata;
 		inode->z_advise |= Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
 		erofs_sb_set_fragments(inode->sbi);
 	}
@@ -1210,12 +1210,10 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 		legacymetasize = Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 	}
 
-	if (ptotal) {
+	if (ptotal)
 		(void)erofs_bh_balloon(bh, ptotal);
-	} else {
-		if (!cfg.c_fragments && !cfg.c_dedupe)
-			DBG_BUGON(!inode->idata_size);
-	}
+	else if (!cfg.c_fragments && !cfg.c_dedupe)
+		DBG_BUGON(!inode->idata_size);
 
 	erofs_info("compressed %s (%llu bytes) into %llu bytes",
 		   inode->i_srcpath, inode->i_size | 0ULL, ptotal | 0ULL);
@@ -1629,7 +1627,7 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 			 * Handle tails in advance to avoid writing duplicated
 			 * parts into the packed inode.
 			 */
-			ret = z_erofs_fragments_dedupe(inode, fd, ictx->tofh);
+			ret = erofs_fragment_findmatch(inode, fd, ictx->tofh);
 			if (ret < 0)
 				goto err_free_ictx;
 
@@ -1649,7 +1647,7 @@ void *erofs_begin_compressed_file(struct erofs_inode *inode, int fd, u64 fpos)
 	ictx->dedupe = false;
 
 	if (all_fragments && !inode->fragment_size) {
-		ret = z_erofs_pack_file_from_fd(inode, fd, ictx->tofh);
+		ret = erofs_pack_file_from_fd(inode, fd, ictx->tofh);
 		if (ret)
 			goto err_free_idata;
 	}
diff --git a/lib/fragments.c b/lib/fragments.c
index 9f5f1f9..ce079af 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -20,12 +20,14 @@
 #include "erofs/fragments.h"
 #include "erofs/bitops.h"
 #include "liberofs_private.h"
+#ifdef HAVE_SYS_SENDFILE_H
+#include <sys/sendfile.h>
+#endif
 
-struct erofs_fragment_dedupe_item {
+struct erofs_fragmentitem {
 	struct list_head	list;
-	unsigned int		length;
-	erofs_off_t		pos;
-	u8			data[];
+	u8			*data;
+	erofs_off_t		length, pos;
 };
 
 #define EROFS_FRAGMENT_INMEM_SZ_MAX	(256 * 1024)
@@ -34,8 +36,15 @@ struct erofs_fragment_dedupe_item {
 #define FRAGMENT_HASHSIZE		65536
 #define FRAGMENT_HASH(c)		((c) & (FRAGMENT_HASHSIZE - 1))
 
+struct erofs_fragment_bucket {
+	struct list_head hash;
+#ifdef EROFS_MT_ENABLED
+	pthread_rwlock_t lock;
+#endif
+};
+
 struct erofs_packed_inode {
-	struct list_head *hash;
+	struct erofs_fragment_bucket *bks;
 	int fd;
 	unsigned long *uptodate;
 #if EROFS_MT_ENABLED
@@ -67,11 +76,49 @@ u32 z_erofs_fragments_tofh(struct erofs_inode *inode, int fd, erofs_off_t fpos)
 	return hash != ~0U ? hash : 0;
 }
 
-int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 tofh)
+static erofs_off_t erofs_fragment_longmatch(struct erofs_inode *inode,
+					    struct erofs_fragmentitem *fi,
+					    erofs_off_t matched, int fd)
 {
 	struct erofs_packed_inode *epi = inode->sbi->packedinode;
-	struct erofs_fragment_dedupe_item *cur, *di = NULL;
-	struct list_head *head = &epi->hash[FRAGMENT_HASH(tofh)];
+	erofs_off_t pos;
+	bool inmem = false;
+
+	if (!fi->pos) {
+		inmem = true;
+		pos = fi->length - matched;
+	} else {
+		pos = fi->pos - matched;
+	}
+
+	while (matched < inode->i_size && pos) {
+		char buf[2][16384];
+		unsigned int sz;
+
+		sz = min_t(u64, pos, sizeof(buf[0]));
+		sz = min_t(u64, sz, inode->i_size - matched);
+		if (pread(fd, buf[0], sz, inode->i_size - matched - sz) != sz)
+			break;
+
+		if (!inmem) {
+			if (pread(epi->fd, buf[1], sz, pos - sz) != sz)
+				break;
+			if (memcmp(buf[0], buf[1], sz))
+				break;
+		} else if (memcmp(buf[0], fi->data + pos - sz, sz)) {
+			break;
+		}
+		pos -= sz;
+		matched += sz;
+	}
+	return matched;
+}
+
+int erofs_fragment_findmatch(struct erofs_inode *inode, int fd, u32 tofh)
+{
+	struct erofs_packed_inode *epi = inode->sbi->packedinode;
+	struct erofs_fragmentitem *cur, *fi = NULL;
+	struct erofs_fragment_bucket *bk = &epi->bks[FRAGMENT_HASH(tofh)];
 	unsigned int s1, e1;
 	erofs_off_t deduped;
 	u8 *data;
@@ -79,7 +126,7 @@ int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 tofh)
 
 	if (inode->i_size <= EROFS_TOF_HASHLEN)
 		return 0;
-	if (list_empty(head))
+	if (list_empty(&bk->hash))
 		return 0;
 
 	s1 = min_t(u64, EROFS_FRAGMENT_INMEM_SZ_MAX, inode->i_size);
@@ -94,13 +141,21 @@ int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 tofh)
 	}
 	e1 = s1 - EROFS_TOF_HASHLEN;
 	deduped = 0;
-	list_for_each_entry(cur, head, list) {
+
+#ifdef EROFS_MT_ENABLED
+	pthread_rwlock_rdlock(&bk->lock);
+#endif
+	list_for_each_entry(cur, &bk->hash, list) {
 		unsigned int e2, mn;
-		erofs_off_t i, pos;
+		erofs_off_t inmax, i;
 
 		DBG_BUGON(cur->length <= EROFS_TOF_HASHLEN);
-		e2 = cur->length - EROFS_TOF_HASHLEN;
-
+		if (cur->pos)
+			inmax = min_t(u64, cur->length,
+				      EROFS_FRAGMENT_INMEM_SZ_MAX);
+		else
+			inmax = cur->length;
+		e2 = inmax - EROFS_TOF_HASHLEN;
 		if (memcmp(data + e1, cur->data + e2, EROFS_TOF_HASHLEN))
 			continue;
 
@@ -112,173 +167,212 @@ int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 tofh)
 		i += EROFS_TOF_HASHLEN;
 		if (i >= s1) {		/* full short match */
 			DBG_BUGON(i > s1);
-			pos = cur->pos + cur->length - s1;
-			while (i < inode->i_size && pos) {
-				char buf[2][16384];
-				unsigned int sz;
-
-				sz = min_t(u64, pos, sizeof(buf[0]));
-				sz = min_t(u64, sz, inode->i_size - i);
-				if (pread(epi->fd, buf[0], sz, pos - sz) != sz)
-					break;
-				if (pread(fd, buf[1], sz,
-					  inode->i_size - i - sz) != sz)
-					break;
-
-				if (memcmp(buf[0], buf[1], sz))
-					break;
-				pos -= sz;
-				i += sz;
-			}
+			i = erofs_fragment_longmatch(inode, cur, s1, fd);
 		}
 
 		if (i <= deduped)
 			continue;
-		di = cur;
+		fi = cur;
 		deduped = i;
 		if (deduped == inode->i_size)
 			break;
 	}
-
+#ifdef EROFS_MT_ENABLED
+	pthread_rwlock_unlock(&bk->lock);
+#endif
 	free(data);
 	if (deduped) {
-		DBG_BUGON(!di);
+		DBG_BUGON(!fi);
 		inode->fragment_size = deduped;
-		inode->fragmentoff = di->pos + di->length - deduped;
-		erofs_dbg("Dedupe %llu tail data at %llu",
-			  inode->fragment_size | 0ULL, inode->fragmentoff | 0ULL);
+		inode->fragment = fi;
+		erofs_dbg("Dedupe %llu tail data", inode->fragment_size | 0ULL);
 	}
 	return 0;
 }
 
-static int z_erofs_fragments_dedupe_insert(struct erofs_inode *inode,
-					   void *data, u32 tofh)
+int erofs_fragment_pack(struct erofs_inode *inode, void *data,
+			erofs_off_t pos, erofs_off_t len, u32 tofh, bool tail)
 {
 	struct erofs_packed_inode *epi = inode->sbi->packedinode;
-	struct erofs_fragment_dedupe_item *di;
-	erofs_off_t len = inode->fragment_size;
-	erofs_off_t pos = inode->fragmentoff;
+	struct erofs_fragment_bucket *bk = &epi->bks[FRAGMENT_HASH(tofh)];
+	struct erofs_fragmentitem *fi;
+	bool inmem = (pos == ~0ULL);
 
-	if (len <= EROFS_TOF_HASHLEN)
-		return 0;
-	if (len > EROFS_FRAGMENT_INMEM_SZ_MAX) {
-		data += len - EROFS_FRAGMENT_INMEM_SZ_MAX;
-		pos += len - EROFS_FRAGMENT_INMEM_SZ_MAX;
-		len = EROFS_FRAGMENT_INMEM_SZ_MAX;
-	}
-	di = malloc(sizeof(*di) + len);
-	if (!di)
+	fi = malloc(sizeof(*fi));
+	if (!fi)
 		return -ENOMEM;
+	fi->length = len;
+	if (!inmem) {
+		pos += len;
+		if (len > EROFS_FRAGMENT_INMEM_SZ_MAX) {
+			if (!tail)
+				data += len - EROFS_FRAGMENT_INMEM_SZ_MAX;
+			len = EROFS_FRAGMENT_INMEM_SZ_MAX;
+		}
+	}
 
-	memcpy(di->data, data, len);
-	di->pos = pos;
-	di->length = len;
-	list_add_tail(&di->list, &epi->hash[FRAGMENT_HASH(tofh)]);
+	fi->data = malloc(len);
+	if (!fi->data) {
+		free(fi);
+		return -ENOMEM;
+	}
+	memcpy(fi->data, data, len);
+	fi->pos = inmem ? 0 : pos;
+	if (len > EROFS_TOF_HASHLEN) {
+		list_add_tail(&fi->list, &bk->hash);
+	} else {
+		init_list_head(&fi->list);
+	}
+	inode->fragment = fi;
+	inode->fragment_size = fi->length;
+	erofs_dbg("Recording %llu fragment data of %s",
+		  fi->length | 0ULL, inode->i_srcpath);
 	return 0;
 }
 
-int z_erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofh)
+int erofs_pack_file_from_fd(struct erofs_inode *inode, int fd, u32 tofh)
 {
 	struct erofs_packed_inode *epi = inode->sbi->packedinode;
-	s64 offset, rc;
+	s64 offset, rc, sz;
 	char *memblock;
+	bool onheap = false;
 
 	offset = lseek(epi->fd, 0, SEEK_CUR);
 	if (offset < 0)
 		return -errno;
 
-	inode->fragmentoff = (erofs_off_t)offset;
-	inode->fragment_size = inode->i_size;
-
 	memblock = mmap(NULL, inode->i_size, PROT_READ, MAP_SHARED, fd, 0);
 	if (memblock == MAP_FAILED || !memblock) {
-		unsigned long long remaining = inode->fragment_size;
-
-		memblock = NULL;
+		erofs_off_t remaining = inode->i_size;
+		struct erofs_vfile vin = { .fd = fd };
+
+#if defined(HAVE_SYS_SENDFILE_H) && defined(HAVE_SENDFILE)
+		do {
+			sz = min_t(u64, remaining, UINT_MAX);
+			rc = sendfile(epi->fd, fd, NULL, sz);
+			if (rc < 0)
+				goto out;
+			remaining -= rc;
+		} while (remaining);
+#endif
 		while (remaining) {
 			char buf[32768];
-			unsigned int sz = min_t(unsigned int, remaining,
-						sizeof(buf));
-
-			rc = read(fd, buf, sz);
-			if (rc != sz) {
-				if (rc <= 0) {
-					if (!rc)
-						rc = -EIO;
-					else
-						rc = -errno;
+
+			sz = min_t(u64, remaining, sizeof(buf));
+			rc = erofs_io_read(&vin, buf, sz);
+			if (rc < 0)
+				goto out;
+			if (rc > 0) {
+				rc = write(epi->fd, buf, rc);
+				if (rc < 0)
 					goto out;
-				}
-				sz = rc;
 			}
-			rc = __erofs_io_write(epi->fd, buf, sz);
-			if (rc != sz) {
-				if (rc >= 0)
-					rc = -EIO;
-				goto out;
+			remaining -= rc;
+		}
+
+		sz = min_t(u64, inode->i_size, EROFS_FRAGMENT_INMEM_SZ_MAX);
+		memblock = malloc(sz);
+		if (!memblock) {
+			rc = -ENOMEM;
+			goto out;
+		}
+		onheap = true;
+
+		rc = pread(epi->fd, memblock, sz, offset + inode->i_size - sz);
+		if (rc != sz) {
+			if (rc >= 0) {
+				DBG_BUGON(1);
+				rc = -EIO;
 			}
-			remaining -= sz;
+			goto out;
 		}
+
 		rc = lseek(fd, 0, SEEK_SET);
 		if (rc < 0) {
 			rc = -errno;
 			goto out;
 		}
 	} else {
-		rc = __erofs_io_write(epi->fd, memblock, inode->fragment_size);
-		if (rc != inode->fragment_size) {
+		rc = __erofs_io_write(epi->fd, memblock, inode->i_size);
+		if (rc != inode->i_size) {
 			if (rc >= 0)
 				rc = -EIO;
 			goto out;
 		}
 	}
 
-	erofs_dbg("Recording %llu fragment data at %llu of %s",
-		  inode->fragment_size | 0ULL, inode->fragmentoff | 0ULL,
-		  inode->i_srcpath);
-
-	if (memblock)
-		rc = z_erofs_fragments_dedupe_insert(inode, memblock, tofh);
-	else
-		rc = 0;
+	rc = erofs_fragment_pack(inode, memblock, offset, inode->i_size,
+				 tofh, onheap);
 out:
-	if (rc)
-		erofs_err("Failed to record %llu-byte fragment data @ %llu for nid %llu: %d",
-			  inode->fragment_size | 0ULL,
-			  inode->fragmentoff | 0ULL, inode->nid | 0ULL, (int)rc);
-	if (memblock)
+	if (onheap)
+		free(memblock);
+	else
 		munmap(memblock, inode->i_size);
 	return rc;
 }
 
-int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
-			   unsigned int len, u32 tofh)
+int erofs_fragment_commit(struct erofs_inode *inode, u32 tofh)
 {
 	struct erofs_packed_inode *epi = inode->sbi->packedinode;
-	s64 offset = lseek(epi->fd, 0, SEEK_CUR);
+	struct erofs_fragmentitem *fi = inode->fragment;
+	erofs_off_t len = inode->fragment_size;
+	unsigned int sz;
+	s64 offset;
 	int ret;
 
+	if (!len) {
+		DBG_BUGON(fi);
+		return 0;
+	}
+
+	if (fi->pos) {
+		inode->fragmentoff = fi->pos - len;
+		return 0;
+	}
+
+	offset = lseek(epi->fd, 0, SEEK_CUR);
 	if (offset < 0)
 		return -errno;
 
-	inode->fragmentoff = (erofs_off_t)offset;
-	inode->fragment_size = len;
-
-	ret = write(epi->fd, data, len);
-	if (ret != len) {
+	ret = write(epi->fd, fi->data, fi->length);
+	if (ret != fi->length) {
 		if (ret < 0)
 			return -errno;
 		return -EIO;
 	}
+	offset += fi->length;
 
-	erofs_dbg("Recording %llu fragment data at %llu of %s",
-		  inode->fragment_size | 0ULL, inode->fragmentoff | 0ULL,
-		  inode->i_srcpath);
+	if (!list_empty(&fi->list)) {
+#ifdef EROFS_MT_ENABLED
+		struct erofs_fragment_bucket *bk = &epi->bks[FRAGMENT_HASH(tofh)];
+#endif
+		void *nb;
+
+		sz = min_t(u64, fi->length, EROFS_FRAGMENT_INMEM_SZ_MAX);
+#ifdef EROFS_MT_ENABLED
+		pthread_rwlock_wrlock(&bk->lock);
+#endif
+		memmove(fi->data, fi->data + fi->length - sz, sz);
 
-	ret = z_erofs_fragments_dedupe_insert(inode, data, tofh);
-	if (ret)
-		return ret;
-	return len;
+		nb = realloc(fi->data, sz);
+		if (!nb) {
+#ifdef EROFS_MT_ENABLED
+			pthread_rwlock_unlock(&bk->lock);
+#endif
+			fi->data = NULL;
+			return -ENOMEM;
+		}
+		fi->data = nb;
+		fi->pos = (erofs_off_t)offset;
+#ifdef EROFS_MT_ENABLED
+		pthread_rwlock_unlock(&bk->lock);
+#endif
+		inode->fragmentoff = fi->pos - len;
+		return 0;
+	}
+	inode->fragmentoff = (erofs_off_t)offset - len;
+	free(fi);
+	return 0;
 }
 
 int erofs_flush_packed_inode(struct erofs_sb_info *sbi)
@@ -306,8 +400,8 @@ int erofs_packedfile(struct erofs_sb_info *sbi)
 void erofs_packedfile_exit(struct erofs_sb_info *sbi)
 {
 	struct erofs_packed_inode *epi = sbi->packedinode;
-	struct erofs_fragment_dedupe_item *di, *n;
-	int i;
+	struct erofs_fragmentitem *fi, *n;
+	struct erofs_fragment_bucket *bk;
 
 	if (!epi)
 		return;
@@ -315,11 +409,14 @@ void erofs_packedfile_exit(struct erofs_sb_info *sbi)
 	if (epi->uptodate)
 		free(epi->uptodate);
 
-	if (epi->hash) {
-		for (i = 0; i < FRAGMENT_HASHSIZE; ++i)
-			list_for_each_entry_safe(di, n, &epi->hash[i], list)
-				free(di);
-		free(epi->hash);
+	if (epi->bks) {
+		for (bk = epi->bks; bk < &epi->bks[FRAGMENT_HASHSIZE]; ++bk) {
+			list_for_each_entry_safe(fi, n, &bk->hash, list) {
+				free(fi->data);
+				free(fi);
+			}
+		}
+		free(epi->bks);
 	}
 
 	if (epi->fd >= 0)
@@ -342,13 +439,17 @@ int erofs_packedfile_init(struct erofs_sb_info *sbi, bool fragments_mkfs)
 
 	sbi->packedinode = epi;
 	if (fragments_mkfs) {
-		epi->hash = malloc(sizeof(*epi->hash) * FRAGMENT_HASHSIZE);
-		if (!epi->hash) {
+		epi->bks = malloc(sizeof(*epi->bks) * FRAGMENT_HASHSIZE);
+		if (!epi->bks) {
 			err = -ENOMEM;
 			goto err_out;
 		}
-		for (i = 0; i < FRAGMENT_HASHSIZE; ++i)
-			init_list_head(&epi->hash[i]);
+		for (i = 0; i < FRAGMENT_HASHSIZE; ++i) {
+			init_list_head(&epi->bks[i].hash);
+#ifdef EROFS_MT_ENABLED
+			pthread_rwlock_init(&epi->bks[i].lock, NULL);
+#endif
+		}
 	}
 
 	epi->fd = erofs_tmpfile();
-- 
2.43.5


