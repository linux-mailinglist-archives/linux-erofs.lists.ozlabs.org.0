Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A93F2F8BE7
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Jan 2021 07:31:45 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DHp9V2MKKzDspp
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Jan 2021 17:31:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1610778702;
	bh=P/c5pdk3PoVORF66z6CWRe20m4hC34ZvYNP62LbqxtY=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=QzwhwQsuX4P2Y/k9S+BWuiiKIHcLc2oVBmUqTdGY7nN2OxcR06nVL5w5oxtgqx6a7
	 xqAd8PsYuAYRLJTIEpGSO34q2xw/ZUszp7yX+h27z+s2yrpC8/37njFlmgdS63Jti/
	 SPykJpcKyNHbtLAkxRhM6g2J9Ul/MKvekToreUA7p8OPFxqCWv22rfmGaVi4mr9n5E
	 CNXnl64U2J0nNgEj0AV/V7HCFvqyMUZy5r1LbkfT+maTBJtwQxc5CQhACAbc0baOS4
	 0/efcNQQsZUI10Q8+POJ0CaiUX3i2riyV97StPwSfdV6yK2wI7YfVRSLWrjvqladhA
	 +f5C196B5w0Hw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.146; helo=sonic301-20.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=b3n1rvtY; dkim-atps=neutral
