Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65276D65FB
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 16:55:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrW5y3Q1lz3chp
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 00:55:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FlqghJc0;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FlqghJc0;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=aalbersh@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FlqghJc0;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FlqghJc0;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrW5d27HQz3cNj
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Apr 2023 00:55:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680620114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HOa0kR4UZ9J5lXSH1eVSD9D5g9oUFaieHHnsOCRS/TM=;
	b=FlqghJc0j0M5d0evAE1MZhNe/BXfpz6pntUDZ8aYrHXoty+Sq6kS1WKDxEJQJurnPUZ/aY
	XFuwVAY1yfhrygW/fud2MPw1At7Y5tKs3AD1rC6j5FZIAdnh8HD3RzvX/oGoRZ8b5tZKBi
	1VGEUEhLo87i6VFwKdbd61mmN25B4X0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680620114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HOa0kR4UZ9J5lXSH1eVSD9D5g9oUFaieHHnsOCRS/TM=;
	b=FlqghJc0j0M5d0evAE1MZhNe/BXfpz6pntUDZ8aYrHXoty+Sq6kS1WKDxEJQJurnPUZ/aY
	XFuwVAY1yfhrygW/fud2MPw1At7Y5tKs3AD1rC6j5FZIAdnh8HD3RzvX/oGoRZ8b5tZKBi
	1VGEUEhLo87i6VFwKdbd61mmN25B4X0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-C0Wy70noOEeN8LILu-G4rA-1; Tue, 04 Apr 2023 10:55:12 -0400
X-MC-Unique: C0Wy70noOEeN8LILu-G4rA-1
Received: by mail-qt1-f200.google.com with SMTP id v10-20020a05622a130a00b003e4ee70e001so16129521qtk.6
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Apr 2023 07:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HOa0kR4UZ9J5lXSH1eVSD9D5g9oUFaieHHnsOCRS/TM=;
        b=SIkt4ocLkRidIVyXRyXjhxyp5+Mo4uyXjbq+VyXmezDsJC1y9s3YFRx6l0zsiX9y8s
         hgshTbAoq+G48amVzjBHj6OXzRxUAwYuiUbhrqBY/3DME6V3PFgc9A5DIJg+FF5wZ7r+
         4VY3O//201neW/aJ4j+0IP4/zqFvmTVr98vO2kmmjRfjao8A6SIsz/eZ1aYeqbfJm+p0
         Z3NeeLNj01WGuqFRDk60vz9k+P8kvRXDZqeIicKCaEJ3xj2EIpgubB7He4YYVvwZ3SED
         jD+zrSSinwJT1TPfiK59Hm1gdZLjPbm17lfNVKVNNRUny4RhtfUzZSBCX820M7kxoqK5
         nYOw==
X-Gm-Message-State: AAQBX9dxxmQs4nLkVyBYgxzlwOLO2oTKyXzwc9kdtMe4QdJcLX/CJCpx
	qpeeDjy0QzRl3kj3nhltkJqknFJnsF4jMBu6UthYPpEhMEHpzlC9Bwnfh2Tp24Milc3dYDQuly5
	ojuxmj9M4luptiA8HY1rg324=
X-Received: by 2002:a05:622a:1206:b0:3e6:386b:2314 with SMTP id y6-20020a05622a120600b003e6386b2314mr4234339qtx.62.1680620112376;
        Tue, 04 Apr 2023 07:55:12 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zi2LAt4qDrudwl48rNwlY8u7pFZFW3zeybFHV9/WikI3mElMyLLcUr2mx2LZUuubcbPpyUsw==
X-Received: by 2002:a05:622a:1206:b0:3e6:386b:2314 with SMTP id y6-20020a05622a120600b003e6386b2314mr4234307qtx.62.1680620112123;
        Tue, 04 Apr 2023 07:55:12 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:55:11 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: djwong@kernel.org,
	dchinner@redhat.com,
	ebiggers@kernel.org,
	hch@infradead.org,
	linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH v2 09/23] iomap: allow filesystem to implement read path verification
