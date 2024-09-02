Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C9596835E
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 11:34:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725269678;
	bh=3zizPzppcEuaKdw8qmJsuld0eajoUISs8F2P4HTRk/s=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=Tcfz/QoYAUEOJZ7NVyasTFd8joknP5u4Kse798JdKJbTqjd31thfuZOqXJZUhYn00
	 vsw4+OdoNM7WLGr6mgKKf4+3rZC2URiKVbrs9T50sXlkfxCBYpU5LQrCN1/tae270h
	 Nt7bMXcFsE04vFhAiGQcSSZQK7NKX4Pv5wplFT23aCa0Y3Eqz5C1g1S0ZPMyQwc2nf
	 tQXv2SPX7VcH9VYkEL9CkIqZaaW+mH0KU697yUB4Dj6G0nXM06MRkVAc3f+hFvmQXl
	 5YwLTOBGgwBBqNhxBWWbV0w+crtJJ25hbLRluaQ3IWcotBzyE2Y8mzOcQdeYk7C2hb
	 0YST1/HyJpu9g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy3W26Wdcz2yMk
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 19:34:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725269677;
	cv=none; b=Os5L6wimT01Z+f/fwgrBrLr6Ut/5NKCvtCKWa/605036ENMBuzaMx7OAMor6LJPxjJGAn7R9MRzPFHoYORCa1GXk+UsQM3RsBSnRoI2eHi9wE1n+3LIRtDH1TPfm6sZACYiYTuijzFxCf9yvQTSnhplrdt8VylRfGeMl5BE2rHsZAdUIDVitj83WdWP9uJcdmDoM27EhqN8Q5nm/SfolLkgNA6hZu3LiWyt904RQCCKKYitmLfHVkj7fpmg8RiTJE/lHtq4WRxRaactzagpIHw2XI/tauABy7aHIEgQQm1ATn+X4ssdrh0Ohw8haqpLdhEoOXMN4n08WrgZbcLikqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725269677; c=relaxed/relaxed;
	bh=3zizPzppcEuaKdw8qmJsuld0eajoUISs8F2P4HTRk/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inLVi/Jmd3j/nlBF/nWHqsBcAge/mqSemP4ARjWv2wWkSlH/9CF3BbvdKdEE+USDpw8+e5YQF5QsgMc2Ew9D3sOHlZn9iCEgl2TIvtb/hHJefqjFGM/B4+WTE2jWqfNa5DHtpyNMRAPMvL+5cfELqehKniAfqbPpi/z8qaSSHAByzJwr5WkkLGpwLBDdfzKhQogxqoIN4D0FsEK+0zYo4LQ3qoUlwE54J5kML3DXCFi3JyTJ6FRiIfTuiGQRFxtqgxE1uQYdq/yiUB9g0KD9oWcu0ls5ciNxFQBapF982DuQK6Xe9Uha/15bEHVHyXz2xg9dhBPSbAxqNuR/Oi3/Sg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=RTCZGm3z; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=RTCZGm3z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy3W051T1z2xfB
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 19:34:36 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6CA8B698B6;
	Mon,  2 Sep 2024 05:34:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725269670; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=3zizPzppcEuaKdw8qmJsuld0eajoUISs8F2P4HTRk/s=;
	b=RTCZGm3zqOk0Laq20K9vLj3fK2qGUS/8TmmscqDhASeVOeGqS2QIo168zqtBUmpMx6meqk
	7hud5iEKzX/9o5xvGlKnrJva1LgFwtk34CSjR/6RtF+84GNpDZVfcZZKFF4lsu8B3o4hMz
	gjZyjryaYlGNqkTcoN5ZyXIFwVWLSOZxdiVr/FS+Ff5luoa5aFEmWLInRlexaVUIBkgfpx
	8D598cXVXmXchrhYGQVQSmU/Ram0eEzydtx/Beq9BBuBgSZH47HkSDv6yMfVzUTY3lkZhT
	oezINfQhj7b5pY9Caa7vWNHoGMDOJuLmktZghqgmNjcMXrzmM1PkEhWZDsJUJg==
