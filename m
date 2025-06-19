Return-Path: <linux-erofs+bounces-468-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD92ADFBDB
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Jun 2025 05:28:56 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bN5gB0HFgz2xpl;
	Thu, 19 Jun 2025 13:28:54 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750303733;
	cv=none; b=HxoxmnYoDTz5ptiqMfZ6xE7r3G33EUuhDsUz16o37GaSrdbJu8xhF5CR1y5bmxMd6+2qJt0+FJq9XJcfvxWT7ZxbiKsd8XRiptkLlJ+sAy2/OZP8t54TPC3fJtVWqCdPZik9bvevKacZiZXn2caxQEb37H2YsTq0BxXKdQqbzeGednyLyxd3GBJ8paHXrPnymge5PCxFtPJHScJ27ZRj0diiZ0O7yY+I7o2SxpaxlkKjxBIVgM+Xe0LbNEWqYzZRiU9GzZu4zJyv2oCgmcfbYzkNLoEC+Fh3JDDtsOZ87FC1M/1bJ+ntMITCrL+wlzw+vW9k1MVMtfmxZ3EVlh7oOw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750303733; c=relaxed/relaxed;
	bh=O8Rp7wzUVaBQXbrLptrr+W6uUV9/YYR6SXF+ORLk/V0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATNmm20+XPUe90VFj2ZRbGT5ar1rU68WTsqKHPjiMk8tNqVYntURn8Yw+WSSvSFjYJwu6q0D7e7RMfbgNKJsWxIfFZ90bwfSDtmH+9plUP9JeFkFjnG0S7BsoQR3wmI6Kt4yhKga3jymULeDWBjcaeYSi+X+n5gAdsNyl3wOiz36rm2fhW8Tm2E5+i6BEhZkz+BJgvQg+6VyayYJrfFamOh+opA4TgiYgnmaGm6pLe/qZ23uQf4R8uEaR3OjLlkfzOYeJZOgzthq0CG2GxIFHA3d3vWNbBKG/hTDoOPTV+PJSeIaEOzncyRQRDnVcagQ3E5uNhiqsIjkZz2VAdhuDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VqgxZ8rg; dkim-atps=neutral; spf=pass (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VqgxZ8rg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bN5g81xD2z2xjN
	for <linux-erofs@lists.ozlabs.org>; Thu, 19 Jun 2025 13:28:50 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750303726; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=O8Rp7wzUVaBQXbrLptrr+W6uUV9/YYR6SXF+ORLk/V0=;
	b=VqgxZ8rgHQsp8PP1C5lE/mi4vsrgAnC5sDBVy2JBsK+I7lbrVPKn8CwW7kcI76iPGh5S1BmEj5tbgN7yy88nTlybUwMVJ7xUzReSLUhjOzKaGHuFt/TR6JLxaAG4mgGghh/B28wqxmRhvKXAOQQ5gYuckbEPj3Zhji1iP2rDkl8=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WeFn9H3_1750303720 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 19 Jun 2025 11:28:44 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com
Subject: [PATCH] erofs: refuse crafted out-of-file-range encoded extents
Date: Thu, 19 Jun 2025 11:28:39 +0800
Message-ID: <20250619032839.2642193-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <684cb499.a00a0220.c6bd7.0010.GAE@google.com>
References: <684cb499.a00a0220.c6bd7.0010.GAE@google.com>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Crafted encoded extents could record out-of-range `lstart`, which should
not happen in normal cases.

It caused an iomap_iter_done() complaint [1] reported by syzbot.

[1] https://lore.kernel.org/r/684cb499.a00a0220.c6bd7.0010.GAE@google.com
Fixes: 1d191b4ca51d ("erofs: implement encoded extent metadata")
Reported-by: syzbot+d8f000c609f05f52d9b5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d8f000c609f05f52d9b5
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 14ea47f954f5..6afcb054780d 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -597,6 +597,10 @@ static int z_erofs_map_blocks_ext(struct inode *inode,
 
 			if (la > map->m_la) {
 				r = mid;
+				if (la > lend) {
+					DBG_BUGON(1);
+					return -EFSCORRUPTED;
+				}
 				lend = la;
 			} else {
 				l = mid + 1;
-- 
2.43.5


