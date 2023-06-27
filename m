Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B6C73F7DA
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jun 2023 10:54:26 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=hPvVDcKq;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qqz6S1XnQz30Px
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Jun 2023 18:54:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=hPvVDcKq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::535; helo=mail-pg1-x535.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qqz6L6zStz2yx0
	for <linux-erofs@lists.ozlabs.org>; Tue, 27 Jun 2023 18:54:17 +1000 (AEST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5577900c06bso3219051a12.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 27 Jun 2023 01:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687856055; x=1690448055;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NH/BntW05WLdrOMOrS/q11ukGGFjdgLWoyFNTU8bZn0=;
        b=hPvVDcKqj26g2GYiHAoEdFwUWTwpoEmt9fWQiwBA0CQk2TLkK9v5WYwGnLRA04YHQc
         YOv1E7emziGN8ZZBskvbqCVnEECKCHuo9B+/OEgpK9M65/Y1kNc9ULO6zMzMFJAZF66W
         JbdcCDpx2zuVcEvxXLcnCQRIB4KH934UUssc9JHLXNzavg8HqovSpl39rFhVAGuNsDl2
         gQYIThyM1g2eeb7ZnXyPl6WlonYw3B8BbsyVt3M/TazKZ81Q1F1Z2nLIgVLLfpDSPias
         nNfcTLkie7OubBS7JrVnD4+xfCdvtl7hpnbs3Jnop/gK1nJsa0el8YvZ46Fh4gEiyRCB
         0few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687856055; x=1690448055;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NH/BntW05WLdrOMOrS/q11ukGGFjdgLWoyFNTU8bZn0=;
        b=EETrSdb3PVWuMusuVLJvxF5qkpWPbYmR3RGQ3P47/aXldfb2A6bnfZJ4GduFYg7Y5d
         xMjL4f2yOB/QAIt8YMIsqtr1Vm2la4svSQMEH1yoP4FT0pkwpPPCY7PtT6FfAgj9RZkF
         No41NllhKeIBoTevZk01rFPganJy/03hVu11Lz3cQ+i6j/789HMUxG9pm9Dp2Y7q+6+5
         2l+MdJBLXRglf0dudkowCycQ8ehIiv2C46CLKBEnQVDTeeAlLvjPeHKANia5iixC1S7d
         HclN5oZ4tSSBwyK+ukRodDYEjVTrYiO3hhzSAlihb5eJIC+3mKYP1xGMp24llrW3c3kE
         PP8g==
X-Gm-Message-State: AC+VfDxUqyZBtRq7jv6vI9qteB9c52MrxMyavi/ySMB+1pSMMWfaUpSO
	9ZbbGAqUA7Y8B7xNPw/siOWKZXQUkrE=
X-Google-Smtp-Source: ACHHUZ5Fn8aKK/N2+yj4qjv6WneRsS3RFxjCQ45eyIqoqZJsE38IqCQImdjUYilqYfuHgAfbSqMbQA==
X-Received: by 2002:a05:6a20:548c:b0:123:100e:c8ae with SMTP id i12-20020a056a20548c00b00123100ec8aemr23399301pzk.52.1687856054790;
        Tue, 27 Jun 2023 01:54:14 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id c20-20020a170902c1d400b001b7f95fbec1sm3886491plc.78.2023.06.27.01.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:54:14 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fsck: add support for extracting hard links
Date: Tue, 27 Jun 2023 16:53:32 +0800
Message-Id: <20230627085332.27974-1-zbestahu@gmail.com>
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
Cc: huyue2@coolpad.com, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Yue Hu <huyue2@coolpad.com>

Currently hard links can't be extracted correctly, let's support it now.

Signed-off-by: Yue Hu <huyue2@coolpad.com>
---
 fsck/main.c | 152 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 124 insertions(+), 28 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index f816bec..e78f67c 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -49,6 +49,16 @@ static struct option long_options[] = {
 	{0, 0, 0, 0},
 };
 
+#define NR_HARDLINK_HASHTABLE	16384
+
+struct hardlink_entry {
+	struct list_head list;
+	erofs_nid_t nid;
+	char *path;
+};
+
+static struct list_head hardlink_hashtable[NR_HARDLINK_HASHTABLE];
+
 static void print_available_decompressors(FILE *f, const char *delim)
 {
 	unsigned int i = 0;
@@ -550,6 +560,64 @@ static inline int erofs_extract_dir(struct erofs_inode *inode)
 	return 0;
 }
 
+static char *erofsfsck_hardlink_find(erofs_nid_t nid)
+{
+	struct list_head *head =
+			&hardlink_hashtable[nid % NR_HARDLINK_HASHTABLE];
+	struct hardlink_entry *entry;
+
+	if (list_empty(head))
+		return NULL;
+
+	list_for_each_entry(entry, head, list)
+		if (entry->nid == nid)
+			return entry->path;
+	return NULL;
+}
+
+static int erofsfsck_hardlink_insert(erofs_nid_t nid, const char *path)
+{
+	struct hardlink_entry *entry;
+
+	entry = malloc(sizeof(*entry));
+	if (!entry)
+		return -ENOMEM;
+
+	entry->nid = nid;
+	entry->path = strdup(path);
+	if (!entry->path)
+		return -ENOMEM;
+
+	list_add_tail(&entry->list,
+		      &hardlink_hashtable[nid % NR_HARDLINK_HASHTABLE]);
+	return 0;
+}
+
+static void erofsfsck_hardlink_init(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < NR_HARDLINK_HASHTABLE; ++i)
+		init_list_head(&hardlink_hashtable[i]);
+}
+
+static void erofsfsck_hardlink_exit(void)
+{
+	struct hardlink_entry *entry, *n;
+	struct list_head *head;
+	unsigned int i;
+
+	for (i = 0; i < NR_HARDLINK_HASHTABLE; ++i) {
+		head = &hardlink_hashtable[i];
+
+		list_for_each_entry_safe(entry, n, head, list) {
+			if (entry->path)
+				free(entry->path);
+			free(entry);
+		}
+	}
+}
+
 static inline int erofs_extract_file(struct erofs_inode *inode)
 {
 	bool tryagain = true;
@@ -719,6 +787,57 @@ static int erofsfsck_dirent_iter(struct erofs_dir_context *ctx)
 	return ret;
 }
 
