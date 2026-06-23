Return-Path: <linux-erofs+bounces-3736-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4ZMEHJ6POmpTAAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3736-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 15:52:30 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 882DA6B79CD
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Jun 2026 15:52:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=MdDv6Mj5;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3736-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3736-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=lst.de (policy=none);
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gl62L5dSwz2ySV;
	Tue, 23 Jun 2026 23:52:26 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782222746;
	cv=none; b=ayNeeECRnq1F10rIJrIXowaf6YFbkv6MPR7Sjsnfz2rXrBbUFGQbxTLlZ0cLCJPMpn8L/qY4RpAbaWAnIC8FNng3U7XIL23Y3AM0LWKUW8bNK++fUbHNIHg8cIR9+J3dkKrOOgntNwAh3beMPBhOMNkV6xstdfO/rJqhhs6UYDueYfrxHDNiVcfIDPtQd7b2aMk4J+PdVX54dqsAUC2eCQ9KtNM6zhxHSJ9b4MfCccTvXn8JMLioqDvFgenvDIUJMk7GyDyyWIB3EMCEf6WQOC9uIwsAx5JUkEqlvoyeHPfCjK/m59fkYcBLjVhdqIcGe72k8AVIJE5Vb4K6mrR6eg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782222746; c=relaxed/relaxed;
	bh=yGAtGrWVu1QATEaU/d3luexBJzA18wibuRcTuaPYFso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Astg7nfZnkvLVyygFPY5b6OmI7mrrtWnmjV0BOPpyHUlzYGsilBDwCoT7JMQyUyrcvLQG+WGUUiMXdGE2Qu9RbAXwSZnDlir3Yp0Zhqu+1smNGsaewIOp3y2u1dKA0rruROQiJq6akJuokVi0UGoDrtFh3f3X165m2D9078h0rJXdj5/mHYgOwhHl5RqzWo9nWZRj+hponSjcHcfgVL+iuGdrEILxZVwebhNm0BAceGqkPYXHH6JIM5E3hdbXYNCFHErdU1sJJxvH3Rh2Q6aF13TDONernbwD/HMWypdekUzceSk4Zxj2RWyoUH0KwImGOTOfGaSPMneh8GSaK4rpw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=MdDv6Mj5; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+1ce5920da89166e1197d+8339+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gl62K5GQ8z2xM7
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Jun 2026 23:52:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yGAtGrWVu1QATEaU/d3luexBJzA18wibuRcTuaPYFso=; b=MdDv6Mj5VAYtRr4Tv/RS9Br9ki
	HojbswlPkdSFiQ9wDXWfjWGnSNFiUneGXVK+o9ABK13LW0+TZkpG7xQkd50DURg8L7NEyxUN2YR+M
	mWwdYn2CR1z99FZBJHSSY9VAYDjZ3R/wgUk0cncbvyHaoP68tTyUaXZaIJb/zlpifHMOV+a+78eig
	aIGr7WBKvfJbj3nw7s0VsI7sVWN5zZ8VVIXyKQ/fWOb+qYy7tGr1pt9X8CjvJUNEnNtgNvTTgVtwO
	doTMN6vXDjW/E+i7xrM/CwMtqWvSKVmsy/SVvngaJ5BSB+Cc560tjdIxNCSRf7Q/hlMMQRMbL9sgy
	yrFgjn3w==;
Received: from [2001:4bb8:2f6:ef61:5b2b:8638:3844:9408] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wc1Y4-00000006NCc-3mnQ;
	Tue, 23 Jun 2026 13:52:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: Kelu Ye <yekelu1@huawei.com>,
	Yifan Zhao <zhaoyifan28@huawei.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Joanne Koong <joannelkoong@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	fuse-devel@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] iomap: consolidate bio submission
