Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA6D6D6637
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 16:56:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrW776Yxzz3chq
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 00:56:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=geDod7dU;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=geDod7dU;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=aalbersh@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=geDod7dU;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=geDod7dU;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrW6S5G1Dz3cLf
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Apr 2023 00:56:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680620158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vAR4IqzKft1FulbfGVumK2HKMhiXaE7ZaLXEvaQK8Qc=;
	b=geDod7dUcgYtoIYHpv5oOM5xke/Tsz6+nna3pumTFRCR8rjrFpRxkt4v59bFZ7LFFAJVW7
	CIE0Bsxtu1dl3uLa55Es3iUYaeZLU+xUqdoFbpKbRvVb0ddZnurrZX/zH3G5oto1wSIxPj
	pNc01/NWqFTsE9ucxOPEKfZ2h7lMImk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680620158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vAR4IqzKft1FulbfGVumK2HKMhiXaE7ZaLXEvaQK8Qc=;
	b=geDod7dUcgYtoIYHpv5oOM5xke/Tsz6+nna3pumTFRCR8rjrFpRxkt4v59bFZ7LFFAJVW7
	CIE0Bsxtu1dl3uLa55Es3iUYaeZLU+xUqdoFbpKbRvVb0ddZnurrZX/zH3G5oto1wSIxPj
	pNc01/NWqFTsE9ucxOPEKfZ2h7lMImk=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-bK_fbyORO7avtO4Ezdv9SQ-1; Tue, 04 Apr 2023 10:55:56 -0400
X-MC-Unique: bK_fbyORO7avtO4Ezdv9SQ-1
Received: by mail-qt1-f198.google.com with SMTP id s23-20020a05622a1a9700b003e6578904c3so3761131qtc.17
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Apr 2023 07:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAR4IqzKft1FulbfGVumK2HKMhiXaE7ZaLXEvaQK8Qc=;
        b=5SWcQFsW0PAOMuF7d+pLTycGixmSW8RwlZL4vfaSl8aGLru/JnOmd+KccL6jYTC34j
         335XdQKnFFdoHzdioAD/juj5k5LrLEOudwKhtRd9BLJ0Bs8zuk1s9e3moymEIOHdfsm7
         McPwQBuDEKqLnrdDQb1ktDjy58gVE8T81CzmKDWqdoHCed+v3unse+vlx+Q11jFS7sOI
         pJvAq37DUjjaf8F/C3NyzVVxqkhkHD0oJXZm0QFxgHDIaEireYZow47BuI+eyXl4oAaD
         ZVOaE5psVO5lQtpI0XG/FY1HCwXkhlPOPvb0mTPfnArc5Jx2G8mVPX2AIdz4fvo36xop
         RzZw==
X-Gm-Message-State: AAQBX9cjdpWqbYA2xJYVn2vLCBroizVYGizR6JKAscm3Aj53lGqPKUU9
	Yni6H95y6V1TuwBGl1eldQEH8n0yatxEEgiHAol46cMpWvlIAaSbCf9NXs03UFPIqj0meF+Hq07
	fvmDnI1dfvqn7C1Jsp8AnNYQ=
X-Received: by 2002:a05:6214:da8:b0:5c5:471a:1e2f with SMTP id h8-20020a0562140da800b005c5471a1e2fmr3781902qvh.51.1680620152500;
        Tue, 04 Apr 2023 07:55:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y+CJdy2zuw3OclTHQicHY+1y6liC+cgVxTA4alT47Sc9E4dbJpC4DNw4j3Dv/W+hf5PybB+w==
X-Received: by 2002:a05:6214:da8:b0:5c5:471a:1e2f with SMTP id h8-20020a0562140da800b005c5471a1e2fmr3781877qvh.51.1680620152126;
        Tue, 04 Apr 2023 07:55:52 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:55:51 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: djwong@kernel.org,
	dchinner@redhat.com,
	ebiggers@kernel.org,
	hch@infradead.org,
	linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH v2 21/23] xfs: handle merkle tree block size != fs blocksize != PAGE_SIZE
Date: Tue,  4 Apr 2023 16:53:17 +0200
Message-Id: <20230404145319.2057051-22-aalbersh@redhat.com>
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

In case of different Merkle tree block size fs-verity expects
->read_merkle_tree_page() to return Merkle tree page filled with
Merkle tree blocks. The XFS stores each merkle tree block under
extended attribute. Those attributes are addressed by block offset
into Merkle tree.

This patch make ->read_merkle_tree_page() to fetch multiple merkle
tree blocks based on size ratio. Also the reference to each xfs_buf
is passed with page->private to ->drop_page().

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_verity.c | 74 +++++++++++++++++++++++++++++++++++----------
 fs/xfs/xfs_verity.h |  8 +++++
 2 files changed, 66 insertions(+), 16 deletions(-)