Date: Tue,  4 Apr 2023 16:53:05 +0200
Message-Id: <20230404145319.2057051-10-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404145319.2057051-1-aalbersh@redhat.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
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
Cc: linux-ext4@vger.kernel.org, agruenba@redhat.com, damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com, rpeterso@redhat.com, jth@kernel.org, linux-erofs@lists.ozlabs.org, Andrey Albershteyn <aalbersh@redhat.com>, linux-btrfs@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add IOMAP_F_READ_VERITY which indicates that iomap need to
verify BIO (e.g. fs-verity) after I/O is completed.

Add iomap_readpage_ops with only optional ->prepare_ioend() to allow
filesystem to add callout used for configuring read path ioend.
Mainly for setting ->bi_end_io() callout. Add
iomap_folio_ops->verify_folio() for direct folio verification.

The verification itself is suppose to happen on filesystem side. The
verification is done when the BIO is processed by calling out
->bi_end_io().

Make iomap_read_end_io() exportable, so, it can be called back from
filesystem callout after verification is done.

The read path ioend are stored side by side with BIOs allocated from
iomap_read_ioend_bioset.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/iomap/buffered-io.c | 32 +++++++++++++++++++++++++++++---
 include/linux/iomap.h  | 26 ++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 3 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d39be64b1da9..7e59c299c496 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -42,6 +42,7 @@ static inline struct iomap_page *to_iomap_page(struct folio *folio)
 }
 
 static struct bio_set iomap_ioend_bioset;
+static struct bio_set iomap_read_ioend_bioset;
 
 static struct iomap_page *
 iomap_page_create(struct inode *inode, struct folio *folio, unsigned int flags)
@@ -184,7 +185,7 @@ static void iomap_finish_folio_read(struct folio *folio, size_t offset,
 		folio_unlock(folio);
 }
 
-static void iomap_read_end_io(struct bio *bio)
+void iomap_read_end_io(struct bio *bio)
 {
 	int error = blk_status_to_errno(bio->bi_status);
 	struct folio_iter fi;
@@ -193,6 +194,7 @@ static void iomap_read_end_io(struct bio *bio)
 		iomap_finish_folio_read(fi.folio, fi.offset, fi.length, error);
 	bio_put(bio);
 }
+EXPORT_SYMBOL_GPL(iomap_read_end_io);
 
 /**
  * iomap_read_inline_data - copy inline data into the page cache
@@ -257,6 +259,7 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	loff_t orig_pos = pos;
 	size_t poff, plen;
 	sector_t sector;
+	struct iomap_read_ioend *ioend;
 
 	if (iomap->type == IOMAP_INLINE)
 		return iomap_read_inline_data(iter, folio);
@@ -269,6 +272,13 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 
 	if (iomap_block_needs_zeroing(iter, pos)) {
 		folio_zero_range(folio, poff, plen);
+		if (iomap->flags & IOMAP_F_READ_VERITY) {
+			if (!iomap->folio_ops->verify_folio(folio, poff, plen)) {
+				folio_set_error(folio);
+				goto done;
+			}
+		}
+
 		iomap_set_range_uptodate(folio, iop, poff, plen);
 		goto done;
 	}
@@ -290,8 +300,8 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 
 		if (ctx->rac) /* same as readahead_gfp_mask */
 			gfp |= __GFP_NORETRY | __GFP_NOWARN;
