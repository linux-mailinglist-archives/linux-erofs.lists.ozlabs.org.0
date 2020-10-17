Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46DA4290F0A
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 07:18:38 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CCrs73djNzDr0l
	for <lists+linux-erofs@lfdr.de>; Sat, 17 Oct 2020 16:18:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.ozlabs.org;
	s=201707; t=1602911915;
	bh=GJy82Q6GPS7f7cNVRS28un51tl9pqGjfcPDPugKfvz0=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Wz36u8etNMRfoffoBtAPcmIpKgkvGalpLmq15cHlAMX8PGkJVNc2DhFfDohU8xzXo
	 rijILtbKO8G/Z+YqJPAykcnLLVvkCK/Hi29f+s2smUI6957BqhdovA1A7fBwb9xHre
	 2BHe5mDxxLoq+TN5S5msMaPEHN6r9lmM6JiMqoGqboDvWAgFjAiduoNqkCRfQ/hHYc
	 uImZwZV/2K5dTrimmdxMq9kd+V4Fdp91josYfx/qxYSV5saGZlAUOc7JPeeLhTGCku
	 1QcSfF+to33j7uOOK1ZNy5nvVb2SojxA5EdduPdgPO54RoPob+j5IpawyxojUXC0b1
	 Pbb1WCX/Wew9Q==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=aol.com
 (client-ip=98.137.64.32; helo=sonic307-8.consmr.mail.gq1.yahoo.com;
 envelope-from=hsiangkao@aol.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=reject dis=none) header.from=aol.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=aol.com header.i=@aol.com header.a=rsa-sha256
 header.s=a2048 header.b=gWyiYrgz; dkim-atps=neutral
