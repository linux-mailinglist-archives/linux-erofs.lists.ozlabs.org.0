Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FC85E71C9
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Sep 2022 04:12:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MYbK24r5nz3c6J
	for <lists+linux-erofs@lfdr.de>; Fri, 23 Sep 2022 12:12:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Qdc5dGGR;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::530; helo=mail-pg1-x530.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Qdc5dGGR;
	dkim-atps=neutral
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MYbJy1plcz3bcF
	for <linux-erofs@lists.ozlabs.org>; Fri, 23 Sep 2022 12:12:48 +1000 (AEST)
Received: by mail-pg1-x530.google.com with SMTP id f193so10982599pgc.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 22 Sep 2022 19:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date;
        bh=nBLIRKbQy5m+kK9o+AaELIEBiSlMmEbK2d2rH3x2pJ8=;
        b=Qdc5dGGRjnzDt565/IPgqBjHZoX7CHW5WoLzTKGzLbYgeVrjVc+b5uAYq9Is7HkZ9E
         9EAHREbKIc7fR0//g1R4Oes1ucj/AeTbO3JmO+mafERA7suTwUEYMnk+oat0KxxNXCcn
         H8sGY3dYYYGfyWg+44q+lqUZkwyrJb0q1ZNWFLMRBYgMPe8W1/plmzL3GMOn3bbMWPtB
         NBUNFvSAkz9/E4cIhPUeftE1O3U8dKuesvWF7ARaQSIgN8dceVJ9fQoQlX3i38+rAKv5
         HxafXt3gt4jeQwrCuqtVNt5DW6ES9xtiWC9Qca7ySGQFHxOHEKM2T6WZU1Ld5mv2CcRl
         R5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nBLIRKbQy5m+kK9o+AaELIEBiSlMmEbK2d2rH3x2pJ8=;
        b=Cr0ZCbaSFIIxbIuyIQeF5MJhV96fkKv7rXhiHMsNkCbBCacVdNksI9qTkmSAotH2E6
         Ifid+9UncYiIS+PY+wAOmeTMvCW4AlMmwG7UvYe9jYrhsiJ3EPU7pl6OVp+PY1nJJ+3k
         wVUJXn+Zj5iCAk0luA6KA7fOly3BT2SIBKFrHlGYkxRFjk3mmSrNxeY8JkLDAlsQXgkr
         GVBbkYT/DFgwB+OG/jQ/gj5wGUH2uOzOSP33WoBsexJocQLwtRRKtm53ZBJgnvqZWBMZ
         RyJTvpKuvw42TwdOE7uJWJUEVGx8YHpXZySReYYZRPI0Np+N30qlfhoVXtiAE1RfXTWd
         VG0Q==
X-Gm-Message-State: ACrzQf2J7AisZOEXqDaz43X5GpQFBEk0AWrsFVsnTFJ0dEUCGrcUsTYi
	ZZ9QDk0/UojT4JazUQKSbL8=
X-Google-Smtp-Source: AMsMyM6Xmx11kK3SIMvtkK748zGxlz2fPbrlhOnDsg3depP0GiStQPv1vl+oSTc+jjLGIicV5RO3PA==
X-Received: by 2002:a05:6a02:19c:b0:43c:401:1bc9 with SMTP id bj28-20020a056a02019c00b0043c04011bc9mr5543119pgb.222.1663899164521;
        Thu, 22 Sep 2022 19:12:44 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001768517f99esm4735204plf.244.2022.09.22.19.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 19:12:44 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [PATCH v6 1/2] erofs: support interlaced uncompressed data for compressed files
Date: Fri, 23 Sep 2022 10:11:21 +0800
Message-Id: <8369112678604fdf4ef796626d59b1fdd0745a53.1663898962.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1663898962.git.huyue2@coolpad.com>
References: <cover.1663898962.git.huyue2@coolpad.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
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
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
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

