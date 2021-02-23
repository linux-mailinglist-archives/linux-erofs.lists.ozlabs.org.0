Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 438F83226EF
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 09:14:03 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DlBf123q6z30JR
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Feb 2021 19:14:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1614068041;
	bh=VgRaNiXmS+fHUI7DmYXUl0ZOy1q455DZjxEhf4VEPXs=;
	h=Date:To:Subject:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=oCxDfmJkIjNTxrdmJ2lKx0KQGfj6Z59Y4V3KpFRImsy8iN4BNN7tKCB7fAhv+ea1L
	 ZN8iZgCQ+8+I+7sZtLsyPDWnokWDIvK1NXCWi/hFMhKWZ4bzJJoeuiSCCjfRpinCHI
	 Gk+amfEZABuaUUHeEu2Y61JnwohRiBMICebJJnLKFJWCyGcOahMkdcGM6Sf7aAr5FS
	 0UHJD3FIja+84vfa0JaRQiv/FzEcOsdat6XDokWPYX8nYJ9QrgyYwweby0pCcUvXK9
	 BiuDtP7sM0xdzOSH/cg3Bo9qyFbjEpaEgyPpd4853bX7KHCqkz/6WRdaphyWJ+gEOD
	 kABvhaDY+m3tg==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.82; helo=sonic305-19.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=ahpk7S/v; dkim-atps=neutral
