Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F1B97C843
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Sep 2024 12:55:55 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X8XVt4Wx7z2yLJ
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Sep 2024 20:55:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1726743347;
	cv=none; b=WRZ9BJitfOdDjTNpIaJ+nAeUQyJYM7QrpviREcJW3dob3q3t+NSSXC/kJQapQgq+5WlC4l+bqnEdrYT2yfPyrooX7CjoGB7IfCLcu40Gpc9v6bGPGe1x6GH5m8yC1+sKkK/d7c6vCbgwnNhjd8iHgsiol8dOypxuTKd+kkqgpaMW6xVFuO3JYpV190SZZ2HcCItB95RNpK1GoU3CLBXwky3biRsJkg5qGRzR1iTLNIavBINkCcu97DrxpOeUI9aEGcoKcEealOEbCE0ZhO7xmTipqp+snRmKXKZLtss0qW4mNts1aF1gZ83hYcy5b3fg5eoVDXUJaCds8RXtrl4zOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1726743347; c=relaxed/relaxed;
	bh=ZGSwXi7yNk6mZEsUWMCIFIJj4hj6VXl42Te8XsHAvQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XIMXucLm4Zd/4e2gQLs9Bl+rICkQC7JxTkVfHDLxWPKhI7klHUBqjSdXKh//+DTSipCvJKHrwtNKdjWI/XKvhabX9xtXHQLHLnqQdy75X5WSmK3auIAnlxdh/smrsc1lLiDTNQ6cYpgQ7dxvElv+mAY3Tl2/M33Vc/FpAzKqVSg90QAYx5lJPCPmdQ52S52sgS6FJKRSqZJXy79JKNPF2eI3WlHWcjAfuSEMkxZnPxAII5cuddN1ujvqDhcbOevi8+4sLaBdm2/2sZBReIzm1pVH8rv5rEFyXodZkGxs3xn54F+6uLhhxKYhownamNwLe/pJR2voq3p/DMTZQLpsuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=U8rE6cJX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=U8rE6cJX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X8XVp13QSz2xLR
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Sep 2024 20:55:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1726743337; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ZGSwXi7yNk6mZEsUWMCIFIJj4hj6VXl42Te8XsHAvQ4=;
	b=U8rE6cJXUNK7KEfxOzNOO6UscToXOiZNbB25QKSOixZzxEG77uhKMQLfLuCpU9ZbYWLNVIN9hMELHH6QqNOpNQg2iY4GTFzaAxhkx40B0GouTG2+wYGIhOGP3FGhrYK+JO8rMMGCLufonHZpTjord587Ej06TAoEdc+UKnKfbbE=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WFHS3pk_1726743330)
          by smtp.aliyun-inc.com;
          Thu, 19 Sep 2024 18:55:35 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: get rid of outdated subpage compression warning
Date: Thu, 19 Sep 2024 18:55:19 +0800
Message-ID: <20240919105519.3656878-1-hsiangkao@linux.alibaba.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

It has been supported since Linux 6.8.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mkfs/main.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 7e2e184..8f1fdbc 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -965,11 +965,6 @@ static int mkfs_parse_options_cfg(int argc, char *argv[])
 		cfg.c_showprogress = false;
 	}
 
-	if (cfg.c_compr_opts[0].alg && erofs_blksiz(&g_sbi) != getpagesize())
-		erofs_warn("Please note that subpage blocksize with compression isn't yet supported in kernel. "
-			   "This compressed image will only work with bs = ps = %u bytes",
-			   erofs_blksiz(&g_sbi));
-
 	if (pclustersize_max) {
 		if (pclustersize_max < erofs_blksiz(&g_sbi) ||
 		    pclustersize_max % erofs_blksiz(&g_sbi)) {
-- 
2.43.5

