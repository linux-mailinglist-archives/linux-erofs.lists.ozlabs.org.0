Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D93799DF5
	for <lists+linux-erofs@lfdr.de>; Sun, 10 Sep 2023 13:58:18 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rk7dx1Y94z3bhy
	for <lists+linux-erofs@lfdr.de>; Sun, 10 Sep 2023 21:58:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rk7dr1PWzz2xdX
	for <linux-erofs@lists.ozlabs.org>; Sun, 10 Sep 2023 21:58:05 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vri-Sk9_1694347071;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vri-Sk9_1694347071)
          by smtp.aliyun-inc.com;
          Sun, 10 Sep 2023 19:57:59 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: get rid of useless (l)stat64 for MacOS
Date: Sun, 10 Sep 2023 19:57:44 +0800
Message-Id: <20230910115744.83819-1-hsiangkao@linux.alibaba.com>
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

It breaks the MacOS build [1] and actually it has no use anymore
after commit 7715b294087e ("erofs-utils: configure: Use 64bit off_t").

[1] https://github.com/erofs/erofsnightly/actions/runs/6134394959/job/16647166641
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/defs.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 20f9741..fefa7e7 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -338,11 +338,6 @@ unsigned long __roundup_pow_of_two(unsigned long n)
 #define ST_MTIM_NSEC(stbuf) 0
 #endif
 
-#ifdef __APPLE__
-#define stat64		stat
-#define lstat64		lstat
-#endif
-
 #ifdef __cplusplus
 }
 #endif
-- 
2.24.4

