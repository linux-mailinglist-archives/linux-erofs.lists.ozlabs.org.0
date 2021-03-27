Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D1934B41A
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Mar 2021 04:50:10 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6lGm1sHPz3c18
	for <lists+linux-erofs@lfdr.de>; Sat, 27 Mar 2021 14:50:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1616817008;
	bh=1j4zk8i3/AwHRnlRrIRqBMNgxEbpt8VtWgFLrPCvvL8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=n85SeMlwnzTFO0Ieb6jA7ccA7uAz4V7a26YcBAnUM3IYS52gx4MQf6gN9WoE1QAxW
	 QIvcOARaDlAbOk+NdvQ+hhoV1nyOAYiGVCYldtNm57FsxQD53PUJEZjxopuigJqdn1
	 2U2FFDTk0MVmSHX5T6WGitpgr+pDJ2E+SjIeVrG9wYZJrQheDJKcfUqR9LfxA8gNMT
	 6JaPXIsjOlrbVNsE0C/Wik2eJ/FXyo0glEhoATdxFClnipX7b+aGQnvyWu7Etla6DV
	 kxJhD6X4d3J81ZVTKrND6bdHc03AmOWUFpO1q31OHyP8KCX805PrOzL7+yxCX4/hNL
	 IB8jYgjVOTnnQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.84; helo=sonic306-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=M1LYkdJt; dkim-atps=neutral
