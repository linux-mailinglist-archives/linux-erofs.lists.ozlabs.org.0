Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3681835F3
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Aug 2019 17:55:30 +0200 (CEST)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 462zk72Lv9zDqvx
	for <lists+linux-erofs@lfdr.de>; Wed,  7 Aug 2019 01:55:27 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=126.com
 (client-ip=220.181.15.112; helo=m15-112.126.com;
 envelope-from=shenmeng999@126.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=126.com header.i=@126.com header.b="Wy+FaWjF"; 
 dkim-atps=neutral
Received: from m15-112.126.com (m15-112.126.com [220.181.15.112])
 by lists.ozlabs.org (Postfix) with ESMTP id 462zjx4zqczDqWL
 for <linux-erofs@lists.ozlabs.org>; Wed,  7 Aug 2019 01:55:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=KiR86I9jJxzj8jQmGa
 2Td54AuK8jQpDbFJoyyw9TZEc=; b=Wy+FaWjFsmRc66h2JXuYFiXL0AX/K/GMLT
 T5UhO0D9yECRY4KsX7nn9vgADntt9rStFdgg12YtGgc9XNCTnrfHMFcyqLMVZUq6
 JD2Ei1ghmxHa+tcDmeikC+WFxJf2wjxoyEnOxf8HntctY/QfkYQMX01OR0tkn9kJ
 KzjMY7R2o=
Received: from localhost.localdomain.localdomain (unknown [112.44.106.84])
 by smtp2 (Coremail) with SMTP id DMmowAAnKAhvm0ldY9OWJQ--.39443S2;
 Tue, 06 Aug 2019 23:23:28 +0800 (CST)
From: shenmeng999@126.com
To: linux-erofs@lists.ozlabs.org, bluce.liguifu@huawei.com, miaoxie@huawei.com,
 fangwei1@huawei.com
Subject: [PATCH] erofs-utils: get block device size correctly
Date: Tue,  6 Aug 2019 23:23:25 +0800
Message-Id: <1565105005-21709-1-git-send-email-shenmeng999@126.com>
X-Mailer: git-send-email 1.8.3.1
X-CM-TRANSID: DMmowAAnKAhvm0ldY9OWJQ--.39443S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtFyfKrWDtFykWFyxGr4fAFb_yoWfAFc_Cw
 1xAr1DWrs7tF4SvrWrJrsFvryvk397Gr4IgryrArW2vr1UGws5Gw1kXayrKF45Wr4Dur17
 uayYqrWfCw1YgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUYLAw3UUUUU==
X-Originating-IP: [112.44.106.84]
X-CM-SenderInfo: xvkh0z5hqjmmaz6rjloofrz/1tbitRAJ01pD+YvbWwAAsU
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
 lib/io.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/io.c b/lib/io.c
index 93328d3..ae3ac37 100644
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
@@ -49,7 +51,12 @@ int dev_open(const char *dev)
 
 	switch (st.st_mode & S_IFMT) {
 	case S_IFBLK:
-		erofs_devsz = st.st_size;
+		ret = ioctl(fd, BLKGETSIZE64, &erofs_devsz);
+		if (ret) {
+			erofs_err("failed to ioctl(%s).", dev);
+			close(fd);
+			return -errno;	
+		}
 		break;
 	case S_IFREG:
 		ret = ftruncate(fd, 0);
-- 
1.8.3.1