Received: from sonic307-8.consmr.mail.gq1.yahoo.com
 (sonic307-8.consmr.mail.gq1.yahoo.com [98.137.64.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CCrs32wsTzDr0t
 for <linux-erofs@lists.ozlabs.org>; Sat, 17 Oct 2020 16:18:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048;
 t=1602911908; bh=5hPaJJVmirmRu6Yd/0YTY3iQRLokDSN0cLisr0BmiRw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject;
 b=gWyiYrgzQCOWAKooOwc9CR/i9A5ZBdjXROo3jNPrqm3GodCY/NAcgyLaQcSA+yY43mEZBfi7QYCzCX7eHi5cUHYaX7UajYQvJoZeaGpv/vT+HGqXcfCpS6XCbei3xy195PzZwn5+B8xeOg2WRNpYWZvSmWmuLzW8fzlwZC7KRQuPeu3knF1NdDGOzfrT9sQEYzJ4uwHh6PmJhTUr+XOIVd+ZGrxEhWZssIoMgn+voVYoH58OVi4qZtpuntAuddVaoQa9EttcKnJrHqnjEHTtqxfrd+oKuMjcxp0H4MrSklTqiRcw6Sw5fpapqqqvJ4I+IggzA6HKwCywV2Usbs/tMA==
X-YMail-OSG: fM3DStYVM1mJpk8qocQA34xJ6wZ1yccawxPeJUAs6BosU.xXmtlUn3FiaAAGZuG
 4raxPRhEhkE9iZpU8iBdS6UHVIgiDBtUTJfXmGirFz87JYJCN.M4D2OS4ufsyshNgS.tAzOlfYZA
 kEG2NG5rAhITKE7_ILwbsSJQ2OzRDodOZzhRMHbh9duNLWfWRrOFwblOpYnrLf4WQxZculg4rABP
 vkgaFgMFcNA2pboJA6i9.1NHcgyaZV5SSVxIo9t8iflnP02.glfGLb.STBpVwWeq14PB1qjItRa_
 PpHryQWd.qFUEoNidsWEhS3iaQil4dtvsy12JBIQ5gc.Ho7GbVMzbTN1gC990qjWwplRs9MtTVPc
 8PDK1cVYqIbQDcLAih7e9ppEHigiaQqwRCNqUBHT2HYbSDqlT1FKlQcSNmhJHA2AgMYQCd2xLlfB
 umOaHwvFy1fZxEW9FiCFj6PZnUbOanLdRLvzg0PYYwE5lQlSW0zLqiRTLk5qpnSL6IWSdGHUNMfM
 IJ91vVIiGzknigAmQXrGKf5Gjy_R31_TsKjAui_t6PYjbH1hr9Leej1laK7KjGpqSlqKmqScG3TE
 J3Nyn1j.w4x_cj7is17tj0YlHLQUtnBD4Z1bE9AW0PtWOH5X6bsHtcF.i6nYKR70zGEutwbqIi4V
 5DOxWKfuVjwjKB0VwIhYVh78thKInK5jUPCG5hwB26WGtbZ_tuQoVRyIMDB9Vl49Hwwd4qpqsgiL
 .ro3BWJ4B29vlBTljMdfNSngSO3jz_wnLKKT9AEVIw7a0LHZrmgOwcgkCt8SEXhqRazpZsSaLqtl
 WR5lHqin8sz1jMivO5JIP6v9NbWGFNIFvVYigIKKTzbuGJ2_.VnmP3rPv7D_XlOHWDs84dSNHhzB
 NkmAAn313usFreZfIvK8rwGq2Zhrt1MBiwlI2BDzDsfKcCUEpHrn2rTjG6rip.zf7_4oQ7kAfFBE
 EbhV6j1ZXVL.ak_bCmB8rnHSU5.ZCdJY6iW1D8yvS2OyShbaQWtNL2sjpQWN7LKbMjae78p7avE_
 m0MmIbppyJugHdQyV95lGgSyvLFCSfdmBeCfH2ThdVA1ySjfTTgz0DpzAFE50GuiLH1TdiYxQkr3
 nE4uOFgTpVV_DBdtieNwqjLXZ08wsX_xD2mEjwIlfF8.KYIK2vXrBeSPbcoJpRpSyg.szA9TMWJq
 ySD2KfmpWRwYzuZmXL7RGh7TdVi8pRt6qr5aZLdfHJ.ye34B1tewbE2luuUsKKg8DxDGl6W0fSxV
 McNSENz2YjgPNvSE1TwNK3cFJFxiGKevF0CZhffFGDQ8fUvTR28VY.z3yEge7rZ_ClwtHcQxN3n3
 BDVCJ3v8wPp8GIL0q7itFj_56AQh3L3O8Tyn4utwWxT4Hv3jtTyjJwaVsKs8wAKiNhhSeY3ctrhT
 wuaUecebd7jFUYVpIicpTWGfZ7sKTNAi.Xwdj0qxcOqE3.vpIKYszWRmo.Gg71MnqTuaPd8Pwtl9
 U10Cnn0cF1OCXTaKVxWuY4ftqPYY6SicOZWtxy9Wa4_ikgv49MRUm5vJT.n1xrmgPQqwxKJaScNv
 o.ux7hhsM8Zs-
Received: from sonic.gate.mail.ne1.yahoo.com by
 sonic307.consmr.mail.gq1.yahoo.com with HTTP; Sat, 17 Oct 2020 05:18:28 +0000
Received: by smtp424.mail.ir2.yahoo.com (VZM Hermes SMTP Server) with ESMTPA
 ID 9d3dc137a63e5241cc606f3cba181f35; 
 Sat, 17 Oct 2020 05:18:22 +0000 (UTC)
To: linux-erofs@lists.ozlabs.org
Subject: [WIP] [PATCH 09/12] erofs-utils: fuse: rename ofs_head and outputsize
Date: Sat, 17 Oct 2020 13:16:18 +0800
Message-Id: <20201017051621.7810-10-hsiangkao@aol.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20201017051621.7810-1-hsiangkao@aol.com>
References: <20201017051621.7810-1-hsiangkao@aol.com>
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
Cc: Zhang Shiming <zhangshiming@oppo.com>, Guo Weichao <guoweichao@oppo.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

[ let's fold in to the original patch. ]
Signed-off-by: Gao Xiang <hsiangkao@aol.com>
---
 fuse/decompress.c | 27 +++++++++++++--------------
 fuse/decompress.h |  8 ++++++--
 fuse/read.c       |  4 ++--
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/fuse/decompress.c b/fuse/decompress.c
index d3ee3677e9a3..fc12852ac6b7 100644
--- a/fuse/decompress.c
+++ b/fuse/decompress.c
@@ -33,8 +33,8 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq)
 			return -EIO;
 	}
 
-	if (rq->ofs_head) {
-		buff = malloc(rq->outputsize);
+	if (rq->decodedskip) {
+		buff = malloc(rq->decodedlength);
 		if (!buff)
 			return -ENOMEM;
 		dest = buff;
@@ -42,22 +42,21 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq)
 
 	if (rq->partial_decoding || !support_0padding)
 		ret = LZ4_decompress_safe_partial(src + inputmargin, dest,
-						  rq->inputsize - inputmargin,
-						  rq->outputsize, rq->outputsize);
+				rq->inputsize - inputmargin,
+				rq->decodedlength, rq->decodedlength);
 	else
 		ret = LZ4_decompress_safe(src + inputmargin, dest,
 					  rq->inputsize - inputmargin,
-					  rq->outputsize);
+					  rq->decodedlength);
 
