Return-Path: <linux-erofs+bounces-488-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BE1AE73FB
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Jun 2025 02:53:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bRjww6BbGz2xKh;
	Wed, 25 Jun 2025 10:53:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750812800;
	cv=none; b=blQY5t1PPIlHPSA3OM1dRjf1PlLHd3J8cx1waxQfoure4OXL3KcVcEv/xggQ401uVv4ohYXRx+F1dUiIUY/QzkUpim00V1fbeCjVSgHzBJ1E/WvMsUIc7ioRcM6YQXnezmmn+Cz+bMkW/0qDHbail1TSAXDXFBxsu+ltaWh+DHQyFDKGDOJxTmrH3YMoHJIdvXE+dkkbEIxnUwwZXekD5L2ZCo2TQ3PTNbtRp09u8WBq2fdgTSDJjJCtbhO+LOvj7PVzJ1MO28N3qko7qAhd/VvjWGJ7lB6LqAaXvALQf6PpN9YKEM7gz9apnEEO+mpYX3AXtY1bcY19mHMl0/O7RA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750812800; c=relaxed/relaxed;
	bh=aONEC6MZuzq8TrzhiTvlPJ8vHFUEhoEiUkpbKqCd7HY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/4/TkGEdGyQPxD6EmGjyIroSY2XvBVfkPJC8gk5uvJgEbLDdgOEqKUYt4Q6PgiIJX5zRmO5RGGsw8ky088R+sbnr/00A6/5ohj7Fm9aabjNpt/jCAEAMdNcctcS4uUG2wDtgVcijts1QWCWQ6KVHu0wBLmXTCs40yuw0OKCLpYYezTBzhBjTXTwLoWn5xP6rzYuhKBUhG4zT3Hdq4T/eZiHM/s60jnVpCKvsTj6BUmBp4RdqrorkW/o2xAsRbtExRUH2+tmo47Ilc44sTwTwTduGRkPIL0YdwxrAmTcIsZ8aeAc1sZVC9qFfHc1xaIWp9Gj5Hwh0CFASTDpNkDd1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ERs6mamX; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ERs6mamX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bRjwv2S1Gz2xHT
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Jun 2025 10:53:18 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750812794; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=aONEC6MZuzq8TrzhiTvlPJ8vHFUEhoEiUkpbKqCd7HY=;
	b=ERs6mamXANosGqfZsJrNYkrfds9wANttc5+FgnZ0MOm6OvvzQtjSAG8xVRDj5gLCAAvUcIxxW1Ss0cimrz6g7fyIXONXVH99Db1Ep3m6UU16XgfhvUwRvAfMwbIRGvAV1H5owm1aXWcjR0lCaklc0+QsWc6Jb5e6tgkM4XsYmDM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WepYYO-_1750812788 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Jun 2025 08:53:13 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mkfs: fix AUFS whiteouts for tarerofs
Date: Wed, 25 Jun 2025 08:53:07 +0800
Message-ID: <20250625005307.1225994-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Fix the misuse strcmp() for whiteouts.

Fixes: 73e321a0fb3b ("erofs-utils: lib: consolidate erofs_rebuild_get_dentry()")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/rebuild.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/rebuild.c b/lib/rebuild.c
index 6ae5ddf..576d9d0 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -113,7 +113,7 @@ struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
 					*opq = true;
 					break;
 				}
-				if (!strcmp(s, AUFS_WH_PFX)) {
+				if (!strncmp(s, AUFS_WH_PFX, sizeof(AUFS_WH_PFX) - 1)) {
 					s += sizeof(AUFS_WH_PFX) - 1;
 					*whout = true;
 				}
-- 
2.43.5


