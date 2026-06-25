Return-Path: <linux-erofs+bounces-3759-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XGHdC0YaPWo1xAgAu9opvQ
	(envelope-from <linux-erofs+bounces-3759-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jun 2026 14:08:38 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 760926C566E
	for <lists+linux-erofs@lfdr.de>; Thu, 25 Jun 2026 14:08:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=IGIi8TUh;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3759-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3759-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=lst.de (policy=none);
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gmHdV3pntz2xLm;
	Thu, 25 Jun 2026 22:08:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782389310;
	cv=none; b=CWsWcpHhH5BB1KMg4p4f9FFY6MiJyxQxdrxOBxeWkxCA7Y8AJRFVRnELj8iYp6A8dsv9l48TxoN58d60iTF4TnsActREdW+tyAi3e6SqSMLHsO7TNcoDkarKqUJypt2RNY0kKeTCboa99YC+8Qvnu1k8ybGBlPa6mc+2TNwmHXwKb1ruQgCmEwfw0yG3+7e+KmuBznLmCKHY21XmtJ5Be4rzhGycJMCwg3bswjl+8LoiyTChwAnCPft06W4Sl4dAkGj2OGBMPyhGP/YiN9S9P070cOuqwXDjkGa+8dmugxe7qI9x+1Fev2le5+iKNCZv/RIDGS1pqsTX8RfZN6LaBg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782389310; c=relaxed/relaxed;
	bh=Xp+vfbAR3gzB/zClwlH4Q55K988r+0DVCqo7HLhKXl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByuoW+bzPAApRSX75/xmAp7dLleaduJGjZB685iZ9oiPu8/p5nHbAspu75ppxOgdyhUaYbjaChTsu32mxMDmIX2C4dEkg/ZtXVVUkiffgUQvtNDoC+jwzYHlP0fKK+Pl/FrQlIhAV8Yl1lE+DBajEKB4wmp2IqBCOhtAzGvSnMOFwtqMy0SqMqnQ5bEGNWJ6UV9gAOb1onflmCa+JAK90yNwu09rQHsivHfo2ZL30qc2s2iPzYLbFa0DeicAYRJP6xHnWAa54rFZbYqt267aW2QJ20wQGnX2rOe3jCpdv+f6jPj2AyuW37tyXZjkfxDOMsA9EJvJh9nyjn+UjCHKWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IGIi8TUh; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+469c0735132da6312b2c+8341+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gmHdP4tj3z2ySW
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 Jun 2026 22:08:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Xp+vfbAR3gzB/zClwlH4Q55K988r+0DVCqo7HLhKXl4=; b=IGIi8TUhndTGNo1v5Mlt1/+U4g
	kN7ykl4DNJDfW2dopHWgfHS1fLA5dacPvJuxeCibcQnrSUUN37PRBHcKGgBNaDRsnzw4QaWa1r97L
	fKJm2zSs77zvchMfj/UukWWrGbV1wGC/ICCYOF8rJY7MYTEiCXskC5tQxBLJL+JW4MsEm2NHkOj/K
	QQ39fYEA1v51HIe5FrhiVDzfu7kWXB7oUht/XrLgc/xAaCvYfhLIuVAioQpUV+sSaBuSMyjYMDp59
	FJbIoeyvZQ9sooOUIKskPj6h9K59smhP6l7hGi0Y9dl+DTqKsor8/aaldOwUup5LY9ebPQ5Z0VAZZ
	t70ADAHQ==;
Received: from 2a02-8389-2301-9f00-3397-c9eb-6d8a-9179.cable.dynamic.v6.surfer.at ([2a02:8389:2301:9f00:3397:c9eb:6d8a:9179] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcisW-000000099ix-2ixh;
	Thu, 25 Jun 2026 12:08:20 +0000
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
Subject: [PATCH 2/2] iomap: submit read bio after each extent
Date: Thu, 25 Jun 2026 14:07:57 +0200
Message-ID: <20260625120803.2462291-3-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625120803.2462291-1-hch@lst.de>
References: <20260625120803.2462291-1-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-3759-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,lst.de:email,lst.de:mid,lst.de:from_mime,huawei.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 760926C566E

Currently the iomap buffered read path tries to build up read context
(i.e. bios for the typical block based case) over multiple iomaps as
long as the sector matches.  This does not take into account files
that can map to multiple different devices.  While this could be fixed
by a bdev check in iomap_bio_read_folio_range, the building up of I/O
over iomaps actually was a problem for the not yet merged ext2 iomap
port, as that does want to send out I/O at the end of an indirect
block mapped range.

So instead of adding more checks move over to a model where a bio only
spans a single iomap.  Change ->submit_read to be called after each
iteration, and pass a force argument to indicate that the bio must
be submitted set on the last iteration.  Switch the bio based users
to always submit, while keeping the single submit for fuse.

Fixes: dfeab2e95a75 ("erofs: add multiple device support")
Reported-by: Kelu Ye <yekelu1@huawei.com>
Reported-by: Yifan Zhao <zhaoyifan28@huawei.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 fs/exfat/iomap.c       |  2 +-
 fs/fuse/file.c         |  6 +++++-
 fs/iomap/bio.c         |  6 ++++--
 fs/iomap/buffered-io.c | 21 +++++++++++++--------
 fs/ntfs/aops.c         |  2 +-
 fs/ntfs3/inode.c       |  2 +-
 fs/xfs/xfs_aops.c      |  3 ++-
 include/linux/iomap.h  |  2 +-
 8 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/fs/exfat/iomap.c b/fs/exfat/iomap.c
index 190fc6471f84..c428a949120e 100644
--- a/fs/exfat/iomap.c
+++ b/fs/exfat/iomap.c
@@ -251,7 +251,7 @@ static void exfat_iomap_read_end_io(struct bio *bio)
 }
 
 static void exfat_iomap_bio_submit_read(const struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx, bool force)
 {
 	iomap_bio_submit_read_endio(iter, ctx, exfat_iomap_read_end_io);
 }
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e052a0d44dee..6fa3b1f55c95 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -982,13 +982,17 @@ static int fuse_iomap_read_folio_range_async(const struct iomap_iter *iter,
 }
 
 static void fuse_iomap_submit_read(const struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx, bool force)
 {
 	struct fuse_fill_read_data *data = ctx->read_ctx;
 
+	if (!force)
+		return;
+
 	if (data->ia)
 		fuse_send_readpages(data->ia, data->file, data->nr_bytes,
 				    data->fc->async_read);
+	ctx->read_ctx = NULL;
 }
 
 static const struct iomap_read_ops fuse_iomap_read_ops = {
diff --git a/fs/iomap/bio.c b/fs/iomap/bio.c
index 0f31e35567b4..6aca1cd0622c 100644
--- a/fs/iomap/bio.c
+++ b/fs/iomap/bio.c
@@ -87,11 +87,13 @@ void iomap_bio_submit_read_endio(const struct iomap_iter *iter,
 	if (iter->iomap.flags & IOMAP_F_INTEGRITY)
 		fs_bio_integrity_alloc(bio);
 	submit_bio(bio);
+
+	ctx->read_ctx = NULL;
 }
 EXPORT_SYMBOL_GPL(iomap_bio_submit_read_endio);
 
 static void iomap_bio_submit_read(const struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx, bool force)
 {
 	return iomap_bio_submit_read_endio(iter, ctx, iomap_read_end_io);
 }
@@ -116,7 +118,7 @@ static void iomap_read_alloc_bio(const struct iomap_iter *iter,
 
 	/* Submit the existing range if there was one. */
 	if (ctx->read_ctx)
-		ctx->ops->submit_read(iter, ctx);
+		ctx->ops->submit_read(iter, ctx, true);
 
 	/* Same as readahead_gfp_mask: */
 	if (ctx->rac)
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 8d4806dc46d4..b1c3da8a97dc 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -524,6 +524,13 @@ static void iomap_read_end(struct folio *folio, size_t bytes_submitted)
 	}
 }
 
+static void iomap_submit_read(struct iomap_iter *iter,
+		struct iomap_read_folio_ctx *ctx, bool force)
+{
+	if (ctx->read_ctx && ctx->ops->submit_read)
+		ctx->ops->submit_read(iter, ctx, force);
+}
+
 static int iomap_read_folio_iter(struct iomap_iter *iter,
 		struct iomap_read_folio_ctx *ctx, size_t *bytes_submitted)
 {
@@ -642,12 +649,11 @@ void iomap_read_folio(const struct iomap_ops *ops,
 		fsverity_readahead(ctx->vi, folio->index,
 				   folio_nr_pages(folio));
 
-	while ((ret = iomap_iter(&iter, ops)) > 0)
+	while ((ret = iomap_iter(&iter, ops)) > 0) {
 		iter.status = iomap_read_folio_iter(&iter, ctx,
 				&bytes_submitted);
-
-	if (ctx->read_ctx && ctx->ops->submit_read)
-		ctx->ops->submit_read(&iter, ctx);
+		iomap_submit_read(&iter, ctx, !iter.iomap.length);
+	}
 
 	if (ctx->cur_folio)
 		iomap_read_end(ctx->cur_folio, bytes_submitted);
@@ -718,12 +724,11 @@ void iomap_readahead(const struct iomap_ops *ops,
 		fsverity_readahead(ctx->vi, readahead_index(rac),
 				readahead_count(rac));
 
-	while (iomap_iter(&iter, ops) > 0)
+	while (iomap_iter(&iter, ops) > 0) {
 		iter.status = iomap_readahead_iter(&iter, ctx,
 					&cur_bytes_submitted);
-
-	if (ctx->read_ctx && ctx->ops->submit_read)
-		ctx->ops->submit_read(&iter, ctx);
+		iomap_submit_read(&iter, ctx, !iter.iomap.length);
+	}
 
 	if (ctx->cur_folio)
 		iomap_read_end(ctx->cur_folio, cur_bytes_submitted);
diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index f2bb56506046..f7bd55275d8c 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -38,7 +38,7 @@ static void ntfs_iomap_read_end_io(struct bio *bio)
 }
 
 static void ntfs_iomap_bio_submit_read(const struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx, bool force)
 {
 	iomap_bio_submit_read_endio(iter, ctx, ntfs_iomap_read_end_io);
 }
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index f9600aba1548..cd05faebb806 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -607,7 +607,7 @@ static void ntfs_iomap_read_end_io(struct bio *bio)
 }
 
 static void ntfs_iomap_bio_submit_read(const struct iomap_iter *iter,
-		struct iomap_read_folio_ctx *ctx)
+		struct iomap_read_folio_ctx *ctx, bool force)
 {
 	iomap_bio_submit_read_endio(iter, ctx, ntfs_iomap_read_end_io);
 }
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 51293b6f331f..1b9a55e2f4a7 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -758,7 +758,8 @@ xfs_vm_bmap(
 static void
 xfs_bio_submit_read(
 	const struct iomap_iter		*iter,
-	struct iomap_read_folio_ctx	*ctx)
+	struct iomap_read_folio_ctx	*ctx,
+	bool				force)
 {
 	struct bio			*bio = ctx->read_ctx;
 
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 56b43d594e6e..4d8893b02aaf 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -528,7 +528,7 @@ struct iomap_read_ops {
 	 * This is optional.
 	 */
 	void (*submit_read)(const struct iomap_iter *iter,
-			struct iomap_read_folio_ctx *ctx);
+			struct iomap_read_folio_ctx *ctx, bool force);
 
 	/*
 	 * Optional, allows filesystem to specify own bio_set, so new bio's
-- 
2.53.0


