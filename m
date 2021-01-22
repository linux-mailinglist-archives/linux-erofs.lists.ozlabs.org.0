Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B84830095C
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Jan 2021 18:13:07 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DMm6m2vCxzDsNP
	for <lists+linux-erofs@lfdr.de>; Sat, 23 Jan 2021 04:13:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1611335584;
	bh=EBwbhZLoamt3mwQQv36PTioXCBaevhsxkQIrYJUep8U=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=PfaBhrDc6B7d+z6NaPLM1jW54FkUzWRmboka0OmfFR6RuGyiD9On+9BbDzwTG/E9G
	 g50O/qtlmo874fKxnMzjAVrpUJToAZXro+gAQOnrfX/zRWk4DXlgsURAw75VXYxeJX
	 mfQDDEkmBPzqPdPWJIBw6QS0jSFDiaqBIADU6uIA9QKLQzClI1r/Pr6SNBt94N9OiU
	 DPQWs11AEtqyeQ2hdWSL0QFiTMMUR9S+GLwq3uIlNfcU3BalJ085k21FjygNeDZQuB
	 rV7RQzxRXgCPhsowRKYJrHSffGzGdvyifKkSrmq1WWRh8pEeA2pOcpsAjRrO/fB4bt
	 ZLA7mEzMGYOnw==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.205; helo=sonic304-24.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=q58mwZwB; dkim-atps=neutral
