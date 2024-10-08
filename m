Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8781399455F
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 12:27:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XNBzZ3v5Hz2yst
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 21:27:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728383256;
	cv=none; b=VW768iw+Yh9hbGjoZrsXLU7OP8dqlRFEFiVRxa/IdI1tKHnP9YjJ1yyYb+nyh0T1nUPSoUwlVgppwSq5ZvGM7u4zmJJuwVil89NsQ9dbUo1CPPqbvxBf8tq3AtmqPBpDd+6Ea48pyloZvPbaOueDk7RFpmvqR/fjILxWCiepnugzoF6e9UtuB6Nj6/kyceDRpr4yVAUzk06VmiCr/ZYKhymHVA8m1kQJv/XSmlj2JVDEw92sGsA9h1HomMfivKNdBBF7YauNcLZLjY8C/RVWupT5ujWD4nlJILpnatYM98Wp7RJzixGy/jF0Zigngk0f/8ge5gVzVLXH1shx7SvMYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728383256; c=relaxed/relaxed;
	bh=8azWINI2/PlTRXhK8Gkr9QUFN2Gl7EmxUK0FtwR65co=;
	h=Subject:To:Cc:From:Date:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=d4bDzFWDA8FltnRMGcsZXV+NSyUgpyLxyUXtguw0sTyv7iY9DK3C96g9/g56RLaGik+JTtE0eu8hjXBHnLGm29rs6xU/pKgAcrJS4DKrHH0/gUz9d16rvK/hb77QLpMk29bI92lhHU9S4q3Lbt6GfSGzw7oSOJEsFB3viqMrrRIKeszSbyzXYJ7jxjw1rAkZlrZ9wfIFRlmdDVn5iK6VCSejmyyEuLxiEPc24q1NS5WWoQz/iQfmeSBf9qu30URdvqbHEU/KuYhWTHnqCdyYWIJZEL4uv4GSVIqb9A3cdyv3i01W1GlQmPUeN/cJF3dMvblffHrfz8fcqmndFXzowA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ItCODTpF; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=ItCODTpF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=gregkh@linuxfoundation.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XNBzX0ng7z2yNc
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2024 21:27:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0AD1A5C5436;
	Tue,  8 Oct 2024 10:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9829FC4CECC;
	Tue,  8 Oct 2024 10:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728383254;
	bh=QHX9rGOUzU2I87pftqsqarH+2lhLlDpSUA8W+jZUd0Q=;
	h=Subject:To:Cc:From:Date:In-Reply-To:From;
	b=ItCODTpFidzKens5pIcdsZEVH1NpGYasuM8Vy42kwJAzxAFMfZzRutl8K3RfaerIE
	 qfp2dVrr3SB3msxoJ7gcZ4DKEXKYsG06rcjg0HIG07ZStEW8L+uZhePdvnjCiwUiJD
	 1inbRZjPUurARHMS9cfPBFpEW+hHR9HaBOEWQH1o=
Subject: Patch "erofs: set block size to the on-disk block size" has been added to the 6.1-stable tree
To: chao@kernel.org,gregkh@linuxfoundation.org,hsiangkao@linux.alibaba.com,huyue2@coolpad.com,jefflexu@linux.alibaba.com,linux-erofs@lists.ozlabs.org
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Oct 2024 12:27:23 +0200
In-Reply-To: <20241008065708.727659-4-hsiangkao@linux.alibaba.com>
Message-ID: <2024100821-dipping-deepen-4c16@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SORTED_RECIPS,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.0
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

    erofs: set block size to the on-disk block size

to the 6.1-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     erofs-set-block-size-to-the-on-disk-block-size.patch
and it can be found in the queue-6.1 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From hsiangkao@linux.alibaba.com Tue Oct  8 08:57:31 2024
From: Gao Xiang <hsiangkao@linux.alibaba.com>
Date: Tue,  8 Oct 2024 14:57:07 +0800
Subject: erofs: set block size to the on-disk block size
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Message-ID: <20241008065708.727659-4-hsiangkao@linux.alibaba.com>

From: Jingbo Xu <jefflexu@linux.alibaba.com>

commit d3c4bdcc756e60b95365c66ff58844ce75d1c8f8 upstream.

Set the block size to that specified in on-disk superblock.

