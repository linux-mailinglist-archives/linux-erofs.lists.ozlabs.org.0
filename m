Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3C039764B4
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Sep 2024 10:35:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X49kd5Smsz2yY9
	for <lists+linux-erofs@lfdr.de>; Thu, 12 Sep 2024 18:35:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726130151;
	cv=none; b=BMqBQN0O3zm8J0vXws7Ku3k9iaGqA86ObmQGb2VqDTsTnSx8bdK99PbzlMdOXwx7ESLJA1pzz/Xon2V8uPkfTBvPG11QLO/YS+pXKtsIUbvjyEEQqnKhSPl8IsmAsawCCRdKQMleb7qU7rVgh1AI8N+d74A9f8xEd6rwmrwoChcdjoz3UI8zG/S1zxj8poxC1VHMdk5GewaqYVu/b9F4n5e8RJ3R47YRZVOoNcji75Bj348WjhY9nrQWTLkF4iR6ZdruykrahcxE0D1wgfcGYfWjUQfFfst6M3l6k2qKZZp8RNjiRYJRRsWRs3uG/j+Qtzou3C9RbLbK52w1xr3jGA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726130151; c=relaxed/relaxed;
	bh=OQSX4JcrAXPvNnaJnPYb8rHWwXAA63xuZRYJXlbO310=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ownziL9kTWGusIEcmElb74hecnblx6ETsqyB/Bc+An5iwkU26jL6zPC72YPFmXAY/2E/tzmnKBZiM7qL3rvGF6K0DnkllClkvyKO01EMGNIDLPLXpA6U6PGooEvsfV40qkDyBYjVbdZ6s+Y5dShHYTdJJXKVWpX9AoilXs1v70Iaanmo4Lj2atC5G2+HnjpjYnpE1Z8D1nBn+7qoO8YMPBZhe6Ly5pLew6EVENk7pczI0waVIbFwhTKuB6ZE5mDyX82TTM8C5bKfsF9Ibjh9wu/R75Zxl1ucCeTcJPW7DYmlF135kHSHyLLOykWVv7Ma9A+wUGHEWyAbIoNdWP80GA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Mxhk8Vpi; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Mxhk8Vpi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X49kZ1MdNz2xl6
	for <linux-erofs@lists.ozlabs.org>; Thu, 12 Sep 2024 18:35:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726130145; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=OQSX4JcrAXPvNnaJnPYb8rHWwXAA63xuZRYJXlbO310=;
	b=Mxhk8VpiNgyWcFFON5nNLN2T6rnNiBsJTYB0lMMGKEx+BBNt2it8W3ghJC53P+2mdS9OuaaLuiFGSA9TBrcAYD/7M1StnArPBc+cm7b7GRPbW8zySMFGmKUxbguu3SLIUOeGSKUkSjaGHfXTN7zQnCWJfy/uT5MKEZQVJx9PVQE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEqlyhG_1726130140)
          by smtp.aliyun-inc.com;
          Thu, 12 Sep 2024 16:35:44 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: reject inodes with negative i_size
Date: Thu, 12 Sep 2024 16:35:38 +0800
Message-ID: <20240912083538.3011860-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Negative i_size is never supported, although crafted images with inodes
having negative i_size will not lead to security issues in our current
codebase:

The following image can verify this (gzip+base64 encoded):

H4sICCmk4mYAA3Rlc3QuaW1nAGNgGAWjYBSMVPDo4dcH3jP2aTED2TwMKgxMUHHNJY/SQDQX
LxcDIw3tZwXit44MDNpQ/n8gQJZ/vxjijosPuSyZ0DUDgQqcZoKzVYFsDShbHeh6PT29ktTi
Eqz2g/y2pBFiLxDMh4lhs5+W4TAKRsEoGAWjYBSMglEwCkYBPQAAS2DbowAQAAA=

Mark as bad inodes for such corrupted inodes explicitly.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/inode.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index 7a98df664814..db29190656eb 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2021, Alibaba Cloud
  */
 #include "xattr.h"
-
 #include <trace/events/erofs.h>
 
 static int erofs_fill_symlink(struct inode *inode, void *kaddr,
@@ -16,7 +15,7 @@ static int erofs_fill_symlink(struct inode *inode, void *kaddr,
 
 	m_pofs += vi->xattr_isize;
 	/* check if it cannot be handled with fast symlink scheme */
-	if (vi->datalayout != EROFS_INODE_FLAT_INLINE || inode->i_size < 0 ||
+	if (vi->datalayout != EROFS_INODE_FLAT_INLINE ||
 	    check_add_overflow(m_pofs, inode->i_size, &off) ||
 	    off > i_blocksize(inode))
 		return 0;
@@ -131,6 +130,11 @@ static int erofs_read_inode(struct inode *inode)
 		goto err_out;
 	}
 
+	if (unlikely(inode->i_size < 0)) {
+		erofs_err(sb, "negative i_size @ nid %llu", vi->nid);
+		err = -EFSCORRUPTED;
+		goto err_out;
+	}
 	switch (inode->i_mode & S_IFMT) {
 	case S_IFREG:
 	case S_IFDIR:
@@ -186,7 +190,6 @@ static int erofs_read_inode(struct inode *inode)
 		inode->i_blocks = round_up(inode->i_size, sb->s_blocksize) >> 9;
 	else
 		inode->i_blocks = nblks << (sb->s_blocksize_bits - 9);
-
 err_out:
 	DBG_BUGON(err);
 	erofs_put_metabuf(&buf);
-- 
2.43.5

