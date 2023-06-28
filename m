Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1904740850
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jun 2023 04:26:31 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=V9lU33GD;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QrQSP4sBWz30GJ
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Jun 2023 12:26:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=V9lU33GD;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::334; helo=mail-ot1-x334.google.com; envelope-from=zbestahu@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QrQSF2XB2z2xqd
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Jun 2023 12:26:19 +1000 (AEST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6b74791c948so2779234a34.3
        for <linux-erofs@lists.ozlabs.org>; Tue, 27 Jun 2023 19:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687919175; x=1690511175;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neV3rDyVNvPLFT5zcm/IVfNbRAa2DWk2HAJ0sr0tN8c=;
        b=V9lU33GDR1/HNlgKjZ5jEh+J4PxCtNJlOks7idKlec4j8S89l2bfcSx2ZlrqzJI5N4
         v79Q1UFbuNQ1EbghT94P5OeSAEdt7zxKgk/yGg96UL7dvpLtpYBSTFlC3kMn5IA2zIpU
         NTFeV+zTdqB8H1CT3Anw2lmHUZrpoaBzU8FtBuZH7k8VJi0kCN8mrnemJzPyZTW4KXKf
         gB7c53/iLy1qi4SfyfVNxyokJG+0EFvxO1gWn4O2swgzN5x3HauDfTbfj54xoAfwnrBe
         EKdD0v/MKF2AIzWQczpq0SUPLTWlKo9mzBMLH5m9v/0TQZ4h5uNrekJVAR68t8zppVJz
         NbnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687919175; x=1690511175;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neV3rDyVNvPLFT5zcm/IVfNbRAa2DWk2HAJ0sr0tN8c=;
        b=f3HZozi58unX4CSXKmhY7/OurgDkfTVgbAuqqv+LUHHrrGGfu3YyMu/RmK8+Sml++X
         8j/xWaJt98i9xmrgbMK29clGXxqS//3uJ+74uQV+Sd8bJgGi2orvi57PIZML6NBWV5D7
         0lQnZ33LoRUWlJzGA1LlSTgFsvzDrxtXlcTHjoxVD2b2Vkf3CEkMMrrIQSztqGouIGRB
         xPhpfpGw/8oh8SoWsYjpGRUjbknEBT8zAKoFg/QIqV+S3iKstgC5Mljo9dUzQLAQ+loX
         HTa+UVgghzkm36KcnJ8+mqY94SyFoeFs+PhLk2SfZStJPB0S7c3lRYU0Dn6Dj/SfofKy
         ZpoQ==
X-Gm-Message-State: AC+VfDwgAhcagm1njUzbItmzbIwT8JPuMmsLoWVc0Pohs1PTjyNrBzC5
	W4Em4N1kdXYODrAcRKZbyv8vyUoqLdY=
X-Google-Smtp-Source: ACHHUZ6/6cgXDHSg0mjZisiOt62iM4kAvZ7nkEJxL8aaKhYNZO8Yl0EkPN3NFt5jSbMYXHjgdYiVXw==
X-Received: by 2002:a05:6359:d0a:b0:132:7a01:32ac with SMTP id gp10-20020a0563590d0a00b001327a0132acmr16077394rwb.16.1687919175448;
        Tue, 27 Jun 2023 19:26:15 -0700 (PDT)
Received: from localhost.localdomain ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id c11-20020a63da0b000000b0054fa8539681sm6470246pgh.34.2023.06.27.19.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 19:26:15 -0700 (PDT)
From: Yue Hu <zbestahu@gmail.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: fsck: add support for extracting hard links
Date: Wed, 28 Jun 2023 10:25:58 +0800
Message-Id: <20230628022558.6198-1-zbestahu@gmail.com>
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
v2:
 - use new names erofsfsck_hardlink_entry/erofsfsck_link_hashtable
 - remove unneeded list_empty in hardlink_find
 - change to initialize hashtable before verifying packed inode
 - add fsckcfg.extract_path check for hardlink_init/exit

 fsck/main.c | 155 ++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 126 insertions(+), 29 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index f816bec..608635e 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -49,6 +49,16 @@ static struct option long_options[] = {
 	{0, 0, 0, 0},
 };
 
+#define NR_HARDLINK_HASHTABLE	16384
+
+struct erofsfsck_hardlink_entry {
+	struct list_head list;
+	erofs_nid_t nid;
+	char *path;
+};
+
+static struct list_head erofsfsck_link_hashtable[NR_HARDLINK_HASHTABLE];
+
 static void print_available_decompressors(FILE *f, const char *delim)
 {
 	unsigned int i = 0;
@@ -550,6 +560,61 @@ static inline int erofs_extract_dir(struct erofs_inode *inode)
 	return 0;
 }
 
+static char *erofsfsck_hardlink_find(erofs_nid_t nid)
+{
+	struct list_head *head =
+			&erofsfsck_link_hashtable[nid % NR_HARDLINK_HASHTABLE];
+	struct erofsfsck_hardlink_entry *entry;
+
+	list_for_each_entry(entry, head, list)
+		if (entry->nid == nid)
+			return entry->path;
+	return NULL;
+}
+
+static int erofsfsck_hardlink_insert(erofs_nid_t nid, const char *path)
+{
+	struct erofsfsck_hardlink_entry *entry;
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
+		      &erofsfsck_link_hashtable[nid % NR_HARDLINK_HASHTABLE]);
+	return 0;
+}
+
+static void erofsfsck_hardlink_init(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < NR_HARDLINK_HASHTABLE; ++i)
+		init_list_head(&erofsfsck_link_hashtable[i]);
+}
+
+static void erofsfsck_hardlink_exit(void)
+{
+	struct erofsfsck_hardlink_entry *entry, *n;
+	struct list_head *head;
+	unsigned int i;
+
+	for (i = 0; i < NR_HARDLINK_HASHTABLE; ++i) {
+		head = &erofsfsck_link_hashtable[i];
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
@@ -719,6 +784,59 @@ static int erofsfsck_dirent_iter(struct erofs_dir_context *ctx)
 	return ret;
 }
 
+static int erofsfsck_extract_inode(struct erofs_inode *inode)
+{
+	int ret;
+	char *oldpath;
+
+	if (!fsckcfg.extract_path) {
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
+		if (erofs_is_packed_inode(inode))
+			goto verify;
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
@@ -740,34 +858,7 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
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
 
@@ -846,11 +937,14 @@ int main(int argc, char *argv[])
 		goto exit_put_super;
 	}
 
+	if (fsckcfg.extract_path)
+		erofsfsck_hardlink_init();
+
 	if (erofs_sb_has_fragments() && sbi.packed_nid > 0) {
 		err = erofsfsck_check_inode(sbi.packed_nid, sbi.packed_nid);
 		if (err) {
 			erofs_err("failed to verify packed file");
-			goto exit_put_super;
+			goto exit_hardlink;
 		}
 	}
 
@@ -876,6 +970,9 @@ int main(int argc, char *argv[])
 		}
 	}
 
+exit_hardlink:
+	if (fsckcfg.extract_path)
+		erofsfsck_hardlink_exit();
 exit_put_super:
 	erofs_put_super();
 exit_dev_close:
-- 
2.17.1

