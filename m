Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048484AE9CC
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 07:01:56 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jtq5Y4fZQz3cPh
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Feb 2022 17:01:53 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jtq5K2SYzz3bV8
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Feb 2022 17:01:40 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R531e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04357; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=15; SR=0; TI=SMTPD_---0V3zaQUW_1644386491; 
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V3zaQUW_1644386491) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Feb 2022 14:01:31 +0800
From: Jeffle Xu <jefflexu@linux.alibaba.com>
To: dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
 chao@kernel.org, linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 17/22] erofs: register cookie context for data blobs
Date: Wed,  9 Feb 2022 14:01:03 +0800
Message-Id: <20220209060108.43051-18-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
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
Cc: gregkh@linuxfoundation.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
 linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
 torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Similar to the multi device mode, erofs could be mounted from multiple
blob files (one bootstrap blob file and optional multiple data blob
files). In this case, each device slot contains the path of
corresponding data blob file.

This patch registers corresponding cookie context for each data blob
file.

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
---
 fs/erofs/internal.h |  1 +
 fs/erofs/super.c    | 27 +++++++++++++++++++--------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
index 548f928b0ded..5d514c7b73cc 100644
--- a/fs/erofs/internal.h
+++ b/fs/erofs/internal.h
@@ -53,6 +53,7 @@ struct erofs_device_info {
 	struct block_device *bdev;
 	struct dax_device *dax_dev;
 	u64 dax_part_off;
+	struct erofs_fscache_context *ctx;
 
 	u32 blocks;
 	u32 mapped_blkaddr;
diff --git a/fs/erofs/super.c b/fs/erofs/super.c
index 8c5783c6f71f..f058a04a00c7 100644
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@ -250,6 +250,7 @@ static int erofs_init_devices(struct super_block *sb,
 	down_read(&sbi->devs->rwsem);
 	idr_for_each_entry(&sbi->devs->tree, dif, id) {
 		struct block_device *bdev;
+		struct erofs_fscache_context *ctx;
 
 		ptr = erofs_read_metabuf(&buf, sb, erofs_blknr(pos),
 					 EROFS_KMAP);
@@ -259,15 +260,24 @@ static int erofs_init_devices(struct super_block *sb,
 		}
 		dis = ptr + erofs_blkoff(pos);
 
-		bdev = blkdev_get_by_path(dif->path,
-					  FMODE_READ | FMODE_EXCL,
-					  sb->s_type);
-		if (IS_ERR(bdev)) {
-			err = PTR_ERR(bdev);
-			break;
+		if (erofs_bdev_mode(sb)) {
+			bdev = blkdev_get_by_path(dif->path,
+						  FMODE_READ | FMODE_EXCL,
+						  sb->s_type);
+			if (IS_ERR(bdev)) {
+				err = PTR_ERR(bdev);
+				break;
+			}
+			dif->bdev = bdev;
+			dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off);
+		} else {
+			ctx = erofs_fscache_get_ctx(sb, dif->path, false);
+			if (IS_ERR(ctx)) {
+				err = PTR_ERR(ctx);
+				break;
+			}
+			dif->ctx = ctx;
 		}
-		dif->bdev = bdev;
-		dif->dax_dev = fs_dax_get_by_bdev(bdev, &dif->dax_part_off);
 		dif->blocks = le32_to_cpu(dis->blocks);
 		dif->mapped_blkaddr = le32_to_cpu(dis->mapped_blkaddr);
 		sbi->total_blocks += dif->blocks;
@@ -694,6 +704,7 @@ static int erofs_release_device_info(int id, void *ptr, void *data)
 {
 	struct erofs_device_info *dif = ptr;
 
+	erofs_fscache_put_ctx(dif->ctx);
 	fs_put_dax(dif->dax_dev);
 	if (dif->bdev)
 		blkdev_put(dif->bdev, FMODE_READ | FMODE_EXCL);
-- 
2.27.0

