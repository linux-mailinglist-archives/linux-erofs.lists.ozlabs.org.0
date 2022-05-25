Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C005337E2
	for <lists+linux-erofs@lfdr.de>; Wed, 25 May 2022 10:00:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L7Nlb6Rtdz3bg4
	for <lists+linux-erofs@lfdr.de>; Wed, 25 May 2022 18:00:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.45;
 helo=out30-45.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L7NlS2TpWz303H
 for <linux-erofs@lists.ozlabs.org>; Wed, 25 May 2022 18:00:00 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=4; SR=0; TI=SMTPD_---0VEMXST1_1653465590; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0VEMXST1_1653465590) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 25 May 2022 15:59:50 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs: leave compressed inodes unsupported in fscache mode
 for now
Date: Wed, 25 May 2022 15:59:50 +0800
Message-Id: <20220525075950.21535-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

erofs over fscache doesn't support the compressed layout yet. It will
cause NULL crash if there are compressed inodes contained when working
in fscache mode.

So far in the erofs based container image distribution scenarios
(RAFS v6), the compressed images are downloaded to local and then
decompressed as a erofs image of uncompressed layout. Then the erofs
image is mounted in fscache mode and serves as the container image. Thus
the current implementation won't break the container image distribution
scenarios.

The fscache support for the compressed layout is still under
development. Anyway, to avoid the potential crash, let's leave the
compressed inodes unsupported in fscache mode until we support it later.

Fixes: 1442b02b66ad ("erofs: implement fscache-based data read for non-inline layout")
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
index bcc8335b46b3..95a403720e8c 100644
--- a/fs/erofs/inode.c
+++ b/fs/erofs/inode.c
@@ -288,7 +288,10 @@ static int erofs_fill_inode(struct inode *inode, int isdir)
 	}
 
 	if (erofs_inode_is_data_compressed(vi->datalayout)) {
-		err = z_erofs_fill_inode(inode);
+		if (!erofs_is_fscache_mode(inode->i_sb))
+			err = z_erofs_fill_inode(inode);
+		else
+			err = -EOPNOTSUPP;
 		goto out_unlock;
 	}
 	inode->i_mapping->a_ops = &erofs_raw_access_aops;
-- 
2.27.0

