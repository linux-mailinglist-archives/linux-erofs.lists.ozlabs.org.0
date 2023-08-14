Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23E277B03C
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 05:43:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RPKx6526sz3bWW
	for <lists+linux-erofs@lfdr.de>; Mon, 14 Aug 2023 13:43:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RPKwp5hK0z2yD6
	for <linux-erofs@lists.ozlabs.org>; Mon, 14 Aug 2023 13:42:50 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R951e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vpelypi_1691984564;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0Vpelypi_1691984564)
          by smtp.aliyun-inc.com;
          Mon, 14 Aug 2023 11:42:45 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH 04/13] erofs-utils: lib: fix erofs_init_devices() in multidev mode
Date: Mon, 14 Aug 2023 11:42:30 +0800
Message-Id: <20230814034239.54660-5-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230814034239.54660-1-jefflexu@linux.alibaba.com>
References: <20230814034239.54660-1-jefflexu@linux.alibaba.com>
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

Fix the missing le32_to_cpu().  Read and cache blocks of each device for
later use.

Initialize sbi->extra_devices from on-disk extra_devices.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 lib/super.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/lib/super.c b/lib/super.c
index e8e84aa..54ab29b 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -36,11 +36,7 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 	else
 		ondisk_extradevs = le16_to_cpu(dsb->extra_devices);
 
-	if (ondisk_extradevs != sbi->extra_devices) {
-		erofs_err("extra devices don't match (ondisk %u, given %u)",
-			  ondisk_extradevs, sbi->extra_devices);
-		return -EINVAL;
-	}
+	sbi->extra_devices = ondisk_extradevs;
 	if (!ondisk_extradevs)
 		return 0;
 
@@ -59,8 +55,9 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 			return ret;
 		}
 
-		sbi->devs[i].mapped_blkaddr = dis.mapped_blkaddr;
-		sbi->total_blocks += dis.blocks;
+		sbi->devs[i].mapped_blkaddr = le32_to_cpu(dis.mapped_blkaddr);
+		sbi->devs[i].blocks = le32_to_cpu(dis.blocks);
+		sbi->total_blocks += sbi->devs[i].blocks;
 		pos += EROFS_DEVT_SLOT_SIZE;
 	}
 	return 0;
-- 
2.19.1.6.gb485710b