To: hsiangkao@linux.alibaba.com
Subject: [PATCH V4 2/2] erofs: refactor read_inode calling convention
Date: Mon,  2 Sep 2024 17:34:12 +0800
Message-ID: <20240902093412.509083-1-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <ca8dea24-1ef2-46a8-bfca-72aeffa1f6e6@linux.alibaba.com>
References: <ca8dea24-1ef2-46a8-bfca-72aeffa1f6e6@linux.alibaba.com>
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Refactor out the iop binding behavior out of the erofs_fill_symlink
and move erofs_buf into the erofs_read_inode, so that erofs_fill_inode
can only deal with inode operation bindings and can be decoupled from
metabuf operations. This results in better calling conventions.

Note that after this patch, we do not need erofs_buf and ofs as
parameters any more when calling erofs_read_inode as
all the data operations are now included in itself.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Link: https://lore.kernel.org/all/20240425222847.GN2118490@ZenIV/
Signed-off-by: Yiyang Wu <toolmanp@tlmp.cc>
---
 fs/erofs/inode.c | 124 ++++++++++++++++++++++-------------------------
 1 file changed, 59 insertions(+), 65 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 68ea67e0caf3..726a93a0413c 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -8,8 +8,32 @@
 
 #include <trace/events/erofs.h>
 
