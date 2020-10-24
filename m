Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B3B77297D23
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Oct 2020 17:28:05 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CJQ371CZwzDqvV
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Oct 2020 02:28:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1603553283;
	bh=v+qJby+u2MJcx/JbQvgvOdFEfnC1jkV14rC8/xxy9I4=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=ajvJSPd82MDk4MxyiGxeQPYKmZlThGZ5KbfdVMFTtKG/e0D390gy9RLmzUFZcXdz3
	 VRJYqgebv/AFH6jBlnC3GwdgDUXigYxduLgkpuQhVuOvIktLnTBGRqcoHwbuxQ97Eg
	 Cq/fZsuidPeMvx5abKfofsoDzYfT44osgVfHRQTO19dOPZOjFm+R16YK5m7mYO+289
	 i+QzkIwofOnJHyS7fGWBlhoIJW/i6T+9L+pq4j3gGZCuZgYAtxYI5xtNk09x1IzkYH
	 MQN9iD031B3QnYn745Ow1+RQJr7z2dafr8Fly5RB1KbgTHxrxS99SrFeg5N2+zsP1J
	 cq3RS71zJk5VQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.205; helo=sonic303-24.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=LPMzrqrW; dkim-atps=neutral
Received: from sonic303-24.consmr.mail.gq1.yahoo.com
 (sonic303-24.consmr.mail.gq1.yahoo.com [98.137.64.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CJQ2s72ybzDqsx
 for <linux-erofs@lists.ozlabs.org>; Sun, 25 Oct 2020 02:27:49 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1603553267; bh=Es+4SsNuoSKtx6CV5k1JTTa9HVRqz8vzKMvUWe/1TTk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=LPMzrqrWniOWmiVgaWnsCMLFzQkw4A5BavaobAD/CFla1iajlDFjrOTZQUPAFj8fliONOr9+5xsHU0yk1I78BbApaaz0VfnWKS8cpc0O02jId6UzAoCv3dMg0J6j/ZPlfo1xYqqSDWevyFOGcVbCwr6PSm2O9slPSul8MIy0+Vp8AWBylpD1UvwSAqoPs4dj8Oy5pZF0/CzswtkOLGI0Q1P7ndvjzvl2kcDyDydvUABCRPYWDKtFMy/n9UyRdJLywbcm06PBrQAfyUDt2hOdGBDWf/27n9MgojFPiglAddCjvbHziYWWrjh/RDd+uOTcZ2Ui888wWRK47VsxH2k7jw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1603553267; bh=/7vDCSztRGV6YfjKpoq590cBkZ3DCWZAa8ChOVqIABU=;
 h=From:To:Subject:Date;
 b=jb+Cft4iWsysZpdazyE77XToqSJwI9ugW4X/J21eWkhWLFXCOBBEVoaW0YrVYjpB+rAcawkBQjC9shG4Jq6cUqhI3hZ9urv3XQoHlAY5wUvekYscsVphOfdYxRc91BKHNvWjvDsbCSCLahXzcndwDr4QgIjdyyfAuXTCWal9R/WdmJO1oRoyG9e5dL9N3WUa5KZ4oYyVvcTrZZvwZWTmuUTzROuxpU2mcXfFPfVRiq+11VBCSOWZX5Vl5aJydheWlOYgFxo0d8KbeXNknzMTZbeUvq38fxcIdHH2iAQFbwkNm92agNlpmlaZCKYp9AW+5FPg75W9ED+/HLtjyw2h9w==
X-YMail-OSG: m1qTsx4VM1kwQ0S9GhK54MXBtxPx.uRJzi.mmHyRQ6UIfydNE5DrGt8uHV3D5GU
 ARptGA97BjJAnDmV9yd0INcUgUbe6FMcesSIb..PADIPLM1aiha_vy7vaiztCHwIAwe8Ds_T3P0i
 UMONY0uwWD8CoXVZ4ASl8cz8_cBwZEmMMF0fKheS3C55ThcIs8kZOsGYQdQ6FG05UeXkQekGNzIc
 M0ob6YkKfCWdqUJ_dbkcuAIkC1hWVf9CezUb0TV9ybzQiy2Ht.0Xx86BZ.O204DfhKADuNBzN9VD
 geMcnbVM3ofOrh8jd5hUlc8wv_509C2LeCDAZFeV5NMdpltYsiXDRkVUSVG8PNBlnFVHe3A44DDF
 .xFEV13vjeGjcSDarvpzSwJ_m8SvcrbH3A1AcN.aMqfcJf3xHlu7CZWSWVdfqFU3jhg59Ix2Et0a
 AMJA8MAUc637pu7zgUdMhY7ILBZ4AgVmG2kEVe51BZ9dFX3KE8uL3hZPl_PflrogTalVXMAXjMWA
 fQSrwaDEqCUVZoP.YqBv0VZnhadyDgI6bdUvmtRhIJZ6SJJQg1wWguMrBu1yfGKsLYHK9I0mLIbY
 uC2Pk0O6PdYOUN4jT9YwC2LHNPRR9bzXep867A8w015b_qI.w76X.5kZ7OSBnOHE98fASp2E_idw
 R8UX2GtuzhVOm_lLr4u_VTobarwr1n0f3ji0MOwtI6gX_9SnbjlNn2z2O4L2mCcepdUIqzaBte7H
 k_9j3wrqONlxW9_TU0sij34bHzqJVnwjfM3c3RC5V2076k99_eL8din8vtnJKN3Aahx68_PdyTx4
 Ddx24HvscGUqFk2CkdAfOi0OLe0oodzPayUId_bHMiwi4Izb6vnI7Vigr6NhmzdRbrnJz_fWz2d_
 xA7S8cYsvVhxUnc2CZbOeBicwL4vuG5j_I5KA_ZpTOfJsjLxDMc6RmQDiPnIFQRez089rgimvfw4
 6x0K8y08BlKwx5TlM5H2iH5BnxvtKwlJeOIyP0728j.QuNYi4QAW1gaRtXkAGBXvBtZPzQEmmwWv
 VP3upfuyVDorJIKV1yLY2lmx6QaWjN2Dr5Ht_pT3Kht9P_HL1j7bn58YZV1bbmXLfLsPbePDLPwR
 EMG.eKEOOAUKKrt0lzKLrToHF4JSFAMz6Pqx42dKfNvCgFzheG4teufU2wWjZ6BU69iWvl0v1GLc
 p9X3PrEOP_dy9Gkxk4bDwGBf6sY.osbG6adgu6qDAIXZHiRwOChqlGedCTwFlkWULxhmVO_hUHcd
 ZPzYnQbILLPRlo67blPXWBcY_F4xuBGFva8NOH_elqpo_qx1bPck9c1vqa5Bop4vp4QUKDEFcf56
 pzMqPdjL9uSMcW16FKyVWCzcQP6p9xK3menWUh4GrVrCWPm89PqJMVUDLLLL8ZBtidBv51E9kzXm
 H4z7k9w23DnKdwX0s6kCDGqv7wKyHhfPiBMLjvBUHijny2D8JsR6yIkpHvt2ujQvYpD8JZdO5Tnv
 n0G9OABw7CBM2E.74MYmmVj1hyTPbbDgCAYVxb08_c5NMzDIV8DCtUm2ZFtnt6T.52zVPMjQXmBH
 iCIDspCBm2MRqRwgiI27u4BfR42GqntP4EMQdHn_b4rZE0vEgHarBPrdThk7jg1SLyTdRb_0WFdq
 uOuZu8VV_XNYaIs1jUgcNWjxciYJkmtrlBAE.zAJ4Z1jP5CAKj9I_CFP2Y0j_QhN4JBAP0Xp_q55
 VZ9qcr0CGXYpOFX.wStnqFZ3T5zO1VR4slCYRjlbqfdDBcMC_qRE2wdlXhP.HnmSgg0nj4sLZTsA
 _lbssNDdehKec5rcxBqxXQf5bA0UBL410pvC.pAB.rCh_.wPZ8XiIxDfeFyk2Q9eFT8XP3KDkETO
 Wgq7TtJaCSrG.suk4UgdgisAN3mJd4msvsfj_IQtpVSYE4Ey.SEp5ylvzTqXOXiJzwjwFeNTCANW
 C0qnBv0K7DEoPCfW8OA6gvPhT7_YqM.laD5ROv2e18X7YyxSlXQzADKZB.E40bRJsDtpYoYlhynU
 lerwJmZXBxIRtWhMoswiZwgzqEbdu1A5sKzZXAyE4y5Ue2DE8vbKjMCupTYAivjcCBe2r5SXtwXp
 Kt1e.gLse5aVdMmx4lU1Ekxd.oYcQgRcOE5xN2Vvn6Zg9FrFkNVDllCo3WHoc0YjlIsguZierkgo
 h.q04mJ7dR2Z3ovElHBEgJBmVQUwfar6HyzBj_ITLQxxV0jq36K8eC44dqOpWtBTpcb.Vi7Yh0N7
 dIAL.UHCMLPE2vjht5tIX5rW2kZ4YZqTdnmPxsDYHltXFDn2fwAgYNGbRnPphbfLkYJPXjlrqQ3R
 P.YReUe27190xMouM6cV_84REnL2xnyjo5bZLAeAgJSQq2CMqVFRcXTMP86g7XnYppQJbzM5T9Lj
 PeQlPVpfCmM6JQjGNPZaGMW_JUlmJY6QdRUcWpzhq2IXVoOMZz5tHvCeAzc_NN2gZx_TRgi2AhJB
 ZPDmy_u68rhPu9YpERXvuHqm1pTxQ72Q.Hcyj2lRGWAoiwLC0bwIoVsVBmM9Us1GQ6csJfh4_GPs
 gP7LeZU.RM8_NVKXtprIktb4ST9QlDPj0aLLU3PnE10gKWMI3PtILNMKTgyBlHVd9VYTvYk98L_M
 iGmzMGmtW4CNuikpSLuAMZ85erQcp9oVTZw5QHnPemgmil0NzzpppCJ4qTzALRWOn8vVS4vqBOpo
 RSvU0e7udx2WOAP3MR.YMscagjLP_S3ctOj075c9_UrRIi18ASnwTHY2098fHynzuf9lUB.7WvF0
 Z2zwczqGrllcLiR3yz.aOZ5nm05OSBJ2H0WreilfE6Oq44AXZVHMSmDvyD4GfbCe4JtvPbVwWJmf
 fiEbfaIgoxQjQQtZ7A72D7aXK46W7rjKtFB_e.wxCzDuJtTGC4h0vNx3WqSq6ZdAbJjRjLxxBsdc
 -
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic303.consmr.mail.gq1.yahoo.com with HTTP; Sat, 24 Oct 2020 15:27:47 +0000
Received: by smtp419.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 2916ee8ddb6600cadb9ae76b200a557d; 
 Sat, 24 Oct 2020 15:27:40 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH 7/5] erofs-utils: fuse: move feature_incompat to sbi
Date: Sat, 24 Oct 2020 23:27:19 +0800
Message-Id: <20201024152720.30603-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201024152720.30603-1-hsiangkao@aol.com>
References: <20201024130959.23720-6-hsiangkao@aol.com>
 <20201024152720.30603-1-hsiangkao@aol.com>
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
Cc: Zhang Shiming <zhangshiming@oppo.com>, Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In preparation to move decompress.c to lib/,
move feature_incompat to sbi only.

Laterly, sbk needs to be completely dropped.

[ will be folded to the original patch. ]
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/decompress.c |  2 +-
 fuse/init.c       | 12 +++++++-----
 fuse/init.h       |  2 --
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fuse/decompress.c b/fuse/decompress.c
index e32a27017a45..766e6639aa68 100644
--- a/fuse/decompress.c
+++ b/fuse/decompress.c
@@ -22,7 +22,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq)
 	bool support_0padding = false;
 	unsigned int inputmargin = 0;
 
