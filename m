Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 202FB476200
	for <lists+linux-erofs@lfdr.de>; Wed, 15 Dec 2021 20:42:35 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JDlyK0bHZz3c8x
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Dec 2021 06:42:33 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JDlyF6wTmz3051
 for <linux-erofs@lists.ozlabs.org>; Thu, 16 Dec 2021 06:42:29 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R991e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=2; SR=0; TI=SMTPD_---0V-kFXdu_1639597321; 
Received: from
 e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V-kFXdu_1639597321) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 16 Dec 2021 03:42:10 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 2/2] erofs-utils: fsck: convert to use erofs_iterate_dir()
Date: Thu, 16 Dec 2021 03:42:00 +0800
Message-Id: <20211215194200.61210-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20211215194200.61210-1-hsiangkao@linux.alibaba.com>
References: <20211215194200.61210-1-hsiangkao@linux.alibaba.com>
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

No need to open code after erofs_iterate_dir() is finalized in
liberofs.

However, there are still some TODOs for fsck:
 - Avoid too deep recursive traversal, sceptically forming a loop;
 - Check link counts at runtime to keep consistency;
 - Check if any ftype / i_mode mismatches.
 - Reuse the same erofs_dir_context to save stack usage.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
v1: https://lore.kernel.org/linux-erofs/20211215085456.90937-1-hsiangkao@linux.alibaba.com/
changes since v1:
 - trivial adaption...

 fsck/main.c | 178 +++++++---------------------------------------------
 1 file changed, 23 insertions(+), 155 deletions(-)

diff --git a/fsck/main.c b/fsck/main.c
index ad48e35..a838275 100644
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
+	return erofsfsck_check_inode(ctx->dir->nid, ctx->de->nid);
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
2.24.4

