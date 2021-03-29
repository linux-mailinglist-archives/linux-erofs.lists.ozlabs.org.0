Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5A0B34C10A
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Mar 2021 03:23:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F7vwp6Q9Zz309Y
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Mar 2021 12:23:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1616981018;
	bh=+QGIxuTVDaE4kP9FGvt0H0qV4YwkRrrFaOWKTa/Wmns=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=HzQQI7n3E+UOoxZ26arpPVWJ8A31EvT1KwkrgFnQyEHX/ZhBPa92LO/RQs9QFomqv
	 u++DFq9ihFjZ0hPjsN8MJDM7o+fOKe58lqVVSxfXYTWkB92S0B1S0xEaOUdiCGkpJt
	 7Dqlc1RvFXCZ4Ym8SMUfwBFhJeS2Tr8WwggxytW20n+gLY9W8H+ErOT6C7FNJOVPnJ
	 WYzQfyxm2CPkhUYQltiqEQxwbV/0/9DDSyEy+GpIBaS0hohw3queOXyuwXmd76mBEZ
	 AusRzxOottEs09kYL5zvRRP1Fw6gSWeFSZ+8uU0Trnm8LzFdIgMKfVjb/wNOWW2iFd
	 h8nvWOLqWLRnw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.84; helo=sonic313-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=T2D9zkZT; dkim-atps=neutral
