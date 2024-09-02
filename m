Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B01967FE1
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 09:01:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725260465;
	bh=Zk2uR11QphT7oi+0jYgUeJopixxchpFds3CpBMapZy8=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=TOrKjWXDQMAlNSabI57XHCKnV/vJSKIXvg/0bYpHmTGN+7uGfC0BMtcRQioO1oEKh
	 ozaB361Jr/d6B/S8Ke9oHPY1kOaIP/g2sd7bCBnvY+i8GOLX0P35EAcph+thc+JG+V
	 gjQ/8c1xY7jEDx3UNKBYLb4Y7uDMzNwLthGKOHp4UAz8QJ2+DJEadMTAJROxDEfyfq
	 DHlzuFqDcM1hfqFld0fay5uqox3t2148YFYlXUcfTAzbCTM0eIxax4+JCQRcUttU2r
	 5wyQcO6wnhLCYBQ8oL61NO2eJb8RWtbtEld3E3ztnn2BxQmmZTbIdov/FX3ugpvVZz
	 pw9irTl9P7BZQ==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy05s2SL6z3c7F
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 17:01:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725260463;
	cv=none; b=jnRjrV+eY8NwIky+KJhNYvzDOsHQLC7iVKP+xgyvLGqJfzyjfuNYnlS6hCOeJi8yee9WY7LlGPcMMMd3pvM5jGqV2EuThiV9g205zfV5OBwkYg80sUA7GtSsWaLWe5lTNirqoHQVQikOr1I7rgk7qxTDW+/E0cYLRIGniiISlcXqdBfV0k4uNVe3l+X2Bj3F8O/hrCBXYqr5voCZph+RJTxXMp/4kd2I5TofqbhT26Vx5gpPSoJz5BWF0aa2kBZa6K4ymS4mafrMco5//3TT6eKYCD3kjyENzpQJbcxqsb+ALKowYD9Gpn/bZncP18So2Pby1Kq7FuptFy2MevKvkw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725260463; c=relaxed/relaxed;
	bh=Zk2uR11QphT7oi+0jYgUeJopixxchpFds3CpBMapZy8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version; b=ZE/esQm3a5S5/+PBka8aBgP1LtE81O1yID53kzQsvl1JWh5XgWnfkqqetdWijKUSNvuLLwskYN+unmL9Mcpvjyue5izmJ4PTZ8Wcs1/0seaugvLAranjZKiOUsK/NCN46n3w/kmMWbpy6IHR333aKF6tsI5Apcp9MlDWitLJHuJTRpCwZKtGPhGVknMv6K7TjK7wVY4Jfo+i/Pn7fM4eTAERTNoumafyqBN4Ea1koamJeQzgWyG/jy8VxUCf/8zedNJcL/G/xxL0ft0yV70bSe4984sf2IToRV9JwgVuFFXkPAdX6JoE/njmpw4cek57Qh5tGiLwa6AsguEmfTrfXw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=U4t5KH8j; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=U4t5KH8j;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy05q3fnpz2yPD
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 17:01:03 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 58CA869838;
	Mon,  2 Sep 2024 03:01:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725260461; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Zk2uR11QphT7oi+0jYgUeJopixxchpFds3CpBMapZy8=;
	b=U4t5KH8jOiSHBhljBfudXpU+JAGWf4k5IdiP7/a7fWL2euKtLEApGOk13IAFrR6/4N4U5k
	8imojhzyz+JBHdC/8ZFpqL90Is90/EgyG905LZuFAzBDWXzk5G8OIksa/kww2OLZSLtuIn
	ioMCQ9nPC2S3c00N+xZgChQPZdXY33Xon5WPGAM70ny1152E3a4zSvKv7SdaUkBadoSiEx
	ggMche5mO7EBrcZ0dUoHmtzzyWoBhz8HbOxssOVBcAIaezsIKjKarsvGU0ji36WsgEGne0
	hrKJDjLyk8SAxUSWOW04P04CtrxPiZqN+wUW2yn0Rt7Ft1HQ2Yo/rDhggPFTsg==
