Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20DAE30095A
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 18:12:53 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMm6V285nzDsMM
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Jan 2021 04:12:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1611335570;
	bh=bJSwehG8Ea5Bcr4hhX2h1qtfNwcllj7jrewd+wAGcoo=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=W9ioW/DhKDtRYzKg4Aq0nqjrVBeSeagUbW3fVr0U9nqGkrNE+NL2luKMjyFWXypUL
	 fpOzlcV+mRNVEegqv37H1R+XfAoGBCPM6kjEg48TIkQEcwnLkw5GpmWVhZ4n0LSrQK
	 7+50vcvDj48+p5jVOxyKwfSpVZJmHmsGw7f7yoLerMZ/MZ7D64eoMuvDNJtlNnzQMJ
	 pq/wR768H1c6LqngtBJTzgygzKoGP4gUz0E1k4x4LIX6sZHY9DAtU+duoai1Qav0HF
	 N0EqdC2pLUq9I6TKTe1snrqvRgZgqavNLqHrNM9z+4Pwz2wRA5lqVAFKFM58YRxwUN
	 nvGNNeunQAULw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.148; helo=sonic301-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=NwPV2dyn; dkim-atps=neutral
Received: from sonic301-22.consmr.mail.gq1.yahoo.com
 (sonic301-22.consmr.mail.gq1.yahoo.com [98.137.64.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DMm610FhhzDrnp
 for <linux-erofs@lists.ozlabs.org>; Sat, 23 Jan 2021 04:12:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1611335538; bh=T6IRk9KzVcVcpj4NGj4t6gyNXkvXreEmxUsQ+Smviwg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=NwPV2dynvRGGH/3J/yGMsja5I0ArA0bzGBsZHtf/BhM9Fomuh/6cjdJ5QCLocYQWg/4h9bJ4nHSGLKkARcx4hWGrxQ42tIiILJphSpbir5G3ZbTJhcmPqRhr9b61qMINvTAyZii3gh6Wsvfnd0/LTLOSVJnCwQKkHDEU+9PqHKA5Y0vkyiWPe5jq8k2mXlQwFO1oHmwwGJD18Q/MzS5hJB2Y/EDINRPjqPBzDtUrHH00iOn1k8Ejz63hCE4XynC3dYwHhbPYcLQsKWD1/2vTTPeH8L/Q34Arb6BoW8c0CdFQHkrIycc3VBukcDNvPMKKkPgpy/3VOpWU42WNHx/Kqg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1611335538; bh=kS3F/0IZwrF7xQdget0fE3G7syRF5YddrWYhHMHW41j=;
 h=From:To:Subject:Date:From:Subject:Reply-To;
 b=U6Oav/jEnCz7+EwsYPlE3moWMN3MEXFCJRBwsx+wBYR4429xWsTfWpB3ZYb78nIGP4/hBWiGoctY03Gub0KN3P1F3u4XA27kxxVZfSTakeRSIeGR/ruTEorW4Pr2a9gi3z4meIBap2UPuQEU8waNJ7AAu9nxLN+aCeISqxKBPgi77H9GnKysoro+LlRH8ivTHiVyH5oSgzgvK+Jn+bE31BNnj8Wkds2AYL789W3DeRr40xe+lHeeAkBzCugIG5x18Rk+yqPhDal1A68CxfD+Djrk2lCfIeC4t6n9fSMh1h7BJbETiq1H2Jco96HPCCiyRoIz8HV6M3zGsSJRwIxy0Q==
X-YMail-OSG: mifDiQ0VM1meSzFORiTTHnpBibDEqUzBHwWOEscw0LtsusMilxaAgUJ3tHHVe6.
 7iRvwOW0Gd6eaH16j9eIK2hmBCjI4OkhbCdZvi9Xiqt3AJqSAEVNs5rmHxLpevyTuTraN7bfyHRS
 W_dnjg3fyg0yOJvjPBEMi8gRWw3qWcOFCRI3oHnzOsytq4adAH2CG6NtiBb2bYr27h.7HxNXDH8U
 RsC7CncygY7yGeQFFTrJSp..wOdGFcmNMiMWon.VIbHSBYvLhWOPRa3gv7zM3Cu8irVSDx84h0Cu
 QS6T6b994Lx67AoLg01A4NfhFA7ihiGocvkMyxm.B1_OTRfvb._UKcpOyHwEiyqxS1wU36WMgBIB
 WcF01NRKTlRjM2ezxTNrDMdsRtFLxcd4qV5RfuWeF.UMEM9A3ZdZ1SJCZdIqf8DTKe81AjKLBtvt
 SYYgXxDDoGhbWZ8PhmZ2SXwHkwnpCJ1LOonTp1wOkoR4bh2jRmV2k6GptQ7wVZxAa5EcGvN.afAv
 g9N5zqK1we4tEtbSfbvFtv2hKdohtP.OvSDSzJnqS3RDcf.njkdD9Qwc4FPrXj0L_FZa0gaV3Dv0
 .6WDNCF35Un1SlNDPrEo5621nvgXUai1aaE5toj.JsJbxAx.pu3mXzxKuX9BKHw3QRVuWumGgxu.
 iL_cx_fVetwQC91kWP10kfs1aIimI1WH5tWgcv1m5OUjRKi4gLyUG8rpCh1Bnvl1IAcyFfmdZhDg
 w7d7G7YvdcIZkY7GX_Ofij2pZoc4oqf7ARlbPPRrzdIokGa1EHHv.ehINm3pT3CT9d0goGG2am9g
 4PMCKWGywNpJ8dwAUkp7BH5mJ07XilyolL19aSAWCS.rFriZvPjaNmrfj0EjaJdJLQr4bzxstzNF
 _3P0zK3e5_oRyYGO3YrOXqMHbor9yW8U8Uhn5e3qZc_bxGJtuSCaTpf9MuJU7ohINiwOYzVmKFJR
 tNvEzfVRVI.bbgNyRZ6zHjNV3wfoW2_5PyrhbH3V8e92KExFS2AYolQep7cBSwPQw_Z88.2Xc97F
 olK8rXP2Pqgjy1tzdWMCb43EaqyzKK64Zi6KxTUMxReVKBPWAdKMDkq4KGy7YSs_TN2TyjDFuHB1
 pYZ3oi12.8qcZwI6rO9hdtDsUum3BSNR9BDCQcwxA7oSwUfThX1E_8vUtfC_dJUvDuLtbLe76mIA
 .LwpMqRFq1OkXIzoAftcI1ZbOpfbWcXyGnVf375deScAQSReuaKqL5PZRMBn5F_wce8XrC9YG5KJ
 K5SMnj7KxJz2PsKz2FH6aPtolh37KF0dGn1VgFmK.WNfa5HPBUu8WG_uZkBtPUC7I7AYU7J8sVct
 P11ClwBpD6GFQH6ZZWNDutpAo3P0GtYn8Jmv0OADhOqeFaPPWsS5wQJ2jFe4ozg1YaOm0Zlk_pJd
 aHdDhI51MNAn.S9gtxEjpkehKQLQq4015m6FONz0MIHytL1e7D5WpyvNEXW7HKDeyP6o5yzMz4E3
 oeiV21OE58YzkjPS8n1xoHYerHnaXhv6Il1ZWYF4lx1_0a7CyTVA..aKyaVxW.ljzTo1PRQ5m8QJ
 3fu15Nd6QLHy6DkpJ8yMrKs1v8RNs446acmdX60jJUHwJ5ElnvCoL_Rpw4kkd2nA1jQA1jX_bjB7
 78yIx3M9niZoyBDSWVC6H7nCCuUBB3.EjC71aoA.eab12uSiZNalJ9qiRCx.suAR0RDpYppR2UOY
 x73m6WpihdeU5NDMlJqgYdWtSItuQdBJJWqy9TZmjapHn844G8X0Jp1lNAopwVURrfJOuy3R7pSR
 EJJrgEZPT.hvORGwdauETDE4Knd8l9DbHVtKoLyg1QZR83iyhUjiBvzum4uodjnlIfvxzBOVKwxP
 myHmgSV8wpub3DFg5KPS8qeE6ZwpZDvil7Z1YT2Mvwkz3lXoXsqTouaaa.e1Z.0ccOgCrxx2WjPU
 2PO6lr8rXig2mEsK1NTyjh1dKuA_KMax7AznsMdKJVi2XGsJ2cf7s9m7r7bnlUoAru9kYqLvn8Tf
 Q0CjANb0sM1vz8LizP5VWNV7ODBvS.ma5PRXIaraU31xEUvDbj4FHTtRRRRCVjx4N_j.gI07FfQf
 3glnMPxNslIVsmYoUKnc_6FKISEMa_5jkou2E_T7rd9HaQprE2FIjSVh._E63yo_WOj.l_TB74Ih
 BGZqD2VWxFWpTEQcj0Urv56dQY4FuMWTk06PbppHOB6vIpTmYCE.f6VhUvvuAl6g0yuC1G.rsZUQ
 XSYEQtE2_B6n0VOso1n3SLp3Ip1Z9erLxy.8kbQDWDlAU0LEHG7RtOsgFia4q5FhlkF5wUsc5SMe
 OCxhDFeaCgoyzyT2jGIAwbKZMurAsXvOp1CfdiTTTc.Ha8nPgS_jJCvxjimKUn9jpCE9qCAVnppG
 c5mleABgCAms_P3IuanZun4rvEpU2EqmzBkCrNTV5COrGzKo2y8485XXZ9V.J0WywvqWn14K4dRd
 rvHeCQXXe5sDqCIz6p.SWMOWdYBe9yUDwP3NJakU8x7ftWYDqm59gzjhvke9mZfLkeDGIHhj.Hvd
 Y2g--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Fri, 22 Jan 2021 17:12:18 +0000
Received: by smtp414.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 421cb1d2e6456159bc18db7d03d7fd0e; 
 Fri, 22 Jan 2021 17:12:12 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 1/3] erofs-utils: get rid of `end' argument from
 erofs_mapbh()
Date: Sat, 23 Jan 2021 01:11:51 +0800
Message-Id: <20210122171153.27404-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210122171153.27404-1-hsiangkao@aol.com>
References: <20210122171153.27404-1-hsiangkao@aol.com>
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

From: Hu Weiwen <sehuww@mail.scut.edu.cn>

`end` arguement is completely broken now. Also, it could
be reintroduced later if needed.

Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
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
index 640068f4147c..ee0afacd4b40 100644
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
@@ -881,7 +881,7 @@ void erofs_fixup_meta_blkaddr(struct erofs_inode *rootdir)
 	struct erofs_buffer_head *const bh = rootdir->bh;
 	erofs_off_t off, meta_offset;
 
-	erofs_mapbh(bh->block, true);
+	erofs_mapbh(bh->block);
 	off = erofs_btell(bh, false);
 
 	if (off > rootnid_maxoffset)
@@ -900,7 +900,7 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode)
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

