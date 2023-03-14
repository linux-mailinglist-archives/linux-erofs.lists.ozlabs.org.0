Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11FF76B890B
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Mar 2023 04:38:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PbK4W4p1cz3cHm
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Mar 2023 14:38:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PbK4L6hY0z3bVP
	for <linux-erofs@lists.ozlabs.org>; Tue, 14 Mar 2023 14:38:26 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VdqTXgw_1678765101;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VdqTXgw_1678765101)
          by smtp.aliyun-inc.com;
          Tue, 14 Mar 2023 11:38:22 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/4] erofs-utils: add per-sb block size
Date: Tue, 14 Mar 2023 11:38:12 +0800
Message-Id: <20230314033814.57938-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230314033814.57938-1-hsiangkao@linux.alibaba.com>
References: <20230314033814.57938-1-hsiangkao@linux.alibaba.com>
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
 include/erofs/internal.h | 1 +
 mkfs/main.c              | 1 +
 2 files changed, 2 insertions(+)

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

