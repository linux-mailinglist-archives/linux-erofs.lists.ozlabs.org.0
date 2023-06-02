Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 766EA71FECD
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 12:18:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QXf970pDSz3dy5
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 20:18:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=G6FLDaij;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=G6FLDaij;
	dkim-atps=neutral
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QXf943hbLz3dtX
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Jun 2023 20:18:30 +1000 (AEST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-256797b5664so874731a91.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 02 Jun 2023 03:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685701107; x=1688293107;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PT390EV2XRvJAM5YUjHztbP6QwvuvI5s2/iVnIdwmR0=;
        b=G6FLDaijw0xTMBTKmTUdWQpvSkSm2ERFAYS3keNdvrtHtIbLnTAUrru8RBlHUMZoYk
         YztTT4lW7dBsKeggTTJguxWZ+WCo2CoEpzxw1ZkwUs/ITIPv506c2aj4s9o5IthOJbfp
         eovDF4QLMsA7HqszywXZAAUF7NZut/XP8mUBAYqCh01ZaVurWG3H/qWhFQ2m9NVSOMu9
         RAGQ2kDbdwuWSAcnR0eXO7ERy95BI2elPzeRkgAipVy1SzB3W9Jq4GQeRnMtjVPQxjgY
         YvNBtvqJCsWoJF1Li2ssTnJPFK5CDz9k5gL4xF1sG1WrOV2BiyK2FvmiN0+PqDXbB29c
         mp/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685701107; x=1688293107;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PT390EV2XRvJAM5YUjHztbP6QwvuvI5s2/iVnIdwmR0=;
        b=KlYZQIY5oRsNA9DJEDyYhSQx9cRXprlv9Z6Y7mWfhrU6KUqz7/J1ffp6+NGLyKL0CU
         EJ+847vDRUc2lE9loNHX+DeV13k0iOW3HEmGuehGSKVUBmbZYch5KmoL15BZC5CgpDJC
         x8KuxrKAOvYL85RQkiiGj1gzRw8TzlwfJdgV4SP9HBrNOnvaN3h1GX7zaNSUV9UWS8Pf
         sdF29al9832JHErGesryQGfXlgLhDSTmkYdwdcH+ek9YAYzeBkQoBVfEH38hnJSYiLY+
         gzW3A39oV2EneGC6zplt3ZqhPCcwgApW1Iv0YXosEpmNpSG9SX+3XQRw9Q2WQl2+ygst
         EHfg==
X-Gm-Message-State: AC+VfDwFGtLExolpZSFnHp35ZYCZTTbW054YFVuhZ+j74etCqXXmpWG8
	SMl21qfT48pMUMcrft1RIl3Vu9s21GE=
X-Google-Smtp-Source: ACHHUZ7CoC0kPoYq06CzH8QBoXqpTDOXoLy3iOUcz00trLLHN1a1wtYwfntFQWoEyZvO7Nbu0Ng6QQ==
X-Received: by 2002:a17:90a:128c:b0:255:dc71:737d with SMTP id g12-20020a17090a128c00b00255dc71737dmr927855pja.43.1685701107288;
        Fri, 02 Jun 2023 03:18:27 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090a390100b00256a4d59bfasm2947046pjb.23.2023.06.02.03.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 03:18:27 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 1/2] erofs-utils: dump: verify packed_nid when reading packed inode
Date: Fri,  2 Jun 2023 18:18:04 +0800
Message-Id: <d755ab1c4eaa634f8822b6ce663c1d1a66aae09c.1685700307.git.huyue2@coolpad.com>
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
Cc: sunshijie@xiaomi.com, huyue2@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Since dedupe feature is also using the same feature bit as fragments.
Meanwhile, add missing dedupe feature to feature_lists[].

Fixes: a6336feefe37 ("erofs-utils: dump: support fragments")
Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 dump/main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index fd1923f..efbc82b 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -99,6 +99,7 @@ static struct erofsdump_feature feature_lists[] = {
 	{ false, EROFS_FEATURE_INCOMPAT_DEVICE_TABLE, "device_table" },
 	{ false, EROFS_FEATURE_INCOMPAT_ZTAILPACKING, "ztailpacking" },
 	{ false, EROFS_FEATURE_INCOMPAT_FRAGMENTS, "fragments" },
+	{ false, EROFS_FEATURE_INCOMPAT_DEDUPE, "dedupe" },
 };
 
 static int erofsdump_readdir(struct erofs_dir_context *ctx);
@@ -273,7 +274,7 @@ static int erofsdump_read_packed_inode(void)
 	erofs_off_t occupied_size = 0;
 	struct erofs_inode vi = { .nid = sbi.packed_nid };
 
-	if (!erofs_sb_has_fragments())
+	if (!(erofs_sb_has_fragments() && sbi.packed_nid > 0))
 		return 0;
 
 	err = erofs_read_inode_from_disk(&vi);
@@ -605,7 +606,7 @@ static void erofsdump_show_superblock(void)
 			sbi.xattr_blkaddr);
 	fprintf(stdout, "Filesystem root nid:                          %llu\n",
 			sbi.root_nid | 0ULL);
-	if (erofs_sb_has_fragments())
+	if (erofs_sb_has_fragments() && sbi.packed_nid > 0)
 		fprintf(stdout, "Filesystem packed nid:                        %llu\n",
 			sbi.packed_nid | 0ULL);
 	fprintf(stdout, "Filesystem inode count:                       %llu\n",
-- 
2.17.1

