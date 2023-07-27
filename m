Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E49F76452D
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 06:57:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RBJRn1NZYz3cKF
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jul 2023 14:57:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RBJR91sgdz3c3t
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jul 2023 14:57:25 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VoJJeTq_1690433840;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VoJJeTq_1690433840)
          by smtp.aliyun-inc.com;
          Thu, 27 Jul 2023 12:57:21 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 8/9] erofs-utils: fix tar.h
Date: Thu, 27 Jul 2023 12:57:11 +0800
Message-Id: <20230727045712.45226-8-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230727045712.45226-1-jefflexu@linux.alibaba.com>
References: <20230727045712.45226-1-jefflexu@linux.alibaba.com>
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
 include/erofs/tar.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/erofs/tar.h b/include/erofs/tar.h
index 8699cb5..3a58528 100644
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
@@ -28,4 +35,9 @@ int tarerofs_write_devtable(struct erofs_sb_info *sbi, struct erofs_tarfile *tar
 
 struct erofs_dentry *erofs_get_dentry(struct erofs_inode *pwd, char *path,
 				      bool aufs, bool *whout, bool *opq);
+
+#ifdef __cplusplus
+}
+#endif
+
 #endif
-- 
2.19.1.6.gb485710b

