Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF5997796F
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Sep 2024 09:21:17 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X4m2348Fpz307K
	for <lists+linux-erofs@lfdr.de>; Fri, 13 Sep 2024 17:21:15 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726212071;
	cv=none; b=g56AhLlLoEZ8/dWAKxKqt3l9twJtpTKhbh4qoPUcHxCAd6Gi7THTjTYqwL00rwPSFNNr1DkerF2u7qtWwLpB4h5YbdjzA3ZkBbE2t/vChTEcMAWrxfo7pCnkSmS2d3SJUG5Gqc57Y6ehYVkCNCJvv00n6v6PBiA3Xhw7skLoTGq18FHFhYEvE3Je4KIA8NGbNbKEZuLswxXVyRkeokq0wwPcf+8sVQvUMVq+h6mi2byGtofssUQ4QEq6b8Tr14X+JVgcwjMKlr40a9TCZ36wVEt+vVoFXVLJ4u4K933B/qnSLOLR8EJRu4anmhjHiBoob2SVFcmuBW7L8KYI9xXnSg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726212071; c=relaxed/relaxed;
	bh=Eoam6yilIHklJ4FfukXGSuwRLashFijqLMFFgRZYJvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1c3IFoh2nTAF0ctIaT91X5UWAuJFz9CnDDEb9pm1V046llxw15pPWleWBSuA9bC7dt2fFxa9dfxAQsiVRJcia9sptfpcbG/jd4fIBRLK0QFhAtP80VLC6XP8FXIB7+8bKDwtl1tnrA2DSRvxeaFwsifE6LYpHhjqIU1jsSRG5yPq6nQQf6VEyMcJk/mfPO5XJ29S03KUu7mQDj7f84+rw10gPmghymzYolRzarHEW7mpt79zJUbVExqPbPja3IVKsMcnRM1YEFyXINY+TvxJB/Fc8bVUhKJMDL10i11ySD8/Cw2AUBRxdT+B7l9jBAx3utBqAykb2Wl8yCxMaGhdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xjUQgWq1; dkim-atps=neutral; spf=pass (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xjUQgWq1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X4m1y28SSz2yZZ
	for <linux-erofs@lists.ozlabs.org>; Fri, 13 Sep 2024 17:21:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726212064; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Eoam6yilIHklJ4FfukXGSuwRLashFijqLMFFgRZYJvo=;
	b=xjUQgWq1f3sKA0zC64ez727OeFzQkD+QoQBrFGoZG6GrYbNs5hGZL6vuCCtKm9e2wjwkABteFCUm3V0b2k9R7c7nb6YZnQfIz7bgvWOQoozrMe95pzv0OSRSxKsg3koVPZ8b6Bq6xq8olVqSgGYWD56pcp2X3xhb4yvh0fG9EoQ=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WEtzAM._1726212062)
          by smtp.aliyun-inc.com;
          Fri, 13 Sep 2024 15:21:03 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v10 2/2] erofs-utils: fsck: introduce exporting xattrs
Date: Fri, 13 Sep 2024 15:21:00 +0800
Message-ID: <20240913072100.577753-2-hongzhen@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240913072100.577753-1-hongzhen@linux.alibaba.com>
References: <20240913072100.577753-1-hongzhen@linux.alibaba.com>
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

Currently `fsck --extract` does not support exporting
extended attributes. This patch adds the `--xattrs` option
to dump extended attributes and the `--no-xattrs` option to
omit them (the default behavior).

Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
---
v10: Added error message when erofs_getxattr() returns <= 0.
v9: https://lore.kernel.org/all/20240913064913.537850-2-hongzhen@linux.alibaba.com/
v8: https://lore.kernel.org/all/20240912131108.3742683-2-hongzhen@linux.alibaba.com/
v7: https://lore.kernel.org/all/20240906095853.3167228-2-hongzhen@linux.alibaba.com/
v6: https://lore.kernel.org/all/20240906083849.3090392-2-hongzhen@linux.alibaba.com/
v5: https://lore.kernel.org/all/20240906022206.2725584-1-hongzhen@linux.alibaba.com/
v4: https://lore.kernel.org/all/20240905113723.1937634-1-hongzhen@linux.alibaba.com/
v3: https://lore.kernel.org/all/20240903113729.3539578-1-hongzhen@linux.alibaba.com/
v2: https://lore.kernel.org/all/20240903085643.3393012-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20240903073517.3311407-1-hongzhen@linux.alibaba.com/
---
 fsck/main.c      | 111 +++++++++++++++++++++++++++++++++++++++++++++--
 man/fsck.erofs.1 |   3 ++
 2 files changed, 110 insertions(+), 4 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 28f1e7e..392318c 100644
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
@@ -411,6 +423,88 @@ out:
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
+		if (ret <= 0) {
+			DBG_BUGON(1);
+			erofs_err("failed to get xattr value size of `%s` @ nid %llu",
+				  key, inode->nid | 0ULL);
+			break;
+		}
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
@@ -900,15 +994,23 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 		goto out;
 	}
 
-	/* verify xattr field */
-	ret = erofs_verify_xattr(&inode);
-	if (ret)
-		goto out;
+	if (!(fsckcfg.check_decomp && fsckcfg.dump_xattrs)) {
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
@@ -955,6 +1057,7 @@ int main(int argc, char *argv[])
 	fsckcfg.overwrite = false;
 	fsckcfg.preserve_owner = fsckcfg.superuser;
 	fsckcfg.preserve_perms = fsckcfg.superuser;
+	fsckcfg.dump_xattrs = false;
 
 	err = erofsfsck_parse_options_cfg(argc, argv);
 	if (err) {
diff --git a/man/fsck.erofs.1 b/man/fsck.erofs.1
index 393ae9e..af0e6ab 100644
--- a/man/fsck.erofs.1
+++ b/man/fsck.erofs.1
@@ -34,6 +34,9 @@ take a long time depending on the image size.
 
 Optionally extract contents of the \fIIMAGE\fR to \fIdirectory\fR.
 .TP
+.BI "--[no-]xattrs"
+Whether to dump extended attributes during extraction (default off).
+.TP
 \fB\-h\fR, \fB\-\-help\fR
 Display help string and exit.
 .TP
-- 
2.43.5

