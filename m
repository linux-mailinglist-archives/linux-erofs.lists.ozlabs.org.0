Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2867029BD
	for <lists+linux-erofs@lfdr.de>; Mon, 15 May 2023 11:58:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QKZYw1dZdz3cG1
	for <lists+linux-erofs@lfdr.de>; Mon, 15 May 2023 19:58:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=aDFvqi3K;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=aDFvqi3K;
	dkim-atps=neutral
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QKZYr4nkdz2xWc
	for <linux-erofs@lists.ozlabs.org>; Mon, 15 May 2023 19:58:07 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1aad6f2be8eso115803765ad.3
        for <linux-erofs@lists.ozlabs.org>; Mon, 15 May 2023 02:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684144684; x=1686736684;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OleVJpT/tSp3JbThvpJR/uVqE8ywZaeyDX9kv6FUcs=;
        b=aDFvqi3Kc+2cTVR7CAW9p2K/+peYT7xMX+X9CD4q3eRs668XvbccLxuU7S3/6ovlT4
         S0qFH8h+qhxocnusiYEeVrcMaWFF+GTJPiOFWz9SN9MoNSntz4EmnAErcip+aEm8Hx0j
         +s87DVDlwWJPZ1ryzCFM0DCwdkVQShRUZYVsfwNP4jIfwhq5nlFP9SBlQ7tY99FJTqrA
         ++Bh5uPOpcs/1uGWpcc+07zYrxC0+VLi+V4FJD7QwIGSIKvQoRpM5fatTr3NGWQ5ZvrO
         5I4xHCt5XJk/cG2UZoa5ueEba0lI/QUpfuZseVlRx92fHqEikc8droMeA28HHeHsciIH
         uy7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684144684; x=1686736684;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OleVJpT/tSp3JbThvpJR/uVqE8ywZaeyDX9kv6FUcs=;
        b=NVrFi/9h1CZvlMwiLM/DJ0pBmLKq6PyxFanEIawiHFudyGkNACeRSKn5rjuAleO9HQ
         N6YQ/ZLbKLbWGF9TktGyXcAacH7OtokvnM8qM1y7S+FMKr4c2CILpuc+13SpfRA47pI7
         XLvAFeIsg7DDvmi8n4b26vxriDz2JEBQitHjnb1MGhuqTnxDz+CH5/lOZQoILbrMKzpJ
         k0xsFdUnGJfpw6GaLKDJL5gGqqNWqXIntAq+Pm6AP6oInE/k4wIjsO4ZgK91ny3T/RXv
         JKSojNmK5Z1IqJMROOS+yS6dowW0RgU8sknyVd3gmwWMCs5B6jtTD10i3z0P+jBat5tH
         54Yw==
X-Gm-Message-State: AC+VfDwaYywY0pp3jvMK6zQ5eN2odL75KmuTlW1Ka3nIFpnWx6B+Vs5d
	fdFbAC7TRkoLftXibVLujvk=
X-Google-Smtp-Source: ACHHUZ6IO/PNayfQxugzW94ZD++QyqwVhs08+86gK5utF9Jhy0YlrUm5kBy/xk0g73G/xx3yPFV9Zg==
X-Received: by 2002:a17:902:e890:b0:1ad:d500:19ce with SMTP id w16-20020a170902e89000b001add50019cemr16115537plg.41.1684144684472;
        Mon, 15 May 2023 02:58:04 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id bf12-20020a170902b90c00b001a96d295f15sm13031127plb.284.2023.05.15.02.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 02:58:04 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: avoid pcpubuf.c inclusion if CONFIG_EROFS_FS_ZIP is off
Date: Mon, 15 May 2023 17:57:58 +0800
Message-Id: <20230515095758.10391-1-zbestahu@gmail.com>
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

The function of pcpubuf.c is just for low-latency decompression
algorithms (e.g. lz4).

Signed-off-by: Yue Hu <huyue2@coolpad.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/Makefile   |  4 ++--
 fs/erofs/internal.h | 13 +++++++------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/Makefile b/fs/erofs/Makefile
index 99bbc597a3e9..a3a98fc3e481 100644
--- a/fs/erofs/Makefile
+++ b/fs/erofs/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 obj-$(CONFIG_EROFS_FS) += erofs.o
-erofs-objs := super.o inode.o data.o namei.o dir.o utils.o pcpubuf.o sysfs.o
+erofs-objs := super.o inode.o data.o namei.o dir.o utils.o sysfs.o
 erofs-$(CONFIG_EROFS_FS_XATTR) += xattr.o
-erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o
+erofs-$(CONFIG_EROFS_FS_ZIP) += decompressor.o zmap.o zdata.o pcpubuf.o
 erofs-$(CONFIG_EROFS_FS_ZIP_LZMA) += decompressor_lzma.o
 erofs-$(CONFIG_EROFS_FS_ONDEMAND) += fscache.o
diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index af0431a40647..1e39c03357d1 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -472,12 +472,6 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
 	return NULL;
 }
 
-void *erofs_get_pcpubuf(unsigned int requiredpages);
-void erofs_put_pcpubuf(void *ptr);
-int erofs_pcpubuf_growsize(unsigned int nrpages);
-void __init erofs_pcpubuf_init(void);
-void erofs_pcpubuf_exit(void);
-
 int erofs_register_sysfs(struct super_block *sb);
 void erofs_unregister_sysfs(struct super_block *sb);
 int __init erofs_init_sysfs(void);
@@ -512,6 +506,11 @@ int z_erofs_load_lz4_config(struct super_block *sb,
 			    struct z_erofs_lz4_cfgs *lz4, int len);
 int z_erofs_map_blocks_iter(struct inode *inode, struct erofs_map_blocks *map,
 			    int flags);
+void *erofs_get_pcpubuf(unsigned int requiredpages);
+void erofs_put_pcpubuf(void *ptr);
+int erofs_pcpubuf_growsize(unsigned int nrpages);
+void __init erofs_pcpubuf_init(void);
+void erofs_pcpubuf_exit(void);
 #else
 static inline void erofs_shrinker_register(struct super_block *sb) {}
 static inline void erofs_shrinker_unregister(struct super_block *sb) {}
@@ -529,6 +528,8 @@ static inline int z_erofs_load_lz4_config(struct super_block *sb,
 	}
 	return 0;
 }
+static inline void erofs_pcpubuf_init(void) {}
+static inline void erofs_pcpubuf_exit(void) {}
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 #ifdef CONFIG_EROFS_FS_ZIP_LZMA
-- 
2.17.1

