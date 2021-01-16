Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F07C2F8B58
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Jan 2021 06:05:41 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DHmGB0pHjzDspx
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Jan 2021 16:05:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1610773538;
	bh=qkDUuVulVaOnSEftNeH6xLNJNuI2FsHlsvWI+OPnEqc=;
	h=To:Subject:Date:References:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=TScr9qRafGYfWtf905TVhwmmYJ58Z023NegAnjqbb5770WmZDYf+zOeS1DP34P2JK
	 7diyugPdJ8XJy599CPe1yvYEZx+BKqahkipj4OwXcl0L46EI33sZMTQlxuTDeUNsj9
	 0CMrOGxPZfJbulNpp7qPYcQKSy4XPWTfOiFhRMhjT+Zvw/5DtA0eG7v/mjzEgRnROC
	 cFRPcDNpon8h9DjZUqPcsel6eAv/k44mFyN47uam0K6dUJXhvBk8qyttT6u/eeICTm
	 igc45pDsyCjkHtPpgs7rLtAAaeXQiCjxZEno1pObfUJJCzlPFQzS3FPLmPbDFcnwr7
	 MlO3uke0wgBWA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.204; helo=sonic304-23.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=FlshPEXL; dkim-atps=neutral
Received: from sonic304-23.consmr.mail.gq1.yahoo.com
 (sonic304-23.consmr.mail.gq1.yahoo.com [98.137.68.204])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DHmFv14qszDspf
 for <linux-erofs@lists.ozlabs.org>; Sat, 16 Jan 2021 16:05:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1610773511; bh=3yzHdPefP8VceFtYN47a5qwmqOZ5kZOQYnt/4QPCFPg=;
 h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To;
 b=FlshPEXLJ6kXdMm5uB0x6YyKaGAjFb9HVLmGutdgpC5H7MiYHTga4+p+PR9NV/ngF4xJwC5Sx9VMXMlnjHse0W9ZleyXA+tgiVgJMdPc+gcrZCautNCc0niQdTBblGeeiM1dnkQxv9TZb2MW+JK2E5JDPysYFs0TNhw2gTfg3bqchJCud3A9inagAoTnUyZsLazSckn6c2MWIzUAVZhpwteHWehfckBM7nIW0pfZ8EUrgvl6dkn0lfMyTJQtd0LbgVV9Nfbuh9QjW7civiA+1RgFMK5bn+7/iUAwscuwOeegKEwoqEmOxmi19oiUFF/iveZGCIzrwiLOPR0fHPRhog==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1610773511; bh=hst1I6804iI9Q+NFaG872JH483H7RFKwrEKW8qmazil=;
 h=From:To:Subject:Date:From:Subject:Reply-To;
 b=qmANsBpgagzoRjNKd+4ABAOFx099GTFyVM08KRawECYC+ycFtKYlEE+SPXU8/chEPupOry4WY3gST6cYs/6lyn5wphq14yQ7n5ypdmaap1cT0H3QYPIxaM3+yizELYHNtWFI8e2JUolsyUrU81WDAh+MCRMShyWhJseHj1ZCpwcD76cyDD+2aUR3qPRvsvNxC7jaLm5m3TMvGCFXLTzCZ8kfWph+1+DJWrP0S387ayvcGmaWbeSftC6McSF3hqQFPAFbu9q+9MK2D55jI/cU6PLPXv+dupB+wkbQfcLQobdVtCSbKibephSjSE500Uqjl2AGGVDJB4CPNeUv9YX/Sw==
