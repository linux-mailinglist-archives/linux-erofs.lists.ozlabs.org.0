Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 541B276C945
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Aug 2023 11:18:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RG5x80pJ7z30Jy
	for <lists+linux-erofs@lfdr.de>; Wed,  2 Aug 2023 19:18:04 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RG5x40PQ8z2xr6
	for <linux-erofs@lists.ozlabs.org>; Wed,  2 Aug 2023 19:17:57 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VouOMFr_1690967870;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VouOMFr_1690967870)
          by smtp.aliyun-inc.com;
          Wed, 02 Aug 2023 17:17:51 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 01/16] erofs-utils: fix tar.h
Date: Wed,  2 Aug 2023 17:17:35 +0800
Message-Id: <20230802091750.74181-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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

Include "internal.h" to fix the dependency on prototypes of `struct
erofs_inode` and `struct erofs_sb_info`.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/tar.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/erofs/tar.h b/include/erofs/tar.h
index 8d3f8de..b7c2ef8 100644
--- a/include/erofs/tar.h
+++ b/include/erofs/tar.h
@@ -2,8 +2,15 @@
 #ifndef __EROFS_TAR_H
 #define __EROFS_TAR_H
 
+#ifdef __cplusplus
+extern "C"
+{
+#endif
+
 #include <sys/stat.h>
 
+#include "internal.h"
+
 struct erofs_pax_header {
 	struct stat st;
 	bool use_mtime;
@@ -27,4 +34,8 @@ int tarerofs_parse_tar(struct erofs_inode *root, struct erofs_tarfile *tar);
 int tarerofs_reserve_devtable(struct erofs_sb_info *sbi, unsigned int devices);
 int tarerofs_write_devtable(struct erofs_sb_info *sbi, struct erofs_tarfile *tar);
 
+#ifdef __cplusplus
+}
+#endif
+
 #endif
-- 
2.19.1.6.gb485710b

