Return-Path: <linux-erofs+bounces-638-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B16B07B1C
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Jul 2025 18:25:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bj1cD0MdTz2ySY;
	Thu, 17 Jul 2025 02:25:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752683099;
	cv=none; b=H93nnLG19iZXFj4FQ+ZhfzuRVX6YqgAyvb1ZAnGQHY4GPiPM/AJ0CP/Wo6jPRtkRlGvTZbxVTrmfciNVQssznAYJO1d1SbJ29IrF4frg+N7Gh58cqn8ZLj7Ai4fuKYfOyRwph52xL0eSQWNzeZscap2C45vZST9a5V8quNa3TnXQoxrSFe7LVVNUbmWCDJaFCp68iz0mOJLr1wNG33TTasJlh5PJr9zkdV+ISKvtcbL2c/+Ng+utVT4ptl4+IRczXvsV89bl3ZLlxN6X0QaZQE+wgH3EvbWClt16aEDUF8QtTQi/KUjr1h+aMMUQ0ScFoOiDDz6IqggS888N1TaRmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752683099; c=relaxed/relaxed;
	bh=hUrvBhpLJeo5e2F+FxUovDoRKL1vlAGdqOeC7hnz8Fs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VfQ1nh9r+yKiJXfRG32w/mvJ6JaINPo1+ZZF5f6mf6JwXLT0eeRGOaI1XvB8ccR7FtYYFbt0wl7IT2VmlOPQYR7pt+8KoLOZPAn7UQD+dltBVsfa6MC+HLYq192jwCE1Id1LgjFlaivDP1DT0Fz3l+mh6/+v30GS0EOFj25JgXaL6qb9dhgET3mYdAOW674nsOvNnoHzZ6mEsYhDVRW3wE9S7QzqVxVbpVaLfNWdrvPpmmc0P8wy9f3JSZVk2MW6dqF6nowZ6yHgj2F0EFFNB2uY4zGCNu5llJ0d9Zbu4S7/g1jxWKhc103F/ei4eR9QRZ2ZfzBspR+OGNjAkBMt0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MKv+AWyp; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MKv+AWyp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bj1c772Fxz30VZ
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Jul 2025 02:24:54 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752683089; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hUrvBhpLJeo5e2F+FxUovDoRKL1vlAGdqOeC7hnz8Fs=;
	b=MKv+AWyprCytdTIYbQevY6YNUWt0JdowRJaPBpchRXNgW5ZEh0HPsfqqDlpoZCJ8+zxPcfWu7d9ODYGac41udrokB3MHxmLn7i5f+5NJech6luUdbor/ZGjaE+MSZQbq5dWr+dHWgL+dXfruUTPVU8QKU3/+G73uo/TWrhRud6M=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj5JWtY_1752683083 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 00:24:47 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/3] erofs-utils: mkfs: don't generate encoded extents for ztailpacking
Date: Thu, 17 Jul 2025 00:24:39 +0800
Message-ID: <20250716162441.209783-1-hsiangkao@linux.alibaba.com>
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

.. Need more library work for ztailpacking.

Fixes: f978245e9da8 ("erofs-utils: support encoded extents")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/compress.c b/lib/compress.c
index a57bb6a3..22fb5d6d 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1142,7 +1142,8 @@ static void *z_erofs_write_indexes(struct z_erofs_compress_ictx *ctx)
 	struct z_erofs_extent_item *ei, *n;
 	void *metabuf;
 
-	if (erofs_sb_has_48bit(sbi)) {
+	/* TODO: support writing encoded extents for ztailpacking later. */
+	if (erofs_sb_has_48bit(sbi) && !inode->idata_size) {
 		metabuf = z_erofs_write_extents(ctx);
 		if (metabuf != ERR_PTR(-EAGAIN)) {
 			if (IS_ERR(metabuf))
@@ -1181,6 +1182,8 @@ static void *z_erofs_write_indexes(struct z_erofs_compress_ictx *ctx)
 	ctx->metacur = metabuf + Z_EROFS_LEGACY_MAP_HEADER_SIZE;
 	ctx->clusterofs = 0;
 	list_for_each_entry_safe(ei, n, &ctx->extents, list) {
+		DBG_BUGON(ei->list.next != &ctx->extents &&
+			  ctx->clusterofs + ei->e.length < erofs_blksiz(sbi));
 		z_erofs_write_full_indexes(ctx, &ei->e);
 
 		list_del(&ei->list);
-- 
2.43.5


