Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB05D650990
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Dec 2022 10:51:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NbFMt2cfTz3c6P
	for <lists+linux-erofs@lfdr.de>; Mon, 19 Dec 2022 20:51:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=oOwBgBxT;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62e; helo=mail-pl1-x62e.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=oOwBgBxT;
	dkim-atps=neutral
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NbFMl3Sd0z30Qt
	for <linux-erofs@lists.ozlabs.org>; Mon, 19 Dec 2022 20:51:13 +1100 (AEDT)
Received: by mail-pl1-x62e.google.com with SMTP id d15so8493195pls.6
        for <linux-erofs@lists.ozlabs.org>; Mon, 19 Dec 2022 01:51:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZslaOiy6Kh7Q6Q4+7JLqKcIcIzJn9gZmaGbsJ53aiI=;
        b=oOwBgBxTFa1xAbupZI4l6eYEH94qCS9WG60ewosaNYCnIdm//vlxhVef4wVeBHnQXB
         6nUMwEKv+jUcy8je3aOF2UWt8tEdJ/HORv/zjqqEjox7x1QAsAT3w0LHMIps3hUIs3oj
         rcUcY8tALxmjWDo5hIX2kS7eC1bxX5nUfssym14YmupkdtzludAL0c3/Yb2uY2y6G2b/
         lGwky8G/hGBVX9Jz3slb5LgD11u9S7uNSGqDnQZ2zGMvL6qIgZs+Qt/Amno0xo3uVg3k
         KlAMBwa4+pJPMGANDGi0Fk/QP7KpbHH4mAdaH2VoI2HfMJUB07IHeECp4T0Y8Ump84pB
         OsCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZslaOiy6Kh7Q6Q4+7JLqKcIcIzJn9gZmaGbsJ53aiI=;
        b=vs6ASe7f1A41iYXff0Oxzh9z5vEA+PzQ5jXfjDK50C+bcdUwHbnvgV7jdM/qZNbr1T
         2rEE9BbF+g3ttX/mn0tUf9Rma9+NzzqjHe7ATN23iJFzpVGtYZ1TZtK35VSd/wDHt0pV
         B5aCz7RL9SNuIIh6p+lpnyX7PNFz4Sr8U4m6gK6KCSN3qlvvZ7JAyYtl7E3aLKwunDe2
         7uI9Wvai1xTC+SgDe/C6EMiy50u4IzBpScHw29NPWwI5bt6FsGTSihJauZHPCjbYJdpW
         f0F7Oi7N7LkFjRSntytkCGzhh/isVdmYJpI9Dp6pEM4gNJLVjDvaIdhV4lvh4/OauxCm
         4WrA==
X-Gm-Message-State: AFqh2kokoy5LwgT07tE+BWuqszaQya+13mr3aNhe3wdt3FR4m/lh1Um6
	U7IGFFotE/nsg8XhtU7Tlcy4/f+bKMU=
X-Google-Smtp-Source: AMrXdXuN4aYRUag3qd2uJtE0eHRoXOGbvYiY+hNz1KNgjJY3x5NNMuJmlvvfsSpDv35ht4EcwqwYdQ==
X-Received: by 2002:a17:902:9895:b0:189:340c:20d2 with SMTP id s21-20020a170902989500b00189340c20d2mr9130428plp.23.1671443468882;
        Mon, 19 Dec 2022 01:51:08 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b00188f6cbd950sm6635351plg.226.2022.12.19.01.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 01:51:08 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [RFC PATCH 1/2] erofs-utils: dump: cleanup update_file_size_statatics()
Date: Mon, 19 Dec 2022 17:50:52 +0800
Message-Id: <0e4797ef5f22ac3c2134aa4b005c489c233d2eec.1671443064.git.huyue2@coolpad.com>
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

The statistic update of occupied_size is the same as original size.
Also, correct naming to update_file_size_statistics().

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 dump/main.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/dump/main.c b/dump/main.c
index 93dce8b..bc4f047 100644
--- a/dump/main.c
+++ b/dump/main.c
@@ -225,36 +225,23 @@ static void inc_file_extension_count(const char *dname, unsigned int len)
 	++stats.file_type_stat[type];
 }
 
-static void update_file_size_statatics(erofs_off_t occupied_size,
-		erofs_off_t original_size)
+static void update_file_size_statistics(erofs_off_t size, bool original)
 {
-	int occupied_size_mark, original_size_mark;
+	unsigned int *file_size = original ? stats.file_original_size :
+				  stats.file_comp_size;
+	int size_mark = 0;
 
-	original_size_mark = 0;
-	occupied_size_mark = 0;
-	occupied_size >>= 10;
-	original_size >>= 10;
+	size >>= 10;
 
-	while (occupied_size || original_size) {
-		if (occupied_size) {
-			occupied_size >>= 1;
-			occupied_size_mark++;
-		}
-		if (original_size) {
-			original_size >>= 1;
-			original_size_mark++;
-		}
+	while (size) {
+		size >>= 1;
+		size_mark++;
 	}
 
-	if (original_size_mark >= FILE_MAX_SIZE_BITS)
-		stats.file_original_size[FILE_MAX_SIZE_BITS]++;
-	else
-		stats.file_original_size[original_size_mark]++;
-
-	if (occupied_size_mark >= FILE_MAX_SIZE_BITS)
-		stats.file_comp_size[FILE_MAX_SIZE_BITS]++;
+	if (size_mark >= FILE_MAX_SIZE_BITS)
+		file_size[FILE_MAX_SIZE_BITS]++;
 	else
-		stats.file_comp_size[occupied_size_mark]++;
+		file_size[size_mark]++;
 }
 
 static int erofsdump_ls_dirent_iter(struct erofs_dir_context *ctx)
@@ -301,7 +288,8 @@ static int erofsdump_readdir(struct erofs_dir_context *ctx)
 		stats.files_total_origin_size += vi.i_size;
 		inc_file_extension_count(ctx->dname, ctx->de_namelen);
 		stats.files_total_size += occupied_size;
-		update_file_size_statatics(occupied_size, vi.i_size);
+		update_file_size_statistics(vi.i_size, true);
+		update_file_size_statistics(occupied_size, false);
 	}
 
 	/* XXXX: the dir depth should be restricted in order to avoid loops */
-- 
2.17.1