-	if (ret != (int)rq->outputsize) {
+	if (ret != (int)rq->decodedlength) {
 		ret = -EIO;
 		goto out;
 	}
 
-	if (rq->ofs_head) {
-		src = dest + rq->ofs_head;
-		memcpy(rq->out, src, rq->outputsize - rq->ofs_head);
-	}
+	if (rq->decodedskip)
+		memcpy(rq->out, dest + rq->decodedskip,
+		       rq->decodedlength - rq->decodedskip);
 
 out:
 	if (buff)
@@ -72,11 +71,11 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq)
 		if (rq->inputsize != EROFS_BLKSIZ)
 			return -EFSCORRUPTED;
 
-		DBG_BUGON(rq->outputsize > EROFS_BLKSIZ);
-		DBG_BUGON(rq->outputsize < rq->ofs_head);
+		DBG_BUGON(rq->decodedlength > EROFS_BLKSIZ);
+		DBG_BUGON(rq->decodedlength < rq->decodedskip);
 
-		memcpy(rq->out, rq->in + rq->ofs_head,
-		       rq->outputsize - rq->ofs_head);
+		memcpy(rq->out, rq->in + rq->decodedskip,
+		       rq->decodedlength - rq->decodedskip);
 		return 0;
 	}
 
diff --git a/fuse/decompress.h b/fuse/decompress.h
index 5a3e2356dc1b..7d436f18da86 100644
--- a/fuse/decompress.h
+++ b/fuse/decompress.h
@@ -17,8 +17,12 @@ enum {
 struct z_erofs_decompress_req {
 	char *in, *out;
 
-	size_t ofs_head;
-	unsigned int inputsize, outputsize;
+	/*
+	 * initial decompressed bytes that need to be skipped
+	 * when finally copying to output buffer
+	 */
+	unsigned int decodedskip;
+	unsigned int inputsize, decodedlength;
 
 	/* indicate the algorithm will be used for decompression */
 	unsigned int alg;
diff --git a/fuse/read.c b/fuse/read.c
index 06ca08587e7c..46be5cc64a90 100644
--- a/fuse/read.c
+++ b/fuse/read.c
@@ -136,9 +136,9 @@ size_t erofs_read_data_compression(struct erofs_vnode *vnode, char *buffer,
 		ret = z_erofs_decompress(&(struct z_erofs_decompress_req) {
 					.in = raw,
 					.out = buffer + sum,
-					.ofs_head = ofs,
+					.decodedskip = ofs,
 					.inputsize = EROFS_BLKSIZ,
-					.outputsize = count,
+					.decodedlength = count,
 					.alg = algorithmformat,
 					.partial_decoding = partial
 					 });
-- 
2.24.0

