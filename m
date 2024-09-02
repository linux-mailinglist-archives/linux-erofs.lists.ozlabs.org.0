Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47467968145
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 10:04:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1725264281;
	bh=hpmJZ0s2GEZuz/a3oISuD+V2NTlGcgmVuoFToUTHIO0=;
	h=To:Subject:Date:In-Reply-To:References:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=esGuAjOISW5Ke2LLVzLsm/cP//8zLC22AueMoNNdbrg+heE9GPb+EwtNKN7BYKyaZ
	 Eo/GsyL3jexmx+e/Ra6Jprh6CcnbuMk2fJdRYHoIstFchfOz46pN0rLbjc8zxSzlSb
	 TiocCHJXyFmps7IP7hYlOgTpACV0YkK6NuYnhNoM1yVarviPpyKVXt3T3XjGCpt5j+
	 8bny4DU7WHT1sGF9dRYtUb/ohAQZ8txcSMGL8Xhs7/P0Fwx7Bu8dekP7MJo/4FuHlA
	 hhoXo0tIYQoG2v8Ajgy4g5IREQmSFhWLKWCT2sWDRsiJlMkgJT+ft8PZl/DoLLAUIH
	 960r8JAHKV14w==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Wy1WF1M1sz30CD
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2024 18:04:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=148.135.17.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725264279;
	cv=none; b=f7mOTRLVJrpBwgE8P8geee5BniiCIChdahi7yaCGDe29oH+uft4sODK2xmuyIeek2jJObJ4Wc++AyF9+ucs+VIUOO6mxIvDtFCMvuhWA4upy7FIw7k5xDRoRdqIqEV+3L4mAFUxVhrK8i+bCTcL7dcOFs2v6mg7lo75dpoyYMJIcch5v06F+WelN+MRq8sPWmAk966b5Cu6083sdZYpEbwwGqbDzWtznu2Mj+PSBWMHAAln7ctCVOWhzmlKStJGC95oiHsHtrwBnSOiEWogVp8AUZA4Ke2n0fF8E55klQnN0HoK7kpS3a42z5fu9uwGTKoZc4nILtnoWjtOHd35sNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725264279; c=relaxed/relaxed;
	bh=hpmJZ0s2GEZuz/a3oISuD+V2NTlGcgmVuoFToUTHIO0=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version; b=fZsYJ24JrM03TLpoVCqWQ4JrAN8hhZptG7M9FtAAL+s0Pp+Oqj9rQCIisyn1VR8J2581d3oiMJLCH4+PXKH+rWpLewFmi1qwsUQX4nCG5QHTK3AbwsylFMb+eT5CHO04jTAmw+ODDB4cFDyPzhGqKi6nHzFY2t3bvIFS0EayPf/Qeup9A5r0gQaamnxV99hos6Ykkc11FGg6YS1boubvC1NG1olWkeT7JNEIXEvn8cYBq+mcVq2XN30qK4Mh8Rbi95/AxWnFa3exk4Jw/IknQHvaxKzluefCneJwOURA1VftLAaXwzzvhmwujXHJhi2KWkrUbDKl6Ql8c68ZILXKpQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc; dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=kPqkXdrK; dkim-atps=neutral; spf=pass (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org) smtp.mailfrom=tlmp.cc
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=tlmp.cc
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=tlmp.cc header.i=@tlmp.cc header.a=rsa-sha256 header.s=dkim header.b=kPqkXdrK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=tlmp.cc (client-ip=148.135.17.20; helo=mail.tlmp.cc; envelope-from=toolmanp@tlmp.cc; receiver=lists.ozlabs.org)
Received: from mail.tlmp.cc (unknown [148.135.17.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Wy1WC3MnKz2yDt
	for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2024 18:04:39 +1000 (AEST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 221E869799;
	Mon,  2 Sep 2024 04:04:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tlmp.cc; s=dkim;
	t=1725264277; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=hpmJZ0s2GEZuz/a3oISuD+V2NTlGcgmVuoFToUTHIO0=;
	b=kPqkXdrKPGtkwYX3r4Cc1mXy3zjlXThiwlZjfcQqPYMbCc+SOWPDk6Tr611UWwAi+9yHxJ
	LQ9e9isUfcB1M+scX0dvYuiJgm6eglHj93pG96iF1lK2IX3wxLtWOWQ/oH3qMsQlzCz8kR
	WVx+JX0GTFv/2PGepJROULmUeOLb3PODPsBZ7fmVWnhV32kyJtFFZqEJCPrCn4z0yUSeuR
	8UeVchWJ0NexlbiuQw8GTmNMSOYNhB13PTFOq1I6GXHzkfFFX9a/A46smGPOPmDjwxI4Cv
	ER+kkYcLlCr3MbxUQxkPrinEkwyh0T311sMNNknkDt/mxA0Hzt94geTJsF5EOg==
To: hsiangkao@linux.alibaba.com
Subject: [PATCH V3 2/2] erofs: refactor read_inode calling convention
Date: Mon,  2 Sep 2024 16:04:17 +0800
Message-ID: <20240902080417.427993-3-toolmanp@tlmp.cc>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902080417.427993-1-toolmanp@tlmp.cc>
References: <20240902080417.427993-1-toolmanp@tlmp.cc>
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
 fs/erofs/inode.c | 120 +++++++++++++++++++++++------------------------
 1 file changed, 58 insertions(+), 62 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 40d3f4921d81..e9712af9a730 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -8,8 +8,33 @@
 
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
+
+	return inode->i_link ? 0 : -ENOMEM;
+}
+
+static int erofs_read_inode(struct inode *inode)
 {
 	struct super_block *sb = inode->i_sb;
 	struct erofs_sb_info *sbi = EROFS_SB(sb);
@@ -20,20 +45,21 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 	struct erofs_inode_compact *dic;
 	struct erofs_inode_extended *die, *copied = NULL;
 	union erofs_inode_i_u iu;
-	unsigned int ifmt;
-	int err;
+	struct erofs_buf buf;
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
@@ -54,11 +80,11 @@ static void *erofs_read_inode(struct erofs_buf *buf,
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
@@ -66,16 +92,16 @@ static void *erofs_read_inode(struct erofs_buf *buf,
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
@@ -91,11 +117,10 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 
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
@@ -119,6 +144,11 @@ static void *erofs_read_inode(struct erofs_buf *buf,
 	case S_IFREG:
 	case S_IFDIR:
 	case S_IFLNK:
+		if(S_ISLNK(inode->i_mode)) {
+			err = erofs_fill_symlink(inode, kaddr, ofs);
+			if (err)
+				goto err_out;
+		}
 		vi->raw_blkaddr = le32_to_cpu(iu.raw_blkaddr);
 		break;
 	case S_IFCHR:
@@ -165,59 +195,24 @@ static void *erofs_read_inode(struct erofs_buf *buf,
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
-
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
@@ -234,9 +229,11 @@ static int erofs_fill_inode(struct inode *inode)
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
@@ -269,7 +266,6 @@ static int erofs_fill_inode(struct inode *inode)
 #endif
 	}
 out_unlock:
-	erofs_put_metabuf(&buf);
 	return err;
 }
 
-- 
2.46.0

