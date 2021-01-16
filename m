Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D45D2F8B59
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Jan 2021 06:06:07 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DHmGh3bkwzDspx
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Jan 2021 16:06:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1610773564;
	bh=091n5ATBiVA2xcfcsP4pN4LRavxGhHvoZx5XDBZOOyg=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=RmQ9n8y87Kl+1fksevHGEuh1ymudoM7CuOVGaUjlKu6MM1PJFHscgcVyn0tQ34D29
	 FpQNhvWicEe/+EjXAn5okZBSZ0KQdTVmbgJcLnSe5d3IrD8SBZhCcyV+lhzCTnSfbn
	 tj0nMIGgTyJL+WphbRDWL3UN6MA2++ADxisMFv4tSax2OpaZFGi9JpPWjC8JEHFIYQ
	 xWFBfclym1lLFH3QTx6u3pKs8lXhmCeX3Ir9XxG0gZzUYh96VGLxqFb4hspgSRKRa9
	 U/0P9+c8LglAkjJS70eekfAvSkAx+APWGHRpqbF5QXT3VkxXdt7Mk7whUu1diG70d3
	 Xc6XGpHxkLpKw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.65.148; helo=sonic309-22.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=U0ATDSOJ; dkim-atps=neutral
Received: from sonic309-22.consmr.mail.gq1.yahoo.com
 (sonic309-22.consmr.mail.gq1.yahoo.com [98.137.65.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DHmGY23MqzDspc
 for <linux-erofs@lists.ozlabs.org>; Sat, 16 Jan 2021 16:05:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1610773550; bh=OavdrxUE63bnyOt4mfYIH0YCsWu8+CaC7dwdqpvYq7A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=U0ATDSOJEFjgorhi54xvpKP9vXKlRirl4XDDHQtnCoIA50jI8GUnbkVdGhQGxE56GC91GMoVhDKWYYwsKZiQr0VgooGJdLOPXZ4H83uUvP0Z7dksWY/aD7D++CR0cCPSzbe+sZLK8OodPTpGDUDctYzcuQiDFg81oGOP5QJNEtbq7Mmn2KgZk75ofw2c9jm3+x4RqfFc47ZjJ1JV4NuDbevkA+GbDQKyHHnEUihLlO2/eBrfBtYz6HtfsmgwXMly23ajHB+b/EsG28l/6eDHbmGo377xfaH/ZcXnKeAZGYhG5oiYTZIOyieqf1Flf0mIiqfGXo3wFb8ZD2XUFwlAwA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1610773550; bh=BAKBxVgNESXq5PQmTVZo5/BBLWH4XTtST0t8U68MMjt=;
 h=From:To:Subject:Date:From:Subject:Reply-To;
 b=Rkg+VavOR5R3s9jGCTP3+kYDgtVQl/G746dhAUVIgKQVLl3VG8weqdM5gkeNJk8CnbA01llu57TqWuzLtTV5H778jazlYCMGLcK2kGTi942t0ILP4rjCIEjvwZs+yfQJPqdgGZOQZ8D7tB7thHf8vMso6I12EXBNygO159vOAgQDTHqU6M8OtQJqG8AFedfv5yu5u0JznpweH0c9W9mHVE8puoWkhkB2OpaRwz/wEe77td8LsXTJFEvIhMb1jgrNeeTxgAES9XoHhERWYM/hDVZot7s4Klfm19sNITSxi+I8CBj5kGcv9lyPfG8vcNOOEGmQHXYld/dJBUcXLhXhLg==
X-YMail-OSG: UuSmoFAVM1l.eIfYnX8PrRYmxlHn.vytS7vwqx5sI9KZvwGB0iEPenVBRulZ2Tb
 M6Zmy5T_POge99.T80dRUsSbGtD.vkojiaxa_LZDg.eSLZtgGtp3SXOjXBQmhzu_CyVRd6DeHAiA
 2mlVqxWfuxQTVJw7AmIP8bVp5CGffeTNouuJSWpkS3.5reHQZYZBZMF0Os4PrblxWvrfqq2M..na
 2UdzeeEtGh4Om4YeCOTFagNXhS23LMgkNUWEBsBrj1CqSh8BVvskcvn3V9O_6O56sYv75RxViwr.
 2ee2li01GFG6KWJrl7ltQmXgGF4sawZxdu_olyyYWOMG3dwvOSC6nIEgOyxtdGlj9JehaTSNUu0S
 _RwAjhfKeMCMmXiIzYlpaPOfaxl0Cl2NaeLYFUPl8ddWNZ34laalup1gYXAp8aUbUOKguBfARhEa
 FEmbTP3jQ1IgkRRUC9FZ9io4BhRaQTriuMbXdmoWtAAsb3JelQuT0ShuRYqONnS.Q13Ip3YyBKz0
 IzhOoMfBmHqvkaTCAFtgA5aQvm3sUY.D0pVX9tFlSeMU_EZoaYF1cV7LuVgMo_NkbUD3Bsh98pQE
 Tu9avlEcafDuJnfshIHpDDxUPIF7QsWHF2VlH.JNoBRPu.IwE9gnqQkCTS4Z9djiVUArWtX6_5.9
 4mE9qEFb2ZRszS_TZyBD8yrqOEtsTs0EPv4k_AV_x4IKvYbQn6_sm.y4.Hzxow8eHCHYmHrDrcTt
 XTn7w5yu3h4kmAsvnOjag.ql6X5ra4DJ83bE5Ywi2njfgytocbpeEugQc4xgmbeg_ufqg2MnHLL7
 FtCNcxNTTmeh3mZ6.GWiEfznaX4d.h_y3Kt8Rh0kLCFdaoADHnWp_M0IGPeY9YcbFlPcoHrqulgB
 qF52z2TXM9vRzqYBLkkrGrYbzYukhob2DHYswH0_ba2tDjInk5r1mi8BjhO7vrHyPbsTuioPcJdP
 CzrIecZpzWFpfDus2mzmsD.RiIyxKzr5AVCfJkQLqDoLsyzum33W7FFd2YtdalLuGTwoCfoJDfR7
 wsj.KYYdfwoh7J3oP9guRyQuVImmBNqlN4_gG5WbDTCdHnD_JCGfghjAUmW_yITEQkHGr1fN4o7l
 a.N3Q8Kus7KpUQWf7SV0xNEDuWoHopwSpxDc1Pkb_vvX1qJYvSN8lFsYf2sAhbYSUovwHabsVyZ.
 P5KCOtuxQ_9fCkykIFF_8E9A.g4hWl1_doI9.FMk5CuzXqwFfgwBl6wPkVKOIunUVe091wSR3Xdw
 NRZyHsULhHgR4fRw5N9KrKVFu9HCgihAbCD83K8pcPmJzoLMmea37qBlvcLAqOiLTaQAwUztL_IN
 wTkP87RPGfi1OhMZcs_BmwwTzqmYz6ffLAvyjO0h3x5Tb41v8k7e9h.J5oEoiscKGkvW2MKnJtu7
 8j_WNUfdJAkc4Wy.NzW3P7TK4kCuSPtD7z7rsC6ZdZfEmwlq6rIuREAlkM2FgrT.cQ9x3jAOJwef
 9T94WfO0EwhEhwExQjANXJNgvb4UYiWj7snbVykePLRVOdhlua7gZptqSZSbKVj5Wcka63WWxzz3
 T.u7Ajq4v4K9WE53dLIctFuUEH5UlNIhAJ2yINUWYrlK6kSs8U2NO5EjCd9aXRvGkukoQ0a7rA3X
 VQdDTv7_blT_.cUQmSPhOZ7aMWc5DPBby45NDANGzmSMAF.VESET19vGuXmJ1wvSl6FiQGhML80m
 Q9adjplW21_Q8CdOOJrcC4P1LofrRewlA6sBuLm1ukpByQ21yDfSEj58S_UIGZXdfO54TSMa3doc
 fswb8AoFIwTcjhfg0EaE6J1ruhKdhblvLxD08Y6tfNy_fra36vrE5GRNRTRiGNka.Fzs4nQ3J_ep
 ztDvRx7wP1pdxcIUZbD1tvrXl_0GLGSIMt3c3gqV_he5EoNMnWCusA.HQAqTnkLYILoSll0AUksz
 tk.OPilV0ty3gZCHL8bFnAhE5d.ZV1uMXBdf1nuTV29SzMFU4wtSf0WRATLeTamUeI5UYZayXZfj
 1IuZgKcKEjmX24JNVSQp0slwR0c4CoxxUa3BFcubRkow33N4oNvjetb_5XneXeQPybVXcQepvppv
 qcapBxZseiqwZPUyjMXe3E8B2QVD3d0qG2w30slf9KN1sDU.xdXZuONmVsc8UznSFTl_JONBhGCf
 N7XeDr.0VPud7dQEnIfwtEcrjrO2TYKk_xfpxC6yWgNR4K9UH70fRXf5RfpAsRq6a_Wsv2qu0JZg
 AfCheC6H2d3DtPi0PyAM9eNKI9yUC1McHZnaegCyAGUf2H2ux.szcAGjlVHbZDhNqhjraFR8ts_Q
 WnscHYTCt4dzAOx.rWMjpeahFmpUlSosooalZgQDm86LTqSlww_eMoEez_3ZgLwwRhJpvP1tqjBM
 Ov4o6eDQt7udI7jFt1XRKCIzfQnAOTgancDcWdePkQWVkwM3FufT4SPus_nhv_LvdSe.9qNCRMiP
 U29bArP_7MHBeLGoZ581uFup7d9TBorQ5JqUvD_AMtkAtrwIDDGpg1DDv4aFYQV5ffzaHd_YHRlm
 kFpRqzUdwSzby_EeYZP_mOPdiD_UyQQi2gXfcGZZXp8c-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic309.consmr.mail.gq1.yahoo.com with HTTP; Sat, 16 Jan 2021 05:05:50 +0000
Received: by smtp419.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 90b779082bcd82d35e69f3ea5422e955; 
 Sat, 16 Jan 2021 05:05:47 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 2/2] erofs-utils: optimize mkfs to O(N), N = #files
Date: Sat, 16 Jan 2021 13:04:38 +0800
Message-Id: <20210116050438.4456-2-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210116050438.4456-1-hsiangkao@aol.com>
References: <20210116050438.4456-1-hsiangkao@aol.com>
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
 include/erofs/cache.h |  1 +
 lib/cache.c           | 97 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 87 insertions(+), 11 deletions(-)

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
index 32a58311f563..17b2b096632c 100644
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
 
@@ -132,20 +142,61 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
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
+	if (used0 == 0 || alignsize == EROFS_BLKSIZ)
+		goto alloc;
+
+	/* Try find a most fit mapped buffer block first. */
+	for (used_before = 1; used_before < EROFS_BLKSIZ; ++used_before) {
+		struct list_head *bt = mapped_buckets[type] + used_before;
+
+		if (list_empty(bt))
+			continue;
+		cur = list_first_entry(bt, struct erofs_buffer_block,
+				       mapped_list);
+
+		ret = __erofs_battach(cur, NULL, size, alignsize,
+				      required_ext + inline_ext, true);
+		if (ret < 0)
+			continue;
+
+		used = (ret + required_ext) % EROFS_BLKSIZ + inline_ext;
+
+		/* should contain inline data in current block */
+		if (used > EROFS_BLKSIZ)
+			continue;
+
+		/*
+		 * remaining should be smaller than before or
+		 * larger than allocating a new buffer block
+		 */
+		if (used < used_before && used < used0)
+			continue;
+
+		if (usedmax < used) {
+			bb = cur;
+			usedmax = used;
+		}
+	}
 
+	/* try to start from the last mapped one, which can be extended */
+	cur = last_mapped_block;
+	if (cur == &blkh)
+		cur = list_next_entry(cur, list);
+	for (; cur != &blkh; cur = list_next_entry(cur, list)) {
 		used_before = cur->buffers.off % EROFS_BLKSIZ;
 
 		/* skip if buffer block is just full */
@@ -187,6 +238,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 		goto found;
 	}
 
+alloc:
 	/* allocate a new buffer block */
 	if (used0 > EROFS_BLKSIZ)
 		return ERR_PTR(-ENOSPC);
@@ -200,6 +252,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 	bb->buffers.off = 0;
 	init_list_head(&bb->buffers.list);
 	list_add_tail(&bb->list, &blkh.list);
+	init_list_head(&bb->mapped_list);
 
 	bh = malloc(sizeof(struct erofs_buffer_head));
 	if (!bh) {
@@ -214,6 +267,18 @@ found:
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
@@ -239,6 +304,7 @@ struct erofs_buffer_head *erofs_battach(struct erofs_buffer_head *bh,
 		free(nbh);
 		return ERR_PTR(ret);
 	}
+	erofs_bupdate_mapped(bb);
 	return nbh;
 
 }
@@ -247,8 +313,11 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
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
@@ -259,15 +328,16 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
 
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
 
@@ -309,6 +379,7 @@ bool erofs_bflush(struct erofs_buffer_block *bb)
 
 		erofs_dbg("block %u to %u flushed", p->blkaddr, blkaddr - 1);
 
+		list_del(&p->mapped_list);
 		list_del(&p->list);
 		free(p);
 	}
@@ -332,6 +403,10 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
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

