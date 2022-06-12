Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC4F547B16
	for <lists+linux-erofs@lfdr.de>; Sun, 12 Jun 2022 18:46:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LLgZN082bz3brF
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Jun 2022 02:46:20 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m3D383UX;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=m3D383UX;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LLgZF36BLz3blq
	for <linux-erofs@lists.ozlabs.org>; Mon, 13 Jun 2022 02:46:13 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 0C93AB800C1
	for <linux-erofs@lists.ozlabs.org>; Sun, 12 Jun 2022 16:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23685C34115;
	Sun, 12 Jun 2022 16:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655052367;
	bh=RHe/dyqKA2tM9ZxphU9drqUjaZGBFsdwD6ZrQud0ADE=;
	h=From:To:Cc:Subject:Date:From;
	b=m3D383UXNhkH17ATBW8c016ymwz86XVJW+yo0PYvWK8dSTKtWJ1WYFotr4Pk/gwcy
	 2W0mypy0y/58n8KiJTzB9RMI0dRqo3cvrMdMFBnNaJVYQ4H7XMhgVKcT97oDypbI73
	 s7l5z2OjwenivEqcMTqSoLdvwzVs3qU3WLDSSbHmtttfvtmnrl00UrxdBfNeMraNmJ
	 Gi3g0QFIZbYds8vUeumRigUBgcRRz9RIdWWM5CTSMPCVg0kydK8Dj3GGqVH1l5MNUD
	 33nMWrtk59awp9hCulGYpep2NFJyg1FRv+O0Yw6PJVVyxLc0uGCQXwWqyLvsMGnJnx
	 wgJz2lh4YlD7Q==
From: Gao Xiang <xiang@kernel.org>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: bump up EROFS_CONFIG_COMPR_MAX_SZ
Date: Mon, 13 Jun 2022 00:45:18 +0800
Message-Id: <20220612164518.503836-1-xiang@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Otherwise, compression ratios could be limited when
pcluster size is large. Use a static variable for now.

Signed-off-by: Gao Xiang <xiang@kernel.org>
---
 include/erofs/compress.h | 4 +---
 lib/compress.c           | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/erofs/compress.h b/include/erofs/compress.h
index 40df2bc..24f6204 100644
--- a/include/erofs/compress.h
+++ b/include/erofs/compress.h
@@ -14,9 +14,7 @@ extern "C"
 
 #include "internal.h"
 
-/* workaround for an upstream lz4 compression issue, which can crash us */
-/* #define EROFS_CONFIG_COMPR_MAX_SZ        (1024 * 1024) */
-#define EROFS_CONFIG_COMPR_MAX_SZ           (900  * 1024)
+#define EROFS_CONFIG_COMPR_MAX_SZ           (3000 * 1024)
 #define EROFS_CONFIG_COMPR_MIN_SZ           (32   * 1024)
 
 void z_erofs_drop_inline_pcluster(struct erofs_inode *inode);
diff --git a/lib/compress.c b/lib/compress.c
index 7ebc534..ee3b856 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -607,7 +607,7 @@ void z_erofs_drop_inline_pcluster(struct erofs_inode *inode)
 int erofs_write_compressed_file(struct erofs_inode *inode)
 {
 	struct erofs_buffer_head *bh;
-	struct z_erofs_vle_compress_ctx ctx;
+	static struct z_erofs_vle_compress_ctx ctx;
 	erofs_off_t remaining;
 	erofs_blk_t blkaddr, compressed_blocks;
 	unsigned int legacymetasize;
-- 
2.30.2

