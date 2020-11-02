Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B91FD2A2ECB
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Nov 2020 16:57:35 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CPyH1298nzDqS0
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Nov 2020 02:57:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1604332653;
	bh=vNRjq2rI/L2m5Z0oaVP31mrEII2GeZzOsuPMKRWOt94=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=a1sx/Bq/HGtsLJuV3wGnuQG070C9CUi+phSHFfkngp9CHf7gvH5uoH93HiWljXxv7
	 FPnTG5qPs0EmQl36+z530yhHFtbXeCYwiwZI4Jp7lUTjAD7pUMDHZ5P2i8SsaFsBMS
	 pvzGi43HSu39iV5d6k3LQvt8t5Gl4W37S/aKKemcBDF/LKgZ9hQhw8XMze3KHXjBGv
	 k67FNy2vJOOBxjZbBkWTQHqD8WgJRSgwVn5kNSslY1U4in+dS+Yo+2YP7QZ5kQ+v1n
	 9tkg9zivTKkOvgKzQn4wJrHeFhSuBrqDCLh6xGjku/fmw1OKAU3RI4ko+AoiCAASwi
	 Ii9YVu7uukRGw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.83; helo=sonic305-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=FVyTYRdq; dkim-atps=neutral
Received: from sonic305-20.consmr.mail.gq1.yahoo.com
 (sonic305-20.consmr.mail.gq1.yahoo.com [98.137.64.83])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CPyGQ1dpMzDqSc
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Nov 2020 02:57:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1604332615; bh=CHeTvECpZ1ZRAlwAHvHD+5wXOZU7MpdL7s4xBDCNNPY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=FVyTYRdq+eJue99Cn82qWmrEikfCrtPKBCM4SbE7rx8WAMTarrYcjIIQOsApBmB4Uk5rVs8h4Wj7r4DlLNN0dcfIZ68MF6N2r0G9dMIRWvfCO5UktTgQNeR0jIfp9Xafe65tsLH19XYTj66doJv7vDg4D0jy9Rsx6uXQo2PWTeolXOMoygZQZmtD62d8JK+Nv1rAdMJcbz1OKAlXwv3l6n7NSlGM2q+7pNZV5D82JIs131DX6LSLSjCxvX7m9OKMcjlUOeqL5el+nxXo958sPPNjLFNos0IPzCMZu0tNStO3D/10b4cdg3xfDefTFYOj00GsKvT4qB732JVZkly9xA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1604332615; bh=cjVY9C1x14p7eiSjKMUCqLExguCdxohJrJa5sq10hZI=;
 h=From:To:Subject:Date;
 b=ACOjflrZGEVdZJtFd6oqs3LTq/639vPb0uznkMm01uWxAzwEvQHPoPqn4/VRGkFmhgqt4xsljGPVuxYLX5mIgqjrXGCItfoy/Kds9SEK0ivjV/E+vb6w32C+49c3PVEAFIR/hHBTMa3iAPBO2zJ/9pa/spy4pjvDKhN65JDqEAva/95bWS9PVhYPA9hydmyldbGE565fUNHCTxIeiCV3R+moi/YSBY8dyf2C6nEjwhl+96+4S/gu7uxCBNdlIzRenP/N1Dhv+dzIJmbvJ7DJMtGP4DfU+Cef5ocyT99xEScRpPEgj7oqOQyOo0xviyPe6IGThWHzkvzgfdIpKX+Hcg==
