Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1FA967EA1
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 06:51:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725252684;
	bh=mVShlybZko0fUKDp7XHFSAgo1uODl7EZkaluD/hRtFI=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=UruuYS5JW4m88qxgzoXt+9lhLZGLj3zh2TmD+v71R+CV+UUlCWDH7Ybj/efugUO46
	 59PPiTCQDKcsFV4l0Kac4xB5g6WCYUmcptvuYZ3kfiYljAtr4UzPwhs2+U+XGkPJkG
	 azISWu87NUrO9WiM50w4Tva3bJTbVv5wnxevAvlQQ72i+5ISc4OJ4FL6oNbN/aaZci
	 V/Z5smKq64yQHpvyh1ULhZzQo1jSRrXHXOvSdS0jTWDaenQ+WJfNWVgHVE4jWfGUGD
	 XuXP7S6j0E19zLz9BsLvBpVt3khaSEVMYaRKfu4vO8ZMpzDQ8ULBW/wi5wvLH6QXma
	 Oyh0NfMbL5D9Q==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WxxDD6rFzz2yNt
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 14:51:24 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725252682;
	cv=none; b=YLp54zh9U766ubWYuXYGIEFiU1NO2q8booyFFhpc5JOQkWS2Jn/KYn4Tg3GHYoW6H72mFcxOe91Yl/8gP0v2vI1VoMipZjXOuCe27T4UPA/DxgVwUu+RBMzOiCCD9k4Jmo+0z4DRUZ8CKdJEJ5Cg/uzSw6lrrb9/up6McwbJKFGav0KMds19Vhu5XQsPHYsv730avNf3PhI7KlCEoUIZJx7WqNKzvNcHYku5/4i9RffSmvKqzQJ4ogwurnphw2B5Yxq6tkQHJNC/wqPKNoHfMhpGPc3VPcr7KsKml0bpQM0Kqhx/Z2wi1WKkCZB4SAuRYc4vP//45Jz72hoB+1m/TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725252682; c=relaxed/relaxed;
	bh=mVShlybZko0fUKDp7XHFSAgo1uODl7EZkaluD/hRtFI=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version; b=aQ2+HdfYHC3sT0m7sd4YMGNxcs9YvwVExGlVXpqk//46TUhVbsJIKQRwIXfUJSuP5Pa4G9jL1o6aIitiEWyTNbjrHvrdknAgeKnrZiBCiUKu7tkIwzSDhQfwo1Tz78z00P7qQhSGglnvE2ea6pu9L0IWnFu9v0dOXgOM4I7hPItkiaySefdC9xjmF/b+FI4Pq6wTe73yVRfQtuA++aRwx6xvMtGAUpHyPPE0JtdHWRU8osC0xKWXHWVn1LkaDFMVTt8JHNGRubAsqhxCYGUAmdoK2d/A/zIVG0c4plPM1E1gNvHcyaFmfPYZ2ul4og2/hturMMeBt7yMnZ1cvW7PZw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=AhlcQ4+3; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=AhlcQ4+3;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WxxDB1lhzz2xZt
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 14:51:22 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A8CB86999B;
	Mon,  2 Sep 2024 00:51:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725252678; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=mVShlybZko0fUKDp7XHFSAgo1uODl7EZkaluD/hRtFI=;
	b=AhlcQ4+3jfi+dyKBVjXGvmegkTMtNpvCgbCH9pRf52sTAPjZRXEXqYmj8Hnkqko7Hnnt2Z
	yywVPTr1CHjSlhPvi3gByfVcLT9YqX4LilAyslFBC0Rcj06Uzr7rHVM0ZUo/FQfgc/k9Pt
	uIHZcEgksFozBsYcKzv+R5Q1kFKyA9mjK1pU2q/5hKhZzbBYI+aqF5P72Kq387FHdfv0Np
	pQZAEPPdymCbs0e4Gbw6Zw9JuQbrTteEF3S5y8yglEIgnPbDdw7hKl2lZ5aluZRrj1nf3y
	Isj5JsHqmEfJXe11rmdgeanDaEQzxrXNYGwExbmc6bskmP2jaq+EEMM+NkA9CQ==
