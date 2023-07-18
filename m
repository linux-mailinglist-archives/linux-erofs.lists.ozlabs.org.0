Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD5975731A
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jul 2023 07:21:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R4nNz1JXGz30XM
	for <lists+linux-erofs@lfdr.de>; Tue, 18 Jul 2023 15:21:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R4nNl4Wv3z305R
	for <linux-erofs@lists.ozlabs.org>; Tue, 18 Jul 2023 15:21:11 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VngOrSR_1689657664;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VngOrSR_1689657664)
          by smtp.aliyun-inc.com;
          Tue, 18 Jul 2023 13:21:05 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/4] erofs-utils: inline vle_compressmeta_capacity()
Date: Tue, 18 Jul 2023 13:21:00 +0800
Message-Id: <20230718052101.124039-4-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230718052101.124039-1-jefflexu@linux.alibaba.com>
References: <20230718052101.124039-1-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 lib/compress.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 6fb63cb..a871322 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -49,14 +49,6 @@ struct z_erofs_vle_compress_ctx {
 
 #define Z_EROFS_LEGACY_MAP_HEADER_SIZE	Z_EROFS_FULL_INDEX_ALIGN(0)
 
-static unsigned int vle_compressmeta_capacity(erofs_off_t filesize)
-{
-	const unsigned int indexsize = BLK_ROUND_UP(filesize) *
-		sizeof(struct z_erofs_lcluster_index);
-
-	return Z_EROFS_LEGACY_MAP_HEADER_SIZE + indexsize;
-}
-
 static void z_erofs_write_indexes_final(struct z_erofs_vle_compress_ctx *ctx)
 {
 	const unsigned int type = Z_EROFS_LCLUSTER_TYPE_PLAIN;
@@ -843,7 +835,9 @@ int erofs_write_compressed_file(struct erofs_inode *inode, int fd)
 	erofs_blk_t blkaddr, compressed_blocks;
 	unsigned int legacymetasize;
 	int ret;
-	u8 *compressmeta = malloc(vle_compressmeta_capacity(inode->i_size));
+	u8 *compressmeta = malloc(BLK_ROUND_UP(inode->i_size) *
+				  sizeof(struct z_erofs_lcluster_index) +
+				  Z_EROFS_LEGACY_MAP_HEADER_SIZE);
 
 	if (!compressmeta)
 		return -ENOMEM;
-- 
2.19.1.6.gb485710b