-static void *erofs_read_inode(struct erofs_buf *buf,
-			      struct inode *inode, unsigned int *ofs)
+static int erofs_fill_symlink(struct inode *inode, void *kaddr,
+			      unsigned int m_pofs)
+{
+	struct erofs_inode *vi = EROFS_I(inode);
+	unsigned int bsz = i_blocksize(inode);
+
+	/* if it cannot be handled with fast symlink scheme */
+	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
+	    inode->i_size >= bsz || inode->i_size < 0) {
+		return 0;
+	}
+
+	m_pofs += vi->xattr_isize;
+	/* inline symlink data shouldn't cross block boundary */
+	if (m_pofs + inode->i_size > bsz) {
+		erofs_err(inode->i_sb, "inline data cross block boundary @ nid %llu",
+			  vi->nid);
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
+
+	inode->i_link = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
+	return inode->i_link ? 0 : -ENOMEM;
+}
+
+static int erofs_read_inode(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
@@ -20,20 +44,21 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 	struct erofs_inode_compact *dic;
 	struct erofs_inode_extended *die, *copied = NULL;
 	union erofs_inode_i_u iu;
-	unsigned int ifmt;
-	int err;
+	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
+	unsigned int ifmt, ofs;
+	int err = 0;
 
 	blkaddr = erofs_blknr(sb, inode_loc);
-	*ofs = erofs_blkoff(sb, inode_loc);
+	ofs = erofs_blkoff(sb, inode_loc);
 
-	kaddr = erofs_read_metabuf(buf, sb, erofs_pos(sb, blkaddr), EROFS_KMAP);
+	kaddr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr), EROFS_KMAP);
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
 		erofs_err(sb, "unsupported i_format %u of nid %llu",
@@ -54,11 +79,11 @@ static void *erofs_read_inode(struct erofs_buf *buf,
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
@@ -66,16 +91,16 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 				goto err_out;
 			}
 			memcpy(copied, dic, gotten);
-			kaddr = erofs_read_metabuf(buf, sb, erofs_pos(sb, blkaddr + 1),
+			kaddr = erofs_read_metabuf(&buf, sb, erofs_pos(sb, blkaddr + 1),
 						   EROFS_KMAP);
 			if (IS_ERR(kaddr)) {
 				erofs_err(sb, "failed to get inode payload block (nid: %llu), err %ld",
 					  vi->nid, PTR_ERR(kaddr));
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
@@ -91,11 +116,10 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 
 		inode->i_size = le64_to_cpu(die->i_size);
 		kfree(copied);
-		copied = NULL;
 		break;
 	case EROFS_INODE_LAYOUT_COMPACT:
 		vi->inode_isize = sizeof(struct erofs_inode_compact);
-		*ofs += vi->inode_isize;
+		ofs += vi->inode_isize;
 		vi->xattr_isize = erofs_xattr_ibody_size(dic->i_xattr_icount);
 
 		inode->i_mode = le16_to_cpu(dic->i_mode);
@@ -120,6 +144,11 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 	case S_IFDIR:
 	case S_IFLNK:
 		vi->raw_blkaddr = le32_to_cpu(iu.raw_blkaddr);
+		if(S_ISLNK(inode->i_mode)) {
+			err = erofs_fill_symlink(inode, kaddr, ofs);
+			if (err)
+				goto err_out;
+		}
 		break;
 	case S_IFCHR:
 	case S_IFBLK:
@@ -165,58 +194,24 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		inode->i_blocks = round_up(inode->i_size, sb->s_blocksize) >> 9;
 	else
 		inode->i_blocks = nblks << (sb->s_blocksize_bits - 9);
-	return kaddr;
 
 err_out:
-	DBG_BUGON(1);
-	kfree(copied);
-	erofs_put_metabuf(buf);
-	return ERR_PTR(err);
-}
-
-static int erofs_fill_symlink(struct inode *inode, void *kaddr,
-			      unsigned int m_pofs)
-{
-	struct erofs_inode *vi = EROFS_I(inode);
-	unsigned int bsz = i_blocksize(inode);
-
-	/* if it cannot be handled with fast symlink scheme */
-	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
-	    inode->i_size >= bsz || inode->i_size < 0) {
-		inode->i_op = &erofs_symlink_iops;
-		return 0;
-	}
-
-	m_pofs += vi->xattr_isize;
-	/* inline symlink data shouldn't cross block boundary */
-	if (m_pofs + inode->i_size > bsz) {
-		erofs_err(inode->i_sb, "inline data cross block boundary @ nid %llu",
-			  vi->nid);
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
-	}
-
-	inode->i_link = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
-	if (!inode->i_link)
-		return -ENOMEM;
-	inode->i_op = &erofs_fast_symlink_iops;
-	return 0;
+	DBG_BUGON(err);
+	erofs_put_metabuf(&buf);
+	return err;
 }
 
 static int erofs_fill_inode(struct inode *inode)
 {
 	struct erofs_inode *vi = EROFS_I(inode);
-	struct erofs_buf buf = __EROFS_BUF_INITIALIZER;
-	void *kaddr;
-	unsigned int ofs;
 	int err = 0;
 
 	trace_erofs_fill_inode(inode);
 
 	/* read inode base data from disk */
-	kaddr = erofs_read_inode(&buf, inode, &ofs);
-	if (IS_ERR(kaddr))
-		return PTR_ERR(kaddr);
+	err = erofs_read_inode(inode);
+	if (err)
+		return err;
 
 	/* setup the new inode */
 	switch (inode->i_mode & S_IFMT) {
@@ -233,9 +228,10 @@ static int erofs_fill_inode(struct inode *inode)
 		inode_nohighmem(inode);
 		break;
 	case S_IFLNK:
-		err = erofs_fill_symlink(inode, kaddr, ofs);
-		if (err)
-			goto out_unlock;
+		if (inode->i_link)
+			inode->i_op = &erofs_fast_symlink_iops;
+		else
+			inode->i_op = &erofs_symlink_iops;
 		inode_nohighmem(inode);
 		break;
 	case S_IFCHR:
@@ -244,10 +240,9 @@ static int erofs_fill_inode(struct inode *inode)
 	case S_IFSOCK:
 		inode->i_op = &erofs_generic_iops;
 		init_special_inode(inode, inode->i_mode, inode->i_rdev);
-		goto out_unlock;
+		return 0;
 	default:
-		err = -EFSCORRUPTED;
-		goto out_unlock;
+		return -EFSCORRUPTED;
 	}
 
 	mapping_set_large_folios(inode->i_mapping);
@@ -271,8 +266,7 @@ static int erofs_fill_inode(struct inode *inode)
 			inode->i_mapping->a_ops = &erofs_fileio_aops;
 #endif
 	}
-out_unlock:
-	erofs_put_metabuf(&buf);
+
 	return err;
 }
 
-- 
2.46.0

