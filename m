Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85B142D213
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Oct 2021 07:59:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HVJdZ6TlZz2yg4
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Oct 2021 16:59:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=iahSOQo8;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636;
 helo=mail-pl1-x636.google.com; envelope-from=zbestahu@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=iahSOQo8; dkim-atps=neutral
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HVJdX1ZJBz2xt0
 for <linux-erofs@lists.ozlabs.org>; Thu, 14 Oct 2021 16:59:43 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id y1so3384545plk.10
 for <linux-erofs@lists.ozlabs.org>; Wed, 13 Oct 2021 22:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z6RUPW2Adv9jzR1Z8rYigTRUGThIFrNbP7qQXF9NsjQ=;
 b=iahSOQo8wGJpY4BfssZefsKFFZ4KO0NEBdjjudsRBPj7m/h2Wi0JzcoFvfCVe+3mwt
 0whZicdiNv6tRb8uxKbE9YhW4L24L+gVTNXGZbNI3TQ6PpO+EY/xgHMWx+s9lwp+0W+/
 cmT4U23EPswcEAwwsjWfx/VuSjQYUssnwBbep4jhVazo1/zdmsw7j5J2xRiuG+DcLSph
 YQ3wkKianz+3BkvujbecXPg0OF0k+TLr+trlwyi17wOZvWkOflihvAtVtz2Yyrw9EvXa
 b6UhM8D79HsDh8omA4uzZJcqF98v63MymREUwMt8Pb+YQbKYptgfZeg8ptxABmDXACnI
 n+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=z6RUPW2Adv9jzR1Z8rYigTRUGThIFrNbP7qQXF9NsjQ=;
 b=gZ0CpgouficZdKb6iMU+T8FJiEuMnwx4Lz8QmpajwpknImKIVMcowUr31uh0g7kEbE
 oj68pycGSITC2pXTnQzOH7MD28fXu/XZaV2AcC2f7uPzEzNz3hj3IMSy+cgIzrdDZ7t9
 BLCtWkDFlfbZPYZ/oc6lIylMvVZ8R2JwYF2axZa8HbbOFwHhAQvy8DUIXwbOIEp1YiMH
 MrBV891G1z6kYcACTwKvui2OAPTJsP/yLlSZWtzie+WX7zDEfCneHRo4r1LIOqldxMP4
 IaIIiyUJhBlHAbOdmnzyCc6Pl6b3Za4eslflIlNFXHbDBWbx+JuzXVJfeVx/1HsaOdqd
 prDQ==
X-Gm-Message-State: AOAM532/qNYocZwqCB6n3IiDHGBcKtqYwODb2+sg3YX84SOOh1utlpuM
 2//4YFGNAlA24snM0PAOKO0=
X-Google-Smtp-Source: ABdhPJxM3XnN87SlkVpWim8Pcgp2SWIuw+2iN4uRRup0PfoT4CVJcH6/4aItGkbeAFgkY7KKqbB1bA==
X-Received: by 2002:a17:902:ce86:b0:13f:16c5:c666 with SMTP id
 f6-20020a170902ce8600b0013f16c5c666mr3380738plg.88.1634191180056; 
 Wed, 13 Oct 2021 22:59:40 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
 by smtp.gmail.com with ESMTPSA id v20sm1295670pff.171.2021.10.13.22.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Oct 2021 22:59:39 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: remove the fast path of per-CPU buffer decompression
Date: Thu, 14 Oct 2021 13:57:56 +0800
Message-Id: <20211014055756.1549-1-zbestahu@gmail.com>
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
with LZMA which will return 0 as well for that case.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 fs/erofs/decompressor.c | 64 +++++++------------------------------------------
 1 file changed, 8 insertions(+), 56 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index a5bc4b1..9905551 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -254,7 +254,7 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 		DBG_BUGON(1);
 		return -EFAULT;
 	}
-	return ret;
+	return ret > 0 ? 0 : ret;
 }
 
 static struct z_erofs_decompressor decompressors[] = {
@@ -268,33 +268,6 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
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
@@ -305,34 +278,13 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
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
+	if (rq->inputsize <= PAGE_SIZE &&
+	    nrpages_out == 1 && !rq->inplace_io) {
+		DBG_BUGON(!*rq->out);
+		dst = kmap_atomic(*rq->out);
+		dst_maptype = 0;
+		goto dstmap_out;
 	}
 
 	/* general decoding path which can be used for all cases */
-- 
1.9.1