-		ctx->bio = bio_alloc(iomap->bdev, bio_max_segs(nr_vecs),
-				     REQ_OP_READ, gfp);
+		ctx->bio = bio_alloc_bioset(iomap->bdev, bio_max_segs(nr_vecs),
+				REQ_OP_READ, GFP_NOFS, &iomap_read_ioend_bioset);
 		/*
 		 * If the bio_alloc fails, try it again for a single page to
 		 * avoid having to deal with partial page reads.  This emulates
@@ -305,6 +315,13 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 			ctx->bio->bi_opf |= REQ_RAHEAD;
 		ctx->bio->bi_iter.bi_sector = sector;
 		ctx->bio->bi_end_io = iomap_read_end_io;
+
+		ioend = container_of(ctx->bio, struct iomap_read_ioend,
+				read_inline_bio);
+		ioend->io_inode = iter->inode;
+		if (ctx->ops && ctx->ops->prepare_ioend)
+			ctx->ops->prepare_ioend(ioend);
+
 		bio_add_folio(ctx->bio, folio, plen, poff);
 	}
 
@@ -1813,6 +1830,15 @@ EXPORT_SYMBOL_GPL(iomap_writepages);
 
 static int __init iomap_init(void)
 {
+	int error = 0;
+
+	error = bioset_init(&iomap_read_ioend_bioset,
+			   4 * (PAGE_SIZE / SECTOR_SIZE),
+			   offsetof(struct iomap_read_ioend, read_inline_bio),
+			   BIOSET_NEED_BVECS);
+	if (error)
+		return error;
+
 	return bioset_init(&iomap_ioend_bioset, 4 * (PAGE_SIZE / SECTOR_SIZE),
 			   offsetof(struct iomap_ioend, io_inline_bio),
 			   BIOSET_NEED_BVECS);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 0fbce375265d..9a17b53309c9 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -53,6 +53,9 @@ struct vm_fault;
  *
  * IOMAP_F_XATTR indicates that the iomap is for an extended attribute extent
  * rather than a file data extent.
+ *
+ * IOMAP_F_READ_VERITY indicates that the iomap needs verification of read
+ * folios
  */
 #define IOMAP_F_NEW		(1U << 0)
 #define IOMAP_F_DIRTY		(1U << 1)
@@ -60,6 +63,7 @@ struct vm_fault;
 #define IOMAP_F_MERGED		(1U << 3)
 #define IOMAP_F_BUFFER_HEAD	(1U << 4)
 #define IOMAP_F_XATTR		(1U << 5)
+#define IOMAP_F_READ_VERITY	(1U << 6)
 
 /*
  * Flags set by the core iomap code during operations:
@@ -156,6 +160,11 @@ struct iomap_folio_ops {
 	 * locked by the iomap code.
 	 */
 	bool (*iomap_valid)(struct inode *inode, const struct iomap *iomap);
+
+	/*
+	 * Verify folio when successfully read
+	 */
+	bool (*verify_folio)(struct folio *folio, loff_t pos, unsigned int len);
 };
 
 /*
@@ -258,13 +267,30 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 		struct iomap *iomap, loff_t pos, loff_t length, ssize_t written,
 		int (*punch)(struct inode *inode, loff_t pos, loff_t length));
 
+struct iomap_read_ioend {
+	struct inode		*io_inode;	/* file being read from */
+	struct work_struct	work;		/* post read work (e.g. fs-verity) */
+	struct bio		read_inline_bio;/* MUST BE LAST! */
+};
+
+struct iomap_readpage_ops {
+	/*
+	 * Optional, allows the file systems to perform actions just before
+	 * submitting the bio and/or override the bio bi_end_io handler for
+	 * additional verification after bio is processed
+	 */
+	void (*prepare_ioend)(struct iomap_read_ioend *ioend);
+};
+
 struct iomap_readpage_ctx {
 	struct folio			*cur_folio;
 	bool				cur_folio_in_bio;
 	struct bio			*bio;
 	struct readahead_control	*rac;
+	const struct iomap_readpage_ops *ops;
 };
 
+void iomap_read_end_io(struct bio *bio);
 int iomap_read_folio(struct iomap_readpage_ctx *ctx,
 		const struct iomap_ops *ops);
 void iomap_readahead(struct iomap_readpage_ctx *ctx,
-- 
2.38.4

