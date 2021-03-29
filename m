Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0B534C108
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Mar 2021 03:23:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F7vwk6K2cz303w
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Mar 2021 12:23:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1616981014;
	bh=Ni0BnRbHzXFf9QkSjmBBPdvhQ7Zelkwra5jmrRPeOJg=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=SsdHlENp2/R/zWJHj4RvHhY+roLMXiRDfD955RcrBsQeplbkXri9aG1u++s9lWCHk
	 ffMcPdX+QSJFvyOLZ8lrOIATmvXeBVOtpj+WJiJySgLrYovHXCdcs7e1ug2raphAQA
	 UOJj321vPUS+HyxqDEYumbGP+m67zToziqAiWFBqeWYrHvHqstjISj0GGQgbzJZh4U
	 hov67V199ZY3qzMu2AIFmOulqK8uRqI8DfRHXCx7+omNypmGenp+KtZG//n4p41dCK
	 ihueKdfXuqz6SJSl+/KBdYw90GOsl21f7cYsQ0JAKCooqY5j/tI77gX9x6KcXX2UL6
	 e3792TZ8y1tfQ==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.206; helo=sonic311-25.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=WJjaPW4E; dkim-atps=neutral
Received: from sonic311-25.consmr.mail.gq1.yahoo.com
 (sonic311-25.consmr.mail.gq1.yahoo.com [98.137.65.206])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F7vwc60Fbz300J
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Mar 2021 12:23:28 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1616981006; bh=VK9sFJ/pGW9fg/z00DxkNenin7A/ACnalUUuy9uY/4t=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=fFF2FItkWOCkusvqlC3ncLdO/YW67GG3t/HPtITvFkaG42gn2ZetbNdHmcSoGAwIuYzPS+f/wtq7/R+SJhURassT2u60UQ1FTv2rIo4dEJW/n56yfGphuE8K+VdOLXLLtq1AYBliAZfkpfXg71U3MC9j/KjczQtblqX9MnWl+e2H7sbKR23qQVG2egD3jOZ7ZApPX3x9sJNJtH3IYab8rC7mzxJffjugLkV8ZqXyJJvwVr/nFPQi5rPeGKB9BNibrjITnyHQXjDiK87qar2IZVX2yMD9EZH+u8AsiEVdpklNGziWoSSfW1MB6tvDK5+Y0B52HyWHEORWpz3D8IzdgQ==
X-YMail-OSG: b9VfCLMVM1nDst7CAfCDtFQTI_kuyhT3OWbCrGLhwMZdZgRvQq7.TWeJkII8ymK
 z96uKzMC3no7l2fkFHyd_8jLL01.VQb5NJC_zrfWjQOdVnrh47fkvoQF1jJCmZNo5y9VjGtWoH0k
 XpDddLOEYAyYPVpkYt2FYCCxtnFPZDNSUYe2r4DWqiF7CB50gMASntczAcsG4gBfGnxxHDV22LYL
 .THuy_rZOshHpHZupIU7Xr_vf1rXnAYeunEBh7qFMgJAL_6p3s63eTt.X3gxl59zWbsAD5OW6rug
 87AJEcii.DlyWuTW0U.y0ZJKNuNoUY95HZLD2kHztnHP7yrnT5S_oF4.eSS4IPM2f.ZqPiWVlPZX
 Y9j0oPR2ulQm3TB7Y.bk99Ki8svtDbMHXA_3j6dZwM5dADoSXiVvZwMclGAPRFYTQW9Qp0FO2Un8
 LqdpFcktNetDxA3BnJZW0eJO_BqC1cQQUEmd6ZfFpjZjH73mf5T2O_RyLKlZAVO2q66lYtSmQw63
 OcbSllGwTDyqrd9HFi5R06BaXKUbYoea0LR9Ih3vjga9J39bH.sU2XdT1vTfb8a1tuQ9hqVHhNM_
 bn.e_hiebWFrcheSRJMiquelwGeHBGihKcuwYukQq36c0eL33mpRCJGBnls8pSuMr6QKkFmY1g6g
 X.AfXd5A1CGvNa2hUpcDkrDdUw3RHyy12sLQ2W4B.MLN3OG_uUGyq_VxkxdsCn1Bxkt2UOrg.Pue
 9uNgmbXnMh.ascfZk65A807uSkocwhI6JOtaIGxTPumrEGzOQnCk8l_MWj47VbvLOYCk0aXXnOg8
 XcZ3vo_8d5LMaWJ8v1Pqmh2krW9E1cBA8.RcqcMIq6gDdGtSroch6SxYDjNNNvnMhX9yzjGwxA5l
 nO3xtBH359AQaaiFq6lnJ.gBiTM5F5FS4z7l822dLC7qW7dwYABVrx.yaTZ_t1mNsxHl7PgFvCED
 QcjZt_n6w7nwQ0RWb1YFty4vwYfq76uifyoi.x8cFy5ZuV8wUXl5pXagqqJQZBpDdJURxOe4fp7C
 0mwPDZQsVRHrGNmcQTktj1WjVMabH4bPL.sQD_Gufik0_kWJN7O_gChLlGGANRmnLAph7DecBLFM
 BWLb7j.mYCjP1EubETJOIlLlLkqGidupBaz19ytA5_q2gGu9fQ6aAPew6L_34O5YsNPU471uMSUg
 dxKubIQtB8enZ2NjxVq1slKlbclb9.mlX7uaewIbLbNAJSB69VO_R4b1xVQ4re9vy1LWRz1kX1ga
 vCKIiF44kfciAKItE9vUxDH_QKn9tCTzAO_1o7k3w7pU.Oq4eoMoOrm8b2iBhXnM.G6Eu6Jk.QO8
 XnyJlRU4KZlo_Hz7ZWbgPF1.XOPLPiRZ0jKG1ZN2mB6eyEMrrpb45XVzVgAyJjrpvMBKuQ_z8G0u
 lfJ9h4hV4VyVdkh7UYsUiXGOI5J8xa7kCtj5mpyYntfOArbzo1pduAWzSaHO7M0FO0Kq52Oiawr3
 LzERzHs_JeQJhGUUW_TV3g2Jg0jCr6XJY1k_X64aG2e2xVm8ZyR.7UvHQkkJvLM2LIzKxDGSlhqh
 N4xAuxwbEb1bxwMpYB.GYx4HBgxt0HN5DHgk9UbbwvOidZMTGbFOQby2PoiV1ID7rKmswJsKbrtS
 qOTOYtePO38cqEjFFuwldrTarr8gZg370Hrra28wlOImJ28ffW6MP1bTP.F6mlsuOL_d3YzhzxJs
 _lmm7uZebmOg8yWXA3b2778TJ2yUnt9IVLfS8k0dmN.z2uGLk5uXgNtg1Gzqh1zn4R.REg.djIEG
 aNixicgDWj_J4d_jlu2lA.zCSyjtJevHMKyBGN4HFthutLeqrTJri5gMrGY5UxkBMCFDDT8NQhsg
 ZD3T7Mzl7fXK03Nf05j8nGwPZ6zulTMUV8girI46A1ci3LA3qnC92x8KxUjzsq.qHCeX.DeNOZDi
 98_MZL30IOvcF5alOg_UqTv_OUCBgq4zMJMvOxmKsXqmjJm5.lya61pcxsRAuWhQzDUWCa_XDYxO
 8gMQvhUG4T8mXY1Nm5YMt0gSed0RHSXVMGGye5aXSY.vf5eD9vDjZM4iQyETIL9KxyxarWizxIg9
 1Hwtr6q6E2plmDpH5u0HFXqNh0e_87zGueInodNqC7WEQipbfbQFG_KEf0q6gpAa6n4TlegUgaUz
 DH71oVY58XnBdRXG0pJ939TEby_93w.4t3fYsV6xX6UfT8sxZKPGyiMb9dDjyuceIBpQYqsploY3
 SRJ2lqd8ao9HRi9Sqr06XWrElso.reW9Trbc4rmLAyE4C2ICegj7WVYlzFnazaWYDGcztLxNNZV7
 6LR4Rq5jkIvfBBtNqiem002brBHVmVefbhX3JiHd2W9Nn3u_RWjamJTV0Vuf_bx4m3NDX2ZvLsj4
 pZ6sipuRQhn51ocTrNR3oLUR24NEEefTWSnFgWkFOZdzKVRmfSUaFs70HWHGBDnv95e2QHJRTK2p
 3cieWg.NOHIGACj_V8d3Ol1MvBmPagTLHr11vNoYY1yCf04BnAuMwicpN9xYK3MPPZ2JBwzb1Ydu
 US6NTCDrkyppDQt69dwpSvGkjJBBV8I8MJsaPynUysnTalsZ9q9izKj0Yar_8ku3D_jpWeuOWa5o
 9f4q85q6rRrF3pTMcovENa1NxNZqe8_N0H5V2.X1q2EtpvBoiH1CJ4HcIcB2lvScaMl6qbkrlgOU
 cF4.WA1vl9Uk.pomgcJRv6C0f61x97mrcU.H0cJ.pISy43oFLZsuuBcfRY_iVbGEMQcWnNwoQwmU
 tQNOKihXkZwA6vJGFM8MD1T4tQ7u0jYeI4f7dGEoF0KBfH5rbDs6Yn1vGzkh_AYz.WimrVGHhMZO
 CLkgBV8qPHeRnl9Cf4TVt
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic311.consmr.mail.gq1.yahoo.com with HTTP; Mon, 29 Mar 2021 01:23:26 +0000
Received: by kubenode575.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID 3d9d64f8790c67205a0f6cb47abdabe6; 
 Mon, 29 Mar 2021 01:23:23 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH v2 2/4] erofs: support adjust lz4 history window size
Date: Mon, 29 Mar 2021 09:23:06 +0800
Message-Id: <20210329012308.28743-3-hsiangkao@aol.com>
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
Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/decompressor.c | 21 +++++++++++++++++----
 fs/erofs/erofs_fs.h     |  4 +++-
 fs/erofs/internal.h     | 19 +++++++++++++++++++
 fs/erofs/super.c        |  4 +++-
 4 files changed, 42 insertions(+), 6 deletions(-)

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
index 9ad1615f4474..43467624ae3b 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -39,7 +39,9 @@ struct erofs_super_block {
 	__u8 uuid[16];          /* 128-bit uuid for volume */
 	__u8 volume_name[16];   /* volume name */
 	__le32 feature_incompat;
-	__u8 reserved2[44];
+	/* customized lz4 sliding window size instead of 64k by default */
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

