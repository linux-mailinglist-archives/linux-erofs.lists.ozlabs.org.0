Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 696246D65F7
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Apr 2023 16:55:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PrW5m2H8cz30hh
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Apr 2023 00:55:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EY7AelK/;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EY7AelK/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=aalbersh@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EY7AelK/;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EY7AelK/;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PrW5W2396z3cJq
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Apr 2023 00:55:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680620108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WlIQw7/j0g439cxIh8Bf75rzXhQHTIStlmhsPCq2zc8=;
	b=EY7AelK/L5B7nfYgNhFCWa14aszGAx+Qh0HpNpuxvCXuy1uehxG4g+mD/G+MfQTY3ag027
	8stPckidHMBv5TKfZorAEJI4FpkJi23lyginZo/I4v3BE37HukMiBD7cweaiXpT4ucPiGW
	8Iq0a4OBMbrDTcKQXCwFLYUZPPrRXoA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1680620108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WlIQw7/j0g439cxIh8Bf75rzXhQHTIStlmhsPCq2zc8=;
	b=EY7AelK/L5B7nfYgNhFCWa14aszGAx+Qh0HpNpuxvCXuy1uehxG4g+mD/G+MfQTY3ag027
	8stPckidHMBv5TKfZorAEJI4FpkJi23lyginZo/I4v3BE37HukMiBD7cweaiXpT4ucPiGW
	8Iq0a4OBMbrDTcKQXCwFLYUZPPrRXoA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-zgfHSJG-PyGa0hvXpBy2bg-1; Tue, 04 Apr 2023 10:55:07 -0400
X-MC-Unique: zgfHSJG-PyGa0hvXpBy2bg-1
Received: by mail-qt1-f200.google.com with SMTP id s23-20020a05622a1a9700b003e6578904c3so3759448qtc.17
        for <linux-erofs@lists.ozlabs.org>; Tue, 04 Apr 2023 07:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WlIQw7/j0g439cxIh8Bf75rzXhQHTIStlmhsPCq2zc8=;
        b=A1PC5ODxRQv+j6Y+bZezg4ik2zLvdHIexOhDM09bZhJk+CdS5nBmLIObPSRL5vtz9e
         Dr8D8JTCJT7ftdaz/ci/YgMfj5bmWY+em3bJDI9Tbm3sE/drNwuMn3N1aLNz6OmL7Y/Y
         85paFvTwS3pGXfCHXE12BOuJw1KSBDC2p/LSOQ+/w//yZVHAzsYiAh6fZ4vIJpZKz9SC
         OU70IiyDXll5z3aTM+Xj7TEQMXmqPScsby9GC25D2HbvVAV223y2EbmmdJ+GUigEqrgu
         KnRoBbVhldaf34VrbX6FgjkLR9ZuW2dDRUUPK6WZUoo51BpkaX6p1aF8pGwZk6sTDRjp
         W5qA==
X-Gm-Message-State: AAQBX9cKSSQz5CZS0Gx9wJXIksUDMgdhNql2nb9xmAzSiUBOX0WqquPe
	oxHwgcLedvmnk4quWwfip5jhIieez1HQG9EsDx7frxWUfCpyGOhiwji/MFvnNK4f0zsYCk6xIUy
	YUkjuBZy5pCoGUpYFpSNkfZE=
X-Received: by 2002:ac8:7c49:0:b0:3e4:db72:2fe9 with SMTP id o9-20020ac87c49000000b003e4db722fe9mr3470326qtv.36.1680620106390;
        Tue, 04 Apr 2023 07:55:06 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZkIqkTYw/ppN5CuEt6hgDbTeahRxMEc8GNEiOIjYIzOXDUEk9J53kAIKMBFKs3QN5nxJK1Ew==
X-Received: by 2002:ac8:7c49:0:b0:3e4:db72:2fe9 with SMTP id o9-20020ac87c49000000b003e4db722fe9mr3470285qtv.36.1680620106020;
        Tue, 04 Apr 2023 07:55:06 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 07:55:05 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: djwong@kernel.org,
	dchinner@redhat.com,
	ebiggers@kernel.org,
	hch@infradead.org,
	linux-xfs@vger.kernel.org,
	fsverity@lists.linux.dev
