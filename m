Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F07E776C954
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Aug 2023 11:18:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RG5xy0HYCz3bTV
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Aug 2023 19:18:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RG5xH2dPzz3c9G
	for <linux-erofs@lists.ozlabs.org>; Wed,  2 Aug 2023 19:18:11 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VouSZMM_1690967885;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VouSZMM_1690967885)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 17:18:06 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 15/16] erofs-utils: mkfs: add dependency on zlib_LIBS
Date: Wed,  2 Aug 2023 17:17:49 +0800
Message-Id: <20230802091750.74181-15-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230802091750.74181-1-jefflexu@linux.alibaba.com>
References: <20230802091750.74181-1-jefflexu@linux.alibaba.com>
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

Later we are going to introduce new feature of merging multiple erofs
images generated from tarfs mode, in which mkfs.erofs may read file data
from disk.  This requires dependency on zlib_LIBS for mkfs.erofs.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 mkfs/Makefile.am | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
index 603c2f3..dd75485 100644
--- a/mkfs/Makefile.am
+++ b/mkfs/Makefile.am
@@ -6,4 +6,5 @@ AM_CPPFLAGS = ${libselinux_CFLAGS}
 mkfs_erofs_SOURCES = main.c
 mkfs_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
 mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
-	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS} ${libdeflate_LIBS}
+	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} \
+	${libdeflate_LIBS}
-- 
2.19.1.6.gb485710b

