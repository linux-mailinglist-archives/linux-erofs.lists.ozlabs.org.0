Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6116C9695B3
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2024 09:35:33 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wycq7145pz2yN8
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2024 17:35:31 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725348928;
	cv=none; b=QpJRofyxa0GcSfmdf0w4pdDSzow5WuX3H7UpeGLvo8f+vQL0lvRc45Uod3X5zkTntWOB73IjMztTinNgmwHy7FIEve21Rk88YkDON1mj2/JLlJFXK+Wk47dhpW5EDDRsmizdYY/Dsik38QiOLl47C7TRj9ApcbNH+WMKPMzLOLVSKJXZOS76SApcGHZZ0jdEsbXpvn8mU+K0qhHQLStMuMS91RxG2SJvC5O23YblP3HzjCG6lGCbt3xiOm5aYyOJQ3fUthJAqPsD333jzuFsyYy9DaNt0CrOjpdod01JaJS78DCqhEg4RBpbocdLKztTf/ZftuhlZXidjTiULMhcnA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725348928; c=relaxed/relaxed;
	bh=O7BRyMp+lq1nuu0SH1Xg9AW4M6rtguWH0B+U8MUvBrE=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=D7i5dZrc4Xqr98p/p75vfJ0nmEeVaUNM7J/X8rkFq7xEICsb8aSyNgM4jQb1BlZByex4aXK8zq00A0Dmj0Fs1s11VkZDVftAtATmfuAx40UUeHteG7OQoa6qXKY6+PEj3lf1/B0KrmHCBH51YI7uIXR8G/sZRfOYJmCkcpMDnnizCkB8QxS+Wj0W+HTNiolQijoiAMa0Mli7bCt+txxhVs4Vp26+pG/+2jhboVViWZ4PjuG/WHVMhEwdtq8JalD9pO0TGfdoI6KhVDrvAxYOb+BawancwL+GGl/zLzTGy9f1e1qUH7niUydto2cWZi5MwSX7HT06h8rX5eV8yCpg+A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UnboN0Qb; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UnboN0Qb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wycq24S7Mz2xQD
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Sep 2024 17:35:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725348919; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=O7BRyMp+lq1nuu0SH1Xg9AW4M6rtguWH0B+U8MUvBrE=;
	b=UnboN0Qb4Qdn6Oxc4f3lt2TaHWQMi1cUkcyh1bSVI2Gk+kYE/v2EFPOEyrvlPnavUEEteAhNt3qpV3u7IWmVhz1NECSsO78pqdCH46Ni69rGcigcAGvOqwYDG8O7HwVCXJMVeD4EyZAUCEz8Spf9KO+Nwrnuqrx5UI9SJ9mPqJI=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WECVRQV_1725348918)
          by smtp.aliyun-inc.com;
          Tue, 03 Sep 2024 15:35:18 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fsck: add --xattr option
Date: Tue,  3 Sep 2024 15:35:17 +0800
Message-ID: <20240903073517.3311407-1-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
attributes of files. This patch adds `--xattr` option to dump the
extended attributes.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
 fsck/main.c | 61 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/fsck/main.c b/fsck/main.c
index 28f1e7e..6a71791 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -9,6 +9,7 @@
 #include <utime.h>
 #include <unistd.h>
 #include <sys/stat.h>
+#include <sys/xattr.h>
 #include "erofs/print.h"
 #include "erofs/compress.h"
 #include "erofs/decompress.h"
@@ -31,6 +32,7 @@ struct erofsfsck_cfg {
 	bool overwrite;
 	bool preserve_owner;
 	bool preserve_perms;
+	bool xattr;
 };
 static struct erofsfsck_cfg fsckcfg;
 
@@ -48,6 +50,7 @@ static struct option long_options[] = {
 	{"no-preserve-owner", no_argument, 0, 10},
 	{"no-preserve-perms", no_argument, 0, 11},
 	{"offset", required_argument, 0, 12},
+	{"xattr", no_argument, 0, 13},
 	{0, 0, 0, 0},
 };
 
@@ -98,6 +101,7 @@ static void usage(int argc, char **argv)
 		" --extract[=X]          check if all files are well encoded, optionally\n"
 		"                        extract to X\n"
 		" --offset=#             skip # bytes at the beginning of IMAGE\n"
+		" --xattr                dump extended attributes\n"
 		"\n"
 		" -a, -A, -y             no-op, for compatibility with fsck of other filesystems\n"
 		"\n"
@@ -225,6 +229,9 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 				return -EINVAL;
 			}
 			break;
+		case 13:
+			fsckcfg.xattr = true;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -411,6 +418,53 @@ out:
 	return ret;
 }
 
+static int erofs_dump_xattr(struct erofs_inode *inode)
+{
+	char *keylst, *key;
+	ssize_t kllen;
+	int ret;
+
+	if (!fsckcfg.extract_path)
+		return 0;
+	kllen = erofs_listxattr(inode, NULL, 0);
+	if (kllen <= 0)
+		return kllen;
+	keylst = malloc(kllen);
+	if (!keylst)
+		return -ENOMEM;
+	ret = erofs_listxattr(inode, keylst, kllen);
+	if (ret < 0)
+		goto out;
+	for (key = keylst; key < keylst + kllen; key += strlen(key) + 1) {
+		void *value = NULL;
+		size_t size = 0;
+
+		ret = erofs_getxattr(inode, key, NULL, 0);
+		if (ret < 0)
+			goto out;
+		if (ret) {
+			size = ret;
+			value = malloc(size);
+			if (!value) {
+				ret = -ENOMEM;
+				goto out;
+			}
+			ret = erofs_getxattr(inode, key, value, size);
+			if (ret < 0) {
+				free(value);
+				goto out;
+			}
+			ret = setxattr(fsckcfg.extract_path, key, value, size, 0);
+			free(value);
+			if (ret)
+				goto out;
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
@@ -909,6 +963,12 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 	if (ret && ret != -ECANCELED)
 		goto out;
 
+	if (fsckcfg.xattr) {
+		ret = erofs_dump_xattr(&inode);
+		if (ret)
+			return ret;
+	}
+
 	/* XXXX: the dir depth should be restricted in order to avoid loops */
 	if (S_ISDIR(inode.i_mode)) {
 		struct erofs_dir_context ctx = {
@@ -955,6 +1015,7 @@ int main(int argc, char *argv[])
 	fsckcfg.overwrite = false;
 	fsckcfg.preserve_owner = fsckcfg.superuser;
 	fsckcfg.preserve_perms = fsckcfg.superuser;
+	fsckcfg.xattr = false;
 
 	err = erofsfsck_parse_options_cfg(argc, argv);
 	if (err) {
-- 
2.43.5

