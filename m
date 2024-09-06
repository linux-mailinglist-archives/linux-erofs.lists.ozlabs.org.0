Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A028996EE55
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 10:39:09 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X0V5735LCz3bZ6
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 18:39:07 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725611945;
	cv=none; b=bq1FECl89J8iH3ZAI3/nm5sI0tnQKkX2hLNbP7LcbSj4G8OWxc/bTlF779pwKtnYrxAR02EbRvpMf0fKgbtUnlrU6JpHxi6Pl7ysiZDYqvNJvgxJsx6uHXT+vAm1ydvt1zDrr9mkCZNYZDEfd8K+Bpc1OhP4ixIzJ2NKIsdUtW7HQTNfz+coNKhoQPbDDt49guXxa6T2RDRO1p6nZu845REXm9RKjw4MlaMD2pKd91ZkUz75YcHdDu7VoIJ6O3FrGthzGqUMRF5UcFqrlwsFZhC/In5P3cHXNiPg46VE9kR+sr+88EjGnkTzSxOQRK+gGDzQxcku9hPSDQ/2H45whw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725611945; c=relaxed/relaxed;
	bh=9OBNH9/SqCSnnXPwk7xcFRxodFvWpM8Vnb9weNLkKqE=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version; b=odrrXfgaxMZenHLfrQP8Snp5WBysLGvMRLBQuMFNEBBYY0Gq3S81ysfJwIhZoxgau7RxVBkhQFR6TNGXNNCqMWQMJN+j2QjOmyaPHtkbWGdaeNFdDe0cUWGKQuEdplPFJ6+Vm5A9KthF8HLs7MBF6Ew/rOKn0t1nA5/mKZRzdokt0vTgCL1HEV0dTwuwn8WWu3fjw0uXB0kJY09FOMJjmPmrTcZZcOZiyt+Z3Yrb1p8vsiM4t8ASIakDj9X4YLrc/KqdqB3tsdEbzk82mtATUHpeWSg82AdeQFIqkgU3k4noePSTJKxy6n7AZ/dKRGYmx0j33hNyZJZv4i32e2nlRw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vS6+SPZv; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vS6+SPZv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X0V5528N5z2yvj
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Sep 2024 18:39:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725611941; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9OBNH9/SqCSnnXPwk7xcFRxodFvWpM8Vnb9weNLkKqE=;
	b=vS6+SPZvEN1OaAJG+yZiCb58SG2ngPFVAO1ny9jGeCHSY7+HSwNJJvyucwGNxko5tYwWVDh60soTeypcIamob09N/e+agNHuHQtTU1MVoAXcx2JTnvAdye6ZYxeCFkpf9iklyetJAQIjghCYf6iteYUuwmqfGN45ceW/+kr90IY=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WEOxFLI_1725611939)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 16:39:00 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v6 2/2] erofs-utils: fsck: introduce exporting xattrs
Date: Fri,  6 Sep 2024 16:38:49 +0800
Message-ID: <20240906083849.3090392-2-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240906083849.3090392-1-hongzhen@linux.alibaba.com>
References: <20240906083849.3090392-1-hongzhen@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

The current `fsck --extract` does not support exporting the extended
attributes of files. This patch adds `--xattrs` option to dump the
extended attributes, as well as the `--no-xattrs` option to not dump
the extended attributes.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v6:
  - update man/fsck.erofs.1;
  - do not export non-`user.` namespace xattrs when operating
    as a non-privileged user;
  - use lsetxattr() to set xattrs instead of setxattr().

v5: https://lore.kernel.org/all/20240906022206.2725584-1-hongzhen@linux.alibaba.com/
v4: https://lore.kernel.org/all/20240905113723.1937634-1-hongzhen@linux.alibaba.com/
v3: https://lore.kernel.org/all/20240903113729.3539578-1-hongzhen@linux.alibaba.com/
v2: https://lore.kernel.org/all/20240903085643.3393012-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20240903073517.3311407-1-hongzhen@linux.alibaba.com/
---
 fsck/main.c      | 90 +++++++++++++++++++++++++++++++++++++++++++++---
 man/fsck.erofs.1 |  3 ++
 2 files changed, 89 insertions(+), 4 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 28f1e7e..e89c43d 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -9,10 +9,12 @@
 #include <utime.h>
 #include <unistd.h>
 #include <sys/stat.h>
+#include <sys/xattr.h>
 #include "erofs/print.h"
 #include "erofs/compress.h"
 #include "erofs/decompress.h"
 #include "erofs/dir.h"
+#include "erofs/xattr.h"
 #include "../lib/compressor.h"
 
 static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
@@ -31,6 +33,7 @@ struct erofsfsck_cfg {
 	bool overwrite;
 	bool preserve_owner;
 	bool preserve_perms;
+	bool dump_xattrs;
 };
 static struct erofsfsck_cfg fsckcfg;
 