X-YMail-OSG: Q11Zbl8VM1l1hriQZR5ocCn.Erv8mUUWa2akTRBxVKkTJEwhHe4WZutlXh3DqFr
 6._fK3mQi68kVJ.1o54dF5A_JIpkX1ZiXfWg0s6Jokc4wEyxKvDWGdepj3e64UujJPL7z7U.J_N5
 OX7nmTlnhzP0vLmnU03Imyq1gJB0Or4M7.EjrUSamduaMzsRcmhFIU7R8sz4VdczlkcfrPKYqi0a
 dQbQWX5mz4XbHQQo1qu4i6AVaIkkUMO99_MHT0GA6j3jlzIEyqZ8C9M0E8sXu5fRIembSSr.Dj1j
 LA6B0pwksuBO_atT6XlQclqYruWiBrLIO8sMJVWZ8bSv7uqASOv7hX4hvkSN3umOdMymVjffqt.j
 oJmsyUDC5xhlY2NLKsfri_OSLxUme7yLWGVETSYoPt_rx7xK9SvpVhwjVVPUHYIyrNC.BIArHI7b
 TkBPhf78I4P6L67A9cO5VyzTj9x.iVtDrwte7XT6E6HEfHP0dEHioybtWOZ8fU.1RKavZMlcrL_Q
 phBlxI7Nph6XB2JK2AdMhiDUDKkI1pZTfvwicCXa6bL9v40AMstumoP3Fm.2wn6xJU7Q15YlCKoR
 dvENZCZfgEE4CF9TkL2n1OPG1nmckCe_uHY2lHSPNObdwSYMI7PmvVt9GKagu6OtrMXYelD0I6Gx
 nLMe.88wuzG0iPOsCQE9hUomUJZSa6qWC8gsX2wyAup4RCTJdHHFc9jS8fCRR4mga2r7Rm2Cy8_G
 TVCgMQ2Op9tXmCNPtyOLbN3a_QoZqkjKI_ELlQOpmv6Z0XZxI8jNhWYrZX2DmZP5MbsiprELTRB6
 ICly4MOXwcK8xHNA6ZbPiQo4EfTkUtCjaNj._YN4wSF7Alpk.WvTk6TeNx0gQHALaVzv8qzX1Yqj
 mwC1xYf3a7OoV2Q5N_fIxIAD94w.INuchqP543y0hwzHKzx_kk8IwnodDHpV9KUdL23drZrfnUR_
 SzBirmklsyGsG9veR9_IkyBtKj7twtPKnFBXj1Z8aKc6ZCvPeZ5h58L1TEaV8uT93NiHtR8cehu8
 RQoYFO_EzMURWVQpirf63U0cV6kJWfpqrtVlL56RbVBCLMH99t2s_eR_KEjB2hzzrGzjxr4aMmoO
 CUBm6E7pQgThdc73yHnoCqL9YU2lell5qKejQ_NkaCxYCdmhR03.1Ay97NTSOA0f4gnNAZ1lSmjs
 DTyPSkfVBKlE7mnft0KHKyoBLT4U6MIvGOYWTcCkhPxdMPXng9T2Mt4mTblNyO8p7a7ISbzheelQ
 oGcpRsdkwreuj.F2kdza6unfwDQpIP8Q_ujmpeWoKgdxtQIIvCBKtiBUdpOiwj2gpKuRyIkYjuzp
 77zwKMu5AuzXNfxT7ysuV07J7yufWcMAewDn3W0B_31WxcIe_OxwGnFtxbpLIUZ6QyJgzWG_H2KS
 dgFwIcPJUWoEoSqTQzKSLH7fa4T9WdS1JnqKvYWDWaWqmkOq1ix0_MMqeSRYdXIJB9ems.SAdFFS
 XuPyX0JeLx0bFoRZUYYAbPK0gAc.0X8ZTAI525vLBnEUpHwq2xFBiYdoJCgwSvpzIo69SQQRvTK.
 a2HdlBkpTSdie2TeF7PZTX.8RpEJ1FI76sqxr_ZxuCrn6UyGl8fSvHuFnzcytzsngmBmxhx1_cc3
 TfEHx.uSlOiFg5bx_rnBJ3VJFat2IoeGbq1u8r84I1tHd4yj78.sCP6Ntxr6LjiIMFN6ltp2TTtv
 1sA5roSjms06WqETCu5GdsBhc91qVcQsAj78k8tzmMRsgBTxD.r0a6JAihNoDiloNYgDl1Nh2.R6
 nsUVj8zkiZkhCseE_ZkaDphYsjx8fbkMoBynVOgjJo6CR4TCA88uYYmjhXbX6LiffkijIKC951wc
 lyhQu9Zt22r20z3Jv2fbfcifMPBJEqaAbrj4NlSXNf6nzk86Kw5vRBFjiIjJ4TLd.F36fu2rtaG0
 vV2e5js3erbMh93hnZp7ZPJ5tSrd_hm_lxgW4YCp2.comLBn1aDMCuICZ_nQATk6cdRv.xrgu9td
 w28ZNWEtEg20eKvNfDm.nqks.Z.sfNv51x9rUf.IE4mCv9_id6be4xcMNRdjWJvyVVs_Gwi_iM4l
 7RCq350mAWi.PVGfh3F81gSmPCvlJKXueJb.tDQx3zVcP6HoAmQzf.JQ80Tas0nUFtHmhf8FOx3l
 UvWEatcW.ZhTWkllB8mXnmwOogxbLv8IX85bGiDplKuCYCsX7YJROlmWR0zEBAdxYPwtAZ9vsw5Y
 y5eKkMmDCl42LgVu7mltGwk8mQXJ.ehQ5hgMhLNZ.N1mKl6OZ04qWJlgyeQVWISewNu3MG_J4lL0
 x8gSeJOPxJNiRWL407_rbH83d1O_HjKOoe.4aSinaTAgwS8hKw4JkI2pWwvS5s2bP5UNjQoFCn_g
 bufQz3LACgH5r_LMHeHxsQdU.WA6EQa4dG_ta6GUXfAQnbTZYWl0ryMiltuVVGAgGHYL3b3rTpaG
 UZrKYMWqv7hzoMG6ZP8dyvs0HkDqaaZb6yNnUk3_9ly..5WICxe804OyjSPsVxxs7UmKFn2h48vT
 1vUYM8DoEvmXMh0ubGUOw60G20R.u9SSmc1X2JwjxIz25mGDxcotSV6SLGWtFs9Tkf.6OXQcVDA8
 3t8e99r_XF9EqXV1uoebgECWgt6a01a7t0OcJvdmbC4PI9Hs6NgxRZh_dZIfgDoyD.tMUmlDjn6U
 xC5GagpmtQfOl8b2UWTWehVMe.Yw-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.gq1.yahoo.com with HTTP; Mon, 2 Nov 2020 15:56:55 +0000
