Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 709B7737DC8
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jun 2023 10:47:46 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QmHFX2Qcjz3cNN
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jun 2023 18:47:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QmGvh38xcz3bNn
	for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jun 2023 18:32:15 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R411e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VlfH3v6_1687336331;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VlfH3v6_1687336331)
          by smtp.aliyun-inc.com;
          Wed, 21 Jun 2023 16:32:11 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [RFC 2/2] erofs: optimize getxattr with bloom filter
Date: Wed, 21 Jun 2023 16:32:09 +0800
Message-Id: <20230621083209.116024-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
References: <20230621083209.116024-1-jefflexu@linux.alibaba.com>
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
Cc: linux-kernel@vger.kernel.org, alexl@redhat.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Boost the negative xattr lookup with bloom filter.

The bit value for the bloom filter map has a reverse semantics for
compatibility.  That is, the mapped bits will be cleared to 0, while the
bit value of 1 indicates the absence of corresponding xattr.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/internal.h |  2 ++
 fs/erofs/xattr.c    | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 1e39c03357d1..49b4b350af8a 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -285,6 +285,7 @@ EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
+EROFS_FEATURE_FUNCS(xattr_bloom, compat, COMPAT_XATTR_BLOOM)
 
 /* atomic flag definitions */
 #define EROFS_I_EA_INITED_BIT	0
@@ -304,6 +305,7 @@ struct erofs_inode {
 	unsigned char inode_isize;
 	unsigned int xattr_isize;
 
+	unsigned long xattr_bloom_map;
 	unsigned int xattr_shared_count;
 	unsigned int *xattr_shared_xattrs;
 
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 4376f654474d..1ab481b46e8d 100644
--- a/fs/erofs/xattr.c
+++ b/fs/erofs/xattr.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2021-2022, Alibaba Cloud
  */
 #include <linux/security.h>
+#include <linux/xxhash.h>
 #include "xattr.h"
 
 struct erofs_xattr_iter {
@@ -87,6 +88,7 @@ static int erofs_init_inode_xattrs(struct inode *inode)
 	}
 
 	ih = it.kaddr + erofs_blkoff(sb, it.pos);
+	vi->xattr_bloom_map = le32_to_cpu(ih->h_map);
 	vi->xattr_shared_count = ih->h_shared_count;
 	vi->xattr_shared_xattrs = kmalloc_array(vi->xattr_shared_count,
 						sizeof(uint), GFP_KERNEL);
@@ -392,8 +394,11 @@ int erofs_getxattr(struct inode *inode, int index,
 		   const char *name,
 		   void *buffer, size_t buffer_size)
 {
-	int ret;
+	int i, ret;
+	uint32_t bit;
 	struct erofs_xattr_iter it;
+	struct erofs_inode *const vi = EROFS_I(inode);
+	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 
 	if (!name)
 		return -EINVAL;
@@ -402,6 +407,15 @@ int erofs_getxattr(struct inode *inode, int index,
 	if (ret)
 		return ret;
 
+	if (erofs_sb_has_xattr_bloom(sbi) && vi->xattr_bloom_map) {
+		for (i = 0; i < EROFS_XATTR_BLOOM_COUNTS; i++) {
+			bit = xxh32(name, strlen(name), index + i);
+			bit &= EROFS_XATTR_BLOOM_MASK;
+			if (test_bit(bit, &vi->xattr_bloom_map))
+				return -ENOATTR;
+		}
+	}
+
 	it.index = index;
 	it.name = (struct qstr)QSTR_INIT(name, strlen(name));
 	if (it.name.len > EROFS_NAME_LEN)
-- 
2.19.1.6.gb485710b

