Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EED7993F12
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 08:57:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XN6KL1QJjz3bmc
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 17:57:42 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728370658;
	cv=none; b=k/tAo1pPaWMEQLsbac6eH+b5ddXPOm1Y7ZLXpq6mIVvHN3rBIkNPqrBXg0cDnOudMmypxXtGHhzUhxt6BE0uLEJcnrl32YMzGk848pbCgZyOgg99y6hYAIORCX9RU3zdfOETEaVaSermrhYn3YOUoXcvkJVG9DEQqwVDEyW9Q9FRKiLts2+D1cvEhBU19FgBCqQ5MRz+4cebmOnMPFCSZwTtxLRR0U10EeBwjack2uxrR7MisU6XWT8/W/ETm8i3BDRFG3JftztmjIAH3Cs0LsB3XlQMSPE+uqXQVuIsZ0TTnF4AsiV8DFFtRLkuz7GeZPz8seQcfZ25uvi/lAlpWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728370658; c=relaxed/relaxed;
	bh=GnvvEgpZfu5pp7KkhPx8xhUyNlF/RjW4kmUiKH0w6ak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nRcMSJ2IotvC7ud387Rn3Z2TuYABRGg2e3APIfXgZTbu4BjgVXlkXJPUYUm/0A33+XctFQ6MB2uE/80OY4pnMbx/tlqvoeAzb9rcpUsGeRdFKpAbGKETcc3E1pPLJ58M/+/0/J3ZbbNFyri84qRVl7VC8zNPUQkgiD54r0QtXYGpHx8a2aDg281UJGzMbdV0py2ewf8E7ywgHuE22pL8gMAnolMebG3Rf9GzOJ4t8x6wG71ni4zxR84CTVJFF9d+HDULsawBFkGQr4L9fuIsS84R2ZluxZ8ln3O76KsTrYT64UMfwkmgAXTiBu8jsXODlDfQUCvO4/LK93T3IuFGnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vRgTvATw; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vRgTvATw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XN6KD0QRfz2xjK
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2024 17:57:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728370646; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=GnvvEgpZfu5pp7KkhPx8xhUyNlF/RjW4kmUiKH0w6ak=;
	b=vRgTvATwstkVf0fCBNW/P0fMgPUDgDCskuro+CmLynhtwpYhq+iPH+BLX4dQVIMlx+xn3u9xZF7g1ZAqTCLe16sDUpdTDB6/gQnjDU2SuEwDsBrrs2NMla0PNeeWX15VnlVdk2cRhIYZim+mLg3gxdg0tZMJsvmUsCTqqxnRqB8=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGbLQfS_1728370644)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 14:57:25 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.1.y 2/5] erofs: get rid of z_erofs_do_map_blocks() forward declaration
Date: Tue,  8 Oct 2024 14:57:05 +0800
Message-ID: <20241008065708.727659-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241008065708.727659-1-hsiangkao@linux.alibaba.com>
References: <20241008065708.727659-1-hsiangkao@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

commit 999f2f9a63f475192d837a2b8595eb0962984d21 upstream.

