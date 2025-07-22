Return-Path: <linux-erofs+bounces-702-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FAEDB0D680
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Jul 2025 12:00:54 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bmXp55fjHz2yF0;
	Tue, 22 Jul 2025 20:00:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753178445;
	cv=none; b=giAZjnejRoS8cRaH1PJym8XuSXwrYmYBa17R+J4vaLKWL+FNKIAWEt8X/crrkcMBx5Nb67rx/bFzA/T0EUoRNrnW0qPqagexgHd8vWLzWbg3M07SjLB5fqH1N7smFraYOZFiui1YF52/JI30/ArbETqhmQGKBQVWUs75J2pmt3pHx/YzmK9lurR4hVRyzAzZAjGgSMyJ9zPrMtygXAbRHgA5/ewdsMnLafUpoJfbFNcJQT9X1TOvSh5X4Fwe5dVnEBuL+x5ePDObCYvyejODjQJNiTW75SdIyIrMUTj1eaaGMX8e5i4j4gHgi2Prf3BW6c6OKE2ntvK/YR9gYY0QzA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753178445; c=relaxed/relaxed;
	bh=gxV1WKa5S/2KsJQTNxmbmmX0Y1yNxfEKlF7T1cOeQVY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1bNGrCBNGzQnICT+4fXkH7Oj75yOXh4XhEpNvG1uhOjSqEpV/5fihL/wr8yoneSlaj96xGc4JnLyxxSY6RlRsN79JrXXHkVWP9cjoFbR4H1AWcQLWX1Y8lVOoxODIveHBWORRdb1y3yFy3mS83Sm9yMz6Fx/ihN2Re8BwD0cijoDGolVX6AB/IXHZrwRUL76hbluQgEmiTlmmaMiWmpjCr4WlXpKGB5e95GOFKk8kZGAIeLixfs3Dy5I+AYb2VW9D5ZcR5kmy7uczcrFCsBBl5S2B122kPVTceKLYAEAyX1IX6VqBpYju92I+Lu0fRFkNTN3Bw3SuTcwdVxwBhSRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=a48jtkUH; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=a48jtkUH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bmXp46wtBz3bgw
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Jul 2025 20:00:44 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1753178440; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=gxV1WKa5S/2KsJQTNxmbmmX0Y1yNxfEKlF7T1cOeQVY=;
	b=a48jtkUH1Tgwl0xxTWuRgGE3x/LtMXFXsUBYILMGwTYoc8+6bwyOUsk5QHrFsv+dDTKOzJTMBiqODvEvMmf6xuFY+ji04nDw4pSIxJz7wNMVC3sk8UOTvCriWzj6hcDUNXtTMQz82NNCNDErQQR8AVzGPiOt3T2Cmi82MFMA768=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WjVvTra_1753178438 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 22 Jul 2025 18:00:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Stefan Kerkmann <s.kerkmann@pengutronix.de>
Cc: linux-erofs@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Yue Hu <huyue2@coolpad.com>,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 6.1.y 4/5] erofs: simplify z_erofs_transform_plain()
Date: Tue, 22 Jul 2025 18:00:28 +0800
Message-ID: <20250722100029.3052177-5-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250722100029.3052177-1-hsiangkao@linux.alibaba.com>
References: <20250722100029.3052177-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

commit c5539762f32e97c5e16215fa1336e32095b8b0fd upstream.

Use memcpy_to_page() instead of open-coding them.

In addition, add a missing flush_dcache_page() even though almost all
modern architectures clear `PG_dcache_clean` flag for new file cache
pages so that it doesn't change anything in practice.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Reviewed-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/r/20230627161240.331-2-hsiangkao@linux.alibaba.com
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/decompressor.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 0eaa9e495346..b1746215efe6 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -323,7 +323,7 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	const unsigned int lefthalf = rq->outputsize - righthalf;
 	const unsigned int interlaced_offset =
 		rq->alg == Z_EROFS_COMPRESSION_SHIFTED ? 0 : rq->pageofs_out;
-	unsigned char *src, *dst;
+	u8 *src;
 
 	if (outpages > 2 && rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
 		DBG_BUGON(1);
@@ -336,22 +336,19 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	}
 
 	src = kmap_local_page(rq->in[inpages - 1]) + rq->pageofs_in;
-	if (rq->out[0]) {
-		dst = kmap_local_page(rq->out[0]);
-		memcpy(dst + rq->pageofs_out, src + interlaced_offset,
-		       righthalf);
-		kunmap_local(dst);
-	}
+	if (rq->out[0])
+		memcpy_to_page(rq->out[0], rq->pageofs_out,
+			       src + interlaced_offset, righthalf);
 
 	if (outpages > inpages) {
 		DBG_BUGON(!rq->out[outpages - 1]);
 		if (rq->out[outpages - 1] != rq->in[inpages - 1]) {
-			dst = kmap_local_page(rq->out[outpages - 1]);
-			memcpy(dst, interlaced_offset ? src :
-					(src + righthalf), lefthalf);
-			kunmap_local(dst);
+			memcpy_to_page(rq->out[outpages - 1], 0, src +
+					(interlaced_offset ? 0 : righthalf),
+				       lefthalf);
 		} else if (!interlaced_offset) {
 			memmove(src, src + righthalf, lefthalf);
+			flush_dcache_page(rq->in[inpages - 1]);
 		}
 	}
 	kunmap_local(src);
-- 
2.43.5