-	if (sbk->feature_incompat & EROFS_FEATURE_INCOMPAT_LZ4_0PADDING) {
+	if (erofs_sb_has_lz4_0padding()) {
 		support_0padding = true;
 
 		while (!src[inputmargin & ~PAGE_MASK])
diff --git a/fuse/init.c b/fuse/init.c
index 867f4bf90e9a..c6a3af697532 100644
--- a/fuse/init.c
+++ b/fuse/init.c
@@ -18,14 +18,16 @@
 
 
 struct erofs_super_block super;
-struct erofs_super_block *sbk = &super;
+/* XXX: sbk needs to be replaced with sbi */
+static struct erofs_super_block *sbk = &super;
+struct erofs_sb_info sbi;
 
-static bool check_layout_compatibility(struct erofs_super_block *sb,
+static bool check_layout_compatibility(struct erofs_sb_info *sbi,
 				       struct erofs_super_block *dsb)
 {
 	const unsigned int feature = le32_to_cpu(dsb->feature_incompat);
 
-	sb->feature_incompat = feature;
+	sbi->feature_incompat = feature;
 
 	/* check if current kernel meets all mandatory requirements */
 	if (feature & (~EROFS_ALL_FEATURE_INCOMPAT)) {
@@ -57,7 +59,7 @@ int erofs_init_super(void)
 		return -EINVAL;
 	}
 
-	if (!check_layout_compatibility(sbk, sb))
+	if (!check_layout_compatibility(&sbi, sb))
 		return -EINVAL;
 
 	sbk->checksum = le32_to_cpu(sb->checksum);
@@ -75,7 +77,7 @@ int erofs_init_super(void)
 	sbk->root_nid = le16_to_cpu(sb->root_nid);
 
 	erofs_dump("%-15s:0x%X\n", STR(magic), SUPER_MEM(magic));
-	erofs_dump("%-15s:0x%X\n", STR(feature_incompat), SUPER_MEM(feature_incompat));
+	erofs_dump("%-15s:0x%X\n", STR(feature_incompat), sbi.feature_incompat);
 	erofs_dump("%-15s:0x%X\n", STR(feature_compat), SUPER_MEM(feature_compat));
 	erofs_dump("%-15s:%u\n",   STR(blkszbits), SUPER_MEM(blkszbits));
 	erofs_dump("%-15s:%u\n",   STR(root_nid), SUPER_MEM(root_nid));
diff --git a/fuse/init.h b/fuse/init.h
index 405a92913b4a..34085f2b548d 100644
--- a/fuse/init.h
+++ b/fuse/init.h
@@ -13,8 +13,6 @@
 
 #define BOOT_SECTOR_SIZE	0x400
 
-extern struct erofs_super_block *sbk;
-
 int erofs_init_super(void);
 erofs_nid_t erofs_get_root_nid(void);
 erofs_off_t nid2addr(erofs_nid_t nid);
-- 
2.24.0