The code can be neater without forward declarations.  Let's
get rid of z_erofs_do_map_blocks() forward declaration.

Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Stable-dep-of: 9ed50b8231e3 ("erofs: fix incorrect symlink detection in fast symlink")
Link: https://lore.kernel.org/r/20230204093040.97967-5-hsiangkao@linux.alibaba.com
[ Gao Xiang: apply this to 6.6.y to avoid further backport twists
             due to obsoleted EROFS_BLKSIZ. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 242 ++++++++++++++++++++++++------------------------
 1 file changed, 119 insertions(+), 123 deletions(-)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 4864863cd129..5d1a7aff2d70 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -7,10 +7,6 @@
 #include <asm/unaligned.h>
 #include <trace/events/erofs.h>
 
-static int z_erofs_do_map_blocks(struct inode *inode,
-				 struct erofs_map_blocks *map,
-				 int flags);
-
 int z_erofs_fill_inode(struct inode *inode)
 {
 	struct erofs_inode *const vi = EROFS_I(inode);
@@ -29,125 +25,6 @@ int z_erofs_fill_inode(struct inode *inode)
 	return 0;
 }
 
-static int z_erofs_fill_inode_lazy(struct inode *inode)
-{
-	struct erofs_inode *const vi = EROFS_I(inode);
-	struct super_block *const sb = inode->i_sb;
-	int err, headnr;
-	erofs_off_t pos;
-	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
-	void *kaddr;
-	struct z_erofs_map_header *h;
-
-	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags)) {
-		/*
-		 * paired with smp_mb() at the end of the function to ensure
-		 * fields will only be observed after the bit is set.
-		 */
-		smp_mb();
-		return 0;
-	}
-
-	if (wait_on_bit_lock(&vi->flags, EROFS_I_BL_Z_BIT, TASK_KILLABLE))
-		return -ERESTARTSYS;
-
-	err = 0;
-	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags))
-		goto out_unlock;
-
-	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
-	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos), EROFS_KMAP);
-	if (IS_ERR(kaddr)) {
-		err = PTR_ERR(kaddr);
-		goto out_unlock;
-	}
-
-	h = kaddr + erofs_blkoff(pos);
-	/*
-	 * if the highest bit of the 8-byte map header is set, the whole file
-	 * is stored in the packed inode. The rest bits keeps z_fragmentoff.
-	 */
-	if (h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT) {
-		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
-		vi->z_fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
-		vi->z_tailextent_headlcn = 0;
-		goto done;
-	}
-	vi->z_advise = le16_to_cpu(h->h_advise);
-	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
-	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
-
-	headnr = 0;
-	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX ||
-	    vi->z_algorithmtype[++headnr] >= Z_EROFS_COMPRESSION_MAX) {
-		erofs_err(sb, "unknown HEAD%u format %u for nid %llu, please upgrade kernel",
-			  headnr + 1, vi->z_algorithmtype[headnr], vi->nid);
-		err = -EOPNOTSUPP;
-		goto out_put_metabuf;
-	}
-
-	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
-	if (!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
-	    vi->z_advise & (Z_EROFS_ADVISE_BIG_PCLUSTER_1 |
-			    Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
-		erofs_err(sb, "per-inode big pcluster without sb feature for nid %llu",
-			  vi->nid);
-		err = -EFSCORRUPTED;
-		goto out_put_metabuf;
-	}
-	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
-	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
-	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
-		erofs_err(sb, "big pcluster head1/2 of compact indexes should be consistent for nid %llu",
-			  vi->nid);
-		err = -EFSCORRUPTED;
-		goto out_put_metabuf;
-	}
-
-	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
-		struct erofs_map_blocks map = {
-			.buf = __EROFS_BUF_INITIALIZER
-		};
-
-		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
-		err = z_erofs_do_map_blocks(inode, &map,
-					    EROFS_GET_BLOCKS_FINDTAIL);
-		erofs_put_metabuf(&map.buf);
-
-		if (!map.m_plen ||
-		    erofs_blkoff(map.m_pa) + map.m_plen > EROFS_BLKSIZ) {
-			erofs_err(sb, "invalid tail-packing pclustersize %llu",
-				  map.m_plen);
-			err = -EFSCORRUPTED;
-		}
-		if (err < 0)
-			goto out_put_metabuf;
-	}
-
-	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
-	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
-		struct erofs_map_blocks map = {
-			.buf = __EROFS_BUF_INITIALIZER
-		};
-
-		vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
-		err = z_erofs_do_map_blocks(inode, &map,
-					    EROFS_GET_BLOCKS_FINDTAIL);
-		erofs_put_metabuf(&map.buf);
-		if (err < 0)
-			goto out_put_metabuf;
-	}
-done:
-	/* paired with smp_mb() at the beginning of the function */
-	smp_mb();
-	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
-out_put_metabuf:
-	erofs_put_metabuf(&buf);
-out_unlock:
-	clear_and_wake_up_bit(EROFS_I_BL_Z_BIT, &vi->flags);
-	return err;
-}
-
 struct z_erofs_maprecorder {
 	struct inode *inode;
 	struct erofs_map_blocks *map;
@@ -732,6 +609,125 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 	return err;
 }
 
