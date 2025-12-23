Return-Path: <linux-erofs+bounces-1567-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A1DCD8BD9
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Dec 2025 11:12:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4db9mg3gKJz2yF1;
	Tue, 23 Dec 2025 21:12:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1766484755;
	cv=none; b=lWSrBu8Udva4bsofQ5YbYcsjXe2fleC7uVJziHcdH+25ZFL/rzYV8WbLUYTnA0fQJQTm880mFa/JGcBbjGFoKv/C0/1PhTC5xjG0fycprNKQUjuoXFy01tk/2wz1mRb8gIaOs4zdfT+rfx1jzWOCe0aJ0CSlzcnjsGi7Fw2XjF/2J15UVJeowkPwKaW0I7OiuCZy/P5KSpSR2aGoQRsYzGAKSTurq1BqCR4np4dkeG9R6hy5hSAlISSKdMtr/t1eatHXhy+YhCQxtmnZTsy4SnFPr1lMEfHd2CUAeKT2/9IZNcI14dQcDaqz6jStYGUQ6j0Iff2mmhUt+9TjIAMZkA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1766484755; c=relaxed/relaxed;
	bh=dUe2siZ8O2PorqO97QPnQPbjFuPy385JoHe37pveCeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Iw+tAk9l3W7MIw5HKGopjivxDqCsvCvFp0UGseWxZ5aPkK5Djfdp7yL+OpUr9lD5n/Hsin4kkhnCvdZiZRLYDefRpw3zXluz6Ea3Zy4RCZdTLb86xPa6xDeFFRspd7xLdeJWCQ9xVMIqSx09yy2B+2jl51KD5Q5+06ZLRbJ3a+7r7oKMXhzwJS1HBCk3+WoGHdsqwFWcoWJAq2/id59zRfl7AW3/KvA5gCuGt94HRR4K1BlKmoEsgexAbCOlchMRXnQMbInEtLetJ0WUHvVxusrPsIVJwUDNMJTXvmTHfABMiZn9h6qcvx9IfqWGy7VTxCZXVLUendayXj6lpsOxRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ym44sdry; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Ym44sdry;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4db9md3zMjz2xQK
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Dec 2025 21:12:32 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1766484746; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=dUe2siZ8O2PorqO97QPnQPbjFuPy385JoHe37pveCeY=;
	b=Ym44sdrygtRie5I2bFLcF9N0d7CZo6jFaJCJyzOa+880/psGYPrHmWGsV4y13owyY09GiKXMxKw8QG6DaB5BeDdItYieuXvj1h3E1jL2F5lS3GF509rg8RTDI5UO+8YuyN4faM6re74T0cbP7oWvynH83xtiiiAcS4qmOaNg1ZM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WvXP6a2_1766484741 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Dec 2025 18:12:25 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mkfs: forget all dirty buffers on failure
Date: Tue, 23 Dec 2025 18:12:21 +0800
Message-ID: <20251223101221.3995330-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

When mkfs fails (e.g., due to network or I/O errors), dirty buffers may
still be queued for write:
```
<E> erofs: s3erofs_request_perform() Line[605] curl_easy_perform() failed: SSL peer certificate or SSH remote key was not OK
<E> erofs: s3erofs_build_trees() Line[1076] failed to get next object: [Error 5] Input/output error
<E> erofs: main() Line[2029]    Could not format the device : [Error 5] Input/output error

mkfs.erofs: cache.c:536: void erofs_buffer_exit(struct erofs_bufmgr *): Assertion `!(!list_empty(&bmgr->blkh.list))' failed.
```

Fixes: a482ef7d1fdf ("erofs-utils: mkfs: fix memleak in error exit path")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/cache.c | 17 +++++++++++++----
 mkfs/main.c |  2 +-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/lib/cache.c b/lib/cache.c
index 24449f221317..a87575ad74d1 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -448,8 +448,8 @@ static void erofs_bfree(struct erofs_buffer_block *bb)
 	free(bb);
 }
 
-int erofs_bflush(struct erofs_bufmgr *bmgr,
-		 struct erofs_buffer_block *bb)
+static int __erofs_bflush(struct erofs_bufmgr *bmgr,
+			  struct erofs_buffer_block *bb, bool forget)
 {
 	struct erofs_sb_info *sbi = bmgr->sbi;
 	const unsigned int blksiz = erofs_blksiz(sbi);
@@ -470,8 +470,11 @@ int erofs_bflush(struct erofs_bufmgr *bmgr,
 
 		list_for_each_entry_safe(bh, nbh, &p->buffers.list, list) {
 			if (bh->op == &erofs_skip_write_bhops) {
-				skip = true;
-				continue;
+				if (!forget) {
+					skip = true;
+					continue;
+				}
+				bh->op = &erofs_drop_directly_bhops;
 			}
 
 			/* flush and remove bh */
@@ -501,6 +504,11 @@ int erofs_bflush(struct erofs_bufmgr *bmgr,
 	return 0;
 }
 
+int erofs_bflush(struct erofs_bufmgr *bmgr, struct erofs_buffer_block *bb)
+{
+	return __erofs_bflush(bmgr, bb, false);
+}
+
 void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke)
 {
 	struct erofs_buffer_block *const bb = bh->block;
@@ -533,6 +541,7 @@ erofs_blk_t erofs_total_metablocks(struct erofs_bufmgr *bmgr)
 
 void erofs_buffer_exit(struct erofs_bufmgr *bmgr)
 {
+	DBG_BUGON(__erofs_bflush(bmgr, NULL, true));
 	DBG_BUGON(!list_empty(&bmgr->blkh.list));
 	free(bmgr);
 }
diff --git a/mkfs/main.c b/mkfs/main.c
index 22201d35dedf..aaa0300bca1b 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1997,7 +1997,6 @@ exit:
 	blklst = erofs_blocklist_close();
 	if (blklst)
 		fclose(blklst);
-	erofs_dev_close(&g_sbi);
 	erofs_cleanup_compress_hints();
 	erofs_cleanup_exclude_rules();
 	if (cfg.c_chunkbits || source_mode == EROFS_MKFS_SOURCE_REBUILD)
@@ -2033,6 +2032,7 @@ exit:
 		erofs_mkfs_showsummaries();
 	}
 	erofs_put_super(&g_sbi);
+	erofs_dev_close(&g_sbi);
 	liberofs_global_exit();
 	return err;
 }
-- 
2.43.5


