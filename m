Return-Path: <linux-erofs+bounces-1441-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA0DC8D478
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Nov 2025 09:08:31 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dH8FT2m0Jz2yl2;
	Thu, 27 Nov 2025 19:08:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1764230909;
	cv=none; b=KTdxkhYAY6TzisYCHmyy1we7V/CQ8Yq8b80sbT98G8AE0FLHSzyx4Dqxu1qo6BKFle1W1r695neYF34dv4FtVtFrbrGPMoMpt6NY+sqGYLzjYGVYhOSqChOGFdOz5pnzRGh8PvMulR7Ab9/Ha0dAP9uKP4ALd53zrb4b3Xpu65MoS/GvtLBxCPymtFCGzo3QelvlXy1+kuN0P1of0ohcUTjq2BUwRrj87etTFBKskdGu1noYq9udQPpJ/6i3xDMtUQ+FsnlAQsoDaBJI1O+krX+Wisfw2GJU6Xq5ebySj4K/e6oKYXZedgCebfsReHkl3BGMhpssyXcHmARNkreC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1764230909; c=relaxed/relaxed;
	bh=lg19gDerPYPrC9qzJjtNYK3ey/49Lb0mQIl5aO4blIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SxMZP84ZbyrjCm8739hBpAqMKw/cL1fcte4KuUC3k4yu2cRnR5/dxF9YDpKcO3ZOorfjS5YBsPFgHofvRH7Otu5anTIXYlQO0BSRTIOLxHz1E4s620zfvLJ2Mvb3C4YxbUUXYnduc6sROrJBs5eQEz8OIH38KE+Wg4fxX9EI3yjb0BSdtddzLQZ4L1JMNXdYT1J77X5D9eSrON+irnro9iaBSsle4zXlzkNmNBceIJEFKT1w1gCuz7im4+kWu5uqrfczAOBIEkyiiB9xrOZTagPxxbG/B5K4+0Ortw8cO8RjyjfRkRh+zCfu1Ox90wqEgKF5bIIt0Bq8JAqAuwzN5g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=o/ry/Za2; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=o/ry/Za2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dH8FR0M8qz2xP9
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Nov 2025 19:08:25 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1764230900; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lg19gDerPYPrC9qzJjtNYK3ey/49Lb0mQIl5aO4blIE=;
	b=o/ry/Za2vZlz/p4DCwgE+1S6vUFkhj6UGjyZNsA0piF37uv+kGWZ9wPDv8ccVX8GVyoqzE8ui9ZWpV0/eAavGXSmmlxoMrxx9QfdzaFhAGSgz3tGzP/MKBfyx7Ce7UCgyKfjdhd1cHUvIlmq3lkhYa0O9yq5LeWi+dUIciEF5Rc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WtWXY1i_1764230899 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 27 Nov 2025 16:08:19 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Ming Lei <ming.lei@redhat.com>,
	Stephen Zhang <starzhangzsd@gmail.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v2] erofs: get rid of raw bi_end_io() usage
Date: Thu, 27 Nov 2025 16:07:56 +0800
Message-ID: <20251127080756.2602939-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251127080237.2589998-1-hsiangkao@linux.alibaba.com>
References: <20251127080237.2589998-1-hsiangkao@linux.alibaba.com>
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
v2:
 - call bio_endio() unconditionally in erofs_fileio_ki_complete().

 fs/erofs/fileio.c  | 2 +-
 fs/erofs/fscache.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/fileio.c b/fs/erofs/fileio.c
index b7b3432a9882..301647b84ca9 100644
--- a/fs/erofs/fileio.c
+++ b/fs/erofs/fileio.c
@@ -34,13 +34,13 @@ static void erofs_fileio_ki_complete(struct kiocb *iocb, long ret)
 	if (rq->bio.bi_end_io) {
 		if (ret < 0 && !rq->bio.bi_status)
 			rq->bio.bi_status = errno_to_blk_status(ret);
-		rq->bio.bi_end_io(&rq->bio);
 	} else {
 		bio_for_each_folio_all(fi, &rq->bio) {
 			DBG_BUGON(folio_test_uptodate(fi.folio));
 			erofs_onlinefolio_end(fi.folio, ret, false);
 		}
 	}
+	bio_endio(&rq->bio);
 	bio_uninit(&rq->bio);
 	kfree(rq);
 }
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