+static int z_erofs_fill_inode_lazy(struct inode *inode)
+{
+	struct erofs_inode *const vi = EROFS_I(inode);
+	struct super_block *const sb = inode->i_sb;
+	int err, headnr;
+	erofs_off_t pos;
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+	void *kaddr;
+	struct z_erofs_map_header *h;
+
+	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags)) {
+		/*
+		 * paired with smp_mb() at the end of the function to ensure
+		 * fields will only be observed after the bit is set.
+		 */
+		smp_mb();
+		return 0;
+	}
+
+	if (wait_on_bit_lock(&vi->flags, EROFS_I_BL_Z_BIT, TASK_KILLABLE))
+		return -ERESTARTSYS;
+
+	err = 0;
+	if (test_bit(EROFS_I_Z_INITED_BIT, &vi->flags))
+		goto out_unlock;
+
+	pos = ALIGN(erofs_iloc(inode) + vi->inode_isize + vi->xattr_isize, 8);
+	kaddr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos), EROFS_KMAP);
+	if (IS_ERR(kaddr)) {
+		err = PTR_ERR(kaddr);
+		goto out_unlock;
+	}
+
+	h = kaddr + erofs_blkoff(pos);
+	/*
+	 * if the highest bit of the 8-byte map header is set, the whole file
+	 * is stored in the packed inode. The rest bits keeps z_fragmentoff.
+	 */
+	if (h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT) {
+		vi->z_advise = Z_EROFS_ADVISE_FRAGMENT_PCLUSTER;
+		vi->z_fragmentoff = le64_to_cpu(*(__le64 *)h) ^ (1ULL << 63);
+		vi->z_tailextent_headlcn = 0;
+		goto done;
+	}
+	vi->z_advise = le16_to_cpu(h->h_advise);
+	vi->z_algorithmtype[0] = h->h_algorithmtype & 15;
+	vi->z_algorithmtype[1] = h->h_algorithmtype >> 4;
+
+	headnr = 0;
+	if (vi->z_algorithmtype[0] >= Z_EROFS_COMPRESSION_MAX ||
+	    vi->z_algorithmtype[++headnr] >= Z_EROFS_COMPRESSION_MAX) {
+		erofs_err(sb, "unknown HEAD%u format %u for nid %llu, please upgrade kernel",
+			  headnr + 1, vi->z_algorithmtype[headnr], vi->nid);
+		err = -EOPNOTSUPP;
+		goto out_put_metabuf;
+	}
+
+	vi->z_logical_clusterbits = LOG_BLOCK_SIZE + (h->h_clusterbits & 7);
+	if (!erofs_sb_has_big_pcluster(EROFS_SB(sb)) &&
+	    vi->z_advise & (Z_EROFS_ADVISE_BIG_PCLUSTER_1 |
+			    Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
+		erofs_err(sb, "per-inode big pcluster without sb feature for nid %llu",
+			  vi->nid);
+		err = -EFSCORRUPTED;
+		goto out_put_metabuf;
+	}
+	if (vi->datalayout == EROFS_INODE_FLAT_COMPRESSION &&
+	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_1) ^
+	    !(vi->z_advise & Z_EROFS_ADVISE_BIG_PCLUSTER_2)) {
+		erofs_err(sb, "big pcluster head1/2 of compact indexes should be consistent for nid %llu",
+			  vi->nid);
+		err = -EFSCORRUPTED;
+		goto out_put_metabuf;
+	}
+
+	if (vi->z_advise & Z_EROFS_ADVISE_INLINE_PCLUSTER) {
+		struct erofs_map_blocks map = {
+			.buf = __EROFS_BUF_INITIALIZER
+		};
+
+		vi->z_idata_size = le16_to_cpu(h->h_idata_size);
+		err = z_erofs_do_map_blocks(inode, &map,
+					    EROFS_GET_BLOCKS_FINDTAIL);
+		erofs_put_metabuf(&map.buf);
+
+		if (!map.m_plen ||
+		    erofs_blkoff(map.m_pa) + map.m_plen > EROFS_BLKSIZ) {
+			erofs_err(sb, "invalid tail-packing pclustersize %llu",
+				  map.m_plen);
+			err = -EFSCORRUPTED;
+		}
+		if (err < 0)
+			goto out_put_metabuf;
+	}
+
+	if (vi->z_advise & Z_EROFS_ADVISE_FRAGMENT_PCLUSTER &&
+	    !(h->h_clusterbits >> Z_EROFS_FRAGMENT_INODE_BIT)) {
+		struct erofs_map_blocks map = {
+			.buf = __EROFS_BUF_INITIALIZER
+		};
+
+		vi->z_fragmentoff = le32_to_cpu(h->h_fragmentoff);
+		err = z_erofs_do_map_blocks(inode, &map,
+					    EROFS_GET_BLOCKS_FINDTAIL);
+		erofs_put_metabuf(&map.buf);
+		if (err < 0)
+			goto out_put_metabuf;
+	}
+done:
+	/* paired with smp_mb() at the beginning of the function */
+	smp_mb();
+	set_bit(EROFS_I_Z_INITED_BIT, &vi->flags);
+out_put_metabuf:
+	erofs_put_metabuf(&buf);
+out_unlock:
+	clear_and_wake_up_bit(EROFS_I_BL_Z_BIT, &vi->flags);
+	return err;
+}
+
 int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			    int flags)
 {
-- 
2.43.5

