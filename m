Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7933376DF7E
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Aug 2023 07:00:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RGc9x04MMz30g8
	for <lists+linux-erofs@lfdr.de>; Thu,  3 Aug 2023 15:00:53 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.111; helo=out30-111.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RGc9n3ZCkz30g8
	for <linux-erofs@lists.ozlabs.org>; Thu,  3 Aug 2023 15:00:43 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VoxOOF1_1691038832;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VoxOOF1_1691038832)
          by smtp.aliyun-inc.com;
          Thu, 03 Aug 2023 13:00:37 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: dump: use a new subdir context for erofs_get_pathname()
Date: Thu,  3 Aug 2023 13:00:31 +0800
Message-Id: <20230803050031.130026-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

It's absolutely unsafe to reuse struct erofs_dir_context.  Also,
we'd like to refactor erofs_get_pathname() in the future.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/dir.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/lib/dir.c b/lib/dir.c
index e8df9f7..fff0bc0 100644
--- a/lib/dir.c
+++ b/lib/dir.c
@@ -217,10 +217,16 @@ static int erofs_get_pathname_iter(struct erofs_dir_context *ctx)
 		}
 
 		if (S_ISDIR(dir.i_mode)) {
-			ctx->dir = &dir;
-			pathctx->pos = pos + len + 1;
-			ret = erofs_iterate_dir(ctx, false);
-			pathctx->pos = pos;
+			struct erofs_get_pathname_context nctx = {
+				.ctx.flags = 0,
+				.ctx.dir = &dir,
+				.ctx.cb = erofs_get_pathname_iter,
+				.target_nid = pathctx->target_nid,
+				.buf = pathctx->buf,
+				.size = pathctx->size,
+				.pos = pos + len + 1,
+			};
+			ret = erofs_iterate_dir(&nctx.ctx, false);
 			if (ret == EROFS_PATHNAME_FOUND) {
 				pathctx->buf[pos++] = '/';
 				strncpy(pathctx->buf + pos, dname, len);
-- 
2.24.4

