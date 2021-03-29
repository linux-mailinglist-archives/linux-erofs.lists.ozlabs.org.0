Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DB23234C109
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Mar 2021 03:23:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F7vwm6Y65z304V
	for <lists+linux-erofs@lfdr.de>; Mon, 29 Mar 2021 12:23:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1616981016;
	bh=t/+ISJ5HXrAlKiul3xBwkVe65r9B8sYHMwSlqDyWszE=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=RucECNdgF9VMPzJnrDfxW0ml0tqyVil3CAxR+E8Gz/5dX7+nW2mAyBofCSEfoHiz8
	 v0/hI3D8XKdUqmwbXl1GAS9AgU/IdlUptWaA7TG34q4+/TLH/6OmVKAF6K+qT19cIu
	 t9zlnfihsRVaVemGo9hE5XnHW909vVW8K4B0jNFg26+JVLJAgOsVGUTWXLg/m2aUj7
	 r1iql2ieqsUnBLYFSuTI2Cf0jeDKUewJutdcP0rP0Zt6neW0aqeLcIHzPnMXXlcfGh
	 /1eT+N3j/Uon/a1IiXPRz7v6XEMxOOGFb++dmsEwc1dRELND/L5H0CaNTeQgi+MAGI
	 PzUoWMRvJm/yA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.84; helo=sonic313-21.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=c0pCPJol; dkim-atps=neutral
