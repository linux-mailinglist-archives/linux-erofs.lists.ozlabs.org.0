Return-Path: <linux-erofs+bounces-86-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 10975A6835F
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Mar 2025 04:00:13 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZHYNV51Ddz2ym2;
	Wed, 19 Mar 2025 14:00:10 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1742353210;
	cv=none; b=QBcwJe3BgszK89B0eird6m2sX37gEkP+mZnpt8SxICrhEceVacvAhz2UIC2bI9QRdECVGwGGOD/852UzBowrF6KaKkuMbxJOm8liVonfpD6k8vWKEneBouX5TbtZJ4a7CbqfWyXP2fGcfS4ZZ1/fvnruaKkiz/JOXhMcb0AsbV7orzCuBNojhFwUf/bcQFkIlD/VRVwfnZb/wXbH7uKmVKJ8pjYr3YAHNG1HQy0RZ7LyObcJi7LRjINuW+dDE9hp1WVD7pdSYZtDzmNVJMeyGM3WSxbAuWkNXOpkrG4fseIKn9zFFNWrVqD1lO5u3asQ33wcLXAwj/JqWviFwk68CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1742353210; c=relaxed/relaxed;
	bh=VUPAqvDxo94oQ2Yp5DEmT3wiJN+0p+J2Q0KkA4Qbhbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z0S47bv75MQ5Op+/238Bo03SStoyqSa3DoRN7YS/VAguAAfQ7s+baeOy813jTwVVpxJwtqM+OQU6tJxXeBhFiR2t5QAArVCcXH/otmrt6UnmeI2lLRRGcQ5hyogqovFPaS1K2Ids/Op+mk6W5KBpZTEvPXTMwRNC0vI1QozgxZR8InAZ3jU6uNWEUv8wzAS3CZ8nZnWC+ig5uPOEB36AMHcdKEExuK084ZJbPTWrIkV72Q+KVLFOjIch6MEpMRPWfHzqrAgAPtOE2yebU9soKyp4kg1yxwEOf5oSQ122cZEPgFTpxA0NJbvOzQd1xbRiBvQEgD0iddpID5Udyb8Wbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qv2fikDj; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qv2fikDj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZHYNS6yg1z2yf3
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Mar 2025 14:00:07 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1742353203; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VUPAqvDxo94oQ2Yp5DEmT3wiJN+0p+J2Q0KkA4Qbhbg=;
	b=qv2fikDjSm56Bm1A4VK+FablqbrN844AQThl8c+rKeoInloV2YvITYl3nOYsrQWaVAndQ0fCtYilEhtvebUyat4vTlH7Gp3k957WUVw2JvN5X1Hb7o/dKzi2Gr880CYMSc0mJD0HYYocB83n5Oti9iZUR6nsiAlzhXI5a5eT5cQ=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WS-6Nzc_1742353195 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Mar 2025 11:00:00 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-fsdevel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Brian Foster <bfoster@redhat.com>
Cc: linux-erofs@lists.ozlabs.org,
	linux-xfs@vger.kernel.org,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Bo Liu <liubo03@inspur.com>,
	Christoph Hellwig <hch@lst.de>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH -next] iomap: fix inline data on buffered read
Date: Wed, 19 Mar 2025 10:59:53 +0800
Message-ID: <20250319025953.3559299-1-hsiangkao@linux.alibaba.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Previously, iomap_readpage_iter() returning 0 would break out of the
loops of iomap_readahead_iter(), which is what iomap_read_inline_data()
relies on.

However, commit d9dc477ff6a2 ("iomap: advance the iter directly on
buffered read") changes this behavior without calling
iomap_iter_advance(), which causes EROFS to get stuck in
iomap_readpage_iter().

It seems iomap_iter_advance() cannot be called in
iomap_read_inline_data() because of the iomap_write_begin() path, so
handle this in iomap_readpage_iter() instead.

Reported-by: Bo Liu <liubo03@inspur.com>
Fixes: d9dc477ff6a2 ("iomap: advance the iter directly on buffered read")
Cc: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christian Brauner <brauner@kernel.org>
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/iomap/buffered-io.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index d52cfdc299c4..2d6e1e3be747 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -372,9 +372,15 @@ static int iomap_readpage_iter(struct iomap_iter *iter,
 	struct iomap_folio_state *ifs;
 	size_t poff, plen;
 	sector_t sector;
+	int ret;
 
-	if (iomap->type == IOMAP_INLINE)
-		return iomap_read_inline_data(iter, folio);
+	if (iomap->type == IOMAP_INLINE) {
+		ret = iomap_read_inline_data(iter, folio);
+		if (ret)
+			return ret;
+		plen = length;
+		goto done;
+	}
 
 	/* zero post-eof blocks as the page may be mapped */
 	ifs = ifs_alloc(iter->inode, folio, iter->flags);
-- 
2.43.5


