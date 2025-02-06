Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1241AA2A8CA
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Feb 2025 13:51:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YpcR24l7tz30WC
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Feb 2025 23:50:54 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1738846251;
	cv=none; b=Gd7EQ8SMAbp40ilNyqBGWHq+rwRFAq8h5dHJ0GivPAoNwz35hrK4VkCcKfAIWIomaMFSqEFXGklXLE9FAe4dMOwjACC20J0m85+7jq6EKuQ2L64375WBMX+LhusPZ+xy2i/Kp9l9xQ6BiLrLPI/gBmI8d9WXJTakGPkGMdlZMzDk6C3VYGPuR5e3oSw2fJ14RM1dmDBM2VQHfPMFBwnJv8dNo0POdb/PY4JPXKhrkvh8zDS0zGCt8l4MJZwIYe9SbWpRjygd4sBlrnpZ3tP8DC+vil6zJSYhDfk9bQxXFtzD5+nR4LdsM/Q3t5WPF+BPiWrlAtZ//OAGLLLbJBFC7A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1738846251; c=relaxed/relaxed;
	bh=PiVnJwspJHnN10y38ub0qI08Xs+HVQyNz5Zhej0R27g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eiIdANABM9jVJPESLv4Tpmzom4JfXmdnIyxkp7ZVUwt4sCt7EOFPmNjap7J+zhnYN0c1ZiwAvsqLWZoTpHN/LRxdoproVIuUJOSA2uwOMxYOG0tzIAtiQoJZHSsNgwggRKMdS6hamLcI0by5yAP2KM5gG6d+lVw+nVKM78Na2bOLWxyZJcTFIFfCTRzFnRJ1bV1c+jDqgK9hQ8OoYBwZDK7aA82kKa2NuocBmuSCp+kD7vr9qXYJBZEIZHlTD+B5xl50B+BivvzcBaR4qYFc27DI+SCwqtsDBDRp4qA35dd4JfJIHdSf36nXRol8tWA2mypWt0r5PFoM3/oxLEQjqQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qg74wtYk; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qg74wtYk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YpcQy0fnhz307V
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Feb 2025 23:50:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738846244; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=PiVnJwspJHnN10y38ub0qI08Xs+HVQyNz5Zhej0R27g=;
	b=qg74wtYkgZw8iMo7YAv1E9C5EEud6X8RhtlLshMvA+Dq43MJOlukF6W4kl0WWh/7ASvKVpg1nhHtTOiM79DC8LXHp6oPO98JlZylBu5q6E6ejxZQtQMwAu40EfN5alrL6C74CFLHMgOEupCnXiQd/4MrSsfX/zpRPMTI3iE5YgI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WOwMl.y_1738846236 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Feb 2025 20:50:43 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/9] erofs-utils: lib: sync up with the latest erofs_fs.h
Date: Thu,  6 Feb 2025 20:50:26 +0800
Message-ID: <20250206125034.1462966-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

Mainly commit 745ed7d77834 ("erofs: cleanup i_format-related stuffs")
and commit 7c3ca1838a78 ("erofs: restrict pcluster size limitations")

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h | 16 ++++------------
 include/erofs_fs.h       | 15 ++++++++-------
 2 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index eb665e2..7f01782 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -292,22 +292,14 @@ static inline bool is_inode_layout_compression(struct erofs_inode *inode)
 	return erofs_inode_is_data_compressed(inode->datalayout);
 }
 
-static inline unsigned int erofs_bitrange(unsigned int value, unsigned int bit,
-					  unsigned int bits)
+static inline unsigned int erofs_inode_version(unsigned int ifmt)
 {
-	return (value >> bit) & ((1 << bits) - 1);
+	return (ifmt >> EROFS_I_VERSION_BIT) & EROFS_I_VERSION_MASK;
 }
 
-static inline unsigned int erofs_inode_version(unsigned int value)
+static inline unsigned int erofs_inode_datalayout(unsigned int ifmt)
 {
-	return erofs_bitrange(value, EROFS_I_VERSION_BIT,
-			      EROFS_I_VERSION_BITS);
-}
-
-static inline unsigned int erofs_inode_datalayout(unsigned int value)
-{
-	return erofs_bitrange(value, EROFS_I_DATALAYOUT_BIT,
-			      EROFS_I_DATALAYOUT_BITS);
+	return (ifmt >> EROFS_I_DATALAYOUT_BIT) & EROFS_I_DATALAYOUT_MASK;
 }
 
 static inline struct erofs_inode *erofs_parent_inode(struct erofs_inode *inode)
diff --git a/include/erofs_fs.h b/include/erofs_fs.h
index 9c69aac..5672c99 100644
--- a/include/erofs_fs.h
+++ b/include/erofs_fs.h
@@ -10,6 +10,7 @@
 #define __EROFS_FS_H
 
 #define EROFS_SUPER_MAGIC_V1    0xE0F5E1E2
+/* to allow for x86 boot sectors and other oddities. */
 #define EROFS_SUPER_OFFSET      1024
 
 #define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
@@ -55,7 +56,7 @@ struct erofs_deviceslot {
 /* erofs on-disk super block (currently 128 bytes) */
 struct erofs_super_block {
 	__le32 magic;           /* file system magic number */
-	__le32 checksum;        /* crc32c(super_block) */
+	__le32 checksum;        /* crc32c to avoid unexpected on-disk overlap */
 	__le32 feature_compat;
 	__u8 blkszbits;         /* filesystem block size in bit shift */
 	__u8 sb_extslots;	/* superblock size = 128 + sb_extslots * 16 */
@@ -112,14 +113,14 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
 }
 
 /* bit definitions of inode i_format */
-#define EROFS_I_VERSION_BITS            1
-#define EROFS_I_DATALAYOUT_BITS         3
+#define EROFS_I_VERSION_MASK            0x01
+#define EROFS_I_DATALAYOUT_MASK         0x07
 
 #define EROFS_I_VERSION_BIT             0
 #define EROFS_I_DATALAYOUT_BIT          1
+#define EROFS_I_ALL_BIT			4
 
-#define EROFS_I_ALL	\
-	((1 << (EROFS_I_DATALAYOUT_BIT + EROFS_I_DATALAYOUT_BITS)) - 1)
+#define EROFS_I_ALL	((1 << EROFS_I_ALL_BIT) - 1)
 
 /* indicate chunk blkbits, thus 'chunksize = blocksize << chunk blkbits' */
 #define EROFS_CHUNK_FORMAT_BLKBITS_MASK		0x001F
@@ -334,11 +335,11 @@ struct z_erofs_deflate_cfgs {
 /* 6 bytes (+ length field = 8 bytes) */
 struct z_erofs_zstd_cfgs {
 	u8 format;
-	u8 windowlog;		/* windowLog - ZSTD_WINDOWLOG_ABSOLUTEMIN(10) */
+	u8 windowlog;           /* windowLog - ZSTD_WINDOWLOG_ABSOLUTEMIN(10) */
 	u8 reserved[4];
 } __packed;
 
-#define Z_EROFS_ZSTD_MAX_DICT_SIZE	Z_EROFS_PCLUSTER_MAX_SIZE
+#define Z_EROFS_ZSTD_MAX_DICT_SIZE      Z_EROFS_PCLUSTER_MAX_SIZE
 
 /*
  * bit 0 : COMPACTED_2B indexes (0 - off; 1 - on)
-- 
2.43.5