diff --git a/fs/xfs/xfs_verity.c b/fs/xfs/xfs_verity.c
index a9874ff4efcd..ef0aff216f06 100644
--- a/fs/xfs/xfs_verity.c
+++ b/fs/xfs/xfs_verity.c
@@ -134,6 +134,10 @@ xfs_read_merkle_tree_page(
 	struct page		*page = NULL;
 	__be64			name = cpu_to_be64(index << PAGE_SHIFT);
 	uint32_t		bs = 1 << log_blocksize;
+	int			blocks_per_page =
+		(1 << (PAGE_SHIFT - log_blocksize));
+	int			n = 0;
+	int			offset = 0;
 	struct xfs_da_args	args = {
 		.dp		= ip,
 		.attr_filter	= XFS_ATTR_VERITY,
@@ -143,26 +147,59 @@ xfs_read_merkle_tree_page(
 		.valuelen	= bs,
 	};
 	int			error = 0;
+	bool			is_checked = true;
+	struct xfs_verity_buf_list	*buf_list;
 
 	page = alloc_page(GFP_KERNEL);
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
-	error = xfs_attr_get(&args);
-	if (error) {
-		kmem_free(args.value);
-		xfs_buf_rele(args.bp);
+	buf_list = kzalloc(sizeof(struct xfs_verity_buf_list), GFP_KERNEL);
+	if (!buf_list) {
 		put_page(page);
-		return ERR_PTR(-EFAULT);
+		return ERR_PTR(-ENOMEM);
 	}
 
-	if (args.bp->b_flags & XBF_VERITY_CHECKED)
+	/*
+	 * Fill the page with Merkle tree blocks. The blcoks_per_page is higher
+	 * than 1 when fs block size != PAGE_SIZE or Merkle tree block size !=
+	 * PAGE SIZE
+	 */
+	for (n = 0; n < blocks_per_page; n++) {
+		offset = bs * n;
+		name = cpu_to_be64(((index << PAGE_SHIFT) + offset));
+		args.name = (const uint8_t *)&name;
+
+		error = xfs_attr_get(&args);
+		if (error) {
+			kmem_free(args.value);
+			/*
+			 * No more Merkle tree blocks (e.g. this was the last
+			 * block of the tree)
+			 */
+			if (error == -ENOATTR)
+				break;
+			xfs_buf_rele(args.bp);
+			put_page(page);
+			kmem_free(buf_list);
+			return ERR_PTR(-EFAULT);
+		}
+
+		buf_list->bufs[buf_list->buf_count++] = args.bp;
+
+		/* One of the buffers was dropped */
+		if (!(args.bp->b_flags & XBF_VERITY_CHECKED))
+			is_checked = false;
+
+		memcpy(page_address(page) + offset, args.value, args.valuelen);
+		kmem_free(args.value);
+		args.value = NULL;
+	}
+
+	if (is_checked)
 		SetPageChecked(page);
+	page->private = (unsigned long)buf_list;
 
-	page->private = (unsigned long)args.bp;
-	memcpy(page_address(page), args.value, args.valuelen);
-
-	kmem_free(args.value);
 	return page;
 }
 
@@ -191,16 +228,21 @@ xfs_write_merkle_tree_block(
 
 static void
 xfs_drop_page(
-	struct page	*page)
+	struct page			*page)
 {
-	struct xfs_buf *buf = (struct xfs_buf *)page->private;
+	int				i = 0;
+	struct xfs_verity_buf_list	*buf_list =
+		(struct xfs_verity_buf_list *)page->private;
 
-	ASSERT(buf != NULL);
+	ASSERT(buf_list != NULL);
 
-	if (PageChecked(page))
-		buf->b_flags |= XBF_VERITY_CHECKED;
+	for (i = 0; i < buf_list->buf_count; i++) {
+		if (PageChecked(page))
+			buf_list->bufs[i]->b_flags |= XBF_VERITY_CHECKED;
+		xfs_buf_rele(buf_list->bufs[i]);
+	}
 
-	xfs_buf_rele(buf);
+	kmem_free(buf_list);
 	put_page(page);
 }
 
diff --git a/fs/xfs/xfs_verity.h b/fs/xfs/xfs_verity.h
index ae5d87ca32a8..433b2f4ae3bc 100644
--- a/fs/xfs/xfs_verity.h
+++ b/fs/xfs/xfs_verity.h
@@ -16,4 +16,12 @@ extern const struct fsverity_operations xfs_verity_ops;
 #define xfs_verity_ops NULL
 #endif	/* CONFIG_FS_VERITY */
 
+/* Minimal Merkle tree block size is 1024 */
+#define XFS_VERITY_MAX_MBLOCKS_PER_PAGE (1 << (PAGE_SHIFT - 10))
+
+struct xfs_verity_buf_list {
+	unsigned int	buf_count;
+	struct xfs_buf	*bufs[XFS_VERITY_MAX_MBLOCKS_PER_PAGE];
+};
+
 #endif	/* __XFS_VERITY_H__ */
-- 
2.38.4

