Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382E147676F
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Dec 2021 02:29:07 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JDvf901jKz2ynm
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Dec 2021 12:29:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ksYcWHfa;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1;
 helo=ams.source.kernel.org; envelope-from=xiang@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ksYcWHfa; 
 dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JDvf6118Nz2xsG
 for <linux-erofs@lists.ozlabs.org>; Thu, 16 Dec 2021 12:29:02 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 3EDF0B82232;
 Thu, 16 Dec 2021 01:28:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC6CC36AE0;
 Thu, 16 Dec 2021 01:25:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639618138;
 bh=mBYmTbwzGnkIqXjqSoBEpyOBUjmaAkCK9ODTol9iFX4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ksYcWHfaCC5ivhIH/3m6+l78lfww7fwn13O+7dyKnKIMLafmdNA/stCUZq8bhmiUF
 IQptOPzP40Hr3FWq0cBA+GTEmXR2VATvFJmS2erHaFsDIdxlMe2TzjRZbJw5fgjk+H
 KODQPhNpLucGYMDD2OBG1pwfuHgDnC94b3MPqKKeMEIDUcOviE8BRdscgCcbWcdoIC
 D5R0FGMhEhGm1nl6NN9lyeILlzFQ2OBkh9e6y9vlHt7x18DQh1+kv/QLV455NtJ4u5
 8/8H55nrUyZ6dh3dJ0qtG+0rubH097SLxs7pMCCVnGnXZzeUbNDRKKGMnbVUA3NWBe
 jeV4xmJ/NDwxQ==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 2/2] erofs-utils: fsck: convert to use erofs_iterate_dir()
Date: Thu, 16 Dec 2021 09:24:36 +0800
Message-Id: <20211216012436.10111-2-xiang@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211216012436.10111-1-xiang@kernel.org>
References: <20211216012436.10111-1-xiang@kernel.org>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Gao Xiang <hsiangkao@linux.alibaba.com>

No need to open code after erofs_iterate_dir() is finalized in
liberofs.

However, there are still some TODOs for fsck:
 - Avoid too deep recursive traversal, sceptically forming a loop;
 - Check link counts at runtime to keep consistency;
 - Check if any ftype / i_mode mismatches.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fsck/main.c | 178 +++++++---------------------------------------------
 1 file changed, 23 insertions(+), 155 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index ad48e35f587b..038f43badb8f 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -10,8 +10,9 @@
 #include "erofs/print.h"
 #include "erofs/io.h"
 #include "erofs/decompress.h"
+#include "erofs/dir.h"
 
-static void erofs_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
+static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid);
 
 struct erofsfsck_cfg {
 	bool corrupted;
@@ -126,121 +127,6 @@ static int erofs_check_sb_chksum(void)
 	return 0;
 }
 
