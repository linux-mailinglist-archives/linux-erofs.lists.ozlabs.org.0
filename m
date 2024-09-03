Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D203969C08
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2024 13:37:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WykBc6KvWz2yN2
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2024 21:37:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725363460;
	cv=none; b=FWkMqZ2A0wMaWX23QhZByv2adoxevLcMHNQbsbTnzbt1n8gFvdTdF7cL6IC/Rg3klju2azV9AD2016aw24D4FwgUWSQQWrhAxXGKmm31W+Xp70812LGv//Ttq0pjOMjex+3YkbSXQeOiS1cz2QUC7Q83v5LP/M+/6dhItriCRnjxFubtKiHzxbdwdtwcA/xASuBbRKOp6v+gNOdAm+tw1PQBdmLHIQcYehk/1cTLipOCK/HyFVDFSKrZN4RaA2emXvexrR1FwHOOR84g3IHjtT2XPFbrQXZ9CBVmMGi7/CBOZlaHBhVSJZ0bRh5HSLaetnwbAXwxdKwmkgEt68JLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725363460; c=relaxed/relaxed;
	bh=p6MGFU2bUdloocC+laHF6YdbzQQZ4faQSNcS88KYe4M=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=Ztw/4GCORI+ocaXzfFqIPWJh5e+nhH7n+uUCMMrG9+iDVcG8FgCvt6pQG9uE31WvBqj419FR9KVNsK9G+gm2dLt8ZRj4U6wsfl/EiTelqIY2xDhw1NCrhQXf5xHZ+uaPeJPqgpfrtqOou7yJbNTbqomWaO5S91OBoCieyaevKfpYJAKxrdY6nIAqhtQEYPl0M12lwp6hgrCnoyyRmvHahYmV+SsMm48Ob/kE4H5ZBv6tdIzxJzNHMviOOvULgSnoVPkXsbNvptD35EEd1GUGYITKr3YzKtay5TMMu9ipCNx3/Y4aFC08RYm0De8vRtB40JivOji36g7EozalGNsxwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pjNqxsrx; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=pjNqxsrx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WykBV5Kvzz2xbd
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Sep 2024 21:37:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725363452; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=p6MGFU2bUdloocC+laHF6YdbzQQZ4faQSNcS88KYe4M=;
	b=pjNqxsrxedk7WJzqW7VgRWpccCthW3lvmzRFgh6ZpxlGWj7SxmN3XXAXIa4n4fuDWEWPxZ76L/oT+7A1hIPyimnmzLKgPSAabhlH7dqvMPdicfRcnPq8UF0fOhcfa/evbpnE+0+A4uNt4tT6uryQcGSDOMvRtt65B7+BsBqShzg=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WEDBM9e_1725363450)
          by smtp.aliyun-inc.com;
          Tue, 03 Sep 2024 19:37:31 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3] erofs-utils: fsck: introduce xattrs export option
Date: Tue,  3 Sep 2024 19:37:29 +0800
Message-ID: <20240903113729.3539578-1-hongzhen@linux.alibaba.com>
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
attributes of files. This patch adds `--xattrs` option to dump the
extended attributes, as well as the `--no-xattrs` option to not dump
the extended attributes.

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v3: Add error messages and optimize the code.
v2: https://lore.kernel.org/all/20240903085643.3393012-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20240903073517.3311407-1-hongzhen@linux.alibaba.com/
---
 fsck/main.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/fsck/main.c b/fsck/main.c
index 28f1e7e..e1610c8 100644
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
+	bool dump_xattrs;
 };
 static struct erofsfsck_cfg fsckcfg;
 
@@ -48,6 +50,8 @@ static struct option long_options[] = {
 	{"no-preserve-owner", no_argument, 0, 10},
 	{"no-preserve-perms", no_argument, 0, 11},
 	{"offset", required_argument, 0, 12},
+	{"xattrs", no_argument, 0, 13},
+	{"no-xattrs", no_argument, 0, 14},
 	{0, 0, 0, 0},
 };
 
@@ -98,6 +102,8 @@ static void usage(int argc, char **argv)
 		" --extract[=X]          check if all files are well encoded, optionally\n"
 		"                        extract to X\n"
 		" --offset=#             skip # bytes at the beginning of IMAGE\n"
+		" --xattrs               dump extended attributes (default)\n"
+		" --no-xattrs            do not dump extended attributes\n"
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
@@ -411,6 +423,59 @@ out:
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
+	if (ret < 0)
+		goto out;
+	for (key = keylst; key < keylst + kllen; key += strlen(key) + 1) {
+		void *value = NULL;
+		size_t size = 0;
+
+		ret = erofs_getxattr(inode, key, NULL, 0);
+		if (ret < 0)
+			break;
+		if (ret) {
+			size = ret;
+			value = malloc(size);
+			if (!value) {
+				ret = -ENOMEM;
+				erofs_err("fail to malloc for value");
+				break;
+			}
+			ret = erofs_getxattr(inode, key, value, size);
+			if (ret < 0) {
+				erofs_err("fail to get xattr for key %s", key);
+				free(value);
+				break;
+			}
+			if (fsckcfg.extract_path)
+				ret = setxattr(fsckcfg.extract_path, key, value,
+					       size, 0);
+			else
+				ret = 0;
+			free(value);
+			if (ret) {
+				erofs_err("fail to set xattr for key %s", key);
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
@@ -909,6 +974,12 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 	if (ret && ret != -ECANCELED)
 		goto out;
 
+	if (fsckcfg.dump_xattrs) {
+		ret = erofsfsck_dump_xattrs(&inode);
+		if (ret)
+			return ret;
+	}
+
 	/* XXXX: the dir depth should be restricted in order to avoid loops */
 	if (S_ISDIR(inode.i_mode)) {
 		struct erofs_dir_context ctx = {
@@ -955,6 +1026,7 @@ int main(int argc, char *argv[])
 	fsckcfg.overwrite = false;
 	fsckcfg.preserve_owner = fsckcfg.superuser;
 	fsckcfg.preserve_perms = fsckcfg.superuser;
+	fsckcfg.dump_xattrs = true;
 
 	err = erofsfsck_parse_options_cfg(argc, argv);
 	if (err) {
-- 
2.43.5

