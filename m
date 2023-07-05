Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D513747DCC
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 09:04:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QwrJG6ywCz3bZM
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 17:04:46 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QwrJ26MlLz2yyg
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jul 2023 17:04:34 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VmfjzPH_1688540669;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VmfjzPH_1688540669)
          by smtp.aliyun-inc.com;
          Wed, 05 Jul 2023 15:04:30 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/2] erofs: boost negative xattr lookup with bloom filter
Date: Wed,  5 Jul 2023 15:04:27 +0800
Message-Id: <20230705070427.92579-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230705070427.92579-1-jefflexu@linux.alibaba.com>
References: <20230705070427.92579-1-jefflexu@linux.alibaba.com>
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

The bit value for the bloom filter map has a reverse semantics for
compatibility.  That is, the bit value of 0 indicates existence, while
the bit value of 1 indicates the absence of corresponding xattr.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/internal.h |  2 ++
 fs/erofs/xattr.c    | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 36e32fa542f0..7e447b48a46b 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -251,6 +251,7 @@ EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRAGMENTS)
 EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
 EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
 EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
+EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
 
 /* atomic flag definitions */
 #define EROFS_I_EA_INITED_BIT	0
@@ -270,6 +271,7 @@ struct erofs_inode {
 	unsigned char inode_isize;
 	unsigned int xattr_isize;
 
+	unsigned long xattr_name_filter;
 	unsigned int xattr_shared_count;
 	unsigned int *xattr_shared_xattrs;
 
diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
index 40178b6e0688..1137723303d3 100644
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
+	vi->xattr_name_filter = le32_to_cpu(ih->h_name_filter);
 	vi->xattr_shared_count = ih->h_shared_count;
 	vi->xattr_shared_xattrs = kmalloc_array(vi->xattr_shared_count,
 						sizeof(uint), GFP_KERNEL);
@@ -392,7 +394,10 @@ int erofs_getxattr(struct inode *inode, int index, const char *name,
 		   void *buffer, size_t buffer_size)
 {
 	int ret;
+	uint32_t bit;
 	struct erofs_xattr_iter it;
+	struct erofs_inode *vi = EROFS_I(inode);
+	struct erofs_sb_info *sbi = EROFS_SB(inode->i_sb);
 
 	if (!name)
 		return -EINVAL;
@@ -401,6 +406,13 @@ int erofs_getxattr(struct inode *inode, int index, const char *name,
 	if (ret)
 		return ret;
 
+	if (erofs_sb_has_xattr_filter(sbi)) {
+		bit = xxh32(name, strlen(name), EROFS_XATTR_FILTER_SEED + index);
+		bit &= EROFS_XATTR_FILTER_MASK;
+		if (test_bit(bit, &vi->xattr_name_filter))
+			return -ENOATTR;
+	}
+
 	it.index = index;
 	it.name = (struct qstr)QSTR_INIT(name, strlen(name));
 	if (it.name.len > EROFS_NAME_LEN)
-- 
2.19.1.6.gb485710b

