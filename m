Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3F5785145
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Aug 2023 09:15:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RVyDH39RNz3c1L
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Aug 2023 17:15:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RVyCy6ST3z3bw4
	for <linux-erofs@lists.ozlabs.org>; Wed, 23 Aug 2023 17:15:26 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VqPT4RW_1692774919;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VqPT4RW_1692774919)
          by smtp.aliyun-inc.com;
          Wed, 23 Aug 2023 15:15:20 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v4 02/10] erofs-utils: lib: keep erofs_init_devices in sync with kernel
Date: Wed, 23 Aug 2023 15:15:09 +0800
Message-Id: <20230823071517.12303-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230823071517.12303-1-jefflexu@linux.alibaba.com>
References: <20230823071517.12303-1-jefflexu@linux.alibaba.com>
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

Keep erofs_init_devices() in sync with kernel erofs_scan_devices()[1],
which scans the devtable (if any) automatically if sbi->extra_devices is
not explicitly specified.

Also fix the missing le32_to_cpu() when parsing the device slot.  Read
and cache the number of blocks of each device for later use.

Fixes: 0ce853a01123 ("erofs-utils: fuse: add multiple device support")
[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ba73eadd23d1c
Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 lib/super.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/lib/super.c b/lib/super.c
index 21dc51f..fc709fc 100644
--- a/lib/super.c
+++ b/lib/super.c
@@ -37,7 +37,8 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 	else
 		ondisk_extradevs = le16_to_cpu(dsb->extra_devices);
 
-	if (ondisk_extradevs != sbi->extra_devices) {
+	if (sbi->extra_devices &&
+	    ondisk_extradevs != sbi->extra_devices) {
 		erofs_err("extra devices don't match (ondisk %u, given %u)",
 			  ondisk_extradevs, sbi->extra_devices);
 		return -EINVAL;
@@ -45,6 +46,7 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
 	if (!ondisk_extradevs)
 		return 0;
 
+	sbi->extra_devices = ondisk_extradevs;
 	sbi->device_id_mask = roundup_pow_of_two(ondisk_extradevs + 1) - 1;
 	sbi->devs = calloc(ondisk_extradevs, sizeof(*sbi->devs));
 	if (!sbi->devs)
@@ -60,8 +62,9 @@ static int erofs_init_devices(struct erofs_sb_info *sbi,
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

