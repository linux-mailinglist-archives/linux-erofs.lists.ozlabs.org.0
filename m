Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D93B9655AC
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2024 05:29:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Ww3XY0qGvz30gn
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2024 13:29:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1724988537;
	cv=none; b=VjcwLHbWZWS1cMB3B0Wt7FBaXBE1vTZbwpN/ntzLvWBXOAqjss2qiY3C25BdyqX5MjJcGYa9qkHryN/tiQstwSbV4TXfCHPu66w0mDSKGsLRWskgiy41ge+xKXDlHJ/YLAuNZGASuND4SPKPj8Ze2nwv9ROEDXeOgYrUsTh4d9XDGTICzd4lyKBNKprcG8DtsrZ26F+iCnE9167378U2L+iqg9+he1RK82Mg7pvEkB/pQ1kn9aSN0Wemmg4EpLf2mrQSgC29UQbopOqOcEqvflwULG0Nb3p1/NYrE+mAc4joA6mGA3Ymmq1z99v5O/WzoDsgYbPIyFpKcvNjtw5Smg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1724988537; c=relaxed/relaxed;
	bh=R2o1Xvz//mBMciOPxIeDZEVRY86N9pEjsxHkBqVbrhc=;
	h=DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=Q+IpCFbKRMpZxuut8jNHs7H7rf+gADsk+XTnUymQYkj5gjAEY4RTgR5P5PLb+2vDvam1E0Q3b6zpotakvdILEdAZ7UXEuStqT+fOKt59frFiVmWWjVPrHefJT84+Gx6Wv1NCSPFfBh6KQ81j2Tq4g0pu5yfLzMaW3lhpJMqs9//q1qPRguNo+vHOyku5/h/W791xCx5phH6XwMSBPrhn0RF/3jejeltWlTf8MeKV3ehjyQumms74jBhqDsukbAy728mxhDhgGCX8Z7ZWT4mePnKIRa+TsA2A4epBuldufHHxDgWMIchcLt5e7UVVF6qjUTQIPkrkC/VvTi5JrD5DkQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iIs3oOca; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=iIs3oOca;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Ww3XS6YYsz2xdX
	for <linux-erofs@lists.ozlabs.org>; Fri, 30 Aug 2024 13:28:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1724988532; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=R2o1Xvz//mBMciOPxIeDZEVRY86N9pEjsxHkBqVbrhc=;
	b=iIs3oOcaIN2S/tSjBeLaL8FZL5JDbKH+2dxdEP17aCa7TproNwdhLbL/62a3/tqL3m+LQOFS1yLbQz88bNDgzbBtfsuZuBB+cF5Vzs6+fPFDCP6tx3QXMLckmgSLXhzODltZDTOyU8o7FXOkENyPlQbG7zFOv6iHoCbGFVAHOlc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WDv3lt0_1724988530)
          by smtp.aliyun-inc.com;
          Fri, 30 Aug 2024 11:28:51 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH v2 4/4] erofs: mark experimental fscache backend deprecated
Date: Fri, 30 Aug 2024 11:28:40 +0800
Message-ID: <20240830032840.3783206-4-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
References: <20240830032840.3783206-1-hsiangkao@linux.alibaba.com>
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

Although fscache is still described as "General Filesystem Caching" for
network filesystems and other things such as ISO9660 filesystems, it has
actually become a part of netfslib recently, which was unexpected at the
time when "EROFS over fscache" proposed (2021) since EROFS is entirely a
disk filesystem and the dependency is redundant.

Mark it deprecated and it will be removed after "fanotify pre-content
hooks" lands, which will provide the same functionality for EROFS.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/Kconfig | 5 ++++-
 fs/erofs/super.c | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/Kconfig b/fs/erofs/Kconfig
index 1428d0530e1c..6ea60661fa55 100644
--- a/fs/erofs/Kconfig
+++ b/fs/erofs/Kconfig
@@ -145,7 +145,7 @@ config EROFS_FS_ZIP_ZSTD
 	  If unsure, say N.
 
 config EROFS_FS_ONDEMAND
-	bool "EROFS fscache-based on-demand read support"
+	bool "EROFS fscache-based on-demand read support (deprecated)"
 	depends on EROFS_FS
 	select NETFS_SUPPORT
 	select FSCACHE
@@ -155,6 +155,9 @@ config EROFS_FS_ONDEMAND
 	  This permits EROFS to use fscache-backed data blobs with on-demand
 	  read support.
 
+	  It is now deprecated and scheduled to be removed from the kernel
+	  after fanotify pre-content hooks are landed.
+
 	  If unsure, say N.
 
 config EROFS_FS_PCPU_KTHREAD
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9a7e67eceed4..666873f745da 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -353,7 +353,7 @@ static int erofs_read_superblock(struct super_block *sb)
 	ret = erofs_scan_devices(sb, dsb);
 
 	if (erofs_is_fscache_mode(sb))
-		erofs_info(sb, "EXPERIMENTAL fscache-based on-demand read feature in use. Use at your own risk!");
+		erofs_info(sb, "[deprecated] fscache-based on-demand read feature in use. Use at your own risk!");
 out:
 	erofs_put_metabuf(&buf);
 	return ret;
-- 
2.43.5

