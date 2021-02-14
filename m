Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F8531B111
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Feb 2021 17:00:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DdsQN0SRzz30Gp
	for <lists+linux-erofs@lfdr.de>; Mon, 15 Feb 2021 03:00:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1613318428;
	bh=5azej2oe6Ui0d4ncAheg8YV++vufRW7+4xiw/rB5BEQ=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=ErrdJK3pbSNzgAFAZNsYMrqpYEBrnnf48zee5nDzm6IrwhNk6Y8qSLupQxN1SntmC
	 ZT0Gvyyorr3HtDoegHFIsF8Gvlu4+ZFtJwbOCsGuLPIBeNVWgfYZJQ94//iJHO6UAV
	 L87xdga69+FhiqkkE8bqUP4CqGb3PDi4qhFtUfBs9VjBLMcG+p7Nuc2AfNcJ+Bbz/y
	 OaXZYfjfW8deJHHtxPv23vl7LhEDKM56OWUauSsyyBwnTJHhD//KCcTBZ9rTj0C9qE
	 YgmJZWlliLdSod2zTMsNeuVNvd+6rd26y6HwK1VaAzB5zfIom9QVJm6qKxFMX01iqg
	 1GvtCQUMblO+A==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.68.205; helo=sonic304-24.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=EajRRPFg; dkim-atps=neutral
