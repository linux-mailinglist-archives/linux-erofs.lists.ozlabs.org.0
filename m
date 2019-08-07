Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id B64A584EDE
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2019 16:37:55 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 463Yy739HKzDqng
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2019 00:37:51 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=126.com
 (client-ip=220.181.15.114; helo=m15-114.126.com;
 envelope-from=shenmeng999@126.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=126.com header.i=@126.com header.b="oqjIuja0"; 
 dkim-atps=neutral
Received: from m15-114.126.com (m15-114.126.com [220.181.15.114])
 by lists.ozlabs.org (Postfix) with ESMTP id 463Yxp0NwkzDql9
 for <linux-erofs@lists.ozlabs.org>; Thu,  8 Aug 2019 00:37:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=K1zYRLV8mXJZEabq/6
 CKw1ePcGLEyExO3HDmqidP/gA=; b=oqjIuja0TB9AqC6UYSbge5busYOqZcxgWy
 7lToufJGQ9QI2FOWoY0ZVTV7FvGh9A7NHVEadngtXEQ4c/DWPBTq1zuIpAGaaPwJ
 +r0mTXC1co2TJKOhK66SVRTItY0hBaXchbMO1UvN9it7FoSgZCyxb/H4THgv1ZS+
 iHs/Yyz5U=
Received: from localhost.localdomain.localdomain (unknown [112.44.106.84])
 by smtp7 (Coremail) with SMTP id DsmowADXO_EJ4kpdwTqxKg--.17425S2;
 Wed, 07 Aug 2019 22:36:59 +0800 (CST)
From: shenmeng999@126.com
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [PATCH v2] erofs-utils: get block device size correctly
Date: Wed,  7 Aug 2019 22:36:55 +0800
Message-Id: <1565188615-19591-1-git-send-email-shenmeng999@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DsmowADXO_EJ4kpdwTqxKg--.17425S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF4fWw1DtrW7ZFy7WFyDZFb_yoW8GFW3pF
 4DCF1rtrW8Kw1xuFyfJ3WIya45KanYkw4Ik3y7Wr1rAa4UJw4qgr4DGr9Yga1fWrW8WF1U
 tFZ3XF1rCFsrXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jMdgAUUUUU=
X-Originating-IP: [112.44.106.84]
X-CM-SenderInfo: xvkh0z5hqjmmaz6rjloofrz/1tbikhoJ01pD9vI0JgABsc
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
Cc: shenmeng996 <shenmeng999@126.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: shenmeng996 <shenmeng999@126.com>

fstat return block device's size of zero.
use ioctl to get block device's size.

Signed-off-by: shenmeng996 <shenmeng999@126.com>
---
 lib/io.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)
 mode change 100644 => 100755 lib/io.c

diff --git a/lib/io.c b/lib/io.c
old mode 100644
new mode 100755
index 93328d3..a93c509
--- a/lib/io.c
+++ b/lib/io.c
@@ -9,6 +9,8 @@
 #define _LARGEFILE64_SOURCE
 #define _GNU_SOURCE
 #include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <linux/fs.h>
 #include "erofs/io.h"
 #ifdef HAVE_LINUX_FALLOC_H
 #include <linux/falloc.h>
@@ -21,6 +23,23 @@ static const char *erofs_devname;
 static int erofs_devfd = -1;
 static u64 erofs_devsz;
 
+int dev_get_blkdev_size(int fd, u64 *bytes)
+{
+	unsigned long size;
+
+#ifdef BLKGETSIZE64
+	if (ioctl(fd, BLKGETSIZE64, bytes) >= 0)
+		return 0;
+#endif
+
+	if (ioctl(fd, BLKGETSIZE, &size) >= 0) {
+		*bytes = ((u64)size << 9);
+		return 0;
+	}
+
+	return -errno;
+}
+
 void dev_close(void)
 {
 	close(erofs_devfd);
@@ -49,7 +68,12 @@ int dev_open(const char *dev)
 
 	switch (st.st_mode & S_IFMT) {
 	case S_IFBLK:
-		erofs_devsz = st.st_size;
+		ret = dev_get_blkdev_size(fd, &erofs_devsz);
+		if (ret) {
+			erofs_err("failed to get block device size(%s).", dev);
+			close(fd);
+			return ret;	
+		}
 		break;
 	case S_IFREG:
 		ret = ftruncate(fd, 0);
-- 
1.8.3.1