Received: from sonic313-21.consmr.mail.gq1.yahoo.com
 (sonic313-21.consmr.mail.gq1.yahoo.com [98.137.65.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F7vwk60ZPz303t
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Mar 2021 12:23:34 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1616981013; bh=ksldMW+XtLRpIQGaYvS95k/fgDuK+rLBKC4x0MAaMDb=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=ajLVbtCZKeB4uMM2izM8c7ny7YHoRfRdLZjZuQZ0Ganop3oOWpWmm0HT/8d8WjvQwdQBxcZcjgvfz3JDaG/TMPYcQ4gEep9bD3QPoA0GpfDZv+bhoKQ4oDSXP0+vthfOSYqZvTbyndO3rcQcM3xlRplRxg3o+PU7Kik2JkH/DnuF+JjZYz5oWTVQhxM0EX85BP+2bJ/qiC0u3DO11relCQtvisDR1GcqJxDxzYE46ZxR93lYDFWnr7yBsjaa0yrOWih/olrZ5o4Nbacn78GBYKpzmgnkZ6mYgd9mzkrs3Vqqd5UViRfyJ0Eu71VKLwAXpXheVJinmQ0rtv4+yERxwg==
X-YMail-OSG: QJqzrjEVM1l6PHQmj5RKlyIiS.VFOjpiixO1eNbwjTxLVuDrGwbB9eVGLhJZDvj
 1sOOULzPo83amkcSsdM1HKD4GoEbTlpBibXFbtTTjzsO4dIXjaoBwgrITN5PDRX3b4NpOiueOQ38
 jp0CLd5O3JB4tdsT3PgT9UOO9yn52HsYr0Nw0GTmTXsUWpdZJFfY0V2rJUJdz.APyOk2tjD1e8fn
 WU79jH9ztkaS0Oa.jWZw3WyrCiR9fHH5tQMtKdXe8KwXejBQu5ABa1l_cZkWlop90qI24EIQkmrI
 QFCuKV0QFv6TIpKK_sJ89mNEk6O0IqNEezUYj5Yspr.gvlMFJTk05JcQS1BCQrfa7q6I7GKKk1Vn
 WJu4m0jSYROHfIv.BXClSAWcuKyaEybQ_WIVirYiLA41MuNV6QX2kB6PldWQEp6rp.vC.7RJIIOo
 745EKfy0zGT8EGcFxpoQ87JcJbtIPt5_FCcQ0Phe5ut1vswfDDrFgmxaKDZJIRk5c8HHfB5mMu9.
 oFNQB64xHlwEEAD4p6VnjpvKQikWPxenoQrw76slwYEqm0ZZeKDtReAoau9yvueqFrs6frc7wOcz
 ZgSGtJlcKby6Uzql2j05l4G.2RQd47.CBevQPM9FYBbKkzU3lK4R95PROp7tTSlHR9zo0lq8mkEf
 pmWbPAw1loLvlqJJnpIeGLHAELnACe.tFtQHupSkeqRmNVr8lEmHrHRfu8UfxfTzKZ09s9HsJQFO
 Z0so43tLX4CZ2hibUkEEPHuamZaGmnsHsBPF9axxHr6t9qQkNDSzz7V7o80c49ejK3mfjWEv4Dgd
 ScWJNiQ4jHem4oVJSGnZIrYR880_W_EZSnbJsTCJhTQBmTMRiXWuZdxd6GekwBz83dKmCI7mwtFB
 uySHZImENt399dXZNpsrVnd.caAFy4R6MZ.C18701jkZ4GY0rVkKavsKjuN_D4DlF36S5Mbo5YNC
 ag8HZp1b9VfunhXsMv21FnPo_pH3u3qV2heenSUwoDRqe_0c.bizu.TOvCIrNk8BMmTaKPEYu9v4
 RidKuThfUDfARbKHlHq1rMTerNKz_0zP3LtEAuUWqhrVTb_87ozwz5ILVKSrom30yWsqmO.YNIZn
 PC2FNFoLOB7K.x35cv6pmwECVXlvX3SEC9khiqc0IvNrgYF5Uos4tx6dAEZ3gTPH0FW3bRPC7DbY
 nouCCw0i.V.i8ab8A2pzRq652kSQVaqDDY0OS6rggMm_Bk6L8A.xHCuUmH2XCychOyBmoNb4xeYY
 KRsIR0nbWSouQMDa2J3hURTj34pxgfa2qLdopBiuEGLXIeJTCbqo6cPMl3q8ajaNhHrO1stdvFaW
 YMyzxOvlxPX_76G1k858EEVyoB13sH2EbveURJFH9eVvBI5ne.Qpyd9ZJtK4p9T11fl1x4OsI8wm
 I2s0xl4JzyMHQYQ58RjebjWKzFa5xfNRN4LoEJhIaPvJnMAD4Wet4A81KDiltZo83hRUnJTE5IP0
 je5cTygrpcKC10Xcw7GxRXIwUg5q54oKVoLohZCDTG9drL9jsjlgTCc93zeUurO.eCQqoiT1AXDk
 VAKWNon37bGNdBBe5UG6jk3UZoMTYQ_UglSkj3u6jFAw1LIwi3fUFabcD0wVl.dJMkil_emwhZUm
 KZmnLSveQESu9HdKiIkEfPcNk_.VXd1iFcdsCufVtXp_hG7thde4EgsRbx73iIXI88_dvKukuGWd
 TGSgoLkGcfY56ljer_t_G8kkJlPDws5DmnpQBQzuRkeaTkVQtaaj3kV0iZwT2xgpzCda6w1QP2Uj
 u.pzAKYWXVwQq4rkGc0e4TuJi21eG6C7o49sp5UwhWDVTa8T6IRkIm8YB5fUe8B_wLkCFYeZjMCW
 3lwKk3VJXh4ut6wlxdf.u47hZnXV_FkOluBYNJH32NwmCpjrm4Lj8hWeQfuCNNWVEWtuo8rbsGlb
 QNPFDxL16deyGCia2ys4_m4.i2KIkz3Jbm2d1D8XFSt89gnX43v8Jxe907Rf92ObSx5o1MzMJvvR
 BNTzYWT4roMwkegDUMqHP_ytrLJ98riHFftE2TXQki1MEz2VFHUG0nnQOJmZOqBAt.zxejWLi91Z
 ToCMZba92cBsa6nAI7jKAlHbcVMIQOtGBXy.IP_X6ACbRAJs8UMmDzR1vyODZo0IpgIGn4dFJl6u
 DQWjtts88_RzCaF8Hy6eQvpQt5.lhvn8tl03upqN6ahYqCaJD71.D8AMeLFsUXVprpCu94NUEb2I
 8ZKmGTuDVJqqC6gKqUUK84v2L8O2RfpjvozqktOANViw6JXbhTaLSrvDCMbj667PVnzA4.GvA9dH
 V8tr0d6lEPpqR6TlbUfugxP_rgZVh8Bu1MKoY3AIaTjc1HJgTBpxwovnWnVP1SF0gIkp9fDz04Rr
 4sjMze6XuBNcQ2t92w_74ob.J9CjBFpMu6FIb8isB.exL9mP5OWRIha4BP3WpvMBNurd8OHTeshR
 sZPFJH0t6jPG_cl1zMn2ZiKqRb.9BsLXLcsOZPFvdAUE8MZSDkU6XPOdTPI0CjG_.yA9D6g33UYc
 4hZDt25rKhqqohcIOwCGhY5B7ndLmJwPV20Ke.z1e.Omn8LXgLHnvt6RvzQ5oHTJqbjKb0no5V4q
 aeDD0GbSAHwtDvJJzT1M2hlkzlQcaRKwUfaoEB0Wln3Ct
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Mon, 29 Mar 2021 01:23:33 +0000
Received: by kubenode575.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID 3d9d64f8790c67205a0f6cb47abdabe6; 
 Mon, 29 Mar 2021 01:23:29 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH v2 4/4] erofs: add on-disk compression configurations
Date: Mon, 29 Mar 2021 09:23:08 +0800
Message-Id: <20210329012308.28743-5-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210329012308.28743-1-hsiangkao@aol.com>
References: <20210329012308.28743-1-hsiangkao@aol.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
From: Gao Xiang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Gao Xiang <hsiangkao@aol.com>
Cc: LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@redhat.com>

Add a bitmap for available compression algorithms and a variable-sized
on-disk table for compression options in preparation for upcoming big
pcluster and LZMA algorithm, which follows the end of super block.

To parse the compression options, the bitmap is scanned one by one.
For each available algorithm, there is data followed by 2-byte `length'
correspondingly (it's enough for most cases, or entire fs blocks should
be used.)

With such available algorithm bitmap, kernel itself can also refuse to
mount such filesystem if any unsupported compression algorithm exists.

Note that COMPR_CFGS feature will be enabled with BIG_PCLUSTER.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/decompressor.c |   2 +-
 fs/erofs/erofs_fs.h     |  14 ++--
 fs/erofs/internal.h     |   5 +-
 fs/erofs/super.c        | 143 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 157 insertions(+), 7 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 97538ff24a19..27aa6a99b371 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -41,7 +41,7 @@ int z_erofs_load_lz4_config(struct super_block *sb,
 		}
 		distance = le16_to_cpu(lz4->max_distance);
 	} else {
-		distance = le16_to_cpu(dsb->lz4_max_distance);
+		distance = le16_to_cpu(dsb->u1.lz4_max_distance);
 	}
 
 	EROFS_SB(sb)->lz4.max_distance_pages = distance ?
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index e0f3c0db1f82..5a126493d4d9 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -18,15 +18,16 @@
  * be incompatible with this kernel version.
  */
 #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
+#define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
 #define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
 
-/* 128-byte erofs on-disk super block */
+/* erofs on-disk super block (currently 128 bytes) */
 struct erofs_super_block {
 	__le32 magic;           /* file system magic number */
 	__le32 checksum;        /* crc32c(super_block) */
 	__le32 feature_compat;
 	__u8 blkszbits;         /* support block_size == PAGE_SIZE only */
-	__u8 reserved;
+	__u8 sb_extslots;	/* superblock size = 128 + sb_extslots * 16 */
 
 	__le16 root_nid;	/* nid of root directory */
 	__le64 inos;            /* total valid ino # (== f_files - f_favail) */
@@ -39,8 +40,12 @@ struct erofs_super_block {
 	__u8 uuid[16];          /* 128-bit uuid for volume */
 	__u8 volume_name[16];   /* volume name */
 	__le32 feature_incompat;
-	/* customized lz4 sliding window size instead of 64k by default */
-	__le16 lz4_max_distance;
+	union {
+		/* bitmap for available compression algorithms */
+		__le16 available_compr_algs;
+		/* customized sliding window size instead of 64k by default */
+		__le16 lz4_max_distance;
+	} __packed u1;
 	__u8 reserved2[42];
 };
 
@@ -196,6 +201,7 @@ enum {
 	Z_EROFS_COMPRESSION_LZ4	= 0,
 	Z_EROFS_COMPRESSION_MAX
 };
+#define Z_EROFS_ALL_COMPR_ALGS		(1 << (Z_EROFS_COMPRESSION_MAX - 1))
 
 /* 14 bytes (+ length field = 16 bytes) */
 struct z_erofs_lz4_cfgs {
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 46b977f348eb..f3fa895d809f 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -75,6 +75,7 @@ struct erofs_sb_info {
 	struct xarray managed_pslots;
 
 	unsigned int shrinker_run_no;
+	u16 available_compr_algs;
 
 	/* pseudo inode to manage cached pages */
 	struct inode *managed_cache;
@@ -90,6 +91,7 @@ struct erofs_sb_info {
 	/* inode slot unit size in bit shift */
 	unsigned char islotbits;
 
+	u32 sb_size;			/* total superblock size */
 	u32 build_time_nsec;
 	u64 build_time;
 
@@ -233,6 +235,7 @@ static inline bool erofs_sb_has_##name(struct erofs_sb_info *sbi) \
 }
 
 EROFS_FEATURE_FUNCS(lz4_0padding, incompat, INCOMPAT_LZ4_0PADDING)
+EROFS_FEATURE_FUNCS(compr_cfgs, incompat, INCOMPAT_COMPR_CFGS)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
 
 /* atomic flag definitions */
@@ -454,7 +457,7 @@ static inline int z_erofs_load_lz4_config(struct super_block *sb,
 				  struct erofs_super_block *dsb,
 				  struct z_erofs_lz4_cfgs *lz4, int len)
 {
-	if (lz4 || dsb->lz4_max_distance) {
+	if (lz4 || dsb->u1.lz4_max_distance) {
 		erofs_err(sb, "lz4 algorithm isn't enabled");
 		return -EINVAL;
 	}
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 1ca8da3f2125..628c751634fe 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -122,6 +122,138 @@ static bool check_layout_compatibility(struct super_block *sb,
 	return true;
 }
 
+#ifdef CONFIG_EROFS_FS_ZIP
+/* read variable-sized metadata, offset will be aligned by 4-byte */
+static void *erofs_read_metadata(struct super_block *sb, struct page **pagep,
+				 erofs_off_t *offset, int *lengthp)
+{
+	struct page *page = *pagep;
+	u8 *buffer, *ptr;
+	int len, i, cnt;
+	erofs_blk_t blk;
+
+	*offset = round_up(*offset, 4);
+	blk = erofs_blknr(*offset);
+
+	if (!page || page->index != blk) {
+		if (page) {
+			unlock_page(page);
+			put_page(page);
+		}
+		page = erofs_get_meta_page(sb, blk);
+		if (IS_ERR(page))
+			goto err_nullpage;
+	}
+
+	ptr = kmap(page);
+	len = le16_to_cpu(*(__le16 *)&ptr[erofs_blkoff(*offset)]);
+	if (!len)
+		len = U16_MAX + 1;
+	buffer = kmalloc(len, GFP_KERNEL);
+	if (!buffer) {
+		buffer = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+	*offset += sizeof(__le16);
+	*lengthp = len;
+
+	for (i = 0; i < len; i += cnt) {
+		cnt = min(EROFS_BLKSIZ - (int)erofs_blkoff(*offset), len - i);
+		blk = erofs_blknr(*offset);
+
+		if (!page || page->index != blk) {
+			if (page) {
+				kunmap(page);
+				unlock_page(page);
+				put_page(page);
+			}
+			page = erofs_get_meta_page(sb, blk);
+			if (IS_ERR(page)) {
+				kfree(buffer);
+				goto err_nullpage;
+			}
+			ptr = kmap(page);
+		}
+		memcpy(buffer + i, ptr + erofs_blkoff(*offset), cnt);
+		*offset += cnt;
+	}
+out:
+	kunmap(page);
+	*pagep = page;
+	return buffer;
+err_nullpage:
+	*pagep = NULL;
+	return page;
+}
+
+static int erofs_load_compr_cfgs(struct super_block *sb,
+				 struct erofs_super_block *dsb)
+{
+	struct erofs_sb_info *sbi;
+	struct page *page;
+	unsigned int algs, alg;
+	erofs_off_t offset;
+	int size, ret;
+
+	sbi = EROFS_SB(sb);
+	sbi->available_compr_algs = le16_to_cpu(dsb->u1.available_compr_algs);
+
+	if (sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS) {
+		erofs_err(sb,
+"try to load compressed image with unsupported algorithms %x",
+			  sbi->available_compr_algs & ~Z_EROFS_ALL_COMPR_ALGS);
+		return -EINVAL;
+	}
+
+	offset = EROFS_SUPER_OFFSET + sbi->sb_size;
+	page = NULL;
+	alg = 0;
+	ret = 0;
+
+	for (algs = sbi->available_compr_algs; algs; algs >>= 1, ++alg) {
+		void *data;
+
+		if (!(algs & 1))
+			continue;
+
+		data = erofs_read_metadata(sb, &page, &offset, &size);
+		if (IS_ERR(data)) {
+			ret = PTR_ERR(data);
+			goto err;
+		}
+
+		switch (alg) {
+		case Z_EROFS_COMPRESSION_LZ4:
+			ret = z_erofs_load_lz4_config(sb, dsb, data, size);
+			break;
+		default:
+			DBG_BUGON(1);
+			ret = -EFAULT;
+		}
+		kfree(data);
+		if (ret)
+			goto err;
+	}
+err:
+	if (page) {
+		unlock_page(page);
+		put_page(page);
+	}
+	return ret;
+}
+#else
+static int erofs_load_compr_cfgs(struct super_block *sb,
+				 struct erofs_super_block *dsb)
+{
+	if (dsb->u1.available_compr_algs) {
+		erofs_err(sb,
+"try to load compressed image when compression is disabled");
+		return -EINVAL;
+	}
+	return 0;
+}
+#endif
+
 static int erofs_read_superblock(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi;
@@ -166,6 +298,12 @@ static int erofs_read_superblock(struct super_block *sb)
 	if (!check_layout_compatibility(sb, dsb))
 		goto out;
 
+	sbi->sb_size = 128 + dsb->sb_extslots * 16;
+	if (sbi->sb_size > EROFS_BLKSIZ) {
+		erofs_err(sb, "invalid sb_extslots %u (more than a fs block)",
+			  sbi->sb_size);
+		goto out;
+	}
 	sbi->blocks = le32_to_cpu(dsb->blocks);
 	sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
 #ifdef CONFIG_EROFS_FS_XATTR
@@ -189,7 +327,10 @@ static int erofs_read_superblock(struct super_block *sb)
 	}
 
 	/* parse on-disk compression configurations */
-	ret = z_erofs_load_lz4_config(sb, dsb, NULL, 0);
+	if (erofs_sb_has_compr_cfgs(sbi))
+		ret = erofs_load_compr_cfgs(sb, dsb);
+	else
+		ret = z_erofs_load_lz4_config(sb, dsb, NULL, 0);
 out:
 	kunmap(page);
 	put_page(page);
-- 
2.20.1

