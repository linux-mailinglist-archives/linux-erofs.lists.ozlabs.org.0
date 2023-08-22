Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A9013783E92
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Aug 2023 13:05:47 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RVRN8704nz30hh
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Aug 2023 21:05:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RVRN40cMmz2ytJ
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Aug 2023 21:05:38 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VqMKLwI_1692702330;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VqMKLwI_1692702330)
          by smtp.aliyun-inc.com;
          Tue, 22 Aug 2023 19:05:31 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: release ztailpacking pclusters properly
Date: Tue, 22 Aug 2023 19:05:30 +0800
Message-Id: <20230822110530.96831-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
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
Cc: huyue2@coolpad.com, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Currently ztailpacking pclusters are chained with FOLLOWED_NOINPLACE and
not recorded into the managed_pslots XArray.

After commit 7674a42f35ea ("erofs: use struct lockref to replace
handcrafted approach"), ztailpacking pclusters won't be freed with
erofs_workgroup_put() anymore, which will cause the following issue:

BUG erofs_pcluster-1 (Tainted: G           OE     ): Objects remaining in erofs_pcluster-1 on __kmem_cache_shutdown()

Use z_erofs_free_pcluster() directly to free ztailpacking pclusters.

Fixes: 7674a42f35ea ("erofs: use struct lockref to replace handcrafted approach")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/zdata.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index de4f12152b62..5419405cafb3 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1410,7 +1410,10 @@ static void z_erofs_decompress_queue(const struct z_erofs_decompressqueue *io,
 		owned = READ_ONCE(be.pcl->next);
 
 		z_erofs_decompress_pcluster(&be, io->eio ? -EIO : 0);
-		erofs_workgroup_put(&be.pcl->obj);
+		if (z_erofs_is_inline_pcluster(be.pcl))
+			z_erofs_free_pcluster(be.pcl);
+		else
+			erofs_workgroup_put(&be.pcl->obj);
 	}
 }
 
-- 
2.19.1.6.gb485710b