Subject: [PATCH v2 07/23] fsverity: pass Merkle tree block size to ->read_merkle_tree_page()
Date: Tue,  4 Apr 2023 16:53:03 +0200
Message-Id: <20230404145319.2057051-8-aalbersh@redhat.com>
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

XFS will need to know size of Merkle tree block as these blocks
will not be stored consecutively in fs blocks but under indexes in
extended attributes.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/btrfs/verity.c         | 3 ++-
 fs/ext4/verity.c          | 3 ++-
 fs/f2fs/verity.c          | 3 ++-
 fs/verity/read_metadata.c | 3 ++-
 fs/verity/verify.c        | 3 ++-
 include/linux/fsverity.h  | 3 ++-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/verity.c b/fs/btrfs/verity.c
index 4c2c09204bb4..737ad277b15a 100644
--- a/fs/btrfs/verity.c
+++ b/fs/btrfs/verity.c
@@ -713,7 +713,8 @@ int btrfs_get_verity_descriptor(struct inode *inode, void *buf, size_t buf_size)
  */
 static struct page *btrfs_read_merkle_tree_page(struct inode *inode,
 						pgoff_t index,
-						unsigned long num_ra_pages)
+						unsigned long num_ra_pages,
+						u8 log_blocksize)
 {
 	struct page *page;
 	u64 off = (u64)index << PAGE_SHIFT;
diff --git a/fs/ext4/verity.c b/fs/ext4/verity.c
index 35a2feb6fd68..cbf1253dd14a 100644
--- a/fs/ext4/verity.c
+++ b/fs/ext4/verity.c
@@ -361,7 +361,8 @@ static int ext4_get_verity_descriptor(struct inode *inode, void *buf,
 
 static struct page *ext4_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
-					       unsigned long num_ra_pages)
+					       unsigned long num_ra_pages,
+					       u8 log_blocksize)
 {
 	struct page *page;
 
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index 019c7a6c6bcf..63c6a1b1bdef 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -256,7 +256,8 @@ static int f2fs_get_verity_descriptor(struct inode *inode, void *buf,
 
 static struct page *f2fs_read_merkle_tree_page(struct inode *inode,
 					       pgoff_t index,
-					       unsigned long num_ra_pages)
+					       unsigned long num_ra_pages,
+					       u8 log_blocksize)
 {
 	struct page *page;
 
diff --git a/fs/verity/read_metadata.c b/fs/verity/read_metadata.c
index cab1612bf4a3..d6cc58c24a2e 100644
--- a/fs/verity/read_metadata.c
+++ b/fs/verity/read_metadata.c
@@ -44,7 +44,8 @@ static int fsverity_read_merkle_tree(struct inode *inode,
 		struct page *page;
 		const void *virt;
 
-		page = vops->read_merkle_tree_page(inode, index, num_ra_pages);
+		page = vops->read_merkle_tree_page(inode, index, num_ra_pages,
+						   vi->tree_params.log_blocksize);
 		if (IS_ERR(page)) {
 			err = PTR_ERR(page);
 			fsverity_err(inode,
diff --git a/fs/verity/verify.c b/fs/verity/verify.c
index c2fc4c86af34..9213b1e5ed2c 100644
--- a/fs/verity/verify.c
+++ b/fs/verity/verify.c
@@ -199,7 +199,8 @@ verify_data_block(struct inode *inode, struct fsverity_info *vi,
 
 		hpage = inode->i_sb->s_vop->read_merkle_tree_page(inode,
 				hpage_idx, level == 0 ? min(max_ra_pages,
-					params->tree_pages - hpage_idx) : 0);
+					params->tree_pages - hpage_idx) : 0,
+				params->log_blocksize);
 		if (IS_ERR(hpage)) {
 			err = PTR_ERR(hpage);
 			fsverity_err(inode,
diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
index 3e923a8e0d6f..ad07a1d10fdf 100644
--- a/include/linux/fsverity.h
+++ b/include/linux/fsverity.h
@@ -103,7 +103,8 @@ struct fsverity_operations {
 	 */
 	struct page *(*read_merkle_tree_page)(struct inode *inode,
 					      pgoff_t index,
-					      unsigned long num_ra_pages);
+					      unsigned long num_ra_pages,
+					      u8 log_blocksize);
 
 	/**
 	 * Write a Merkle tree block to the given inode.
-- 
2.38.4

