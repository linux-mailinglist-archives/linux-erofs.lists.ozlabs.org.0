Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E975B6C2E
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 13:06:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MRgdn667kz3bbj
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Sep 2022 21:06:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=FguiKJYD;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=FguiKJYD;
	dkim-atps=neutral
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MRgdf3HPDz2xvJ
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 21:06:45 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so10984026pjh.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 13 Sep 2022 04:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=Dna0jbzOe4cc+tkUwZnxiT+7ajfuKJQBNUXCBRN9zpY=;
        b=FguiKJYDPfwB9opcnzRmp2m7Zjz6vt088E9qXaPs3WSu56u5B8mDrVpjUGSZAL/DFg
         spRLkGQTl9+E2SJlbOX4bBumtrUVAJh0IyzqXs46lF4iPT1CAvIkIvdMdY4D0JwfZul0
         blbmcBWbFuShVxk36ZmO1qNTGzC6COchLgHoFKP+JXtrApoEFApNNwZp4d/T724+J8J8
         KLLAeUkw0eu2IEafc9Colz+7Rxk2OudJ3HnxKEys+F7HYrx9eKeovEKFTzrWxffv005K
         Bl1VHPPFxUJHI9tvJpL1yRXXmzTIHoOVHs3fJZNFl7Yh5qGHQSDlCGAdy4hYjTshbzTg
         AQSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=Dna0jbzOe4cc+tkUwZnxiT+7ajfuKJQBNUXCBRN9zpY=;
        b=mRsltS88DZ0+RPiXVrJonYOe5vmUW+wSULUYDKFwuSU0WI8wuueyXIKfTzP+sT4tV1
         Uo3IhDpjnD8aXg09Xj20rAN39f94mZZCQZci8DeG0dBYCZ0kXz5C9sKHaXf467YyO3LE
         5WH7VwWtX8L4N5T4bqPPcj4IJ4cedOdtMp10LgS7zT6eIxvRBb95rdYyafkthyWUCDDj
         O5FZH/P3kFp099avMYF0ck31fPCbWWzoNfmY2BzHoxsF2lW112oNqYvvXJ8RX0K18UMK
         ZXjqcy5EDbFbLjHi1Y9S/1rmmAKEgLpBjrsQeedCXGUZhugMbgcroOIoR2VXgZU8ZdJj
         bTeA==
X-Gm-Message-State: ACgBeo1w73WbpqvuQ6wkPfutfPCK1hDFgfYWVcayDo5BDcn3u8E24vMv
	7VU0tkJgT4EVxvzB5ZXU07U=
X-Google-Smtp-Source: AA6agR7hbfK/XhnYBW4UGtVSi43kFhgabslRYF4wkTOloB+sM7cGUSDPDfKT5ZIksBdwlnEv+9fjdQ==
X-Received: by 2002:a17:90b:1e0d:b0:202:91ec:e167 with SMTP id pg13-20020a17090b1e0d00b0020291ece167mr3351243pjb.174.1663067203891;
        Tue, 13 Sep 2022 04:06:43 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id cm3-20020a17090afa0300b002000d577cc3sm6888658pjb.55.2022.09.13.04.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 04:06:43 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [RFC PATCH v4 1/2] erofs: support interlaced uncompressed data for compressed files
Date: Tue, 13 Sep 2022 19:05:51 +0800
Message-Id: <2ef3d0fb6d1fa2d036ad4217d474d6efd12f63b9.1663066966.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663065625.git.huyue2@coolpad.com>
References: <cover.1663065625.git.huyue2@coolpad.com>
In-Reply-To: <cover.1663066966.git.huyue2@coolpad.com>
References: <cover.1663066966.git.huyue2@coolpad.com>
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
Cc: linux-kernel@vger.kernel.org, zhangwen@coolpad.com, Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, shaojunjun@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Currently, uncompressed data is all handled in the shifted way, which
means we have to shift the whole on-disk plain pcluster to get the
logical data.   However, since we are also using in-place I/O for
uncompressed data, data copy will be reduced a lot if pcluster is
recorded in the interlaced way as illustrated below:
 _______________________________________________________________
|               |    |               |_ tail part |_ head part _|
|<-   blk0    ->| .. |<-   blkn-2  ->|<-         blkn-1       ->|

The logical data then becomes:
 ________________________________________________________
|_ head part _|_  blk0  _| .. |_  blkn-2  _|_ tail part _|

In addition, non-4k plain pclusters are also survived by the
interlaced way, which can be used for non-4k lclusters as well.

However, it's almost impossible to de-duplicate uncompressed data
in the interlaced way, therefore shifted uncompressed data is still
useful.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/decompressor.c | 47 ++++++++++++++++++++++++-----------------
 fs/erofs/erofs_fs.h     |  2 ++
 fs/erofs/internal.h     |  1 +
 fs/erofs/zmap.c         | 14 ++++++++----
 4 files changed, 41 insertions(+), 23 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 2d55569f96ac..51b7ac7166d9 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -317,52 +317,61 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq,
 	return ret;
 }
 
