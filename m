Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A273034B41C
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Mar 2021 04:50:26 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6lH44SP3z3btg
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Mar 2021 14:50:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1616817024;
	bh=tBGu2fJ8fHbkJD++940EdwF1vd/8m/+LGVncG5BAvAs=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=N4zRFU3vdTihmSOAu6+mCCBCn86S7xK1Q6PuVDO23MNxKWvTltnER+xNGPh50DYUL
	 VDuLLvQmBZjakA3t106ncoPm4N3E8mCcsAYiPVEuxsyL+EanJgAUbywd12qOpaCofQ
	 SVhbXzUqPB2DVn9n3IeGKKTu8+5raV+c5HQUw5QQOqPN/ITfOptwETQjIrgQ40dGDx
	 W1QyFFurlOY2mG1eLpHhs7tYTvhrJco8DT6zuxcEvfTLGYlbCLTDXLUqVqDWt3N67q
	 hPLedDiO86+hUrODKzCR8C6jHvOSsEJbDNuxJChi+5/RV/Zhuzq+T5I56mtSQA4FqT
	 8ZlJMmCMt5/Zw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.204; helo=sonic304-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=bl7COtYS; dkim-atps=neutral
Received: from sonic304-23.consmr.mail.gq1.yahoo.com
 (sonic304-23.consmr.mail.gq1.yahoo.com [98.137.68.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6lH15yrsz3bsh
 for <linux-erofs@lists.ozlabs.org>; Sat, 27 Mar 2021 14:50:21 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1616817016; bh=3KXhB0zW8+asxPRqGDp1ArFHW7POpw6dTsdgMneba4c=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=N2fslfAkkJVL+L9qGgA+DcReju6CSrGsTEt02Tv/ZkbrzRPDuEnr3E3P/5rpmNGhvdP1MXSCl5RXq64r+DIjkjxKxSk/7cJh3KwPq9/QWmFUejAF7d4oeI/UOm1P0tOWiEmsDcOSjsSYa/2W/YrLyO7pVP8ZYn0MhlQf7kMvCS1yqTCr1dysnAKfGnKYMdKjTAHyaowxTOOwwM/jQQwNepORd97W93chGYBxd4eh/4lu0S8n1qjmgIjYKhFVczf2ztWrcNen8OofOoziR2ejxkDBaLVbTGJCi6YEBQnl4z3b0FUrq4m18UkBI7ritoCuRCR0AdBOyBan5uCeCclq6g==
X-YMail-OSG: Qz0clzoVM1lfE2Yl2Fcmc.JtN0beL8KzLcz0mVD0j.PyAzPfOydWR72KhcQ22OI
 ZjdN9kDYT2jVtDss.VBsXscI0WE608wdacwiqJztPLwFCmqNaenicXKXP3g.N7o5kMkpubkcCjcA
 rdpgGeIMZcoRLTP08R61YUaEEsQ0DA7T3xOzyJAZ1KLg_cTl7El4Z0l8qE9CyeJ3IjlkTagb1BgV
 EI3UqtKRcN_5mNVS9Rj87E5oECAYTiebYKbt2pkNAbirlzazgOGJHgQmXlD97SGQixEwH7_5KDNf
 D0eoj39ASWps9SPfv1OhiBHds_XnhQodNtWOKSlZEPYF3UcIbYj3NJxjpfUjdP5m1HoJ235RGOpx
 .h7qR84wGS1vth3zDIkOfJwRJxuT0kqcdvKWTxmpmmzb7KLMoYNxX91dF1TBdDosTRTVSTjujxjB
 XNkvXaiYGO1B3T9ahqR0LJ4Y3D0jFgnh7E4nE6CaTXHUawDP9gbAMbDSgMgDhwBC4l3uYyfWflSe
 tBnRiBukKRNpEvldssDmiyaGwgDu.yD1fUCZcyeVFskJIttTLwuWNMZznVIIl9FI58MWQiKSNm6q
 NxReHSMQvKLalwL_X9B0OnvcAMLnGYJ6Ef7IjQXFDQWPAnUIkuRpTrKbHhttxdEzWRH2pUhuz56B
 QomvdwQrCDlbq5IYM8IFch.qwGLovGwBRVLx7HcdB6NtFKkbZXXlG2dG.uJL8SVfTs.UyMECParK
 4lmKyNEDKjONwF4s76tC5_yTCavXNsSJfdexMf7fMB4nDPo0dvVlqBbXrap8shJfN84R3wU5FJsx
 BReJvCw6RhulKn28e5yGWNiaqbTbgve0g1CRPOhXphY1MeBaJJNXpajeqw3A.QC2ClHfhby3aD7g
 N5IjtLrtwZqEr6i8yRqINGcM.HhutfhYmX7ZhYeSfHB0w3k4aH61ZMTyd8jCznjCztISVQRyXYrH
 cJMzvWLxg7UZtctJG7wx4uMJ5kyU8.bKRNYsQ8MlY4Rb7r_8r_2DUWtpXKrzcJOGjWsilvBKGEm6
 VZdJvAA8ULO4Tj5QVA.MEOpnlY2ibQEtXoMvBPOIz9EdZ9n_jqFtMihzKBxHJPnYCvSj.QxbXG3f
 EwiJ14dEhqVgnX_MSn0ve9RVgPozYH1QP82Ol8pGv.uyMxNlQbZhMiCDG4K7r9ZJ0sVWAM6m98gy
 XoKoFvEoqI4eTv4qt7PdqpuCcvq5iwJiBlkEJRqksVtNu26BhEJ_wV38RF1JEi34qSEe9JavzGy5
 2bn4DpgqV.ZFnuudJhW4DMsyAbmb2trK6acNGplaElcW.LYECPrgToR0f8BN7PeP9rIczqnCMxku
 1yQ_N3_iFVwUmxd.TK.pYNVxrB.74CvjY7qBRyUYPKvfmPD55k1w3KAu6_rP14rGjPxnK31IXv4b
 fD1BVP6x0lZgLcnjZ4CDtbFRYnEt4Pw4TQ1yFy8LLqPN_B_sO3.D.szMdwWszDGNICLlHfD1EN4B
 Lp6jS7SxJ.9SFHjToWG8avxk3SLY8Xehph.ZDzb57H2DAB_tIn9PhT.UM1VZglLikEnTiyQIiI_c
 Jty.sJQg8DVQdM44OiuM02IFqRs5si_uQ7PbB8XynKbluBjo9VA4HsA1Ao9._zDvmKYQ3Nv8tl.c
 sKZXVAc_oFWMK.Jk3GrDHyxxxvXKVNaK2Wh3F6FawH26.OJ4s_tp.yOIzKcyNilAKOsFIsQ6riqI
 5RPQQCmTmZrTVSI6PofEnjXJIVG6qI63qGahMVjLdJ5NnLFd6pSlccVWwMNXYlOr.ZqQ4Ex1x8IT
 0hskJu1VxsxpWSRcBHRxdyBx9uYl1DfLFiMHvAd.5d9g1y.LdI.kYKGnBSpcE2lnz_e2JKSzHO1Q
 ULawqVrylsEHUBxIMiYeaonbq6we8HhoZJMcNoIs8ZRslABvA.8fNdLVkz7BVhjRzX2M_Fjeb9Al
 VeYuqQt5R0hZ3GoGXvv1aqUXSFKFgNn.sAe_iGoqqQ1Y8NJhBwTh9UZN3CsiFCsI.Bc2ZT2qLVPT
 NMZeq1Rteci8wrWdUb6CGug_pIhPUkxy035YcaRj5D5wSi7fvvB.ocPAABKVh1Dfjyd.g9gzEm7P
 7eEoGBP.tF4PJ30EFzw3VCs_A8T_zCGSi7hWflvy.DJbcgX4t3193kvgBg3pC8LVQQ37KiN94gvx
 WhmihjL.kLKbkcNN9mGWyAHpiE2F2ZI3Bhdsg6ENbApWyeWEIlZlJTu.UYTCX3MZxQTs0QSp3Exd
 4zkFUgk_8I2Phj.XgHuSwKrWwfthKjpjwetIfxMhehGUvkT6ZpviehZ3IlyAaX5BWhSEjyXmHpoX
 biK4qzM.E9WP5SSW_FuufWZnmImGuMvhbwHKAKxvHwAFPx1YPo9frzkseGk0FJxXGD7.5eMhR.5K
 5iIBvx.ahAta3jVPvGup7Pi613mkSupZp72Sbbxv4f2rIPuEjxnfDjsWOQFVRG4xBbENLhVN.MgL
 PJpjnDPMGS2llzEjTWblQq5t195R0bTiZf86jBHxmlC7Td_Pkl.8MnnInwdTlZfWXEI77CUByJJt
 rZue._.Ed4Edj0PIVBx0wVt6dnLkKLbawKILqiigVbmo4randPOnRlqjvnQxUNJ_qHPS0SerckZV
 x2YzrvDpLAA4T6VHyRWokaLjxIHTqb5HjgN4v6edP7KT53p700Vrurpf7gXjTdUGGxQG5jAGCQio
 PrpW3_gnDnLAhyUZgZnqD
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sat, 27 Mar 2021 03:50:16 +0000
Received: by kubenode529.mail-prod1.omega.ir2.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID b79f63fb2a60f2e9a0e41858735ab882; 
 Sat, 27 Mar 2021 03:50:09 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH 4/4] erofs: add on-disk compression configurations
Date: Sat, 27 Mar 2021 11:49:36 +0800
Message-Id: <20210327034936.12537-5-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210327034936.12537-1-hsiangkao@aol.com>
References: <20210327034936.12537-1-hsiangkao@aol.com>
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

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/decompressor.c |   2 +-
 fs/erofs/erofs_fs.h     |  16 +++--
 fs/erofs/internal.h     |   5 +-
 fs/erofs/super.c        | 145 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 161 insertions(+), 7 deletions(-)

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
index 1322ae63944b..ef3f8a99aa5f 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -18,15 +18,18 @@
  * be incompatible with this kernel version.
  */
 #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
-#define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
+#define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
+#define EROFS_ALL_FEATURE_INCOMPAT		\
+	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
+	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS)
 
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
@@ -39,7 +42,11 @@ struct erofs_super_block {
 	__u8 uuid[16];          /* 128-bit uuid for volume */
 	__u8 volume_name[16];   /* volume name */
 	__le32 feature_incompat;
-	__le16 lz4_max_distance;
+	union {
+		/* bitmap for available compression algorithms */
+		__le16 available_compr_algs;
+		__le16 lz4_max_distance;
+	} __packed u1;
 	__u8 reserved2[42];
 };
 
