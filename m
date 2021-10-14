Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A70242D31D
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Oct 2021 08:58:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HVKx46BH0z2xY5
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Oct 2021 17:58:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=VU9jibIQ;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535;
 helo=mail-pg1-x535.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=VU9jibIQ; dkim-atps=neutral
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com
 [IPv6:2607:f8b0:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HVKx13NYxz2xWx
 for <linux-erofs@lists.ozlabs.org>; Thu, 14 Oct 2021 17:58:13 +1100 (AEDT)
Received: by mail-pg1-x535.google.com with SMTP id r2so4616763pgl.10
 for <linux-erofs@lists.ozlabs.org>; Wed, 13 Oct 2021 23:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=90F5GgkLIzukAhvTUV+3ZzegFo7c/yVw23FmmmyLKiI=;
 b=VU9jibIQXVcmVaH2SOhkP9l3k7zUgV40ftobar8AZgoRHL4i3UJXHNLih5Y0wEX3La
 lYS8avExv0xbWA5SrMeAETDEr1/hPMajlBL7GHqb9f1sx0f42q1OhnPKGjP080R4jPVW
 GVoiZOrRy6joTosLhQiGMdmmWo5ZCE8xbcnerORU7GCtgWCwz9YXm5Z54txP03fOe27x
 GZ+MXyhFOc2U5Cy2PoptgW/LTLeVjVOXBz64/o2Q6HnOH+1maFMn2kuMMcuNgymcSjA+
 OVc4PQ8C5Vcr9OYSq/2gZwZgNO7RLsd9SPvvPD+rvkx/C1ChUkW1QBOuaJOTyoFFCk0O
 91Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=90F5GgkLIzukAhvTUV+3ZzegFo7c/yVw23FmmmyLKiI=;
 b=uS/jwtZ6ht/POWowZJzDsbgM19iDRI6DdnwBULTQWP7clILv7pUiEz+rmejsqmAVke
 Jgs+WEG1hIou+11StDCmoo3fy7FBfjYvihSNxh/VCngMv9Xya1AJcWSBSRO1bBTtZ4v+
 qDQ8RbuTLppiWm35q2zxfsWoYdrfqJhKaHsjhGUPo/OI2pIUze1o2h1xQyT7otXBo2uB
 F84Tsj6qgPneDgw9zMpoz/jHr9/p2RDbb4CwmgCdiGe+5CoeYBGadl5c39ttqVr8pBVc
 UvF1dqeySGbTykk+zLw87S+IScjsUa1N5NMUou7pbXLl2FzUuP1Ddj1sML0egSSKvmV3
 EH3g==
X-Gm-Message-State: AOAM531SJdeOPOHxiCW4yMEoCQaBMxOYFSvGYryFMCRssqnUv6MkBjOq
 DKIsLETzA5iUR0yRDvqourc=
X-Google-Smtp-Source: ABdhPJz4a95eMFhV5Mp4XkSq67jFVy4DJT0e8XpQWvj/20b+JQrbT4+Tu7tKhWRnxNmdNhhpgcb8Aw==
X-Received: by 2002:a65:6398:: with SMTP id h24mr2919614pgv.367.1634194691474; 
 Wed, 13 Oct 2021 23:58:11 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id p9sm1670864pfh.162.2021.10.13.23.58.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 23:58:10 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs: remove the fast path of per-CPU buffer decompression
Date: Thu, 14 Oct 2021 14:57:44 +0800
Message-Id: <20211014065744.1787-1-zbestahu@gmail.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, huyue2@yulong.com,
 zhangwen@yulong.com, linux-kernel@vger.kernel.org, zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@yulong.com>

As Xiang mentioned, such path has no real impact to our current
decompression strategy, remove it directly. Also, update the return
value of z_erofs_lz4_decompress() to 0 if success to keep consistent
with LZMA which will return 0 as well for that case.

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Yue Hu <huyue2@yulong.com>
---
v2: just set ret = 0 in else branch and rearrange if statement into one line.
v3: "paths" -> "path", recover missing message words in v2.

 fs/erofs/decompressor.c | 63 +++++++------------------------------------------
 1 file changed, 8 insertions(+), 55 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 88e33ad..a8a4e3d 100644
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
+	/* one optimized fast path only for non bigpcluster cases yet */
+	if (rq->inputsize <= PAGE_SIZE && nrpages_out == 1 && !rq->inplace_io) {
+		DBG_BUGON(!*rq->out);
+		dst = kmap_atomic(*rq->out);
+		dst_maptype = 0;
+		goto dstmap_out;
 	}
 
 	/* general decoding path which can be used for all cases */
-- 
1.9.1