Also remove the hard constraint of PAGE_SIZE block size for the
uncompressed device backend.  This constraint is temporarily remained
for compressed device and fscache backend, as there is more work needed
to handle the condition where the block size is not equal to PAGE_SIZE.

It is worth noting that the on-disk block size is read prior to
erofs_superblock_csum_verify(), as the read block size is needed in the
latter.

Besides, later we are going to make erofs refer to tar data blobs (which
is 512-byte aligned) for OCI containers, where the block size is 512
bytes.  In this case, the 512-byte block size may not be adequate for a
directory to contain enough dirents.  To fix this, we are also going to
introduce directory block size independent on the block size.

Due to we have already supported block size smaller than PAGE_SIZE now,
disable all these images with such separated directory block size until
we supported this feature later.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20230313135309.75269-3-jefflexu@linux.alibaba.com
Stable-dep-of: 9ed50b8231e3 ("erofs: fix incorrect symlink detection in fast symlink")
[ Gao Xiang: apply this to 6.6.y to avoid further backport twists
             due to obsoleted EROFS_BLKSIZ. ]
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/erofs/erofs_fs.h |    5 +++--
 fs/erofs/inode.c    |    3 ++-
 fs/erofs/internal.h |   10 +---------
 fs/erofs/super.c    |   45 +++++++++++++++++++++++++++++----------------
 4 files changed, 35 insertions(+), 28 deletions(-)

--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -53,7 +53,7 @@ struct erofs_super_block {
 	__le32 magic;           /* file system magic number */
 	__le32 checksum;        /* crc32c(super_block) */
 	__le32 feature_compat;
-	__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
+	__u8 blkszbits;         /* filesystem block size in bit shift */
 	__u8 sb_extslots;	/* superblock size = 128 + sb_extslots * 16 */
 
 	__le16 root_nid;	/* nid of root directory */
@@ -75,7 +75,8 @@ struct erofs_super_block {
 	} __packed u1;
 	__le16 extra_devices;	/* # of devices besides the primary device */
 	__le16 devt_slotoff;	/* startoff = devt_slotoff * devt_slotsize */
-	__u8 reserved[6];
+	__u8 dirblkbits;	/* directory block size in bit shift */
+	__u8 reserved[5];
 	__le64 packed_nid;	/* nid of the special packed inode */
 	__u8 reserved2[24];
 };
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -291,7 +291,8 @@ static int erofs_fill_inode(struct inode
 	}
 
 	if (erofs_inode_is_data_compressed(vi->datalayout)) {
-		if (!erofs_is_fscache_mode(inode->i_sb))
+		if (!erofs_is_fscache_mode(inode->i_sb) &&
+		    inode->i_sb->s_blocksize_bits == PAGE_SHIFT)
 			err = z_erofs_fill_inode(inode);
 		else
 			err = -EOPNOTSUPP;
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -146,7 +146,7 @@ struct erofs_sb_info {
 	u16 device_id_mask;	/* valid bits of device id to be used */
 
 	unsigned char islotbits;	/* inode slot unit size in bit shift */
-	unsigned char blkszbits;
+	unsigned char blkszbits;	/* filesystem block size in bit shift */
 
 	u32 sb_size;			/* total superblock size */
 	u32 build_time_nsec;
@@ -239,14 +239,6 @@ static inline int erofs_wait_on_workgrou
 					VAL != EROFS_LOCKED_MAGIC);
 }
 
