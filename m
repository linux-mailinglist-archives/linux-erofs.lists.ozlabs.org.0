Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A11D36F4C3
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Apr 2021 06:04:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FWdz617clz3018
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Apr 2021 14:04:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jgfzCPXm;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=jgfzCPXm; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FWdz4107Tz302L
 for <linux-erofs@lists.ozlabs.org>; Fri, 30 Apr 2021 14:04:00 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7428561423;
 Fri, 30 Apr 2021 04:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1619755437;
 bh=tvvPm0pRh9NtWMjZ+pz/HWek43RqwSsSGaGzLS0CzPg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jgfzCPXm1Zgr2f2I4QDVmn1Aww3HuXf1fQKPVQiEC8Or0GAs7HEMDrCWWApwsaZEc
 cBYYmzOjBdBOuJR/42c13H/fhT/fAFs5pzBwVnZC9Go2hKlwhqhLGr2QZpleq1fGWr
 9MaNP6+ennRM8aq7jALa18Y8UbHZa6ss00okjrzABZMGQVydAarOXWjp0rGfTXD64K
 38ph1fotAzWdfcgc2Ib47UP8hpAGCmuCclStke7VXyBGoBuDLfwFajRIT66fBqFPz1
 cNBfzEWpRIggI8yNNWi6Ij712jKJeBSUAgobLL+3db2KwE8544t3/vVz1F5KwkSxqz
 y4lYuz2G6mHQw==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org,
	Li Guifu <bluce.liguifu@huawei.com>
Subject: [PATCH v4 4/5] erofs-utils: zero out garbage trailing data for
 non-0padding cases
Date: Fri, 30 Apr 2021 12:03:44 +0800
Message-Id: <20210430040345.17120-4-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210430040345.17120-1-xiang@kernel.org>
References: <20210430040345.17120-1-xiang@kernel.org>
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

When "-E legacy-compress" is used, lz4 0padding feature will be
disabled by default in order to support old kernels (< Linux v5.3).

In that case, the current mkfs leaves previous garbage data after
valid compressed data if the length becomes shorter. This doesn't
matter for kernels >= v5.0 since LZ4_decompress_safe_partial() is used.

However, for staging erofs v4.19, it used an in-house customized
lz4 implemention due to LZ4_decompress_safe_partial() didn't work
as expected at that time, yet it doesn't allow trailing random
data in practice or decompression failure could happen.

I don't think it really matters since "obsoleted_mkfs" works perfectly
for such old staging versions (v4.19). Anyway, trailing garbage data
sounds unreasonable, so let's zero out it now.

Fixes: 66653ef10a7f ("erofs-utils: introduce compression for regular files")
Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 lib/compress.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index b8bb89e7ae9d..deef6a2c8ae3 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -189,18 +189,22 @@ nocompression:
 			ctx->compressedblks = 1;
 			raw = true;
 		} else {
-			const unsigned int used = ret & (EROFS_BLKSIZ - 1);
-			const unsigned int margin =
-				erofs_sb_has_lz4_0padding() && used ?
-					EROFS_BLKSIZ - used : 0;
+			const unsigned int tailused = ret & (EROFS_BLKSIZ - 1);
+			const unsigned int padding =
+				erofs_sb_has_lz4_0padding() && tailused ?
+					EROFS_BLKSIZ - tailused : 0;
 
 			ctx->compressedblks = DIV_ROUND_UP(ret, EROFS_BLKSIZ);
+			/* zero out garbage trailing data for non-0padding */
+			if (!erofs_sb_has_lz4_0padding())
+				memset(dst + ret, 0,
+				       roundup(ret, EROFS_BLKSIZ) - ret);
 
 			/* write compressed data */
 			erofs_dbg("Writing %u compressed data to %u of %u blocks",
 				  count, ctx->blkaddr, ctx->compressedblks);
 
-			ret = blk_write(dst - margin, ctx->blkaddr,
+			ret = blk_write(dst - padding, ctx->blkaddr,
 					ctx->compressedblks);
 			if (ret)
 				return ret;
-- 
2.20.1

