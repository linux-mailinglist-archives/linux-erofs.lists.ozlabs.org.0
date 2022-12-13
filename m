Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7575164B220
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Dec 2022 10:18:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NWXwG2TLPz3bh4
	for <lists+linux-erofs@lfdr.de>; Tue, 13 Dec 2022 20:18:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=YiUTuWbx;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=zbestahu@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=YiUTuWbx;
	dkim-atps=neutral
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NWXw91lFBz3bY0
	for <linux-erofs@lists.ozlabs.org>; Tue, 13 Dec 2022 20:18:00 +1100 (AEDT)
Received: by mail-pj1-x102e.google.com with SMTP id e7-20020a17090a77c700b00216928a3917so2869540pjs.4
        for <linux-erofs@lists.ozlabs.org>; Tue, 13 Dec 2022 01:18:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AlM7+ttnWIA5hW9SWmsTKhtM1CABzvvKuddCfyKleUc=;
        b=YiUTuWbxrvy1KoypF14E+VW51q+8mcpKHBOFEvY9zUcZ8y11u12/HM/JU5/mfspseh
         79UzBaUO2c77tvrlbGMtRifKeDHerQzVvPJxIL5evNxIQT5FI7LiEpLzohqpkV0ik8fE
         byKaQ5UQrvBhCUqNFGOlK0bSZrmGxNWD7ePo/4nkrGDH+aPgXq3hXAytPFAQt2l226Xk
         dZT1dE9OGvQrpek8Hw4PoTgnppguHkX1F5vn/G3eEeQpzZLSZT2J1c7ppzhmcxGuBTNg
         a2tDuV5azk1GVolrIyjPnP1RFDwH32bs9oLUu7x8gvkLn/nTTnt6HVNcTmWOx6fNJ7Cn
         EqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlM7+ttnWIA5hW9SWmsTKhtM1CABzvvKuddCfyKleUc=;
        b=myHv8/IXLF8WDy91gJzwWFXycZ1UUD2F28Arqg4e+lo6jh78+vkWAZmLmfjykoCGBs
         /SkO5xlNFutxAZmzmW8f5vN8YmsRSD2pIEgj3HlnrNeHnbd82UxFJ2qtv9ZopQzoefNr
         HT2RK9kqrPXL8r+1A3iEchKtpeb9jEYrJAsNo+cM43yXBYfgmWeQGlPzX/NiW5HQzY/b
         tgjZPZ1slqNJafsafdAEeRvLuhcKnOnhJZX4+gyUq37qDxhSIAaz5mlzHlsRwSrFj+Wb
         X3RmDaprYhezHq8vqFWekr7H67xdC7JNsYWAkJ3NKEN2aVWk/da6OmeazYHJ+j2lej2d
         vakg==
X-Gm-Message-State: ANoB5pnt+b93nR7jB7dPzDIrHwIfK+SAn7gmL+rxLFLbAZQHLqUOdirh
	TDqRdEkZjWvD9my2wPQpZRvLdJz5aQU=
X-Google-Smtp-Source: AA0mqf4eGZ9FMikwYb9IBEcrQ5MkRTz/neOCwyZbCZrsL1L/6sV3upV0qmCnMYKblVFkPVfNZ3X4Jg==
X-Received: by 2002:a17:902:7104:b0:189:bf5d:c951 with SMTP id a4-20020a170902710400b00189bf5dc951mr18889891pll.26.1670923077956;
        Tue, 13 Dec 2022 01:17:57 -0800 (PST)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id bi12-20020a170902bf0c00b001782398648dsm5886489plb.8.2022.12.13.01.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 01:17:57 -0800 (PST)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: fix fragmentoff overflow for large packed inode
Date: Tue, 13 Dec 2022 17:17:46 +0800
Message-Id: <20221213091746.16683-1-zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, raj.khem@gmail.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

The return value of ftell() is a long int, use ftello{64} instead. Also,
need to return at once if it fails. Meanwhile, use lseek64 for large
file position as well to avoid this error if we have it.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
v2:
- lseek64 -> erofs_lseek64
- remove change in inode.c
- minor commit message update

 configure.ac    |  2 ++
 lib/fragments.c | 33 ++++++++++++++++++++++++++++-----
 2 files changed, 30 insertions(+), 5 deletions(-)

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
index e69ae47..c67c1bb 100644
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
@@ -30,6 +41,12 @@ static struct list_head dupli_frags[FRAGMENT_HASHSIZE];
 static FILE *packedfile;
 const char *frags_packedname = "packed_file";
 
+#ifndef HAVE_LSEEK64
+#define erofs_lseek64 lseek
+#else
+#define erofs_lseek64 lseek64
+#endif
+
 static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
 					 u32 crc)
 {
@@ -53,8 +70,7 @@ static int z_erofs_fragments_dedupe_find(struct erofs_inode *inode, int fd,
 	if (!data)
 		return -ENOMEM;
 
-	ret = lseek(fd, inode->i_size - length, SEEK_SET);
-	if (ret < 0) {
+	if (erofs_lseek64(fd, inode->i_size - length, SEEK_SET) < 0) {
 		ret = -errno;
 		goto out;
 	}
@@ -113,8 +129,7 @@ int z_erofs_fragments_dedupe(struct erofs_inode *inode, int fd, u32 *tofcrc)
 	if (inode->i_size <= EROFS_TOF_HASHLEN)
 		return 0;
 
-	ret = lseek(fd, inode->i_size - EROFS_TOF_HASHLEN, SEEK_SET);
-	if (ret < 0)
+	if (erofs_lseek64(fd, inode->i_size - EROFS_TOF_HASHLEN, SEEK_SET) < 0)
 		return -errno;
 
 	ret = read(fd, data_to_hash, EROFS_TOF_HASHLEN);
@@ -192,9 +207,17 @@ void z_erofs_fragments_commit(struct erofs_inode *inode)
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
-- 
2.17.1