Received: from sonic304-24.consmr.mail.gq1.yahoo.com
 (sonic304-24.consmr.mail.gq1.yahoo.com [98.137.68.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DMm694hz7zDrnp
 for <linux-erofs@lists.ozlabs.org>; Sat, 23 Jan 2021 04:12:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1611335548; bh=wyq3rLczOb/uOI/8VSbjug5JmuqrKwEVJkzwZeiMyEs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To;
 b=q58mwZwBlkFviQk5I3k6YLPZw2G6of7Do5A4WBuAWsxqQHsKqWzA3gHyrfatLdAKgM2f3oR9DBgMMhUqvuDT+fJ3Ti86yFP8hfkHtJ29sW5WeHmQ4BwbQ9J9cNWfYJAml9+XczCXIxOrL8epGsMhLJyrnqUmv5THVuOM+UXEAMOIB74R8xafSJRYzQiHPV+i0oW2fGUFOtg4SDbkVmh5lUPO7//J192tYsQQz8Koj7l90J+L4Tca7aGxXHb1TlBPGoasSbVk6/vnrJ47sM646D1Ye8ONGuBPPURH1hll5et0bktpqaIZXWW+/pSUdqv+seqLBHYAjrSzZS8Jb1mcBw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1611335548; bh=AysBJpjI57yLjizMNaXVdhya3OT2rxLwjMf/9tOrwHD=;
 h=From:To:Subject:Date:From:Subject:Reply-To;
 b=t+q7EvpqsE44ERkn1ce4b5nt50RVvvSF3e1wUI05KtlSEycz+5Z3ETAwqmyg72xCUDNKKvUdo7XFn3rc9nLSFl4W9UG7CE67kl7B8Th/LiouRp2f1IW1aDYqvVZKCFfN/uBidIXeyQTXYmBMNu8v8YMFISSjAWU86Agatgh3Yp/gZoriqQ51TRIGFnCRxlkDX119x9tRq2p240r/ENKiTAp5XV4L+xFOQNTXCC5eM65qgPHP/5q61jKn5C6CICXkJVmH3jJErLqqaRC6qozJkgL8+/rKJB+3tqY0OQLjtKZNt3j14xjSt2nHwolK6U9Bl8I15P4UmEMF64aC0DEgGA==
X-YMail-OSG: 0JB5iu0VM1mowSZz.FL8anoQk7kzN8aJ4uXBlGU7sGGuHVxCBsIvMm5T5bMalmS
 qEMftGAZxjYQv0nNVlBpYOcGZskMJCflKh4Y3ej.DRYUe2SPb6FQacCpCFSes.U8ti4JREduuaqj
 MLaonHkC_nSoshvStmIQOBkDF7bg3ZO52cFjqWnCJAyIVk7911jmEsKXEHE5pYXlx2VPtvQW68Gp
 in.7KB3Yp1O3ibUYGsofe8gdjPQY5rpUggtb6BDXqrgdjfVzKMlq9Lfg5F5cf8QrWV2HWQflKQvn
 isel.fFkxq1UfAsx61CJdnDHOd.J5.7.3POxgio9uVw3DIVVOu1zAkUx6Trg_7GOrv.LL6gVBIN2
 H85NsZiR98ifBRC69DgWKdIt5OjyrKOhdn0mjFv3ltb6wJpZqkqNf8wxXvrkF4.qRhwEvToJjusC
 mJKh.h.liyPFSxd7wpIwwph34JoXWS1mm_FitUve0cEJvioV32TFyUxZMiVGbzjmMuNHl3sGPdpg
 cF9peAh.v3rd5fymnCmpeM76qZRSZhEZF8rU5DFfgXz932YxWdObEE6.aDR6Xs_qvmYBvDZDTCMd
 CzaDO9Nn46iiuJf0.q0nEbWMacB91_De3v53G.cMxuNiujlWRGlZUve0f2XlVMr8tSzjkEnJV.ck
 fWQOa2F01d69YEhDIBNKRHwU3MzwHbQNI7YoFymSxYrj1SjWD9Reir433bX1mOFgTbaLdSUnK4w2
 t95wThI2nJ2sPQAMR7PHkhuoeQ.KW7WnfUB7nck7VF665yoaO6pRofX9x8SMNvCaCaQDqKbTwxJP
 1Cr_3nbXt1_qczQjtK.kehaKFsFq8VFg3Tq0G9y_QMFoDh4ojiIdsnaGzpMu.owWkr6e0FVBYrDM
 LhkkTpq.r7gWwLaMUBK3cNy_nZ_vJjwfTbbhCJFBFbDLK8MLQ_fAP.zxTpL5kLDXcyyOLxLB0.FS
 eCbz04oD1BlhmgGsY3vG3uOFWhHZtVtErCOH7J_a4DPjCFuVGkdWgYBad3uT69E__91puMuwdZpl
 cuWvtXwaBOMlJG7ARqG8ttBrCG5IXTBL35DJzg1q6ojERsjsl3wLirLbjYM4eHRdvI8OpcilA_LD
 7D3.nYtD0T2R2_Wj5GPW8azq6OZ3ImZ8fV16d7IfOYXTE3R2aluSoGxQNl.w5Y71HMUzy5YSbXiL
 pqs23N1hpCpes2_B5UgMtiOjqa7ImZf5yx_iOtx4jqNAN1Xvv2VYkfej2HPi5rAlFMkkV67Jtj8f
 .yFpLrwvazf.0EP0J5x9sY7I1_edy9XXuChICurexJlYOikhoGGI2Cvqwj89O7uQqDYIyXxKvnEy
 IdjuhIZWqwzaRUl6kQWipuJHhwgCUels5ku8hbmsXnmaco9ejLMGgG67zgKtNm73LSJnQMYRvCsg
 3QOkozZyDm9GqpU6cEEukG4XCp4E7tGDVZEuhty7JTPN4sHmX23M7ndXvraOwY5FGH_ysDqT4Xyp
 h68Aig3kmRBEShenijgo4686_TZa6y5m68kY7dp1EZwKXy.kAHNTrb8pB3MiF9CUJU1C5kwra5gU
 kSnK.r.5Vq913AC2rtY0ned50UZ6trdfIWmzsgaChyL653P1Zspgj8h4sYMjKxyMgUqAl5giPYO5
 v7bzsethz1rqCxPvLLa0smUYkNzbshgez3BRXYpcfv1qBU_5GKtDdNpYCMYNxaKhXiZLsIo3JPWa
 KbWbj6AYUC60iJCbS2Odm.xwzpE12SMAJWPWbvsVOa.2ybUce12R05ZqyYP1cSWYypiZfqBUZb4i
 t7GXb3cECY8DjtciIAwommo3m62M028UwQWd4vL5.Tks3d4jb4T2gIeM2wUdDpkHYU_rTGPt4gTD
 MuRrRHP2SAgluML_B111mlrLRtSsbJks7UGKVWK7rWV4.9wjHOiF9bTvnPCYb8UdcW9m2oCxu_x1
 fZYKI96XHp9PrfR5WC1b_VFgoIcQcEYudYdrcR8rSKEX0mGN6lHjrGheTeL30X0j55aNSaiENfxz
 RJBZYdc0XBA0K2nAsNUYR8jzKaIXY6Vt.0TGHmvkHKKCPqzEDHZ1nQRLK5TqmpiVYZwaAJrlOmV.
 WbHalvojsU9qqOqSljNPhdwWcVs8Tn7JWKpH.Sqy9R7wuq6kRxvP2LtnBXMbcSoLAwZuLXF410iM
 pIp6OP.yrs3_8QvjWgewbXPG6I6NMwDAgr2icJieiY40LK4mu_eFB9EIdPsF5lGR6PXhzaCQDMaE
 ujh3onFYygDr9tVN3ogyiLYM_xqqz4t8CL0Rb_2sECHDY7EJ1FdsKYAMfweDaeRSTxCmAusTg2vZ
 Es1CQmGpSq0uCNI2X2snQ3jRGiVIIR3I4kERezkq2ZlNtoCB6ME8UOHJqGXQ61DQZJFRjA7wCJor
 rTsCb8iBdSbLcKHQYBInjQf4LINE_x7AlCd46KHYBhMyfHNsB.eTn1YAKg4N2bHa_erhdYfpnwUQ
 qB8GZ1N4ZzHAxSbiz_dXevAPc7dlhsNgjhbY8EeylOh6iqgxbJdrxmlNY8SwJZuug8xjE4W9oWvf
 .2JK3QUOZ6o_EJ8XfFq2nlzs3IRwxnriNa2U3nu3ZDrH1_D9KSoF0niGrmte78nX.rAAiHbbpQVl
 Z_k1y2lwJi6dALD6GuOo5DU6ijGfbKI33BzHgqA--
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Fri, 22 Jan 2021 17:12:28 +0000
Received: by smtp414.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 421cb1d2e6456159bc18db7d03d7fd0e; 
 Fri, 22 Jan 2021 17:12:24 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 3/3] erofs-utils: optimize buffer allocation logic
Date: Sat, 23 Jan 2021 01:11:53 +0800
Message-Id: <20210122171153.27404-4-hsiangkao@aol.com>
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

When using EROFS to pack our dataset which consists of millions of
files, mkfs.erofs is very slow compared with mksquashfs.

The bottleneck is `erofs_balloc' and `erofs_mapbh' function, which
iterate over all previously allocated buffer blocks, making the
complexity of the algrithm O(N^2) where N is the number of files.

With this patch:

* global `last_mapped_block' is mantained to avoid full scan in
`erofs_mapbh` function.

* global `mapped_buckets' maintains a list of already mapped buffer
blocks for each type and for each possible used bytes in the last
EROFS_BLKSIZ. Then it is used to identify the most suitable blocks in
future `erofs_balloc', avoiding full scan. Note that not-mapped (and the
last mapped) blocks can be expended, so we deal with them separately.

When I test it with ImageNet dataset (1.33M files, 147GiB), it takes
about 4 hours. Most time is spent on IO.

Cc: Huang Jianan <jnhuang95@gmail.com>
Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 include/erofs/cache.h |   1 +
 lib/cache.c           | 105 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 93 insertions(+), 13 deletions(-)

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
index f02413d0f887..40d3b1f3f4d5 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -18,6 +18,11 @@ static struct erofs_buffer_block blkh = {
 };
 static erofs_blk_t tail_blkaddr;
 
+/* buckets for all mapped buffer blocks to boost up allocation */
+static struct list_head mapped_buckets[META + 1][EROFS_BLKSIZ];
+/* last mapped buffer block to accelerate erofs_mapbh() */
+static struct erofs_buffer_block *last_mapped_block = &blkh;
+
 static bool erofs_bh_flush_drop_directly(struct erofs_buffer_head *bh)
 {
 	return erofs_bh_flush_generic_end(bh);
@@ -62,15 +67,32 @@ struct erofs_bhops erofs_buf_write_bhops = {
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
 /* return occupied bytes in specific buffer block if succeed */
 static int __erofs_battach(struct erofs_buffer_block *bb,
 			   struct erofs_buffer_head *bh,
@@ -110,6 +132,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 		/* need to update the tail_blkaddr */
 		if (tailupdate)
 			tail_blkaddr = blkaddr + BLK_ROUND_UP(bb->buffers.off);
+		erofs_bupdate_mapped(bb);
 	}
 	return (alignedoffset + incr) % EROFS_BLKSIZ;
 }
@@ -132,20 +155,62 @@ static int erofs_bfind_for_attach(int type, erofs_off_t size,
 				  struct erofs_buffer_block **bbp)
 {
 	struct erofs_buffer_block *cur, *bb;
-	unsigned int used0, usedmax;
+	unsigned int used0, usedmax, used;
+	int used_before, ret;
 
 	used0 = (size + required_ext) % EROFS_BLKSIZ + inline_ext;
 	/* inline data should be in the same fs block */
 	if (used0 > EROFS_BLKSIZ)
 		return -ENOSPC;
 
+	if (!used0 || alignsize == EROFS_BLKSIZ) {
+		*bbp = NULL;
+		return 0;
+	}
+
 	usedmax = 0;
 	bb = NULL;
 
-	list_for_each_entry(cur, &blkh.list, list) {
-		int ret;
-		unsigned int used_before, used;
+	/* try to find a most-fit mapped buffer block first */
+	if (size + required_ext + inline_ext >= EROFS_BLKSIZ)
+		goto skip_mapped;
+
+	used_before = rounddown(EROFS_BLKSIZ -
+				(size + required_ext + inline_ext), alignsize);
+	do {
+		struct list_head *bt = mapped_buckets[type] + used_before;
 
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
+		if (ret < 0) {
+			DBG_BUGON(1);
+			continue;
+		}
+
+		/* should contain all data in the current block */
+		used = ret + required_ext + inline_ext;
+		DBG_BUGON(used > EROFS_BLKSIZ);
+
+		bb = cur;
+		usedmax = used;
+		break;
+	} while (--used_before > 0);
+
+skip_mapped:
+	/* try to start from the last mapped one, which can be expended */
+	cur = last_mapped_block;
+	if (cur == &blkh)
+		cur = list_next_entry(cur, list);
+	for (; cur != &blkh; cur = list_next_entry(cur, list)) {
 		used_before = cur->buffers.off % EROFS_BLKSIZ;
 
 		/* skip if buffer block is just full */
@@ -195,6 +260,8 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 
 	if (ret < 0)
 		return ERR_PTR(ret);
+
+	DBG_BUGON(type < 0 || type > META);
 	alignsize = ret;
 
 	/* try to find if we could reuse an allocated buffer block */
@@ -218,6 +285,7 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 		bb->buffers.off = 0;
 		init_list_head(&bb->buffers.list);
 		list_add_tail(&bb->list, &blkh.list);
+		init_list_head(&bb->mapped_list);
 
 		bh = malloc(sizeof(struct erofs_buffer_head));
 		if (!bh) {
@@ -266,8 +334,11 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
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
@@ -278,15 +349,18 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
 
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
+	if (bb && bb->blkaddr != NULL_ADDR)
+		return bb->blkaddr;
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
 
@@ -328,6 +402,7 @@ bool erofs_bflush(struct erofs_buffer_block *bb)
 
 		erofs_dbg("block %u to %u flushed", p->blkaddr, blkaddr - 1);
 
+		list_del(&p->mapped_list);
 		list_del(&p->list);
 		free(p);
 	}
@@ -351,6 +426,10 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
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

