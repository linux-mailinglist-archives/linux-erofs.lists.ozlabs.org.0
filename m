Return-Path: <linux-erofs+bounces-2241-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPDgMOLIemk7+gEAu9opvQ
	(envelope-from <linux-erofs+bounces-2241-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Jan 2026 03:41:38 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D34AB37B
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Jan 2026 03:41:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f1k1C2fkhz2yFl;
	Thu, 29 Jan 2026 13:41:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1769654495;
	cv=none; b=PRU0jocaZUjojz3YWsm9b3hMuou+JhuIjIKxGasMLDaCoE2bFN7ocjuNMBoBnVnIoxaFjip2yhqf1BhtgnfdwqkWAM6o/YyjfDTSxBSz7Osieno0oh5LtomDEdkH5oAFHSSEE8wIG/SIpVYQLdNpqBjAAXViMcLxjnKTRIIU0SXAzpPoy/9JQDevtM363dUY+2cQG9OvgQsLAw6Dtp5P/QjSWexf+R2s6rSVFc0FqDxfdbGLVWZvGfZZLpldz2Gm1+rrfmEQCfq6dU8Ina1C843YLqAF3yc8Odbtw5EyhzkgM95lys8o42Ua0DHZ6Cxwp4C9qYl+VMyChiHgn9UB1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1769654495; c=relaxed/relaxed;
	bh=isiOb/qEVErIMnCx1t+5c9wFgFRT5j851jIsqitBtEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWr/KNx438wNjrKSnnt8ZoHOtmQfIyzUzMExheNTDuaGQM9aGkhglSjGBz/noolI+fYAES1TT7yES9HP8p+A7xOVn+42PQ98PIhna96Mt22o8MiMBclBNUIrn1Z2DGly4hzSZy4zi6yf3puM+A2ffs0tSUNDqOPUT1fWBW8EulGn/+dw666XknH0U7xAI6E5a/s5jDkvNcF0FpT9MvA5ZLWbJnhKRnqxctrtEt3qpFnBA3fzM4AIlslEc4hQyei7//sh3lzXu0BJfeK/ipId6x9t8fBsx1WTaewAq7AA6XOD+djQwwUFuUW9ewQpOvAc7nbYMvct9fzILZMg9LDsFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=l0iNTS8E; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=l0iNTS8E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f1k1B0Sksz2xNT
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Jan 2026 13:41:33 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1769654489; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=isiOb/qEVErIMnCx1t+5c9wFgFRT5j851jIsqitBtEU=;
	b=l0iNTS8EGrs+N6dHmjEVMDIcfBlfpjPSepd8iZ3nYcpDqzhk/OhfSOfAk5UX3WaFwUyUSPYHTdLwCNC96Joa32PYU+v9C/EHeSiYUXcs05cTejWp0w/3UFWpvPujgXQwDV/5M5mBGRX8KRn5gHD8Rzo++oX2LrHwb3Wgb7gnfOg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wy5iJSC_1769654487 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Jan 2026 10:41:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 RESEND] erofs: separate plain and compressed filesystems formally
