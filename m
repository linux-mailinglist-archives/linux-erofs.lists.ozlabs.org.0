Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC526B8B2A
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Mar 2023 07:21:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PbNhl5NSrz3ccs
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Mar 2023 17:21:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PbNhY33vSz3c7d
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Mar 2023 17:21:32 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R381e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VdqrTCm_1678774886;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdqrTCm_1678774886)
          by smtp.aliyun-inc.com;
          Tue, 14 Mar 2023 14:21:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/4] erofs-utils: add per-sb block size
Date: Tue, 14 Mar 2023 14:21:19 +0800
Message-Id: <20230314062121.115020-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230314062121.115020-1-hsiangkao@linux.alibaba.com>
References: <20230314062121.115020-1-hsiangkao@linux.alibaba.com>
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

Will be used for subpage blocksize support.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v2: fold in runtime blkszbits modification from 4/4.
 include/erofs/internal.h | 1 +
 lib/super.c              | 7 +++----
 mkfs/main.c              | 1 +
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index d4ae3b8..a031915 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -88,6 +88,7 @@ struct erofs_sb_info {
 	u32 build_time_nsec;
 
 	unsigned char islotbits;
+	unsigned char blkszbits;
 
 	/* what we really care is nid, rather than ino.. */
 	erofs_nid_t root_nid;
diff --git a/lib/super.c b/lib/super.c
index 30aeb36..6b91011 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -70,7 +70,6 @@ int erofs_read_superblock(void)
 {
 	char data[EROFS_BLKSIZ];
 	struct erofs_super_block *dsb;
-	unsigned int blkszbits;
 	int ret;
 
 	ret = blk_read(0, data, 0, 1);
@@ -88,11 +87,11 @@ int erofs_read_superblock(void)
 
 	sbi.feature_compat = le32_to_cpu(dsb->feature_compat);
 
-	blkszbits = dsb->blkszbits;
+	sbi.blkszbits = dsb->blkszbits;
 	/* 9(512 bytes) + LOG_SECTORS_PER_BLOCK == LOG_BLOCK_SIZE */
-	if (blkszbits != LOG_BLOCK_SIZE) {
+	if (sbi.blkszbits != LOG_BLOCK_SIZE) {
 		erofs_err("blksize %d isn't supported on this platform",
-			  1 << blkszbits);
+			  1 << sbi.blkszbits);
 		return ret;
 	}
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 8e5a421..be3d805 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -641,6 +641,7 @@ static void erofs_mkfs_default_options(void)
 {
 	cfg.c_showprogress = true;
 	cfg.c_legacy_compress = false;
+	sbi.blkszbits = ilog2(PAGE_SIZE);
 	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_LZ4_0PADDING;
 	sbi.feature_compat = EROFS_FEATURE_COMPAT_SB_CHKSUM |
 			     EROFS_FEATURE_COMPAT_MTIME;
-- 
2.24.4