X-YMail-OSG: hMG002kVM1noq3LK7yTua13VfS4zXo19lUHYMZb5cJZnsQTAkiRlpYL0mpeTet4
 TI8ycovSJs27UpmoU0jkWU0V9VZoAsG8tPnaRMCS_vjJ.LQrpuZLQ28HG9zZgQT3T7J_gsrkPiQW
 F8OC2e2kl2shzwAuXJa_FH0UG2EPknRb.AktmNrOhbTsrdxwp8kjwlvGi93P17R3BJ0sRINWC3kL
 JwK0kn1ab7P1cdjxxxwBXXT1jUgCjgxroMevCRSV9kjsb0113AA5Rj6Yhn7f5.znUsNgUfdK_U6m
 Bl5CeZUxouEWarlXIpMmHdxhvLZ.PvVgQrflmVz_JatubWJ0E2hEEkKZMr.BLwJzFs._92tecRxq
 aLZkEQ11UOXOZgQnCGW9ecIE2zX0sBjKQ5lSVrYQ8lGHPvrwLuduyJSIgorpggB16hgeaNnVK_Oi
 eTSNJribAFvuMgEmFqVUJ8SmTMpJAuz0WA1owW_As73cLsiLfKZuWp_kZ3GBm0TF__k00snF.mCa
 tCMuC7DBYO.0vJfrfeTTa.svC4KZrVMqVEbi.iOYHj8GT_qEaQRoKzfF0XJbNGjxVv36ld5RkIOZ
 1XkDUaK81HwG7YC9rT.x8kv1VRiN5Rv61M57nlrMSSgiECKZYszpsn9Fh.BA6.hvmitvRipU_6Yw
 _CakidiqO.0RGNKyHUzvHK3gyjixqN5AK1qOl69BJ2t9Jb5DKEa8dNfWtZ0HQKP59m3dLKNurDdd
 P8bYqJjx2VgjpqDaAHgxM1qH2JgjjDjgkbZ36Km6Pu7QxesR4EhPKN5_157fjXxv7zAt9KnGzNWK
 WEaadpzMN9CNY7Wz8G0.vvLV5zQ8i9vQyT5j4xEuDZkoOv0v3BSgHoRui1A_HK7pMYJfO2EWB_ki
 vgPISxjx4kF2HznZE.mXxgVX1vQ7XdNiRxkcUdSVnSXJB__tzZCtiVWvDQz9VIBSIMAmuw0EYnex
 49_0aQnPEiF7Pe.VPkSQhqhusGqhAPAv.lyDEAYf8r8cdl4enBzpWfNdIdL8kR11ZxCENhZ.uR44
 qRRdJBuYNQbet2CJVJ2DJ4G.250U.EtKUgJIWeGuB6sOhwbpUIivNjnsu_6uIvrTy54ehWgEYCtN
 Py5HehTPHb7FzzTvw4LSwoUbtMgw3SSllqLBmf6ytqvZcEJb.bPEKi2HtgTwtjo3KiWihuAtvJIQ
 5_Q7.VLrVTiGjbaPB7LhNfudZXhbxPOn3YBDD5ShUila2yiSSWGlk3MRL_oWtdS_P3qlH4oAZhZL
 1LIwcot1iQ3WjLcKlbmV1gqsk9TjBqyXXYduMfpFgqj1Euh7Pjm2136R.9EfiMc64N9_DhlsheYG
 sxTKRMyjuwVbZEpvPVJfTbNaSX9Dp0XMXULTR_hvIjBiuzqrKvnKAzBsOqiUVKzagm.M_yvI2yiC
 jhEqGKFC4s3StBTxVaj8SHZuEwf5MZjWccmENNzvyXD4nTmMdPJ6Zwp2vr16n7j2cydcIod3b84w
 0Ks_Z4C7lybE254hJvMHe528bq9zB5Zzubnh__OhUzao_iq6PClrXI2NNpwAMgVrffP4tPkrzYhe
 ZYomHGG6f6BAV0IfIu5xNzmn1XdZWoul0j4mS9RuUnA7ufrnoScIVOe6zyTCngDoar4J15opbrkv
 gP8nH0uY.e_z.GicCOpMizfMUhyyuybxGrLNWfKTaX8JETFGbNEMT.ZwawNrJuqp3ijmwiS27FmC
 .jAKWN20p1oS.vwyCOlcBw23Ub02X6cENeDVOZi0tRkHkcprYB4b.CuUgH6Kai.XIm.Uri8psmFB
 6CZWt6OXtKUsA2xuYL14Wy27D2WKmrHg0B3ILeJaLz_bJbqhosPaDBRpBEhlItKvZRw4okDBrhq0
 NPThL45CeR4M7xoEvQM4_ifanBEWnSZsSs768sOwbKtQkP0w7KWdd366dS.6lm34xbWlzDrTeZn_
 tQZImtsDiSq8ZqisUJnfShc.FTNV19HMPrcqZSFlc3cVclK8qr5EXStOS_ytf.cLp1mexd6NpS8t
 fnIesnrEdUNe.ydLEAfGqWy9Nv3QEKsvyDL1GbzRAnYV3ChAjHmmiTtrl01J44dxvyZ_PJjXPFLk
 Epl_ZG2hoYg4Jd3W1oKjaeHJQD6Vj5Y.UwTfs8BKPSZfllF0qQfVA0wDoKbFWALkaBshjDYr2S0B
 a61J.Yifys7aMV0w0FPXQLrx.RKYKGu1xGkW4Psss9TDyubRuas8po8Mjd_MLDf8etUrKAYo1Q.6
 AgGmU_ZX6WxHYoNiYK.jvxOdbE2ZrS9FeQAu0_d11ScScrR8ZGFTE4gEv_aJX1jc7Ma6j4XYovB4
 YwEK.2mx7i3TvRmp3XulCibQiT4RBmoh2bb7ENt1y3oLoHwnl1MEhaA_VhjgthqIJBHUWTPZCada
 NN5Nojdn0epMUdrFUqV_MD0QCz95dmN9oo4mVsglzMxq4XcaJApSY9mceQTjb.lseVkqLD_a.lxG
 zD3zoFHZDG2Yyjyb14X6KLttgX8er7iKipxLDs51wmGvDqmZKWunVFj9rGgg7b9yK5rEZ.f6FaMl
 rFXwnN58fZzEuDtfM5Fdypk1IYxZp4U11mDxYJaqIt.EZ2HzO3MGgDi_6qHRyIsAtwblZeaQOO9t
 FGsLCwZJ3vcC27bYuoMxLZvz__DI0oELSObLZmg--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sat, 16 Jan 2021 05:05:11 +0000
