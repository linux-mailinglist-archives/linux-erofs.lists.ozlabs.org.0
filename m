Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 686D791493C
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jun 2024 13:59:48 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VJVkWK5Q;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W762m6pW1z3cQL
	for <lists+linux-erofs@lfdr.de>; Mon, 24 Jun 2024 21:59:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VJVkWK5Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W762Z33YCz30TZ
	for <linux-erofs@lists.ozlabs.org>; Mon, 24 Jun 2024 21:59:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719230369; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=D4hpRgMsz5Z+LU6MpsY3hkRcr50xNeWA4lj79gSNVAQ=;
	b=VJVkWK5QGPjkLqy1WZtg801XeVpAAIb1SMpkeZgJGetlRLzlVhRcMuHEmFgilLTRQYKSBZfnQfbJOfyIdIdbfqAgrZUEndZNGhvYYPL42EwzCw7jPbRNhdgZjBz0C4Vj1KLeThPWCHG29wFpgBoPqoEj60B6Vya0Esh76CemWjk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R611e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W9960gL_1719230364;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9960gL_1719230364)
          by smtp.aliyun-inc.com;
          Mon, 24 Jun 2024 19:59:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: derive i_srcpath for erofs_rebuild_mkdir()
Date: Mon, 24 Jun 2024 19:59:22 +0800
Message-Id: <20240624115923.4090196-1-hsiangkao@linux.alibaba.com>
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

Also add missing erofs_iput() on errors.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/rebuild.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/rebuild.c b/lib/rebuild.c
index 9c1e8f8..8b186eb 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -35,6 +35,11 @@ static struct erofs_dentry *erofs_rebuild_mkdir(struct erofs_inode *dir,
 	if (IS_ERR(inode))
 		return ERR_CAST(inode);
 
+	if (asprintf(&inode->i_srcpath, "%s/%s",
+		     dir->i_srcpath ? : "", s) < 0) {
+		erofs_iput(inode);
+		return ERR_PTR(-ENOMEM);
+	}
 	inode->i_mode = S_IFDIR | 0755;
 	inode->i_parent = dir;
 	inode->i_uid = getuid();
@@ -44,7 +49,9 @@ static struct erofs_dentry *erofs_rebuild_mkdir(struct erofs_inode *dir,
 	erofs_init_empty_dir(inode);
 
 	d = erofs_d_alloc(dir, s);
-	if (!IS_ERR(d)) {
+	if (IS_ERR(d)) {
+		erofs_iput(inode);
+	} else {
 		d->type = EROFS_FT_DIR;
 		d->inode = inode;
 	}
-- 
2.39.3

