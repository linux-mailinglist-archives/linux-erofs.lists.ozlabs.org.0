Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6178622E9
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Feb 2024 07:27:14 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tGqXzzcx;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ThcNs1rxYz3vXM
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Feb 2024 17:27:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tGqXzzcx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ThcNj427Zz3cDr
	for <linux-erofs@lists.ozlabs.org>; Sat, 24 Feb 2024 17:26:59 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708756015; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4GEqWX6yU3+p/xenHNHEWR+mKGMypPUF4pv+LX4hbk0=;
	b=tGqXzzcx2LPOFhuNHr2+ZHYaIsWHHzS/IQU2MMpwePRG5Ng0JIvKVI7rpMRAr8PFfflY1zV4QUULV6YQI6ukUPZyKUFUwc7lY/Ln3YNPcJouQ8az8Zo4tn8qoAM1epjgFsFlYxTMYcRH9Hyz/uQaG74LXYU2b+iH/5bldgmv+iY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W16.xLk_1708756005;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W16.xLk_1708756005)
          by smtp.aliyun-inc.com;
          Sat, 24 Feb 2024 14:26:53 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: [PATCH 5.15.y] erofs: fix lz4 inplace decompression
Date: Sat, 24 Feb 2024 14:26:43 +0800
Message-Id: <20240224062643.2099614-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <2024012648-backwater-colt-7290@gregkh>
References: <2024012648-backwater-colt-7290@gregkh>
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
Cc: Juhyung Park <qkrwngud825@gmail.com>, Gao Xiang <hsiangkao@linux.alibaba.com>, Yifan Zhao <zhaoyifan@sjtu.edu.cn>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

commit 3c12466b6b7bf1e56f9b32c366a3d83d87afb4de upstream.

Currently EROFS can map another compressed buffer for inplace
decompression, that was used to handle the cases that some pages of
compressed data are actually not in-place I/O.

However, like most simple LZ77 algorithms, LZ4 expects the compressed
data is arranged at the end of the decompressed buffer and it
explicitly uses memmove() to handle overlapping:
  __________________________________________________________
 |_ direction of decompression --> ____ |_ compressed data _|

Although EROFS arranges compressed data like this, it typically maps two
individual virtual buffers so the relative order is uncertain.
Previously, it was hardly observed since LZ4 only uses memmove() for
short overlapped literals and x86/arm64 memmove implementations seem to
completely cover it up and they don't have this issue.  Juhyung reported
that EROFS data corruption can be found on a new Intel x86 processor.
After some analysis, it seems that recent x86 processors with the new
FSRM feature expose this issue with "rep movsb".

Let's strictly use the decompressed buffer for lz4 inplace
decompression for now.  Later, as an useful improvement, we could try
to tie up these two buffers together in the correct order.

Reported-and-tested-by: Juhyung Park <qkrwngud825@gmail.com>
Closes: https://lore.kernel.org/r/CAD14+f2AVKf8Fa2OO1aAUdDNTDsVzzR6ctU_oJSmTyd6zSYR2Q@mail.gmail.com
Fixes: 0ffd71bcc3a0 ("staging: erofs: introduce LZ4 decompression inplace")
Fixes: 598162d05080 ("erofs: support decompress big pcluster for lz4 backend")
Cc: stable <stable@vger.kernel.org> # 5.4+
Tested-by: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Link: https://lore.kernel.org/r/20231206045534.3920847-1-hsiangkao@linux.alibaba.com
---
Adapt 5.15.y codebase due to non-trivial conflicts out of
recent new features & cleanups.

I've done my own EROFS tests, yet more test on new x86
platform triggered by FSRM is helpful too.

 fs/erofs/decompressor.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index 8193c14bb111..b4be6c524815 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -124,11 +124,11 @@ static int z_erofs_lz4_prepare_destpages(struct z_erofs_decompress_req *rq,
 }
 
 static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
-			void *inpage, unsigned int *inputmargin, int *maptype,
-			bool support_0padding)
+		void *inpage, void *out, unsigned int *inputmargin, int *maptype,
+		bool support_0padding)
 {
 	unsigned int nrpages_in, nrpages_out;
-	unsigned int ofull, oend, inputsize, total, i, j;
+	unsigned int ofull, oend, inputsize, total, i;
 	struct page **in;
 	void *src, *tmp;
 
@@ -143,12 +143,13 @@ static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
 		    ofull - oend < LZ4_DECOMPRESS_INPLACE_MARGIN(inputsize))
 			goto docopy;
 
-		for (i = 0; i < nrpages_in; ++i) {
-			DBG_BUGON(rq->in[i] == NULL);
-			for (j = 0; j < nrpages_out - nrpages_in + i; ++j)
-				if (rq->out[j] == rq->in[i])
-					goto docopy;
-		}
+		for (i = 0; i < nrpages_in; ++i)
+			if (rq->out[nrpages_out - nrpages_in + i] !=
+			    rq->in[i])
+				goto docopy;
+		kunmap_atomic(inpage);
+		*maptype = 3;
+		return out + ((nrpages_out - nrpages_in) << PAGE_SHIFT);
 	}
 
 	if (nrpages_in <= 1) {
@@ -156,7 +157,6 @@ static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
 		return inpage;
 	}
 	kunmap_atomic(inpage);
-	might_sleep();
 	src = erofs_vm_map_ram(rq->in, nrpages_in);
 	if (!src)
 		return ERR_PTR(-ENOMEM);
@@ -193,10 +193,10 @@ static void *z_erofs_handle_inplace_io(struct z_erofs_decompress_req *rq,
 	return src;
 }
 
-static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
+static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *dst)
 {
 	unsigned int inputmargin;
-	u8 *headpage, *src;
+	u8 *out, *headpage, *src;
 	bool support_0padding;
 	int ret, maptype;
 
@@ -220,11 +220,12 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 	}
 
 	rq->inputsize -= inputmargin;
-	src = z_erofs_handle_inplace_io(rq, headpage, &inputmargin, &maptype,
-					support_0padding);
+	src = z_erofs_handle_inplace_io(rq, headpage, dst, &inputmargin,
+					&maptype, support_0padding);
 	if (IS_ERR(src))
 		return PTR_ERR(src);
 
+	out = dst + rq->pageofs_out;
 	/* legacy format could compress extra data in a pcluster. */
 	if (rq->partial_decoding || !support_0padding)
 		ret = LZ4_decompress_safe_partial(src + inputmargin, out,
@@ -253,7 +254,7 @@ static int z_erofs_lz4_decompress(struct z_erofs_decompress_req *rq, u8 *out)
 		vm_unmap_ram(src, PAGE_ALIGN(rq->inputsize) >> PAGE_SHIFT);
 	} else if (maptype == 2) {
 		erofs_put_pcpubuf(src);
-	} else {
+	} else if (maptype != 3) {
 		DBG_BUGON(1);
 		return -EFAULT;
 	}
@@ -354,8 +355,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	dst_maptype = 2;
 
 dstmap_out:
-	ret = alg->decompress(rq, dst + rq->pageofs_out);
-
+	ret = alg->decompress(rq, dst);
 	if (!dst_maptype)
 		kunmap_atomic(dst);
 	else if (dst_maptype == 2)
-- 
2.39.3

