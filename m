Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F94D646B19
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Dec 2022 09:54:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NSSdH3Pk3z3bjH
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Dec 2022 19:54:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=AFBZd1h5;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=raj.khem@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=AFBZd1h5;
	dkim-atps=neutral
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NSScR0f14z3bjw
	for <linux-erofs@lists.ozlabs.org>; Thu,  8 Dec 2022 19:53:42 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id q17-20020a17090aa01100b002194cba32e9so3985919pjp.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 08 Dec 2022 00:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJCBNdHJZOaV9Vz7eP03zVF14YpB9OyDmXNL9/9F9SI=;
        b=AFBZd1h5a+eh6Z8ASstEOBGKxhnqehAg+9/1AObzAHHXv2fH5kqySFdVdKHv13zN6s
         hacCAAWtnrjKuOX53X7rxuuDrjE3/Bc9pEqKNEeGzJjR0b7O9v0IbwQfZ5Ozz0NzDWVh
         DLTnSfOItUzAYnY9ULQN7I1aINBfv6cx8NILiH616CcNT20C1l616dfrrf9Y6CmjzD1U
         0vJsYs+mHK57Tbi9KLooN4hrUEh0Tjem9kRapFg5AXzU/uopCgSRXS02YR3QO4hh86D5
         qL38zkJWnTccj1DuJVTZ3dDHcqS+xoOLuj3f145gbhhpDqIJSaIj9r80hYXsgb86L0B3
         VV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJCBNdHJZOaV9Vz7eP03zVF14YpB9OyDmXNL9/9F9SI=;
        b=V2VWNXPxpTGgWVtbExL7QXTPHOu89oh5AupihM4j2SJmeWfIPxZ6Csy7l98RWeEkFQ
         emCAh7Yi0x1wxp123gvoT9cR+n4jsfN1i6gl7kP736EtxA8zLrCQrn8zQrWzhTVLwhLt
         FfO7jtAb5k9kdOR8Blej68oDQr8NAo04GhBiK8BKvOTv68Oy+/6fjZIDOpTAykJ0MR38
         LaAKltKyxIGyVjj7yyte8iQMXQElqrog8yBlfqHw+S1wRMcKgu2I5WJlj3D+MFwPtbPn
         q8k4kgCTXBqR7PrINqr/MkFZI0SFnJrvPCu3+6184QR2H7e72GNTRE+fXUrWUSKZaMMO
         dT7A==
X-Gm-Message-State: ANoB5plZIz500DkaKKDiIucx/aizXoezd2KCTWUzI4oBbB5mrNIx5ZEp
	aIKxXWbCdW5capgYYXW+Snw2kuDuc7k=
X-Google-Smtp-Source: AA0mqf5bOFT9te8ICJV3NQsKDlf0vDRN+E+qoOLGNj39TtwTFldfslNB83HCHgTOlxMm2uKq7JrtXw==
X-Received: by 2002:a17:90b:48c9:b0:219:ce72:f480 with SMTP id li9-20020a17090b48c900b00219ce72f480mr1878292pjb.13.1670489620290;
        Thu, 08 Dec 2022 00:53:40 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9181:1cf0::7d9c])
        by smtp.gmail.com with ESMTPSA id k1-20020a17090a7f0100b00205db4ff6dfsm2398392pjl.46.2022.12.08.00.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 00:53:39 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 3/3] erosfs: replace [l]stat64 by equivalent [l]stat
Date: Thu,  8 Dec 2022 00:53:35 -0800
Message-Id: <20221208085335.2884608-3-raj.khem@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221208085335.2884608-1-raj.khem@gmail.com>
References: <20221208085335.2884608-1-raj.khem@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Khem Raj <raj.khem@gmail.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 lib/inode.c | 10 +++++-----
 lib/xattr.c |  4 ++--
 mkfs/main.c |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index f192510..38003fc 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -773,7 +773,7 @@ static u32 erofs_new_encode_dev(dev_t dev)
 
 #ifdef WITH_ANDROID
 int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
-			       struct stat64 *st,
+			       struct stat *st,
 			       const char *path)
 {
 	/* filesystem_config does not preserve file type bits */
@@ -818,7 +818,7 @@ int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 }
 #else
 static int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
-				      struct stat64 *st,
+				      struct stat *st,
 				      const char *path)
 {
 	return 0;
@@ -826,7 +826,7 @@ static int erofs_droid_inode_fsconfig(struct erofs_inode *inode,
 #endif
 
 static int erofs_fill_inode(struct erofs_inode *inode,
-			    struct stat64 *st,
+			    struct stat *st,
 			    const char *path)
 {
 	int err = erofs_droid_inode_fsconfig(inode, st, path);
@@ -910,7 +910,7 @@ static struct erofs_inode *erofs_new_inode(void)
 /* get the inode from the (source) path */
 static struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
 {
-	struct stat64 st;
+	struct stat st;
 	struct erofs_inode *inode;
 	int ret;
 
@@ -918,7 +918,7 @@ static struct erofs_inode *erofs_iget_from_path(const char *path, bool is_src)
 	if (!is_src)
 		return ERR_PTR(-EINVAL);
 
-	ret = lstat64(path, &st);
+	ret = lstat(path, &st);
 	if (ret)
 		return ERR_PTR(-errno);
 
diff --git a/lib/xattr.c b/lib/xattr.c
index 71ffe3e..fd0e728 100644
--- a/lib/xattr.c
+++ b/lib/xattr.c
@@ -467,7 +467,7 @@ static int erofs_count_all_xattrs_from_path(const char *path)
 {
 	int ret;
 	DIR *_dir;
-	struct stat64 st;
+	struct stat st;
 
 	_dir = opendir(path);
 	if (!_dir) {
@@ -502,7 +502,7 @@ static int erofs_count_all_xattrs_from_path(const char *path)
 			goto fail;
 		}
 
-		ret = lstat64(buf, &st);
+		ret = lstat(buf, &st);
 		if (ret) {
 			ret = -errno;
 			goto fail;
diff --git a/mkfs/main.c b/mkfs/main.c
index 0e601d9..ca1ac16 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -582,7 +582,7 @@ int main(int argc, char **argv)
 	struct erofs_buffer_head *sb_bh;
 	struct erofs_inode *root_inode;
 	erofs_nid_t root_nid;
-	struct stat64 st;
+	struct stat st;
 	erofs_blk_t nblocks;
 	struct timeval t;
 	char uuid_str[37] = "not available";
@@ -610,7 +610,7 @@ int main(int argc, char **argv)
 			return 1;
 	}
 
-	err = lstat64(cfg.c_src_path, &st);
+	err = lstat(cfg.c_src_path, &st);
 	if (err)
 		return 1;
 	if (!S_ISDIR(st.st_mode)) {
-- 
2.38.1

