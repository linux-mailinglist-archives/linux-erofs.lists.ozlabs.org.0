Return-Path: <linux-erofs+bounces-1440-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CF611C8D451
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Nov 2025 09:02:53 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dH86z4n16z2yvW;
	Thu, 27 Nov 2025 19:02:51 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764230571;
	cv=none; b=cD8r9fQJw5H0tH0meXdsgsoFLz/9q3tXW3ZmAvaKjW1KOxm/00Zk68OPWKhubmRwhs/elu/J6DwhLE8FrstAGdoz9xXQBBZWUm57ts4/Vnj+s2LigV1to+VfgnbqFcBCGk4oJ5ThuzNzlQA09fXMrDRPU5pjVKaYbXl6PsuRjbHyWpzvmTOtwkEsy87XaAkNK6KDNHqBZEYhoqaUEmn5gQpCkuUQupUQxjn4+yauGrO460ZAFrO7cTvY8+1aJkG/DFKihQ8ElBlPGHJJyj8pvokYt5H5J1FgLKIVEaepPxrWfLti29OpiNI1iKk2/MiS05yN74mTM4RvsgbwYmu0yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764230571; c=relaxed/relaxed;
	bh=Qc9KRM73OWEhqOEmQa0INwKZygqVyMGwG+ycFVJCLGs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fzM0Ubw9oyVyP/eTwbPSy2U168ZBuZ8R9sT/sZjqKne1A1N7AOKxAuCwGIFW9xK5TSbUO9+oaQq4uW+4eLXjbPp6wxKdG17BZAxivyCf1kVbqJMAb9nkwiTFo0ErPzeBD8YbNAdD6zwGx9IpcV4oMu8+kKBmd88EcqFcbw6Sp2xKJQFUumMGlfs5FqYVg88zMT0NGK6ONZGQLUrPzLbKCaSgxgNbAH6lgNcpL7t0v95hV2CijkWC96wCcfuFUWnksmpWsw5XQggTmhlcPWe6571mptP3PgngYBW/PLcyEtkgi8oYPYYcuMGeClgHc77ElOPnR6CQfgewhQ8MnsBztA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=r7GvtDgq; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=r7GvtDgq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dH86x3TJwz2yl2
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Nov 2025 19:02:47 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764230563; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Qc9KRM73OWEhqOEmQa0INwKZygqVyMGwG+ycFVJCLGs=;
	b=r7GvtDgqV81u+VGqftQU2kn6JARDKjm7ZpPY2NjYtPKQj5RV65veefFvRJYhCyBj5sB9KDvLeWgf8b2yR06h8U2gLNmHVBlz4nbm0hCTl2kNDBSczgt5xQzl/2IZjAfPrhQczEI2aQbv2+PXvsmvqMPQvKStnhuVDhZACUvO5N0=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WtWMPOR_1764230557 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Nov 2025 16:02:42 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Ming Lei <ming.lei@redhat.com>,
	Stephen Zhang <starzhangzsd@gmail.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs: get rid of raw bi_end_io() usage
Date: Thu, 27 Nov 2025 16:02:37 +0800
Message-ID: <20251127080237.2589998-1-hsiangkao@linux.alibaba.com>
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
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

These BIOs are actually harmless in practice, as they are all pseudo
BIOs and do not use advanced features like chaining.  Using the BIO
interface is a more friendly and unified approach for both bdev and
and file-backed I/Os.

Let's use bio_endio() instead.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/fileio.c  | 2 +-
 fs/erofs/fscache.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index b7b3432a9882..a65f86dc79b6 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -34,7 +34,7 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 	if (rq->bio.bi_end_io) {
 		if (ret < 0 && !rq->bio.bi_status)
 			rq->bio.bi_status = errno_to_blk_status(ret);
-		rq->bio.bi_end_io(&rq->bio);
+		bio_endio(&rq->bio);
 	} else {
 		bio_for_each_folio_all(fi, &rq->bio) {
 			DBG_BUGON(folio_test_uptodate(fi.folio));
diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index 362acf828279..7a346e20f7b7 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -185,7 +185,7 @@ static void erofs_fscache_bio_endio(void *priv, ssize_t transferred_or_error)
 
 	if (IS_ERR_VALUE(transferred_or_error))
 		io->bio.bi_status = errno_to_blk_status(transferred_or_error);
-	io->bio.bi_end_io(&io->bio);
+	bio_endio(&io->bio);
 	BUILD_BUG_ON(offsetof(struct erofs_fscache_bio, io) != 0);
 	erofs_fscache_io_put(&io->io);
 }
@@ -216,7 +216,7 @@ void erofs_fscache_submit_bio(struct bio *bio)
 	if (!ret)
 		return;
 	bio->bi_status = errno_to_blk_status(ret);
-	bio->bi_end_io(bio);
+	bio_endio(bio);
 }
 
 static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
-- 
2.43.5