Received: from sonic305-19.consmr.mail.gq1.yahoo.com
 (sonic305-19.consmr.mail.gq1.yahoo.com [98.137.64.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DlBdy1fHdz30JR
 for <linux-erofs@lists.ozlabs.org>; Tue, 23 Feb 2021 19:13:56 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1614068030; bh=FVnb1PG+YppfkV46CJalLyQRXxdyypGCCqCP4Bm+kbw=;
 h=X-Sonic-MF:Date:From:To:Subject:From:Subject;
 b=WgAef68o9i3vsUCVcRVYnZ4TiVpIR92x3702QTxgT+TGVP4Fg8c98qbYwAvlF6IboqNlRkeE+deIWUxD111o7pPtysXjUFD9552Oc/RB5KmheuMXApBSEDRuY1MEoD0WA8Yu2vvs2C2MLpoYsvjXApgOgyQmNuhb7AwM3NXfWDnL9PBNIYARilhpSvZrmXk3acw48dBwvCPxXBh19OgwFLWUB58YcQVOimbTfH1/9owCNV+T9tYCjQtO2YIPnE4oW00Zdow8+ZRpoQKax6JQT0mOU0torpQcnRCnKAyAFWaclFbMbPNQ+t37jVyBgZ6PwnPBi9AWGTYhCZq4bCOprQ==
X-YMail-OSG: 2g6jPhQVM1mMw6MW0uill92AcbruD0.qNLKiBq9lnIsAwaCU6a3CK4JSTRXwPD.
 YV3AMK.HMHvvKlmhuMWrMf7089jcAuRY2HtHq2E7AosEdDWVRrFTVlvv5IueDDF5Adt8hzdvdcy1
 e5tSwqZStbiDfdOe5903zNrgaCkZiNb16d3NfsQNSS9DK7CP3Qai7kXT9g1ORepY5pxNPRe6AfUV
 lLUj_0fq0uNd8zKwhXkbJuBT6Jc7J6nNVYUyckzYoPtXeXKbOvxfLBKxypemeLiG7FYa0g02vPSv
 snP_L_WFySD5Hp5fplqtztdY8ZQ6LSI7F5cw77STN_V.UHGK4Xq0Bo378JdaGYBpjSdEu3eANKB9
 R.B_0WsrFeWyW9wVleGtQ45pGHZ1y9kEIw.lM_CnTtY9oSq8_g9qa8.KxJDi95EjNPevO6_DPiqZ
 bHskEwu0gliyV4OoDgHFGgFXO31pfV633tb3jgWQ_ASkQzbE0guFe7vWfxqO_rJBgngDVirkMv1y
 Q8s49fA5aKlTT5HWmabTqg6Gi09x0QL1j9ve8CdyBns7tBysSA3BJKRL5OxaItvO33kHGJ_rOdxK
 VOFhy.u6gDzDm5NeOTuGFJqTFOOkLl9hgudbIW6AfUr.CdsxTirRgsToZuFp1q1Xe17LfgnnT86T
 5MfgRJxVW4JGnY78tj7yU.BD2eh9fO5BQ2gRDEBmmcofgFAEuvRgrluCGm3piyR2UVZ7NRrrsaun
 IF1o0b.bOFLhBaR9i6aaqqHbyrRLXuPXKrdsxGropjwrW_NaUAbviurviyb7Ew1NOFLSFfTqAES2
 uRexWouGOAOrSrEvV75Jpm_41hfRc5wfi1rheauIS0c0Y8bTVdlpw4xdhqeedIjwsGEYeYOFGWMP
 NmiaDLxIPB8UVzBG9TIP2SBVsVtCvko4KlFR42Zw_DZTIFZSz9RUNMu0RF0RrL467BVf4nf5Oe2y
 O__aDfyQo65dg3QGR8vbyRjcgBeMNqhvxtf_m2nDBB9xwBumJzNo4eqfWqVesJFF3StUXo0jW3RY
 Nsx.GJ2J7C700y_LKa0JFnW8hEllW0t8FjFoOh9tX36eEFV6i60TzHSQUvSO1rxzsUkfuNaEdc4a
 F_iecXEi9RuwLS7xlrTtQQryD7E3Zy_eMnnCWv9KbAduP4OUZOuET8FxrlmNj_nUzkDH2x5If5ig
 i3IlQ_B8wMNQShy0cpD9Y4jFL.7HP4V8.EzX9N_zT200AUjgy8kOBGN8f2Fu7mS7RdU4P_h42niz
 9w6xaPmA81vrVARcW_HLT0wIdckEUXd1.PgLZNvmfbtQzh1kz2OKbbcUUcDrLsnD4VNX1ZD0TtxJ
 muDzYDGZyGSWYWtxJNiIDaudkVrCNgzZSvVPrNQKhosZlNzElGp.G7L6CLlAuaP4Fu1X08gQYjV.
 pcyssXltq4CTX_nf6E6ddwNLuOB6V_1m6_QRAeyiJa17WItaWOveaF18GmcWkJ_xWmpfsKkb_c9H
 ysMUx8pLU91O5ZgWza0dgaysMEC3iG65YFevhyTGULQe7RrVeILX0hcvzgrw87l8sus5kBbdDuDA
 yw2oUO09.rLYEJ.o0rq2XM_jU1BFr7pUCULQn0aWJbTEyFATbwI_SsGgjrKZTgb3nNhCJ1It1Nx7
 A0rQXDxLfnMf0yKU8Ju2N0o8xHXURXZXtAcb_adW7zUiAdkgQ.gnIbocTOBtN3j.wghYRDMFwvb4
 G9oQksG6VZoK5lKpozG6gI1cYa5fxReKzcMx.NaM1nNiY1fmYgO5Gmez1VGEGL4J.W2ObVQ9gwey
 N5j2XSNo4LWfhpbZvYH9TOgnxncUzToZhn0b3U37Ezxm_wuoqV4_frQQjMEeLbb8wFwCdErhvg.u
 mqemZIZqExR_O5EjNNaC9ilnw.MunaMk2Xl5zynv8NrhSvuJqro.hrDxz6Oy_O39CKuTbVenXstc
 a3vjdqO.s4zTgcf0MRstfKsDRxS43z1l14gwIQCLFIYN546U_bUWc8UtAcOVXcHVNgrvWgKNPi16
 q9Z88II2YV8a14CdVWPmPF2yLzIF2z7SI19JCcb8JG2UITMQccZP.VoTveKXXbbVCQdaLS9wbtHO
 oZosmguZEwSVPOsT8y.8ynxH8qr0JIC9HyVEULYtWrV_5cekUuTowbQbNYW4iiRarAPFfwr2DcqQ
 IyekUHZL9cjmkboh4qiEqE_qpUwkvg_ZNPD0pYqXm6RU1UfH30lCw.ozJ5GILuTctPjBtqb5SG1j
 ACieA1qQWRtym.AbyYQfu4wxrvSBwcByTUMpy7ZkBpbAGmTCfjdMOLpEpUZrjnYAxQe.y4juuyhM
 JTWT.tII40pTGSTM2qJZddfDBEZRr5e_FSx_xGbFurfoD4GkKAGMT.AAzTPjLqoEnBb.HsinCmaP
 8CQX2eEH3X6tn1nvgt7XRl7oRYcVV28BRw0FHy8Yd5RMc6E1weasb9dNS.LUfOiwu0mmebT6TAsu
 vsLkHZtspciL5l_TXjNhSroPKmVdWUjLrgW8X61e0BFQj8lxpkMOOCT.1HTBMbG3DME9hzWGGfwc
 FFLNeGPKDQylf_rVp7d.fPGM4SaXyiVhxyjuOIema8r6vKT9siUlq5L7.ffeJwgzxrQkEytpKe4u
 PGAGZYjXiFNevdKD5Ih9GcGizK7nxuRU33.DhKjlKcnpWerTCaKhJMSSyTRoHziAybGZQfQsoOsG
 9kqisFGgp5a4TfDc45A--
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic305.consmr.mail.gq1.yahoo.com with HTTP; Tue, 23 Feb 2021 08:13:50 +0000
Received: by smtp407.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID c8a8e7ed1d54030eb2a1fabfc0c47f76; 
 Tue, 23 Feb 2021 08:13:42 +0000 (UTC)
Date: Tue, 23 Feb 2021 16:13:24 +0800
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v3] erofs: support adjust lz4 history window size
Message-ID: <20210223081323.GA21197@hsiangkao-HP-ZHAN-66-Pro-G1>
References: <20210223073119.69232-1-huangjianan@oppo.com>
 <20210223074418.GA1269766@xiangao.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210223074418.GA1269766@xiangao.remote.csb>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Mailer: WebService/1.1.17712
 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.aol
 Apache-HttpAsyncClient/4.1.4 (Java/11.0.9.1)
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
Cc: zhangshiming@oppo.com, linux-erofs@lists.ozlabs.org, guoweichao@oppo.com,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Feb 23, 2021 at 03:44:18PM +0800, Gao Xiang wrote:
> On Tue, Feb 23, 2021 at 03:31:19PM +0800, Huang Jianan via Linux-erofs wrote:
> > lz4 uses LZ4_DISTANCE_MAX to record history preservation. When
> > using rolling decompression, a block with a higher compression
> > ratio will cause a larger memory allocation (up to 64k). It may
> > cause a large resource burden in extreme cases on devices with
> > small memory and a large number of concurrent IOs. So appropriately
> > reducing this value can improve performance.
> > 
> > Decreasing this value will reduce the compression ratio (except
> > when input_size <LZ4_DISTANCE_MAX). But considering that erofs
> > currently only supports 4k output, reducing this value will not
> > significantly reduce the compression benefits.
> > 
> > The maximum value of LZ4_DISTANCE_MAX defined by lz4 is 64k, and
> > we can only reduce this value. For the old kernel, it just can't
> > reduce the memory allocation during rolling decompression without
> > affecting the decompression result.
> > 
> > Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> > Signed-off-by: Guo Weichao <guoweichao@oppo.com>
> > ---
> > 
> > change since v2:
> > - use z_erofs_load_lz4_config to calculate lz4_distance_pages
> > - add description about the compatibility of the old kernel version
> > - drop useless comment
> > 
> >  fs/erofs/decompressor.c | 22 ++++++++++++++++++----
> >  fs/erofs/erofs_fs.h     |  3 ++-
> >  fs/erofs/internal.h     |  7 +++++++
> >  fs/erofs/super.c        |  2 ++
> >  4 files changed, 29 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
> > index 1cb1ffd10569..0bb7903e3f9b 100644
> > --- a/fs/erofs/decompressor.c
> > +++ b/fs/erofs/decompressor.c
> > @@ -28,6 +28,18 @@ struct z_erofs_decompressor {
> >  	char *name;
> >  };
> >  
> > +int z_erofs_load_lz4_config(struct erofs_sb_info *sbi,
> > +			    struct erofs_super_block *dsb)
> > +{
> > +	u16 distance = le16_to_cpu(dsb->lz4_max_distance);
> > +
> > +	sbi->lz4_max_distance_pages = distance ?
> > +					(DIV_ROUND_UP(distance, PAGE_SIZE) + 1) :
> 
> Unneeded parentheses here (I'll update it when applying).
> Otherwise it looks good to me.
> 
> Reviewed-by: Gao Xiang <hsiangkao@redhat.com>
> 
> Thanks,
> Gao Xiang

Applied to dev-test temporarily with the following diff
(fix 80 char limitation, etc):

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 0bb7903e3f9b..49347e681a53 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -34,9 +34,8 @@ int z_erofs_load_lz4_config(struct erofs_sb_info *sbi,
 	u16 distance = le16_to_cpu(dsb->lz4_max_distance);
 
 	sbi->lz4_max_distance_pages = distance ?
-					(DIV_ROUND_UP(distance, PAGE_SIZE) + 1) :
+					DIV_ROUND_UP(distance, PAGE_SIZE) + 1 :
 					LZ4_MAX_DISTANCE_PAGES;
-
 	return 0;
 }
 
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 4cb2395db45c..77965490dced 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -433,7 +433,7 @@ static inline void erofs_exit_shrinker(void) {}
 static inline int z_erofs_init_zip_subsystem(void) { return 0; }
 static inline void z_erofs_exit_zip_subsystem(void) {}
 static inline int z_erofs_load_lz4_config(struct erofs_sb_info *sbi,
-					  struct erofs_super_block *dsb) { return 0; }
+				struct erofs_super_block *dsb) { return 0; }
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 #define EFSCORRUPTED    EUCLEAN         /* Filesystem is corrupted */
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 11bc51e488dd..025c25d6e0f3 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -166,8 +166,6 @@ static int erofs_read_superblock(struct super_block *sb)
 	if (!check_layout_compatibility(sb, dsb))
 		goto out;
 
-	z_erofs_load_lz4_config(sbi, dsb);
-
 	sbi->blocks = le32_to_cpu(dsb->blocks);
 	sbi->meta_blkaddr = le32_to_cpu(dsb->meta_blkaddr);
 #ifdef CONFIG_EROFS_FS_XATTR
@@ -189,6 +187,9 @@ static int erofs_read_superblock(struct super_block *sb)
 		ret = -EFSCORRUPTED;
 		goto out;
 	}
+
+	/* parse on-disk compression configurations */
+	z_erofs_load_lz4_config(sbi, dsb);
 	ret = 0;
 out:
 	kunmap(page);

