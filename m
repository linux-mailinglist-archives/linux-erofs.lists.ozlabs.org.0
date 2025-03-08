Return-Path: <linux-erofs+bounces-21-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7EEA57C6B
	for <lists+linux-erofs@lfdr.de>; Sat,  8 Mar 2025 18:35:45 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Z99Kl3kP8z3041;
	Sun,  9 Mar 2025 04:35:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1741455339;
	cv=none; b=Bl6GS1b8UbUe12iig6sQ4GDhgUjq8tFuYD4K+UiorSuu6KL+KMjfVegJenrBA0ZHN/b/Jaq14Cii+TKY/VTB0nRtIi77znuORESD7m3OOIqbPJpO270lZrwhaaJjoYC/R4UrrhttI2F6RZEr7tvWsFsNHq9JnajKbv8yxCTmZRglz9c1S9QjCRcHwiVNO4lKKXOQMuPtflgZpcYlbwt4i6YC/XHJYvQ/IYiey16ctU8c8o9gOkTjHEQDIC+29TNWubVyBdxrvVM6SOqNPGJz9CZpwfdenycuzRf3Q+iMxYSXEwXfskhlUNY+kgiqUcVJHiztq4zsVTh6i9bOaMzslQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1741455339; c=relaxed/relaxed;
	bh=ihlsQAniPCwZCEmKRA/oFx6z8pZlzw9yF2a1/hW9hso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kaylKI5b93pC484BT+dkhhEBrP+8zLy2zZTJgI3q+XlHqGmGrM5PtyCdPLPgaYVblKXEa7c8C8M56NXDAx0/AWb/ySSRbTGDVponWe2xTbGtlOh2veyXUa6HGAlabdjNAdthdzc6+fRond1P3lrWXhf6esI/IGi3v0yHaeaoffkrsHEdbtEX0jdLhhVfSQFHV8PbY4n0DLK0IdnAXA7D+YePPC308h/kW9G5idTeprKojMmTiZAj32fzoQ+J2LRA6S8l6GD/ykEd+Fco/wMvIf5dEv2itX+yRmr9Tefj0OWoJymDvSTIIntZao4v5KWkXF1KGEKi4mS+pvQMjk2uAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qifzPlS/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qifzPlS/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.118; helo=out30-118.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Z99Kj28mSz303B
	for <linux-erofs@lists.ozlabs.org>; Sun,  9 Mar 2025 04:35:35 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741455331; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ihlsQAniPCwZCEmKRA/oFx6z8pZlzw9yF2a1/hW9hso=;
	b=qifzPlS/WNwSh3O6xhf+TlFVSWiQzwzbc9wug6Cz2EVinqSgTeDqaQF4ZGqDIMAKQ6y4VMPXnxygO/yQthxgONqYclhI8veOPL4f6aZ4RkTbKpq7M1cQi5UmL+arzebD+YLiThuEYLw2uv8hc3RxSFEET5C4lulIFdlAHJY+x0k=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WQvU-W4_1741455324 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sun, 09 Mar 2025 01:35:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: lib: fix insufficient fragment cache bitmap
Date: Sun,  9 Mar 2025 01:35:23 +0800
Message-ID: <20250308173523.3696606-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org

.. should round up to the nearest byte instead of down.

Fixes: f511cfbbc0da ("erofs-utils: introduce fragment cache")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/fragments.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/fragments.c b/lib/fragments.c
index 05bbf0d..d300439 100644
--- a/lib/fragments.c
+++ b/lib/fragments.c
@@ -402,7 +402,7 @@ int erofs_packedfile_init(struct erofs_sb_info *sbi, bool fragments_mkfs)
 			err = -errno;
 			goto err_out;
 		}
-		epi->uptodate_size = BLK_ROUND_UP(sbi, ei.i_size) / 8;
+		epi->uptodate_size = DIV_ROUND_UP(BLK_ROUND_UP(sbi, ei.i_size), 8);
 		epi->uptodate = calloc(1, epi->uptodate_size);
 		if (!epi->uptodate) {
 			err = -ENOMEM;
-- 
2.43.5


