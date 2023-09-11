Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A12479A451
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Sep 2023 09:18:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RkdNx2ypcz3bhy
	for <lists+linux-erofs@lfdr.de>; Mon, 11 Sep 2023 17:18:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RkdNs0zg0z2y1c
	for <linux-erofs@lists.ozlabs.org>; Mon, 11 Sep 2023 17:18:35 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vrn4Sbp_1694416700;
Received: from e69b19392.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vrn4Sbp_1694416700)
          by smtp.aliyun-inc.com;
          Mon, 11 Sep 2023 15:18:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: add ^{inline_data,ztailpacking,dedupe} options
Date: Mon, 11 Sep 2023 15:18:19 +0800
Message-Id: <20230911071819.3714867-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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

Later, some preset configurations will be added, which could enable
some of these features by default.

Let's add a way to turn each individual off too.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/config.h |  2 +-
 lib/inode.c            |  2 +-
 mkfs/main.c            | 13 ++++++++++---
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/erofs/config.h b/include/erofs/config.h
index dea5d74..e342722 100644
--- a/include/erofs/config.h
+++ b/include/erofs/config.h
@@ -45,7 +45,7 @@ struct erofs_configure {
 #endif
 	char c_timeinherit;
 	char c_chunkbits;
-	bool c_noinline_data;
+	bool c_inline_data;
 	bool c_ztailpacking;
 	bool c_fragments;
 	bool c_all_fragments;
diff --git a/lib/inode.c b/lib/inode.c
index d393602..3976c47 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -657,7 +657,7 @@ static int erofs_prepare_inode_buffer(struct erofs_inode *inode)
 		goto noinline;
 
 	if (!is_inode_layout_compression(inode)) {
-		if (cfg.c_noinline_data && S_ISREG(inode->i_mode)) {
+		if (!cfg.c_inline_data && S_ISREG(inode->i_mode)) {
 			inode->datalayout = EROFS_INODE_FLAT_PLAIN;
 			goto noinline;
 		}
diff --git a/mkfs/main.c b/mkfs/main.c
index 8f34e57..ad0e320 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -214,7 +214,13 @@ static int parse_extended_opts(const char *opts)
 		if (MATCH_EXTENTED_OPT("noinline_data", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			cfg.c_noinline_data = true;
+			cfg.c_inline_data = false;
+		}
+
+		if (MATCH_EXTENTED_OPT("inline_data", token, keylen)) {
+			if (vallen)
+				return -EINVAL;
+			cfg.c_inline_data = !clear;
 		}
 
 		if (MATCH_EXTENTED_OPT("force-inode-blockmap", token, keylen)) {
@@ -232,7 +238,7 @@ static int parse_extended_opts(const char *opts)
 		if (MATCH_EXTENTED_OPT("ztailpacking", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			cfg.c_ztailpacking = true;
+			cfg.c_ztailpacking = !clear;
 		}
 
 		if (MATCH_EXTENTED_OPT("all-fragments", token, keylen)) {
@@ -260,7 +266,7 @@ handle_fragment:
 		if (MATCH_EXTENTED_OPT("dedupe", token, keylen)) {
 			if (vallen)
 				return -EINVAL;
-			cfg.c_dedupe = true;
+			cfg.c_dedupe = !clear;
 		}
 
 		if (MATCH_EXTENTED_OPT("xattr-name-filter", token, keylen)) {
@@ -773,6 +779,7 @@ static void erofs_mkfs_default_options(void)
 {
 	cfg.c_showprogress = true;
 	cfg.c_legacy_compress = false;
+	cfg.c_inline_data = true;
 	cfg.c_xattr_name_filter = true;
 	sbi.blkszbits = ilog2(min_t(u32, getpagesize(), EROFS_MAX_BLOCK_SIZE));
 	sbi.feature_incompat = EROFS_FEATURE_INCOMPAT_ZERO_PADDING;
-- 
2.39.3

