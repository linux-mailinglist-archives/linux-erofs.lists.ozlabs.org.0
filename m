Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828897E1F1E
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Nov 2023 12:02:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SP7j23W0Zz3cR4
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Nov 2023 22:02:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=mengferry@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SP7hh2jflz2ygZ
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Nov 2023 22:01:54 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=mengferry@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VvnuJPt_1699268503;
Received: from j66c13357.sqa.eu95.tbsite.net(mailfrom:mengferry@linux.alibaba.com fp:SMTPD_---0VvnuJPt_1699268503)
          by smtp.aliyun-inc.com;
          Mon, 06 Nov 2023 19:01:46 +0800
From: Ferry Meng <mengferry@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: simplify erofs_read_inode()
Date: Mon,  6 Nov 2023 19:01:41 +0800
Message-Id: <20231106110141.94103-1-mengferry@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Cc: Ferry Meng <mengferry@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

After commit 1c7f49a76773 ("erofs: tidy up EROFS on-disk naming"),
there is a unique `union erofs_inode_i_u` so that we could parse
the union directly.

Besides, it also replaces `inode->i_sb` with `sb` for simplicity.

Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
---
 fs/erofs/inode.c | 98 +++++++++++++++++-------------------------------
 1 file changed, 35 insertions(+), 63 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index edc8ec7581b8..99535c8c53b5 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -15,11 +15,11 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_inode *vi = EROFS_I(inode);
 	const erofs_off_t inode_loc = erofs_iloc(inode);
-
 	erofs_blk_t blkaddr, nblks = 0;
 	void *kaddr;
 	struct erofs_inode_compact *dic;
 	struct erofs_inode_extended *die, *copied = NULL;
+	union erofs_inode_i_u *iu;
 	unsigned int ifmt;
 	int err;
 
@@ -35,9 +35,8 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 
 	dic = kaddr + *ofs;
 	ifmt = le16_to_cpu(dic->i_format);
