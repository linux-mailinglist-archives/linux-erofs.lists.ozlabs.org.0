Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2415971FE08
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 11:38:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QXdH05t4mz3dy4
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Jun 2023 19:38:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=WtJoLwTq;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=WtJoLwTq;
	dkim-atps=neutral
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QXdGt6VdBz2yfg
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Jun 2023 19:38:30 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-530638a60e1so1662040a12.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 02 Jun 2023 02:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685698706; x=1688290706;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fs0Ja80UiXkAbe3BXXHzC2Nr3EUDWT8/KSXk/XuUIM=;
        b=WtJoLwTqPutwvbd/FjfBfAO+1MmKw6/sBOVKatD0ZgfJnhk5hb17Hhgejot8swQYbM
         G73yAG3Yis0hHvP79n5ttVE95KlzbpmqkC1CeNk+38/C8l/SGxOFaac48d9yhgFFwxfR
         QvQoiofYm0KBkQotMQNlarFu6mHod0mpZ2Uu4ivihkQuOjZOS5h2LfyG0eoi+rO6QcXd
         TvyUppKxpT3v3TWGljqAeogJIVCQYuvUFqrZVWm25j64Rs+pfQqlfn4c+S0i2U54d8Z8
         0vFuhv7/GCEp31wtY+kQ0R5cOocckguOcvNqVFBePBCtz/BkkhH0s7T6w9+rP8Ws+TYm
         qHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685698706; x=1688290706;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1fs0Ja80UiXkAbe3BXXHzC2Nr3EUDWT8/KSXk/XuUIM=;
        b=YHop1oq8d2Z1qEO+Ift2ZlL9j1lItCF6WDC6jlgJe4BjyIFJpMJ5Wt5NGe1GI0GIee
         T6ab/WKAPKO01UtXRZ4M4pBgHEne+saJaxzTvfbgDObAcN/HKCcfq6Gg3OBCyswNaul9
         KRDms2DhH3Ze9kGLmB1c0KGz04lDmSouZEpnvtfs449qLKtZ2+X5xbLZmaxWwSi8rDrz
         C24D6nkEUZpdFYuIQCpM9JG/cVE720+nSIRN7z3N1LEo16FgxBWyIzQOLpm33INWU/B5
         0c6kUWIRxE1ValelN5c4zstsltDopjCLnsi8ONOTdWagE5/ioU0ln40h2uY67Jy5CIBS
         GiIg==
X-Gm-Message-State: AC+VfDzQSHNaPHHhEti7rKpQ6BHMzQljKwCMD1W+3DbKD/93MOehOiqg
	VypnxfToOiyKVDukxezoZCQTldGr2es=
X-Google-Smtp-Source: ACHHUZ7LZO85TS89HBzhjtKl/8G0FrHBT+xzG5K0GeCXHLf+Lzx6lo4c7svoNW3UQ8ZmcVE+6ttVxA==
X-Received: by 2002:a17:902:b7c6:b0:1b0:7123:6ee8 with SMTP id v6-20020a170902b7c600b001b071236ee8mr1670548plz.61.1685698705788;
        Fri, 02 Jun 2023 02:38:25 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id n24-20020a170902969800b001a072aedec7sm917210plp.75.2023.06.02.02.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 02:38:25 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: dump: read packed inode only by valid packed_nid
Date: Fri,  2 Jun 2023 17:37:54 +0800
Message-Id: <b07be6197e879b8200b4c25f91957d6a206dc143.1685697802.git.huyue2@coolpad.com>
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
index fd1923f..b9aa0f5 100644
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
+	if (!sbi.packed_nid)
 		return 0;
 
 	err = erofs_read_inode_from_disk(&vi);
@@ -605,7 +606,7 @@ static void erofsdump_show_superblock(void)
 			sbi.xattr_blkaddr);
 	fprintf(stdout, "Filesystem root nid:                          %llu\n",
 			sbi.root_nid | 0ULL);
-	if (erofs_sb_has_fragments())
+	if (sbi.packed_nid > 0)
 		fprintf(stdout, "Filesystem packed nid:                        %llu\n",
 			sbi.packed_nid | 0ULL);
 	fprintf(stdout, "Filesystem inode count:                       %llu\n",
-- 
2.17.1

