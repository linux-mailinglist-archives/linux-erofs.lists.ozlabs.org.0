Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFBA9237AB
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jul 2024 10:41:19 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CeKVovZf;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WCx3T63bVz3cP3
	for <lists+linux-erofs@lfdr.de>; Tue,  2 Jul 2024 18:32:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=CeKVovZf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WCx3L55GGz30Sq
	for <linux-erofs@lists.ozlabs.org>; Tue,  2 Jul 2024 18:31:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719909110; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Q83zRyhZx02SPsTDYC2zzSV+NwN0j3Br4c1q04fQaag=;
	b=CeKVovZfhVDlHkhepRCVI53O3sTvxLJyXsQvR4bscgYGFt7W5uJpsQO8l8tSusoyKCsTn9hrY3gfjcBezv584ed8mcJ7r/qtYYl6t+V41ZPycrBbLYL2H3ic4Ts60mjNAt5A+I/5GwoqvzRDMEHr2cQqyTtTMwCdS2EtPSCH2/g=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0W9iCzJT_1719909104;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9iCzJT_1719909104)
          by smtp.aliyun-inc.com;
          Tue, 02 Jul 2024 16:31:49 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: rebuild: only update dev/i_ino[1] pairs for directories
Date: Tue,  2 Jul 2024 16:31:44 +0800
Message-ID: <20240702083144.2120808-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Hongzhen Luo <hongzhen@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Since the underlying dev/i_ino[1] pairs are only useful for merged
sub-directories, don't bother with other types of inodes.

Otherwise, the original i_ino[1] could be overwritten unexpectedly,
which impacts resvsp mode at least..

Fixes: f64d9d02576b ("erofs-utils: introduce incremental builds")
Reported-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/rebuild.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/lib/rebuild.c b/lib/rebuild.c
index 8b186eb..0b1a6c6 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -464,10 +464,13 @@ static int erofs_rebuild_basedir_dirent_iter(struct erofs_dir_context *ctx)
 	} else {
 		struct erofs_inode *inode = d->inode;
 
-		list_del(&inode->i_hash);
-		inode->dev = dir->sbi->dev;
-		inode->i_ino[1] = ctx->de_nid;
-		erofs_insert_ihash(inode);
+		/* update sub-directories only for recursively loading */
+		if (S_ISDIR(inode->i_mode)) {
+			list_del(&inode->i_hash);
+			inode->dev = dir->sbi->dev;
+			inode->i_ino[1] = ctx->de_nid;
+			erofs_insert_ihash(inode);
+		}
 	}
 	ret = 0;
 out:
-- 
2.43.5