Received: from sonic313-21.consmr.mail.gq1.yahoo.com
 (sonic313-21.consmr.mail.gq1.yahoo.com [98.137.65.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F7vwg62nYz302C
 for <linux-erofs@lists.ozlabs.org>; Mon, 29 Mar 2021 12:23:31 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1616981008; bh=/I/6RPssPwK9kvIcYTQVylBSMn2DILL9DVGytGfKZ7x=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=X4gcHHqfTlWZefB+s1xvhoI9C4RxcjYtg0053o1k/+Fjs/PPsDUPzba8iEyVAkyrEI9H5rbFT54RjbJLaDhZxSpecmVOaIMjGSO2TQfd5aanhaieqaMlDv9g+cfbGbDq9NXPrPyy5HZGjtPtgC6YAJxw0m1jqv2NFByNbuMeIu3TpIAaPFkVFtxohk2B4EPkUhtxZOwmJDtDQNgi4y3k1WLkfAAf9DUOqj9+3AUN42v/0p+SMY67GIcX+d3cstkGOH/ZXIO/aOpOa9UaFM/d75RrhetWwW5v7yWSRdBl9Y5JI80eEQhvabm7+Vvx9ns7brqH2OeSEpsZggJ1KMxv5g==
X-YMail-OSG: mn2SRiwVM1m3IIvxGE4awjm3jmVC9P5H6N_yYu7Q9ZOVSE9IhRm_2h1TLJPX11O
 Cw.hB0GKXZ3BnJYsojKM9PJR5k4FBHzhb2_OZ8J_4xIWO_5oo_91_6JcjXhf1jYyQEi5ZQzKW7u0
 PIFpodwcjEtE1FZQslhb_04RT8I3B_UZD5kWRcp0R9ZEsTE2KVqdCTIzStB_dU4vyLm7muGbERrH
 Di2NEax6XX.nRTI..F5B93qx6DVr7NMlKSgKhjbn2tut09_NCAkr4VOPCq2QwmMczQtJDJoHA8mw
 8ndUJnYArA7OhEErI5mQUizfWOyZOb.iJ_WK7EncyL1enAF9kfccP9yrLh8rtVz2JJHcKvcRy31W
 5OMlMvm2tVQ0Pl92JinB8Ex2C6fNLT3IKIq0a6qtznR14iUL95bx5fg_iAQWvRFPPmQtclCr5GF1
 vWHHd.nCTyon_XL3MqDZPFKrNB67CYlms9MR.ijTmvNCqkqu25Ll4NjJy4f.ybxLr60lzRhFXAao
 dT.QXXxenEwxRqT2s9P1RvFx6UYdbBnPWgXkpLiVEzNomkJBdiSM5lmSI6HBiZVcHmNPFQiuxx2V
 6bwjDwhXJl2Dbc7phSAnNHySq4Wy7qQhITRrEiXTr.5SanL6xfqzQNLCAE9Dx0roADrryidS.Thm
 v1IVtEBdgnEs0lkWbCvX3AXIZWbPYJsXhmCNsQSB5A6KFvjrntCAwHmQA8nfHvHd5zw52J4vU05Z
 NBcOnh1NsuHZNerHVQ8.6mNksXLbFCpeimazJ.1CBNNLW.ZhdpI9oULA57DZQJENjM.ptoJE5j3e
 JT9aFiADQ8FkKMpqDoP5TgwODTgz_f1yvQ.RxI2o4.z3SrH2phWZChTK9qKjgNg8dfXb9EkQUuZ3
 HAoSp9.W6zuSlLuLH.xreZoS68zuyu6YZ_n320ajnrfHaMm1fm2ee3zRzSKtNoGqbns.2advodYe
 z2jL8TnvRoLE8bMOGYCvy5f.8T6MbiAAXcM725OQQtO6Gn7Qel.i7EOD_nsIhpDQJ4_yeP13Y2bH
 QoLSwsPi42ZC_bUrw283tsMcQnLY62LRVia4QpZypdQUwacwdc7nM4cpMGuA2c7_1xbjZLsKVpIs
 HJk1mwWt4WDx5htXTwgI_ENWIzx78Qwv1svd3D3Exelc8Om6sLNby3Bbwb6wiP_ObpCZVC5CZA3O
 K_HPceicUzNIrapD140hQHbnqhxq07wOScR2TGNspkFDXz3FMuIJoFogYoHQiNhhaMpg2j0_L_4i
 VNAEYxgjAexN_Zld_l.A3xB6w2gv5YbYXNDPpOAT.KuRnwezCMhpNUEft.5NGQdIQn.0QvbGxRF_
 6YpuW5JMxn26tN5nt84oaHU6RlFi2WiLWtRfwA45VDIUzzMadBlh5fNKRvUOYlOb2J_8NCIIoZIY
 5jH06_VV4tkTi31DhxyOCD1ve8NNkmeGsesialSicJdPjEpXopqAWKHJBNvsCiRe6CU.9eVaMGRh
 slVoi6ySq7cs9Jbmhbz7k7NzEnIgJg2HMjWWxp0QE.PELFwNQwL7E_jt4jL_V0Hc9gLYu_tL8dGL
 37ftPTJ60uZWM5oiSPoR48IWfFjyfnWaydhHplo1turnv2Pitx9ywyTJo_ho0B6fiGRtW99cbudg
 PotBRNrjIRrIIF5xWQRiW2KkMYYF8TSx2RdXTGQ5mfcdfzV1UfPs5Fyfsv_aQ3A4lVt_M1Bz4p93
 Abp7Qpjz_uOYOlKRmReiCodxSI_r.n26V2VGZu1qmGlQ8CfEFgliRiH8mC965TYgr8eTRMc31nAH
 4tlkv6JsaIbW5omI7h9pQLRbe0g2yChMYf1QDXl0mKJvSzsAALSm50OwsnCOyXrkOLy.ljeMnFB6
 SUxYKX6ITZ2gf7TfhqxYIlTiBrLUhi2CweNs14ukKRistGHsctLVSBVGFWLBTdhXSYM4gimsSwwU
 Pu1IjN3MJNpwyhWhsZ3bP.AicBeoCAwnS3rCBp0KYwLa7W_C3MygIJ1PKP8SDG.Bdv0KwlQYwiui
 ljLARn0jsuAQXLP5N9NWtnMfXC9JLxSKjYkA6xacXsIWywWZnoLJvh3bBlWwIiaBp.oNmw0uJkJu
 aFmkJ10MbZYsLylQ7fZ.5wynPPR98BDgWcd3VKoLkVCgvcrZilVDQOL.Bnxl42q6JRapJ5ml9OmX
 RhbjKZQ6BXLt14PoCvp4KdSJppJe35YYFZ4RpH42YlJjKUhP6kEqvRMaTiC_cWqm81x7TMhCVmee
 7PSKYVqg0wkgie_h39z5hffVh5BubJBsKxZh56ozkxiAfpd.kwlneIA.w7uebi7nLaPPUwmzioR9
 a28QODDj0sl1TDmr7gi_10exTOZxu1GkUKqhgsQETTcxHISNeN5bwbeNhSaQLUcb_8tuTqhdDaCP
 2bt4hqk7RcHbdhrD.7yhgI74BBL9HpPgqEmB2kIBLL3SdGRyr6geJSvS4YXrP3QgLGMuKRxASnei
 Nl2iwfWlSXTFTeOmcO4R1DOSta72me8lOsgQUS5jcdNIBYRszun69wV7QqWGiCserhavQ2ERCzE_
 jGHv4FBZJbDyngn9xGF.xFWmY5gEA7qI_d1IlZ3uM9UYJRNgY8SBVQTMxyBfRLKBeWMYgBikchw9
 bh8e_pksrElPmiUSv_Up_GBV.QLSRDWl.oa90CwaqM4gr.wAU2Ru0dbNVGoX7S47D6f7fayP7XD7
 5BDGmILxffXTYe.WrU1S0OYE-
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic313.consmr.mail.gq1.yahoo.com with HTTP; Mon, 29 Mar 2021 01:23:28 +0000
Received: by kubenode575.mail-prod1.omega.gq1.yahoo.com (VZM Hermes SMTP
 Server) with ESMTPA ID 3d9d64f8790c67205a0f6cb47abdabe6; 
 Mon, 29 Mar 2021 01:23:26 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org, Chao Yu <yuchao0@huawei.com>,
 Chao Yu <chao@kernel.org>
Subject: [PATCH v2 3/4] erofs: introduce on-disk lz4 fs configurations
Date: Mon, 29 Mar 2021 09:23:07 +0800
Message-Id: <20210329012308.28743-4-hsiangkao@aol.com>
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

Introduce z_erofs_lz4_cfgs to store all lz4 configurations.
Currently it's only max_distance, but will be used for new
features later.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 fs/erofs/decompressor.c | 15 +++++++++++++--
 fs/erofs/erofs_fs.h     |  6 ++++++
 fs/erofs/internal.h     |  8 +++++---
 fs/erofs/super.c        |  2 +-
 4 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 93411e9df9b6..97538ff24a19 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -29,9 +29,20 @@ struct z_erofs_decompressor {
 };
 
 int z_erofs_load_lz4_config(struct super_block *sb,
-			    struct erofs_super_block *dsb)
+			    struct erofs_super_block *dsb,
+			    struct z_erofs_lz4_cfgs *lz4, int size)
 {
-	u16 distance = le16_to_cpu(dsb->lz4_max_distance);
+	u16 distance;
+
+	if (lz4) {
+		if (size < sizeof(struct z_erofs_lz4_cfgs)) {
+			erofs_err(sb, "invalid lz4 cfgs, size=%u", size);
+			return -EINVAL;
+		}
+		distance = le16_to_cpu(lz4->max_distance);
+	} else {
+		distance = le16_to_cpu(dsb->lz4_max_distance);
+	}
 
 	EROFS_SB(sb)->lz4.max_distance_pages = distance ?
 					DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 43467624ae3b..e0f3c0db1f82 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -197,6 +197,12 @@ enum {
 	Z_EROFS_COMPRESSION_MAX
 };
 
+/* 14 bytes (+ length field = 16 bytes) */
+struct z_erofs_lz4_cfgs {
+	__le16 max_distance;
+	u8 reserved[12];
+} __packed;
+
 /*
  * bit 0 : COMPACTED_2B indexes (0 - off; 1 - on)
  *  e.g. for 4k logical cluster size,      4B        if compacted 2B is off;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 1de60992c3dd..46b977f348eb 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -441,7 +441,8 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
 int erofs_try_to_free_cached_page(struct address_space *mapping,
 				  struct page *page);
 int z_erofs_load_lz4_config(struct super_block *sb,
-			    struct erofs_super_block *dsb);
+			    struct erofs_super_block *dsb,
+			    struct z_erofs_lz4_cfgs *lz4, int len);
 #else
 static inline void erofs_shrinker_register(struct super_block *sb) {}
 static inline void erofs_shrinker_unregister(struct super_block *sb) {}
@@ -450,9 +451,10 @@ static inline void erofs_exit_shrinker(void) {}
 static inline int z_erofs_init_zip_subsystem(void) { return 0; }
 static inline void z_erofs_exit_zip_subsystem(void) {}
 static inline int z_erofs_load_lz4_config(struct super_block *sb,
-				struct erofs_super_block *dsb)
+				  struct erofs_super_block *dsb,
+				  struct z_erofs_lz4_cfgs *lz4, int len)
 {
-	if (dsb->lz4_max_distance) {
+	if (lz4 || dsb->lz4_max_distance) {
 		erofs_err(sb, "lz4 algorithm isn't enabled");
 		return -EINVAL;
 	}
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 3212e4f73f85..1ca8da3f2125 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -189,7 +189,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	}
 
 	/* parse on-disk compression configurations */
-	ret = z_erofs_load_lz4_config(sb, dsb);
+	ret = z_erofs_load_lz4_config(sb, dsb, NULL, 0);
 out:
 	kunmap(page);
 	put_page(page);
-- 
2.20.1

