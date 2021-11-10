Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A705A44BBCF
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Nov 2021 07:50:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpwT63Vt9z2yWL
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Nov 2021 17:50:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpwSy4skyz2xRn
 for <linux-erofs@lists.ozlabs.org>; Wed, 10 Nov 2021 17:49:49 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0UvtLyJm_1636526973; 
Received: from
 e18g09479.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UvtLyJm_1636526973) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 10 Nov 2021 14:49:39 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] AOSP: erofs-utils: avoid lzma inclusion when liblzma is
 disabled
Date: Wed, 10 Nov 2021 14:49:31 +0800
Message-Id: <20211110064931.181727-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Daeho Jeong <daehojeong@google.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

As Daeho reported [1], erofs-utils will fail to build with the
current AOSP Android.bp:

external/erofs-utils/lib/compressor_liblzma.c:8:10: fatal error:
'lzma.h' file not found
         ^~~~~~~~
1 error generated.
16:13:47 ninja failed with: exit status 1

compressor_liblzma.c won't be compiled if ENABLE_LIBLZMA is not
defined according to lib/Makefile.am. Thus it doesn't have an impact
on non-Android scenarios.

[1] https://lore.kernel.org/r/CACOAw_wt+DX0D+Ps-K=oF+MgUxtVKbXpamShoZR7n4WwM+wODw@mail.gmail.com
Reported-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compressor_liblzma.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index e9bfcc556c54..40a05efb11dc 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2021 Gao Xiang <xiang@kernel.org>
  */
 #include <stdlib.h>
+#include "config.h"
+#ifdef HAVE_LIBLZMA
 #include <lzma.h>
 #include "erofs/config.h"
 #include "erofs/print.h"
@@ -103,3 +105,4 @@ struct erofs_compressor erofs_compressor_lzma = {
 	.setlevel = erofs_compressor_liblzma_setlevel,
 	.compress_destsize = erofs_liblzma_compress_destsize,
 };
+#endif
-- 
2.24.4