-static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
-				     struct page **pagepool)
+static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
+				   struct page **pagepool)
 {
-	const unsigned int nrpages_out =
+	const unsigned int inpages = PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT;
+	const unsigned int outpages =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
 	const unsigned int righthalf = min_t(unsigned int, rq->outputsize,
 					     PAGE_SIZE - rq->pageofs_out);
 	const unsigned int lefthalf = rq->outputsize - righthalf;
+	const unsigned int interlaced_offset =
+		rq->alg == Z_EROFS_COMPRESSION_SHIFTED ? 0 : rq->pageofs_out;
 	unsigned char *src, *dst;
 
-	if (nrpages_out > 2) {
+	if (outpages > 2 && rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
 		DBG_BUGON(1);
-		return -EIO;
+		return -EFSCORRUPTED;
 	}
 
 	if (rq->out[0] == *rq->in) {
-		DBG_BUGON(nrpages_out != 1);
+		DBG_BUGON(rq->pageofs_out);
 		return 0;
 	}
 
-	src = kmap_atomic(*rq->in) + rq->pageofs_in;
+	src = kmap_local_page(rq->in[inpages - 1]) + rq->pageofs_in;
 	if (rq->out[0]) {
-		dst = kmap_atomic(rq->out[0]);
-		memcpy(dst + rq->pageofs_out, src, righthalf);
-		kunmap_atomic(dst);
+		dst = kmap_local_page(rq->out[0]);
+		memcpy(dst + rq->pageofs_out, src + interlaced_offset,
+		       righthalf);
+		kunmap_local(dst);
 	}
 
-	if (nrpages_out == 2) {
-		DBG_BUGON(!rq->out[1]);
-		if (rq->out[1] == *rq->in) {
+	if (outpages > inpages) {
+		DBG_BUGON(!rq->out[outpages - 1]);
+		if (rq->out[outpages - 1] != rq->in[inpages - 1]) {
+			dst = kmap_local_page(rq->out[outpages - 1]);
+			memcpy(dst, interlaced_offset ? src :
+					(src + righthalf), lefthalf);
+			kunmap_local(dst);
+		} else if (!interlaced_offset) {
 			memmove(src, src + righthalf, lefthalf);
-		} else {
-			dst = kmap_atomic(rq->out[1]);
-			memcpy(dst, src + righthalf, lefthalf);
-			kunmap_atomic(dst);
 		}
 	}
-	kunmap_atomic(src);
+	kunmap_local(src);
 	return 0;
 }
 
 static struct z_erofs_decompressor decompressors[] = {
 	[Z_EROFS_COMPRESSION_SHIFTED] = {
-		.decompress = z_erofs_shifted_transform,
+		.decompress = z_erofs_transform_plain,
 		.name = "shifted"
 	},
+	[Z_EROFS_COMPRESSION_INTERLACED] = {
+		.decompress = z_erofs_transform_plain,
+		.name = "interlaced"
+	},
 	[Z_EROFS_COMPRESSION_LZ4] = {
 		.decompress = z_erofs_lz4_decompress,
 		.name = "lz4"
diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
index 2b48373f690b..5c1de6d7ad71 100644
--- a/fs/erofs/erofs_fs.h
+++ b/fs/erofs/erofs_fs.h
@@ -295,11 +295,13 @@ struct z_erofs_lzma_cfgs {
  * bit 1 : HEAD1 big pcluster (0 - off; 1 - on)
  * bit 2 : HEAD2 big pcluster (0 - off; 1 - on)
  * bit 3 : tailpacking inline pcluster (0 - off; 1 - on)
+ * bit 4 : interlaced plain pcluster (0 - off; 1 - on)
  */
 #define Z_EROFS_ADVISE_COMPACTED_2B		0x0001
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_1		0x0002
 #define Z_EROFS_ADVISE_BIG_PCLUSTER_2		0x0004
 #define Z_EROFS_ADVISE_INLINE_PCLUSTER		0x0008
+#define Z_EROFS_ADVISE_INTERLACED_PCLUSTER	0x0010
 
 struct z_erofs_map_header {
 	__le16	h_reserved1;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index cfee49d33b95..f3ed36445d73 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -436,6 +436,7 @@ struct erofs_map_blocks {
 
 enum {
 	Z_EROFS_COMPRESSION_SHIFTED = Z_EROFS_COMPRESSION_MAX,
+	Z_EROFS_COMPRESSION_INTERLACED,
 	Z_EROFS_COMPRESSION_RUNTIME_MAX
 };
 
diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index d58549ca1df9..7196235a441c 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -679,12 +679,18 @@ static int z_erofs_do_map_blocks(struct inode *inode,
 			goto out;
 	}
 
-	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN)
-		map->m_algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
-	else if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2)
+	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN) {
+		if (vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER)
+			map->m_algorithmformat =
+				Z_EROFS_COMPRESSION_INTERLACED;
+		else
+			map->m_algorithmformat =
+				Z_EROFS_COMPRESSION_SHIFTED;
+	} else if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_HEAD2) {
 		map->m_algorithmformat = vi->z_algorithmtype[1];
-	else
+	} else {
 		map->m_algorithmformat = vi->z_algorithmtype[0];
+	}
 
 	if ((flags & EROFS_GET_BLOCKS_FIEMAP) ||
 	    ((flags & EROFS_GET_BLOCKS_READMORE) &&
-- 
2.17.1

