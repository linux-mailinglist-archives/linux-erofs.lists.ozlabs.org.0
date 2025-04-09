Return-Path: <linux-erofs+bounces-166-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EEB8A81CEC
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Apr 2025 08:17:53 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZXXmq1qPsz30D3;
	Wed,  9 Apr 2025 16:17:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744179467;
	cv=none; b=bHJoB2wDgEjDKM4FE5C4yDfevEa5FqeB4ErwTuag0x//r3q15I0TFk2e/PTLg9Ba6/PPO8fwoXZlYrOjU+XRCEhANtflcIfLjmwBCrrEkjNZ6p34VgyCPDJmsKDNPQjSH6xBEiSgUIncbdyzYWVrhAQ0itz9Ahk9o64uMf8xX2KRQUo69xw2p6Vseg9rUgWZtvI9c3Obx8KYTAkdySmlCR27hhWJZuXw9iGZJePCgZiEPq+jx49hzw0YXOEjEL9C8NqmVrIc2yWlCeYNABMqrkja16RihVLbTOL7Xg3uv+xHobxdObYGNXdblFABgclBhxqdqQR5yE79HmcO1aIK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744179467; c=relaxed/relaxed;
	bh=F+EaNOHvSIG5XYQF/vN0dpNhhnFI3aYX5LkcusrUfKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrdRks7+ZKYDvAnVOQgLdGFFqwJyeraLEcDowwmroc0j+b14IXj+Mg/RLd2iAb743bcEm4Nh58L1hxac1QVsX2C2f+zWdgc1A7zBMYBsTZmEOMrtM+nPlIEOfM5Nu/px8vwbAQA/RwP7ou/1YgMspMz9OrNMb3UpwjhJOtayFJg0ko1gZew4IhnO/GKG4qFFhQHedatKMZ6aMBAz0FrIquBsfjBwG752EjJEVzJafdGw8ygjgRC1w37O+942spTRMIgkAJi15oGonolXWSqz3LVQjfUfz68kXO/pmKNFD/cXAMxsQG5NiJrSjtHSGKpuC5Mssm5XX6MCxPBW0JxYQA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=D7wsfB9A; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=D7wsfB9A;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZXXmm3N6Tz2yrX
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Apr 2025 16:17:43 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744179458; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=F+EaNOHvSIG5XYQF/vN0dpNhhnFI3aYX5LkcusrUfKA=;
	b=D7wsfB9AkoLSC0yNXT9ShwxOhRtx9k/V4su4Z7BHVf+KxOO1rWRXbQWrYBzaazOn6ggyiryqb5gnVSqiuNSYc1GBgwWWoas929fGuKEm0Dbp8JNRGvWPPgX8UhTrq9A0D+d0H3X8zz1Ukp/NPLHo2OQXJRZ7GYvBmeWimjxenT8=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WWIjRb6_1744179451 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 09 Apr 2025 14:17:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Colin Walters <walters@verbum.org>
Subject: [PATCH] erofs-utils: lib: fix `1UL << vi->u.chunkbits` on 32-bit platforms
Date: Wed,  9 Apr 2025 14:17:30 +0800
Message-ID: <20250409061731.1267689-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <3bc4c375-9a5b-41cc-a91c-a15fb4b073ba@app.fastmail.com>
References: <3bc4c375-9a5b-41cc-a91c-a15fb4b073ba@app.fastmail.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

`vi->u.chunkbits` could exceed 32, e.g., 43 (12 + 31), which causes
the result of 1UL << vi->u.chunkbits to be truncated, returning 2048.

Reported-by: Colin Walters <walters@verbum.org>
Closes: https://lore.kernel.org/r/3bc4c375-9a5b-41cc-a91c-a15fb4b073ba@app.fastmail.com
Fixes: 401ca0769e20 ("erofs-utils: fuse: support reading chunk-based uncompressed files")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
I think it should be fixed on the kernel side too, yet I rarely look
after 32-bit platforms due to lack of test environments.  On 64-bit
platform, it shouldn't be an issue since `vi->u.chunkbits` should
never larger than 64.

 lib/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/data.c b/lib/data.c
index dd33d9e..f4ce8c8 100644
--- a/lib/data.c
+++ b/lib/data.c
@@ -66,7 +66,7 @@ int __erofs_map_blocks(struct erofs_inode *inode,
 
 	idx = (void *)buf + erofs_blkoff(sbi, pos);
 	map->m_la = chunknr << vi->u.chunkbits;
-	map->m_llen = min_t(erofs_off_t, 1UL << vi->u.chunkbits,
+	map->m_llen = min_t(erofs_off_t, 1ULL << vi->u.chunkbits,
 			    round_up(inode->i_size - map->m_la, blksz));
 	if (vi->u.chunkformat & EROFS_CHUNK_FORMAT_INDEXES) {
 		addrmask = (vi->u.chunkformat & EROFS_CHUNK_FORMAT_48BIT) ?
-- 
2.43.5


