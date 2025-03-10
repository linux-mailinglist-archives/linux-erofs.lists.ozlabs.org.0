Return-Path: <linux-erofs+bounces-33-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82716A59055
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Mar 2025 10:55:15 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZBC1X1HjGz30Tf;
	Mon, 10 Mar 2025 20:55:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741600512;
	cv=none; b=W8njPMoYgePg6a9rH+S2T5/O+0LTvK+1vrckP8f2ocnQBNnKCL22zakAjOPH6PRTYv8WmoO25vkvxJfVOK+bp9pFB0WTyM3map3R8fQLVDiEmDAMPJeC5E3F1vsmPIHBFRRw3Us6oM2/kXIDaPQmOnnoXeHZ6F50wlQyIEUbzXeOqGPzl93YDBnZYpD0g4Nqq4aVnSM1qMNS+CEFC3g70bb7SxLG0s31O8zOlY+dTJrWzw8XItAre8Pj+ELOEKw/leQbwYcqVi2+l+XsmzbGJxQwxLZNb/ssf/1849jPL32SW/GuBzZyN9zIVMicE2E3onqjHhov0dPMg0uR9b+j8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741600512; c=relaxed/relaxed;
	bh=XkR7fIg1S/Lk9bWN6A3/iG9/WpYW4a9EMWzI9Z0Fxtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yftq6AslDf1YZRF/Y0iiUsc0hIrpo3tpnnbsdYpszPIKfiPuTu6PMOzmSvpyvO8awuYDzK7j5RroqJTZp8PcN6G+dFmdJzLL+9zFhhIIQSW9v+fUjzRurWGy7GtdQ1oZ8h+CwkX4WRWv9KzZ1dOvEX+LDk6s6GKQXeD8R1mzc7C825H2+WfMd2QAVgPCRm6GgJhnCfVS3n7zC61zEc8bFH2AV+h/imlJMd3Qukkcrwngs2rp6A5qiOf2Eg406b+prm0Ci20MUAWZRPRRkq1ZACdvSp1reOSI7txYPZrT+ePlDGKgUR4ghhpIJVv/DOxysNAZoHPOBRspqbtrwryvBg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TkpyQdT/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=TkpyQdT/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZBC1V4yxbz305v
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Mar 2025 20:55:10 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741600506; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XkR7fIg1S/Lk9bWN6A3/iG9/WpYW4a9EMWzI9Z0Fxtk=;
	b=TkpyQdT/9mlpH1L58bPYAzaR8TEBplmCqGiuB10AZwatrz+JPZaGxQ7p0zHkgfAZlj/zliq/v/M3gCqGI+XChBkh92r9WrnjYWTtmHfAwjGVkJTiTLJcN7PdUSr7c23Qdy8Q4i8uUU98QMXdEYONLb3m996lzZqFw0WJEr04aPA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WR1F3xk_1741600505 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 17:55:06 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 02/10] erofs: simplify erofs_{read,fill}_inode()
