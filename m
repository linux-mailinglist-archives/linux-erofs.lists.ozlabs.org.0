Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBD5906207
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jun 2024 04:37:34 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Af2DBdIR;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W0655490Nz3cTb
	for <lists+linux-erofs@lfdr.de>; Thu, 13 Jun 2024 12:37:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Af2DBdIR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W064v2JSFz30Wh
	for <linux-erofs@lists.ozlabs.org>; Thu, 13 Jun 2024 12:37:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718246233; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=hkjuegaPKL/WUNMWmNlE9DhijNPIpdtdltT9iCVQ7kg=;
	b=Af2DBdIRMUiL4MwtMz/MWcX//O6ICg0mhirNul4yDjB1Kizl/yAhO7rtXJmv0E+0BV6DGsk8PRmlek7tNMlXvgTJGYLqiTH5maaYj+E1f1vPKWvDt9BRrmT25FifFLBLYd5ruR2AEHKtRbvnhv2y6Iz9h9i+FmtvG7MP8Lh6q30=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W8MQVZM_1718246227;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W8MQVZM_1718246227)
          by smtp.aliyun-inc.com;
          Thu, 13 Jun 2024 10:37:11 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix incorrect i_nlink in the unified rebuild logic
Date: Thu, 13 Jun 2024 10:37:06 +0800
Message-Id: <20240613023706.1269816-1-hsiangkao@linux.alibaba.com>
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

Fixes: 203c847cc7d1 ("erofs-utils: unify the tree traversal for the rebuild mode")
Closes: https://github.com/erofs/erofsnightly/actions/runs/9492427961/job/26159566596
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/inode.c b/lib/inode.c
index 7d4ccc4..9219759 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1386,7 +1386,7 @@ static int erofs_rebuild_handle_directory(struct erofs_inode *dir)
 	int ret;
 
 	nr_subdirs = 0;
-	i_nlink = 2;
+	i_nlink = 0;
 	list_for_each_entry_safe(d, n, &dir->i_subdirs, d_child) {
 		if (cfg.c_ovlfs_strip && erofs_inode_is_whiteout(d->inode)) {
 			erofs_dbg("remove whiteout %s", d->inode->i_srcpath);
@@ -1399,6 +1399,8 @@ static int erofs_rebuild_handle_directory(struct erofs_inode *dir)
 		++nr_subdirs;
 	}
 
+	DBG_BUGON(i_nlink < 2);		/* should have `.` and `..` */
+	DBG_BUGON(nr_subdirs < i_nlink);
 	ret = erofs_prepare_dir_layout(dir, nr_subdirs);
 	if (ret)
 		return ret;
-- 
2.39.3