+static int erofsfsck_extract_inode(struct erofs_inode *inode)
+{
+	int ret;
+	char *oldpath;
+
+	if (!fsckcfg.extract_path || erofs_is_packed_inode(inode)) {
+verify:
+		/* verify data chunk layout */
+		return erofs_verify_inode_data(inode, -1);
+	}
+
+	oldpath = erofsfsck_hardlink_find(inode->nid);
+	if (oldpath) {
+		if (link(oldpath, fsckcfg.extract_path) == -1) {
+			erofs_err("failed to extract hard link: %s (%s)",
+				  fsckcfg.extract_path, strerror(errno));
+			return -errno;
+		}
+		return 0;
+	}
+
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFDIR:
+		ret = erofs_extract_dir(inode);
+		break;
+	case S_IFREG:
+		ret = erofs_extract_file(inode);
+		break;
+	case S_IFLNK:
+		ret = erofs_extract_symlink(inode);
+		break;
+	case S_IFCHR:
+	case S_IFBLK:
+	case S_IFIFO:
+	case S_IFSOCK:
+		ret = erofs_extract_special(inode);
+		break;
+	default:
+		/* TODO */
+		goto verify;
+	}
+	if (ret && ret != -ECANCELED)
+		return ret;
+
+	/* record nid and old path for hardlink */
+	if (inode->i_nlink > 1 && !S_ISDIR(inode->i_mode))
+		ret = erofsfsck_hardlink_insert(inode->nid,
+						fsckcfg.extract_path);
+	return ret;
+}
+
 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 {
 	int ret;
@@ -740,34 +859,7 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 	if (ret)
 		goto out;
 
-	if (fsckcfg.extract_path) {
-		switch (inode.i_mode & S_IFMT) {
-		case S_IFDIR:
-			ret = erofs_extract_dir(&inode);
-			break;
-		case S_IFREG:
-			if (erofs_is_packed_inode(&inode))
-				goto verify;
-			ret = erofs_extract_file(&inode);
-			break;
-		case S_IFLNK:
-			ret = erofs_extract_symlink(&inode);
-			break;
-		case S_IFCHR:
-		case S_IFBLK:
-		case S_IFIFO:
-		case S_IFSOCK:
-			ret = erofs_extract_special(&inode);
-			break;
-		default:
-			/* TODO */
-			goto verify;
-		}
-	} else {
-verify:
-		/* verify data chunk layout */
-		ret = erofs_verify_inode_data(&inode, -1);
-	}
+	ret = erofsfsck_extract_inode(&inode);
 	if (ret && ret != -ECANCELED)
 		goto out;
 
@@ -854,6 +946,8 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	erofsfsck_hardlink_init();
+
 	err = erofsfsck_check_inode(sbi.root_nid, sbi.root_nid);
 	if (fsckcfg.corrupted) {
 		if (!fsckcfg.extract_path)
@@ -876,6 +970,8 @@ int main(int argc, char *argv[])
 		}
 	}
 
+	erofsfsck_hardlink_exit();
+
 exit_put_super:
 	erofs_put_super();
 exit_dev_close:
-- 
2.17.1

