Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8689077D838
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Aug 2023 04:14:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RQWsj3SxQz3cTh
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Aug 2023 12:14:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RQWsL502Qz300f
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Aug 2023 12:13:58 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vptjsms_1692152032;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vptjsms_1692152032)
          by smtp.aliyun-inc.com;
          Wed, 16 Aug 2023 10:13:53 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 05/12] erofs-utils: lib: keep self maintained devname
Date: Wed, 16 Aug 2023 10:13:40 +0800
Message-Id: <20230816021347.126886-6-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230816021347.126886-1-jefflexu@linux.alibaba.com>
References: <20230816021347.126886-1-jefflexu@linux.alibaba.com>
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

Keep self allocated and maintained devname in erofs_sb_info.

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 include/erofs/internal.h |  2 +-
 lib/io.c                 | 14 ++++++++++++--
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/erofs/internal.h b/include/erofs/internal.h
index a04e6a6..892dc96 100644
--- a/include/erofs/internal.h
+++ b/include/erofs/internal.h
@@ -61,7 +61,7 @@ struct erofs_device_info {
 
 struct erofs_sb_info {
 	struct erofs_device_info *devs;
-	const char *devname;
+	char *devname;
 
 	u64 total_blocks;
 	u64 primarydevice_blocks;
diff --git a/lib/io.c b/lib/io.c
index 8d84de2..1545436 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -10,6 +10,7 @@
 #ifndef _GNU_SOURCE
 #define _GNU_SOURCE
 #endif
+#include <stdlib.h>
 #include <sys/stat.h>
 #include <sys/ioctl.h>
 #include "erofs/io.h"
@@ -46,6 +47,7 @@ static int dev_get_blkdev_size(int fd, u64 *bytes)
 void dev_close(struct erofs_sb_info *sbi)
 {
 	close(sbi->devfd);
+	free(sbi->devname);
 	sbi->devname = NULL;
 	sbi->devfd   = -1;
 	sbi->devsz   = 0;
@@ -95,7 +97,11 @@ int dev_open(struct erofs_sb_info *sbi, const char *dev)
 		return -EINVAL;
 	}
 
-	sbi->devname = dev;
+	sbi->devname = strdup(dev);
+	if (!sbi->devname) {
+		close(fd);
+		return -ENOMEM;
+	}
 	sbi->devfd = fd;
 
 	erofs_info("successfully to open %s", dev);
@@ -136,8 +142,12 @@ int dev_open_ro(struct erofs_sb_info *sbi, const char *dev)
 		return -errno;
 	}
 
+	sbi->devname = strdup(dev);
+	if (!sbi->devname) {
+		close(fd);
+		return -ENOMEM;
+	}
 	sbi->devfd = fd;
-	sbi->devname = dev;
 	sbi->devsz = INT64_MAX;
 	return 0;
 }
-- 
2.19.1.6.gb485710b

