Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B2B993F14
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 08:57:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XN6KM6WYCz3bxR
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Oct 2024 17:57:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728370660;
	cv=none; b=neWimZB/IwLJ69YbPtgjBYIpZ6ztV5NwHJmzIkEBaYOFmDxl1Pjvo6vs2LSpOPCYtmbAnR4CFl2hO0hzOn8F7RYw+vcnRaDxjGmWuHGvKJ599GS1cXUlYs4glTcsm0Y57OBQmCwjRVpd8vy22yA8W+RDzQXO+cSSompchiUvIGuWNttWvg6dmnFD4n3gaSHQyY1kZz7qsaVv9nhzX3WieMvh0mRWJCqJYWzDCJgap80EgEdfqneKlo5HDpEgm9IuwBSXpj+gJ++geRYOuakJClRp2roOXZY2XT7epE0F2ycDRv6m9unN/fd5spIQhg2ILj/Ydwu81WMm5esWoj2R5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728370660; c=relaxed/relaxed;
	bh=i5KG4rJ1jhzr82GcPr3e6w3lcm6mcM15cZ85KlWdwyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jhs09dfsfpUYcBW+mvcDG+IwYR9zSswlaVr7WoxhMLi0xuw/hpRDbQiT9zx6dffScIAGMG0B/EINrpGY8nHa/K3aMWpHJTctyeW7psbclzLv4CKtSjp/69Xnx9TSmnILHPYu33oQgxDRxUzYUVEU23J0s1Lb9nRX+NX1VHzDT4nEThrobfTeP8G8FTGknvTz2kwnbbopHr5kltHTwFN5ZB878TTyd2NYiXh+bgysK7/DNAZQe0kyWhdZs2a1PZabvDNEaCDRlZ6G4uFyq+FFZuIOG4GqI3yXSj/g53SRxLw4+FarvU5faPLSqAHbaZx9e3szmL41MKB5Ta1V2raMwg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xNKWuC3N; dkim-atps=neutral; spf=pass (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xNKWuC3N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XN6KG0RT5z2xjP
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Oct 2024 17:57:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728370649; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=i5KG4rJ1jhzr82GcPr3e6w3lcm6mcM15cZ85KlWdwyQ=;
	b=xNKWuC3Nnv0e3XhukRH2vWGeyR3FEzado+FAM0CEYzvRx76zHKjnuOghHTs6JrtES++v6P604JJhgjPe0k9ht1lTIh6ifOlXrXBcNv/4EIlNTRMsEh2cs2doo6GmRq9iRRdTeHJrvn7HrmFby+mV+xUf/w3TwB6YTvpR6zOOEfw=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGbLQgl_1728370646)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 14:57:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 6.1.y 4/5] erofs: set block size to the on-disk block size
Date: Tue,  8 Oct 2024 14:57:07 +0800
Message-ID: <20241008065708.727659-4-hsiangkao@linux.alibaba.com>
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
---
 fs/erofs/erofs_fs.h |  5 +++--
 fs/erofs/inode.c    |  3 ++-
 fs/erofs/internal.h | 10 +---------
 fs/erofs/super.c    | 45 +++++++++++++++++++++++++++++----------------
 4 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index dbcd24371002..44876a97cabd 100644
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
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index efbaa4ef63cb..8fc41fd1620c 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -291,7 +291,8 @@ static int erofs_fill_inode(struct inode *inode)
 	}
 
 	if (erofs_inode_is_data_compressed(vi->datalayout)) {
-		if (!erofs_is_fscache_mode(inode->i_sb))
+		if (!erofs_is_fscache_mode(inode->i_sb) &&
+		    inode->i_sb->s_blocksize_bits == PAGE_SHIFT)
 			err = z_erofs_fill_inode(inode);
 		else
 			err = -EOPNOTSUPP;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 2b3d9e9665fa..d7cd1e619d46 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -146,7 +146,7 @@ struct erofs_sb_info {
 	u16 device_id_mask;	/* valid bits of device id to be used */
 
 	unsigned char islotbits;	/* inode slot unit size in bit shift */
-	unsigned char blkszbits;
+	unsigned char blkszbits;	/* filesystem block size in bit shift */
 
 	u32 sb_size;			/* total superblock size */
 	u32 build_time_nsec;
@@ -239,14 +239,6 @@ static inline int erofs_wait_on_workgroup_freezed(struct erofs_workgroup *grp)
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
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 446b9b7e712e..25cd66e487e8 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -285,7 +285,6 @@ static int erofs_read_superblock(struct super_block *sb)
 	struct erofs_sb_info *sbi;
 	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct erofs_super_block *dsb;
-	unsigned int blkszbits;
 	void *data;
 	int ret;
 
@@ -304,6 +303,16 @@ static int erofs_read_superblock(struct super_block *sb)
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
@@ -312,19 +321,11 @@ static int erofs_read_superblock(struct super_block *sb)
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
@@ -678,8 +679,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	sbi->blkszbits = PAGE_SHIFT;
 	if (erofs_is_fscache_mode(sb)) {
-		sb->s_blocksize = EROFS_BLKSIZ;
-		sb->s_blocksize_bits = LOG_BLOCK_SIZE;
+		sb->s_blocksize = PAGE_SIZE;
+		sb->s_blocksize_bits = PAGE_SHIFT;
 
 		err = erofs_fscache_register_fs(sb);
 		if (err)
@@ -689,8 +690,8 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
 		if (err)
 			return err;
 	} else {
-		if (!sb_set_blocksize(sb, EROFS_BLKSIZ)) {
-			erofs_err(sb, "failed to set erofs blksize");
+		if (!sb_set_blocksize(sb, PAGE_SIZE)) {
+			errorfc(fc, "failed to set initial blksize");
 			return -EINVAL;
 		}
 
@@ -703,12 +704,24 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
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
 
-- 
2.43.5

