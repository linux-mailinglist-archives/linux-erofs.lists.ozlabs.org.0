Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 509298C6B6C
	for <lists+linux-erofs@lfdr.de>; Wed, 15 May 2024 19:23:38 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mNk+/DlU;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vfg6v5VKhz3cjX
	for <lists+linux-erofs@lfdr.de>; Thu, 16 May 2024 03:23:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mNk+/DlU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vfg6q2BK3z30WV
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 May 2024 03:23:30 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715793807; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=F7Gx2J+AytGH7Ea6tYwXHCMeAV5ZOlJBxyruWF9lOnM=;
	b=mNk+/DlUBZEgkARDO3zPQwP1jsfYzn4XH7B54qzHilvify+kqCJ8uBHEg4VIGqKKqeI6zc3RrVriDdreAu9X3dJRhWNLu3vienj/bw2+tQRRu04QwHW6Mo6tWkGRa2HO5MkZF3IPEFdPJVEA/kAmdk9Say9gJVnrPUee3AEDPns=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W6YfSm8_1715793799;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W6YfSm8_1715793799)
          by smtp.aliyun-inc.com;
          Thu, 16 May 2024 01:23:25 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: pretty root directory progressinfo
Date: Thu, 16 May 2024 01:23:13 +0800
Message-Id: <20240515172313.661530-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240515172236.661035-1-hsiangkao@linux.alibaba.com>
References: <20240515172236.661035-1-hsiangkao@linux.alibaba.com>
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

Avoid `Processing  ...` or `file  dumped (mode 40755)`..

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/inode.c b/lib/inode.c
index 8ec87e6..67a572d 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -1405,10 +1405,11 @@ static int erofs_rebuild_handle_directory(struct erofs_inode *dir)
 
 static int erofs_mkfs_handle_inode(struct erofs_inode *inode)
 {
+	const char *relpath = erofs_fspath(inode->i_srcpath);
 	char *trimmed;
 	int ret;
 
-	trimmed = erofs_trim_for_progressinfo(erofs_fspath(inode->i_srcpath),
+	trimmed = erofs_trim_for_progressinfo(relpath[0] ? relpath : "/",
 					      sizeof("Processing  ...") - 1);
 	erofs_update_progressinfo("Processing %s ...", trimmed);
 	free(trimmed);
@@ -1442,8 +1443,7 @@ static int erofs_mkfs_handle_inode(struct erofs_inode *inode)
 	} else {
 		ret = erofs_mkfs_handle_directory(inode);
 	}
-	erofs_info("file %s dumped (mode %05o)", erofs_fspath(inode->i_srcpath),
-		   inode->i_mode);
+	erofs_info("file /%s dumped (mode %05o)", relpath, inode->i_mode);
 	return ret;
 }
 
-- 
2.39.3

