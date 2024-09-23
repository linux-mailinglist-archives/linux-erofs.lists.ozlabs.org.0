Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 447BB97E6D1
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 09:49:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XBwBQ5VVHz2yWK
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Sep 2024 17:49:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1727077787;
	cv=none; b=bCs6HeJqivseZ1i8vM2Z6pdK/PCtREqeggq2wI1Pb0m7Jst2In7/+9VsUMLXqck8yBAmxaSqqcho/IPnaxJFM8aTswZ1a0hTAi7FbI+gD5maTSmKbQgQDl3qaX/lg4qNz8oy1jcgbN6GlubwUVV68x/tyYQobN2X46vYvQnNCjuHG+tbHnutbxdZdC1kWBUjjY3usN6GqgqH2/mrTGqPFupOLcfVmfZjBVUsXpQdgDEWuBQmDqSxj4Whu4atdM9BvZK1UV/+lDx8mOxztJpPnvwD/DKw+PjLzSjdPQAwbj7a8Xkve9LyHQA6DsbVGHVMDSUx4tCoeojJn3Fm36bWPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1727077787; c=relaxed/relaxed;
	bh=qLO3Nj4qAiL63oNUX3KeCO6PkcJXE3W/V0tHhTDbq3k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CS/hNksPxFRdVNZZkVzoVwSJ6g0RUy0RiGyvbYBEi6Io3hDC2W0dkLCvVMxNg3CEOM/MXzTRYSSyRvl7klyQ+9W4HrEK5AUe0dBl2/0T718tWj5RWPaq/B1Ps1du4GCJ7/Hj8nd0SIdxy8BhbcBVYPna5RquAOcMuH3/59bQxkVcXsdUUBGIIqxf9AttUAcJ4I2DDHSoDCNlMY0U95Vx37uDEsA8DhwRFCszhLJ5h1RN1YtZtjln/EgbucO0iNUb44/7sIMn8spLAQ2RdscHBaF3CZztbOrl1A72u1LHL9x1o51cpHaNnY8k/wMVSZF59sfdqsk/0p1YgBUwRlZBVA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WZV3Tt9V; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=WZV3Tt9V;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XBwBH6F52z2yN3
	for <linux-erofs@lists.ozlabs.org>; Mon, 23 Sep 2024 17:49:40 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727077775; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=qLO3Nj4qAiL63oNUX3KeCO6PkcJXE3W/V0tHhTDbq3k=;
	b=WZV3Tt9VX6VpJVqMVn2qAqgHjsFlH618x64OdQxIwSm41xsXXGM5oLzw+GzgaTPTnHjUUVdsF5ar1o23Qbs2PboG0/XWNw4pZD+tkae6kv4LtIu1tqUepladTnPSwYKqH8q0mGhMfnvKsOOHAJrhBHYmLosrO0uUjG1hurFEvmg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFVV3fE_1727077769)
          by smtp.aliyun-inc.com;
          Mon, 23 Sep 2024 15:49:34 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: add `--sort=none`
Date: Mon, 23 Sep 2024 15:49:29 +0800
Message-ID: <20240923074929.2445674-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently, `--tar=f` writes file data twice due to unseekable streams
and EROFS data ordering requirements.  Some use cases may need to avoid
unnecessary data writes for performance and do NOT require a strict
data ordering.

It adds `--sort=none` to address this.  The image is still reproducible;
it simply means no specific file data ordering is implied.

Currently, It comes into effect if `-E^inline_data` is specified and no
compression is applied.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 include/erofs/inode.h |  1 +
 include/erofs/tar.h   |  1 +
 lib/inode.c           | 19 +++++++++----------
 lib/tar.c             | 36 ++++++++++++++++++++++++++++++++++++
 man/mkfs.erofs.1      | 13 ++++++++++++-
 mkfs/main.c           |  6 ++++++
 6 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/include/erofs/inode.h b/include/erofs/inode.h
index 604161c..eb8f45b 100644
--- a/include/erofs/inode.h
+++ b/include/erofs/inode.h
@@ -34,6 +34,7 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
 int erofs_iflush(struct erofs_inode *inode);
 struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 				   const char *name);
