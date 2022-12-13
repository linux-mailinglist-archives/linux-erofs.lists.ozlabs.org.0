Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E8E64B242
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Dec 2022 10:23:43 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NWY2j0mbHz3bgx
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Dec 2022 20:23:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=a0gaepRC;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::630; helo=mail-pl1-x630.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=a0gaepRC;
	dkim-atps=neutral
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NWY2b0s6gz30QQ
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Dec 2022 20:23:32 +1100 (AEDT)
Received: by mail-pl1-x630.google.com with SMTP id 17so7558674pll.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 13 Dec 2022 01:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUKQRH2E7IyO+7Nd0+q4ItnT7LtVHFeHRMpP7q9oMRA=;
        b=a0gaepRCkAzzHdSt67Q2mqA05UfjZkvj8hQAVBJJOgOGLuxUwVXz6DoOMuL6tE1HV+
         JsydRg39t1P8j0M23r+JGL1y6WAqXE/rwoq1muUbVJwo+Noprv6KAm+q4+rGqbxRf5Ax
         YlhF0RY4oy0GJuvSTFCccXsUhhA2mVALKCVcF/feikSU6aW+VRPwjKM+7LUqMQv2SUeU
         3kJr8ZFsaNfwROWL+hkVo4cAEwhLjUHi2uKkT4ksS3xvQrFJ8/JDi5AhK+nsQRB8JVan
         muLIjkk0tRZNZPbCpzJh7pp0t7GsUgSj3LfrwoFhW3ZrNhNQ43y+qyFmfmL8N1TsVf/2
         4u6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUKQRH2E7IyO+7Nd0+q4ItnT7LtVHFeHRMpP7q9oMRA=;
        b=3FR0J4xwoQdjem8ccEKdMAYh6Vyj8iN/2ROBU1qt+fe10Gt/QgdW7wx8OH86CswQi+
         OuhyAKTo1XxnLQLCjALiPp2smv99mOHloxt4D3JProbXDfcejSm8PMc+9SlhD7xHr6sE
         rXjxYt4DX9i+Ej+cdvdIoFdGRdaEoxMqke2GPbJAUPdJSxdh5SqQiYyyMccVeRKwRNi0
         kxF9/PBNPgdUQbCn70Ydsgg5GBmn7ZUmizKqT2u37R6fwkPbEZBFY2cbNQtGdfNZpD7k
         hLF3Jgtox8ckt8DEoXQ8r3FRDoREChCQLmKbvQw7ZnTngGixDGdrSbU5Rm+Y1Cpj/esi
         XJog==
X-Gm-Message-State: ANoB5pnkwLkbud6edLuGs8k6jeeXB4Hrsk/BtS5zj0KLOBDIYyCRaAZy
	tlsOyZD4cCIW0auWtVRUROHq1Hleras=
X-Google-Smtp-Source: AA0mqf4azMfd5klX7qEZBOSGtEpomSeVtRZ8xvp9J+TIBY1ITbOmJJjuFyO/zROoSYsi2sjZT2WGrw==
X-Received: by 2002:a05:6a20:c991:b0:9d:efbe:a117 with SMTP id gy17-20020a056a20c99100b0009defbea117mr20328916pzb.39.1670923409865;
        Tue, 13 Dec 2022 01:23:29 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id b3-20020a637143000000b0046feb2754e5sm6494346pgn.28.2022.12.13.01.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 01:23:29 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: check the return value of lseek in inode.c
Date: Tue, 13 Dec 2022 17:23:17 +0800
Message-Id: <20221213092317.17236-1-zbestahu@gmail.com>
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
v2: check ret < 0 rather than ret == -1

 lib/inode.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 9de4dec..e675b45 100644
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
+	if (ret < 0)
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
+		if (ret < 0)
+			return ERR_PTR(-errno);
+
 		ret = write_uncompressed_file_from_fd(inode, fd);
 	}
 
-- 
2.17.1

