Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8811F42D2D4
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Oct 2021 08:39:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HVKWk6jVVz2ysq
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Oct 2021 17:39:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=OLjdXKse;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d;
 helo=mail-pj1-x102d.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=OLjdXKse; dkim-atps=neutral
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HVKWc2m8pz2xfM
 for <linux-erofs@lists.ozlabs.org>; Thu, 14 Oct 2021 17:39:39 +1100 (AEDT)
Received: by mail-pj1-x102d.google.com with SMTP id
 q10-20020a17090a1b0a00b001a076a59640so4986896pjq.0
 for <linux-erofs@lists.ozlabs.org>; Wed, 13 Oct 2021 23:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3aIVKuzI3Dv4Fcy3CYcnfW1yxN1O0fSYPq2cnv41BVc=;
 b=OLjdXKseZ4gUQA2hQBRzUhGG3G+56UxGwcrZcGluEj/0YCeqmIVE0IBiFJRkHVWxSJ
 RNI37/6aOy4iP2yNZpdwj9CWW3/nkemdqltxSdkZy85G+L/VIzsWDIZwxYOLVd2S34vl
 tbUqQUoeoxTxMN9FQN9WbWnM4PyIeKaY7gZLK8CPiyv4QFSfM/DiZeUmbs2tGThaLi77
 lw/zojoxajtzaj9zPVnZostHmWW9O4x+G5gKQRuOggyB/ceSO68Te+s2Zr+1qmGf1j31
 jaSeXc52dLiyEGFAtBmZdc0HIrAaquU+ckB3PRA053ZOxWoPZCxluLqxPgCOIjwswDL5
 4Y3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3aIVKuzI3Dv4Fcy3CYcnfW1yxN1O0fSYPq2cnv41BVc=;
 b=Nc/RdSni+tSShLtrN5q7SgHIWH0v9JRTyOr9RFdHe8mDi8ljRRtokj0xJjBg6pz5/t
 YSRTLnbhX9JTSPYpdDju7PTHN2Gyi61tJrDGE40zu4Q9defnTOZW21BGC7f0wqLAZT7f
 I4JsMBb042Fj48d2iZ9OhPv5THY6mp+M7xRqJaJC2U00NeFpDPNVK+NHCicwZvoc/gvb
 icUICTbmQgBEchvZtAu3JIMNgZexDmbAukPtzVrRiRawxvDeFlJS01FX63IuzyE7zLsR
 SHVwRC7rmiF0bHg8r57dMB6Dg99HzTBajMnTCJJDNqJ0acCu+lLw2POMgdir9Qoearpy
 5XNA==
X-Gm-Message-State: AOAM5302rQh8dM18K4NklXJULCHiqnR4zp0K3CT7Y4dJa1bk+p4JsHaS
 HXhIzSGYSa/Oxwku3ajWnbg=
X-Google-Smtp-Source: ABdhPJz3cyaTYA44BcyCgjvDwXXLh4LSF9kdIIliUC16vy216WP3a1lkOAgQDc0pAE++tC55yUrUGQ==
X-Received: by 2002:a17:90b:4c86:: with SMTP id
 my6mr4293450pjb.203.1634193576416; 
 Wed, 13 Oct 2021 23:39:36 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id p2sm1412887pgd.84.2021.10.13.23.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 23:39:35 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: remove the fast path of per-CPU buffer decompression
Date: Thu, 14 Oct 2021 14:39:01 +0800
Message-Id: <20211014063901.1629-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
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
Cc: huyue2@yulong.com, zhangwen@yulong.com, linux-kernel@vger.kernel.org,
 zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

As Xiang mentioned, such path has no real impact to our current
decompression strategy, remove it directly. Also, update the return
value of z_erofs_lz4_decompress() to 0 if success to keep consistent
with LZMA which will return 0 for that case.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
v2: just set ret = 0 in else branch and rearrange if statement into one line.

 fs/erofs/decompressor.c | 63 +++++++------------------------------------------
 1 file changed, 8 insertions(+), 55 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 88e33ad..f8a372e 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -243,6 +243,8 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 		if (ret >= 0)
 			memset(out + ret, 0, rq->outputsize - ret);
 		ret = -EIO;
+	} else {
+		ret = 0;
 	}
 
 	if (maptype == 0) {
@@ -269,33 +271,6 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 	},
 };
 
-static void copy_from_pcpubuf(struct page **out, const char *dst,
-			      unsigned short pageofs_out,
-			      unsigned int outputsize)
-{
-	const char *end = dst + outputsize;
-	const unsigned int righthalf = PAGE_SIZE - pageofs_out;
-	const char *cur = dst - pageofs_out;
-
-	while (cur < end) {
-		struct page *const page = *out++;
-
-		if (page) {
-			char *buf = kmap_atomic(page);
-
-			if (cur >= dst) {
-				memcpy(buf, cur, min_t(uint, PAGE_SIZE,
-						       end - cur));
-			} else {
-				memcpy(buf + pageofs_out, cur + pageofs_out,
-				       min_t(uint, righthalf, end - cur));
-			}
-			kunmap_atomic(buf);
-		}
-		cur += PAGE_SIZE;
-	}
-}
-
 static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 				      struct list_head *pagepool)
 {
@@ -306,34 +281,12 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	void *dst;
 	int ret;
 
-	/* two optimized fast paths only for non bigpcluster cases yet */
-	if (rq->inputsize <= PAGE_SIZE) {
-		if (nrpages_out == 1 && !rq->inplace_io) {
-			DBG_BUGON(!*rq->out);
-			dst = kmap_atomic(*rq->out);
-			dst_maptype = 0;
-			goto dstmap_out;
-		}
-
-		/*
-		 * For the case of small output size (especially much less
-		 * than PAGE_SIZE), memcpy the decompressed data rather than
-		 * compressed data is preferred.
-		 */
-		if (rq->outputsize <= PAGE_SIZE * 7 / 8) {
-			dst = erofs_get_pcpubuf(1);
-			if (IS_ERR(dst))
-				return PTR_ERR(dst);
-
-			rq->inplace_io = false;
-			ret = alg->decompress(rq, dst);
-			if (!ret)
-				copy_from_pcpubuf(rq->out, dst, rq->pageofs_out,
-						  rq->outputsize);
-
-			erofs_put_pcpubuf(dst);
-			return ret;
-		}
+	/* one optimized fast paths only for non bigpcluster cases yet */
+	if (rq->inputsize <= PAGE_SIZE && nrpages_out == 1 && !rq->inplace_io) {
+		DBG_BUGON(!*rq->out);
+		dst = kmap_atomic(*rq->out);
+		dst_maptype = 0;
+		goto dstmap_out;
 	}
 
 	/* general decoding path which can be used for all cases */
-- 
1.9.1

