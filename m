Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E31377D09
	for <lists+linux-erofs@lfdr.de>; Mon, 10 May 2021 09:23:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FdswW1GRwz301t
	for <lists+linux-erofs@lfdr.de>; Mon, 10 May 2021 17:23:23 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=UytHVgFt;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=UytHVgFt; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FdswS2CSYz2yYV
 for <linux-erofs@lists.ozlabs.org>; Mon, 10 May 2021 17:23:20 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 686D261433;
 Mon, 10 May 2021 07:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620631398;
 bh=HZSDg2LN8wWjU5GC/dNPjZaCoRdg1JSiyytjnEl31u0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UytHVgFtQE4y4sh0KgOEFduDkkjgVYr9dManCqPWspVVag+btLOEizvsYCgZLByYs
 ohD6NAuStusLPbuw69YFHHBcKast598vjcrhnJp/hLq3fsAX1HtkduSyElPbojbqFH
 lYivM+HOIhDLdYOvyrq0VPT9UJEfUvYhxfZzKurq9Xf7jYGR2r2efYZkpXS8pN+oUj
 /QsgsqNnD7fRMTIVI5r+UFqH0at/Ar1B77rpSAzgMPuFd0sKS4Xi4lAIVXEFVoxjyQ
 IZsi8mGs24fGax4FcNgqFyhfZCoRO56EoCq+Z0c9LSGEI9FtQ0CdPTbdYQVQH+p1OX
 Yx14nsSQF7rzw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Li Guifu <bluce.liguifu@huawei.com>
Subject: [PATCH 1/4] erofs-utils: compress trailing data for big pcluster
 properly
Date: Mon, 10 May 2021 15:23:00 +0800
Message-Id: <20210510072303.4628-2-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210510072303.4628-1-xiang@kernel.org>
References: <20210510072303.4628-1-xiang@kernel.org>
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
Cc: Gao Xiang <xiang@kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Compress in smaller pcluster size if the trailing data isn't enough for
maximum pcluster size instead of leaving trailing data uncompressed.

Fixes: b71dc92df6f1 ("erofs-utils: mkfs: support multiple block compression")
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 lib/compress.c   | 11 ++++++++---
 lib/compressor.c |  5 ++++-
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index deef6a2c8ae3..e146416890f0 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -166,9 +166,12 @@ static int vle_compress_one(struct erofs_inode *inode,
 		bool raw;
 
 		if (len <= pclustersize) {
-			if (final)
-				goto nocompression;
-			break;
+			if (final) {
+				if (len <= EROFS_BLKSIZ)
+					goto nocompression;
+			} else {
+				break;
+			}
 		}
 
 		count = len;
@@ -195,6 +198,8 @@ nocompression:
 					EROFS_BLKSIZ - tailused : 0;
 
 			ctx->compressedblks = DIV_ROUND_UP(ret, EROFS_BLKSIZ);
+			DBG_BUGON(ctx->compressedblks * EROFS_BLKSIZ >= count);
+
 			/* zero out garbage trailing data for non-0padding */
 			if (!erofs_sb_has_lz4_0padding())
 				memset(dst + ret, 0,
diff --git a/lib/compressor.c b/lib/compressor.c
index b2434e0e5418..8836e0c785ba 100644
--- a/lib/compressor.c
+++ b/lib/compressor.c
@@ -28,6 +28,7 @@ int erofs_compress_destsize(struct erofs_compress *c,
 			    void *dst,
 			    unsigned int dstsize)
 {
+	unsigned uncompressed_size;
 	int ret;
 
 	DBG_BUGON(!c->alg);
@@ -40,7 +41,9 @@ int erofs_compress_destsize(struct erofs_compress *c,
 		return ret;
 
 	/* check if there is enough gains to compress */
-	if (*srcsize <= dstsize * c->compress_threshold / 100)
+	uncompressed_size = *srcsize;
+	if (roundup(ret, EROFS_BLKSIZ) >= uncompressed_size *
+	    c->compress_threshold / 100)
 		return -EAGAIN;
 	return ret;
 }
-- 
2.20.1