To: hsiangkao@linux.alibaba.com
Subject: [PATCH 1/2] erofs: refactor read_inode calling convention
Date: Mon,  2 Sep 2024 12:50:59 +0800
Message-ID: <20240902045100.285477-2-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902045100.285477-1-toolmanp@tlmp.cc>
References: <20240902045100.285477-1-toolmanp@tlmp.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
From: Yiyang Wu via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Yiyang Wu <toolmanp@tlmp.cc>
Cc: linux-erofs@lists.ozlabs.org, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Refactor out the iop binding behavior out of the erofs_fill_symlink
and move erofs_buf into the erofs_read_inode, so that erofs_fill_inode
can only deal with inode operation bindings and can be decoupled from
metabuf operations. This results in better calling conventions.

Note that after the patch, we do not need erofs_buf and ofs as
parameters when calling erofs_read_inode as all the data operations are
self included inside itself.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV/
Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/inode.c | 164 +++++++++++++++++++++++++----------------------
 1 file changed, 86 insertions(+), 78 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 419432be3223..90f1235dc404 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -8,36 +8,71 @@
 
 #include <trace/events/erofs.h>
 
-static void *erofs_read_inode(struct erofs_buf *buf,
-			      struct inode *inode, unsigned int *ofs)
+static int erofs_fill_symlink(struct inode *inode, void *kaddr,
+			      unsigned int m_pofs)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+	unsigned int bsz = i_blocksize(inode);
+	char *lnk;
+
+	/* if it cannot be handled with fast symlink scheme */
+	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
+	    inode->i_size >= bsz || inode->i_size < 0) {
+		return 0;
+	}
+
+	lnk = kmalloc(inode->i_size + 1, GFP_KERNEL);
+	if (!lnk)
+		return -ENOMEM;
+
+	m_pofs += vi->xattr_isize;
+	/* inline symlink data shouldn't cross block boundary */
+	if (m_pofs + inode->i_size > bsz) {
+		kfree(lnk);
+		erofs_err(inode->i_sb,
+			  "inline data cross block boundary @ nid %llu",
+			  vi->nid);
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
+	memcpy(lnk, kaddr + m_pofs, inode->i_size);
+	lnk[inode->i_size] = '\0';
+
+	inode->i_link = lnk;
+	return 0;
+}
+
+static int erofs_read_inode(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
 	struct erofs_inode *vi = EROFS_I(inode);
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
 	const erofs_off_t inode_loc = erofs_iloc(inode);
 	erofs_blk_t blkaddr, nblks = 0;
 	void *kaddr;
 	struct erofs_inode_compact *dic;
 	struct erofs_inode_extended *die, *copied = NULL;
 	union erofs_inode_i_u iu;
-	unsigned int ifmt;
+	unsigned int ifmt, ofs;
 	int err;
 
 	blkaddr = erofs_blknr(sb, inode_loc);
-	*ofs = erofs_blkoff(sb, inode_loc);
+	ofs = erofs_blkoff(sb, inode_loc);
 
-	kaddr = erofs_read_metabuf(buf, sb, erofs_pos(sb, blkaddr), EROFS_KMAP);
+	kaddr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr),
+				   EROFS_KMAP);
 	if (IS_ERR(kaddr)) {
 		erofs_err(sb, "failed to get inode (nid: %llu) page, err %ld",
 			  vi->nid, PTR_ERR(kaddr));
-		return kaddr;
+		return PTR_ERR(kaddr);
 	}
 
-	dic = kaddr + *ofs;
+	dic = kaddr + ofs;
 	ifmt = le16_to_cpu(dic->i_format);
 	if (ifmt & ~EROFS_I_ALL) {
-		erofs_err(sb, "unsupported i_format %u of nid %llu",
-			  ifmt, vi->nid);
+		erofs_err(sb, "unsupported i_format %u of nid %llu", ifmt,
+			  vi->nid);
 		err = -EOPNOTSUPP;
 		goto err_out;
 	}
@@ -54,11 +89,11 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 	case EROFS_INODE_LAYOUT_EXTENDED:
 		vi->inode_isize = sizeof(struct erofs_inode_extended);
 		/* check if the extended inode acrosses block boundary */
