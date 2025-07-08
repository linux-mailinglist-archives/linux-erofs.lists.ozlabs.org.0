Return-Path: <linux-erofs+bounces-543-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CC3AFC0B6
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 04:17:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bblB84FQlz30WQ;
	Tue,  8 Jul 2025 12:17:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751941056;
	cv=none; b=KHd7BVCcZDtZ6uJdAFxnqEKrsUHWq8NOVKJl5I6WZ7lA4G0FXlqhxegS7rOxdfCmUC40GOdQ3WuX2KDvo4WzCYZUDvND7jVs+qIutGtfC01j4A+b4i0xYRTdo3Gv1003hnYrTDXjyxdo1zNWPHO7Nlt/oDk9IOqs3PYfoKg85gyLboRHVPgoc8tdGG92DEygqIY3V/Pz1Q0FovSvVQhoMjvcAgngDLQ1j8LKLKFY+z694XrkWOKpIkcljb2Htsl/lWCbCE+fLVohe7z9ez+X6rbC/e8FzQNdlK3XR4H5oZGVTuEma98ggLM53AE1BBQbCOH3CMLD7H8VlRv9JThJkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751941056; c=relaxed/relaxed;
	bh=kCDzoTWx0q73pM0bcGHRMzIgVXGtcoUk0/tFxyUctqo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I/aQmYZooPgFQZUvmIFqRT9FFbv9bvjnWe43MIlBfLe2kQ4GtpjtgWwo/A5f4lafDoSigb9qNgkk88yPWFc6UdR4Hc/THtQKGCqIL3jAlCjll9V1ivA2H/3PoPQ5uqVvf255OkCWEDxR3HK5RRmnVNyvolIL3vbBMul7L58dtIQNdZL8YJcMNZ5rRwMdE5A8C/O7OQEDEPOf3M9cAWX5jVP38ZKJQF+uIk4SiSkEF/LhSR5q6LsiaqpEMDnOrfyzDn42vSXiWybJtjI0PZxKqOohJEG+12WGytIRg2KwAyPK9+dQq/27OEDH+3JCaMF+N00+g2xM/4YxbUpyeSWUtg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fGbzITjF; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=fGbzITjF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bblB54Wrpz2yFP
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Jul 2025 12:17:32 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751941047; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=kCDzoTWx0q73pM0bcGHRMzIgVXGtcoUk0/tFxyUctqo=;
	b=fGbzITjFPqVEHTCqAt3i2dGHLd/srYVDRoa1v8+3aAtANNEIicFMdkpYnyTaKgDQc8LtSpHpMLS4uViqkbco+E67V0pXnXTFit2gBsUosdOSd8jVfFhDmJ6nGLN++nzOdE1O4Thq/knqeA4p8sNnb/UMllFUloy6bAH4NrSbtY0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiIWO-Y_1751941043 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 10:17:26 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/4] erofs-utils: introduce `fallthrough;`
Date: Tue,  8 Jul 2025 10:17:19 +0800
Message-ID: <20250708021722.768644-1-hsiangkao@linux.alibaba.com>
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

To silence the `Missing break in switch (MISSING_BREAK)` warning.

Coverity-id: 569459
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/defs.h | 6 ++++++
 lib/namei.c          | 1 +
 lib/rebuild.c        | 2 +-
 lib/zmap.c           | 2 +-
 4 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/erofs/defs.h b/include/erofs/defs.h
index 21e0f09d..0f3e7546 100644
--- a/include/erofs/defs.h
+++ b/include/erofs/defs.h
@@ -369,6 +369,12 @@ unsigned long __roundup_pow_of_two(unsigned long n)
 #define __erofs_likely(x)      __builtin_expect(!!(x), 1)
 #define __erofs_unlikely(x)    __builtin_expect(!!(x), 0)
 
+#if __has_attribute(__fallthrough__)
+# define fallthrough	__attribute__((__fallthrough__))
+#else
+# define fallthrough	do {} while (0)  /* fallthrough */
+#endif
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/namei.c b/lib/namei.c
index 5da8ed98..d6013e5c 100644
--- a/lib/namei.c
+++ b/lib/namei.c
@@ -102,6 +102,7 @@ int erofs_read_inode_from_disk(struct erofs_inode *vi)
 	switch (vi->i_mode & S_IFMT) {
 	case S_IFDIR:
 		vi->dot_omitted = (ifmt >> EROFS_I_DOT_OMITTED_BIT) & 1;
+		fallthrough;
 	case S_IFREG:
 	case S_IFLNK:
 		vi->u.i_blkaddr = le32_to_cpu(copied.i_u.startblk_lo) |
diff --git a/lib/rebuild.c b/lib/rebuild.c
index 576d9d05..c580f81f 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -231,7 +231,7 @@ static int erofs_rebuild_update_inode(struct erofs_sb_info *dst_sb,
 	case S_IFCHR:
 		if (erofs_inode_is_whiteout(inode))
 			inode->i_parent->whiteouts = true;
-		/* fallthrough */
+		fallthrough;
 	case S_IFBLK:
 	case S_IFIFO:
 	case S_IFSOCK:
diff --git a/lib/zmap.c b/lib/zmap.c
index 99f40887..43e76e55 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -474,7 +474,7 @@ static int z_erofs_map_blocks_fo(struct erofs_inode *vi,
 		end = (m.lcn << lclusterbits) | m.clusterofs;
 		map->m_flags |= EROFS_MAP_FULL_MAPPED;
 		m.delta[0] = 1;
-		/* fallthrough */
+		fallthrough;
 	case Z_EROFS_LCLUSTER_TYPE_NONHEAD:
 		/* get the corresponding first chunk */
 		err = z_erofs_extent_lookback(&m, m.delta[0]);
-- 
2.43.5