-/* we strictly follow PAGE_SIZE and no buffer head yet */
-#define LOG_BLOCK_SIZE		PAGE_SHIFT
-#define EROFS_BLKSIZ		(1 << LOG_BLOCK_SIZE)
-
-#if (EROFS_BLKSIZ % 4096 || !EROFS_BLKSIZ)
-#error erofs cannot be used in this platform
-#endif
-
 enum erofs_kmap_type {
 	EROFS_NO_KMAP,		/* don't map the buffer */
 	EROFS_KMAP,		/* use kmap() to map the buffer */
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -285,7 +285,6 @@ static int erofs_read_superblock(struct
 	struct erofs_sb_info *sbi;
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct erofs_super_block *dsb;
-	unsigned int blkszbits;
 	void *data;
 	int ret;
 
@@ -304,6 +303,16 @@ static int erofs_read_superblock(struct
 		goto out;
 	}
 
+	sbi->blkszbits  = dsb->blkszbits;
+	if (sbi->blkszbits < 9 || sbi->blkszbits > PAGE_SHIFT) {
+		erofs_err(sb, "blkszbits %u isn't supported", sbi->blkszbits);
+		goto out;
+	}
+	if (dsb->dirblkbits) {
+		erofs_err(sb, "dirblkbits %u isn't supported", dsb->dirblkbits);
+		goto out;
+	}
+
 	sbi->feature_compat = le32_to_cpu(dsb->feature_compat);
 	if (erofs_sb_has_sb_chksum(sbi)) {
 		ret = erofs_superblock_csum_verify(sb, data);
@@ -312,19 +321,11 @@ static int erofs_read_superblock(struct
 	}
 
 	ret = -EINVAL;
-	blkszbits = dsb->blkszbits;
-	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
-	if (blkszbits != LOG_BLOCK_SIZE) {
-		erofs_err(sb, "blkszbits %u isn't supported on this platform",
-			  blkszbits);
-		goto out;
-	}
-
 	if (!check_layout_compatibility(sb, dsb))
 		goto out;
 
 	sbi->sb_size = 128 + dsb->sb_extslots * EROFS_SB_EXTSLOT_SIZE;
-	if (sbi->sb_size > EROFS_BLKSIZ) {
+	if (sbi->sb_size > PAGE_SIZE - EROFS_SUPER_OFFSET) {
 		erofs_err(sb, "invalid sb_extslots %u (more than a fs block)",
 			  sbi->sb_size);
 		goto out;
@@ -678,8 +679,8 @@ static int erofs_fc_fill_super(struct su
 
 	sbi->blkszbits = PAGE_SHIFT;
 	if (erofs_is_fscache_mode(sb)) {
-		sb->s_blocksize = EROFS_BLKSIZ;
-		sb->s_blocksize_bits = LOG_BLOCK_SIZE;
+		sb->s_blocksize = PAGE_SIZE;
+		sb->s_blocksize_bits = PAGE_SHIFT;
 
 		err = erofs_fscache_register_fs(sb);
 		if (err)
@@ -689,8 +690,8 @@ static int erofs_fc_fill_super(struct su
 		if (err)
 			return err;
 	} else {
-		if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
-			erofs_err(sb, "failed to set erofs blksize");
+		if (!sb_set_blocksize(sb, PAGE_SIZE)) {
+			errorfc(fc, "failed to set initial blksize");
 			return -EINVAL;
 		}
 
@@ -703,12 +704,24 @@ static int erofs_fc_fill_super(struct su
 	if (err)
 		return err;
 
-	if (test_opt(&sbi->opt, DAX_ALWAYS)) {
-		BUILD_BUG_ON(EROFS_BLKSIZ != PAGE_SIZE);
+	if (sb->s_blocksize_bits != sbi->blkszbits) {
+		if (erofs_is_fscache_mode(sb)) {
+			errorfc(fc, "unsupported blksize for fscache mode");
+			return -EINVAL;
+		}
+		if (!sb_set_blocksize(sb, 1 << sbi->blkszbits)) {
+			errorfc(fc, "failed to set erofs blksize");
+			return -EINVAL;
+		}
+	}
 
+	if (test_opt(&sbi->opt, DAX_ALWAYS)) {
 		if (!sbi->dax_dev) {
 			errorfc(fc, "DAX unsupported by block device. Turning off DAX.");
 			clear_opt(&sbi->opt, DAX_ALWAYS);
+		} else if (sbi->blkszbits != PAGE_SHIFT) {
+			errorfc(fc, "unsupported blocksize for DAX");
+			clear_opt(&sbi->opt, DAX_ALWAYS);
 		}
 	}
 


Patches currently in stable-queue which might be from hsiangkao@linux.alibaba.com are

queue-6.1/erofs-set-block-size-to-the-on-disk-block-size.patch
queue-6.1/erofs-avoid-hardcoded-blocksize-for-subpage-block-support.patch
queue-6.1/erofs-fix-incorrect-symlink-detection-in-fast-symlink.patch
queue-6.1/erofs-get-rid-of-z_erofs_do_map_blocks-forward-declaration.patch
queue-6.1/erofs-get-rid-of-erofs_inode_datablocks.patch
