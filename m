Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D58B64B048
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Dec 2022 08:17:41 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NWVFG6ktFz3bfN
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Dec 2022 18:17:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=iQeJxbrW;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=iQeJxbrW;
	dkim-atps=neutral
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NWVF64FsPz3bfN
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Dec 2022 18:17:29 +1100 (AEDT)
Received: by mail-pj1-x1034.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso2626071pjh.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 12 Dec 2022 23:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sZqLETZEG2COaSOXGaq4xFJGoz6L2Tl0QF7dcJg2rU=;
        b=iQeJxbrW4KcPM04HwpKoHkWTnuxwaUXUDuXTXZXULrhwNO3BOv9gw3aug+A4ZsZFBk
         pm+2cIf+N7kBUng3DqTlFmjpU4iXPdy14RvZ4H/o45gjKgj1JviSc1o59Wk4BSDevhct
         QgJAqIIhEDVhr9nzAQn2hkxw59ytQn2a4bZPn7bMmZLpCigjvrQ2eWr9nYCEdgkATXUy
         ElPpyTr5j77d0pauLk8vDL9iD6buzzLCEMzYS6HZ1ujoXpsQfSvoYyKYBHtvhWfhU3RS
         8ZOtLqyFg00xf6B5XiD7KtV44H+7zwBN9cnlMvP7+MVxSD4jGgM/eNw/FsjEWf5eQhxb
         /aLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sZqLETZEG2COaSOXGaq4xFJGoz6L2Tl0QF7dcJg2rU=;
        b=UDU31cEx03zAfAPQr1Gwu9H+hgR0xiQbcwBeOKOvKBP4+haD/6DLKCPdOftRFIJmJ0
         LvnQwY/qh9pFcg3H+fWISoMvWsygwFXUVkXIL0i+CLg0q8vtAMZWW8GgYKDz5/NGTto3
         fcVevheelKqtzGgYZXAhMfWoAGzoqJXCl9jqww0nS1bH33eV3nQs8Rd7DfJq07rUa8CU
         od1E//sU70ZUz2d6+DYq5fQ5eZKiTKNfis5KErVUyIAKp0VX56yRlqHhHselWpA2a1NF
         eYQbTv+S0CKljGsSHN2NluKDP8Ajcr4R3adzgl6ldFMRUmdNsioowJHgvSk7Dhx5YhUs
         rV1Q==
X-Gm-Message-State: ANoB5pnRmzRo/rAUexOTer9ovTQE3jewrN51OJ029k+1AFDsrgzIZdmq
	EwYeMYA2xmkR5i5ihwlk5DKEOppUaSY=
X-Google-Smtp-Source: AA0mqf4/9MH/pPV8MCmZooaS0xsVrJY992ppd6xPMLA3+pmElbFbELHm5JjZRdSW6rHqNYQJBCKzcg==
X-Received: by 2002:a17:90a:f598:b0:218:f15f:4b41 with SMTP id ct24-20020a17090af59800b00218f15f4b41mr19738735pjb.27.1670915845021;
        Mon, 12 Dec 2022 23:17:25 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id js3-20020a17090b148300b002135a57029dsm6545859pjb.29.2022.12.12.23.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 23:17:24 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix fragmentoff overflow for large packed inode
Date: Tue, 13 Dec 2022 15:16:43 +0800
Message-Id: <20221213071643.11874-1-zbestahu@gmail.com>
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

The return value of ftell() is a long int, use ftello{64} instead. Also,
use lseek64 for large file position to avoid this error if we have it.
And need to return at once if they fail.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 configure.ac    |  2 ++
 lib/fragments.c | 34 +++++++++++++++++++++++++++++-----
 lib/inode.c     |  9 +++++++--
 3 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index a736ff0..5c9666a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -190,6 +190,8 @@ AC_CHECK_FUNCS(m4_flatten([
 	llistxattr
 	memset
 	realpath
+	lseek64
+	ftello64
 	pread64
 	pwrite64
 	strdup
diff --git a/lib/fragments.c b/lib/fragments.c
index e69ae47..4302cd5 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -3,7 +3,18 @@
  * Copyright (C), 2022, Coolpad Group Limited.
  * Created by Yue Hu <huyue2@coolpad.com>
  */
+#ifndef _LARGEFILE_SOURCE
+#define _LARGEFILE_SOURCE
+#endif
+#ifndef _LARGEFILE64_SOURCE
+#define _LARGEFILE64_SOURCE
+#endif
+#ifndef _FILE_OFFSET_BITS
+#define _FILE_OFFSET_BITS 64
+#endif
+#ifndef _GNU_SOURCE
 #define _GNU_SOURCE
+#endif
 #include <stdlib.h>
 #include <unistd.h>
 #include "erofs/err.h"
@@ -30,6 +41,13 @@ static struct list_head dupli_frags[FRAGMENT_HASHSIZE];
 static FILE *packedfile;
 const char *frags_packedname = "packed_file";
 
+#ifndef HAVE_LSEEK64
+static inline off_t lseek64(int fd, u64 offset, int set)
+{
+	return lseek(fd, offset, set);
+}
+#endif
+
 static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
 					 u32 crc)
 {
@@ -53,8 +71,7 @@ static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
 	if (!data)
 		return -ENOMEM;
 
-	ret = lseek(fd, inode->i_size - length, SEEK_SET);
-	if (ret < 0) {
+	if (lseek64(fd, inode->i_size - length, SEEK_SET) < 0) {
 		ret = -errno;
 		goto out;
 	}
@@ -113,8 +130,7 @@ int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *tofcrc)
 	if (inode->i_size <= EROFS_TOF_HASHLEN)
 		return 0;
 
-	ret = lseek(fd, inode->i_size - EROFS_TOF_HASHLEN, SEEK_SET);
-	if (ret < 0)
+	if (lseek64(fd, inode->i_size - EROFS_TOF_HASHLEN, SEEK_SET) < 0)
 		return -errno;
 
 	ret = read(fd, data_to_hash, EROFS_TOF_HASHLEN);
@@ -192,9 +208,17 @@ void z_erofs_fragments_commit(struct erofs_inode *inode)
 int z_erofs_pack_fragments(struct erofs_inode *inode, void *data,
 			   unsigned int len, u32 tofcrc)
 {
+#ifdef HAVE_FTELLO64
+	off64_t offset = ftello64(packedfile);
+#else
+	off_t offset = ftello(packedfile);
+#endif
 	int ret;
 
-	inode->fragmentoff = ftell(packedfile);
+	if (offset < 0)
+		return -errno;
+
+	inode->fragmentoff = (erofs_off_t)offset;
 	inode->fragment_size = len;
 
 	if (fwrite(data, len, 1, packedfile) != 1)
diff --git a/lib/inode.c b/lib/inode.c
index 9de4dec..a8510f3 100644
--- a/lib/inode.c
+++ b/lib/inode.c
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
@@ -1223,7 +1226,9 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 
 	ret = erofs_write_compressed_file(inode, fd);
 	if (ret == -ENOSPC) {
-		lseek(fd, 0, SEEK_SET);
+		ret = lseek(fd, 0, SEEK_SET);
+		if (ret < 0)
+			return ERR_PTR(-errno);
 		ret = write_uncompressed_file_from_fd(inode, fd);
 	}
 
-- 
2.17.1