Received: from sonic301-20.consmr.mail.gq1.yahoo.com
 (sonic301-20.consmr.mail.gq1.yahoo.com [98.137.64.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DHp9G12QlzDspX
 for <linux-erofs@lists.ozlabs.org>; Sat, 16 Jan 2021 17:31:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1610778681; bh=0+OEaHqeXf+EBdVgvZtTIIG938bsm2lKRZU529k4Ut0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=b3n1rvtYDGRDSQSQ9wuC+OvOx6JZsA/r8lT/seuLxb7DU7t2KguPXRpMcLFKO89nShv0fiAT8BsZN0RF0pCloueVu0/ilJEeic+iYewXk1c1boY4PEPWZzr6Wztx1DzsfoM6VxfbC8Ta3FO5nyALMmL6yKs/xOA0NnJSd3V8bbp6/y2VCel8UcQiDNOOceSHCbp0joN547uyQxjNnK23JnIQVPukyY8SP57QK18k28kqMPKnw+DExBLZ9W64HC6al7wuQ5+KJwTfZXlInGkbbV3iitWx/WOnHLh6tyRTllQuDNVrQ5yV6bsSgBDQ+ZuTDw/E48vyD7S4jwYhEl5jEA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1610778681; bh=kxWAVO/zhu76NVMF0KP5aq4LtM5jivAmg6ceIIh80YJ=;
 h=From:To:Subject:Date:From:Subject:Reply-To;
 b=LCGtvLUyH0tDYeyClXpdIhIDBuqAeMWz9TfYm7yOa1CH/AQQ3RGxi6akTodRiMpOeRJZTCb7h7EPJU8LOXtY/wXRbaQvRO3DA3U4fLm7XhXDpAliyif3aqhfYWj/DvBG93ujgJ996BMeZ4cyB6ZpP805QtYCu68bC01+aOJf679n0VzXCUZYUX7YDRltT8LJlEIb1ZuA/S4LbhBrfhiY8cgq7aU4imirXosPiuWj6eVFlwjrvx9M0tepd9ieM92mvhPMH5Ddx9HWeL2fybJdWIQiOgbLIC6REEIeUj543hq2nvKTv0r2ccJC8xFIA7/QgGHg8MWlYPK+TEhzgr6K8A==
X-YMail-OSG: G708qMMVM1l7oV0nkRfl0BGE3Z7ZYVGHOtSNMJVFfTV9pEHlpNA6ARpaOYZBiFa
 3ZL7nzK3dyKvY5zorB.JcF679t50MaU36nXwCmv0ozyr7b7y.9kUWNMMrFzBnxHZ5BkPNPQ9ysFg
 4.gO.VFRlTZHvFFa4WnrWrUDkYQXA6_r0zZ13wCdEMyOTatOVUZcaa32A7lHn2I8V1lFnr5PNq1D
 8RqfS.ELZC206pfT2ijN6uO1W_6KpGm1N7WqJCUM0DMkRbcf64msOYWCdefM4WT_yPxfx7X8LvSP
 PWBrxBbcQdRWdLzELAEIErb4SdoP5HVIoxQlqeT.3h9Z6KRZOKhnvq5pf1UVTFnN33o10gDSzfa0
 hoLCGRXMRagHac9P6jIojUIg6BbCNMVdQrZHGA5RxQSUnr3dEhc7x2dQZsyd3fSIm_Vcaz6qroqk
 dCTWVIT3HKSXXDkAh_rXU_UNt_esNNMawt1TUpJOgm2GhLinKo5uSt7YmXSjzMW2PmYnrqwDEWVk
 BElyBLH3E6UwRm0ln88QXhqedzM1V8UPppCHjFFamb6l6bh1MuOFImDCgFKhq70Z1.N0KcFB_t6p
 uxI2cT5Kh301ljhXZSN5Glzal2ePMvKryMBmy3QSFgjQvXuN5rc6zxrpVi92aWwxYmIYcV1NKKul
 25FBasFITzbzhsJUzWp3U7IJmSiqVyXjQAmJVM842XwgiSrlq1H7mY2nLZj0xT1AyIYiBsdLAtyv
 FqhEdDeEPKwoVgqa5NAVHFuTbYk_WJE7K8oOjtPHZzeP..Jk9KjES3eH4gz1PkqsvZkDvgAFQwu3
 NMhDArzCIW6Ahm7.twQoyiZnZmKTUhDSLBvyOC1_3RoduXkRG6tlqOb1W3RVS6cb_8zhjId.VYsd
 uevrlOeBsL78U9eXZJyY7wOIPMHFb3pffVeZBhCZFWp2uM0YSWAOKkA_P6uxvcDvr1grNJJ3Kldm
 SYHYa8keOaj7bvJhBdTmGMn37NctMdI_URB7AtAIp5vm.PLaYsmm3LWoHhyYVn8hNJi84EAryCk8
 ko2E85I1Lj64FVaXmpt0iDRJgU3EjHAjqxr6yi9.VHUQsGwHvKpkY3vEJI7vMTl2E6.ibmmQ_nYu
 0qiS7WpdrAgSNvZvupnQBoX4XRU8mCm0X0Oiu08fWiQAMWKaPS23bc.9qG02GAMxH8lPQv1i6vo_
 1Yy5PDhAXY8i.78XF3ws.X9UUqbVvARSD03TTTmV0PH3kewBa7omlTkJ9nXruIAvn4wrPPdOyvze
 j.clryuBVJpOGJJE.IL8WjeVzdfv.6kyVsg5sZW3bCrlbShJhuT.gyhRgtn6XcTfp0zJtXYaNMnU
 hslMRzL98el3itRs0CY1dko3RxDgdwjsHH5ckzxXHx5tYC6BQXGdKsoFINQvYpPwa88_woyFwgyg
 BQuTjCPnc6njmgP1usY1Oh.cAdCr_gu0jZIvAS5sKhK4ZX5GDZeV18BLiU5srbNbyCuo98YGObNq
 RqlvFuK84f5DUs_oY7deKEXVzav0YE0qcGtGITsdQQVH5MzM3PIWVjH.v3yL7GeezeijGSrhuYBe
 G4Byi340Cyumxs5qE4MAJRKFl3_pY8iSNIoJfkEFFW8z2nwdFn8tzDUmZV3yIL3XJ2dIxgp2q9CP
 AyrDWhNAHq1UrqzncbkarfNB72oHKenez3QNyMbuoonsBoBbcaOIdzLDi5ND2sygYFCS9tMZ93qR
 WQTKQ6JkO5IgYO2FwWdAB0YV.A22HNyuU7t6yu77Bbh3pnNB2wD.PEpqy1it3Nl3yIyX_V7_nY7G
 l4En.LvfjWfHQYbgr.OAQG4dqbAAbJTRurZws3klmtIsnW6qDZ.fNlwxZ3fpkucA8iLl0NmWMhLU
 eau8DPlHBx.nSJI2VdMuZnxp_FHeGK8N6kUziSny2U4whXZVcaeMkvppwGCCL3j2EtVRKZpLUscJ
 KaEW7.XId.E0zNF0c7hrgxl1uiJ8xccH7bb9CQ7yAqADP3vWc5dpeUy5SWvRHiZ.neBH2c87Zp2a
 M_DwZcX4U_JqjovB8gGGUz4vXFQktSLBS3QmVGk96oRJhqzQmThVnjcaNEBb_3hvoEspNz4dtw9X
 oEP_G7ZdMsqBjLB_.RpBxUeauI9MEp2sTNNusHwUBMPU0EHByHiYrA_MXEwOHaIjWJA9wRdmkrPZ
 7NgCyGtB0wsgBeva8OAw06yTWwwkBsgbGDvcD6AoMh1xR193VaXNLyg9jCgy.yz3odEBzn1yuZA1
 4Rw5eHp8as0HbYeP6t8KT49uumZ465faxQzmNWjHpsnsbBvQTUllNDRgbadmeYRchy1inNdNU8JM
 6lHwhJat1B.LbCQEZup8w6cdiG6KDaWrzPVOFO4cdIKenk96M0znlxFfoCYGW9UuxHMMLL5lwCJn
 mhbrsukswz4miAonZM6ExnnZNm2NQyau8A4chBL.7Zxb0DyyYoRwvzeDlJiMJPgZie.zPL4VZWDL
 oAPJTYaDWHk6mEKF8u8_qc4jP0tdraU5f4CPVdWUJD4FF6HjxfYW1jZKoTvGKU4eGDWkuzAtQyen
 rcJMHv.xrm.KbV_2V5wmYq6yI7Q--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic301.consmr.mail.gq1.yahoo.com with HTTP; Sat, 16 Jan 2021 06:31:21 +0000
Received: by smtp415.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID eadc909ea7abb96587ba50be3d790bc5; 
 Sat, 16 Jan 2021 06:31:17 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4 2/2] erofs-utils: optimize buffer allocation logic
Date: Sat, 16 Jan 2021 14:31:06 +0800
Message-Id: <20210116063106.5031-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210116050438.4456-2-hsiangkao@aol.com>
References: <20210116050438.4456-2-hsiangkao@aol.com>
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
Cc: Hu Weiwen <sehuww@mail.scut.edu.cn>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Hu Weiwen <sehuww@mail.scut.edu.cn>

When using EROFS to pack our dataset which consists of millions of
files, mkfs.erofs is very slow compared with mksquashfs.

The bottleneck is `erofs_balloc` and `erofs_mapbh` function, which
iterate over all previously allocated buffer blocks, making the
complexity of the algrithm O(N^2) where N is the number of files.

With this patch:

* global `last_mapped_block` is mantained to avoid full scan in
  `erofs_mapbh` function.

* global `non_full_buffer_blocks` mantains a list of buffer block for
  each type and each possible remaining bytes in the block. Then it is
  used to identify the most suitable blocks in future `erofs_balloc`,
  avoiding full scan.

Some new data structure is allocated in this patch, more RAM usage is
expected, but not much. When I test it with ImageNet dataset (1.33M
files), 7GiB RAM is consumed, and it takes about 4 hours. Most time is
spent on IO.

Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---

I've simplified the most-fit finding logic of v3... Since buffers.off
has to be aligned to alignsize, so I think it's better to use
buffers.off as the index of mapped_buckets compared to using remaining
size as it looks more straight-forward.

Also, I found the exist logic handling expended blocks might be
potential ineffective as well... we have to skip used < used0 only
after oob (extra blocks is allocated, so not expend such blocks but
allocate a new bb...) It might be more effective to reuse such
non-mapped buffer blocks...

Thanks,
Gao Xiang

 include/erofs/cache.h |  1 +
 lib/cache.c           | 91 +++++++++++++++++++++++++++++++++++++------
 2 files changed, 81 insertions(+), 11 deletions(-)

diff --git a/include/erofs/cache.h b/include/erofs/cache.h
index f8dff67b9736..611ca5b8432b 100644
--- a/include/erofs/cache.h
+++ b/include/erofs/cache.h
@@ -39,6 +39,7 @@ struct erofs_buffer_head {
 
 struct erofs_buffer_block {
 	struct list_head list;
+	struct list_head mapped_list;
 
 	erofs_blk_t blkaddr;
 	int type;
diff --git a/lib/cache.c b/lib/cache.c
index 32a58311f563..a44e140bc77b 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -18,6 +18,11 @@ static struct erofs_buffer_block blkh = {
 };
 static erofs_blk_t tail_blkaddr;
 
+/* buckets for all mapped buffer blocks to boost up allocation */
+static struct list_head mapped_buckets[2][EROFS_BLKSIZ];
+/* last mapped buffer block to accelerate erofs_mapbh() */
+static struct erofs_buffer_block *last_mapped_block = &blkh;
+
 static bool erofs_bh_flush_drop_directly(struct erofs_buffer_head *bh)
 {
 	return erofs_bh_flush_generic_end(bh);
@@ -62,12 +67,17 @@ struct erofs_bhops erofs_buf_write_bhops = {
 /* return buffer_head of erofs super block (with size 0) */
 struct erofs_buffer_head *erofs_buffer_init(void)
 {
+	int i, j;
 	struct erofs_buffer_head *bh = erofs_balloc(META, 0, 0, 0);
 
 	if (IS_ERR(bh))
 		return bh;
 
 	bh->op = &erofs_skip_write_bhops;
+
+	for (i = 0; i < ARRAY_SIZE(mapped_buckets); i++)
+		for (j = 0; j < ARRAY_SIZE(mapped_buckets[0]); j++)
+			init_list_head(&mapped_buckets[i][j]);
 	return bh;
 }
 
@@ -132,20 +142,55 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 	struct erofs_buffer_block *cur, *bb;
 	struct erofs_buffer_head *bh;
 	unsigned int alignsize, used0, usedmax;
+	unsigned int used_before, used;
 
 	int ret = get_alignsize(type, &type);
 
 	if (ret < 0)
 		return ERR_PTR(ret);
+
+	DBG_BUGON(type < 0 || type > META);
 	alignsize = ret;
 
 	used0 = (size + required_ext) % EROFS_BLKSIZ + inline_ext;
 	usedmax = 0;
 	bb = NULL;
 
-	list_for_each_entry(cur, &blkh.list, list) {
-		unsigned int used_before, used;
+	if (!used0 || alignsize == EROFS_BLKSIZ)
+		goto alloc;
+
+	/* try to find a most-fit mapped buffer block first */
+	for (used_before = EROFS_BLKSIZ; used_before > 1; ) {
+		struct list_head *bt = mapped_buckets[type] + --used_before;
+
+		if (list_empty(bt))
+			continue;
+		cur = list_first_entry(bt, struct erofs_buffer_block,
+				       mapped_list);
+
+		/* last mapped block can be expended, don't handle it here */
+		if (cur == last_mapped_block)
+			continue;
+
+		ret = __erofs_battach(cur, NULL, size, alignsize,
+				      required_ext + inline_ext, true);
+		if (ret < 0)
+			continue;
+
+		/* should contain all data in the current block */
+		used = ret + required_ext + inline_ext;
+		DBG_BUGON(used > EROFS_BLKSIZ);
+
+		bb = cur;
+		usedmax = used;
+		break;
+	}
 
+	/* try to start from the last mapped one, which can be expended */
+	cur = last_mapped_block;
+	if (cur == &blkh)
+		cur = list_next_entry(cur, list);
+	for (; cur != &blkh; cur = list_next_entry(cur, list)) {
 		used_before = cur->buffers.off % EROFS_BLKSIZ;
 
 		/* skip if buffer block is just full */
@@ -187,6 +232,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 		goto found;
 	}
 
+alloc:
 	/* allocate a new buffer block */
 	if (used0 > EROFS_BLKSIZ)
 		return ERR_PTR(-ENOSPC);
@@ -200,6 +246,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 	bb->buffers.off = 0;
 	init_list_head(&bb->buffers.list);
 	list_add_tail(&bb->list, &blkh.list);
+	init_list_head(&bb->mapped_list);
 
 	bh = malloc(sizeof(struct erofs_buffer_head));
 	if (!bh) {
@@ -214,6 +261,18 @@ found:
 	return bh;
 }
 
+static void erofs_bupdate_mapped(struct erofs_buffer_block *bb)
+{
+	struct list_head *bkt;
+
+	if (bb->blkaddr == NULL_ADDR)
+		return;
+
+	bkt = mapped_buckets[bb->type] + bb->buffers.off % EROFS_BLKSIZ;
+	list_del(&bb->mapped_list);
+	list_add_tail(&bb->mapped_list, bkt);
+}
+
 struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
 					int type, unsigned int size)
 {
@@ -239,6 +298,7 @@ struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
 		free(nbh);
 		return ERR_PTR(ret);
 	}
+	erofs_bupdate_mapped(bb);
 	return nbh;
 
 }
@@ -247,8 +307,11 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
 {
 	erofs_blk_t blkaddr;
 
-	if (bb->blkaddr == NULL_ADDR)
+	if (bb->blkaddr == NULL_ADDR) {
 		bb->blkaddr = tail_blkaddr;
+		last_mapped_block = bb;
+		erofs_bupdate_mapped(bb);
+	}
 
 	blkaddr = bb->blkaddr + BLK_ROUND_UP(bb->buffers.off);
 	if (blkaddr > tail_blkaddr)
@@ -259,15 +322,16 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
 
 erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb)
 {
-	struct erofs_buffer_block *t, *nt;
+	struct erofs_buffer_block *t = last_mapped_block;
 
-	if (!bb || bb->blkaddr == NULL_ADDR) {
-		list_for_each_entry_safe(t, nt, &blkh.list, list) {
-			(void)__erofs_mapbh(t);
-			if (t == bb)
-				break;
-		}
-	}
+	do {
+		t = list_next_entry(t, list);
+		if (t == &blkh)
+			break;
+
+		DBG_BUGON(t->blkaddr != NULL_ADDR);
+		(void)__erofs_mapbh(t);
+	} while (t != bb);
 	return tail_blkaddr;
 }
 
@@ -309,6 +373,7 @@ bool erofs_bflush(struct erofs_buffer_block *bb)
 
 		erofs_dbg("block %u to %u flushed", p->blkaddr, blkaddr - 1);
 
+		list_del(&p->mapped_list);
 		list_del(&p->list);
 		free(p);
 	}
@@ -332,6 +397,10 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
 	if (!list_empty(&bb->buffers.list))
 		return;
 
+	if (bb == last_mapped_block)
+		last_mapped_block = list_prev_entry(bb, list);
+
+	list_del(&bb->mapped_list);
 	list_del(&bb->list);
 	free(bb);
 
-- 
2.24.0

