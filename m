Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D491708DD2
	for <lists+linux-erofs@lfdr.de>; Fri, 19 May 2023 04:34:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QMrWh05xFz3f7X
	for <lists+linux-erofs@lfdr.de>; Fri, 19 May 2023 12:34:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=cthiU+9I;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=cthiU+9I;
	dkim-atps=neutral
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QMrWb1SYTz3bdm
	for <linux-erofs@lists.ozlabs.org>; Fri, 19 May 2023 12:34:01 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ae85b71141so67845ad.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 18 May 2023 19:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684463637; x=1687055637;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+KLO8kfhh/ehAJcoZFZyic4XaS3xMS9Q6emroTwVE0=;
        b=cthiU+9IQNQti2B6zpcXJctFQENHs0De8M6OVjXZWRjvv89ObB19AZcSD1hVDI6bIq
         tp47XOiQ5hLPTIcKTmJBD+YtJC4x/SCCq4RJlX2Z65RpKbueEotZjTmRO0A9Y4zgtTLP
         oBvuUSZrtkTYzDp7Ov2jI5d3bZO+MdXODjgbqscpmRjZZcRbtlu5GYXS6bt/yj8xw6Tk
         Zw5Ny5cp0YWLiN8TRnDjD6ORYVQ1Dntv33LzcFKislzRHhwb4b3Laet2ZksVkc1+LteY
         TDVAV6SHdjRkvkMM62Tb/WfktPGJijJ/00pMnAZTEJSeJZJTw12rt3f/iJjl3IqHKTJw
         EiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684463637; x=1687055637;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+KLO8kfhh/ehAJcoZFZyic4XaS3xMS9Q6emroTwVE0=;
        b=B/eXiT4N4QQqR9QJHprly8Q0TmqEhgkmdj0oMvUqFCkFHLffmdXc7/AShBNPQFrWUO
         VXzKbbtva5MUn+cSOJmW5spcKkwI1Ok6YkLfk19NzVzVJa2ZkeVLSmle6eW2hjU3sGBG
         ArXPEDxZU0NXHahUTlxKaqFvY6H2bnOzAI5zYaeap3j0+qBAJj7+ZMAT9o8B4dRY22bX
         y/ZFO+FP5zjW2Xa+navZJgjyImICKr6IIQmkh+hjhaQ9UdGOlUXS3Pj1bfjsg3oyVRCG
         SGQdcR81dILiWX7SadHF0e8H3Ixq+W5S+vziSd3QrqBGCx+3UuHWIhvfZNIYEHKpP33H
         wX3Q==
X-Gm-Message-State: AC+VfDxWzV04RaAbIbbyfATMKCgnoZUExI3q3OzW9TYU/UsW4/YsqQMO
	gLYOEuvrgNMHHmIj7gsrRos=
X-Google-Smtp-Source: ACHHUZ6XisjMlgkxAik7qc3jmnRJ2+i1rCJ9pNHbYp/N+aeCFg8vUvXVuKM/KOZCM1bxHdyI7J9UyA==
X-Received: by 2002:a17:902:ecc6:b0:1a6:9f9b:1327 with SMTP id a6-20020a170902ecc600b001a69f9b1327mr1343417plh.45.1684463637189;
        Thu, 18 May 2023 19:33:57 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id u11-20020a170902e80b00b0019f3cc463absm2202645plg.0.2023.05.18.19.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 19:33:56 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	jefflexu@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: move erofs_{allocpage,release_pages}() under CONFIG_EROFS_FS_ZIP
Date: Fri, 19 May 2023 10:33:13 +0800
Message-Id: <20230519023313.24892-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.17.1
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

These two functions are only used for compression side now. Also,
eliminate unused pagevec.h inclusion.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/Makefile | 4 ++--
 fs/erofs/utils.c  | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index a3a98fc3e481..1b1c3e3127cd 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
-erofs-objs := super.o inode.o data.o namei.o dir.o utils.o sysfs.o
+erofs-objs := super.o inode.o data.o namei.o dir.o sysfs.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
-erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o pcpubuf.o
+erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o utils.o pcpubuf.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
diff --git a/fs/erofs/utils.c b/fs/erofs/utils.c
index 46627cb69abe..72ba7daba33c 100644
--- a/fs/erofs/utils.c
+++ b/fs/erofs/utils.c
@@ -4,7 +4,6 @@
  *             https://www.huawei.com/
  */
 #include "internal.h"
-#include <linux/pagevec.h>
 
 struct page *erofs_allocpage(struct page **pagepool, gfp_t gfp)
 {
@@ -29,7 +28,6 @@ void erofs_release_pages(struct page **pagepool)
 	}
 }
 
-#ifdef CONFIG_EROFS_FS_ZIP
 /* global shrink count (for all mounted EROFS instances) */
 static atomic_long_t erofs_global_shrink_cnt;
 
@@ -289,4 +287,3 @@ void erofs_exit_shrinker(void)
 {
 	unregister_shrinker(&erofs_shrinker_info);
 }
-#endif	/* !CONFIG_EROFS_FS_ZIP */
-- 
2.17.1

