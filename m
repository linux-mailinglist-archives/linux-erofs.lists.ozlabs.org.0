Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTP id D7D038CCAE7
	for <lists+linux-erofs@lfdr.de>; Thu, 23 May 2024 05:01:42 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wCEbwlNZ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VlCVP4wTbz78s6
	for <lists+linux-erofs@lfdr.de>; Thu, 23 May 2024 12:56:13 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=wCEbwlNZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VlCVH2P9bz78rh
	for <linux-erofs@lists.ozlabs.org>; Thu, 23 May 2024 12:56:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716432960; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OafFSAKGS/yPXL/ahcsJ0Px3w3V7Fmuu853k/LZsAtY=;
	b=wCEbwlNZ23l/qR1Et+o4ni+PJzxi3JIcTI0a6ATFo0ldFgTOWjuZqmtSuRsPpZD0is6JmY7Bb0aRRYUWnfHCYJMy6fReVaOqj4Xie6zBxGWMspQ5eLcrUCqDqe91AfrX99VPtOfdiGu6XIXHfo/EKIalLSVdOBXIgRXsB3E4dv0=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W716Hru_1716432951;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W716Hru_1716432951)
          by smtp.aliyun-inc.com;
          Thu, 23 May 2024 10:55:58 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: fix uncompressed packed inode
Date: Thu, 23 May 2024 10:55:50 +0800
Message-Id: <20240523025550.2447091-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
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

Currently, packed inode can be used in the unencoded way too such
as xattr prefixes.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index cbe0810..cd48e55 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1710,24 +1710,24 @@ struct erofs_inode *erofs_mkfs_build_special_from_fd(int fd, const char *name)
 		inode->nid = inode->sbi->packed_nid;
 	}
 
-	ictx = erofs_begin_compressed_file(inode, fd, 0);
-	if (IS_ERR(ictx))
-		return ERR_CAST(ictx);
+	if (cfg.c_compr_opts[0].alg &&
+	    erofs_file_is_compressible(inode)) {
+		ictx = erofs_begin_compressed_file(inode, fd, 0);
+		if (IS_ERR(ictx))
+			return ERR_CAST(ictx);
+
+		DBG_BUGON(!ictx);
+		ret = erofs_write_compressed_file(ictx);
+		if (ret && ret != -ENOSPC)
+			 return ERR_PTR(ret);
 
-	DBG_BUGON(!ictx);
-	ret = erofs_write_compressed_file(ictx);
-	if (ret == -ENOSPC) {
 		ret = lseek(fd, 0, SEEK_SET);
 		if (ret < 0)
 			return ERR_PTR(-errno);
-
-		ret = write_uncompressed_file_from_fd(inode, fd);
 	}
-
-	if (ret) {
-		DBG_BUGON(ret == -ENOSPC);
+	ret = write_uncompressed_file_from_fd(inode, fd);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 	erofs_prepare_inode_buffer(inode);
 	erofs_write_tail_end(inode);
 	return inode;
-- 
2.39.3

