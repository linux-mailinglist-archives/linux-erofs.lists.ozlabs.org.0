Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A818A9048C6
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jun 2024 04:16:43 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qmzaQzvr;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VzTgX3bpLz3dWS
	for <lists+linux-erofs@lfdr.de>; Wed, 12 Jun 2024 12:16:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qmzaQzvr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VzTgN65q9z3cTw
	for <linux-erofs@lists.ozlabs.org>; Wed, 12 Jun 2024 12:16:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718158585; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=4OoyvooNhHIcNgc2OhPup93d9I/EjOmz/qcbbDfR08Y=;
	b=qmzaQzvrf2ubek8NroAAEOoTOQQv+GFeD5sMSLFHS/PFESSR7WBpEjZjW1ajH1MLYs6lLKwrNR8m7jjtnbSU9pZwrZ9gCScXRSBtiyiSR5jIIV/RJ75gml7yGWlBpz+cwZT4gjRQR8LtrNgZEs+qqU2AYdZXfhX6dTd2L4ZgPFk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8IJC8X_1718158578;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8IJC8X_1718158578)
          by smtp.aliyun-inc.com;
          Wed, 12 Jun 2024 10:16:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix the current rebuild mode
Date: Wed, 12 Jun 2024 10:16:17 +0800
Message-Id: <20240612021617.4025762-1-hsiangkao@linux.alibaba.com>
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

`inode->with_diskbuf` can be false in the rebuild mode since
inode data has been mapped before.

Fixes: 203c847cc7d1 ("erofs-utils: unify the tree traversal for the rebuild mode")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 3c29bd2..09bf76b 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1148,7 +1148,7 @@ static int erofs_mkfs_handle_nondirectory(struct erofs_mkfs_job_ndir_ctx *ctx)
 		ret = erofs_write_file_from_buffer(inode, symlink);
 		free(symlink);
 		inode->i_link = NULL;
-	} else if (inode->i_size) {
+	} else if (inode->i_size && ctx->fd >= 0) {
 		ret = erofs_mkfs_job_write_file(ctx);
 	}
 	if (ret)
@@ -1484,10 +1484,11 @@ static int erofs_rebuild_handle_inode(struct erofs_inode *inode)
 		return ret;
 
 	if (!S_ISDIR(inode->i_mode)) {
-		struct erofs_mkfs_job_ndir_ctx ctx = { .inode = inode };
+		struct erofs_mkfs_job_ndir_ctx ctx =
+			{ .inode = inode, .fd = -1 };
 
-		if (!S_ISLNK(inode->i_mode) && inode->i_size) {
-			DBG_BUGON(!inode->with_diskbuf);
+		if (!S_ISLNK(inode->i_mode) && inode->i_size &&
+		    inode->with_diskbuf) {
 			ctx.fd = erofs_diskbuf_getfd(inode->i_diskbuf, &ctx.fpos);
 			if (ctx.fd < 0)
 				return ret;
-- 
2.39.3