-		if (*ofs + vi->inode_isize <= sb->s_blocksize) {
-			*ofs += vi->inode_isize;
+		if (ofs + vi->inode_isize <= sb->s_blocksize) {
+			ofs += vi->inode_isize;
 			die = (struct erofs_inode_extended *)dic;
 		} else {
-			const unsigned int gotten = sb->s_blocksize - *ofs;
+			const unsigned int gotten = sb->s_blocksize - ofs;
 
 			copied = kmalloc(vi->inode_isize, GFP_KERNEL);
 			if (!copied) {
@@ -66,16 +101,19 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 				goto err_out;
 			}
 			memcpy(copied, dic, gotten);
-			kaddr = erofs_read_metabuf(buf, sb, erofs_pos(sb, blkaddr + 1),
+			kaddr = erofs_read_metabuf(&buf, sb,
+						   erofs_pos(sb, blkaddr + 1),
 						   EROFS_KMAP);
 			if (IS_ERR(kaddr)) {
-				erofs_err(sb, "failed to get inode payload block (nid: %llu), err %ld",
-					  vi->nid, PTR_ERR(kaddr));
+				erofs_err(
+					sb,
+					"failed to get inode payload block (nid: %llu), err %ld",
+					vi->nid, PTR_ERR(kaddr));
 				kfree(copied);
-				return kaddr;
+				return PTR_ERR(kaddr);
 			}
-			*ofs = vi->inode_isize - gotten;
-			memcpy((u8 *)copied + gotten, kaddr, *ofs);
+			ofs = vi->inode_isize - gotten;
+			memcpy((u8 *)copied + gotten, kaddr, ofs);
 			die = copied;
 		}
 		vi->xattr_isize = erofs_xattr_ibody_size(die->i_xattr_icount);
@@ -95,7 +133,7 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		break;
 	case EROFS_INODE_LAYOUT_COMPACT:
 		vi->inode_isize = sizeof(struct erofs_inode_compact);
-		*ofs += vi->inode_isize;
+		ofs += vi->inode_isize;
 		vi->xattr_isize = erofs_xattr_ibody_size(dic->i_xattr_icount);
 
 		inode->i_mode = le16_to_cpu(dic->i_mode);
@@ -109,16 +147,22 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		inode->i_size = le32_to_cpu(dic->i_size);
 		break;
 	default:
-		erofs_err(sb, "unsupported on-disk inode version %u of nid %llu",
+		erofs_err(sb,
+			  "unsupported on-disk inode version %u of nid %llu",
 			  erofs_inode_version(ifmt), vi->nid);
 		err = -EOPNOTSUPP;
 		goto err_out;
 	}
 
 	switch (inode->i_mode & S_IFMT) {
+	case S_IFLNK:
+		vi->raw_blkaddr = le32_to_cpu(iu.raw_blkaddr);
+		err = erofs_fill_symlink(inode, kaddr, ofs);
+		if (err)
+			goto err_out;
+		break;
 	case S_IFREG:
 	case S_IFDIR:
-	case S_IFLNK:
 		vi->raw_blkaddr = le32_to_cpu(iu.raw_blkaddr);
 		break;
 	case S_IFCHR:
@@ -148,11 +192,12 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 			err = -EOPNOTSUPP;
 			goto err_out;
 		}
-		vi->chunkbits = sb->s_blocksize_bits +
+		vi->chunkbits =
+			sb->s_blocksize_bits +
 			(vi->chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	}
-	inode_set_mtime_to_ts(inode,
-			      inode_set_atime_to_ts(inode, inode_get_ctime(inode)));
+	inode_set_mtime_to_ts(
+		inode, inode_set_atime_to_ts(inode, inode_get_ctime(inode)));
 
 	inode->i_flags &= ~S_DAX;
 	if (test_opt(&sbi->opt, DAX_ALWAYS) && S_ISREG(inode->i_mode) &&
@@ -165,65 +210,29 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		inode->i_blocks = round_up(inode->i_size, sb->s_blocksize) >> 9;
 	else
 		inode->i_blocks = nblks << (sb->s_blocksize_bits - 9);
-	return kaddr;
+
+	erofs_put_metabuf(&buf);
+	return 0;
 
 err_out:
 	DBG_BUGON(1);
 	kfree(copied);
-	erofs_put_metabuf(buf);
-	return ERR_PTR(err);
-}
-
-static int erofs_fill_symlink(struct inode *inode, void *kaddr,
-			      unsigned int m_pofs)
-{
-	struct erofs_inode *vi = EROFS_I(inode);
-	unsigned int bsz = i_blocksize(inode);
-	char *lnk;
-
-	/* if it cannot be handled with fast symlink scheme */
-	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
-	    inode->i_size >= bsz || inode->i_size < 0) {
-		inode->i_op = &erofs_symlink_iops;
-		return 0;
-	}
-
-	lnk = kmalloc(inode->i_size + 1, GFP_KERNEL);
-	if (!lnk)
-		return -ENOMEM;
-
-	m_pofs += vi->xattr_isize;
-	/* inline symlink data shouldn't cross block boundary */
-	if (m_pofs + inode->i_size > bsz) {
-		kfree(lnk);
-		erofs_err(inode->i_sb,
-			  "inline data cross block boundary @ nid %llu",
-			  vi->nid);
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
-	}
-	memcpy(lnk, kaddr + m_pofs, inode->i_size);
-	lnk[inode->i_size] = '\0';
-
-	inode->i_link = lnk;
-	inode->i_op = &erofs_fast_symlink_iops;
+	erofs_put_metabuf(&buf);
 	return 0;
 }
 
 static int erofs_fill_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
-	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
-	void *kaddr;
-	unsigned int ofs;
-	int err = 0;
+
+	int err;
 
 	trace_erofs_fill_inode(inode);
 
 	/* read inode base data from disk */
-	kaddr = erofs_read_inode(&buf, inode, &ofs);
-	if (IS_ERR(kaddr))
-		return PTR_ERR(kaddr);
+	err = erofs_read_inode(inode);
+	if (err)
+		goto out_unlock;
 
 	/* setup the new inode */
 	switch (inode->i_mode & S_IFMT) {
@@ -240,9 +249,10 @@ static int erofs_fill_inode(struct inode *inode)
 		inode_nohighmem(inode);
 		break;
 	case S_IFLNK:
-		err = erofs_fill_symlink(inode, kaddr, ofs);
-		if (err)
-			goto out_unlock;
+		if (inode->i_link != NULL)
+			inode->i_op = &erofs_fast_symlink_iops;
+		else
+			inode->i_op = &erofs_symlink_iops;
 		inode_nohighmem(inode);
 		break;
 	case S_IFCHR:
@@ -260,9 +270,9 @@ static int erofs_fill_inode(struct inode *inode)
 	mapping_set_large_folios(inode->i_mapping);
 	if (erofs_inode_is_data_compressed(vi->datalayout)) {
 #ifdef CONFIG_EROFS_FS_ZIP
-		DO_ONCE_LITE_IF(inode->i_blkbits != PAGE_SHIFT,
-			  erofs_info, inode->i_sb,
-			  "EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
+		DO_ONCE_LITE_IF(
+			inode->i_blkbits != PAGE_SHIFT, erofs_info, inode->i_sb,
+			"EXPERIMENTAL EROFS subpage compressed block support in use. Use at your own risk!");
 		inode->i_mapping->a_ops = &z_erofs_aops;
 #else
 		err = -EOPNOTSUPP;
@@ -275,7 +285,6 @@ static int erofs_fill_inode(struct inode *inode)
 #endif
 	}
 out_unlock:
-	erofs_put_metabuf(&buf);
 	return err;
 }
 
@@ -338,8 +347,7 @@ int erofs_getattr(struct mnt_idmap *idmap, const struct path *path,
 	if (compressed)
 		stat->attributes |= STATX_ATTR_COMPRESSED;
 	stat->attributes |= STATX_ATTR_IMMUTABLE;
-	stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
-				  STATX_ATTR_IMMUTABLE);
+	stat->attributes_mask |= (STATX_ATTR_COMPRESSED | STATX_ATTR_IMMUTABLE);
 
 	/*
 	 * Return the DIO alignment restrictions if requested.
-- 
2.46.0

