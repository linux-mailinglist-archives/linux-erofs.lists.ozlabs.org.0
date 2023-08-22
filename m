Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B833783CCF
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Aug 2023 11:25:25 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RVP8G73G9z3by9
	for <lists+linux-erofs@lfdr.de>; Tue, 22 Aug 2023 19:25:18 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=jefflexu@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RVP834S1Xz2y1b
	for <linux-erofs@lists.ozlabs.org>; Tue, 22 Aug 2023 19:25:05 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VqM0o58_1692696299;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VqM0o58_1692696299)
          by smtp.aliyun-inc.com;
          Tue, 22 Aug 2023 17:25:00 +0800
From: Jingbo Xu <jefflexu@linux.alibaba.com>
To: xiang@kernel.org,
	linux-erofs@lists.ozlabs.org
Subject: [PATCH v3 02/11] erofs-utils: lib: scan devtable if extra_devices is not specified
Date: Tue, 22 Aug 2023 17:24:48 +0800
Message-Id: <20230822092457.114686-3-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20230822092457.114686-1-jefflexu@linux.alibaba.com>
References: <20230822092457.114686-1-jefflexu@linux.alibaba.com>
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

Scan the devtable (if any) automatically when reading superblock from
disk if sbi->extra_devices is not specified, and initialize
sbi->extra_devices with the number of on-disk device slots.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 lib/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/super.c b/lib/super.c
index 4fe81c3..fc709fc 100644
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
-- 
2.19.1.6.gb485710b