-static bool check_special_dentry(struct erofs_dirent *de,
-				 unsigned int de_namelen, erofs_nid_t nid,
-				 erofs_nid_t pnid)
-{
-	if (de_namelen == 2 && de->nid != pnid) {
-		erofs_err("wrong parent dir nid(%llu): pnid(%llu) @ nid(%llu)",
-			  de->nid | 0ULL, pnid | 0ULL, nid | 0ULL);
-		return false;
-	}
-
-	if (de_namelen == 1 && de->nid != nid) {
-		erofs_err("wrong current dir nid(%llu) @ nid(%llu)",
-			  de->nid | 0ULL, nid | 0ULL);
-		return false;
-	}
-	return true;
-}
-
-static int traverse_dirents(erofs_nid_t pnid, erofs_nid_t nid,
-			    void *dentry_blk, erofs_blk_t block,
-			    unsigned int next_nameoff, unsigned int maxsize)
-{
-	struct erofs_dirent *de = dentry_blk;
-	const struct erofs_dirent *end = dentry_blk + next_nameoff;
-	unsigned int idx = 0;
-	char *prev_name = NULL, *cur_name = NULL;
-	int ret = 0;
-
-	erofs_dbg("traversing pnid(%llu), nid(%llu)", pnid | 0ULL, nid | 0ULL);
-
-	if (!block && (next_nameoff < 2 * sizeof(struct erofs_dirent))) {
-		erofs_err("too small dirents of size(%d) in nid(%llu)",
-			  next_nameoff, nid | 0ULL);
-		return -EFSCORRUPTED;
-	}
-
-	while (de < end) {
-		const char *de_name;
-		unsigned int de_namelen;
-		unsigned int nameoff;
-
-		nameoff = le16_to_cpu(de->nameoff);
-		de_name = (char *)dentry_blk + nameoff;
-
-		/* the last dirent check */
-		if (de + 1 >= end)
-			de_namelen = strnlen(de_name, maxsize - nameoff);
-		else
-			de_namelen = le16_to_cpu(de[1].nameoff) - nameoff;
-
-		if (prev_name)
-			free(prev_name);
-		prev_name = cur_name;
-		cur_name = strndup(de_name, de_namelen);
-		if (!cur_name) {
-			ret = -ENOMEM;
-			goto out;
-		}
-
-		erofs_dbg("traversed filename(%s)", cur_name);
-
-		/* corrupted entry check */
-		if (nameoff != next_nameoff) {
-			erofs_err("bogus dirent with nameoff(%u): expected(%d) @ nid %llu, block %u, idx %u",
-				  nameoff, next_nameoff, nid | 0ULL,
-				  block, idx);
-			ret = -EFSCORRUPTED;
-			goto out;
-		}
-
-		if (nameoff + de_namelen > maxsize ||
-				de_namelen > EROFS_NAME_LEN) {
-			erofs_err("bogus dirent with namelen(%u) @ nid %llu, block %u, idx %u",
-				  de_namelen, nid | 0ULL, block, idx);
-			ret = -EFSCORRUPTED;
-			goto out;
-		}
-
-		if (prev_name && (strcmp(prev_name, cur_name) >= 0)) {
-			erofs_err("wrong dirent name order @ nid %llu block %u idx %u: prev(%s), cur(%s)",
-				  nid | 0ULL, block, idx,
-				  prev_name, cur_name);
-			ret = -EFSCORRUPTED;
-			goto out;
-		}
-
-		if (is_dot_dotdot(cur_name)) {
-			if (!check_special_dentry(de, de_namelen, nid, pnid)) {
-				ret = -EFSCORRUPTED;
-				goto out;
-			}
-		} else {
-			erofs_check_inode(nid, de->nid);
-		}
-
-		if (fsckcfg.corrupted) {
-			ret = -EFSCORRUPTED;
-			goto out;
-		}
-
-		next_nameoff += de_namelen;
-		++de;
-		++idx;
-	}
-
-out:
-	if (prev_name)
-		free(prev_name);
-	if (cur_name)
-		free(cur_name);
-
-	erofs_dbg("traversing ... done nid(%llu)", nid | 0ULL);
-	return ret;
-}
-
 static int verify_uncompressed_inode(struct erofs_inode *inode)
 {
 	struct erofs_map_blocks map = {
@@ -479,12 +365,18 @@ static int erofs_verify_inode_data(struct erofs_inode *inode)
 	return ret;
 }
 
-static void erofs_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
+static int erofsfsck_chk_dirents(struct erofs_dir_context *ctx)
+{
+	if (ctx->dot_dotdot)
+		return 0;
+
+	return erofsfsck_check_inode(ctx->dir->nid, ctx->de_nid);
+}
+
+static int erofsfsck_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 {
 	int ret;
 	struct erofs_inode inode;
-	char buf[EROFS_BLKSIZ];
-	erofs_off_t offset;
 
 	erofs_dbg("check inode: nid(%llu)", nid | 0ULL);
 
@@ -507,44 +399,21 @@ static void erofs_check_inode(erofs_nid_t pnid, erofs_nid_t nid)
 	if (ret)
 		goto out;
 
-	if ((inode.i_mode & S_IFMT) != S_IFDIR)
-		goto out;
-
-	offset = 0;
-	while (offset < inode.i_size) {
-		erofs_blk_t block = erofs_blknr(offset);
-		erofs_off_t maxsize = min_t(erofs_off_t,
-					inode.i_size - offset, EROFS_BLKSIZ);
-		struct erofs_dirent *de = (void *)buf;
-
-		unsigned int nameoff;
-
-		ret = erofs_pread(&inode, buf, maxsize, offset);
-		if (ret) {
-			erofs_err("I/O error occurred when reading dirents @ nid %llu, block %u: %d",
-				  nid | 0ULL, block, ret);
-			goto out;
-		}
-
-		nameoff = le16_to_cpu(de->nameoff);
-		if (nameoff < sizeof(struct erofs_dirent) ||
-				nameoff >= PAGE_SIZE) {
-			erofs_err("invalid de[0].nameoff %u @ nid %llu block %u: %d",
-				  nameoff, nid | 0ULL, block, ret);
-			ret = -EFSCORRUPTED;
-			goto out;
-		}
-
-		ret = traverse_dirents(pnid, nid, buf, block,
-				       nameoff, maxsize);
-		if (ret)
-			goto out;
+	/* XXXX: the dir depth should be restricted in order to avoid loops */
+	if ((inode.i_mode & S_IFMT) == S_IFDIR) {
+		struct erofs_dir_context ctx = {
+			.flags = EROFS_READDIR_VALID_PNID,
+			.pnid = pnid,
+			.dir = &inode,
+			.cb = erofsfsck_chk_dirents,
+		};
 
-		offset += maxsize;
+		ret = erofs_iterate_dir(&ctx, true);
 	}
 out:
 	if (ret && ret != -EIO)
 		fsckcfg.corrupted = true;
+	return ret;
 }
 
 int main(int argc, char **argv)
@@ -583,12 +452,11 @@ int main(int argc, char **argv)
 		goto exit_dev_close;
 	}
 
-	erofs_check_inode(sbi.root_nid, sbi.root_nid);
-
+	err = erofsfsck_check_inode(sbi.root_nid, sbi.root_nid);
 	if (fsckcfg.corrupted) {
 		erofs_err("Found some filesystem corruption");
 		err = -EFSCORRUPTED;
-	} else {
+	} else if (!err) {
 		erofs_info("No error found");
 		if (fsckcfg.print_comp_ratio) {
 			double comp_ratio =
-- 
2.20.1

