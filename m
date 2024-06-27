Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 474B0919DBC
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 05:14:11 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ONjNwX/0;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W8kDq4v1hz3cdn
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 13:14:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ONjNwX/0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W8kDk6vBcz3cXH
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jun 2024 13:13:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719458032; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=KkPaDWoZmD+ORfXLaG1I2n9oL2r5YM/kos0rPUAl7lk=;
	b=ONjNwX/0TwfmBttjDT/kXQ49gsoeYCptqOGovFi/lM0FqV5jNAb0xGidQgDkLdW3dPlLefV5fmDXxBMkSU2fvX/S/UG8/bgMnURRjsGcCdjfZLy4luhQsn1CmbEqxjWLkOAf8dezUaelnW1OqG0/9FvX1J1gjRufPEoA2I8pGTA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W9LHU.z_1719458024;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9LHU.z_1719458024)
          by smtp.aliyun-inc.com;
          Thu, 27 Jun 2024 11:13:50 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix "non-trivial designated initializers not supported"
Date: Thu, 27 Jun 2024 11:13:43 +0800
Message-Id: <20240627031343.3424030-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Hongzhen Luo <hongzhen@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

This partially reverts commit 79f6e168d94c ("erofs-utils: improve
compatibility and reduce header conflicts") since some C++ compiler
will complain:

include/erofs_fs.h: In function 'void erofs_check_ondisk_layout_definitions()':
include/erofs_fs.h:460:2: sorry, unimplemented: non-trivial designated initializers not supported

Let's just bypass this compile-time check for the C++ language since
only external programs may be written by C++.

Fixes: 79f6e168d94c ("erofs-utils: improve compatibility and reduce header conflicts")
Cc: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs_fs.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 0d603c4..fc21915 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -450,14 +450,14 @@ struct z_erofs_lcluster_index {
 /* check the EROFS on-disk layout strictly at compile time */
 static inline void erofs_check_ondisk_layout_definitions(void)
 {
+#ifndef __cplusplus
 	const union {
 		struct z_erofs_map_header h;
 		__le64 v;
 	} fmh __maybe_unused = {
-		.h = {
-			.h_clusterbits = 1 <<Z_EROFS_FRAGMENT_INODE_BIT,
-		},
+		.h.h_clusterbits = 1 << Z_EROFS_FRAGMENT_INODE_BIT,
 	};
+#endif
 
 	BUILD_BUG_ON(sizeof(struct erofs_super_block) != 128);
 	BUILD_BUG_ON(sizeof(struct erofs_inode_compact) != 32);
@@ -476,9 +476,11 @@ static inline void erofs_check_ondisk_layout_definitions(void)
 
 	BUILD_BUG_ON(BIT(Z_EROFS_LI_LCLUSTER_TYPE_BITS) <
 		     Z_EROFS_LCLUSTER_TYPE_MAX - 1);
+#ifndef __cplusplus
 	/* exclude old compiler versions like gcc 7.5.0 */
 	BUILD_BUG_ON(__builtin_constant_p(fmh.v) ?
 		     fmh.v != cpu_to_le64(1ULL << 63) : 0);
+#endif
 }
 
 #endif
-- 
2.39.3