@@ -195,6 +202,7 @@ enum {
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
index 1ca8da3f2125..c5e3039f51bf 100644
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
+	kunmap(page);
+out:
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
@@ -166,6 +298,13 @@ static int erofs_read_superblock(struct super_block *sb)
 	if (!check_layout_compatibility(sb, dsb))
 		goto out;
 
+	sbi->sb_size = 128 + dsb->sb_extslots * 16;
+	if (sbi->sb_size > EROFS_BLKSIZ) {
+		erofs_err(sb, "invalid sb_extslots %u (more than a fs block)",
+			  sbi->sb_size);
+		goto out;
+	}
+
 	sbi->blocks = le32_to_cpu(dsb->blocks);
 	sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
 #ifdef CONFIG_EROFS_FS_XATTR
@@ -189,7 +328,11 @@ static int erofs_read_superblock(struct super_block *sb)
 	}
 
 	/* parse on-disk compression configurations */
-	ret = z_erofs_load_lz4_config(sb, dsb, NULL, 0);
+	if (erofs_sb_has_compr_cfgs(sbi))
+		ret = erofs_load_compr_cfgs(sb, dsb);
+	else
+		ret = z_erofs_load_lz4_config(sb, dsb, NULL, 0);
+
 out:
 	kunmap(page);
 	put_page(page);
-- 
2.20.1