Received: from sonic306-21.consmr.mail.gq1.yahoo.com
 (sonic306-21.consmr.mail.gq1.yahoo.com [98.137.68.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6lGh3mM2z3bxG
 for <linux-erofs@lists.ozlabs.org>; Sat, 27 Mar 2021 14:50:04 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1616817001; bh=gUwjEVgYQoFxHmKr0tHJ/eTDBDYtICppxwaeEVySpMg=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=Nm0p6UWHoqqkNP3CLxrqVNvzukAtOBlJ3VMAKrj9ixxQXwuvyFBwME+ZPFDSGThyBqwH+mCPgob4Izk1cYcpEU2o8yZgA1/hufSSyQyeNd5V9K6EchP66dOY9nJ6CVDiPI2SwQ3y9EZI+rF3Ural23XNkAE5DB0Ec+31w990PFMXABG56GfkH9FA11Y0sS+RHCJEYlAMrrZxF2aNjmSxvk1JkefxBKhfTMgmen9yxw8qg6K5hBqePl+R+7FNxpC7XbyBlS4EdDQ+BAtvocLG19yc72ed60ycymN9kVqm7sadAW8/dsuW5U0A4DXHGym2i7Jbrar66umFi8qMtM4P2A==
X-YMail-OSG: 901yY7UVM1leEfl16rz0AanV8psklk8gT3qVhg37BwLVfmokj.aeD0n710JXgSC
 sOOI420CuNdqAex58hdQLBpoNJvYQJhweGhbNGs.1_18dUXUHWGUwLbw7mLTHJBEVDXkkLkdt_EH
 cgGWDn4zhgm4lVCx4YhBp6WnwumC9mMKjcZDXOsmr0kKq.sGCV1DdQmX1sBauJiwjJq4.JA2VNkH
 TGf2f7.KfavBoVebj2JQlSwWnCmc5ExibvXuarFKFoVADDrjhQkNw3wXCONFBFkdaKe1qOx5MNjs
 dhKtlADs719lhnlwbVpj0iaEmtGr4zas5PZ5p6AFdXXAk9eZgV9jnVpX7xe39iz3xPITdxiaKJuE
 qUo9A5h1fHEMCTDsaAf4GqeZVQXOzbeeuci.6JTju5gEq1hhCAH6UCHhS0gTOc2LzZLwLq97.E4b
 sTXGx_UpqGEs2dw.e6vQ8fIYjE2iHUJCPtm0e4J37rxRDHKFjL7BE.PnIegcOcl2MBJWgYUwFS8S
 aTV6BybPBY8wc0RGRIg9u8X_bu_WzhIZbWI_fgFgiPp37VZwAfL3CLH1h0E3Pqocq3rSXKUc2GJH
 IkEF2YQ5HvnloFDkhP6ZdjayJJ4CvXx3prFbnD91VgC_kyn2Z4loqIed8qLSK2mSM.8tgEGx1qwZ
 gAbSMliJsbe0pksiCTfiGetHujJsbIyUZ2gdCVlbTWlKR27VXTH_m9lrwk9jfcZJmRYfqdhTUZOK
 GMuQ6yoP6GdoihK3e5hvSa8Pggvuu6tx0NXEJF.U80U8.hHC9EhRy8grS9QD1D9JVMUEPNLoeyxL
 EH6Hy5Merm5bIE7BJMP6pPVmcTMGFsvIjC05EoD9sJqPgIztAY.4RfY7fhyon3_9MzAzIYXCgkjh
 JQml9.Wuwmflj5GkOQG6m73D8UIMQ0kogCNbhUCJy1EwBSXrDUXdQRRL1ghyE164MmhG4prx0__P
 fgxSvrKu28Zu5N43Ilz1FK9WHO36Uba8IxJ19I5jtYRm3frB_g62XqO9hQZkZ1qH4yRR8rC7ZMv_
 By22Nuim.orboZvjFQsJsWkKHBWlSyIpSXQZLfcpaIECNI97eKK9n83EsknSyMjZAcccQbYoOLpH
 881ZW6v4Nfdv0k21dmlal.OnF8dctqSP.I0.SWm_MkM2HHT8Qtuk9ig7HxDOVl5ESOxE0TQwZooS
 k4wbTal2acq31o6jkWSJ70QiolOdIi_CRvQoHwrlBcW9i1kFnz1B2__md7Db9L_y2iVxo927DVDA
 fs9PyW3A_Nw_Zcdz2Q77g_cha9JQiIodBfcWHGTREdIV2IVlzDhU..rCKTVgcZCuzWoI4QFyO2QI
 oqgkqG42xOBR58zgN4mqGLhMM1zd4wHRCEU7f3uI8VGZJTwlw3yw_jpX0UmyOtXQ.OO_DQUvRh1G
 lnzGHraSd5KSdJ5dofnJQyj9mubXqOOXN9Mitzs8D0S7vy2aDiS.EsN9oPAYznSItwW7M_Ucmi7g
 wvJofN_JNQ_Ca5ypKwnRBh2Cyj11wRgNK_E1b3RjjOwR.VOclIwRerE4WhchMXvNBuK6nJqs9U96
 _Fiv2IKU9U7kKEher4qMzwO5I0KsvOIFUAAFITWDGgrvgeVJGzApfdTfxoRIdpQedDymtBJzBQkt
 y928UDIjh1TxL37._X.iMhs6D4Hwbo43f335DGl2cADpdOg_wsfYCB3xvTDm2OPZ2AGyyvhpQ5N4
 piCQMJ0p0PC4BhasvnjRMn7jHQP6ztWoEkBXEt9Zqr1Ed.zkpOZxQl4GU3kNz6baZGGw.LD9ZMeV
 MYEJm.kTuAVa_0JhOZeF08pkwXp9ha54VEBRz5Km52u8za2a51qQDY43TnTrbFHr.6jweT3A0nn8
 XRrzEF2tx71jn_kARinkdWKiKF_I_zIKkD1A8UmsSapgljcLBLI.TYEhdBoy6yRYrohCSAxDoPcQ
 dJGknKTmuHX7Qaz7qXfj6JrbPVavfw1trFa1mUzc2YJ3iYptoBkOtV6ldxSCL_tuH7l4E92aLGpX
 r4UA7VPi2fK22TdJFvXBRa_o51nQyRZkVr5k_ZWilz6C8JtEZUPJYSA.Uj4f8sIn6T69KL7APH9_
 tzvEaKRlz_OW4RDvq1im7y7lrnr8cDTw1zBcqXRw.DYDf8TgPVnrZlPYLLKNQtTYPtUdWN.u_Spl
 qoCNodSYE7ScQIH3DXVwGFtxXs1p2zy89pbpfH1AtYRkuC1O3JaSze8VDABmhdeFjEZQU5koCn.Z
 hnCFJT_9L1.h9vtJHl.rbG7rsYSewlFS5Nhe_P4TWWI1XIfWp7f_rvVJclrXouDMaApwrZWYs23k
 XdFCYIYk.Ypj7D4lRRbuIbhcFmagBvusuFkBUp59jEj1TkJh6WtoxS2NZwn2BrkRHz9doiNdR5gV
 jyXs3mQl.VUd8nHom7zSVPQFk2Bhr8L4VUQtPLQyX06b4TwyNQA1wpr5TX8erDoNB43GfFKwQfPm
 WTZ4SAcftwcDkP7EYUEgaWHG9NGY9bEFVrheAm0gFpd7dXRKPhfdB0m70pBhvf8k_Mz_nE.nLogk
 Hat.l6CmwLeYB87UhXFWA9Hh3L0rmaWf92M_BOFxacoIGBbVE9n4EwouZ6zFUhvPJN7Bnc4ni8cj
 qAlKiCdgPlg3mjmFIMzzoT86NNkYUxZ6fIJ8tk1b20sqIe_d2b3ojJ_0pZn1NKa9eiVvZLobpept
 cLHUeOkAaoSKnoNl1SkOrSKsE4zdKwkMgBWa5bnLrIlWDLM_o1_BAKIOpKNoMh9qScd4Kt1FK5SQ
 cylR_YjD8WHGtCNfhPLOfg.B7mi4bJVykd8sz9w--
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic306.consmr.mail.gq1.yahoo.com with HTTP; Sat, 27 Mar 2021 03:50:01 +0000
Received: by kubenode529.mail-prod1.omega.ir2.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID b79f63fb2a60f2e9a0e41858735ab882; 
 Sat, 27 Mar 2021 03:49:59 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH 2/4] erofs: support adjust lz4 history window size
Date: Sat, 27 Mar 2021 11:49:34 +0800
Message-Id: <20210327034936.12537-3-hsiangkao@aol.com>
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
Cc: Guo Weichao <guoweichao@oppo.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Huang Jianan <huangjianan@oppo.com>

lz4 uses LZ4_DISTANCE_MAX to record history preservation. When
using rolling decompression, a block with a higher compression
ratio will cause a larger memory allocation (up to 64k). It may
cause a large resource burden in extreme cases on devices with
small memory and a large number of concurrent IOs. So appropriately
reducing this value can improve performance.

Decreasing this value will reduce the compression ratio (except
when input_size <LZ4_DISTANCE_MAX). But considering that erofs
currently only supports 4k output, reducing this value will not
significantly reduce the compression benefits.

The maximum value of LZ4_DISTANCE_MAX defined by lz4 is 64k, and
we can only reduce this value. For the old kernel, it just can't
reduce the memory allocation during rolling decompression without
affecting the decompression result.

Signed-off-by: Huang Jianan <huangjianan@oppo.com>
Signed-off-by: Guo Weichao <guoweichao@oppo.com>
[ Gao Xiang: introduce struct erofs_sb_lz4_info for configurations. ]
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/decompressor.c | 21 +++++++++++++++++----
 fs/erofs/erofs_fs.h     |  3 ++-
 fs/erofs/internal.h     | 19 +++++++++++++++++++
 fs/erofs/super.c        |  4 +++-
 4 files changed, 41 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 80e8871aef71..93411e9df9b6 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -28,6 +28,17 @@ struct z_erofs_decompressor {
 	char *name;
 };
 
+int z_erofs_load_lz4_config(struct super_block *sb,
+			    struct erofs_super_block *dsb)
+{
+	u16 distance = le16_to_cpu(dsb->lz4_max_distance);
+
+	EROFS_SB(sb)->lz4.max_distance_pages = distance ?
+					DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
+					LZ4_MAX_DISTANCE_PAGES;
+	return 0;
+}
+
 static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 					 struct list_head *pagepool)
 {
@@ -36,6 +47,8 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 	struct page *availables[LZ4_MAX_DISTANCE_PAGES] = { NULL };
 	unsigned long bounced[DIV_ROUND_UP(LZ4_MAX_DISTANCE_PAGES,
 					   BITS_PER_LONG)] = { 0 };
+	unsigned int lz4_max_distance_pages =
+				EROFS_SB(rq->sb)->lz4.max_distance_pages;
 	void *kaddr = NULL;
 	unsigned int i, j, top;
 
@@ -44,14 +57,14 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 		struct page *const page = rq->out[i];
 		struct page *victim;
 
-		if (j >= LZ4_MAX_DISTANCE_PAGES)
+		if (j >= lz4_max_distance_pages)
 			j = 0;
 
 		/* 'valid' bounced can only be tested after a complete round */
 		if (test_bit(j, bounced)) {
-			DBG_BUGON(i < LZ4_MAX_DISTANCE_PAGES);
-			DBG_BUGON(top >= LZ4_MAX_DISTANCE_PAGES);
-			availables[top++] = rq->out[i - LZ4_MAX_DISTANCE_PAGES];
+			DBG_BUGON(i < lz4_max_distance_pages);
+			DBG_BUGON(top >= lz4_max_distance_pages);
+			availables[top++] = rq->out[i - lz4_max_distance_pages];
 		}
 
 		if (page) {
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 9ad1615f4474..b27d0e4e4ab5 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -39,7 +39,8 @@ struct erofs_super_block {
 	__u8 uuid[16];          /* 128-bit uuid for volume */
 	__u8 volume_name[16];   /* volume name */
 	__le32 feature_incompat;
-	__u8 reserved2[44];
+	__le16 lz4_max_distance;
+	__u8 reserved2[42];
 };
 
 /*
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index d29fc0c56032..1de60992c3dd 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -59,6 +59,12 @@ struct erofs_fs_context {
 	unsigned int mount_opt;
 };
 
+/* all filesystem-wide lz4 configurations */
+struct erofs_sb_lz4_info {
+	/* # of pages needed for EROFS lz4 rolling decompression */
+	u16 max_distance_pages;
+};
+
 struct erofs_sb_info {
 #ifdef CONFIG_EROFS_FS_ZIP
 	/* list for all registered superblocks, mainly for shrinker */
@@ -72,6 +78,8 @@ struct erofs_sb_info {
 
 	/* pseudo inode to manage cached pages */
 	struct inode *managed_cache;
+
+	struct erofs_sb_lz4_info lz4;
 #endif	/* CONFIG_EROFS_FS_ZIP */
 	u32 blocks;
 	u32 meta_blkaddr;
@@ -432,6 +440,8 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 				       struct erofs_workgroup *egrp);
 int erofs_try_to_free_cached_page(struct address_space *mapping,
 				  struct page *page);
+int z_erofs_load_lz4_config(struct super_block *sb,
+			    struct erofs_super_block *dsb);
 #else
 static inline void erofs_shrinker_register(struct super_block *sb) {}
 static inline void erofs_shrinker_unregister(struct super_block *sb) {}
@@ -439,6 +449,15 @@ static inline int erofs_init_shrinker(void) { return 0; }
 static inline void erofs_exit_shrinker(void) {}
 static inline int z_erofs_init_zip_subsystem(void) { return 0; }
 static inline void z_erofs_exit_zip_subsystem(void) {}
+static inline int z_erofs_load_lz4_config(struct super_block *sb,
+				struct erofs_super_block *dsb)
+{
+	if (dsb->lz4_max_distance) {
+		erofs_err(sb, "lz4 algorithm isn't enabled");
+		return -EINVAL;
+	}
+	return 0;
+}
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 991b99eaf22a..3212e4f73f85 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -187,7 +187,9 @@ static int erofs_read_superblock(struct super_block *sb)
 		ret = -EFSCORRUPTED;
 		goto out;
 	}
-	ret = 0;
+
+	/* parse on-disk compression configurations */
+	ret = z_erofs_load_lz4_config(sb, dsb);
 out:
 	kunmap(page);
 	put_page(page);
-- 
2.20.1

