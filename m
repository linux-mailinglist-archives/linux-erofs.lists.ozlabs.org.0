Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E812E835F
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Jan 2021 10:17:21 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4D6fYN5RYDzDqKW
	for <lists+linux-erofs@lfdr.de>; Fri,  1 Jan 2021 20:17:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=outlook.com (client-ip=40.92.253.106;
 helo=apc01-sg2-obe.outbound.protection.outlook.com;
 envelope-from=huww98@outlook.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256
 header.s=selector1 header.b=mHEjSVWR; 
 dkim-atps=neutral
Received: from APC01-SG2-obe.outbound.protection.outlook.com
 (mail-oln040092253106.outbound.protection.outlook.com [40.92.253.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4D6fY85xqwzDqK1
 for <linux-erofs@lists.ozlabs.org>; Fri,  1 Jan 2021 20:16:59 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K8OOHFAEPGvyHD0wx4mSE9FybJU8ufKvWnVWoASJEVAE1K/vTEMrOrzS9Te8MitIaaiPXjw1jZrIDPiWTJGvhd5YAmkAXMVcIRxuSnMfBZ2UOXqR52Wcg/Xx4Sbps+2QPt65ePVMUXrqVSlN4vFfRepyFqEoN519TQrxWIBv7bOi1eQcW05UMy1TANpqaWIpQq37YYcFOFeymAxYhn7J/jhYgq8NzRys0HANxaU4o2pedyEirg3N39+NNyZrEUvAN3mXO1NGxLrp5T7+mjqEN9rIdIzB68lnMbyhuOa09B/qQ2XB6Jm+YRyN1Z8AMU3zeTofqjYj85Wk30RmQM2Saw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YRUBMwbkhmEACY3k6vN2UnExLvUgu78KNqXvGPMz+4=;
 b=fUynDaFYWUT+V3M6FglK4wb/C+XeGznn3R7ezyf7ZkT8rlTHlBWQ0B+M3eW0svJG5hvEJl89ue6Z1d3CT1Hfb8oQx8BlG9fqdrwmWNVOIZTkPffkemJU91Mi+31w32PMaFNExz0u83OioRxcSJnPyeSeh5jm73XFRdZn8MhW5IFbSze4pqKTbhFTKgVKKjnnVWBPZG1HL76q+aEX1+L0WFGLW6pHXtHWxVutgAhh3kVCuxByy6+XFBz1rkRYgG3CjeI+EKmXWd+EKIXRxwjdpmmqQ4oj3pXWfcxoy+7CFO21x+OhorxiHEsQnh331RidGzpFy4A/xhfNp3/RxYgNmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YRUBMwbkhmEACY3k6vN2UnExLvUgu78KNqXvGPMz+4=;
 b=mHEjSVWRvZfU3oGxH+UEmOnNPmnq9g0rHiSfMPDQZD/cUEnMgOXXb2kKogWQiyygeOCoMi7gzYeY8Fxao8EtyJfQ9snC3ertKzoLk0PA7v3yyrZl4aT1iUcPmPk1Gq5Y4mzd1GjUoIYQb+Ms6zoE0Al4TpbLvgJYGPwcO7YAnyVWY7qUV67VMrKp79e2CZ62K1Q/EreBvnkEC/Jax4LW4f+M6HcW/ieOmTavUVxlvVWauzCMNTLncZaW0dXEqPHI5HoFHLqhbuxztESOqRbhww45mQye/ZcpijJ7ajOIDMUizQ8LorTyK4ih6CARk4zKeJIuzyix7WnbnJ2KiauT+A==
Received: from HK2APC01FT033.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::4e) by
 HK2APC01HT121.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::409)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.20; Fri, 1 Jan
 2021 09:16:47 +0000
Received: from ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM (2a01:111:e400:7ebc::4c)
 by HK2APC01FT033.mail.protection.outlook.com
 (2a01:111:e400:7ebc::190) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27 via Frontend
 Transport; Fri, 1 Jan 2021 09:16:47 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:41AB3237764ABD9D218C9FE117CA55F1AD755A17FA0EA24A2E79DD465CA21DF4;
 UpperCasedChecksum:D8A2C7C23D91BC82CA22E6780687DBA5E8C3258ED9050A6A496B0A8C071CB5E4;
 SizeAsReceived:7520; Count:45
Received: from ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM
 ([fe80::20b2:7b23:9b1e:df3e]) by ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM
 ([fe80::20b2:7b23:9b1e:df3e%7]) with mapi id 15.20.3721.020; Fri, 1 Jan 2021
 09:16:47 +0000
From: =?UTF-8?q?=E8=83=A1=E7=8E=AE=E6=96=87?= <huww98@outlook.com>
To: Li Guifu <bluce.liguifu@huawei.com>, Miao Xie <miaoxie@huawei.com>,
 Fang Wei <fangwei1@huawei.com>
Subject: [PATCH 1/2] erofs-utils: optimize mkfs to O(N), N = #files
Date: Fri,  1 Jan 2021 17:11:57 +0800
Message-ID: <ME3P282MB1938A1CE1C6AF60BE7F955F7C0D50@ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [QIzxHQb3zDw+JmvDiwSQATnkDOwNOUeO]
X-ClientProxiedBy: BY5PR16CA0012.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::25) To ME3P282MB1938.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:a2::12)
X-Microsoft-Original-Message-ID: <20210101091158.13896-1-huww98@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from DESKTOP-N4CECTO.scut-smil.cn (125.216.246.30) by
 BY5PR16CA0012.namprd16.prod.outlook.com (2603:10b6:a03:1a0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19 via Frontend
 Transport; Fri, 1 Jan 2021 09:16:43 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 45
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 4f66d900-0c13-4678-33c7-08d8ae35f738
X-MS-Exchange-SLBlob-MailProps: 6H6McBavlAitrUe8DDNNaoFgbjwJL2LpJZt8/H1BY+PW6MhqmYMB6NGjXOV1qQRzbbpr1mDe34WjnLVD3HkbShFgWLov5yBBLyi2XU7BlNub/SzDhla4olyeL89OwGLa44uRGqrIJD0t0exW0ZBKrycjz9RRsUdA3kdGXpUQl2YnWzi4ILJk6btQ61w0WK42Cv1AjPuXXVUN/KoPWk77AZ3tUIHh6NKkuGsrTqTkL9hQpJ5p/GCAp9KRje8hM65natTv8xJqbE7S6NGZT0eobBfTfGsQ3bD6WLv81KWdUzr4IqWeVJcIX6mz7H7KV9jQmIlL1oSbfH6qlqSRvQu0azwKh2pZcIYxm2RxB36HbHA/+xtkY2Kpk7VUECTm3aXBrlts+zgmYMyBqi1Z7ElEgDpozLKJL94S3F/vR6wpFj0DPAm6pHil02DvcDF8SrnFQ7GVwTzVfEYMEERktMAVGgawtm2JnG7jEgl306olzF5ctlHVrwQPUrpTVUE64gEwRKXRh8vbdR3p+mE+dtGsMmNFkDnflkGIt2uug6kbimTXr28CeYZC41y2UjCZSALjPVfNoLXwONSsrNtNMWN/Qec0Xsg/mlx4X6dGtrDoNE4fLSWhfM+UXqwFkJS2QC/Z3SpKQl0y+tukKF4XWTiaiu85EPPETj9t89e9GtZTfwW7Nd8pxJxH9SeGSw4/GaNMyQUWQQdC9mbuVbiUULCCaQBiBYhHRRHWn1GAk/0B2VOaS6WSKWabiFq8mwKiXHo8Sh6fD0ZHiHo=
X-MS-TrafficTypeDiagnostic: HK2APC01HT121:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bv0WtF8MEu6CimvIRp1VnamjHoHI+b2qoxy/SOwxchwWbALDy3O0h+e+JQaLnRF5/7eXtegUh259vrahwoXc7GauR/AwzQbEmFgOX1hkrtxgPoVL1QuJhIHTkbyTh/HZZjotxNrxgR5iU00RM0KrfLKfSc4lQVGAavESGkRtJqLuWBRGTqtXCww5qqiiJ7ggryE5Sjy7bF5Ds/6w1kShglo4STQHSGKmuqwWYBdpYUcvdpavlUlxCNuUqzA1eeYQ
X-MS-Exchange-AntiSpam-MessageData: 9U/fzpTyOQlZrZG2cpO2AJFX48Q3Ce676KmLkrDNkuf/ngpm7+9R0O2ivatA5MXaNjSC140MWgVo5qiSEI2RoWhtaWHO5lbT0FGkDXVHMKrPUjkc6FB85EEOyr640RqXNILQKxUYN7p8FcXr3VcoNA==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2021 09:16:47.5925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f66d900-0c13-4678-33c7-08d8ae35f738
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT033.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT121
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
Cc: linux-erofs@lists.ozlabs.org, Gao Xiang <gaoxiang25@huawei.com>,
 =?UTF-8?q?=E8=83=A1=E7=8E=AE=E6=96=87?= <huww98@outlook.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

When using EROFS to pack our dataset which consists of millions of
files, mkfs.erofs is very slow compared with mksquashfs.

The bottleneck is `erofs_balloc` and `erofs_mapbh` function, which
iterate over all previously allocated buffer blocks, making the
complexity of the algrithm O(N^2) where N is the number of files.

With this patch:

* global `last_mapped_block` is mantained to avoid full scan in
  `erofs_mapbh` function.

* global `non_full_buffer_blocks` mantains a list of buffer block for
  each type and each possible remaining bytes in the block. Then it is
  used to identify the most suitable blocks in future `erofs_balloc`,
  avoiding full scan.

Some new data structure is allocated in this patch, more RAM usage is
expected, but not much. When I test it with ImageNet dataset (1.33M
files), 7GiB RAM is consumed, and it takes about 4 hours. Most time is
spent on IO.

Signed-off-by: Hu Weiwen <huww98@outlook.com>
---
 lib/cache.c | 102 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 89 insertions(+), 13 deletions(-)

diff --git a/lib/cache.c b/lib/cache.c
index 0d5c4a5..3412a0b 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -18,6 +18,18 @@ static struct erofs_buffer_block blkh = {
 };
 static erofs_blk_t tail_blkaddr;
 
+/**
+ * Some buffers are not full, we can reuse it to store more data
+ * 2 for DATA, META
+ * EROFS_BLKSIZ for each possible remaining bytes in the last block
+ **/
+static struct erofs_buffer_block_record {
+	struct list_head list;
+	struct erofs_buffer_block *bb;
+} non_full_buffer_blocks[2][EROFS_BLKSIZ];
+
+static struct erofs_buffer_block *last_mapped_block = &blkh;
+
 static bool erofs_bh_flush_drop_directly(struct erofs_buffer_head *bh)
 {
 	return erofs_bh_flush_generic_end(bh);
@@ -62,6 +74,12 @@ struct erofs_bhops erofs_buf_write_bhops = {
 /* return buffer_head of erofs super block (with size 0) */
 struct erofs_buffer_head *erofs_buffer_init(void)
 {
+	for (int i = 0; i < 2; i++) {
+		for (int j = 0; j < EROFS_BLKSIZ; j++) {
+			init_list_head(&non_full_buffer_blocks[i][j].list);
+		}
+	}
+
 	struct erofs_buffer_head *bh = erofs_balloc(META, 0, 0, 0);
 
 	if (IS_ERR(bh))
@@ -131,7 +149,8 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 {
 	struct erofs_buffer_block *cur, *bb;
 	struct erofs_buffer_head *bh;
-	unsigned int alignsize, used0, usedmax;
+	unsigned int alignsize, used0, usedmax, total_size;
+	struct erofs_buffer_block_record * reusing = NULL;
 
 	int ret = get_alignsize(type, &type);
 
@@ -143,7 +162,38 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 	usedmax = 0;
 	bb = NULL;
 
-	list_for_each_entry(cur, &blkh.list, list) {
+	erofs_dbg("balloc size=%lu alignsize=%u used0=%u", size, alignsize, used0);
+	if (used0 == 0 || alignsize == EROFS_BLKSIZ) {
+		goto alloc;
+	}
+	total_size = size + required_ext + inline_ext;
+	if (total_size < EROFS_BLKSIZ) {
+		// Try find a most fit block.
+		DBG_BUGON(type < 0 || type > 1);
+		struct erofs_buffer_block_record *non_fulls = non_full_buffer_blocks[type];
+		for (struct erofs_buffer_block_record *r = non_fulls + round_up(total_size, alignsize);
+				r < non_fulls + EROFS_BLKSIZ; r++) {
+			if (!list_empty(&r->list)) {
+				struct erofs_buffer_block_record *reuse_candidate =
+						list_first_entry(&r->list, struct erofs_buffer_block_record, list);
+				ret = __erofs_battach(reuse_candidate->bb, NULL, size, alignsize,
+						required_ext + inline_ext, true);
+				if (ret >= 0) {
+					reusing = reuse_candidate;
+					bb = reuse_candidate->bb;
+					usedmax = (ret + required_ext) % EROFS_BLKSIZ + inline_ext;
+				}
+				break;
+			}
+		}
+	}
+
+	/* Try reuse last ones, which are not mapped and can be extended */
+	cur = last_mapped_block;
+	if (cur == &blkh) {
+		cur = list_next_entry(cur, list);
+	}
+	for (; cur != &blkh; cur = list_next_entry(cur, list)) {
 		unsigned int used_before, used;
 
 		used_before = cur->buffers.off % EROFS_BLKSIZ;
@@ -175,22 +225,32 @@ struct erofs_buffer_head *erofs_balloc(int type, erofs_off_t size,
 			continue;
 
 		if (usedmax < used) {
+			reusing = NULL;
 			bb = cur;
 			usedmax = used;
 		}
 	}
 
 	if (bb) {
+		erofs_dbg("reusing buffer. usedmax=%u", usedmax);
 		bh = malloc(sizeof(struct erofs_buffer_head));
 		if (!bh)
 			return ERR_PTR(-ENOMEM);
+		if (reusing) {
+			list_del(&reusing->list);
+			free(reusing);
+		}
 		goto found;
 	}
 
+alloc:
 	/* allocate a new buffer block */
-	if (used0 > EROFS_BLKSIZ)
+	if (used0 > EROFS_BLKSIZ) {
+		erofs_dbg("used0 > EROFS_BLKSIZ");
 		return ERR_PTR(-ENOSPC);
+	}
 
+	erofs_dbg("new buffer block");
 	bb = malloc(sizeof(struct erofs_buffer_block));
 	if (!bb)
 		return ERR_PTR(-ENOMEM);
@@ -211,6 +271,16 @@ found:
 			      required_ext + inline_ext, false);
 	if (ret < 0)
 		return ERR_PTR(ret);
+	if (ret != 0) {
+		/* This buffer is not full yet, we may reuse it */
+		reusing = malloc(sizeof(struct erofs_buffer_block_record));
+		if (!reusing) {
+			return ERR_PTR(-ENOMEM);
+		}
+		reusing->bb = bb;
+		list_add_tail(&reusing->list,
+				&non_full_buffer_blocks[type][EROFS_BLKSIZ - ret - inline_ext].list);
+	}
 	return bh;
 }
 
@@ -247,8 +317,10 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
 {
 	erofs_blk_t blkaddr;
 
-	if (bb->blkaddr == NULL_ADDR)
+	if (bb->blkaddr == NULL_ADDR) {
 		bb->blkaddr = tail_blkaddr;
+		last_mapped_block = bb;
+	}
 
 	blkaddr = bb->blkaddr + BLK_ROUND_UP(bb->buffers.off);
 	if (blkaddr > tail_blkaddr)
@@ -259,15 +331,16 @@ static erofs_blk_t __erofs_mapbh(struct erofs_buffer_block *bb)
 
 erofs_blk_t erofs_mapbh(struct erofs_buffer_block *bb, bool end)
 {
-	struct erofs_buffer_block *t, *nt;
-
-	if (!bb || bb->blkaddr == NULL_ADDR) {
-		list_for_each_entry_safe(t, nt, &blkh.list, list) {
-			if (!end && (t == bb || nt == &blkh))
-				break;
-			(void)__erofs_mapbh(t);
-			if (end && t == bb)
-				break;
+	DBG_BUGON(!end);
+	struct erofs_buffer_block *t = last_mapped_block;
+	while (1) {
+		t = list_next_entry(t, list);
+		if (t == &blkh) {
+			break;
+		}
+		(void)__erofs_mapbh(t);
+		if (t == bb) {
+			break;
 		}
 	}
 	return tail_blkaddr;
@@ -334,6 +407,9 @@ void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
 	if (!list_empty(&bb->buffers.list))
 		return;
 
+	if (bb == last_mapped_block) {
+		last_mapped_block = list_prev_entry(bb, list);
+	}
 	list_del(&bb->list);
 	free(bb);
 
-- 
2.30.0

