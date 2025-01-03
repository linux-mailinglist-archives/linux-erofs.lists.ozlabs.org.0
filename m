Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E665EA0066A
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Jan 2025 10:04:04 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YPd0y2HKyz3bW5
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Jan 2025 20:04:02 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735895039;
	cv=none; b=Tzhb+4P6Hy8goH+JrIj/fGyjB8JRmzcXOc/LwiVfZff0SUeMq1JLYIiwqxktQNlyUlf8A/s/uPfUqFUp8BQDlhhNzJ2LgPjOZ1n3N8qDckkESdioxcb6yzAWtLXlDYDnt+U/mswGb5enCzJ6YijLu1er7ZcVs/i66xidR8u1bnBZUAPE7g+KFQ+T4nahuHJGTtv5TYciCTtyxBmo8Z7vrNQuZAWYwh2F0d2f/qZnUQnQDU3rbpWQV7WfAo6GbQ/Df4o5Yt/wIkko4mU9yMTnaHzfE5AOijVQahzEJ3gn99PTPiHQy1PYcGTLShJN+Qr7pZTkt/fWcnxbxt/XsA1lng==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735895039; c=relaxed/relaxed;
	bh=phHQqjNsV6ZsEiskKpFgHrSOHP1c1dwIg3EYD/HJo14=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J9cRMnC6yiprgeUEf/BL6KSQZ8hy98qzYuhc8LXwsk4PwwEo7M+y/Pxrgd9+7PjwXi7vOb7CzQIZtLitcv1cXoMdg724XX/41WnVhiYgljqD7N9P5M5yfDJWoYil9HHM6aoV2hRwjf+aF8jUKHxWHejgldhG1bWb9nowTzFLgi8F7JQwh0VlcAdvixln0ckl7cbFW3Xzof6/DCzyeCieUfDl5D2UIwB5EbXMbz6RGS2MdOfyCPGH21Odz1S+DEaVc983WsAB2K3Vk285tV53/5idBFBopzxDMVJy8ct1tTRaNMXN1kP7YaPPjhmCP3Iq5iHqZ8ZkE9yxOC9tLs0Z1g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tqdbkf3q; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=tqdbkf3q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YPd0r047jz30Ss
	for <linux-erofs@lists.ozlabs.org>; Fri,  3 Jan 2025 20:03:53 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735895027; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=phHQqjNsV6ZsEiskKpFgHrSOHP1c1dwIg3EYD/HJo14=;
	b=tqdbkf3qtW5ylFsLngJ+9oNhTyFLuk0C129nF5ruCy8AEkjyjZt+G1cUVzV00s8jFisbBJK59+UjcPL9af591W6gRg6Vl6SjcOcT7Y7WN2aaayZueHLpLF+nMpkDrSE5Cm0n2w7Fa3NXYKaAcGazW3T9OtXmilMVokS0LfjCMbM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WMsl6OA_1735895021 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 03 Jan 2025 17:03:45 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 1/5] erofs-utils: lib: use round_up() to avoid division
Date: Fri,  3 Jan 2025 17:03:34 +0800
Message-ID: <20250103090338.740593-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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

A hotspot identified by profiling.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/cache.c b/lib/cache.c
index 5b2cc45..f9aa6eb 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -76,11 +76,12 @@ static int __erofs_battach(struct erofs_buffer_block *bb,
 	struct erofs_sb_info *sbi = bmgr->sbi;
 	const unsigned int blkmask = erofs_blksiz(sbi) - 1;
 	erofs_off_t boff = bb->buffers.off;
-	const erofs_off_t alignedoffset = roundup(boff, alignsize);
+	const erofs_off_t alignedoffset = round_up(boff, alignsize);
 	bool tailupdate = false;
 	erofs_blk_t blkaddr;
 	int oob;
 
+	DBG_BUGON(alignsize & (alignsize - 1));
 	/* inline data must never span block boundaries */
 	if (erofs_blkoff(sbi, alignedoffset + incr + blkmask)
 			+ inline_ext > blkmask)
-- 
2.43.5

