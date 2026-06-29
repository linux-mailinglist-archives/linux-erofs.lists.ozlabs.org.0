Return-Path: <linux-erofs+bounces-3780-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VDFWHItiQmrX5wkAu9opvQ
	(envelope-from <linux-erofs+bounces-3780-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jun 2026 14:18:19 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAD86D9F4F
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Jun 2026 14:18:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=infradead.org header.s=bombadil.20210309 header.b=ENi4gjhv;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3780-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3780-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=lst.de (policy=none);
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gplfs3l3Wz2ySS;
	Mon, 29 Jun 2026 22:18:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782735493;
	cv=none; b=bc0cKcTe+27OvQ+RqRCOI0euw1oyr/tBBoQpjW1/GAiNDmUwu4hZyOjbPpb9cG9BUQpPKVABIuX8blrq8jUD1m+qW3sd5mENt0UE/1Yi3+9GtXLyg17Qw4EF5t0Zr+JPB8zLyfu6FuOA4t+NQxkdMfml+GURxUekodcb0kVDRp+Q55UX3as/dKIbuBDR/lQj/quMRpDqFWNy/nnLwg2qJTGVEydqYurL13S6kB5iZ4nMiwOhcs/ZTsxTMjj6qXR+Jwww91wJGOpjqpTHkk5zI45QEKHx9k6nDOhpiHwyd7Ifm8wJl3zdXXVXOa3Hz34eu+IbGVvqVX1c6JChNmXr/A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782735493; c=relaxed/relaxed;
	bh=h8W/8MOVA/KLPn/O4gFOUg7bhB+AX9sU5r41MvDzxwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bJKStrI40qge/ExfRRNmK2F5RVa/Q3U5MibMcaJHAcc6K8ajjLQ/Cd7pk6ykdVpk3XMTIseL8UuddOQTlGTKHZ+IhDZtqeG48b32uMPdrKjrXZltDyheDoY3iYEcR1AIxztIzPKsKgGqP6EhjB+7/5LxDH0FYE66lRxBsXdK3k4qd1uJzhCrCSKUISw5EdfPmVvvosoMLh9Ocj0sUQlVGLIRm0Gu3Eq+iC4YRFHcRYuOnN/Y1N9wq7/U1c9gsA5HjKth/YzDk2cn7DgZkgr1Wc2CP5zoF8LOllqzQ5qpu9q+VFPm70hiGI/ms1DGyoympCgDtMm4oIqu1YHmFb6VWw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=lst.de; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ENi4gjhv; dkim-atps=neutral; spf=none (client-ip=2607:7c80:54:3::133; helo=bombadil.infradead.org; envelope-from=batv+90a5730460baaf6f6760+8345+infradead.org+hch@bombadil.srs.infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=bombadil.srs.infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gplfl53mnz2xYh
	for <linux-erofs@lists.ozlabs.org>; Mon, 29 Jun 2026 22:18:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=h8W/8MOVA/KLPn/O4gFOUg7bhB+AX9sU5r41MvDzxwY=; b=ENi4gjhv1y6oMmj7vcPthQA93k
	MxTLJ3Qm3IOJUzqCyvUwop61YPAgD+Ao6F/5SshgOtlGWGpW4sts5bl1E4JYtdGMo9YMOsgJ8AUC+
	0SnWc6KSYxY6brMxLJCbN5CTljr99E86RDIy5wyboff6VKB7VOk6f/gV1Ntdc5o4B0HFkeTA9YegJ
	KOmwM5UJx2u/2uhRnSDeQngpv4rn7q2FRtVOnekSd2T2G/2fEiSwb4oo+Pwq34WHoJzuY/CoqT9yu
	Pm0A6Z2BN82ArtUh1v6KrYkdY4uSi3ltjU2BTTArw0MEJVzbYzMQ/0azMyB1KcpQ7/GVDQpXMka1D
	EbykWDWQ==;
Received: from clnet-b08-202.ikbnet.co.at ([83.175.123.202] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weAw5-0000000EWzg-3hsh;
	Mon, 29 Jun 2026 12:18:02 +0000
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
	linux-fsdevel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 1/3] iomap: consolidate bio submission
Date: Mon, 29 Jun 2026 14:17:38 +0200
Message-ID: <20260629121750.3392300-2-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629121750.3392300-1-hch@lst.de>
References: <20260629121750.3392300-1-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.19)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3780-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:djwong@kernel.org,m:yekelu1@huawei.com,m:zhaoyifan28@huawei.com,m:ritesh.list@gmail.com,m:joannelkoong@gmail.com,m:linkinjeon@kernel.org,m:sj1557.seo@samsung.com,m:hyc.lee@gmail.com,m:almaz.alexandrovich@paragon-software.com,m:miklos@szeredi.hu,m:fuse-devel@lists.linux.dev,m:ntfs3@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-xfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:stable@vger.kernel.org,m:riteshlist@gmail.com,m:hyclee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hch@lst.de,linux-erofs@lists.ozlabs.org];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[17];
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
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp,lst.de:email,lst.de:mid,lst.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AAD86D9F4F

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
Cc: <stable@vger.kernel.org> # v7.1
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
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


