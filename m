Return-Path: <linux-erofs+bounces-1033-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFF6B59146
	for <lists+linux-erofs@lfdr.de>; Tue, 16 Sep 2025 10:49:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cQwYZ5Dfzz30T8;
	Tue, 16 Sep 2025 18:49:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758012546;
	cv=none; b=V3lHM0LYFVy6ODjoJLR1Q2y1zcWWaH3vOqx8CTVvQYruc8v52uLgF/TvwMCPY+YlTV5lzqhH1zi1EXq4Ag5U9CZBzvSpz+ck7Yh9LUB9Jk7DrWY0POE3PksN/b9WgdVgry95jMzGccI9hfGLVVaN+kKIJBEv5A3/GLfdvFanTPPirwgbiat1gNl2PWA8dvMHhPeSG2w1B3EakG6uawMCxXYG6USS1ZwHDL4hqPBE8C7eYaC8cpdJPuvxbWBL9NF1mhMdUeNS0sumguVWdXuHOwZ7e+NRWoZ74ISGAFlJzNsz6bXjzDgHVRN06fYjK4Qn0FOVagyajPM12LVTzObgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758012546; c=relaxed/relaxed;
	bh=8qnhYfS7VrRZICNtKs2/xri74kwNWI+Epqo+8EzBylY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vx00KXA6DfNXZ4Rl7uTNo3IQIm583l8C82owV2b6exwtUHwZiuT65btkT1p4rEo5UWSGw6WNCzDtr1J6n/VL9Ggj6Aex6uu4U3fM3mqSDkECwGCXwOf0E309ccBBDOtxIVCpyRrdOnh4XqhNDM7/Ihg3m8LiQkpzwHHKa7Fpxp6dgQdkh/O8pGM7ZrI5pFnmFdlVfuGhnCl3OzZ9FoUKlCHRTorH1xpuys5uaGMiJQQJZORv62ZxZ3IxSrBVjFX3ByR/NFdLrCXLzIVSM4be/wLzjn1qqXdSHRCXQe+4XxjPeovPxVo3huxcKygG8m6xHh93z7D5bE8RVhNTNqZUGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vVbVUMmy; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vVbVUMmy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cQwYX4YK9z304h
	for <linux-erofs@lists.ozlabs.org>; Tue, 16 Sep 2025 18:49:03 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758012538; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=8qnhYfS7VrRZICNtKs2/xri74kwNWI+Epqo+8EzBylY=;
	b=vVbVUMmyAEnyF8PEfgCxiBptgTewJ6zVYCCePGQk/Bohw20al9urVCVj/fJ0eHSZUknwrKU3tYfdFHGdl9FpcoH6QQHukUSnRYUXLJKOr3tfVI6WNMbNdtGK8gd7wCNYB/lZCwEpP2Efx9IAUX6Ck2z22oELSTgdALCuR8ZTlCM=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wo81C3I_1758012532 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 16 Sep 2025 16:48:56 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	syzbot+1a9af3ef3c84c5e14dcc@syzkaller.appspotmail.com
Subject: [PATCH] erofs: avoid reading more for fragment maps
Date: Tue, 16 Sep 2025 16:48:51 +0800
Message-ID: <20250916084851.1759111-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <68c8583d.050a0220.2ff435.03a3.GAE@google.com>
References: <68c8583d.050a0220.2ff435.03a3.GAE@google.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Since all real encoded extents (directly handled by the decompression
subsystem) have a sane, limited maximum decoded length
(Z_EROFS_PCLUSTER_MAX_DSIZE), and the read‑more policy is only applied
if needed.

However, it makes no sense to read more for non‑encoded maps, such as
fragment extents, since such extents can be huge (up to i_size) and
there is no benefit to reading more at this layer.

For normal images, it does not really matter, but for crafted images
generated by syzbot, excessively large fragment extents can cause
read‑more to run for an overly long time.

Reported-by: syzbot+1a9af3ef3c84c5e14dcc@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/r/68c8583d.050a0220.2ff435.03a3.GAE@google.com
Fixes: b44686c8391b ("erofs: fix large fragment handling")
Fixes: b15b2e307c3a ("erofs: support on-disk compressed fragments data")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 2d73297003d2..625b8ae8f67f 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1835,7 +1835,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 		map->m_la = end;
 		err = z_erofs_map_blocks_iter(inode, map,
 					      EROFS_GET_BLOCKS_READMORE);
-		if (err)
+		if (err || !(map->m_flags & EROFS_MAP_ENCODED))
 			return;
 
 		/* expand ra for the trailing edge if readahead */
@@ -1847,7 +1847,7 @@ static void z_erofs_pcluster_readmore(struct z_erofs_frontend *f,
 		end = round_up(end, PAGE_SIZE);
 	} else {
 		end = round_up(map->m_la, PAGE_SIZE);
-		if (!map->m_llen)
+		if (!(map->m_flags & EROFS_MAP_ENCODED) || !map->m_llen)
 			return;
 	}
 
-- 
2.43.5