Date: Thu, 29 Jan 2026 10:41:25 +0800
Message-ID: <20260129024125.3971443-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260128113427.2805446-1-hsiangkao@linux.alibaba.com>
References: <20260128113427.2805446-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TAGGED_FROM(0.00)[bounces-2241-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D4D34AB37B
X-Rspamd-Action: no action

The EROFS on-disk format uses a tiny, plain metadata design that
prioritizes performance and minimizes complex inconsistencies against
common writable disk filesystems (almost all serious metadata
inconsistency cannot happen in well-designed immutable filesystems like
EROFS). EROFS deliberately avoids artificial design flaws to eliminate
serious security risks from untrusted remote sources by design,
although human-made implementation bugs can still happen sometimes.

Currently, there is no strict check to prevent compressed inodes,
especially LZ4-compressed inodes, from being read in plain filesystems.

Starting with erofs-utils 1.0 and Linux 5.3, LZ4_0PADDING sb feature
is automatically enabled for LZ4-compressed EROFS images to support
in-place decompression. Furthermore, since Linux 5.4 LTS is no longer
supported, we no longer need to handle ancient LZ4-compressed EROFS
images generated by erofs-utils prior to 1.0.

To formally distinguish different filesystem types for improved
security:

 - Use the presence of LZ4_0PADDING or a non-zero
   `dsb->u1.lz4_max_distance` as a marker for compressed filesystems
   containing LZ4-compressed inodes only;

 - For other algorithms, use `dsb->u1.available_compr_algs` bitmap.

Note: LZ4_0PADDING has been supported since Linux 5.4 (the first formal
kernel version), so exposing it via sysfs is no longer necessary and is
now deprecated (but remain it for five more years until 2031):

  `dsb->u1` has been strictly non-zero for all EROFS images containing
  compressed inodes starting with erofs-utils v1.3 and it is actually
  a much better marker for compressed filesystems.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v3:
 - fix build error:
    https://lore.kernel.org/linux-erofs/202601290220.4nKd6hHT-lkp@intel.com

 Documentation/ABI/testing/sysfs-fs-erofs |  6 ++---
 fs/erofs/decompressor.c                  | 30 ++++++++++--------------
 fs/erofs/erofs_fs.h                      |  2 +-
 fs/erofs/inode.c                         | 14 +++++++----
 fs/erofs/internal.h                      |  6 ++---
 fs/erofs/super.c                         | 24 +++++++------------
 fs/erofs/sysfs.c                         |  2 --
 7 files changed, 39 insertions(+), 45 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-erofs b/Documentation/ABI/testing/sysfs-fs-erofs
index b9243c7f28d7..e4cf6fc6a106 100644
--- a/Documentation/ABI/testing/sysfs-fs-erofs
+++ b/Documentation/ABI/testing/sysfs-fs-erofs
@@ -3,9 +3,9 @@ Date:		November 2021
 Contact:	"Huang Jianan" <huangjianan@oppo.com>
 Description:	Shows all enabled kernel features.
 		Supported features:
-		zero_padding, compr_cfgs, big_pcluster, chunked_file,
-		device_table, compr_head2, sb_chksum, ztailpacking,
-		dedupe, fragments, 48bit, metabox.
+		compr_cfgs, big_pcluster, chunked_file, device_table,
+		compr_head2, sb_chksum, ztailpacking, dedupe, fragments,
+		48bit, metabox.
 
 What:		/sys/fs/erofs/<disk>/sync_decompress
 Date:		November 2021
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index e9d799a03a91..3c54e95964c9 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -34,7 +34,10 @@ static int z_erofs_load_lz4_config(struct super_block *sb,
 		}
 	} else {
 		distance = le16_to_cpu(dsb->u1.lz4_max_distance);
+		if (!distance && !erofs_sb_has_lz4_0padding(sbi))
+			return 0;
 		sbi->lz4.max_pclusterblks = 1;
+		sbi->available_compr_algs = 1 << Z_EROFS_COMPRESSION_LZ4;
 	}
 
 	sbi->lz4.max_distance_pages = distance ?