+int erofs_allocate_inode_bh_data(struct erofs_inode *inode, erofs_blk_t nblocks);
 bool erofs_dentry_is_wht(struct erofs_sb_info *sbi, struct erofs_dentry *d);
 int erofs_rebuild_dump_tree(struct erofs_inode *dir, bool incremental);
 int erofs_init_empty_dir(struct erofs_inode *dir);
diff --git a/include/erofs/tar.h b/include/erofs/tar.h
index 42fbb00..6981f9e 100644
--- a/include/erofs/tar.h
+++ b/include/erofs/tar.h
@@ -52,6 +52,7 @@ struct erofs_tarfile {
 	u64 offset;
 	bool index_mode, headeronly_mode, rvsp_mode, aufs;
 	bool ddtaridx_mode;
+	bool try_no_reorder;
 };
 
 void erofs_iostream_close(struct erofs_iostream *ios);
diff --git a/lib/inode.c b/lib/inode.c
index bc3cb76..f08f395 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -171,14 +171,12 @@ struct erofs_dentry *erofs_d_alloc(struct erofs_inode *parent,
 	return d;
 }
 
-/* allocate main data for a inode */
-static int __allocate_inode_bh_data(struct erofs_inode *inode,
-				    unsigned long nblocks,
-				    int type)
+/* allocate main data for an inode */
+int erofs_allocate_inode_bh_data(struct erofs_inode *inode, erofs_blk_t nblocks)
 {
 	struct erofs_bufmgr *bmgr = inode->sbi->bmgr;
 	struct erofs_buffer_head *bh;
-	int ret;
+	int ret, type;
 
 	if (!nblocks) {
 		/* it has only tail-end data */
@@ -187,6 +185,7 @@ static int __allocate_inode_bh_data(struct erofs_inode *inode,
 	}
 
 	/* allocate main data buffer */
+	type = S_ISDIR(inode->i_mode) ? DIRA : DATA;
 	bh = erofs_balloc(bmgr, type, erofs_pos(inode->sbi, nblocks), 0, 0);
 	if (IS_ERR(bh))
 		return PTR_ERR(bh);
@@ -431,7 +430,7 @@ static int erofs_write_dir_file(struct erofs_inode *dir)
 	q = used = blkno = 0;
 
 	/* allocate dir main data */
-	ret = __allocate_inode_bh_data(dir, erofs_blknr(sbi, dir->i_size), DIRA);
+	ret = erofs_allocate_inode_bh_data(dir, erofs_blknr(sbi, dir->i_size));
 	if (ret)
 		return ret;
 
@@ -487,7 +486,7 @@ int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
 
 	inode->datalayout = EROFS_INODE_FLAT_INLINE;
 
-	ret = __allocate_inode_bh_data(inode, nblocks, DATA);
+	ret = erofs_allocate_inode_bh_data(inode, nblocks);
 	if (ret)
 		return ret;
 
@@ -514,15 +513,15 @@ static bool erofs_file_is_compressible(struct erofs_inode *inode)
 
 static int write_uncompressed_file_from_fd(struct erofs_inode *inode, int fd)
 {
-	int ret;
+	struct erofs_sb_info *sbi = inode->sbi;
 	erofs_blk_t nblocks, i;
 	unsigned int len;
-	struct erofs_sb_info *sbi = inode->sbi;
+	int ret;
 
 	inode->datalayout = EROFS_INODE_FLAT_INLINE;
 	nblocks = inode->i_size >> sbi->blkszbits;
 
-	ret = __allocate_inode_bh_data(inode, nblocks, DATA);
+	ret = erofs_allocate_inode_bh_data(inode, nblocks);
 	if (ret)
 		return ret;
 
diff --git a/lib/tar.c b/lib/tar.c
index 6d35292..3c56d43 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -586,6 +586,38 @@ void tarerofs_remove_inode(struct erofs_inode *inode)
 	--inode->i_parent->i_nlink;
 }
 
+static int tarerofs_write_uncompressed_file(struct erofs_inode *inode,
+					    struct erofs_tarfile *tar)
+{
+	struct erofs_sb_info *sbi = inode->sbi;
+	erofs_blk_t nblocks;
+	erofs_off_t pos;
+	void *buf;
+	int ret;
+
+	inode->datalayout = EROFS_INODE_FLAT_PLAIN;
+	nblocks = DIV_ROUND_UP(inode->i_size, 1U << sbi->blkszbits);
+
+	ret = erofs_allocate_inode_bh_data(inode, nblocks);
+	if (ret)
+		return ret;
+
+	for (pos = 0; pos < inode->i_size; pos += ret) {
+		ret = erofs_iostream_read(&tar->ios, &buf, inode->i_size - pos);
+		if (ret < 0)
+			break;
+		if (erofs_dev_write(sbi, buf,
+				    erofs_pos(sbi, inode->u.i_blkaddr) + pos,
+				    ret)) {
+			ret = -EIO;
+			break;
+		}
+	}
+	inode->idata_size = 0;
+	inode->datasource = EROFS_INODE_DATA_SOURCE_NONE;
+	return 0;
+}
+
 static int tarerofs_write_file_data(struct erofs_inode *inode,
 				    struct erofs_tarfile *tar)
 {
@@ -1012,6 +1044,10 @@ new_inode:
 				if (!ret && erofs_iostream_lskip(&tar->ios,
 								 inode->i_size))
 					ret = -EIO;
+			} else if (tar->try_no_reorder &&
+				   !cfg.c_compr_opts[0].alg &&
+				   !cfg.c_inline_data) {
+				ret = tarerofs_write_uncompressed_file(inode, tar);
 			} else {
 				ret = tarerofs_write_file_data(inode, tar);
 			}
diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index d599fac..abdd9b9 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -192,7 +192,18 @@ Use extended inodes instead of compact inodes if the file modification time
 would overflow compact inodes. This is the default. Overrides
 .BR --ignore-mtime .
 .TP
-.BI "\-\-tar, \-\-tar="MODE
+.BI "\-\-sort=" MODE
+Inode data sorting order for tarballs as input.
+
+\fIMODE\fR may be one of \fBnone\fR or \fBpath\fR.
+
+\fBnone\fR: No particular data order is specified for the target image to
+avoid unnecessary overhead; Currently, it takes effect if `-E^inline_data` is
+specified and no compression is applied.
+
+\fBpath\fR: Data order strictly follows the tree generation order. (default)
+.TP
+.BI "\-\-tar, \-\-tar=" MODE
 Treat \fISOURCE\fR as a tarball or tarball-like "headerball" rather than as a
 directory.
 
diff --git a/mkfs/main.c b/mkfs/main.c
index 8f1fdbc..d422787 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -84,6 +84,7 @@ static struct option long_options[] = {
 	{"root-xattr-isize", required_argument, NULL, 524},
 	{"mkfs-time", no_argument, NULL, 525},
 	{"all-time", no_argument, NULL, 526},
+	{"sort", required_argument, NULL, 527},
 	{0, 0, 0, 0},
 };
 
@@ -180,6 +181,7 @@ static void usage(int argc, char **argv)
 		" --offset=#            skip # bytes at the beginning of IMAGE.\n"
 		" --root-xattr-isize=#  ensure the inline xattr size of the root directory is # bytes at least\n"
 		" --aufs                replace aufs special files with overlayfs metadata\n"
+		" --sort=<path,none>    data sorting order for tarballs as input (default: path)\n"
 		" --tar=X               generate a full or index-only image from a tarball(-ish) source\n"
 		"                       (X = f|i|headerball; f=full mode, i=index mode,\n"
 		"                                            headerball=file data is omited in the source stream)\n"
@@ -840,6 +842,10 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		case 526:
 			cfg.c_timeinherit = TIMESTAMP_FIXED;
 			break;
+		case 527:
+			if (!strcmp(optarg, "none"))
+				erofstar.try_no_reorder = true;
+			break;
 		case 'V':
 			version();
 			exit(0);
-- 
2.43.5

