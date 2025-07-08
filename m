Return-Path: <linux-erofs+bounces-541-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71235AFC0B4
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Jul 2025 04:17:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bblB74zMGz3064;
	Tue,  8 Jul 2025 12:17:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751941055;
	cv=none; b=kPvKJZk3JpIiT10skIIKcY2spaSCo5/KWh2yHhrjxV7yd8qdSoO2M678IaszVVH0CUs20MU3V9TzEim6mQSxJsxkZIgQg9Wsec/b/4OZJsRwz+OYPnWoENM9Wsx132fwf3HEqy+h9cyVAoqP3tRXXWYzOICxJ5b2lc03vcbvejMauLzFIEdkSjdDtC9+fFZdwZrhE2Q6PQVfuNk7mhYj633Z1DYZlZEayTG4JO2i0ohKKP8A+/xuWQQzk4B1sOnNOv7WJVUamkVWZ0xV6sp0i/cGfGbPiZWjvZRx6LdZb8ItbGsOuNdklMtwK/j5/gBy0Tq1y+7JRwARzQ28sGVuVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751941055; c=relaxed/relaxed;
	bh=1YCoWyNYqhv4Wa0E2i6YLW4cEshoPkfQsA9rvNybBBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WIFT3rl4Yvi4q8R8kDGZZmDbrlg4zVCKM4ImvjHJi+72UruIHlzxZU8VH3S2Pz1pMPKsQB0VTlH3HuXfVvuNuxcZLnJvqF3lyizYpXmzZO6xkvx2IzvdvSOD56ju0Wh3iXetP6wcYN9PFOXNj8DPP0upc7vlFjmBDTQzA7cPXUXltvHypriNMFgaa0E8tMC2wImsC+eWCj74MGd2pB8hER0VTdvdUOqqDLY5NBc+95SqSRYn8KDkvQQavdTDBWODhJ0a4xOD+R2s2Q3v54hRs4smCilZkGoJf6FwJpgtXaL7ndfp54dX52B1hxEo8q2azI2ZgC/9H+/h/HolaWSoJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=slNCPElg; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=slNCPElg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bblB55tVMz30T3
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Jul 2025 12:17:33 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751941050; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1YCoWyNYqhv4Wa0E2i6YLW4cEshoPkfQsA9rvNybBBo=;
	b=slNCPElgJTaY9N2uqm3nFjm3CwKkaR2R3lcmqU0vwczB58ObUfLLnY8AIECncH96pOy3/NPz+OHiYoNHFWoCX9BuQmwUtRPSoGkpfk6m0XJR3pHIU9vMEVPkDRyTMUTqhx36oTyz2Ha9JIFmjH8/fYe6kEqdliBeYU63cO7Wiqs=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WiIWO0P_1751941047 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 10:17:28 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 3/4] erofs-utils: resolve `PRINTF_ARGS`
Date: Tue,  8 Jul 2025 10:17:21 +0800
Message-ID: <20250708021722.768644-3-hsiangkao@linux.alibaba.com>
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

Coverity-id: 569452
Coverity-id: 569454
Coverity-id: 569455
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/blobchunk.c |  4 ++--
 lib/cache.c     |  3 ++-
 lib/dir.c       | 11 ++++++-----
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/lib/blobchunk.c b/lib/blobchunk.c
index 024a3927..54644cd4 100644
--- a/lib/blobchunk.c
+++ b/lib/blobchunk.c
@@ -73,8 +73,8 @@ static struct erofs_blobchunk *erofs_blob_getchunk(struct erofs_sb_info *sbi,
 			chunk = &erofs_holechunk;
 			erofs_dbg("Found duplicated hole chunk");
 		} else {
-			erofs_dbg("Found duplicated chunk at %u",
-				  chunk->blkaddr);
+			erofs_dbg("Found duplicated chunk at %llu",
+				  chunk->blkaddr | 0ULL);
 		}
 		return chunk;
 	}
diff --git a/lib/cache.c b/lib/cache.c
index b91a2887..2c730169 100644
--- a/lib/cache.c
+++ b/lib/cache.c
@@ -487,7 +487,8 @@ int erofs_bflush(struct erofs_bufmgr *bmgr,
 
 		if (p->type != DATA)
 			bmgr->metablkcnt += p->buffers.nblocks;
-		erofs_dbg("block %u to %u flushed", p->blkaddr, blkaddr - 1);
+		erofs_dbg("block %llu to %llu flushed", p->blkaddr | 0ULL,
+			  (blkaddr - 1) | 0ULL);
 		erofs_bfree(p);
 	}
 	return 0;
diff --git a/lib/dir.c b/lib/dir.c
index 3405844c..821a364f 100644
--- a/lib/dir.c
+++ b/lib/dir.c
@@ -18,7 +18,7 @@ static bool erofs_validate_filename(const char *dname, int size)
 }
 
 static int traverse_dirents(struct erofs_dir_context *ctx,
-			    void *dentry_blk, unsigned int lblk,
+			    void *dentry_blk, erofs_off_t lblk,
 			    unsigned int next_nameoff, unsigned int maxsize,
 			    bool fsck)
 {
@@ -132,8 +132,8 @@ static int traverse_dirents(struct erofs_dir_context *ctx,
 	}
 out:
 	if (ret && !silent)
-		erofs_err("%s @ nid %llu, lblk %u, index %lu",
-			  errmsg, ctx->dir->nid | 0ULL, lblk,
+		erofs_err("%s @ nid %llu, lblk %llu, index %lu",
+			  errmsg, ctx->dir->nid | 0ULL, lblk | 0ULL,
 			  (de - (struct erofs_dirent *)dentry_blk) | 0UL);
 	return ret;
 }
@@ -162,8 +162,9 @@ int erofs_iterate_dir(struct erofs_dir_context *ctx, bool fsck)
 
 		err = erofs_pread(dir, buf, maxsize, pos);
 		if (err) {
-			erofs_err("I/O error occurred when reading dirents @ nid %llu, lblk %u: %d",
-				  dir->nid | 0ULL, lblk, err);
+			erofs_err("I/O error when reading dirents @ nid %llu, lblk %llu: %s",
+				  dir->nid | 0ULL, lblk | 0ULL,
+				  erofs_strerror(err));
 			return err;
 		}
 
-- 
2.43.5


