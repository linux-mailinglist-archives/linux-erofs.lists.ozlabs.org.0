Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEF8976A17
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Sep 2024 15:11:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X4HrW5D1Jz2yZN
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Sep 2024 23:11:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726146681;
	cv=none; b=A9lxXn8cVottjVvlvC/TQOOwpOBsAWVj2KQgZCWYw5pSh/7GfYBTV8sqtUTxl5RYUNaEz87pEPpjBwK7kacKsfkeyip7y7PORJbVu1SQLd2x/+uss3fEtX4IsXQEZIP35JZPB4itQV6u8rRsKKGr9TjUCXmHGJZjmFVTigUXTJZlQFb8fy7pMdSRyozeVlYq2q+KXfPumiKhxoQXm9s+gYAnyAdD7c8XbiIULm98owYLqxGP8hPkEQyY5mPiHmIm4Ck5CyNfqKi229dfa/5yR7Aguh7Ht/PakJkyc+5HZoI01I3Yb2tZGEZ6PvIKJ/lcPpGr9J4QnFP2+/9phVfYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726146681; c=relaxed/relaxed;
	bh=7fCQRQwsMoH52DHhFKG/Wb/bJ5r2DvcsUvL3gitxiuk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gtxls4Ho/mv250aua5+0gmKwv3wacowSt1tSPLDq8UiqrsYFzdZyzMQYIOgJfR2WRZ6AbWtx4riZs8xhPr83X8508DSKtWecz1EsbaTtn33tZNyA3Cw2ym1s5iYgrra5iQy2SqkbB7ODi+zkNB4s/27LCfT3x80KcT+HVf1u8GkPHz7sYuNt753NSPZkQDUB+rX5Lcwa7CwWf8sMVZeqBf5lX1ib7MJmtrF9nH9XFHkPuEzdoIZXUVyJSWSv6TQEPbvtNcz1HrBbTfqDRHd1UoknYoHfIQaPekBUMfwN/3pth2ZRYGbnr2pXD7jq+SWFfapUKpSYrmjIWa7utAJCxQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HubyjaHK; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HubyjaHK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X4HrR58Njz2yS0
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Sep 2024 23:11:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726146673; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7fCQRQwsMoH52DHhFKG/Wb/bJ5r2DvcsUvL3gitxiuk=;
	b=HubyjaHK+sG/zY1zGvjfgUnGNbmbRR43tkgd1PolOgBjqQpVhE5es4QKWgpxDGjtpqs97VnuyTbXX0kbBSFF5zNGtZnRpwxhhtaE7Lf02lLidSC3lOHEt0sTC/9jy78aIoBlXO+ht2Vuy1RZe+ElY7Ss1BMh7bnx4JRWqf2lFus=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WErWkDZ_1726146671)
          by smtp.aliyun-inc.com;
          Thu, 12 Sep 2024 21:11:12 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v8 2/2] erofs-utils: fsck: introduce exporting xattrs
Date: Thu, 12 Sep 2024 21:11:08 +0800
Message-ID: <20240912131108.3742683-2-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240912131108.3742683-1-hongzhen@linux.alibaba.com>
References: <20240912131108.3742683-1-hongzhen@linux.alibaba.com>
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
v8: The code has been adjusted to look better.
v7: https://lore.kernel.org/all/20240906095853.3167228-2-hongzhen@linux.alibaba.com/
v6: https://lore.kernel.org/all/20240906083849.3090392-2-hongzhen@linux.alibaba.com/
v5: https://lore.kernel.org/all/20240906022206.2725584-1-hongzhen@linux.alibaba.com/
v4: https://lore.kernel.org/all/20240905113723.1937634-1-hongzhen@linux.alibaba.com/
v3: https://lore.kernel.org/all/20240903113729.3539578-1-hongzhen@linux.alibaba.com/
v2: https://lore.kernel.org/all/20240903085643.3393012-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20240903073517.3311407-1-hongzhen@linux.alibaba.com/
---
 fsck/main.c      | 107 +++++++++++++++++++++++++++++++++++++++++++++--
 man/fsck.erofs.1 |   3 ++
 2 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 28f1e7e..af0c01f 100644
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
+		" --[no-]xattrs          whether to dump extended attributes (default off)\n"
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
@@ -411,6 +423,84 @@ out:
 	return ret;
 }
 
+static int erofsfsck_dump_xattrs(struct erofs_inode *inode)
+{
+	static bool ignore_xattrs = false;
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
+		erofs_err("failed to list xattrs @ nid %llu",
+			  inode->nid | 0ULL);
+		ret = -EINVAL;
+		goto out;
+	}
+	ret = 0;
+	for (key = keylst; key < keylst + kllen; key += strlen(key) + 1) {
+		unsigned int index, len;
+		void *value = NULL;
+		size_t size = 0;
+
+		ret = erofs_getxattr(inode, key, NULL, 0);
+		if (ret <= 0)
+			break;
+		size = ret;
+		value = malloc(size);
+		if (!value) {
+			ret = -ENOMEM;
+			break;
+		}
+		ret = erofs_getxattr(inode, key, value, size);
+		if (ret < 0) {
+			erofs_err("failed to get xattr `%s` @ nid %llu, because of `%s`", key,
+				  inode->nid | 0ULL, erofs_strerror(ret));
+			free(value);
+			break;
+		}
+		if (fsckcfg.extract_path)
+			ret = lsetxattr(fsckcfg.extract_path, key, value, size,
+					0);
+		else
+			ret = 0;
+		free(value);
+		if (ret == -EPERM && !fsckcfg.superuser) {
+			if (__erofs_unlikely(!erofs_xattr_prefix_matches(key,
+					&index, &len))) {
+				erofs_err("failed to match the prefix of `%s` @ nid %llu",
+					  key, inode->nid | 0ULL);
+				ret = -EINVAL;
+				break;
+			}
+			if (index != EROFS_XATTR_INDEX_USER) {
+				if (!ignore_xattrs) {
+					erofs_warn("ignored xattr `%s` @ nid %llu, due to non-superuser",
+						   key, inode->nid | 0ULL);
+					ignore_xattrs = true;
+				}
+				ret = 0;
+				continue;
+			}
+
+		}
+		if (ret) {
+			erofs_err("failed to set xattr `%s` @ nid %llu because of `%s`",
+				  key, inode->nid | 0ULL, erofs_strerror(ret));
+			break;
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
@@ -900,15 +990,23 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
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
@@ -955,6 +1053,7 @@ int main(int argc, char *argv[])
 	fsckcfg.overwrite = false;
 	fsckcfg.preserve_owner = fsckcfg.superuser;
 	fsckcfg.preserve_perms = fsckcfg.superuser;
+	fsckcfg.dump_xattrs = false;
 
 	err = erofsfsck_parse_options_cfg(argc, argv);
 	if (err) {
diff --git a/man/fsck.erofs.1 b/man/fsck.erofs.1
index 393ae9e..fc862e2 100644
--- a/man/fsck.erofs.1
+++ b/man/fsck.erofs.1
@@ -27,6 +27,9 @@ You may give multiple
 .B --device
 options in the correct order.
 .TP
+.BI "--[no-]xattrs"
+Whether to dump extended attributes (default off).
+.TP
 .BI "\-\-extract" "[=directory]"
 Test to extract the whole file system. It scans all inode data, including
 compressed inode data, which leads to more I/O and CPU load, so it might
-- 
2.43.5

