Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B205AC908
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Sep 2022 05:21:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MLYgx0l5sz2yyT
	for <lists+linux-erofs@lfdr.de>; Mon,  5 Sep 2022 13:21:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=fL+HTU4o;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=fL+HTU4o;
	dkim-atps=neutral
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MLYgn1xmnz2xRq
	for <linux-erofs@lists.ozlabs.org>; Mon,  5 Sep 2022 13:20:51 +1000 (AEST)
Received: by mail-pj1-x102d.google.com with SMTP id o15-20020a17090a3d4f00b002004ed4d77eso1882712pjf.5
        for <linux-erofs@lists.ozlabs.org>; Sun, 04 Sep 2022 20:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=1XsIXzCfYSNzIOIGImGAWV+tb3SyPubQmBiPiBkaZ8w=;
        b=fL+HTU4o9FF6kWlGXP5zzc+Su7OgwNV24fv++3yiaEw0ZjONVHunjE7lZ3bxiWAzIm
         +2sOBeflg8s25jcAxgdKy7tL5rxPeUSx8uK0VHC56/tCH1h1/j5gaaGRXWM2QdVqLaD+
         f+fecuNxkczvsV9u3yniZ8s39kSiG5oBE+VNRYqHi3ZcXzq7rvlpoiehjUKjvLbuzuld
         hV1mTog0ETLjjPeqnaHtvj5H0Y2jptPlGyXwdnMQamoaQY3/ooL96D1LsLYzia7lzVRZ
         0cf0JvrRMo8OP6q5AHW7NMqusvVt2UEc7SGGoY6sQi3sEKNnPK4terCyy826uhtK7dIY
         BoiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=1XsIXzCfYSNzIOIGImGAWV+tb3SyPubQmBiPiBkaZ8w=;
        b=3Pkbs+syRJrM4M1u7aKOVHDWwI4prNSqYM7hnfP+ab/AmmDw+QlqbDqAohOlfiAzk3
         MweK97v7O5q5fS4pgyjxVmpKIWxtt5SOFRzNYDUqjaZkUxjBYbvm07V+Lo51ydLaC5fH
         NAN4RAC5AwRZ4P+51okdVPulPT4m8W+Xfqt7HizlXrx2Y2OYngQ6HtJd1MrJEkTiWdPJ
         9zk0qQfs7FgJYUXAkQP40bfO9XO1Xk75no6L1ZCYOkT+xuNqSeUilV0tvgVREca55zzL
         m0FgxUCP94jK28J5st8k5NSwp/g/t4Fshfx3bpJsAmg0fpo141lToFWYa0dNl2bjbnhi
         Le3A==
X-Gm-Message-State: ACgBeo004DHJzbT9WvSP/JE8ir464OzifEpBD1+2QwyO5rs2VnbbrjpF
	8MfQjz+Rk/eyEfjosjezyRA=
X-Google-Smtp-Source: AA6agR5y83vwrBlpEZ0CWr8hny5Qz72uTm7u7os2hkcASUtX/LnGioJIsBg/ua/q9rZJ2MS7o8lBoQ==
X-Received: by 2002:a17:90a:ac2:b0:1fd:fad1:e506 with SMTP id r2-20020a17090a0ac200b001fdfad1e506mr17466968pje.66.1662348049040;
        Sun, 04 Sep 2022 20:20:49 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id w5-20020a17090ac98500b001f216407204sm5610265pjt.36.2022.09.04.20.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 20:20:48 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org
Subject: [RFC PATCH v3 1/2] erofs: support interlaced uncompressed data for compressed files
Date: Mon,  5 Sep 2022 11:20:07 +0800
Message-Id: <3d5e2da044c751afdd4dc8a5b845b18d2e14194b.1662347031.git.huyue2@coolpad.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1662347031.git.huyue2@coolpad.com>
References: <cover.1662347031.git.huyue2@coolpad.com>
In-Reply-To: <cover.1662347031.git.huyue2@coolpad.com>
References: <cover.1662347031.git.huyue2@coolpad.com>
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

Currently, there is no start offset when writing uncompressed data to
disk blocks for compressed files. However, we are using in-place I/O
which will decrease the number of memory copies a lot if we write it
just from an offset of 'pageofs_out'. So, let's support it.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/compress.h     |  3 +++
 fs/erofs/decompressor.c | 12 +++++++-----
 fs/erofs/erofs_fs.h     |  2 ++
 fs/erofs/zdata.c        | 12 +++++++++++-
 fs/erofs/zdata.h        |  3 +++
 5 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/compress.h b/fs/erofs/compress.h