Received: from sonic304-24.consmr.mail.gq1.yahoo.com
 (sonic304-24.consmr.mail.gq1.yahoo.com [98.137.68.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DdsQK0BQDz2yRh
 for <linux-erofs@lists.ozlabs.org>; Mon, 15 Feb 2021 03:00:23 +1100 (AEDT)
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048;
 t=1613318420; bh=glP3TXkHL+j0bUjP5GhaM8UbFXCio0mOpn//wUMDVe3=;
 h=X-Sonic-MF:From:To:Subject:Date:From:Subject;
 b=o+eI7ERA9fwuxZNr62KDfWbLMxZTMNuXstwvBdV5BVLmPKMaCEnCAjDQCDWTM056ZZqoB+ItFYGScLr5NFpMAUiI8kmqOO7GG3bXl3A+t/idFs+FKqV0RYNmPNsqEp0d+UtuWrXCcFAPBM87SzeeIxU8o+fENv3vUdx/znyc9Ctz4AEo4gE391P90W2mH5/u/H8LygzvyRLo0ntiF4o3B3rnyEC5QTvmVlyShVhhxbF/L4I9DQ5oMAB8frQug6FiwuS2+XXLiyiUzrRcrHYK8gKQFCOale9r3LOYj96IoPZm6D5lLwYet6Ixaa1DqcujOjbDQTt1j6G6dnsUNtu4AQ==
X-YMail-OSG: xuvBx70VM1kZ4cLdky6ryIiOH36Wou8OFThzz2JBsFTtLyNj1tjHrHwfewp7.Li
 Z.AgXbgBlaqa6wuw2MueGea4a4OdU1uaQwERrW7SycPmtBq6Jka0Gh99tM_WKiaRE1.IEn7wCdDc
 HbNc7XlAysykNqwG7Bx1rwnrWIqckb7f6hUJ1hE5juLtZDnpq1h01RUTNjpg.rohf8ssk9xU8VS6
 q8ujrne_YtvGIrrmfG_sZvpamAOgeKHLHSk6fvRaUXdmYs539ZzwEqQDqttK8DkRMKClp.c05fHc
 .P_qxSS7WBJUv6cM3hCdR1xGHxL1xmX_F7qAuGW.YE6sh7t4cY1E.2IusW4iAP3wJ7OdWCSIIuLG
 aUQgMfoHexpF09CLm.Dq.cVr.Igjfn4_9acE0F0JSriQWeOYpV.elvpJko7p6uBqZI92Cx.WlF3J
 fJDGEzJL2_9kY68w1TjuOul7GoOR0aBQNlxM4oeeznlYdBaosuaw3v0csQKNZdvL20jDXNLkW2sp
 y2jE0zI671ZfsjMGVajRUs7sSAU0xyA0B9yZcFfftT0s0b97_wfjNsZK1p8G_37nHyiyH_k_opB.
 SCwH4_4CbMjcwx6daY_Cffc9elw8ZoHt4qe14MDlMYO7n7.KpLt_4Op1YKfjalSMtbanMUQ_ZB2y
 .Hb8q9AUFWD9CS3s40U1Zb2FFoMY0JAjJCQ0KLhAO20ihL0eGKpQ.TaEcdCKQPjwpvnSnP7yQmrS
 0Wyh.x7iuFmKPbTWWGymYg7QxL44Tso_g4gbeElUwIbG2z3Kz6HkFyKYZAWg9SMfef_ZeuRl1Dl4
 8vdsxJGITobKfvENiVzHUBeaFns6k3h46itI5M8SWySdM5cym60BBORu2a29bWFqm4ca1tIGjRKo
 bN5dSwy3WNiS4NUKCrWXoMhbnQorb0pJPoB1ycfF7b43WmYluedeEm2Dd_.C9BMEoDXGTYITlP2L
 QDqmipMiplVi0qpMC0J5xvZA6vkP8l43fvRZd0w2wZtGewh.LvQDZY5cdWsEbEtktV2xtXOgLLHM
 ic3vYZ23HdATuwTxKSl3L7qayuOG96iSFBcdps0t4IvWDEaWMh20Soj3Wbl2V1r.GlrzLZqade9D
 Ofi1beTL7M3nNKtE2decdMvHxRmse40GEUYb4dqXj4RzZWcJmyOb0yQ_2LwjM7SQRnxipi71RsXI
 dDN6XkPADbl3gdrxtIw8hB6AEAXa97TKDRM_GqKEjRttr.9WOoyjd0LicaJNfnDa1x2xBO5iJYwD
 loIC3FVlqaYw.qBuDnbX0OFyXs2OU0CDJZVt0qGrYc.S5Zs3iOIVXH4Vh028Y3DmmpZmwN5Idi38
 auyBHytOZSoNXkrIjumsMOSMG9bxWJutWIazpE3y4UOZXzln8iIEzfqiKSyYCSTjO7YQ3f4JD5km
 e3EQsUqTgmybv94_a3H8dKZg.wGNUGypqwQHUmQrKOIQkQsT9Svg6_yWlP7QDfkexNPfdiCw4bpI
 mUOE76p7_EPyJvHwyWdwTXGTYb7IujCXJpuWZGguPuKgB_zdMkKuSniBm30m7mCyoQ5d.VFE5rOa
 5_if..ADYg50QB5atfiGQOy_79xLQ67vltzjnJBd4i33r7W_g6IJDtrjBc5htop5EBCDTFU1JGPF
 hFDzaxM5TRekkrv8fLN3urhRx1ucgXt1vQU5PMuzuBsUD5wSvQG9ZjsRb7dJ1VhuofQSeO1TFICu
 6ImkxtIH6YcdgbV3bfpgdiw6Fu.vAk2C2Hq6T21gmGv9.5lk7PlcST._5htc37lKUzIk2gwaxT47
 6uJ47GP14A1IDBqav1xc.gs94ghohTW7Vk1pRtGsIh7SMgVqLRNSutvtV9A5o0hmhSIdpnm1IVLL
 9U7G5Wn3O8IO6QbIQr02q9NPn8kJ2EnWpt8maIgMuIm6egyRirMV1_VZTTdySgjKsq6sMY_8MxtK
 heVi5keFg3hgnnbnIfK3R2erbjWpM.s0IY9cgrYCg0KxxlQ9XkWi_Ystst2w41kltdCMAVsD3tC4
 oSEgHktnXoHtU1DPQtvDv7M09wZPWm4WfoV1yaOZ.NfQ1gRiFxaGOs5zXmGWBDUhouR9q506.HIW
 lPQ9QLnDgrRcD9IHk9DI4Hp6Gi9YZNofOPdQMxhqOpEBiVU2YyKPtHJXhKTlct_0umFRUlkrKmcA
 M0d_g4ioHdl0QsB5Z5nq.58RK1MNA8GFsIrvxRXwbc4kqB6QxeKgbQ8th0EZzmAOFH1IGUnMZRW6
 kZJ_Zy4q_dV3yM993nJvLm93LlKg1e9bMZaJsIPTG_2_8u4sBG1h5Gde.kVpkftXQ1kiUjryYkAA
 WNN.uxVt.n4u1XIvjM1WpVjaOC94Jnb4UVu0925hQogCDU_cA2Fe2YyX7pQnB84Hsm861tj4i5nD
 HXNrT4RMT04vaBnermhGU9bf0Q0wG87iMirZjs0LdR2OHhYWpDSrpdI4uxz4myWcdkTXYONDiDFQ
 QVz4q2NPdrOA78tubPcYXG9HoqkmBu0AUZdYSqCIMqkRCcR_2rXTgCfZHbkjNLsTsHlkqeUJFlmi
 sWtuWiyb5kYnxnSGTuPe6bWb8AS3WemZ9Rglj2Q--
X-Sonic-MF: <hsiangkao@aol.com>
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic304.consmr.mail.gq1.yahoo.com with HTTP; Sun, 14 Feb 2021 16:00:20 +0000
Received: by smtp401.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 75500277925b637a18bf3ff9d3b68f79; 
 Sun, 14 Feb 2021 16:00:18 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs-utils: fix battach on full buffer blocks
Date: Mon, 15 Feb 2021 00:00:04 +0800
Message-Id: <20210214160004.6075-1-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20210121162606.8168-1-sehuww@mail.scut.edu.cn>
References: <20210121162606.8168-1-sehuww@mail.scut.edu.cn>
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

When the subsequent erofs_battach() is called on an buffer block of
which (bb->buffers.off % EROFS_BLKSIZ == 0), `tail_blkaddr' won't be
updated correctly. This bug can be reproduced by:

mkdir bug-repo
head -c 4032 /dev/urandom > bug-repo/1
head -c 4095 /dev/urandom > bug-repo/2
head -c 12345 /dev/urandom > bug-repo/3  # arbitrary size
mkfs.erofs -Eforce-inode-compact bug-repo.erofs.img bug-repo
Then mount this image and see that file `3' in the image is different
from `bug-repo/3'.

This patch fix this by:
 * Handle `oob' and `tail_blkaddr' for the case above properly;
 * Don't inline tail-packing data for such case, since the tail-packing
   data is actually in a different block from inode itself even kernel
   can handle such cases properly.

Signed-off-by: Hu Weiwen <sehuww@mail.scut.edu.cn>
Reviewed-by: Gao Xiang <hsiangkao@aol.com>
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
changes since v2:
 - update commit message;
 - refine 2 asserts from < 0 to != EROFS_BLKSIZ.

 lib/cache.c    | 4 ++--
 lib/compress.c | 3 ++-
 lib/inode.c    | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/cache.c b/lib/cache.c
index 40d3b1f3f4d5..e3327c3f1586 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -102,7 +102,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 			   bool dryrun)
 {
 	const erofs_off_t alignedoffset = roundup(bb->buffers.off, alignsize);
-	const int oob = cmpsgn(roundup(bb->buffers.off % EROFS_BLKSIZ,
+	const int oob = cmpsgn(roundup((bb->buffers.off - 1) % EROFS_BLKSIZ + 1,
 				       alignsize) + incr + extrasize,
 			       EROFS_BLKSIZ);
 	bool tailupdate = false;
@@ -134,7 +134,7 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 			tail_blkaddr = blkaddr + BLK_ROUND_UP(bb->buffers.off);
 		erofs_bupdate_mapped(bb);
 	}
-	return (alignedoffset + incr) % EROFS_BLKSIZ;
+	return (alignedoffset + incr - 1) % EROFS_BLKSIZ + 1;
 }
 
 int erofs_bh_balloon(struct erofs_buffer_head *bh, erofs_off_t incr)
diff --git a/lib/compress.c b/lib/compress.c
index 2b1f93c389ff..4b685cd27080 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -456,8 +456,9 @@ int erofs_write_compressed_file(struct erofs_inode *inode)
 	vle_write_indexes_final(&ctx);
 
 	close(fd);
+	DBG_BUGON(!compressed_blocks);
 	ret = erofs_bh_balloon(bh, blknr_to_addr(compressed_blocks));
-	DBG_BUGON(ret);
+	DBG_BUGON(ret != EROFS_BLKSIZ);
 
 	erofs_info("compressed %s (%llu bytes) into %u blocks",
 		   inode->i_srcpath, (unsigned long long)inode->i_size,
diff --git a/lib/inode.c b/lib/inode.c
index 6371aa563673..40189fed37dd 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -531,7 +531,7 @@ int erofs_prepare_tail_block(struct erofs_inode *inode)
 	}
 	/* expend a block as the tail block (should be successful) */
 	ret = erofs_bh_balloon(bh, EROFS_BLKSIZ);
-	DBG_BUGON(ret);
+	DBG_BUGON(ret != EROFS_BLKSIZ);
 	return 0;
 }
 
-- 
2.24.0

