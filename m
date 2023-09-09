Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2CA7999FB
	for <lists+linux-erofs@lfdr.de>; Sat,  9 Sep 2023 18:33:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rjdng4fnmz3c5Y
	for <lists+linux-erofs@lfdr.de>; Sun, 10 Sep 2023 02:33:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RjdnQ4jZkz2yVg
	for <linux-erofs@lists.ozlabs.org>; Sun, 10 Sep 2023 02:32:58 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VrfyqQt_1694277170;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VrfyqQt_1694277170)
          by smtp.aliyun-inc.com;
          Sun, 10 Sep 2023 00:32:52 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v7 03/13] erofs-utils: lib: add erofs_inode_is_whiteout() helper
Date: Sun, 10 Sep 2023 00:32:30 +0800
Message-Id: <20230909163240.42057-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20230909163240.42057-1-hsiangkao@linux.alibaba.com>
References: <20230909163240.42057-1-hsiangkao@linux.alibaba.com>
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

From: Jingbo Xu <jefflexu@linux.alibaba.com>

Add erofs_inode_is_whiteout() helper to check if a given inode is
a whiteout.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/internal.h | 7 +++++++
 lib/tar.c                | 2 --
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index 382024a..ac82336 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -20,6 +20,7 @@ typedef unsigned short umode_t;
 #include "erofs_fs.h"
 #include <fcntl.h>
 #include <sys/types.h> /* for off_t definition */
+#include <sys/stat.h> /* for S_ISCHR definition */
 #include <stdio.h>
 
 #ifndef PATH_MAX
@@ -423,6 +424,12 @@ static inline u32 erofs_crc32c(u32 crc, const u8 *in, size_t len)
 	return crc;
 }
 
+#define EROFS_WHITEOUT_DEV	0
+static inline bool erofs_inode_is_whiteout(struct erofs_inode *inode)
+{
+	return S_ISCHR(inode->i_mode) && inode->u.i_rdev == EROFS_WHITEOUT_DEV;
+}
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/lib/tar.c b/lib/tar.c
index 5b63cf5..c5dbef0 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -19,8 +19,6 @@
 #include "erofs/xattr.h"
 #include "erofs/blobchunk.h"
 
-#define EROFS_WHITEOUT_DEV	0
-
 static char erofs_libbuf[16384];
 
 struct tar_header {
-- 
2.24.4

