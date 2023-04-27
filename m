Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0686EFF77
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Apr 2023 05:04:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Q6LDR6432z3chn
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Apr 2023 13:04:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=CGxwL2vk;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=CGxwL2vk;
	dkim-atps=neutral
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Q6LDJ3N7Rz2xjw
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Apr 2023 13:03:59 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-52091c58109so7442529a12.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 26 Apr 2023 20:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682564635; x=1685156635;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1A14gXOIzQ8LsUnpCV+kWBAJ4ogPDSbb3KQJ7ZlYIxs=;
        b=CGxwL2vk3j0Yl7BI3W9SYPNrRmdSJVZdUm4BiiDFB+Ar6LcG0PXNyNuBzpYQyaxTse
         XLXQdoVu8xdTnD1fad777iUEp5YoLGOoyTII71EtG/J9igUkFPj0ke6NNWW7gGEcxNKk
         2F34Ua6ky7fmEE2GSc9QNDRkjbo99IK+Szn5r03o8nJiUEHNoZPtDruWmgdQ0FjLb44E
         jdemBlMJ+EYcgbdFl8in/JMoBsKdirR2hhczuH4Bq8or+GOvtBosIuoOd8X7chVIyk9O
         B5yRHTYy4TVPMXmdY8WIfVd/o96m31vJ2eC5gmO9QHkdDf7yYAEgRg2Oed/c0u67mZ+D
         qnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682564635; x=1685156635;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1A14gXOIzQ8LsUnpCV+kWBAJ4ogPDSbb3KQJ7ZlYIxs=;
        b=an9Dc5nW8QZw4mU2gcyls467mQgpdv0ne1FGyzePjbOEtz5GlnF/CWi2DoMLCJwAc6
         iWNhfPsh/F2RsrabxN1EGw3r/iKPm3iMl6iAbBE14rla5H6vk+o+OeLio1/sYfjd3IWa
         9+8ie9m3pgb4CxX9b/uI37QN+ZDgl8oGW8vLUhjrZGbjd5EenQd4gfspFHT3kY93U2MX
         6mX0MoqHsFo/s4emlZDvxR5giNzS24RU5SbSuSWWTnaGkgUXYvgvms/jgQ6akzeBvWr1
         dm7f7RyU4wIA82P4btpKqhNeXFDeIB8oKtpiwYsjhZiAxyLwhsz9iWsv66CKtVfhxxVM
         sX+w==
X-Gm-Message-State: AC+VfDw90sAxC/jcXoS45QOOq2niiOLFgO4liafIdgaSErgOAsvWz6Lq
	SSi+keLf3yn1q6oekJbJgGA=
X-Google-Smtp-Source: ACHHUZ5NkADkq+bFRhb0WRAgEgeVe3ol89Kb4ts/o7en2zRirP5e/NpezlHp2j9+TAoMVPZxAHratg==
X-Received: by 2002:a17:90b:313:b0:247:2ff9:1cff with SMTP id ay19-20020a17090b031300b002472ff91cffmr306271pjb.25.1682564635110;
        Wed, 26 Apr 2023 20:03:55 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id f24-20020a63f118000000b0051b7d83ff22sm10380506pgi.80.2023.04.26.20.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 20:03:54 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: do not build pcpubuf.c for uncompressed data
Date: Thu, 27 Apr 2023 11:03:46 +0800
Message-Id: <20230427030346.5624-1-zbestahu@gmail.com>
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

The function of pcpubuf.c is just for low-latency decompression
algorithms (e.g. lz4).

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fs/erofs/Makefile   |  4 ++--
 fs/erofs/internal.h | 12 +++++++-----
 2 files changed, 9 insertions(+), 7 deletions(-)

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
index af0431a40647..65dbfa76f854 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -472,11 +472,6 @@ static inline void *erofs_vm_map_ram(struct page **pages, unsigned int count)
 	return NULL;
 }
 
-void *erofs_get_pcpubuf(unsigned int requiredpages);
-void erofs_put_pcpubuf(void *ptr);
-int erofs_pcpubuf_growsize(unsigned int nrpages);
-void __init erofs_pcpubuf_init(void);
-void erofs_pcpubuf_exit(void);
 
 int erofs_register_sysfs(struct super_block *sb);
 void erofs_unregister_sysfs(struct super_block *sb);
@@ -512,6 +507,11 @@ int z_erofs_load_lz4_config(struct super_block *sb,
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
@@ -529,6 +529,8 @@ static inline int z_erofs_load_lz4_config(struct super_block *sb,
 	}
 	return 0;
 }
+static inline void erofs_pcpubuf_init(void) {}
+static inline void erofs_pcpubuf_exit(void) {}
 #endif	/* !CONFIG_EROFS_FS_ZIP */
 
 #ifdef CONFIG_EROFS_FS_ZIP_LZMA
-- 
2.17.1