Date: Tue, 23 Jun 2026 15:51:36 +0200
Message-ID: <20260623135208.1812933-2-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623135208.1812933-1-hch@lst.de>
References: <20260623135208.1812933-1-hch@lst.de>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.40 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.19)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3736-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:djwong@kernel.org,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:joannelkoong@gmail.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[infradead.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,kernel.org,samsung.com,paragon-software.com,szeredi.hu,lists.linux.dev,lists.ozlabs.org,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,lst.de:mid,lst.de:from_mime,infradead.org:dkim,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 882DA6B79CD

Add a iomap_bio_submit_read_endio helper factored out of
iomap_bio_submit_read to that all ->submit_read implementations for
iomap_read_ops that use iomap_bio_read_folio_range can shared the
logic.

Right now that logic is mostly trivial, but already has a bug for XFS
because the XFS version is too trivial:  file system integrity validation
needs a workqueue context and thus can't happen from the default iomap
bi_end_io I/O handler.  Unfortunately the iomap refactoring just before
fs integrity landed moved code around here and the call go misplaced,
meaning it never got called.  The PI information still is verified by
the block layer, but the offloading is less efficient (and the future
userspace interface can't get at it).

Fixes: 0b10a370529c ("iomap: support T10 protection information")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/exfat/iomap.c      |  5 +----
 fs/iomap/bio.c        | 13 ++++++++++---
 fs/ntfs/aops.c        |  6 ++----
 fs/ntfs3/inode.c      |  5 +----
 fs/xfs/xfs_aops.c     |  3 +--
 include/linux/iomap.h |  2 ++
 6 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
index 1aac38e63fe6..190fc6471f84 100644
--- a/fs/exfat/iomap.c
+++ b/fs/exfat/iomap.c
@@ -253,10 +253,7 @@ static void exfat_iomap_read_end_io(struct bio *bio)
 static void exfat_iomap_bio_submit_read(const struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx)
 {
-	struct bio *bio = ctx->read_ctx;
-
-	bio->bi_end_io = exfat_iomap_read_end_io;
-	submit_bio(bio);
+	iomap_bio_submit_read_endio(iter, ctx, exfat_iomap_read_end_io);
 }
 
 const struct iomap_read_ops exfat_iomap_bio_read_ops = {
diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
index 4504f4633f17..0f31e35567b4 100644
--- a/fs/iomap/bio.c
+++ b/fs/iomap/bio.c
@@ -78,15 +78,23 @@ u32 iomap_finish_ioend_buffered_read(struct iomap_ioend *ioend)
 	return __iomap_read_end_io(&ioend->io_bio, ioend->io_error);
 }
 
-static void iomap_bio_submit_read(const struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx)
+void iomap_bio_submit_read_endio(const struct iomap_iter *iter,
+		struct iomap_read_folio_ctx *ctx, bio_end_io_t end_io)
 {
 	struct bio *bio = ctx->read_ctx;
 
+	bio->bi_end_io = end_io;
 	if (iter->iomap.flags & IOMAP_F_INTEGRITY)
 		fs_bio_integrity_alloc(bio);
 	submit_bio(bio);
 }
+EXPORT_SYMBOL_GPL(iomap_bio_submit_read_endio);
+
+static void iomap_bio_submit_read(const struct iomap_iter *iter,
+		struct iomap_read_folio_ctx *ctx)
+{
+	return iomap_bio_submit_read_endio(iter, ctx, iomap_read_end_io);
+}
 
 static struct bio_set *iomap_read_bio_set(struct iomap_read_folio_ctx *ctx)
 {
@@ -127,7 +135,6 @@ static void iomap_read_alloc_bio(const struct iomap_iter *iter,
 	if (ctx->rac)
 		bio->bi_opf |= REQ_RAHEAD;
 	bio->bi_iter.bi_sector = iomap_sector(iomap, iter->pos);
-	bio->bi_end_io = iomap_read_end_io;
 	bio_add_folio_nofail(bio, folio, plen,
 			offset_in_folio(folio, iter->pos));
 	ctx->read_ctx = bio;
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 1fbf832ad165..f2bb56506046 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -38,11 +38,9 @@ static void ntfs_iomap_read_end_io(struct bio *bio)
 }
 
 static void ntfs_iomap_bio_submit_read(const struct iomap_iter *iter,
-	struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx)
 {
-	struct bio *bio = ctx->read_ctx;
-	bio->bi_end_io = ntfs_iomap_read_end_io;
-	submit_bio(bio);
+	iomap_bio_submit_read_endio(iter, ctx, ntfs_iomap_read_end_io);
 }
 
 static const struct iomap_read_ops ntfs_iomap_bio_read_ops = {
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 42af1abe17f8..f9600aba1548 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -609,10 +609,7 @@ static void ntfs_iomap_read_end_io(struct bio *bio)
 static void ntfs_iomap_bio_submit_read(const struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx)
 {
-	struct bio *bio = ctx->read_ctx;
-
-	bio->bi_end_io = ntfs_iomap_read_end_io;
-	submit_bio(bio);
+	iomap_bio_submit_read_endio(iter, ctx, ntfs_iomap_read_end_io);
 }
 
 static const struct iomap_read_ops ntfs_iomap_bio_read_ops = {
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 2a0c54256e93..51293b6f331f 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -764,8 +764,7 @@ xfs_bio_submit_read(
 
 	/* defer read completions to the ioend workqueue */
 	iomap_init_ioend(iter->inode, bio, ctx->read_ctx_file_offset, 0);
-	bio->bi_end_io = xfs_end_bio;
-	submit_bio(bio);
+	iomap_bio_submit_read_endio(iter, ctx, xfs_end_bio);
 }
 
 static const struct iomap_read_ops xfs_iomap_read_ops = {
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 3582ed1fe236..56b43d594e6e 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -622,6 +622,8 @@ extern struct bio_set iomap_ioend_bioset;
 #ifdef CONFIG_BLOCK
 int iomap_bio_read_folio_range(const struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx, size_t plen);
+void iomap_bio_submit_read_endio(const struct iomap_iter *iter,
+		struct iomap_read_folio_ctx *ctx, bio_end_io_t end_io);
 
 extern const struct iomap_read_ops iomap_bio_read_ops;
 
-- 
2.53.0