@@ -198,7 +201,6 @@ const char *z_erofs_fixup_insize(struct z_erofs_decompress_req *rq,
 static const char *__z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 					    u8 *dst)
 {
-	bool zeropadded = erofs_sb_has_zero_padding(EROFS_SB(rq->sb));
 	bool may_inplace = false;
 	unsigned int inputmargin;
 	u8 *out, *headpage, *src;
@@ -206,18 +208,15 @@ static const char *__z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 	int ret, maptype;
 
 	headpage = kmap_local_page(*rq->in);
-	/* LZ4 decompression inplace is only safe if zero_padding is enabled */
-	if (zeropadded) {
-		reason = z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
-				min_t(unsigned int, rq->inputsize,
-				      rq->sb->s_blocksize - rq->pageofs_in));
-		if (reason) {
-			kunmap_local(headpage);
-			return reason;
-		}
-		may_inplace = !((rq->pageofs_in + rq->inputsize) &
-				(rq->sb->s_blocksize - 1));
+	reason = z_erofs_fixup_insize(rq, headpage + rq->pageofs_in,
+			min_t(unsigned int, rq->inputsize,
+			      rq->sb->s_blocksize - rq->pageofs_in));
+	if (reason) {
+		kunmap_local(headpage);
+		return reason;
 	}
+	may_inplace = !((rq->pageofs_in + rq->inputsize) &
+			(rq->sb->s_blocksize - 1));
 
 	inputmargin = rq->pageofs_in;
 	src = z_erofs_lz4_handle_overlap(rq, headpage, dst, &inputmargin,
@@ -226,8 +225,7 @@ static const char *__z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 		return ERR_CAST(src);
 
 	out = dst + rq->pageofs_out;
-	/* legacy format could compress extra data in a pcluster. */
-	if (rq->partial_decoding || !zeropadded)
+	if (rq->partial_decoding)
 		ret = LZ4_decompress_safe_partial(src + inputmargin, out,
 				rq->inputsize, rq->outputsize, rq->outputsize);
 	else
@@ -454,10 +452,8 @@ int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb)
 	erofs_off_t offset;
 	int size, ret = 0;
 
-	if (!erofs_sb_has_compr_cfgs(sbi)) {
-		sbi->available_compr_algs = 1 << Z_EROFS_COMPRESSION_LZ4;
+	if (!erofs_sb_has_compr_cfgs(sbi))
 		return z_erofs_load_lz4_config(sb, dsb, NULL, 0);
-	}
 
 	algs = le16_to_cpu(dsb->u1.available_compr_algs);
 	sbi->available_compr_algs = algs;
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index b30a74d307c5..b80c6bb33a58 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -23,7 +23,7 @@
  * Any bits that aren't in EROFS_ALL_FEATURE_INCOMPAT should
  * be incompatible with this kernel version.
  */
-#define EROFS_FEATURE_INCOMPAT_ZERO_PADDING	0x00000001
+#define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
 #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
 #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
 #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 984dfa0c5231..28ac85a35926 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -177,11 +177,17 @@ static int erofs_read_inode(struct inode *inode)
 		goto err_out;
 	}
 
-	if (erofs_inode_is_data_compressed(vi->datalayout))
-		inode->i_blocks = le32_to_cpu(copied.i_u.blocks_lo) <<
-					(sb->s_blocksize_bits - 9);
-	else
+	if (!erofs_inode_is_data_compressed(vi->datalayout)) {
 		inode->i_blocks = round_up(inode->i_size, sb->s_blocksize) >> 9;
+	} else if (!IS_ENABLED(CONFIG_EROFS_FS_ZIP) || !sbi->available_compr_algs) {
+		erofs_err(sb, "compressed inode (nid %llu) is invalid in a plain filesystem",
+			  vi->nid);
+		err = -EFSCORRUPTED;
+		goto err_out;
+	} else {
+		inode->i_blocks = le32_to_cpu(copied.i_u.blocks_lo) <<
+				(sb->s_blocksize_bits - 9);
+	}
 
 	if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
 		/* fill chunked inode summary info */
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 3001bfec4e04..6a4802f3fdd8 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -114,7 +114,6 @@ struct erofs_sb_info {
 
 	unsigned int sync_decompress;	/* strategy for sync decompression */
 	unsigned int shrinker_run_no;
-	u16 available_compr_algs;
 
 	/* pseudo inode to manage cached pages */
 	struct inode *managed_cache;
@@ -154,6 +153,7 @@ struct erofs_sb_info {
 	char *volume_name;
 	u32 feature_compat;
 	u32 feature_incompat;
+	u16 available_compr_algs;
 
 	/* sysfs support */
 	struct kobject s_kobj;		/* /sys/fs/erofs/<devname> */
@@ -221,7 +221,7 @@ static inline bool erofs_sb_has_##name(struct erofs_sb_info *sbi) \
 	return sbi->feature_##compat & EROFS_FEATURE_##feature; \
 }
 
-EROFS_FEATURE_FUNCS(zero_padding, incompat, INCOMPAT_ZERO_PADDING)
+EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
 EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
 EROFS_FEATURE_FUNCS(big_pcluster, incompat, INCOMPAT_BIG_PCLUSTER)
 EROFS_FEATURE_FUNCS(chunked_file, incompat, INCOMPAT_CHUNKED_FILE)
@@ -530,7 +530,6 @@ void z_erofs_put_gbuf(void *ptr);
 int z_erofs_gbuf_growsize(unsigned int nrpages);
 int __init z_erofs_gbuf_init(void);
 void z_erofs_gbuf_exit(void);
-int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb);
 #else
 static inline void erofs_shrinker_register(struct super_block *sb) {}
 static inline void erofs_shrinker_unregister(struct super_block *sb) {}
