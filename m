Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6EE9688DAE
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Feb 2023 04:02:11 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P7L6T5ZYJz3c6q
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Feb 2023 14:02:09 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P7L684Kgsz3cf2
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Feb 2023 14:01:52 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R281e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VamyBZB_1675393308;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VamyBZB_1675393308)
          by smtp.aliyun-inc.com;
          Fri, 03 Feb 2023 11:01:48 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 5/9] erofs: set accurate anony inode size for page cache sharing
Date: Fri,  3 Feb 2023 11:01:39 +0800
Message-Id: <20230203030143.73105-6-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230203030143.73105-1-jefflexu@linux.alibaba.com>
References: <20230203030143.73105-1-jefflexu@linux.alibaba.com>
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
Cc: linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

In prep for the following support for readahead for page cache sharing,
we need accurate inode size of the anonymous inode, or the readahead
algorithm may exceed EOF of blobs if the inode size is OFFSET_MAX magic.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/fscache.c  | 9 +++++++++
 fs/erofs/internal.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index bed02b21978a..4fe7f23b022e 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -554,6 +554,15 @@ struct erofs_fscache *erofs_fscache_acquire_cookie(struct super_block *sb,
 	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
 	inode->i_private = ctx;
 
+	if (test_opt(&EROFS_SB(sb)->opt, SHARE_CACHE)) {
+		struct netfs_cache_resources cres;
+		ret = fscache_begin_read_operation(&cres, cookie);
+		if (ret)
+			goto err_cookie;
+		fscache_end_operation(&cres);
+		inode->i_size = cookie->object_size;
+	}
+
 	ctx->cookie = cookie;
 	ctx->inode = inode;
 	return ctx;
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 7c6a7a2d9acf..60d14561fb46 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -181,6 +181,7 @@ struct erofs_sb_info {
 #define EROFS_MOUNT_POSIX_ACL		0x00000020
 #define EROFS_MOUNT_DAX_ALWAYS		0x00000040
 #define EROFS_MOUNT_DAX_NEVER		0x00000080
+#define EROFS_MOUNT_SHARE_CACHE		0x00000100
 
 #define clear_opt(opt, option)	((opt)->mount_opt &= ~EROFS_MOUNT_##option)
 #define set_opt(opt, option)	((opt)->mount_opt |= EROFS_MOUNT_##option)
-- 
2.19.1.6.gb485710b

