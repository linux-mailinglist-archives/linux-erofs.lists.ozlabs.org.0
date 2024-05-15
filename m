Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567A68C6B69
	for <lists+linux-erofs@lfdr.de>; Wed, 15 May 2024 19:23:08 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XYYQWFbx;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Vfg6K3Rmzz3cgd
	for <lists+linux-erofs@lfdr.de>; Thu, 16 May 2024 03:23:05 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XYYQWFbx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Vfg692m3Dz30WV
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 May 2024 03:22:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1715793768; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=5BrnBlAnP4HsIckQvEl5xaIc7rj84zmME3Jpg7gzkJE=;
	b=XYYQWFbxqrRzh4XoiZH1aThhdDwzkr0IBssEy1B0pTf7r+j8xgThJ6OJmHZQg0xHadLf2+MXfAJOq6hwEflDiFQllor6cBOon4Xq7JqHylqpLCrJj0ID9/M5KnG6axhPbf/J5mEy7+NKbhopxOz5V7otptHBIyo+lJmUcoxMdvM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W6YfSd9_1715793758;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W6YfSd9_1715793758)
          by smtp.aliyun-inc.com;
          Thu, 16 May 2024 01:22:46 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/2] erofs-utils: correct the default number of workers in the usage
Date: Thu, 16 May 2024 01:22:34 +0800
Message-Id: <20240515172236.661035-1-hsiangkao@linux.alibaba.com>
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

Fixes: 59c36e7a4008 ("erofs-utils: mkfs: use all available processors by default")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mkfs/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 4c3620d..455c152 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -187,7 +187,7 @@ static void usage(int argc, char **argv)
 		"                       (and optionally dump the raw stream to X together)\n"
 #endif
 #ifdef EROFS_MT_ENABLED
-		" --workers=#           set the number of worker threads to # (default=1)\n"
+		" --workers=#           set the number of worker threads to # (default: %u)\n"
 #endif
 		" --xattr-prefix=X      X=extra xattr name prefix\n"
 		" --mount-point=X       X=prefix of target fs path (default: /)\n"
@@ -198,7 +198,7 @@ static void usage(int argc, char **argv)
 		" --fs-config-file=X    X=fs_config file\n"
 		" --block-list-file=X   X=block_list file\n"
 #endif
-		);
+		, erofs_get_available_processors() /* --workers= */);
 }
 
 static void version(void)
-- 
2.39.3

