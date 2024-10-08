Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2DC99455E
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 12:27:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XNBzX1J6Bz2yZ6
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 21:27:36 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728383253;
	cv=none; b=VkzXDREeg4q8LUHf6MGyg9Ug6a9x4SBDAS4gh6i1PL9pXfLt5FYVpQASo2Uf1BDITQMnb7mBdy39YaMyJL+JTLXMV3Vsb/K4g0JpluPIZn4JA+nBnoncnw4h7339uKdwwEPhqfMkNK90JY5+1yLRh80cntIrEchbU94HDe7mDrbVLrN/nTSS3E5bPXLGYIwhzfCs+l8iBj2K1l/Z+E/erPGLcLTJFAC2n2ruuQMdcHjWSNNdVqQ3uaSFgrW/cWyUN6sehfoEOR+nJYbFTI+ZljvoIPhIWl90ViwP399OeOuYCJ37VogGCN+hXdNLwI/fSADYqgPeWxLXHKEAm9gtxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728383253; c=relaxed/relaxed;
	bh=KTQuavA39eoeBFiRJGzbdjuqB0zfGXv0HPOrpV57mwc=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=I7CHQ41zkJGEA9PBkgfKzihNHt65vYZ2KahDsNmtJeU2c3wanIMtNl8YLN92DwP90ANYNCQ2J4WivFZm95ssiS2BBImP1zisjpoXXewRjK/CSWz53807Iz1Iq9Li7Dx2SlRomQV4l5szyYEeH3Mx+Ku9phyVleaRl6HlbvugZIwZKB/7rq6nnxnYMqtSMgetLBLXHccdrRy6NvKWfQBoUoquxSvfKBvPml3sjZqSsQJsszIGrOWsuaOKy0SgqQyXOFLG1exb/14BouRQyo7lm5UDN4LuDFKHgGE+oB2fqdLGDhlsv9CY8cEoK7FCf4pH1v0aFxXzaxj9O9yWCpbB0g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=QAcd+TRy; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=QAcd+TRy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XNBzS6xhqz3bkL
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2024 21:27:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 57FFE5C3A76;
	Tue,  8 Oct 2024 10:27:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E597CC4CECE;
	Tue,  8 Oct 2024 10:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728383250;
	bh=HbBlUCBeHMYraiK+qFQz4NQbR58xPuY+7r6A8OksLSE=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=QAcd+TRyqdnmIK+/PBoCdcpOKusGv41+vnSVKzRZM5tYX5aG1Wn8Q7IIWzj/0JyQw
	 qcCTFrCRL9UOJEs7kK+QHzgD+LWKozYBwOnsE/+UIaHAlom9bBevlkcDRV/gGo0VgD
	 AGSoLCNw54lHoW/GMNT7g1lsy0OFZyac8K6gQBIc=
Subject: Patch "erofs: get rid of z_erofs_do_map_blocks() forward declaration" has been added to the 6.1-stable tree
To: chao@kernel.org,gregkh@linuxfoundation.org,hsiangkao@linux.alibaba.com,huyue2@coolpad.com,linux-erofs@lists.ozlabs.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Oct 2024 12:27:21 +0200
In-Reply-To: <20241008065708.727659-2-hsiangkao@linux.alibaba.com>
Message-ID: <2024100819-premises-gray-e4f7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.0
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
Cc: stable-commits@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>


This is a note to let you know that I've just added the patch titled

    erofs: get rid of z_erofs_do_map_blocks() forward declaration

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     erofs-get-rid-of-z_erofs_do_map_blocks-forward-declaration.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From hsiangkao@linux.alibaba.com Tue Oct  8 08:57:29 2024
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Date: Tue,  8 Oct 2024 14:57:05 +0800
Subject: erofs: get rid of z_erofs_do_map_blocks() forward declaration
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20241008065708.727659-2-hsiangkao@linux.alibaba.com>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/zmap.c |  242 +++++++++++++++++++++++++++-----------------------------
 1 file changed, 119 insertions(+), 123 deletions(-)

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
@@ -29,125 +25,6 @@ int z_erofs_fill_inode(struct inode *ino
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
@@ -732,6 +609,125 @@ unmap_out:
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


Patches currently in stable-queue which might be from hsiangkao@linux.alibaba.com are

queue-6.1/erofs-set-block-size-to-the-on-disk-block-size.patch
queue-6.1/erofs-avoid-hardcoded-blocksize-for-subpage-block-support.patch
queue-6.1/erofs-fix-incorrect-symlink-detection-in-fast-symlink.patch
queue-6.1/erofs-get-rid-of-z_erofs_do_map_blocks-forward-declaration.patch
queue-6.1/erofs-get-rid-of-erofs_inode_datablocks.patch
