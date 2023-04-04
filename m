Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 820686D65F9
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 16:55:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrW5s2xHGz3cj1
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 00:55:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VVwfGis+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VVwfGis+;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=aalbersh@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VVwfGis+;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VVwfGis+;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrW5b2VFdz3chp
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Apr 2023 00:55:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680620112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jde43B7wLiY0X8TkodUDvektg6VGP7LMYmpHpXCm3PE=;
	b=VVwfGis+TDLUXb0+f6079tQGzShLwspYHelM4vhTHuvy1vr2FgkEnGize7ZLUucqiI4qrL
	eNmlz1EvZQx/0i5KEKTJEGdWo9BbxLELFknErOCFmFoSUxyV8fdYzBgoZkWrcEKfFUeOQO
	VqPoNl6v0az6yIo6PuxGBMtObyVEAoM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680620112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jde43B7wLiY0X8TkodUDvektg6VGP7LMYmpHpXCm3PE=;
	b=VVwfGis+TDLUXb0+f6079tQGzShLwspYHelM4vhTHuvy1vr2FgkEnGize7ZLUucqiI4qrL
	eNmlz1EvZQx/0i5KEKTJEGdWo9BbxLELFknErOCFmFoSUxyV8fdYzBgoZkWrcEKfFUeOQO
	VqPoNl6v0az6yIo6PuxGBMtObyVEAoM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-8Aoewae9OBeeYvIqeDsViA-1; Tue, 04 Apr 2023 10:55:11 -0400
X-MC-Unique: 8Aoewae9OBeeYvIqeDsViA-1
Received: by mail-qv1-f72.google.com with SMTP id e1-20020a0cd641000000b005b47df84f6eso14822750qvj.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Apr 2023 07:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jde43B7wLiY0X8TkodUDvektg6VGP7LMYmpHpXCm3PE=;
        b=wKfru7Xivqb2l2jyn6ZkmpLP11zBOaXIBis+2XLCrUddiR7oIUvtFFffcdpiDLuvAr
         6jHaB9vFPunekRj5wM1ZsZaxtPi01kbh4dv1+6Ym0ip9LcIAi7mGaoSbrhhShzUHdJ8x
         8N05NAAgJ1jKRtFlXDd9CsgxeSaGQhiMX5rahY7xpxJ41Ip4A1osBMfpowWXE7MSleG3
         l95hxSFAfxTBWgRv0RHLOc/GKSm/qq5At10kRlUfK2kQ5m2CXsf/oQDmEt/O28UWSa6s
         n3xNO4fg+lDlgDOc/etbwDAvC4vvyTXA265SgVHUapqrKk5uqiaMzgDwSBeSFHh2bdtS
         uYkw==
X-Gm-Message-State: AAQBX9d/iW0gIRaIoLWkwtb7hoEn8v3UY30XYeQpZGYiFsiS/wlOblE2
	Ni9jbwbpysSaDcR94eNEy3IRTKk9s0O0FFv5TBVK9wQwSOMwP7z6GiGjXW5XutrNnBjfKGfGhFS
	2gsIO394DK+eUB8KQX6x+PC0=
X-Received: by 2002:ac8:58ca:0:b0:3e6:61a6:c020 with SMTP id u10-20020ac858ca000000b003e661a6c020mr4116073qta.18.1680620109214;
        Tue, 04 Apr 2023 07:55:09 -0700 (PDT)
X-Google-Smtp-Source: AKy350bRukieGp/vBCe07UBrAYPMxqeAHfI+NHR3fac66ESM5ACOxN0AeboeMCKRIpd7badFWWI16A==
X-Received: by 2002:ac8:58ca:0:b0:3e6:61a6:c020 with SMTP id u10-20020ac858ca000000b003e661a6c020mr4116026qta.18.1680620108814;
        Tue, 04 Apr 2023 07:55:08 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:55:08 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: djwong@kernel.org,
	dchinner@redhat.com,
	ebiggers@kernel.org,
	hch@infradead.org,
	linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH v2 08/23] iomap: hoist iomap_readpage_ctx from the iomap_readahead/_folio
Date: Tue,  4 Apr 2023 16:53:04 +0200
Message-Id: <20230404145319.2057051-9-aalbersh@redhat.com>
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

Make filesystems create readpage context, similar as
iomap_writepage_ctx in write path. This will allow filesystem to
pass _ops to iomap for ioend configuration (->prepare_ioend) which
in turn would be used to set BIO end callout (bio->bi_end_io).

This will be utilized in further patches by fs-verity to verify
pages on BIO completion by XFS.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/erofs/data.c        | 12 +++++++--
 fs/gfs2/aops.c         | 10 ++++++--
 fs/iomap/buffered-io.c | 57 ++++++++++++++++--------------------------
 fs/xfs/xfs_aops.c      | 16 +++++++++---
 fs/zonefs/file.c       | 12 +++++++--
 include/linux/iomap.h  | 13 ++++++++--
 6 files changed, 73 insertions(+), 47 deletions(-)

diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index e16545849ea7..189591249f61 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -344,12 +344,20 @@ int erofs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
  */
 static int erofs_read_folio(struct file *file, struct folio *folio)
 {
-	return iomap_read_folio(folio, &erofs_iomap_ops);
+	struct iomap_readpage_ctx ctx = {
+		.cur_folio = folio,
+	};
+
+	return iomap_read_folio(&ctx, &erofs_iomap_ops);
 }
 
 static void erofs_readahead(struct readahead_control *rac)
 {
-	return iomap_readahead(rac, &erofs_iomap_ops);
+	struct iomap_readpage_ctx ctx = {
+		.rac = rac,
+	};
+
+	return iomap_readahead(&ctx, &erofs_iomap_ops);
 }
 
 static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
index a5f4be6b9213..2764e1e99e8b 100644
--- a/fs/gfs2/aops.c
+++ b/fs/gfs2/aops.c
@@ -453,10 +453,13 @@ static int gfs2_read_folio(struct file *file, struct folio *folio)
 	struct gfs2_inode *ip = GFS2_I(inode);
 	struct gfs2_sbd *sdp = GFS2_SB(inode);
 	int error;
+	struct iomap_readpage_ctx ctx = {
+		.cur_folio = folio,
+	};
 
 	if (!gfs2_is_jdata(ip) ||
 	    (i_blocksize(inode) == PAGE_SIZE && !folio_buffers(folio))) {
-		error = iomap_read_folio(folio, &gfs2_iomap_ops);
+		error = iomap_read_folio(&ctx, &gfs2_iomap_ops);
 	} else if (gfs2_is_stuffed(ip)) {
 		error = stuffed_readpage(ip, &folio->page);
 		folio_unlock(folio);
@@ -528,13 +531,16 @@ static void gfs2_readahead(struct readahead_control *rac)
 {
 	struct inode *inode = rac->mapping->host;
 	struct gfs2_inode *ip = GFS2_I(inode);
+	struct iomap_readpage_ctx ctx = {
+		.rac = rac,
+	};
 
 	if (gfs2_is_stuffed(ip))
 		;
 	else if (gfs2_is_jdata(ip))
 		mpage_readahead(rac, gfs2_block_map);
 	else
-		iomap_readahead(rac, &gfs2_iomap_ops);
+		iomap_readahead(&ctx, &gfs2_iomap_ops);
 }
 
 /**
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 6f4c97a6d7e9..d39be64b1da9 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -194,13 +194,6 @@ static void iomap_read_end_io(struct bio *bio)
 	bio_put(bio);
 }
 
-struct iomap_readpage_ctx {
-	struct folio		*cur_folio;
-	bool			cur_folio_in_bio;
-	struct bio		*bio;
-	struct readahead_control *rac;
-};
-
 /**
  * iomap_read_inline_data - copy inline data into the page cache
  * @iter: iteration structure
@@ -325,32 +318,29 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
 	return pos - orig_pos + plen;
 }
 
-int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
+int iomap_read_folio(struct iomap_readpage_ctx *ctx, const struct iomap_ops *ops)
 {
 	struct iomap_iter iter = {
-		.inode		= folio->mapping->host,
-		.pos		= folio_pos(folio),
-		.len		= folio_size(folio),
-	};
-	struct iomap_readpage_ctx ctx = {
-		.cur_folio	= folio,
+		.inode		= ctx->cur_folio->mapping->host,
+		.pos		= folio_pos(ctx->cur_folio),
+		.len		= folio_size(ctx->cur_folio),
 	};
 	int ret;
 
 	trace_iomap_readpage(iter.inode, 1);
 
 	while ((ret = iomap_iter(&iter, ops)) > 0)
-		iter.processed = iomap_readpage_iter(&iter, &ctx, 0);
+		iter.processed = iomap_readpage_iter(&iter, ctx, 0);
 
 	if (ret < 0)
-		folio_set_error(folio);
+		folio_set_error(ctx->cur_folio);
 
-	if (ctx.bio) {
-		submit_bio(ctx.bio);
-		WARN_ON_ONCE(!ctx.cur_folio_in_bio);
+	if (ctx->bio) {
+		submit_bio(ctx->bio);
+		WARN_ON_ONCE(!ctx->cur_folio_in_bio);
 	} else {
-		WARN_ON_ONCE(ctx.cur_folio_in_bio);
-		folio_unlock(folio);
+		WARN_ON_ONCE(ctx->cur_folio_in_bio);
+		folio_unlock(ctx->cur_folio);
 	}
 
 	/*
@@ -402,27 +392,24 @@ static loff_t iomap_readahead_iter(const struct iomap_iter *iter,
  * function is called with memalloc_nofs set, so allocations will not cause
  * the filesystem to be reentered.
  */
-void iomap_readahead(struct readahead_control *rac, const struct iomap_ops *ops)
+void iomap_readahead(struct iomap_readpage_ctx *ctx, const struct iomap_ops *ops)
 {
 	struct iomap_iter iter = {
-		.inode	= rac->mapping->host,
-		.pos	= readahead_pos(rac),
-		.len	= readahead_length(rac),
-	};
-	struct iomap_readpage_ctx ctx = {
-		.rac	= rac,
+		.inode	= ctx->rac->mapping->host,
+		.pos	= readahead_pos(ctx->rac),
+		.len	= readahead_length(ctx->rac),
 	};
 
-	trace_iomap_readahead(rac->mapping->host, readahead_count(rac));
+	trace_iomap_readahead(ctx->rac->mapping->host, readahead_count(ctx->rac));
 
 	while (iomap_iter(&iter, ops) > 0)
-		iter.processed = iomap_readahead_iter(&iter, &ctx);
+		iter.processed = iomap_readahead_iter(&iter, ctx);
 
-	if (ctx.bio)
-		submit_bio(ctx.bio);
-	if (ctx.cur_folio) {
-		if (!ctx.cur_folio_in_bio)
-			folio_unlock(ctx.cur_folio);
+	if (ctx->bio)
+		submit_bio(ctx->bio);
+	if (ctx->cur_folio) {
+		if (!ctx->cur_folio_in_bio)
+			folio_unlock(ctx->cur_folio);
 	}
 }
 EXPORT_SYMBOL_GPL(iomap_readahead);
diff --git a/fs/xfs/xfs_aops.c b/fs/xfs/xfs_aops.c
index 2ef78aa1d3f6..daa0dd4768fb 100644
--- a/fs/xfs/xfs_aops.c
+++ b/fs/xfs/xfs_aops.c
@@ -550,17 +550,25 @@ xfs_vm_bmap(
 
 STATIC int
 xfs_vm_read_folio(
-	struct file		*unused,
-	struct folio		*folio)
+	struct file			*unused,
+	struct folio			*folio)
 {
-	return iomap_read_folio(folio, &xfs_read_iomap_ops);
+	struct iomap_readpage_ctx	ctx = {
+		.cur_folio		= folio,
+	};
+
+	return iomap_read_folio(&ctx, &xfs_read_iomap_ops);
 }
 
 STATIC void
 xfs_vm_readahead(
 	struct readahead_control	*rac)
 {
-	iomap_readahead(rac, &xfs_read_iomap_ops);
+	struct iomap_readpage_ctx	ctx = {
+		.rac			= rac,
+	};
+
+	iomap_readahead(&ctx, &xfs_read_iomap_ops);
 }
 
 static int
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 738b0e28d74b..5d01496a5ada 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -112,12 +112,20 @@ static const struct iomap_ops zonefs_write_iomap_ops = {
 
 static int zonefs_read_folio(struct file *unused, struct folio *folio)
 {
-	return iomap_read_folio(folio, &zonefs_read_iomap_ops);
+	struct iomap_readpage_ctx ctx = {
+		.cur_folio = folio,
+	};
+
+	return iomap_read_folio(&ctx, &zonefs_read_iomap_ops);
 }
 
 static void zonefs_readahead(struct readahead_control *rac)
 {
-	iomap_readahead(rac, &zonefs_read_iomap_ops);
+	struct iomap_readpage_ctx ctx = {
+		.rac = rac,
+	};
+
+	iomap_readahead(&ctx, &zonefs_read_iomap_ops);
 }
 
 /*
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 0f8123504e5e..0fbce375265d 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -258,8 +258,17 @@ int iomap_file_buffered_write_punch_delalloc(struct inode *inode,
 		struct iomap *iomap, loff_t pos, loff_t length, ssize_t written,
 		int (*punch)(struct inode *inode, loff_t pos, loff_t length));
 
-int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops);
-void iomap_readahead(struct readahead_control *, const struct iomap_ops *ops);
+struct iomap_readpage_ctx {
+	struct folio			*cur_folio;
+	bool				cur_folio_in_bio;
+	struct bio			*bio;
+	struct readahead_control	*rac;
+};
+
+int iomap_read_folio(struct iomap_readpage_ctx *ctx,
+		const struct iomap_ops *ops);
+void iomap_readahead(struct iomap_readpage_ctx *ctx,
+		const struct iomap_ops *ops);
 bool iomap_is_partially_uptodate(struct folio *, size_t from, size_t count);
 struct folio *iomap_get_folio(struct iomap_iter *iter, loff_t pos);
 bool iomap_release_folio(struct folio *folio, gfp_t gfp_flags);
-- 
2.38.4

