Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99720719B04
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Jun 2023 13:34:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QX3vF70R8z3dsQ
	for <lists+linux-erofs@lfdr.de>; Thu,  1 Jun 2023 21:34:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QX3v60K1Bz3ch2
	for <linux-erofs@lists.ozlabs.org>; Thu,  1 Jun 2023 21:34:24 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vk5ycKy_1685619257;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vk5ycKy_1685619257)
          by smtp.aliyun-inc.com;
          Thu, 01 Jun 2023 19:34:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix compact format for large lcluster sizes
Date: Thu,  1 Jun 2023 19:34:16 +0800
Message-Id: <20230601113416.71774-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Use compact 4B format for large lcluster sizes if possible or fall
back to the non-compact format.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index ae0838c..2e1dfb3 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -684,9 +684,19 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 
 	if (logical_clusterbits < sbi.blkszbits || sbi.blkszbits < 12)
 		return -EINVAL;
-	if (logical_clusterbits > 14)	/* currently not supported */
+	if (logical_clusterbits > 14) {
+		erofs_err("compact format is unsupported for lcluster size %u",
+			  1 << logical_clusterbits);
 		return -EOPNOTSUPP;
-	if (logical_clusterbits == 12) {
+	}
+
+	if (inode->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) {
+		if (logical_clusterbits != 12) {
+			erofs_err("compact 2B is unsupported for lcluster size %u",
+				  1 << logical_clusterbits);
+			return -EINVAL;
+		}
+
 		compacted_4b_initial = (32 - mpos % 32) / 4;
 		if (compacted_4b_initial == 32 / 4)
 			compacted_4b_initial = 0;
@@ -847,8 +857,10 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 
 	/* initialize per-file compression setting */
 	inode->z_advise = 0;
-	if (!cfg.c_legacy_compress) {
-		inode->z_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
+	inode->z_logical_clusterbits = sbi.blkszbits;
+	if (!cfg.c_legacy_compress && inode->z_logical_clusterbits <= 14) {
+		if (inode->z_logical_clusterbits <= 12)
+			inode->z_advise |= Z_EROFS_ADVISE_COMPACTED_2B;
 		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION;
 	} else {
 		inode->datalayout = EROFS_INODE_FLAT_COMPRESSION_LEGACY;
@@ -875,7 +887,6 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	ctx.ccfg = &erofs_ccfg[inode->z_algorithmtype[0]];
 	inode->z_algorithmtype[0] = ctx.ccfg[0].algorithmtype;
 	inode->z_algorithmtype[1] = 0;
-	inode->z_logical_clusterbits = sbi.blkszbits;
 
 	inode->idata_size = 0;
 	inode->fragment_size = 0;
-- 
2.24.4

