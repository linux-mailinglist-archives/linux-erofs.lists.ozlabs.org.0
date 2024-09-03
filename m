Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E41D9969800
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2024 10:56:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wyfd54ZQmz2yN8
	for <lists+linux-erofs@lfdr.de>; Tue,  3 Sep 2024 18:56:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725353815;
	cv=none; b=WfvELGh12nK9iFToB0Fatu0aNEJw6ijQrZNbnFkb4ChHqZEwGULSIwLZwHp/8cVkj1G8gVw6rbPMQR5gXUH1sWarUY2gyiberK8ANJvcLUBxicnsjNOo3EcoOyuHTJ7NDfJK+E2/Q9XCaxfLgBfMXuj2Aog+zgdnR4fSrxEAz0JdhegM1u4R1L0Wp5z2B13e1u5uLWK4gNwRgz6s2/XexcdoN75Z/OINY6FtQyVmpC5zBYy7VMYYeKkR6iJFpiiwSurvmPaasBYkP4re7ojTdfD9zTWOPSFV10Jpf3On3Ex9+GrPxV62HpJk8KH6hqWt2yOuMS2dGVDCQAIPr/IGZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725353815; c=relaxed/relaxed;
	bh=URgLL4C5RfR6TMnh9C73DHDESeMt3fE5ltYuz+EuLEw=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=epEBOLdTHShCcwCSTeEPM7XSmjwrIuWqLJkFkR4tIaOQoIPGWjwtpKCmAObURZn772wrbzIF50B2AZCyd+S7RG6DueTRsTmkBMKp9bebRMHqFSKJUMQRZFXL0npLKvVl7IhXth9ybXgi3iTm1tUiLwzSymRT/Ip6ArPJIRQvpTEg6YDLAbESsOeo92f36ac1ZDN3z/WKltdCyZh+OzXi0J53Yy8obxBa8jICNudzIZ4HiqR1Du9kA46uWdbFNLef+4+FspDFOY2TxZMH8yoFNbsIaAFaQ8oeUrzVZT1d7IR8rKGOyFxrgs5+jQxaBmaqzqVJrTZV6Yz39bDWzU9d6w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lpmwpTRQ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lpmwpTRQ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wyfd20ct9z2xCW
	for <linux-erofs@lists.ozlabs.org>; Tue,  3 Sep 2024 18:56:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725353806; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=URgLL4C5RfR6TMnh9C73DHDESeMt3fE5ltYuz+EuLEw=;
	b=lpmwpTRQZd+TMeyQS3R82vW+f91bv7hcy1WBE8w5fN+rddU40giHhjNqGU53/3KpeeRdRkP5hraKNhJzu/m1FIDUDaFjOMNkryZLGrvKFKd+P4oETjzY2AkgobUpqwFc12kFt6/7j5mtpfZYkOBln7uRg8qjWEP84g7mmKiIZ+o=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WECh0Eu_1725353804)
          by smtp.aliyun-inc.com;
          Tue, 03 Sep 2024 16:56:45 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs-utils: fsck: add --xattrs and --no-xattrs options
Date: Tue,  3 Sep 2024 16:56:43 +0800
Message-ID: <20240903085643.3393012-1-hongzhen@linux.alibaba.com>
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
v2: In addition to "--xattrs", the option "--no-xattrs" has been added.
v1: https://lore.kernel.org/all/20240903073517.3311407-1-hongzhen@linux.alibaba.com/
---
 fsck/main.c | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/fsck/main.c b/fsck/main.c
index 28f1e7e..273bf73 100644
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
@@ -225,6 +231,16 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
 				return -EINVAL;
 			}
 			break;
+		case 13:
+			if (!fsckcfg.dump_xattrs) {
+				erofs_err("--xattrs conflicts with --no-xattrs");
+				return -EINVAL;
+			}
+			fsckcfg.dump_xattrs = true;
+			break;
+		case 14:
+			fsckcfg.dump_xattrs = false;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -411,6 +427,57 @@ out:
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
+				break;
+			}
+			ret = erofs_getxattr(inode, key, value, size);
+			if (ret < 0) {
+				free(value);
+				break;
+			}
+			if (fsckcfg.extract_path) {
+				ret = setxattr(fsckcfg.extract_path, key, value,
+					       size, 0);
+				if (ret) {
+					free(value);
+					break;
+				}
+			} else
+				ret = 0;
+			free(value);
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
@@ -909,6 +976,12 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
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
@@ -955,6 +1028,7 @@ int main(int argc, char *argv[])
 	fsckcfg.overwrite = false;
 	fsckcfg.preserve_owner = fsckcfg.superuser;
 	fsckcfg.preserve_perms = fsckcfg.superuser;
+	fsckcfg.dump_xattrs= true;
 
 	err = erofsfsck_parse_options_cfg(argc, argv);
 	if (err) {
-- 
2.43.5

