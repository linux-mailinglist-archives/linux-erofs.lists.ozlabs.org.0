Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 876D774008F
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jun 2023 18:13:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qr8rr3FQvz30hB
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jun 2023 02:13:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qr8rc2lXFz2xTR
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jun 2023 02:13:02 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Vm6X30h_1687882372;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vm6X30h_1687882372)
          by smtp.aliyun-inc.com;
          Wed, 28 Jun 2023 00:12:53 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs: simplify z_erofs_transform_plain()
Date: Wed, 28 Jun 2023 00:12:40 +0800
Message-Id: <20230627161240.331-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230627161240.331-1-hsiangkao@linux.alibaba.com>
References: <20230627161240.331-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use memcpy_to_page() instead of open-coding them.

In addition, add a missing flush_dcache_page() even though almost all
modern architectures clear `PG_dcache_clean` flag for new file cache
pages so that it doesn't change anything in practice.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
preliminary tested with silesia dataset.

 fs/erofs/decompressor.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index ad53cf52d899..cfad1eac7fd9 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -328,7 +328,7 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
 	const unsigned int lefthalf = rq->outputsize - righthalf;
 	const unsigned int interlaced_offset =
 		rq->alg == Z_EROFS_COMPRESSION_SHIFTED ? 0 : rq->pageofs_out;
-	unsigned char *src, *dst;
+	u8 *src;
 
 	if (outpages > 2 && rq->alg == Z_EROFS_COMPRESSION_SHIFTED) {
 		DBG_BUGON(1);
@@ -341,22 +341,19 @@ static int z_erofs_transform_plain(struct z_erofs_decompress_req *rq,
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
2.24.4