@@ -540,6 +539,7 @@ static inline int z_erofs_init_subsystem(void) { return 0; }
 static inline void z_erofs_exit_subsystem(void) {}
 static inline int z_erofs_init_super(struct super_block *sb) { return 0; }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
+int z_erofs_parse_cfgs(struct super_block *sb, struct erofs_super_block *dsb);
 
 #ifdef CONFIG_EROFS_FS_BACKED_BY_FILE
 struct bio *erofs_fileio_bio_alloc(struct erofs_map_dev *mdev);
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index b9ffb3d42bf4..e52c2b528f86 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -122,18 +122,6 @@ void *erofs_read_metadata(struct super_block *sb, struct erofs_buf *buf,
 	return buffer;
 }
 
-#ifndef CONFIG_EROFS_FS_ZIP
-static int z_erofs_parse_cfgs(struct super_block *sb,
-			      struct erofs_super_block *dsb)
-{
-	if (!dsb->u1.available_compr_algs)
-		return 0;
-
-	erofs_err(sb, "compression disabled, unable to mount compressed EROFS");
-	return -EOPNOTSUPP;
-}
-#endif
-
 static int erofs_init_device(struct erofs_buf *buf, struct super_block *sb,
 			     struct erofs_device_info *dif, erofs_off_t *pos)
 {
@@ -363,10 +351,16 @@ static int erofs_read_superblock(struct super_block *sb)
 		}
 	}
 
-	/* parse on-disk compression configurations */
-	ret = z_erofs_parse_cfgs(sb, dsb);
-	if (ret < 0)
+	if (IS_ENABLED(CONFIG_EROFS_FS_ZIP)) {
+		ret = z_erofs_parse_cfgs(sb, dsb);
+		if (ret < 0)
+			goto out;
+	} else if (dsb->u1.available_compr_algs ||
+		   erofs_sb_has_lz4_0padding(sbi)) {
+		erofs_err(sb, "compression disabled, unable to mount compressed EROFS");
+		ret = -EOPNOTSUPP;
 		goto out;
+	}
 
 	ret = erofs_scan_devices(sb, dsb);
 
diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
index 86b22b9f0c19..3a9a5fa000ae 100644
--- a/fs/erofs/sysfs.c
+++ b/fs/erofs/sysfs.c
@@ -86,7 +86,6 @@ static struct attribute *erofs_attrs[] = {
 ATTRIBUTE_GROUPS(erofs);
 
 /* Features this copy of erofs supports */
-EROFS_ATTR_FEATURE(zero_padding);
 EROFS_ATTR_FEATURE(compr_cfgs);
 EROFS_ATTR_FEATURE(big_pcluster);
 EROFS_ATTR_FEATURE(chunked_file);
@@ -100,7 +99,6 @@ EROFS_ATTR_FEATURE(48bit);
 EROFS_ATTR_FEATURE(metabox);
 
 static struct attribute *erofs_feat_attrs[] = {
-	ATTR_LIST(zero_padding),
 	ATTR_LIST(compr_cfgs),
 	ATTR_LIST(big_pcluster),
 	ATTR_LIST(chunked_file),
-- 
2.43.5


