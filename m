Return-Path: <linux-erofs+bounces-540-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBF0AFC0B3
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 04:17:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bblB73xCFz30WT;
	Tue,  8 Jul 2025 12:17:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751941055;
	cv=none; b=AK4GUxCzxpcE/taHvj2VEppgmuIT5ERTfTwgKwyuHxu3dRo6e14E6VDguIKSEqd2E/iEOoJgRzUTMTu64Hfx1JSwX6s1dfh9lt4YljCYEDJTn9Y5hQ6M/DZD8nNFm31rBV7z/3mMEaleQWMWhsRl5NapeGva7tqhjWiQ0vTINckAxjZqa3R9P4UdxyUBiCt3Arupdx6ziCxHajYsD88cKW9AVsFcIr1kjGNkHNuIqNYDPVqL2Ewu84xiUz2v9hbrKRcGHQfaik9d+RuMm4rfrqIbqXKIIfDRoPYKkRiE7KuKaXNgGh7tUjleOQ0HPuPUKdnUgOSNUiY9hRa7N2XwYw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751941055; c=relaxed/relaxed;
	bh=I6sPgHf3PlAheuUbGUiw3QLGEdazAi3aE4j9byu9DyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cWgMW4uy7E5V2VazzZKNgwIIF6cSDwDFEDvKq1LsSK24lrGjEoPL1jy2NEpn5GdgYSlsNPIrMt3JE71uWON7HRyhLLFjsSu+nnHvvy2ZASgHSL2OzrblRylAybyOoTym8maVhJL3xOIN96bfDoUIqP+ZDzKm9DKz1C2JOcRUkE640Q1SMRCroldyofMVOjUfyok6DZQJX/u5BvsX7R7oSpF6ejfQkVNT9ia12qoGmHX47ojUVwnf/P5aZtOV4+HjAB4juOHzm9lW4C/vPjerOXdwLIQPAvXS7yLV/EDP+fRrKJOvtPS4PfS38rCQyf/fJ5/efIxU8Cw3i4S23XRl5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lGbT1TN9; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=lGbT1TN9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bblB54ZFbz3064
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Jul 2025 12:17:32 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751941048; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=I6sPgHf3PlAheuUbGUiw3QLGEdazAi3aE4j9byu9DyA=;
	b=lGbT1TN9jGgtOiN8wDphxM7q0TmO4S9ZKh+WSmyiXb161KizOHwUtXxTH0d7ZQFzSWUUto2rNPOCTdhn/1LfG3ZnpdvJxMTbRUHkvk3pMoKqk9GiJqT35Mho3hx1KSSkaDGIO/Ys/Ygn7sKpVW+1fTZP5kwEYKw6Ruzzjll5EG4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiIWO0-_1751941047 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 10:17:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 2/4] erofs-utils: silence `Unintentional integer overflow`
Date: Tue,  8 Jul 2025 10:17:20 +0800
Message-ID: <20250708021722.768644-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250708021722.768644-1-hsiangkao@linux.alibaba.com>
References: <20250708021722.768644-1-hsiangkao@linux.alibaba.com>
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

Coverity-id: 569450
Coverity-id: 569460
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/blobchunk.c | 2 +-
 lib/zmap.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index ccc77b0b..024a3927 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -150,7 +150,7 @@ int erofs_blob_write_chunk_indexes(struct erofs_inode *inode,
 	else
 		unit = EROFS_BLOCK_MAP_ENTRY_SIZE;
 
-	chunkblks = 1U << (inode->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
+	chunkblks = 1ULL << (inode->u.chunkformat & EROFS_CHUNK_FORMAT_BLKBITS_MASK);
 	_48bit = inode->u.chunkformat & EROFS_CHUNK_FORMAT_48BIT;
 	for (dst = src = 0; dst < inode->extent_isize;
 	     src += sizeof(void *), dst += unit) {
diff --git a/lib/zmap.c b/lib/zmap.c
index 43e76e55..22d7a092 100644
--- a/lib/zmap.c
+++ b/lib/zmap.c
@@ -604,7 +604,7 @@ static int z_erofs_map_blocks_ext(struct erofs_inode *vi,
 		}
 		last = (lstart >= round_up(lend, 1 << vi->z_lclusterbits));
 		lend = min(lstart, lend);
-		lstart -= 1 << vi->z_lclusterbits;
+		lstart -= 1ULL << vi->z_lclusterbits;
 	} else {
 		lstart = lend;
 		for (l = 0, r = vi->z_extents; l < r; ) {
-- 
2.43.5