Date: Mon, 10 Mar 2025 17:54:52 +0800
Message-ID: <20250310095459.2620647-3-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
References: <20250310095459.2620647-1-hsiangkao@linux.alibaba.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

 - Switch to on-stack `copied` since it's just 64 bytes;

 - Get rid of `nblks` and derive `i_blocks` directly;

 - Use `inode_set_mtime()` instead of `inode_set_ctime()`
   to follow the ondisk naming;

 - Rearrange the code.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c | 92 ++++++++++++++++++------------------------------
 1 file changed, 35 insertions(+), 57 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 4936bd43c438..c8ede541c239 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -27,29 +27,27 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 static int erofs_read_inode(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
+	erofs_blk_t blkaddr = erofs_blknr(sb, erofs_iloc(inode));
+	unsigned int ofs = erofs_blkoff(sb, erofs_iloc(inode));
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_inode *vi = EROFS_I(inode);
-	const erofs_off_t inode_loc = erofs_iloc(inode);
-	erofs_blk_t blkaddr, nblks = 0;
-	void *kaddr;
+	struct erofs_inode_extended *die, copied;
 	struct erofs_inode_compact *dic;
-	struct erofs_inode_extended *die, *copied = NULL;
 	union erofs_inode_i_u iu;
-	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
-	unsigned int ifmt, ofs;
+	unsigned int ifmt;
+	void *ptr;
 	int err = 0;
 
-	blkaddr = erofs_blknr(sb, inode_loc);
-	ofs = erofs_blkoff(sb, inode_loc);
-
-	kaddr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr), true);
-	if (IS_ERR(kaddr)) {
-		erofs_err(sb, "failed to get inode (nid: %llu) page, err %ld",
-			  vi->nid, PTR_ERR(kaddr));
-		return PTR_ERR(kaddr);
+	ptr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr), true);
+	if (IS_ERR(ptr)) {
+		err = PTR_ERR(ptr);
+		erofs_err(sb, "failed to get inode (nid: %llu) page, err %d",
+			  vi->nid, err);
+		goto err_out;
 	}
 