index 26fa170090b8..cef26c63d6b1 100644
--- a/fs/erofs/compress.h
+++ b/fs/erofs/compress.h
@@ -15,6 +15,9 @@ struct z_erofs_decompress_req {
 	unsigned short pageofs_in, pageofs_out;
 	unsigned int inputsize, outputsize;
 
+	/* cut point of interlaced uncompressed data */
+	unsigned int interlaced_offset;
+
 	/* indicate the algorithm will be used for decompression */
 	unsigned int alg;
 	bool inplace_io, partial_decoding, fillgaps;
diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 2d55569f96ac..e5dc8eb992b1 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -340,18 +340,20 @@ static int z_erofs_shifted_transform(struct z_erofs_decompress_req *rq,
 	src = kmap_atomic(*rq->in) + rq->pageofs_in;
 	if (rq->out[0]) {
 		dst = kmap_atomic(rq->out[0]);
-		memcpy(dst + rq->pageofs_out, src, righthalf);
+		memcpy(dst + rq->pageofs_out, src + rq->interlaced_offset,
+		       righthalf);
 		kunmap_atomic(dst);
 	}
 
 	if (nrpages_out == 2) {
 		DBG_BUGON(!rq->out[1]);
-		if (rq->out[1] == *rq->in) {
-			memmove(src, src + righthalf, lefthalf);
-		} else {
+		if (rq->out[1] != *rq->in) {
 			dst = kmap_atomic(rq->out[1]);
-			memcpy(dst, src + righthalf, lefthalf);
+			memcpy(dst, rq->interlaced_offset ? src :
+						(src + righthalf), lefthalf);
 			kunmap_atomic(dst);
+		} else if (!rq->interlaced_offset) {
+			memmove(src, src + righthalf, lefthalf);
 		}
 	}
 	kunmap_atomic(src);
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
diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 5792ca9e0d5e..bbaa3a924852 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -481,6 +481,7 @@ static void z_erofs_try_to_claim_pcluster(struct z_erofs_decompress_frontend *f)
 
 static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 {
+	struct erofs_inode *const vi = EROFS_I(fe->inode);
 	struct erofs_map_blocks *map = &fe->map;
 	bool ztailpacking = map->m_flags & EROFS_MAP_META;
 	struct z_erofs_pcluster *pcl;
@@ -508,6 +509,12 @@ static int z_erofs_register_pcluster(struct z_erofs_decompress_frontend *fe)
 	pcl->pageofs_out = map->m_la & ~PAGE_MASK;
 	fe->mode = Z_EROFS_PCLUSTER_FOLLOWED;
 
+	pcl->interlaced = false;
+	if ((vi->z_advise & Z_EROFS_ADVISE_INTERLACED_PCLUSTER) &&
+	    pcl->algorithmformat == Z_EROFS_COMPRESSION_SHIFTED &&
+	    pcl->pageofs_out)
+		pcl->interlaced = true;
+
 	/*
 	 * lock all primary followed works before visible to others
 	 * and mutex_trylock *never* fails for a new pcluster.
@@ -972,7 +979,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	struct erofs_sb_info *const sbi = EROFS_SB(be->sb);
 	struct z_erofs_pcluster *pcl = be->pcl;
 	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
-	unsigned int i, inputsize;
+	unsigned int i, inputsize, interlaced_offset;
 	int err2;
 	struct page *page;
 	bool overlapped;
@@ -1015,6 +1022,8 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 	else
 		inputsize = pclusterpages * PAGE_SIZE;
 
+	interlaced_offset = pcl->interlaced ? pcl->pageofs_out : 0;
+
 	err = z_erofs_decompress(&(struct z_erofs_decompress_req) {
 					.sb = be->sb,
 					.in = be->compressed_pages,
@@ -1023,6 +1032,7 @@ static int z_erofs_decompress_pcluster(struct z_erofs_decompress_backend *be,
 					.pageofs_out = pcl->pageofs_out,
 					.inputsize = inputsize,
 					.outputsize = pcl->length,
+					.interlaced_offset = interlaced_offset,
 					.alg = pcl->algorithmformat,
 					.inplace_io = overlapped,
 					.partial_decoding = pcl->partial,
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index e7f04c4fbb81..75f3a52fc66f 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -87,6 +87,9 @@ struct z_erofs_pcluster {
 	/* L: indicate several pageofs_outs or not */
 	bool multibases;
 
+	/* I: whether interlaced uncompressed data or not */
+	bool interlaced;
+
 	/* A: compressed bvecs (can be cached or inplaced pages) */
 	struct z_erofs_bvec compressed_bvecs[];
 };
-- 
2.17.1

