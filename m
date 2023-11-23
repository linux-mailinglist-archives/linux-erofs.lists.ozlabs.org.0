Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4105A7F57C3
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Nov 2023 06:23:12 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SbRMy1gSrz3dBl
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Nov 2023 16:23:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SbRMn55m5z3bT8
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 Nov 2023 16:22:59 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vwxzk0d_1700716971;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vwxzk0d_1700716971)
          by smtp.aliyun-inc.com;
          Thu, 23 Nov 2023 13:22:53 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: mkfs: support compact indexes for smaller block sizes
Date: Thu, 23 Nov 2023 13:22:45 +0800
Message-Id: <20231123052245.868698-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231123052245.868698-1-hsiangkao@linux.alibaba.com>
References: <20231123052245.868698-1-hsiangkao@linux.alibaba.com>
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

This commit also adds mkfs support of compact indexes for smaller
block sizes (less than 4096).

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 47f1c1d..61328ed 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -627,19 +627,20 @@ static void *write_compacted_indexes(u8 *out,
 				     struct z_erofs_compressindex_vec *cv,
 				     erofs_blk_t *blkaddr_ret,
 				     unsigned int destsize,
-				     unsigned int logical_clusterbits,
+				     unsigned int lclusterbits,
 				     bool final, bool *dummy_head,
 				     bool update_blkaddr)
 {
-	unsigned int vcnt, encodebits, pos, i, cblks;
+	unsigned int vcnt, lobits, encodebits, pos, i, cblks;
 	erofs_blk_t blkaddr;
 
 	if (destsize == 4)
 		vcnt = 2;
-	else if (destsize == 2 && logical_clusterbits == 12)
+	else if (destsize == 2 && lclusterbits <= 12)
 		vcnt = 16;
 	else
 		return ERR_PTR(-EINVAL);
+	lobits = max(lclusterbits, ilog2(Z_EROFS_LI_D0_CBLKCNT) + 1U);
 	encodebits = (vcnt * destsize * 8 - 32) / vcnt;
 	blkaddr = *blkaddr_ret;
 
@@ -656,7 +657,7 @@ static void *write_compacted_indexes(u8 *out,
 				*dummy_head = false;
 			} else if (i + 1 == vcnt) {
 				offset = min_t(u16, cv[i].u.delta[1],
-						(1 << logical_clusterbits) - 1);
+						(1 << lobits) - 1);
 			} else {
 				offset = cv[i].u.delta[0];
 			}
@@ -676,7 +677,7 @@ static void *write_compacted_indexes(u8 *out,
 				DBG_BUGON(cv[i].u.blkaddr);
 			}
 		}
-		v = (cv[i].clustertype << logical_clusterbits) | offset;
+		v = (cv[i].clustertype << lobits) | offset;
 		rem = pos & 7;
 		ch = out[pos / 8] & ((1 << rem) - 1);
 		out[pos / 8] = (v << rem) | ch;
@@ -711,7 +712,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 	bool dummy_head;
 	bool big_pcluster = erofs_sb_has_big_pcluster(sbi);
 
-	if (logical_clusterbits < sbi->blkszbits || sbi->blkszbits < 12)
+	if (logical_clusterbits < sbi->blkszbits)
 		return -EINVAL;
 	if (logical_clusterbits > 14) {
 		erofs_err("compact format is unsupported for lcluster size %u",
@@ -720,7 +721,7 @@ int z_erofs_convert_to_compacted_format(struct erofs_inode *inode,
 	}
 
 	if (inode->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) {
-		if (logical_clusterbits != 12) {
+		if (logical_clusterbits > 12) {
 			erofs_err("compact 2B is unsupported for lcluster size %u",
 				  1 << logical_clusterbits);
 			return -EINVAL;
-- 
2.39.3

