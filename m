Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF0D648C84
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Dec 2022 03:22:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NTWr464w2z3bgH
	for <lists+linux-erofs@lfdr.de>; Sat, 10 Dec 2022 13:22:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=GyInDtvv;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::436; helo=mail-pf1-x436.google.com; envelope-from=raj.khem@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=GyInDtvv;
	dkim-atps=neutral
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NTWqp4nS7z3bVP
	for <linux-erofs@lists.ozlabs.org>; Sat, 10 Dec 2022 13:22:14 +1100 (AEDT)
Received: by mail-pf1-x436.google.com with SMTP id d82so4935691pfd.11
        for <linux-erofs@lists.ozlabs.org>; Fri, 09 Dec 2022 18:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EJCBNdHJZOaV9Vz7eP03zVF14YpB9OyDmXNL9/9F9SI=;
        b=GyInDtvvMza3FAEnA5JX1cIvZ4hdIUT7MLyzBsYi3hrE+6GUwGzG9E49KmYqocfoxY
         xDt1oRKHAfvunOszsOyc+clnNUJ6sEJa0nKLIBQTXi9WGdX4m2eP+mDvd3w2zz03MDBy
         +RUl+guHkAYoe35V0xf4oKa5o5itJWDg/pEZk8waUTZ14b9geIiNKqamuT/VHapBJYlU
         KvuMsZw4F0PyGq5JmAIO/2aTpE/2xav6MQqD58jtaeXTurMnLKfNt01zdcC9+0C7+GVZ
         PP7Bc7x5sK73wHoIESBcR9DMOEM8RwnBjkqMkgO8cAlbx3VD9nMScdcnKhXdgaKi78Rq
         kXlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EJCBNdHJZOaV9Vz7eP03zVF14YpB9OyDmXNL9/9F9SI=;
        b=8Bzl1zdGdKCMFKslqoZ46X2Kd6nRA0Rv5fyXRgdAys3gSMTRs7M1z1SfXtVHY9bp/N
         2/xiDdBZyKe3bGGLUS0kO0EWaZHhn+e77XNNZWQTsmT7cNcEy1lDUovnhz7g2SU+zy8e
         V2r9FtLuAAhstKEd/lBCgcvGCbv3a0+hAuD9bTD1orUP+GjdH2R/0BDH4auTb/NQm3XM
         SxebKv1mwpaOoWjtDdu6HP+NFgjGWJz+I09XZ5f6HcqUEVBPk/Vvd+mQXpYn2Pc9XhWd
         RCid/P33Qt3G4Ft/8CCmFnqOsYx2ggQeoj7ziu/PUrKNv9epmlHr6E4DBKp9GEp2WK8y
         82+A==
X-Gm-Message-State: ANoB5plqicoxG5jXmbCxcDsj5ApRK1whiVQAkDcRiJgO8SEWl9/zTLL0
	ERfx+E4rXSeTAyESccKuW9w52Cbb0LQ=
X-Google-Smtp-Source: AA0mqf5SU7z4Zq6pO913O/fkFrAb6qH8ULw6Y914nUViqpwLlObR0ikDPoFKyEUzURnONYIu5kvraw==
X-Received: by 2002:a05:6a00:188b:b0:576:9eed:61de with SMTP id x11-20020a056a00188b00b005769eed61demr10267935pfh.4.1670638932017;
        Fri, 09 Dec 2022 18:22:12 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9181:1cf0::7d9c])
        by smtp.gmail.com with ESMTPSA id b64-20020a621b43000000b0056c3a0dc65fsm1814475pfb.71.2022.12.09.18.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 18:22:11 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [[PATCH v2 3/3] erofs: replace [l]stat64 by equivalent [l]stat
Date: Fri,  9 Dec 2022 18:22:07 -0800
Message-Id: <20221210022207.757975-3-raj.khem@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221210022207.757975-1-raj.khem@gmail.com>
References: <20221210022207.757975-1-raj.khem@gmail.com>
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

