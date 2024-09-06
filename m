Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id F110196E7AA
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 04:22:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X0KkK66BPz303B
	for <lists+linux-erofs@lfdr.de>; Fri,  6 Sep 2024 12:22:17 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725589335;
	cv=none; b=XUlMfk3gp46x7mindtpitJ2J5T7izrEA+5XT8V5BNVBqmUYExQunF2lq/E2/XhLDspnNOOTm5ovEbRFiA4Q88+xfclvDpS4+cBQaWia5O65uYy676S3v4OeOKr+hqNXdg7dGtkE6WsFnxiEzGR6Nh9D5PKY44ffh93TltDo3Bb5ft4Gu1fB6hP7g0pR3pJQkxtsEHeHCfw7jyPPr4JnhYseFl8AlbBaBsNkvyuYIIJBS5weWIliRMX0GysKUnk1HzS9o+WQHOWiRIgdYXXPeYRwbzXgPQKQX7YVS2mDonp2wJaaSC72ZuWPrSdHM3eD3e1r10nIy2p/8HG1F2R2kcg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725589335; c=relaxed/relaxed;
	bh=qQfIco2WZImdJiiNUPRx+UCTpTubGsqO8hR2QRn2xlU=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=oNqj/8jKhpaya2e2bLwnwsgwpp8K/uGj8BCzwmH/qTwUP267ujPkBe7T1iGbiEcyNtzOPIAtXz95Oky3wOnTG9f3Ggn/D21+VRTQTfkLxhN1xfDOcdpAg1BK0SEIeyio1lNuKhxLJkfo2mo+Lrmg3vmcQenT7ySqr0Uqy2+har3jBZFEHQHtiEHMz/xizXhjnVGd5j/0Ck9q3gAyg3c1CbFNEk5nwBRNGYUJNIo9xZ/GYvXyXJ9rsHbgC26ZkGvOAK9tBIz7udWVFY6SGZQ0c+fXlEzdfcpPZBZ/3VRRYIb3YqhHRgl43sLKtCxhjFe5zQcTnlEGe59Tvi0QXi3mbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MClLB6e/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MClLB6e/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hongzhen@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X0KkG1Rz2z2yFL
	for <linux-erofs@lists.ozlabs.org>; Fri,  6 Sep 2024 12:22:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725589328; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qQfIco2WZImdJiiNUPRx+UCTpTubGsqO8hR2QRn2xlU=;
	b=MClLB6e/X8n0H0TKKmPqEOAfE1IfXSlMj/C9/3CS0Uplrsc2ulzj94qMLatgJ4wcJy2B1f3RVdvGq8AlteTiXbjNDG/n9t/37JsYTxoFWH+DDKncCtHz6aDdU5Ij2ifIh2GU7A0D8bvsf0Uqbd/iDOtL5W5MEANvRkfTGHNA0WA=
Received: from localhost(mailfrom:hongzhen@linux.alibaba.com fp:SMTPD_---0WENdGkF_1725589327)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 10:22:08 +0800
From: Hongzhen Luo <hongzhen@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v5] erofs-utils: fsck: introduce exporting xattrs
Date: Fri,  6 Sep 2024 10:22:06 +0800
Message-ID: <20240906022206.2725584-1-hongzhen@linux.alibaba.com>
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
v5: Adjust the help information.
v4: https://lore.kernel.org/all/20240905113723.1937634-1-hongzhen@linux.alibaba.com/
v3: https://lore.kernel.org/all/20240903113729.3539578-1-hongzhen@linux.alibaba.com/
v2: https://lore.kernel.org/all/20240903085643.3393012-1-hongzhen@linux.alibaba.com/
v1: https://lore.kernel.org/all/20240903073517.3311407-1-hongzhen@linux.alibaba.com/
---
 fsck/main.c | 82 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 78 insertions(+), 4 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index 28f1e7e..d110cdb 100644
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
 
@@ -98,6 +102,7 @@ static void usage(int argc, char **argv)
 		" --extract[=X]          check if all files are well encoded, optionally\n"
 		"                        extract to X\n"
 		" --offset=#             skip # bytes at the beginning of IMAGE\n"
+		" --[no-]xattrs          whether to dump extended attributes (default on)\n"
 		"\n"
 		" -a, -A, -y             no-op, for compatibility with fsck of other filesystems\n"
 		"\n"
@@ -225,6 +230,12 @@ static int erofsfsck_parse_options_cfg(int argc, char **argv)
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
@@ -411,6 +422,60 @@ out:
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
+				erofs_err("fail to get xattr %s @ nid %llu",
+					  key, inode->nid | 0ULL);
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
@@ -900,15 +965,23 @@ static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
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
@@ -955,6 +1028,7 @@ int main(int argc, char *argv[])
 	fsckcfg.overwrite = false;
 	fsckcfg.preserve_owner = fsckcfg.superuser;
 	fsckcfg.preserve_perms = fsckcfg.superuser;
+	fsckcfg.dump_xattrs = true;
 
 	err = erofsfsck_parse_options_cfg(argc, argv);
 	if (err) {
-- 
2.43.5