-	dic = kaddr + ofs;
+	dic = ptr + ofs;
 	ifmt = le16_to_cpu(dic->i_format);
 	if (ifmt & ~EROFS_I_ALL) {
 		erofs_err(sb, "unsupported i_format %u of nid %llu",
@@ -76,23 +74,18 @@ static int erofs_read_inode(struct inode *inode)
 		} else {
 			const unsigned int gotten = sb->s_blocksize - ofs;
 
-			copied = kmalloc(vi->inode_isize, GFP_KERNEL);
-			if (!copied) {
-				err = -ENOMEM;
-				goto err_out;
-			}
-			memcpy(copied, dic, gotten);
-			kaddr = erofs_read_metabuf(&buf, sb,
+			memcpy(&copied, dic, gotten);
+			ptr = erofs_read_metabuf(&buf, sb,
 					erofs_pos(sb, blkaddr + 1), true);
-			if (IS_ERR(kaddr)) {
-				erofs_err(sb, "failed to get inode payload block (nid: %llu), err %ld",
-					  vi->nid, PTR_ERR(kaddr));
-				kfree(copied);
-				return PTR_ERR(kaddr);
+			if (IS_ERR(ptr)) {
+				err = PTR_ERR(ptr);
+				erofs_err(sb, "failed to get inode payload block (nid: %llu), err %d",
+					  vi->nid, err);
+				goto err_out;
 			}
 			ofs = vi->inode_isize - gotten;
-			memcpy((u8 *)copied + gotten, kaddr, ofs);
-			die = copied;
+			memcpy((u8 *)&copied + gotten, ptr, ofs);
+			die = &copied;
 		}
 		vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
 
@@ -101,12 +94,10 @@ static int erofs_read_inode(struct inode *inode)
 		i_uid_write(inode, le32_to_cpu(die->i_uid));
 		i_gid_write(inode, le32_to_cpu(die->i_gid));
 		set_nlink(inode, le32_to_cpu(die->i_nlink));
-		/* each extended inode has its own timestamp */
-		inode_set_ctime(inode, le64_to_cpu(die->i_mtime),
+		inode_set_mtime(inode, le64_to_cpu(die->i_mtime),
 				le32_to_cpu(die->i_mtime_nsec));
 
 		inode->i_size = le64_to_cpu(die->i_size);
-		kfree(copied);
 		break;
 	case EROFS_INODE_LAYOUT_COMPACT:
 		vi->inode_isize = sizeof(struct erofs_inode_compact);
@@ -118,8 +109,7 @@ static int erofs_read_inode(struct inode *inode)
 		i_uid_write(inode, le16_to_cpu(dic->i_uid));
 		i_gid_write(inode, le16_to_cpu(dic->i_gid));
 		set_nlink(inode, le16_to_cpu(dic->i_nlink));
-		/* use build time for compact inodes */
-		inode_set_ctime(inode, sbi->build_time, sbi->build_time_nsec);
+		inode_set_mtime(inode, sbi->build_time, sbi->build_time_nsec);
 
 		inode->i_size = le32_to_cpu(dic->i_size);
 		break;
@@ -141,7 +131,7 @@ static int erofs_read_inode(struct inode *inode)
 	case S_IFLNK:
 		vi->raw_blkaddr = le32_to_cpu(iu.raw_blkaddr);
 		if(S_ISLNK(inode->i_mode)) {
-			err = erofs_fill_symlink(inode, kaddr, ofs);
+			err = erofs_fill_symlink(inode, ptr, ofs);
 			if (err)
 				goto err_out;
 		}
@@ -161,10 +151,13 @@ static int erofs_read_inode(struct inode *inode)
 		goto err_out;
 	}
 
-	/* total blocks for compressed files */
-	if (erofs_inode_is_data_compressed(vi->datalayout)) {
-		nblks = le32_to_cpu(iu.compressed_blocks);
-	} else if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
+	if (erofs_inode_is_data_compressed(vi->datalayout))
+		inode->i_blocks = le32_to_cpu(iu.compressed_blocks) <<
+					(sb->s_blocksize_bits - 9);
+	else
+		inode->i_blocks = round_up(inode->i_size, sb->s_blocksize) >> 9;
+
+	if (vi->datalayout == EROFS_INODE_CHUNK_BASED) {
 		/* fill chunked inode summary info */
 		vi->chunkformat = le16_to_cpu(iu.c.format);
 		if (vi->chunkformat & ~EROFS_CHUNK_FORMAT_ALL) {
@@ -176,22 +169,15 @@ static int erofs_read_inode(struct inode *inode)
 		vi->chunkbits = sb->s_blocksize_bits +
 			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	}
-	inode_set_mtime_to_ts(inode,
-			      inode_set_atime_to_ts(inode, inode_get_ctime(inode)));
+	inode_set_atime_to_ts(inode,
+			      inode_set_ctime_to_ts(inode, inode_get_mtime(inode)));
 
 	inode->i_flags &= ~S_DAX;
 	if (test_opt(&sbi->opt, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
 	    (vi->datalayout == EROFS_INODE_FLAT_PLAIN ||
 	     vi->datalayout == EROFS_INODE_CHUNK_BASED))
 		inode->i_flags |= S_DAX;
-
-	if (!nblks)
-		/* measure inode.i_blocks as generic filesystems */
-		inode->i_blocks = round_up(inode->i_size, sb->s_blocksize) >> 9;
-	else
-		inode->i_blocks = nblks << (sb->s_blocksize_bits - 9);
 err_out:
-	DBG_BUGON(err);
 	erofs_put_metabuf(&buf);
 	return err;
 }
@@ -202,13 +188,10 @@ static int erofs_fill_inode(struct inode *inode)
 	int err;
 
 	trace_erofs_fill_inode(inode);
-
-	/* read inode base data from disk */
 	err = erofs_read_inode(inode);
 	if (err)
 		return err;
 
-	/* setup the new inode */
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
 		inode->i_op = &erofs_generic_iops;
@@ -229,15 +212,10 @@ static int erofs_fill_inode(struct inode *inode)
 			inode->i_op = &erofs_symlink_iops;
 		inode_nohighmem(inode);
 		break;
-	case S_IFCHR:
-	case S_IFBLK:
-	case S_IFIFO:
-	case S_IFSOCK:
+	default:
 		inode->i_op = &erofs_generic_iops;
 		init_special_inode(inode, inode->i_mode, inode->i_rdev);
 		return 0;
-	default:
-		return -EFSCORRUPTED;
 	}
 
 	mapping_set_large_folios(inode->i_mapping);
-- 
2.43.5


