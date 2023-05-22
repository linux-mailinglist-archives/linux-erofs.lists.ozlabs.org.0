Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F3D70B34E
	for <lists+linux-erofs@lfdr.de>; Mon, 22 May 2023 04:49:06 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QPhjT6NKyz3cdB
	for <lists+linux-erofs@lfdr.de>; Mon, 22 May 2023 12:49:01 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QPhjM6Gs0z3bgv
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 May 2023 12:48:54 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vj6edcd_1684723728;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vj6edcd_1684723728)
          by smtp.aliyun-inc.com;
          Mon, 22 May 2023 10:48:49 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	chao@kernel.org,
	huyue2@coolpad.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: fix the endianness of erofs_super_block
Date: Mon, 22 May 2023 10:48:48 +0800
Message-Id: <20230522024848.89861-1-jefflexu@linux.alibaba.com>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Add the missing cpu_to_le[16|32]() conversion when initializing
erofs_super_block.

Fixes: 0a94653c56b2 ("erofs-utils: introduce mkfs support")
Fixes: 116ac0a254fc ("erofs-utils: introduce shared xattr support")
Fixes: a70f35adc1b0 ("erofs-utils: introduce ondisk compression cfgs")
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 mkfs/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 61387b3..3ec4903 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -577,8 +577,8 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 		.build_time = cpu_to_le64(sbi.build_time),
 		.build_time_nsec = cpu_to_le32(sbi.build_time_nsec),
 		.blocks = 0,
-		.meta_blkaddr  = sbi.meta_blkaddr,
-		.xattr_blkaddr = sbi.xattr_blkaddr,
+		.meta_blkaddr  = cpu_to_le32(sbi.meta_blkaddr),
+		.xattr_blkaddr = cpu_to_le32(sbi.xattr_blkaddr),
 		.xattr_prefix_count = sbi.xattr_prefix_count,
 		.xattr_prefix_start = cpu_to_le32(sbi.xattr_prefix_start),
 		.feature_incompat = cpu_to_le32(sbi.feature_incompat),
@@ -599,7 +599,7 @@ int erofs_mkfs_update_super_block(struct erofs_buffer_head *bh,
 	memcpy(sb.volume_name, sbi.volume_name, sizeof(sb.volume_name));
 
 	if (erofs_sb_has_compr_cfgs())
-		sb.u1.available_compr_algs = sbi.available_compr_algs;
+		sb.u1.available_compr_algs = cpu_to_le16(sbi.available_compr_algs);
 	else
 		sb.u1.lz4_max_distance = cpu_to_le16(sbi.lz4_max_distance);
 
-- 
2.19.1.6.gb485710b

