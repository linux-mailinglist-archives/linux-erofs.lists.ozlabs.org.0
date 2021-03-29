Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC9F34CD76
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Mar 2021 12:00:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F87PF0rqTz302T
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Mar 2021 21:00:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1617012033;
	bh=ZnpwQjRYpRGdNv9pRtt6m4LvyqJtcIcV9fxNnrsJWAU=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=S8Xi2skinEki8W5yr8OO9O/RlY4ik1M2ttFogHMosfSaUCZDbEf2kTnCGNcySHOFZ
	 Lfcr+Sl0GKTU3QCGlyv6RfqAVrdhYYR3vBq/3tPq9htu8v2vAwlYvD2O9Y2qTGdshS
	 g0mC216Tsy0flwZRqjSRSxSfJWxqm16J1Q+n6fB4F1tudPNDmW04jAYOJe6Hx9yJYj
	 jhcLvu8UTZmRPjnXQjGFBwtcHeimecpovkuuhrvqM19t8PxeieFf8Qst9sBnVntip6
	 rTVwNuec8xjlPjQzwQFiJdDLT2rAw/ku/bbsuJ8McWHN9SqdZwKutGGdC1mHZE3mCP
	 hQqjDk+q9Cw2w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.82; helo=sonic306-19.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=sfHdsvP6; dkim-atps=neutral
