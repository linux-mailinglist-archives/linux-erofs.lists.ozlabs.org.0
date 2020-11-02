Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id D745F2A2ECC
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Nov 2020 16:57:41 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CPyH70jtNzDqTR
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Nov 2020 02:57:39 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1604332659;
	bh=4q0ZtP79jU1mW5Glsl/HPxYdXLiZ0joaKMRoRGnvQBs=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=WKTzoUf1F8U/D3KIvx25AEXYjQkrdj/YlUbMvoAmnrYnUA0RYomaIG9bVSwbvnD6t
	 xcgQUu5sxeRPkW+vwMyKS8QYjrsf3Me+76150dc7/8urN2P1YkSmW9GR/NSa+w0igG
	 yCOTlLK8ZeYl5gRarloSt4tWwZ5a0md7iiuJ5rVQ54UuxPdfNt7LRXrSv59jYZruL8
	 13ORb5b3Yz48dJXmeSqBUGsXJ0HLm9BXoQk/MvxHXZekly8yFR4EYLiYoW8OIcZZX0
	 TnVfKdckdpl7mHskOcAfL7ENaBUbE95EfIR0SB8YMJiOhmMmYJNZbAOCbv5u13XnII
	 7VvJXZjGavUdA==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.31; helo=sonic307-55.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=pqL7yqKm; dkim-atps=neutral