Received: by smtp404.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 0de93bd81f6e7581799539af1246db07; 
 Mon, 02 Nov 2020 15:56:51 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v3 05/12] erofs-utils: fuse: kill sbk
Date: Mon,  2 Nov 2020 23:55:51 +0800
Message-Id: <20201102155558.1995-6-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201102155558.1995-1-hsiangkao@aol.com>
References: <20201102155558.1995-1-hsiangkao@aol.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

(will fold into the original patch.)

Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/init.c              | 78 +++++++++++++++++++---------------------
 fuse/init.h              |  2 +-
 fuse/main.c              |  2 +-
 include/erofs/internal.h |  7 ++++
 4 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/fuse/init.c b/fuse/init.c
index 09e7b1210006..f3f7f9750468 100644
--- a/fuse/init.c
+++ b/fuse/init.c
@@ -18,8 +18,6 @@
 
 
 struct erofs_super_block super;
-/* XXX: sbk needs to be replaced with sbi */
-static struct erofs_super_block *sbk = &super;
 struct erofs_sb_info sbi;
 
 static bool check_layout_compatibility(struct erofs_sb_info *sbi,
@@ -38,65 +36,61 @@ static bool check_layout_compatibility(struct erofs_sb_info *sbi,
 	return true;
 }
 
-int erofs_init_super(void)
+int erofs_read_superblock(void)
 {
+	char data[EROFS_BLKSIZ];
+	struct erofs_super_block *dsb;
+	unsigned int blkszbits;
 	int ret;
-	char buf[EROFS_BLKSIZ];
-	struct erofs_super_block *sb;
 
-	memset(buf, 0, sizeof(buf));
-	ret = blk_read(buf, 0, 1);
+	ret = blk_read(data, 0, 1);
 	if (ret < 0) {
-		erofs_err("Failed to read super block ret=%d", ret);
-		return -EINVAL;
+		erofs_err("cannot read erofs superblock: %d", ret);
+		return -EIO;
 	}
+	dsb = (struct erofs_super_block *)(data + EROFS_SUPER_OFFSET);
 
-	sb = (struct erofs_super_block *) (buf + BOOT_SECTOR_SIZE);
-	sbk->magic = le32_to_cpu(sb->magic);
-	if (sbk->magic != EROFS_SUPER_MAGIC_V1) {
-		erofs_err("EROFS magic[0x%X] NOT matched to [0x%X] ",
-			  super.magic, EROFS_SUPER_MAGIC_V1);
-		return -EINVAL;
+	ret = -EINVAL;
+	if (le32_to_cpu(dsb->magic) != EROFS_SUPER_MAGIC_V1) {
+		erofs_err("cannot find valid erofs superblock");
+		return ret;
 	}
 
-	if (!check_layout_compatibility(&sbi, sb))
-		return -EINVAL;
+	sbi.feature_compat = le32_to_cpu(dsb->feature_compat);
 
-	sbk->checksum = le32_to_cpu(sb->checksum);
-	sbk->feature_compat = le32_to_cpu(sb->feature_compat);
-	sbk->blkszbits = sb->blkszbits;
+	blkszbits = dsb->blkszbits;
+	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
+	if (blkszbits != LOG_BLOCK_SIZE) {
+		erofs_err("blksize %u isn't supported on this platform",
+			  1 << blkszbits);
+		return ret;
+	}
+
+	if (!check_layout_compatibility(&sbi, dsb))
+		return ret;
 
-	sbk->inos = le64_to_cpu(sb->inos);
-	sbk->build_time = le64_to_cpu(sb->build_time);
-	sbk->build_time_nsec = le32_to_cpu(sb->build_time_nsec);
-	sbk->blocks = le32_to_cpu(sb->blocks);
-	sbk->meta_blkaddr = le32_to_cpu(sb->meta_blkaddr);
-	sbi.meta_blkaddr = sbk->meta_blkaddr;
-	sbk->xattr_blkaddr = le32_to_cpu(sb->xattr_blkaddr);
+	sbi.blocks = le32_to_cpu(dsb->blocks);
+	sbi.meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
+	sbi.xattr_blkaddr = le32_to_cpu(dsb->xattr_blkaddr);
 	sbi.islotbits = EROFS_ISLOTBITS;
-	memcpy(sbk->uuid, sb->uuid, 16);
-	memcpy(sbk->volume_name, sb->volume_name, 16);
-	sbk->root_nid = le16_to_cpu(sb->root_nid);
-
-	erofs_dump("%-15s:0x%X\n", STR(magic), SUPER_MEM(magic));
-	erofs_dump("%-15s:0x%X\n", STR(feature_incompat), sbi.feature_incompat);
-	erofs_dump("%-15s:0x%X\n", STR(feature_compat), SUPER_MEM(feature_compat));
-	erofs_dump("%-15s:%u\n",   STR(blkszbits), SUPER_MEM(blkszbits));
-	erofs_dump("%-15s:%u\n",   STR(root_nid), SUPER_MEM(root_nid));
-	erofs_dump("%-15s:%llu\n",  STR(inos), (unsigned long long)SUPER_MEM(inos));
-	erofs_dump("%-15s:%d\n",   STR(meta_blkaddr), SUPER_MEM(meta_blkaddr));
-	erofs_dump("%-15s:%d\n",   STR(xattr_blkaddr), SUPER_MEM(xattr_blkaddr));
+	sbi.root_nid = le16_to_cpu(dsb->root_nid);
+	sbi.inos = le64_to_cpu(dsb->inos);
+
+	sbi.build_time = le64_to_cpu(dsb->build_time);
+	sbi.build_time_nsec = le32_to_cpu(dsb->build_time_nsec);
+
+	memcpy(&sbi.uuid, dsb->uuid, sizeof(dsb->uuid));
 	return 0;
 }
 
 erofs_nid_t erofs_get_root_nid(void)
 {
-	return sbk->root_nid;
+	return sbi.root_nid;
 }
 
 erofs_nid_t addr2nid(erofs_off_t addr)
 {
-	erofs_nid_t offset = (erofs_nid_t)sbk->meta_blkaddr * EROFS_BLKSIZ;
+	erofs_nid_t offset = (erofs_nid_t)sbi.meta_blkaddr * EROFS_BLKSIZ;
 
 	DBG_BUGON(!IS_SLOT_ALIGN(addr));
 	return (addr - offset) >> EROFS_ISLOTBITS;
@@ -104,7 +98,7 @@ erofs_nid_t addr2nid(erofs_off_t addr)
 
 erofs_off_t nid2addr(erofs_nid_t nid)
 {
-	erofs_off_t offset = (erofs_off_t)sbk->meta_blkaddr * EROFS_BLKSIZ;
+	erofs_off_t offset = (erofs_off_t)sbi.meta_blkaddr * EROFS_BLKSIZ;
 
 	return (nid <<  EROFS_ISLOTBITS) + offset;
 }
diff --git a/fuse/init.h b/fuse/init.h
index 34085f2b548d..062cd69f6e4d 100644
--- a/fuse/init.h
+++ b/fuse/init.h
@@ -13,7 +13,7 @@
 
 #define BOOT_SECTOR_SIZE	0x400
 
-int erofs_init_super(void);
+int erofs_read_superblock(void);
 erofs_nid_t erofs_get_root_nid(void);
 erofs_off_t nid2addr(erofs_nid_t nid);
 erofs_nid_t addr2nid(erofs_off_t addr);
diff --git a/fuse/main.c b/fuse/main.c
index 26f49f6fc299..fed4488081d8 100644
--- a/fuse/main.c
+++ b/fuse/main.c
@@ -147,7 +147,7 @@ int main(int argc, char *argv[])
 		goto exit;
 	}
 
-	if (erofs_init_super()) {
+	if (erofs_read_superblock()) {
 		fprintf(stderr, "Failed to read erofs super block\n");
 		goto exit_dev;
 	}
diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 54038071bf84..306005dea2a7 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -63,6 +63,8 @@ typedef u32 erofs_blk_t;
 struct erofs_buffer_head;
 
 struct erofs_sb_info {
+	u64 blocks;
+
 	erofs_blk_t meta_blkaddr;
 	erofs_blk_t xattr_blkaddr;
 
@@ -73,6 +75,11 @@ struct erofs_sb_info {
 
 	unsigned char islotbits;
 
+	/* what we really care is nid, rather than ino.. */
+	erofs_nid_t root_nid;
+	/* used for statfs, f_files - f_favail */
+	u64 inos;
+
 	u8 uuid[16];
 };
 
-- 
2.24.0

