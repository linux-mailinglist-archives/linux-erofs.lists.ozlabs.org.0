Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F69994C242
	for <lists+linux-erofs@lfdr.de>; Thu,  8 Aug 2024 18:04:03 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nRI5yJZb;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WfsKr6gPWz2yWr
	for <lists+linux-erofs@lfdr.de>; Fri,  9 Aug 2024 02:04:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=nRI5yJZb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WfsKm5znwz2yMb
	for <linux-erofs@lists.ozlabs.org>; Fri,  9 Aug 2024 02:03:54 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723133030; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XnnKyVWpDm0n/vM/D+DUWilgQf7PA9B63pdxdLMW7j8=;
	b=nRI5yJZbiPmS3EHnTkHRY9G5dKDyKryFx7sSKpeSwbxNNZROKt3qtCiBoFO3QqsV7lnmlPvcJEbH1e5pUefcMFd1UGVtXmqCIku2k6+roDkg0Cqos7d6SaivKuFgugVTDNJYBa16Jm/7zdCoqiHl/btgRtVoz3rTgBa39skuXaQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0WCN1Isi_1723133024;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WCN1Isi_1723133024)
          by smtp.aliyun-inc.com;
          Fri, 09 Aug 2024 00:03:48 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: fix global-buffer-overflow due to invalid device
Date: Fri,  9 Aug 2024 00:03:43 +0800
Message-ID: <20240808160343.2544426-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Fuzzer generates an image with crafted chunks of some invalid device.
Also refine the printed message of EOD.

Closes: https://github.com/erofs/erofsnightly/actions/runs/10172576269/job/28135408276
Closes: https://github.com/erofs/erofs-utils/issues/11
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/io.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/lib/io.c b/lib/io.c
index 6bfae69..fbeff03 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -342,6 +342,10 @@ ssize_t erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
 	ssize_t read;
 
 	if (device_id) {
+		if (device_id >= sbi->nblobs) {
+			erofs_err("invalid device id %u", device_id);
+			return -EIO;
+		}
 		read = erofs_io_pread(&((struct erofs_vfile) {
 				.fd = sbi->blobfd[device_id - 1],
 			}), buf, offset, len);
@@ -352,7 +356,8 @@ ssize_t erofs_dev_read(struct erofs_sb_info *sbi, int device_id,
 	if (read < 0)
 		return read;
 	if (read < len) {
-		erofs_info("reach EOF of device, pading with zeroes");
+		erofs_info("reach EOF of device @ %llu, pading with zeroes",
+			   offset | 0ULL);
 		memset(buf + read, 0, len - read);
 	}
 	return 0;
-- 
2.43.5