Received: from sonic307-55.consmr.mail.gq1.yahoo.com
 (sonic307-55.consmr.mail.gq1.yahoo.com [98.137.64.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CPyGR5YFLzDqST
 for <linux-erofs@lists.ozlabs.org>; Tue,  3 Nov 2020 02:57:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1604332620; bh=0j09uCoopdU6pOEx+gSd2p8R1rejBuZJTg/ykIpNc/E=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=pqL7yqKm1hL6FKozgrpXAAIaqr0PvNQYd6dt3dXeoZJoC/Td7J4mlE2l4odG2RwnsGt+skiJJXxL/jEe0c0/hwC0YKWkbJUDm6aX+1akhLBPMh4ZaWDk5w5hpMMfwToex0hrgAIuhWIZGnj//PAVg7slP/Ed27jTM9AssafS2zpdY36lfvpP6j2Kelda6niHe3GUDDZm9M/5figShDgwbL/Jj7D7x+F92c3Q+g143pqkLYBtpHFaTLEDk3nR1IjLOfsajUj8P7P/rgU+5bw/Nr2WtYwahMyfIs0Br8CXMXZrfGSS/Pe9laQz412C8rQGqIiELTtk0+meMQJHfEPJfA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1604332620; bh=PD83kuZIWuJMFog5zrlaM6ud9w7J7SR3Ks0EPVY2N97=;
 h=From:To:Subject:Date;
 b=HTje8wt1s0nymP20uvN2PR06fJ2zhpe02v0HjII5ku2bXe9dkBJFM8JB3t8v7cjr0GYyaYqVeEyN3BtFuIhyHeXhee5m/GLgrrqsqf3gq6VSiPpzFVbwxz8A4o/PwKvAHpwXjBdlTT4bkMBMpPbvWiEnuNxSo4gltm2lxI8CjmtXIrrr5autrLROwPXss8R/9lJP6fnYSMUPe4kaRfDb/R12zTQZ4j4YBbHsmVORRz8DGMPNdjs1a7Qgd5kehzaKAqH3ofYrjEJprVm7QUKYRdjbDunn52ell2LsOkopcBI2TVQtA9YDtmdQraCExg4Aa8NNpuISZiq+Fvjj92P6cA==
X-YMail-OSG: VHKEK3cVM1lPx0cV7UkuKkwsF8m1oR25zxUJ6PyjvBZ5FV.phTXMohb6aQWm3Pp
 ChWfwRIsXGZqTSa.LTh0aOgIvtO2B_wNTxynNq0RTxKu8tjR77UDs9uzgTm1KeIskswm4Yh7oWOr
 QN1lxsjuz48VhXuoWvgSbvGYukpwMjKnuU_zf9inJscNsX85T.OExvlzp7Ln5E2AjRuFu8Ywipbc
 _aW9gV244sKU7W1kp2TsCtgSR37LtZa4NForjTOoB84eSJvu3AkiUKpHJVHXDoNTF4o_qzYgZqZL
 Np1KJz2EO3cwq3llU60.BhQfU5YmHBBCis7mcyID4sDjPMTDHL3GalxIXbcHKdegs3K9wVvYbC.v
 QkHQNSTzPdC12TAxYjgTyleC8aMlBeoOTF7lx6CqkKDFj1ocEAHBbCYmK.locGH2qpNieEAettIu
 hZJON1Jn3YgQfhR6RlCy90a4dwsxQyXZvDvA86.uDNn0fd1WJiKwJJzdEaGcj9SU6.GYNRA0jLl8
 _79k5Q6owxHIAwsd5MFyXDkbSql5ZuUm77VHZFwdC.DiwMm1CTLDkG3WJPWE5sijLsSFkNW27s3E
 42z5FvC79jb7ZoO58VsKpjlMU.P4WpbYJezgrDvIHvRV4Uv.i0qKN3ys2Rf1rxCSDJKbaWfEc8PB
 nBBLMj1Mp6YnZvoi85wOFzylZ_BrbqpLjgy1xQEY0ONRxz1IXrNOvtTvVhVI8HB_CWH9aOeHBdTI
 JYYMqdMEe1Yc3HKrrp6wwVeitEAtDMzdgDg6TmoGB5TqMNRhLntsj827uZrUvWubnS4H96Z0Ouk9
 kYYCEDESAPsHRXchqzogYFDS22otYDzcL6V_qjuRZhOkBi6.iNG0J6ALzMuO7yzD89UD.tkWr5Us
 ohA6R210JpXVj9LDAHbi_RY13a9TPCijNH8EqEYRZeOpkVvKQhzTI6Sx1Xk33cGkqLh2JVBYtouB
 2F2y7XrhIij2nvPGv_cQJPEk5MrP1U7yxmaQcuZhU0a3VFU2AJLJxhc6SMWhARiAi66lNuZWy8Gz
 acqgkbeTnQw_Wh9TkfSAfGIGT8fvQlWsVAeu.FDpUJi0TRa0Dhnr.38xNLDrnZ7gMVSnsjLdoVmo
 UtwqjikJ1sOqGJnb_d1Q6NH.ShThmZjSaak3xRqg3plTCmCy8c8R2fd3oaFuDN4FyOstjoPDMk7s
 NKkvjcPlQ6L6PeW5Yi5aXxJhabgPZhIsmpzsxmUt39r6qxgg_T8pKbUh5L5dzs7eUQf9DCv2CUyg
 oQx92VDXraYZhiRrcQXK9fUHgN_P0i37FKSVJ4O48VGOcOqyKtiblHE6LTKJuyaJltZPccOoVilY
 K7bBG9VWY.c18DVeWPIg7SlXJER2JtP4qUs0cAoeyNBD4lcIjilnHqPRQLDvDDpfyCSGleItltKp
 LtWWZPaFgn8FPXWzWmzpQYqUIJqYR08M7JGBulR2t.8WWoSjuo1taa7qDO9vNfSPvhlcUs0DeEeV
 PysmL507.ZlqWmYUr5n34V_MyqDBz.pXyVCZVehOMXkmREvd23.NAaq7_qUUM4bjdt2u2JsPrw8i
 tg.DspH.jyTqfOoBg2EEbeGtajZBKyUUudj5t3Kct0vYyGDBjZ7540.RJsWpTjDCqf_gP8hthuYX
 LaFZ.iaRKcSHgch0RS55exzjIuVws3Yz1JWQHo85vwoa7TQgTJXceZ7ASHkGq_5Ode.E5F1CBSTw
 C9Coxh.ZhoP3HLL5DVIBYory.n6GkjNjRwvxeJbtRcmSJElgZjl7aFGV93OlZ999P0dsbTocqG8N
 P0Y2a.vqjVFuYt.znI04dKn_kG_JmsJrWBq66QsB7t89.nv3Gd5ntzzGGiCPCPXXlZ5txEk3n0bg
 P2Yn8IiYhKEIHQsTDKiIvGQWKwENYDcHl9P5.PfXwGz1xi4zFN7odc8qWYmUlOnv8GXyCfD770Ds
 iEvgXFKlSQBBQnYVhFGqYr6iqxcJSWWpU1PccOifGDZPGMyUJ7eI.MOAjNgFKavVRLaw_mYcnPT1
 rJGkR78HptdKBYZ9Wth_t5nD0QBK7TV0KnZxLzgG7eswvBLjh_XH3CVE70bMaQZxqrk9u9M6A3Xj
 5PdpIcMjf1t5HzvMP2EkrUFdzS6yOC0DTNT4tlzmG32XHIkU_HT_hNZmcNEU1hTxE46Pj5_n0fUt
 D8UF2xMPXFmkVsJZsLPha7CHvvAWpXmNifYkXD8fjhq7kviiyj477Hyu6Nh6VS3IduGXVYtuPPSd
 .yAcLVNgpnM1HKhio5IV09D8qzwZupDdcylseXRWcsIXUsDMCsd5Yj.mgmDxGNTbcDvhpZV7tWv9
 cahPf0XE1lVJWj.lpIigqbPOn1rfzJ_cESrdPlPnyR5bgd2luoGY0jSujg1YaPYuP2w42jxvTXd6
 _OHmOiY0pctTLag_siTscRJZ9huU4uoSdTiXEB_3uuBgDZIekfkCvMcafR3MAwAg2xEEoJgKuDoS
 EGdUxPkmcRcUACQLcJ9nleja5L3wwlv2_2llID1g0PkLdDHqj19vM.2NwaVx1gb6l1RF6n787_ru
 QYyQve0r3dS7DEWCRtQIpJlmHqFBxZaffzMGaAkyf4s2zHD5uaxvP8XQqpVhDRQGS2bdjdSSRdSA
 B4fjhqfT5UH0170lRyk7WriAqcNHnl6wp.LPY0D970LIP9PrA8FMMpPfQ.OxbmLDAHgqET9Yx0LU
 HWxSu89HhXXMG23eUnwZHK7s40h0MYnViENszdKZGzPN4
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic307.consmr.mail.gq1.yahoo.com with HTTP; Mon, 2 Nov 2020 15:57:00 +0000
Received: by smtp404.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 0de93bd81f6e7581799539af1246db07; 
 Mon, 02 Nov 2020 15:56:56 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH v3 06/12] erofs-utils: fuse: kill nid2addr, addr2nid
Date: Mon,  2 Nov 2020 23:55:52 +0800
Message-Id: <20201102155558.1995-7-hsiangkao@aol.com>
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
 fuse/init.c   | 15 ---------------
 fuse/init.h   |  2 --
 fuse/namei.c  |  4 ++--
 fuse/readir.c |  2 +-
 fuse/zmap.c   |  6 +++---
 5 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/fuse/init.c b/fuse/init.c
index f3f7f9750468..b4089a204409 100644
--- a/fuse/init.c
+++ b/fuse/init.c
@@ -88,21 +88,6 @@ erofs_nid_t erofs_get_root_nid(void)
 	return sbi.root_nid;
 }
 
