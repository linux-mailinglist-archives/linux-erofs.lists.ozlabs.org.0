Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 01FD99FF599
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jan 2025 03:42:47 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4YNrbR64Ybz2xYr
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Jan 2025 13:42:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1735785761;
	cv=none; b=b/AtDoIkRn/GZPvLECwCcKWi7Y5jK80959rC1aXtqZBMdcrwgKDGyUCMVi3VhfaXDILo21fhzTXGMF9butGyQwQQwQ/tOeSZldnVYDeHp0GdH2pq/ocGZx0k7O5gmd4MohiJ9gRb9MKYZzCVkWfFojsL1iDYQvqI8TIJV2mL/oRu/ytp3h2Wlu2OjeDr1zpps0dboXVxcNNy0Hrp4ke+wdRNRm+aH0QLAUrdkVCyn+KxDDGyTAFZDBBgIn9ROG5tgL9klQwpJQSUitUM9u7kPq3K+AOyzoZgG1rmu+NRCGv079aW7lUpnbXESsk1PUlZXI6IHy1GVLHwI4stgTPhXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1735785761; c=relaxed/relaxed;
	bh=xZA/ayt4zIAaaI57f7Yuq0dsDLz6SdXdmJNoxeMf580=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUwfTyykQOH5c1Me0KHaiBYridGjk8iAoO9sBF18Lm1v6OSznwGk1e5mzIRhnkbH+/5OhkBLIVpEn9eP97EsgOQl6s3nINQUYFVP6Zn8o6vwiQ2pQm23gUu5G0fgqNJJF+Ki04/snJgNIptu7CwZGB+ljiG+2hxKav+18N0qDs5PwjvfdUtI2jbRjnNhvGG62pgQPGyj+YVO/yCHH4N4Msy2yTKS/b/Ww8Ai9nUl3PYsRj6X6/JrC+2VL+IwJQbtvMvQVV2SQ/k1Cqo4J0S8hbT7hrpBfCQniOd48QhzZfBe/wxzxGH4+jrWQGulF1cpito4/w8PiH++SUydjm8qbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ic5fJpPh; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ic5fJpPh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4YNrbM2qbGz2xYr
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 Jan 2025 13:42:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1735785751; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=xZA/ayt4zIAaaI57f7Yuq0dsDLz6SdXdmJNoxeMf580=;
	b=ic5fJpPhr8wL7pPhRIWd/FnpGwdkph7bWE6Kb3KbV7GHg7tJE9nPLJlPKozDztJeI97kmaQ6ZuM8pT7qCF5MzZqcxvkKXdPvGpzX2PqKbWP231WE6ECNow8/x0zs4vphqQMJi/144PFxC3A6G1HLQchjg8OL6Of8nQiY37B2oZA=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WMi6QJj_1735785746 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 02 Jan 2025 10:42:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: mkfs: fix `-Eall-fragments` for multi-threaded compression
Date: Thu,  2 Jan 2025 10:42:25 +0800
Message-ID: <20250102024225.2433419-1-hsiangkao@linux.alibaba.com>
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

may_packing in __z_erofs_compress_one() is still bypassed when multi-threaded
compression is enabled, which is unexpected.

Furthermore, multi-threaded -Eall-fragments,ztailpacking can sometimes corrupt
images. Let's fix it.

Fixes: 882ad1c3157f ("erofs-utils: mkfs: fix `-Eall-fragments` for multi-threaded compression")
Fixes: 10c1590c0920 ("erofs-utils: enable multi-threaded support for `-Eall-fragments`")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 6ac9c75..fd4c241 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -565,8 +565,7 @@ static int __z_erofs_compress_one(struct z_erofs_compress_sctx *ctx,
 	unsigned int len = ctx->tail - ctx->head;
 	bool is_packed_inode = erofs_is_packed_inode(inode);
 	bool tsg = (ctx->seg_idx + 1 >= ictx->seg_num), final = !ctx->remaining;
-	bool may_packing = (cfg.c_fragments && tsg && final &&
-			    !is_packed_inode && !z_erofs_mt_enabled);
+	bool may_packing = (cfg.c_fragments && tsg && final && !is_packed_inode);
 	bool may_inline = (cfg.c_ztailpacking && tsg && final && !may_packing);
 	unsigned int compressedsize;
 	int ret;
-- 
2.43.5

