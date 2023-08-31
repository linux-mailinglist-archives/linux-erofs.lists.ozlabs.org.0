Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4715278EA39
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 12:30:32 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rby9L1fdzz30fF
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 20:30:30 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rby9G75Rnz2yVh
	for <linux-erofs@lists.ozlabs.org>; Thu, 31 Aug 2023 20:30:26 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vqy1Gq9_1693477820;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vqy1Gq9_1693477820)
          by smtp.aliyun-inc.com;
          Thu, 31 Aug 2023 18:30:21 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: dump: support dumping xattr filter feature bit
Date: Thu, 31 Aug 2023 18:30:20 +0800
Message-Id: <20230831103020.120683-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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

Add support for dumping xattr filter feature bit.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 dump/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/dump/main.c b/dump/main.c
index 7980f78..5425b7b 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -91,6 +91,7 @@ struct erofsdump_feature {
 static struct erofsdump_feature feature_lists[] = {
 	{ true, EROFS_FEATURE_COMPAT_SB_CHKSUM, "sb_csum" },
 	{ true, EROFS_FEATURE_COMPAT_MTIME, "mtime" },
+	{ true, EROFS_FEATURE_COMPAT_XATTR_FILTER, "xattr_filter" },
 	{ false, EROFS_FEATURE_INCOMPAT_ZERO_PADDING, "0padding" },
 	{ false, EROFS_FEATURE_INCOMPAT_COMPR_CFGS, "compr_cfgs" },
 	{ false, EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER, "big_pcluster" },
-- 
2.19.1.6.gb485710b

