Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB779D5A7D
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Nov 2024 08:57:29 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XvnWR4GlNz30W2
	for <lists+linux-erofs@lfdr.de>; Fri, 22 Nov 2024 18:57:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.132
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1732262241;
	cv=none; b=AxQg/uhHXegmwhpMLgoF22w4aqdHPP82QQxN8nw3ng+bM/aLqtI5OgxLLJmct0c3qaYn7cPshFZSiAKaESCZ5W+fylcijcVFNou8FTkEWGPHiv3eDviw+B+SZiSNYYBB6N28Z+eEsTQN4vfmYNRXYJHgbeTpw8jPXuD0shm98957HjPgZwRz86AZZAREoYaamnilHjIFjygdTLfaHBvCa+AuToggsIb7N0XO3hOFSlQlToXKR47DroNyYZa30MDriOrW7vvcErne4GkaSrQN+pHwcp6g2kkMhrQFBLiSzdX7oQdSvKCBRGrJzr+y1Q5U62H91ZrqOXm1wyOAWD+dqg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1732262241; c=relaxed/relaxed;
	bh=ixGkXK3MKTqiXBjDxjSRt51/Mh3qwW1smIkBbEuPtr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PLK2YDo3llyvDuM74kff3bCnbicw1zEtBYNfJ7N7P33BZW4DUYnyXBNW+CsouPvThROvtjmy/t4aCwKS1FS/N2GQ+4yfBnqzLsUWil/LXlDLiddH+yJRTcphcIwBzjnvxGfjiw+rS7Ug/PCGh4WXVACokyGBFiCiIbyYZnnRcTGMmt9LOFwB1N4H2yuuqyhPjyEShuv3XWhOKDUJ4OmIvXwPpB1qVL15sujPUxtw6WQ/9vtTHeZqkBR/+jZYe+X40bRmsTZl6RzvkT0nPEU9MELE12RBnEG5VdQ5Xo68B3gKB9kF8e55CMYKxgCzG6A3VpadKj3tT2ft9HCqLuT3tA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JXUwcRue; dkim-atps=neutral; spf=pass (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=JXUwcRue;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XvnWJ0ZV5z2ykf
	for <linux-erofs@lists.ozlabs.org>; Fri, 22 Nov 2024 18:57:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732262227; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=ixGkXK3MKTqiXBjDxjSRt51/Mh3qwW1smIkBbEuPtr4=;
	b=JXUwcRueo4n+TiVkOW6By+lXWZYOdGHxKR5tU6BTQKKFW1w5lEHNClgqKyXNeT57LSuGaIydYDIWyPLiDCpjuCtBlK3MrneexKcNQ2AOyY9oPHToOE4daYT0QLRZk8iIte4HikoGhealY/xJo9LHcp+EqFo85gjsH5vrR2dX9yk=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WJztmAU_1732262221 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 22 Nov 2024 15:57:05 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: fix `Not a directory` error for incremental builds
Date: Fri, 22 Nov 2024 15:56:59 +0800
Message-ID: <20241122075659.2869515-1-hsiangkao@linux.alibaba.com>
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

If an incremental layer contains a directory but the same path in
the base layer is a non-directory, it will fail unexpectedly.

Fix it now.

Reported-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Co-developped-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
Fixes: f64d9d02576b ("erofs-utils: introduce incremental builds")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/rebuild.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/lib/rebuild.c b/lib/rebuild.c
index 08c1b86..b37823e 100644
--- a/lib/rebuild.c
+++ b/lib/rebuild.c
@@ -465,7 +465,9 @@ static int erofs_rebuild_basedir_dirent_iter(struct erofs_dir_context *ctx)
 		struct erofs_inode *inode = d->inode;
 
 		/* update sub-directories only for recursively loading */
-		if (S_ISDIR(inode->i_mode)) {
+		if (S_ISDIR(inode->i_mode) &&
+		    (ctx->de_ftype == EROFS_FT_DIR ||
+		     ctx->de_ftype == EROFS_FT_UNKNOWN)) {
 			list_del(&inode->i_hash);
 			inode->dev = dir->sbi->dev;
 			inode->i_ino[1] = ctx->de_nid;
@@ -497,6 +499,15 @@ int erofs_rebuild_load_basedir(struct erofs_inode *dir)
 	if (__erofs_unlikely(IS_ROOT(dir)))
 		dir->xattr_isize = fakeinode.xattr_isize;
 
+	/*
+	 * May be triggered if ftype == EROFS_FT_UNKNOWN, which is impossible
+	 * with the current mkfs.
+	 */
+	if (__erofs_unlikely(!S_ISDIR(fakeinode.i_mode))) {
+		DBG_BUGON(1);
+		return 0;
+	}
+
 	ctx = (struct erofs_rebuild_dir_context) {
 		.ctx.dir = &fakeinode,
 		.ctx.cb = erofs_rebuild_basedir_dirent_iter,
-- 
2.43.5