@@ -48,6 +51,8 @@ static struct option long_options[] = {
 	{"no-preserve-owner", no_argument, 0, 10},
 	{"no-preserve-perms", no_argument, 0, 11},
 	{"offset", required_argument, 0, 12},
+	{"xattrs", no_argument, 0, 13},
+	{"no-xattrs", no_argument, 0, 14},
 	{0, 0, 0, 0},
 };
 
@@ -98,6 +103,7 @@ static void usage(int argc, char **argv)
 		" --extract[=X]          check if all files are well encoded, optionally\n"
 		"                        extract to X\n"
 		" --offset=#             skip # bytes at the beginning of IMAGE\n"
+		" --[no-]xattrs          whether to dump extended attributes (default on)\n"
 		"\n"
 		" -a, -A, -y             no-op, for compatibility with fsck of other filesystems\n"
 		"\n"
@@ -225,6 +231,12 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 				return -EINVAL;
 			}
 			break;
+		case 13:
+			fsckcfg.dump_xattrs = true;
+			break;
+		case 14:
+			fsckcfg.dump_xattrs = false;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -411,6 +423,67 @@ out:
 	return ret;
 }
 
+static int erofsfsck_dump_xattrs(struct erofs_inode *inode)
+{
+	char *keylst, *key;
+	ssize_t kllen;
+	int ret;
+
+	kllen = erofs_listxattr(inode, NULL, 0);
+	if (kllen <= 0)
+		return kllen;
+	keylst = malloc(kllen);
+	if (!keylst)
+		return -ENOMEM;
+	ret = erofs_listxattr(inode, keylst, kllen);
+	if (ret != kllen) {
+		ret = -EINVAL;
+		goto out;
+	}
+	ret = 0;
+	for (key = keylst; key < keylst + kllen; key += strlen(key) + 1) {
+		void *value = NULL;
+		size_t size = 0;
+
+		if (!fsckcfg.superuser && erofs_xattr_prefix_index(key)
+		    != EROFS_XATTR_INDEX_USER)
+			continue;
+
+		ret = erofs_getxattr(inode, key, NULL, 0);
+		if (ret < 0)
+			break;
+		if (ret) {
+			size = ret;
+			value = malloc(size);
+			if (!value) {
+				ret = -ENOMEM;
+				break;
+			}
+			ret = erofs_getxattr(inode, key, value, size);
+			if (ret < 0) {
+				erofs_err("fail to get xattr %s @ nid %llu",
+					  key, inode->nid | 0ULL);
+				free(value);
+				break;
+			}
+			if (fsckcfg.extract_path)
+				ret = lsetxattr(fsckcfg.extract_path, key, value,
+						size, 0);
+			else
+				ret = 0;
+			free(value);
+			if (ret) {
+				erofs_err("fail to set xattr %s @ nid %llu",
+					  key, inode->nid | 0ULL);
+				break;
+			}
+		}
+	}
+out:
+	free(keylst);
+	return ret;
+}
+
 static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
 {
 	struct erofs_map_blocks map = {
@@ -900,15 +973,23 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 		goto out;
 	}
 
-	/* verify xattr field */
-	ret = erofs_verify_xattr(&inode);
-	if (ret)
-		goto out;
+	if (!fsckcfg.check_decomp) {
+		/* verify xattr field */
+		ret = erofs_verify_xattr(&inode);
+		if (ret)
+			goto out;
+	}
 
 	ret = erofsfsck_extract_inode(&inode);
 	if (ret && ret != -ECANCELED)
 		goto out;
 
+	if (fsckcfg.check_decomp && fsckcfg.dump_xattrs) {
+		ret = erofsfsck_dump_xattrs(&inode);
+		if (ret)
+			return ret;
+	}
+
 	/* XXXX: the dir depth should be restricted in order to avoid loops */
 	if (S_ISDIR(inode.i_mode)) {
 		struct erofs_dir_context ctx = {
@@ -955,6 +1036,7 @@ int main(int argc, char *argv[])
 	fsckcfg.overwrite = false;
 	fsckcfg.preserve_owner = fsckcfg.superuser;
 	fsckcfg.preserve_perms = fsckcfg.superuser;
+	fsckcfg.dump_xattrs = true;
 
 	err = erofsfsck_parse_options_cfg(argc, argv);
 	if (err) {
diff --git a/man/fsck.erofs.1 b/man/fsck.erofs.1
index 393ae9e..898f48e 100644
--- a/man/fsck.erofs.1
+++ b/man/fsck.erofs.1
@@ -27,6 +27,9 @@ You may give multiple
 .B --device
 options in the correct order.
 .TP
+.BI "--[no-]xattrs"
+Whether to dump extended attributes (default on).
+.TP
 .BI "\-\-extract" "[=directory]"
 Test to extract the whole file system. It scans all inode data, including
 compressed inode data, which leads to more I/O and CPU load, so it might
-- 
2.43.5

