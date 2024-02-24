Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AD1862581
	for <lists+linux-erofs@lfdr.de>; Sat, 24 Feb 2024 14:57:59 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fl/RWrgg;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ThpP12Cvsz3cG3
	for <lists+linux-erofs@lfdr.de>; Sun, 25 Feb 2024 00:57:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fl/RWrgg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:203:375::b4; helo=out-180.mta1.migadu.com; envelope-from=chengming.zhou@linux.dev; receiver=lists.ozlabs.org)
X-Greylist: delayed 544 seconds by postgrey-1.37 at boromir; Sun, 25 Feb 2024 00:57:50 AEDT
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [IPv6:2001:41d0:203:375::b4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ThpNt6G1dz3c01
	for <linux-erofs@lists.ozlabs.org>; Sun, 25 Feb 2024 00:57:50 +1100 (AEDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nhgk1xLGq4KX/ZM1rwfa07VQXn0oX30NwYq/BvwDp04=;
	b=fl/RWrggsb1lT23NO1RkWdvVun6tHSIULezh29Wj5sdbZDIbimQXihiTJ/TYDYuVSpgTUf
	xNrVYfDyUsd7UO0ltzy9rp3FfJEsstIkLMGalkZrHm/2aDPm0ANm3586REIj+DtM2NC8vA
	uNi52abAQJbIiC4SFfiaP+oHFRKV8AA=
From: chengming.zhou@linux.dev
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	jefflexu@linux.alibaba.com
Subject: [PATCH] erofs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:47:49 +0000
Message-Id: <20240224134749.829361-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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
Cc: Xiongwei.Song@windriver.com, roman.gushchin@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, chengming.zhou@linux.dev, linux-erofs@lists.ozlabs.org, vbabka@suse.cz, Chengming Zhou <zhouchengming@bytedance.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

From: Chengming Zhou <zhouchengming@bytedance.com>

The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
its usage so we can delete it from slab. No functional change.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 fs/erofs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 9b4b66dcdd4f..8b6bf9ae1a59 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -885,7 +885,7 @@ static int __init erofs_module_init(void)
 
 	erofs_inode_cachep = kmem_cache_create("erofs_inode",
 			sizeof(struct erofs_inode), 0,
-			SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT,
+			SLAB_RECLAIM_ACCOUNT | SLAB_ACCOUNT,
 			erofs_inode_init_once);
 	if (!erofs_inode_cachep)
 		return -ENOMEM;
-- 
2.40.1

