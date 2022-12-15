Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E674864D69E
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 07:48:17 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NXjVR0t3lz3c9s
	for <lists+linux-erofs@lfdr.de>; Thu, 15 Dec 2022 17:48:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=GZPohEHI;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=raj.khem@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=GZPohEHI;
	dkim-atps=neutral
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NXjVG2qvwz3bct
	for <linux-erofs@lists.ozlabs.org>; Thu, 15 Dec 2022 17:48:05 +1100 (AEDT)
Received: by mail-pj1-x1032.google.com with SMTP id hd14-20020a17090b458e00b0021909875bccso5441339pjb.1
        for <linux-erofs@lists.ozlabs.org>; Wed, 14 Dec 2022 22:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=677Lz0UDEAt8K83Zlx0JZXrqQaOAkX8RHROs3etKXCU=;
        b=GZPohEHIy1byef5ZP09icmYnzYk1V9GIOQwx1tgMj8iMGGywlW6xpDKq4j5XuwCc0R
         Xrct3VXo1K8kdPLF2LZL416s4guC+eUw1RQ33Ld+nlGsxnaYqZdhRoOBfarKYOjEf1lm
         /1eRhV3KupaLxNXfqBShm0hfrIL3rpWC9sdTGcgE/RQkPnLWbS60OmV1KNzuhRvvSyJV
         rQSIDlxLh1RQGl8CkoHAKH1C+62JPoT7HDdQefjiv8ed9PcSkFKxiqcup9hk24uNzWhm
         bbf/7RRZmK7mLECvPAdyL/TIGJ0iPe4hr7lAtNHC0i7B0PQS1RPtQqoqEYEOdLnRAlA1
         cJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=677Lz0UDEAt8K83Zlx0JZXrqQaOAkX8RHROs3etKXCU=;
        b=6BclwTZXcMdeUe8qET74PyvHs3Q/U7+8UScAtnj4ZwkwU+Bry9Yb1TS43Bhg1Gzr0T
         xuvRM7oEIEVbfqFjbPeU5RA5SX4S6773WbGq9sdyAYcI28DesV8Nk3fNIawWPp9DdqVq
         G4Fu6SMqpur8n9dD+6OAu0nNT7jgnoMKQlY+m9idtSmRDb7O33LlUKtVEkwfJLLuPeTn
         puylJQ7GafOqQAFhPLr4ChgVNBZwsfMUAH06SewZDznjgFtx+ocsJEEh4LSvrnwl75p6
         qa9pT4XBqDSpLJcnVTedDzfvEXiK9MO7l9c1s9nRetdNTWLM+GMPcCH968vVnb2QX9Pb
         Hdww==
X-Gm-Message-State: ANoB5pmie8IBCTWTbNWp07Kq6Mixm/yf578nJ321S0hsbjY5a4avAyx8
	SBDmJBSd+HI9kTCtjuQJ4G3jDmXPcvc=
X-Google-Smtp-Source: AA0mqf4pz3px2ll0FpekJ2nXNFVS7Uv5UqEiK9yhfLUPT1RKeEJ2Hl4aQnm799KMBv+axRHYMHL+oA==
X-Received: by 2002:a05:6a20:9f05:b0:9d:efbf:8170 with SMTP id mk5-20020a056a209f0500b0009defbf8170mr30855152pzb.57.1671086883018;
        Wed, 14 Dec 2022 22:48:03 -0800 (PST)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9181:1cf0::7d9c])
        by smtp.gmail.com with ESMTPSA id c202-20020a621cd3000000b0057524960947sm926689pfc.39.2022.12.14.22.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 22:48:02 -0800 (PST)
From: Khem Raj <raj.khem@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 2/3] erofs: replace [l]stat64 by equivalent [l]stat
Date: Wed, 14 Dec 2022 22:47:57 -0800
Message-Id: <20221215064758.93821-2-raj.khem@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221215064758.93821-1-raj.khem@gmail.com>
References: <20221215064758.93821-1-raj.khem@gmail.com>
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