To: hsiangkao@linux.alibaba.com
Subject: [PATCH V2 2/2] erofs: refactor read_inode calling convention
Date: Mon,  2 Sep 2024 15:00:47 +0800
Message-ID: <20240902070047.384952-3-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902070047.384952-1-toolmanp@tlmp.cc>
References: <20240902070047.384952-1-toolmanp@tlmp.cc>
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
 fs/erofs/inode.c | 126 ++++++++++++++++++++++++-----------------------
 1 file changed, 65 insertions(+), 61 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index d051afe39670..d854509bb082 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -8,8 +8,39 @@
 
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
+	m_pofs += vi->xattr_isize;
+	/* inline symlink data shouldn't cross block boundary */
+	if (m_pofs + inode->i_size > bsz) {
+		erofs_err(inode->i_sb,
+			  "inline data cross block boundary @ nid %llu",
+			  vi->nid);
+		DBG_BUGON(1);
+		return -EFSCORRUPTED;
+	}
+
+	lnk = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
+
+	if (!lnk)
+		return -ENOMEM;
+
+	inode->i_link = lnk;
+	return 0;
+}
+
+static int erofs_read_inode(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
@@ -20,20 +51,21 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 	struct erofs_inode_compact *dic;
 	struct erofs_inode_extended *die, *copied = NULL;
 	union erofs_inode_i_u iu;
-	unsigned int ifmt;
+	struct erofs_buf buf;
+	unsigned int ifmt, ofs;
 	int err;
 
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
@@ -54,11 +86,11 @@ static void *erofs_read_inode(struct erofs_buf *buf,
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
@@ -66,16 +98,16 @@ static void *erofs_read_inode(struct erofs_buf *buf,
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
@@ -95,7 +127,7 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 		break;
 	case EROFS_INODE_LAYOUT_COMPACT:
 		vi->inode_isize = sizeof(struct erofs_inode_compact);
-		*ofs += vi->inode_isize;
+		ofs += vi->inode_isize;
 		vi->xattr_isize = erofs_xattr_ibody_size(dic->i_xattr_icount);
 
 		inode->i_mode = le16_to_cpu(dic->i_mode);
@@ -119,6 +151,11 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 	case S_IFREG:
 	case S_IFDIR:
 	case S_IFLNK:
+		if(S_ISLNK(inode->i_mode)) {
+			err = erofs_fill_symlink(inode, kaddr, ofs);
+			if(err)
+				goto err_out;
+		}
 		vi->raw_blkaddr = le32_to_cpu(iu.raw_blkaddr);
 		break;
 	case S_IFCHR:
@@ -165,63 +202,29 @@ static void *erofs_read_inode(struct erofs_buf *buf,
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
+	erofs_put_metabuf(&buf);
+	return err;
 }
 
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
-	m_pofs += vi->xattr_isize;
-	/* inline symlink data shouldn't cross block boundary */
-	if (m_pofs + inode->i_size > bsz) {
-		erofs_err(inode->i_sb,
-			  "inline data cross block boundary @ nid %llu",
-			  vi->nid);
-		DBG_BUGON(1);
-		return -EFSCORRUPTED;
-	}
-
-	lnk = kmemdup_nul(kaddr + m_pofs, inode->i_size, GFP_KERNEL);
-
-	if (!lnk)
-		return -ENOMEM;
-
-	inode->i_link = lnk;
-	inode->i_op = &erofs_fast_symlink_iops;
-	return 0;
-}
 
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
+		goto out_unlock;
 
 	/* setup the new inode */
 	switch (inode->i_mode & S_IFMT) {
@@ -238,9 +241,11 @@ static int erofs_fill_inode(struct inode *inode)
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
+
 		inode_nohighmem(inode);
 		break;
 	case S_IFCHR:
@@ -273,7 +278,6 @@ static int erofs_fill_inode(struct inode *inode)
 #endif
 	}
 out_unlock:
-	erofs_put_metabuf(&buf);
 	return err;
 }
 
-- 
2.46.0