Received: by smtp419.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 90b779082bcd82d35e69f3ea5422e955; 
 Sat, 16 Jan 2021 05:05:08 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 1/2] erofs-utils: get rid of `end' argument from
 erofs_mapbh()
Date: Sat, 16 Jan 2021 13:04:37 +0800
Message-Id: <20210116050438.4456-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20210116050438.4456-1-hsiangkao.ref@aol.com>
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
Cc: Hu Weiwen <sehuww@mail.scut.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Hu Weiwen <sehuww@mail.scut.edu.cn>

`end` arguement is completely broken now. Also, it could
be readded later if needed.

Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
Hi Weiwen,
Sorry for late update. I've cleaned up the patchset (mainly [PATCH 2/2],
could you kindly recheck it on your side if it works, and help me update
the commit message of [PATCH 2/2] as well?

Thanks,
Gao Xiang

 include/erofs/cache.h |  2 +-
 lib/cache.c           |  6 ++----
 lib/compress.c        |  2 +-
 lib/inode.c           | 10 +++++-----
 lib/xattr.c           |  2 +-
 mkfs/main.c           |  2 +-
 6 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index 8c171f5a130e..f8dff67b9736 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -95,7 +95,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
 					int type, unsigned int size);
 
-erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb, bool end);
+erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb);
 bool erofs_bflush(struct erofs_buffer_block *bb);
 
 void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke);
diff --git a/lib/cache.c b/lib/cache.c
index 0d5c4a5d48de..32a58311f563 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -257,16 +257,14 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
 	return blkaddr;
 }
 
-erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb, bool end)
+erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb)
 {
 	struct erofs_buffer_block *t, *nt;
 
 	if (!bb || bb->blkaddr == NULL_ADDR) {
 		list_for_each_entry_safe(t, nt, &blkh.list, list) {
-			if (!end && (t == bb || nt == &blkh))
-				break;
 			(void)__erofs_mapbh(t);
-			if (end && t == bb)
+			if (t == bb)
 				break;
 		}
 	}
diff --git a/lib/compress.c b/lib/compress.c
index 86db940b6edd..2b1f93c389ff 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -416,7 +416,7 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 
 	memset(compressmeta, 0, Z_EROFS_LEGACY_MAP_HEADER_SIZE);
 
-	blkaddr = erofs_mapbh(bh->block, true);	/* start_blkaddr */
+	blkaddr = erofs_mapbh(bh->block);	/* start_blkaddr */
 	ctx.blkaddr = blkaddr;
 	ctx.metacur = compressmeta + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 	ctx.head = ctx.tail = 0;
diff --git a/lib/inode.c b/lib/inode.c
index d0b4d51f3e3d..4ed6aed25243 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -148,7 +148,7 @@ static int __allocate_inode_bh_data(struct erofs_inode *inode,
 	inode->bh_data = bh;
 
 	/* get blkaddr of the bh */
-	ret = erofs_mapbh(bh->block, true);
+	ret = erofs_mapbh(bh->block);
 	DBG_BUGON(ret < 0);
 
 	/* write blocks except for the tail-end block */
@@ -522,7 +522,7 @@ int erofs_prepare_tail_block(struct erofs_inode *inode)
 		bh->op = &erofs_skip_write_bhops;
 
 		/* get blkaddr of bh */
-		ret = erofs_mapbh(bh->block, true);
+		ret = erofs_mapbh(bh->block);
 		DBG_BUGON(ret < 0);
 		inode->u.i_blkaddr = bh->block->blkaddr;
 
@@ -632,7 +632,7 @@ int erofs_write_tail_end(struct erofs_inode *inode)
 		int ret;
 		erofs_off_t pos;
 
-		erofs_mapbh(bh->block, true);
+		erofs_mapbh(bh->block);
 		pos = erofs_btell(bh, true) - EROFS_BLKSIZ;
 		ret = dev_write(inode->idata, pos, inode->idata_size);
 		if (ret)
@@ -879,7 +879,7 @@ void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
 	struct erofs_buffer_head *const bh = rootdir->bh;
 	erofs_off_t off, meta_offset;
 
-	erofs_mapbh(bh->block, true);
+	erofs_mapbh(bh->block);
 	off = erofs_btell(bh, false);
 
 	if (off > rootnid_maxoffset)
@@ -898,7 +898,7 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
 	if (!bh)
 		return inode->nid;
 
-	erofs_mapbh(bh->block, true);
+	erofs_mapbh(bh->block);
 	off = erofs_btell(bh, false);
 
 	meta_offset = blknr_to_addr(sbi.meta_blkaddr);
diff --git a/lib/xattr.c b/lib/xattr.c
index 49ebb9c2f539..8b7bcb126fe9 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -575,7 +575,7 @@ int erofs_build_shared_xattrs_from_path(const char *path)
 	}
 	bh->op = &erofs_skip_write_bhops;
 
-	erofs_mapbh(bh->block, true);
+	erofs_mapbh(bh->block);
 	off = erofs_btell(bh, false);
 
 	sbi.xattr_blkaddr = off / EROFS_BLKSIZ;
diff --git a/mkfs/main.c b/mkfs/main.c
index abd48be0fa4f..d9c4c7fff5c1 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -304,7 +304,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		round_up(EROFS_SUPER_END, EROFS_BLKSIZ);
 	char *buf;
 
-	*blocks         = erofs_mapbh(NULL, true);
+	*blocks         = erofs_mapbh(NULL);
 	sb.blocks       = cpu_to_le32(*blocks);
 	sb.root_nid     = cpu_to_le16(root_nid);
 	memcpy(sb.uuid, sbi.uuid, sizeof(sb.uuid));
-- 
2.24.0