Received: from sonic306-19.consmr.mail.gq1.yahoo.com
 (sonic306-19.consmr.mail.gq1.yahoo.com [98.137.68.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F87P96rWyz2yj0
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Mar 2021 21:00:27 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1617012023; bh=7bwWaAk1v9uxCmeZmebmn5S6KvEQ/F4B4UErx2CZoFz=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=g8EFXCcKWvOVzikOKrURj6oAUImPnN58g+QDDB/AYw2gjfxkZQMRIgPy6EaW8BmVAbXgGS6/TiuM6rrFV7LvaR8b1BsX4ab/7bb55ATYLr5RMRK2sxjp0zPJ01KNsjzL4yC5/XawCpMKBGUCrb/os4CRamwSHQZALrQwaYHrorkK5GbhrvrARXNFKbN8ZK8sh6kA2Uiw6+5evv+i0nkdJ3Yxn8s8w42H804xoYykmhpu4CTMy7qbIdVUyWsbhNOXp65vNRvbZKzFWGVA2REV1+p+dM5fzYreGlLVeaUztXTP5lqqlPYQ/O1T+VLRXr8jhvbOnNx7Z1lRe2IQxLtCDw==
X-YMail-OSG: Ftdf1T4VM1kUpZwBXWsYWpXHbXR4iVxKvENezNCCv9DFVYAgK3E2SeYCBhryj1n
 ehvNJZ0oWy.R3Ttd3MH5DQDWVAkfafYw0HLlexR6Inf_5icJYm12h8uNrokldxB9bOqZmLyODe4H
 r6Z_r1Ybv1VsgHvloDtz4kLlM1r5hDVwkj2eLe9ne5aReysXm9.AYzzmqHSvsLVxlBtbTV.aXcti
 bWFQxaT72.NSrL6EUA5Nj2sbmVQPnc6P26_3WRMSEugX1jWh0fmKTvnnBxaBLGMNOISe4GR.wUou
 rR2ZlZm8jnj0_npBVsN6UDM05jbAhIprzDv7bzmWEYUPV81QN2HSwiW2JFy2eGuZfY.PACbsssEU
 G6buAqrQwPwH1nc2aC1AzgGvE7M8T4wbkrCIFzsaAzq4SMJ9ujpzXw2ZtTVc2wKQnO1MuAfKRJpT
 ZwBhVWg87eWBPuWK2IU.NG7u06_lmIeviAAVpapklbndFNEX1mJBTC5xn.x13szJR01OciSofoy5
 ef0LihGybeuZ9tzE.JFZZ_sH79otD99.Jq.YLxt4B._m4ev9H08H0wfqnQaqJhJL56pLYwr0CTnh
 sAVGZkmxmaQ_lkFuseuRgwS3AN_.Nt11lMnw2LBUqXJV4lFRtBcULu7Q9pb27XhWXMCJdjIVzZdu
 UrY9LHthEY0DHKXGL5Z4wAahmqW2hoikhxyPmWKWsdKLnOQi2GCcuwrJ.RTnCgiBuwTH2I8UntEX
 c8bPPIsub9l3VPdRAGxFPPrhecXMtuyAFLrbLJAiQOxPhnfFRH6DN3CSL7kW.V4u_vxa67n.r3uc
 4X_RA6OSfCN_41FK3e0iB1xrw6iTpQND2s6XQB5ts6EngSlGchhEZMr9J6HBUZiy.UtOl1WAODJq
 ekcMi2HZk5XnCw4Yzbyo3l_KE39KHUXk1Eo93xT4Dxjmng77QaFXe5s.frDT0HWUwYEYPrwCmiZz
 HTz54qrZb0ErV4o72qK1_n1DnOPwjmSyqKf643lf7T.i6J9LxxKyKi4DjW8iV5i..qtTyHFmSQ0A
 S5KIIS4MeoAOUprfteU8tngipoTH4zABtu2Oa.yVrEaMpP.7i2y2fQUaBBOQXUKRQiHG2AhG.vc7
 5mG0LUMuAx.07E4om6ubn.nU8aY8B_8pqxGZZ2i1cHFEChCv80AYtPXBT5h7FfgCaAPI39GHp.v0
 bwchbQQuo8HhNjXC1iOb83DQXShMYmg06B4ytvVlvvuixjNt8MZmPUc4nBXWe7aDUuaxLtxR78jW
 GAgwMQ3HkNr6vmYnFZRYtjWcFWnkJ3AYP7R9S1we7tSLwKy_4RsHzTUtRUjSoprj7ePgExT9fNLX
 WYBTrIvmxoYXVFCaErLiMb_RuV5t4pVgLrQrF6ivEizxFK.4Rh_Z2i_hwzwGF9fpZhyg2.JS6Ily
 Tvaf1.co9t5cBqG2BBYj3dWexmtwcWW2vDbZbqXz3Xo3ZRk4MS.HPhtuXGUr3xgrVTQUKXRAGUpJ
 LuRaCKRD2hEp_LA7TlfTjQx5awnic.HFyG5hUl3BjMUHTkE_Md9HLvXc9CRjKiMUpM8nepn6ZW3.
 kflDvgSuteMgLl8vLcGpjzkI8zBbsjCIC56eVOkMA2Uf56TWHF2I8l.BA3rgtbst5d_hv9ARyN2O
 bN3gB_mJkAzCzfdjbNsaMpab6oMPcU5MhHdt3AwQ_KHP0lGxSrUk1vgE88lmSPN_CYwMTFqTsP5.
 ossLvR9atAP8QRWiqn5_eLUpA2ti60X8V5NW3dEywzAn56GgATRgNFjJHEdGbNvM_2SAY.Kq8pHq
 lvDYHfe667_7e6D6RVBISHmod4gD3zQQy0AH.222oLwg87as_Bpjtty8lmWEDGAyyfL1mq6U8nFH
 F790VDrceS9du83Fmfr8A73uns06oqHJN1UxJfR1YQqmswcqbzxyAUZWXCWK_vjTWH41qM2hfj2c
 iKxU2oM.H6CUuJEZk23_4rXd8g9zq38fKE1SmPWlsDVseWk6dEEbLuapoRKKH4mC3Uk2yZT5i2Dp
 MgG2HJLaMjy7gyk9pOkvzW5w4Col8htQSYAdrPu5dywbiKxV7eD1LoaAtHfhcfRUzOCqxvlLoHDn
 695rg5Wom3SIev6iDOks7uXo8WbKUAsQFJSzikJuyy_I6oUJLEtiYjmPDmoxGERCe.zRQD3LuexI
 5I9T9JExAOnhmfaVifAhBtLNk4_y78DATaenxBvPcRac_CLOpJfh6af3dubYkT3Cmrx2w1PGb9sg
 OK0eqK2ItsneQZrSpMEgeI3JvcjHrwARTMCuz9F07vgKURZ6V70PU64PoQfpcYjBZ3BNw.k7wybY
 VNHXFU3lgwOzx1gVTRJQsi4lnHHamJhsehobTwCNosMljXkPZK8lKtyqhf6PVnBlc0f1itG0OXYv
 ABp3u6sSroicMFJXMsHH1cAh2fTn0iQRWp9KJcuvNvwMMMyOnBI.pPwxD587VD.zEgPAy10pzcH9
 ntIYkJX2PEnwttIBYcDuf.zTyTBz2pmBZIb.R0cRt2lGTvghpksVmJcuHmcLB_YNpTTP_WOE12XV
 gCNhpt396DLrkyAqM_92zcJP4CnTV.oYUJbXd1vAHaj7Z9qpqrVTgTPum2wlTxeyGjZzxE1bqz1g
 SK7xFkDXnQQOkWP0ti.ptjiboLdRI0ZmxtjddG.4OWOIdMZtf3sn15c6ZgsBu_GuylK5.mBSo1cM
 tBeAC.nSLqMdrOLMlUUCIOg--
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.gq1.yahoo.com with HTTP; Mon, 29 Mar 2021 10:00:23 +0000
Received: by kubenode506.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID 1f87e113dc0e8fbabe1892b4a6b18c18; 
 Mon, 29 Mar 2021 10:00:21 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH v3 4/4] erofs: add on-disk compression configurations
Date: Mon, 29 Mar 2021 18:00:12 +0800
Message-Id: <20210329100012.12980-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210329012308.28743-5-hsiangkao@aol.com>
References: <20210329012308.28743-5-hsiangkao@aol.com>
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

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
changes since v2:
 - move upwords print messages since even using a new extra line with
   indentation, they still exceed 80 char;
 - introduce EROFS_SB_EXTSLOT_SIZE but remaining 128 since
   sizeof(struct erofs_super_block) could be changed in the future.

 fs/erofs/decompressor.c |   2 +-
 fs/erofs/erofs_fs.h     |  16 +++--
 fs/erofs/internal.h     |   5 +-
 fs/erofs/super.c        | 141 +++++++++++++++++++++++++++++++++++++++-
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
index 700597e9c810..17bc0b5f117d 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -18,15 +18,18 @@
  * be incompatible with this kernel version.
  */
 #define EROFS_FEATURE_INCOMPAT_LZ4_0PADDING	0x00000001
+#define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
 #define EROFS_ALL_FEATURE_INCOMPAT		EROFS_FEATURE_INCOMPAT_LZ4_0PADDING
 
-/* 128-byte erofs on-disk super block */
+#define EROFS_SB_EXTSLOT_SIZE	16
+
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
@@ -39,8 +42,12 @@ struct erofs_super_block {
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
 
@@ -199,6 +206,7 @@ enum {
 	Z_EROFS_COMPRESSION_LZ4	= 0,
 	Z_EROFS_COMPRESSION_MAX
 };
+#define Z_EROFS_ALL_COMPR_ALGS		(1 << (Z_EROFS_COMPRESSION_MAX - 1))
 
 /* 14 bytes (+ length field = 16 bytes) */
 struct z_erofs_lz4_cfgs {
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index b02fc64fcece..60063bbbb91a 100644
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
@@ -452,7 +455,7 @@ static inline int z_erofs_load_lz4_config(struct super_block *sb,
 				  struct erofs_super_block *dsb,
 				  struct z_erofs_lz4_cfgs *lz4, int len)
 {
-	if (lz4 || dsb->lz4_max_distance) {
+	if (lz4 || dsb->u1.lz4_max_distance) {
 		erofs_err(sb, "lz4 algorithm isn't enabled");
 		return -EINVAL;
 	}
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 1ca8da3f2125..ec9e5fb073b5 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -122,6 +122,136 @@ static bool check_layout_compatibility(struct super_block *sb,
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
+		erofs_err(sb, "try to load compressed fs with unsupported algorithms %x",
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
+		erofs_err(sb, "try to load compressed fs when compression is disabled");
+		return -EINVAL;
+	}
+	return 0;
+}
+#endif
+
 static int erofs_read_superblock(struct super_block *sb)
 {
 	struct erofs_sb_info *sbi;
@@ -166,6 +296,12 @@ static int erofs_read_superblock(struct super_block *sb)
 	if (!check_layout_compatibility(sb, dsb))
 		goto out;
 
+	sbi->sb_size = 128 + dsb->sb_extslots * EROFS_SB_EXTSLOT_SIZE;
+	if (sbi->sb_size > EROFS_BLKSIZ) {
+		erofs_err(sb, "invalid sb_extslots %u (more than a fs block)",
+			  sbi->sb_size);
+		goto out;
+	}
 	sbi->blocks = le32_to_cpu(dsb->blocks);
 	sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
 #ifdef CONFIG_EROFS_FS_XATTR
@@ -189,7 +325,10 @@ static int erofs_read_superblock(struct super_block *sb)
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

