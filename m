Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5728964D81F
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 09:58:54 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NXmP81cBhz3bXj
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 19:58:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Esv/ZQmE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102f; helo=mail-pj1-x102f.google.com; envelope-from=raj.khem@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Esv/ZQmE;
	dkim-atps=neutral
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NXmP44SN8z2x9C
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Dec 2022 19:58:47 +1100 (AEDT)
Received: by mail-pj1-x102f.google.com with SMTP id js9so9797364pjb.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 15 Dec 2022 00:58:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=677Lz0UDEAt8K83Zlx0JZXrqQaOAkX8RHROs3etKXCU=;
        b=Esv/ZQmEKIWmaie1FugxqX4QiSawykhftKbE6tOhPWcW9K0qRZXM8xjbupJo38u7RG
         PU6TlYKrB4uEpidccQnnaKPHaGJ4U5UAua2OX7KOhWURTxk60Mfot1Bt0Db5JpaM+FtR
         Y5Kwgxji7cCr41D/VxC7t10FCEySt/k3IZFVMlHDT03Ht6weUKB61VWuGSy/qMzSggVO
         xt0HlfFc7jyD4D0ptKIIGm+uuil73gpyAyPOgaF3hBA3ov894DlZAPDL6coG+Cxx/bbR
         mrmKVQZj1P83zfyCe6iVwpQvXBfill7UFjxzYXJZZ3zuxkdBVewh0J8ZRKJPeYcSQ7qr
         OeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=677Lz0UDEAt8K83Zlx0JZXrqQaOAkX8RHROs3etKXCU=;
        b=tR1g5FsvGugfss2gtJ8KES3SSFcLhjc44RlymgAq0OIjyI2wwQ+DLJ7jwquC0ZIEAt
         mhHNt7bdBSL/+l40hD93BI9IwwJ8v7I+Onvl2OdDzb4TUsfx7YgsfbRBHZis8djknF/m
         reDXffFa2MlKfPbOznHrkrlw3/fAcm1UEfbXzn48eQOaVhZzIrhTnJeY0iDX8QmbP2wg
         c1yLDsG8GpL0camay8i2Owxufi92sOLinmLpJ5w5KCMXYVom6Q0k12yutRocXfaf9g3P
         jSqjuxTSQQ3Y53/K5sndBJSnWoJT6SPRCNq50NrA2nKagMpswlQRtJfK1PC8hryTBDiK
         w1fg==
X-Gm-Message-State: ANoB5plqiRLmM5tylcmR+cva7KJWb70vMdvh4fvMEuXJQzO8hqnKUfFV
	d+uz/QnSoAZs/IifYGrAgbanQzTP3sE=
X-Google-Smtp-Source: AA0mqf6yiTUY3iy6Pm/VmfcqP4kbK4yzsAqoi2fvakpNh4HXH3XAnIuvIe/QcbBRjLMZWRNvmerQlg==
X-Received: by 2002:a17:902:eccc:b0:189:cb73:75f0 with SMTP id a12-20020a170902eccc00b00189cb7375f0mr37969701plh.8.1671094724992;
        Thu, 15 Dec 2022 00:58:44 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9181:1cf0::7d9c])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902f39500b00186a6b63525sm3247881ple.120.2022.12.15.00.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:58:44 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v4 2/3] erofs: replace [l]stat64 by equivalent [l]stat
Date: Thu, 15 Dec 2022 00:58:41 -0800
Message-Id: <20221215085842.130804-2-raj.khem@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221215085842.130804-1-raj.khem@gmail.com>
References: <20221215085842.130804-1-raj.khem@gmail.com>
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
index d2c9830..5279805 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -581,7 +581,7 @@ int main(int argc, char **argv)
 	struct erofs_buffer_head *sb_bh;
 	struct erofs_inode *root_inode;
 	erofs_nid_t root_nid;
-	struct stat64 st;
+	struct stat st;
 	erofs_blk_t nblocks;
 	struct timeval t;
 	char uuid_str[37] = "not available";
@@ -609,7 +609,7 @@ int main(int argc, char **argv)
 			return 1;
 	}
 
-	err = lstat64(cfg.c_src_path, &st);
+	err = lstat(cfg.c_src_path, &st);
 	if (err)
 		return 1;
 	if (!S_ISDIR(st.st_mode)) {
-- 
2.39.0

