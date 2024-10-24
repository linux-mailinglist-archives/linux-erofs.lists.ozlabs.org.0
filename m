Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EF69AE164
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Oct 2024 11:49:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1729763358;
	bh=c6HCchMQrhchaziLboXajbjRCehmsBv4y+T2v7L/JKA=;
	h=To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:Cc:From;
	b=fWjq91wzg32yrl/EMqbchWueXwwLUjUQUzlI1CCzXxrBMJ8fCWX4kJBF8CUbtwk99
	 20T/ocTYEpBM+vQCqFgfVB0q83hA3oYZPhYiepAoKcZ6nzYdH5c46aTD8w8ZeqboYg
	 R4bpERdPzftw/vnoWt/uEauY5O9CrVPDPk6U4JLVj5Ln9JjtiubAE55FhXqgmn6rL0
	 XOUnsjMG1B+dPzjMIJkwWoLGdBZwa+9IgHafeGNGi57BHdyEGJEkeGdXnvYJNhChz9
	 7mAXUAHeaP/hBYhwiHzRrli2WJbCOSpSTFJ10qQVqmtAVSRnzQrt8ozwJfU8QNbHed
	 3vRFyJcfgXeJw==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZ1My20zfz3bcP
	for <lists+linux-erofs@lfdr.de>; Thu, 24 Oct 2024 20:49:18 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=207.226.244.122
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729763357;
	cv=none; b=f2VesKIs4Wawzqp71OhM+wdaQvs83UNPwHiwgG+3fEDJI8N+lG6MrgzoC+y2G6h7zo0KTNpf5toPoOvWhcJG8w2sPzYFwoca2mu4JXhs+eEQW/RTmFvogd6eRAMwM/8YZeN+sc8OLeYAzZvZh5GeFgE+Vdpo+ky6YgXKiHbuif3SalssFHg4NqHf/GtjBiFgkvYuv7MbdtL6L/lhX+HZFPIY2kVTtJ9u8B0O7yHLFWIbCW7d7Cu7ieoFWUoZzC9RCgyr2v3ZQeTnbQG4GOxFg+ik+wfhlGaW4cEciaX5ChgH5vDhFmPw9EPbKRLeeWwYLCaZ9RcwsFLJlgTUPeaC8w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729763357; c=relaxed/relaxed;
	bh=c6HCchMQrhchaziLboXajbjRCehmsBv4y+T2v7L/JKA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W8SyqZig/yo/ytFY9MkS8d31ofFUj+uj6ZONt0TxqzGqAL6LZ+UGDrsoj8ORUEUKUOh02E0oqEJMzUD2KWZCrVVisj4kRE22Xde7JiJ/Nr+ntMm8WiPxV0q7qerAACkPJNx6UBgw/8U4vygGAJXKskcyk6+c/Bisx0IBI85/ZZRFbM54vO2Tj2IfnbonyM7B6eF+RCjtnxVeat+rotC1thGUnpsFOR+n2HZhNH4gQwCJVGdMO0a66o3/3NquCPnqmAh3T+r9LvHVpdrq6EgtszKwFvHRr/ScwkIdqese0ANUGykPeAk3utswInx5HQRSa0WVYsDxZG9uVS356YV3XQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass (client-ip=207.226.244.122; helo=outboundhk.mxmail.xiaomi.com; envelope-from=huangjianan@xiaomi.com; receiver=lists.ozlabs.org) smtp.mailfrom=xiaomi.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=xiaomi.com (client-ip=207.226.244.122; helo=outboundhk.mxmail.xiaomi.com; envelope-from=huangjianan@xiaomi.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 62 seconds by postgrey-1.37 at boromir; Thu, 24 Oct 2024 20:49:15 AEDT
Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.122])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XZ1Mv6QCKz305n
	for <linux-erofs@lists.ozlabs.org>; Thu, 24 Oct 2024 20:49:15 +1100 (AEDT)
X-CSE-ConnectionGUID: 8PtQMcH2T8qa6OR5cNYXEQ==
X-CSE-MsgGUID: lD5+u/tQTvGXP40UyK7k7A==
X-IronPort-AV: E=Sophos;i="6.11,228,1725292800"; 
   d="scan'208";a="125175919"
To: <linux-erofs@lists.ozlabs.org>
Subject: [PATCH] erofs-utils: avoid allocating large arrays on the stack
Date: Thu, 24 Oct 2024 17:48:06 +0800
Message-ID: <20241024094806.634534-1-huangjianan@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.237.8.11]
X-ClientProxiedBy: BJ-MBX17.mioffice.cn (10.237.8.137) To YZ-MBX05.mioffice.cn
 (10.237.88.125)
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_MSPIKE_H4,
	RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=disabled
	version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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
From: Jianan Huang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Jianan Huang <huangjianan@xiaomi.com>
Cc: zhaoyifan@sjtu.edu.cn
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The default pthread stack size of bionic is 1M. Use malloc to avoid
stack overflow.

Signed-off-by: Jianan Huang <huangjianan@xiaomi.com>
---
 lib/compress.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index cbd4620..47ba662 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -451,31 +451,37 @@ static int z_erofs_fill_inline_data(struct erofs_inode *inode, void *data,
 	return len;
 }
 
-static void tryrecompress_trailing(struct z_erofs_compress_sctx *ctx,
-				   struct erofs_compress *ec,
-				   void *in, unsigned int *insize,
-				   void *out, unsigned int *compressedsize)
+static int tryrecompress_trailing(struct z_erofs_compress_sctx *ctx,
+				  struct erofs_compress *ec,
+				  void *in, unsigned int *insize,
+				  void *out, unsigned int *compressedsize)
 {
 	struct erofs_sb_info *sbi = ctx->ictx->inode->sbi;
-	char tmp[Z_EROFS_PCLUSTER_MAX_SIZE];
+	char *tmp;
 	unsigned int count;
 	int ret = *compressedsize;
 
+	tmp = malloc(Z_EROFS_PCLUSTER_MAX_SIZE);
+	if (!tmp)
+		return -ENOMEM;
+
 	/* no need to recompress */
 	if (!(ret & (erofs_blksiz(sbi) - 1)))
-		return;
+		return 0;
 
 	count = *insize;
 	ret = erofs_compress_destsize(ec, in, &count, (void *)tmp,
 				      rounddown(ret, erofs_blksiz(sbi)));
 	if (ret <= 0 || ret + (*insize - count) >=
 			roundup(*compressedsize, erofs_blksiz(sbi)))
-		return;
+		return 0;
 
 	/* replace the original compressed data if any gain */
 	memcpy(out, tmp, ret);
 	*insize = count;
 	*compressedsize = ret;
+
+	return 0;
 }
 
 static bool z_erofs_fixup_deduped_fragment(struct z_erofs_compress_sctx *ctx,
@@ -631,9 +637,14 @@ frag_packing:
 			goto fix_dedupedfrag;
 		}
 
-		if (may_inline && len == e->length)
-			tryrecompress_trailing(ctx, h, ctx->queue + ctx->head,
-					&e->length, dst, &compressedsize);
+		if (may_inline && len == e->length) {
+			ret = tryrecompress_trailing(ctx, h,
+						     ctx->queue + ctx->head,
+						     &e->length, dst,
+						     &compressedsize);
+			if (ret)
+				return ret;
+		}
 
 		e->compressedblks = BLK_ROUND_UP(sbi, compressedsize);
 		DBG_BUGON(e->compressedblks * blksz >= e->length);
-- 
2.43.0

