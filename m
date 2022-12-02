Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 892F963FE40
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Dec 2022 03:43:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NNchK312xz3bbR
	for <lists+linux-erofs@lfdr.de>; Fri,  2 Dec 2022 13:43:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=koBy20dw;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52b; helo=mail-pg1-x52b.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=koBy20dw;
	dkim-atps=neutral
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NNchD2HD1z2xDv
	for <linux-erofs@lists.ozlabs.org>; Fri,  2 Dec 2022 13:43:39 +1100 (AEDT)
Received: by mail-pg1-x52b.google.com with SMTP id q71so3278164pgq.8
        for <linux-erofs@lists.ozlabs.org>; Thu, 01 Dec 2022 18:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vSeKOYHtmWq1kL3qsfzOs69K8/VAM/Y46p1+vX7A1M=;
        b=koBy20dwmMfxll6tbUYMtzybnY5HHR7RHhrNtLHE+edxZu8befmEVFEdqULkWcsGII
         w5+wgN7oyrce8bkTmFBzp1lVsJ5ffqo1cpK9UmgAStGArwjEN6l52T9HJ96OkrCobnQK
         WPk/eAidG3NqES8afcxGXYcHYfpYW3IFQh9SPjHoXvzlXsxEXDhALubcjtvWEgV3m3NS
         nCPS5rFdh0aqoLjJweJCw+o9SYp9YLtOZoBc8r2Q3Jbc0feaArdWE4hxHcqu95Eh16Nh
         6QHqHj5xojdagLqdboIT1zcwEnNuB7t1M+vYHBXprF+Nf4WMOGkdE1hR4OqGnmHWbwgc
         8KJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vSeKOYHtmWq1kL3qsfzOs69K8/VAM/Y46p1+vX7A1M=;
        b=lvTYCyCq7ZVs2EZUtwcTkjdPoskvnsfXWPHhUA2oEK/aPiR33qyK4PphFW4hoRl8wl
         6X5xjdHbjw1XLQOu43YRPI6DX5BP3SWCs1z/gLCRUlW4XfhcY6Y2+xdeZIYyPBqL8aJB
         nqy6eF49V0IEYY+soqPcfmgjCbqdopacYX3tB0KJG+ergPFVvmb7kihnzg5RLU3R1a9J
         JufhimWXJxOVrPABiOsBb60jAwF5F6sHuvgKjkpRjBRBxsqxgMXj68KXSRnI6LtbUhav
         b8F5s78dTvZLAlbS7OSVlnm9r4+p28IoWieR1luwBQ/W+SDHSNKsnRITT2nblggG088I
         neQQ==
X-Gm-Message-State: ANoB5pmH0Ryo81wO4VAdDetxJWy86ckSs0wB4f4gSBMlwUqM+dgmZ0o4
	iighAtgfDy3KHA7szP6UyC0IBicsCgMv0w==
X-Google-Smtp-Source: AA0mqf5X56cW8lTnDnfsiZakPC6EDjlQxfgca2ie7CQJV/jAr/76qw6FeZJEYU90toeGzTPCGaP8sw==
X-Received: by 2002:a62:3084:0:b0:56d:dd2a:c494 with SMTP id w126-20020a623084000000b0056ddd2ac494mr50161761pfw.76.1669949016065;
        Thu, 01 Dec 2022 18:43:36 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id c14-20020a62f84e000000b0056bc30e618dsm3910810pfm.38.2022.12.01.18.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 18:43:35 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: check the return value of lseek in inode.c
Date: Fri,  2 Dec 2022 10:43:15 +0800
Message-Id: <20221202024315.16138-1-zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Need to check if we got an error. Also, make erofs_write_file() static.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 lib/inode.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 9de4dec..cb2e057 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -406,7 +406,7 @@ static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 	return 0;
 }
 
-int erofs_write_file(struct erofs_inode *inode)
+static int erofs_write_file(struct erofs_inode *inode)
 {
 	int ret, fd;
 
@@ -1196,7 +1196,10 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 	struct erofs_inode *inode;
 	int ret;
 
-	lseek(fd, 0, SEEK_SET);
+	ret = lseek(fd, 0, SEEK_SET);
+	if (ret == -1)
+		return ERR_PTR(-errno);
+
 	ret = fstat64(fd, &st);
 	if (ret)
 		return ERR_PTR(-errno);
@@ -1223,7 +1226,10 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 
 	ret = erofs_write_compressed_file(inode, fd);
 	if (ret == -ENOSPC) {
-		lseek(fd, 0, SEEK_SET);
+		ret = lseek(fd, 0, SEEK_SET);
+		if (ret == -1)
+			return ERR_PTR(-errno);
+
 		ret = write_uncompressed_file_from_fd(inode, fd);
 	}
 
-- 
2.17.1

