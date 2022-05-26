Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 770915347C5
	for <lists+linux-erofs@lfdr.de>; Thu, 26 May 2022 03:03:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L7qSs2r2yz3bhs
	for <lists+linux-erofs@lfdr.de>; Thu, 26 May 2022 11:03:57 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42; helo=out30-42.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4L7qSn1tdrz2yyh
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 May 2022 11:03:51 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VEPlGvz_1653527024;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VEPlGvz_1653527024)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 26 May 2022 09:03:45 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v2] erofs: leave compressed inodes unsupported in fscache mode for now
Date: Thu, 26 May 2022 09:03:44 +0800
Message-Id: <20220526010344.118493-1-jefflexu@linux.alibaba.com>
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
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

erofs over fscache doesn't support the compressed layout yet. It will
cause NULL crash if there are compressed inodes contained when working
in fscache mode.

So far in the erofs based container image distribution scenarios
(RAFS v6), the compressed RAFS v6 images are downloaded and then
decompressed on demand as an uncompressed erofs image. Then the erofs
image is mounted in fscache mode for containers to use. IOWs, currently
compressed data is decompressed on the userspace side instead and
uncompressed erofs images will be finally cached.

The fscache support for the compressed layout is still under
development and it will be used for runtime decompression feature.
Anyway, to avoid the potential crash, let's leave the compressed inodes
unsupported in fscache mode until we support it later.

Fixes: 1442b02b66ad ("erofs: implement fscache-based data read for non-inline layout")
Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
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