-erofs_nid_t addr2nid(erofs_off_t addr)
-{
-	erofs_nid_t offset = (erofs_nid_t)sbi.meta_blkaddr * EROFS_BLKSIZ;
-
-	DBG_BUGON(!IS_SLOT_ALIGN(addr));
-	return (addr - offset) >> EROFS_ISLOTBITS;
-}
-
-erofs_off_t nid2addr(erofs_nid_t nid)
-{
-	erofs_off_t offset = (erofs_off_t)sbi.meta_blkaddr * EROFS_BLKSIZ;
-
-	return (nid <<  EROFS_ISLOTBITS) + offset;
-}
-
 void *erofs_init(struct fuse_conn_info *info)
 {
 	erofs_info("Using FUSE protocol %d.%d", info->proto_major, info->proto_minor);
diff --git a/fuse/init.h b/fuse/init.h
index 062cd69f6e4d..4bd48d18b003 100644
--- a/fuse/init.h
+++ b/fuse/init.h
@@ -15,8 +15,6 @@
 
 int erofs_read_superblock(void);
 erofs_nid_t erofs_get_root_nid(void);
-erofs_off_t nid2addr(erofs_nid_t nid);
-erofs_nid_t addr2nid(erofs_off_t addr);
 void *erofs_init(struct fuse_conn_info *info);
 
 #endif
diff --git a/fuse/namei.c b/fuse/namei.c
index 79273f89be1b..c3766f9a9f02 100644
--- a/fuse/namei.c
+++ b/fuse/namei.c
@@ -52,7 +52,7 @@ int erofs_iget_by_nid(erofs_nid_t nid, struct erofs_vnode *vi)
 	int ret, ifmt;
 	char buf[EROFS_BLKSIZ];
 	struct erofs_inode_compact *v1;
-	const erofs_off_t addr = nid2addr(nid);
+	const erofs_off_t addr = iloc(nid);
 	const size_t size = EROFS_BLKSIZ - erofs_blkoff(addr);
 
 	ret = dev_read(buf, addr, size);
@@ -173,7 +173,7 @@ struct dcache_entry *disk_lookup(struct dcache_entry *parent, const char *name,
 
 	if (v.datalayout == EROFS_INODE_FLAT_INLINE) {
 		uint32_t dir_off = erofs_blkoff(dirsize);
-		off_t dir_addr = nid2addr(dcache_get_nid(parent)) +
+		off_t dir_addr = iloc(dcache_get_nid(parent)) +
 			v.inode_isize + v.xattr_isize;
 
 		memset(buf, 0, sizeof(buf));
diff --git a/fuse/readir.c b/fuse/readir.c
index 8111047803df..496f4e73a9c2 100644
--- a/fuse/readir.c
+++ b/fuse/readir.c
@@ -108,7 +108,7 @@ int erofs_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
 	if (v.datalayout == EROFS_INODE_FLAT_INLINE) {
 		off_t addr;
 
-		addr = nid2addr(nid) + v.inode_isize + v.xattr_isize;
+		addr = iloc(nid) + v.inode_isize + v.xattr_isize;
 
 		memset(dirsbuf, 0, sizeof(dirsbuf));
 		ret = dev_read(dirsbuf, addr, dir_off);
diff --git a/fuse/zmap.c b/fuse/zmap.c
index 9860b770362c..cb667da4e0c8 100644
--- a/fuse/zmap.c
+++ b/fuse/zmap.c
@@ -40,7 +40,7 @@ static int z_erofs_fill_inode_lazy(struct erofs_vnode *vi)
 
 	DBG_BUGON(vi->datalayout == EROFS_INODE_FLAT_COMPRESSION_LEGACY);
 
-	pos = round_up(nid2addr(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
+	pos = round_up(iloc(vi->nid) + vi->inode_isize + vi->xattr_isize, 8);
 
 	ret = dev_read(buf, pos, 8);
 	if (ret < 0)
@@ -110,7 +110,7 @@ static int legacy_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 					 unsigned long lcn)
 {
 	struct erofs_vnode *const vi = m->vnode;
-	const erofs_off_t ibase = nid2addr(vi->nid);
+	const erofs_off_t ibase = iloc(vi->nid);
 	const erofs_off_t pos =
 		Z_EROFS_VLE_LEGACY_INDEX_ALIGN(ibase + vi->inode_isize +
 					       vi->xattr_isize) +
@@ -228,7 +228,7 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
 {
 	struct erofs_vnode *const vi = m->vnode;
 	const unsigned int lclusterbits = vi->z_logical_clusterbits;
-	const erofs_off_t ebase = round_up(nid2addr(vi->nid) + vi->inode_isize +
+	const erofs_off_t ebase = round_up(iloc(vi->nid) + vi->inode_isize +
 					   vi->xattr_isize, 8) +
 		sizeof(struct z_erofs_map_header);
 	const unsigned int totalidx = DIV_ROUND_UP(vi->i_size, EROFS_BLKSIZ);
-- 
2.24.0

