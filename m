Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id DF9616AAC43
	for <lists+linux-erofs@lfdr.de>; Sat,  4 Mar 2023 20:58:30 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PTbHg1Jmgz3cMR
	for <lists+linux-erofs@lfdr.de>; Sun,  5 Mar 2023 06:58:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PTbHb20nJz2ygG
	for <linux-erofs@lists.ozlabs.org>; Sun,  5 Mar 2023 06:58:19 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R551e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vd47ESv_1677959894;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vd47ESv_1677959894)
          by smtp.aliyun-inc.com;
          Sun, 05 Mar 2023 03:58:15 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/5] erofs-utils: fix delta[1] out-of-bound of compact indexes
Date: Sun,  5 Mar 2023 03:58:08 +0800
Message-Id: <20230304195812.120063-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230304195732.119053-1-hsiangkao@linux.alibaba.com>
References: <20230304195732.119053-1-hsiangkao@linux.alibaba.com>
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

delta[1] should not exceed (1 << lclusterbits) - 1, usually 4095
blocks, which means a single compressed extent which isn't less
than 16MiB could trigger this issue (it very rare happens).

Fixes: 76b822726ff8 ("erofs-utils: introduce compacted compression indexes")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/compress.c b/lib/compress.c
index 65c6f90..f38c795 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -627,7 +627,8 @@ static void *write_compacted_indexes(u8 *out,
 				blkaddr += cblks;
 				*dummy_head = false;
 			} else if (i + 1 == vcnt) {
-				offset = cv[i].u.delta[1];
+				offset = min_t(u16, cv[i].u.delta[1],
+						(1 << logical_clusterbits) - 1);
 			} else {
 				offset = cv[i].u.delta[0];
 			}
-- 
2.24.4