-
 	if (ifmt & ~EROFS_I_ALL) {
-		erofs_err(inode->i_sb, "unsupported i_format %u of nid %llu",
+		erofs_err(sb, "unsupported i_format %u of nid %llu",
 			  ifmt, vi->nid);
 		err = -EOPNOTSUPP;
 		goto err_out;
@@ -45,7 +44,7 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 
 	vi->datalayout = erofs_inode_datalayout(ifmt);
 	if (vi->datalayout >= EROFS_INODE_DATALAYOUT_MAX) {
-		erofs_err(inode->i_sb, "unsupported datalayout %u of nid %llu",
+		erofs_err(sb, "unsupported datalayout %u of nid %llu",
 			  vi->datalayout, vi->nid);
 		err = -EOPNOTSUPP;
 		goto err_out;
@@ -82,40 +81,15 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
 
 		inode->i_mode = le16_to_cpu(die->i_mode);
-		switch (inode->i_mode & S_IFMT) {
-		case S_IFREG:
-		case S_IFDIR:
-		case S_IFLNK:
-			vi->raw_blkaddr = le32_to_cpu(die->i_u.raw_blkaddr);
-			break;
-		case S_IFCHR:
-		case S_IFBLK:
-			inode->i_rdev =
-				new_decode_dev(le32_to_cpu(die->i_u.rdev));
-			break;
-		case S_IFIFO:
-		case S_IFSOCK:
-			inode->i_rdev = 0;
-			break;
-		default:
-			goto bogusimode;
-		}
+		iu = &die->i_u;
 		i_uid_write(inode, le32_to_cpu(die->i_uid));
 		i_gid_write(inode, le32_to_cpu(die->i_gid));
 		set_nlink(inode, le32_to_cpu(die->i_nlink));
-
-		/* extended inode has its own timestamp */
+		/* each extended inode has its own timestamp */
 		inode_set_ctime(inode, le64_to_cpu(die->i_mtime),
 				le32_to_cpu(die->i_mtime_nsec));
 
 		inode->i_size = le64_to_cpu(die->i_size);
-
-		/* total blocks for compressed files */
-		if (erofs_inode_is_data_compressed(vi->datalayout))
-			nblks = le32_to_cpu(die->i_u.compressed_blocks);
-		else if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
-			/* fill chunked inode summary info */
-			vi->chunkformat = le16_to_cpu(die->i_u.c.format);
 		kfree(copied);
 		copied = NULL;
 		break;
@@ -125,49 +99,51 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		vi->xattr_isize = erofs_xattr_ibody_size(dic->i_xattr_icount);
 
 		inode->i_mode = le16_to_cpu(dic->i_mode);
-		switch (inode->i_mode & S_IFMT) {
-		case S_IFREG:
-		case S_IFDIR:
-		case S_IFLNK:
-			vi->raw_blkaddr = le32_to_cpu(dic->i_u.raw_blkaddr);
-			break;
-		case S_IFCHR:
-		case S_IFBLK:
-			inode->i_rdev =
-				new_decode_dev(le32_to_cpu(dic->i_u.rdev));
-			break;
-		case S_IFIFO:
-		case S_IFSOCK:
-			inode->i_rdev = 0;
-			break;
-		default:
-			goto bogusimode;
-		}
+		iu = &dic->i_u;
 		i_uid_write(inode, le16_to_cpu(dic->i_uid));
 		i_gid_write(inode, le16_to_cpu(dic->i_gid));
 		set_nlink(inode, le16_to_cpu(dic->i_nlink));
-
 		/* use build time for compact inodes */
 		inode_set_ctime(inode, sbi->build_time, sbi->build_time_nsec);
 
 		inode->i_size = le32_to_cpu(dic->i_size);
-		if (erofs_inode_is_data_compressed(vi->datalayout))
-			nblks = le32_to_cpu(dic->i_u.compressed_blocks);
-		else if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
-			vi->chunkformat = le16_to_cpu(dic->i_u.c.format);
 		break;
 	default:
-		erofs_err(inode->i_sb,
-			  "unsupported on-disk inode version %u of nid %llu",
+		erofs_err(sb, "unsupported on-disk inode version %u of nid %llu",
 			  erofs_inode_version(ifmt), vi->nid);
 		err = -EOPNOTSUPP;
 		goto err_out;
 	}
 
-	if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
+	switch (inode->i_mode & S_IFMT) {
+	case S_IFREG:
+	case S_IFDIR:
+	case S_IFLNK:
+		vi->raw_blkaddr = le32_to_cpu(iu->raw_blkaddr);
+		break;
+	case S_IFCHR:
+	case S_IFBLK:
+		inode->i_rdev = new_decode_dev(le32_to_cpu(iu->rdev));
+		break;
+	case S_IFIFO:
+	case S_IFSOCK:
+		inode->i_rdev = 0;
+		break;
+	default:
+		erofs_err(sb, "bogus i_mode (%o) @ nid %llu", inode->i_mode,
+			  vi->nid);
+		err = -EFSCORRUPTED;
+		goto err_out;
+	}
+
+	/* total blocks for compressed files */
+	if (erofs_inode_is_data_compressed(vi->datalayout)) {
+		nblks = le32_to_cpu(iu->compressed_blocks);
+	} else if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
+		/* fill chunked inode summary info */
+		vi->chunkformat = le16_to_cpu(iu->c.format);
 		if (vi->chunkformat & ~EROFS_CHUNK_FORMAT_ALL) {
-			erofs_err(inode->i_sb,
-				  "unsupported chunk format %x of nid %llu",
+			erofs_err(sb, "unsupported chunk format %x of nid %llu",
 				  vi->chunkformat, vi->nid);
 			err = -EOPNOTSUPP;
 			goto err_out;
@@ -190,10 +166,6 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		inode->i_blocks = nblks << (sb->s_blocksize_bits - 9);
 	return kaddr;
 
-bogusimode:
-	erofs_err(inode->i_sb, "bogus i_mode (%o) @ nid %llu",
-		  inode->i_mode, vi->nid);
-	err = -EFSCORRUPTED;
 err_out:
 	DBG_BUGON(1);
 	kfree(copied);
-- 
2.19.1.6.gb485710b

