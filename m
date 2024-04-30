Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 232468B6A8E
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Apr 2024 08:38:06 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=H6fOjCaA;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VT9Vq2m7Fz3cLQ
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Apr 2024 16:37:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=H6fOjCaA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VT9Vf0lHXz2xHK
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Apr 2024 16:37:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714459060; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=RnObM7gb/4xjJhQ325WoNti7tToqO2n5kX8UNsmNPG4=;
	b=H6fOjCaAKq7zM5ukYBp+XM069E/20IS+dm3NM6yeFAMwcz7mijFImE/UrKA813p0FpHdN6F6zJFau95VK665xr386m+KwJjqlFASWZiceprdijp12RIud/CeohLPAMD9z23UMcMdpSBTJauHJD6bW7ueZbeqMQoJGZsLYKr1fLs=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W5bHMIe_1714459057;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5bHMIe_1714459057)
          by smtp.aliyun-inc.com;
          Tue, 30 Apr 2024 14:37:38 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH 2/2] erofs-utils: lib: adjust MicroLZMA default dictionary size
Date: Tue, 30 Apr 2024 14:37:30 +0800
Message-Id: <20240430063730.599937-2-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240430063730.599937-1-hsiangkao@linux.alibaba.com>
References: <20240430063730.599937-1-hsiangkao@linux.alibaba.com>
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

If dict_size is not given, it will be set as max(32k, pclustersize * 8)
but no more than Z_EROFS_LZMA_MAX_DICT_SIZE.

Also kill an obsolete warning since multi-threaded support is landed.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compressor_liblzma.c | 19 +++++++++++--------
 mkfs/main.c              |  8 ++++++--
 2 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/lib/compressor_liblzma.c b/lib/compressor_liblzma.c
index 2f19a93..d609a28 100644
--- a/lib/compressor_liblzma.c
+++ b/lib/compressor_liblzma.c
@@ -70,11 +70,18 @@ static int erofs_compressor_liblzma_setlevel(struct erofs_compress *c,
 static int erofs_compressor_liblzma_setdictsize(struct erofs_compress *c,
 						u32 dict_size)
 {
-	if (!dict_size)
-		dict_size = erofs_compressor_lzma.default_dictsize;
+	if (!dict_size) {
+		if (erofs_compressor_lzma.default_dictsize) {
+			dict_size = erofs_compressor_lzma.default_dictsize;
+		} else {
+			dict_size = min_t(u32, Z_EROFS_LZMA_MAX_DICT_SIZE,
+					  cfg.c_mkfs_pclustersize_max << 3);
+			if (dict_size < 32768)
+				dict_size = 32768;
+		}
+	}
 
-	if (dict_size > erofs_compressor_lzma.max_dictsize ||
-	    dict_size < 4096) {
+	if (dict_size > Z_EROFS_LZMA_MAX_DICT_SIZE || dict_size < 4096) {
 		erofs_err("invalid dictionary size %u", dict_size);
 		return -EINVAL;
 	}
@@ -86,7 +93,6 @@ static int erofs_compressor_liblzma_init(struct erofs_compress *c)
 {
 	struct erofs_liblzma_context *ctx;
 	u32 preset;
-	static erofs_atomic_bool_t __warnonce;
 
 	ctx = malloc(sizeof(*ctx));
 	if (!ctx)
@@ -105,15 +111,12 @@ static int erofs_compressor_liblzma_init(struct erofs_compress *c)
 	ctx->opt.dict_size = c->dict_size;
 
 	c->private_data = ctx;
-	if (!erofs_atomic_test_and_set(&__warnonce))
-		erofs_warn("It may take a longer time since MicroLZMA is still single-threaded for now.");
 	return 0;
 }
 
 const struct erofs_compressor erofs_compressor_lzma = {
 	.default_level = LZMA_PRESET_DEFAULT,
 	.best_level = 109,
-	.default_dictsize = Z_EROFS_LZMA_MAX_DICT_SIZE,
 	.max_dictsize = Z_EROFS_LZMA_MAX_DICT_SIZE,
 	.init = erofs_compressor_liblzma_init,
 	.exit = erofs_compressor_liblzma_exit,
diff --git a/mkfs/main.c b/mkfs/main.c
index 3d19f60..bbf4f43 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -137,8 +137,12 @@ static void usage(int argc, char **argv)
 				       spaces, s->c->best_level, s->c->default_level);
 		}
 		if (s->c->setdictsize) {
-			printf("%s  [,dictsize=<dictsize>]\t(default=%u, max=%u)\n",
-			       spaces, s->c->default_dictsize, s->c->max_dictsize);
+			if (s->c->default_dictsize)
+				printf("%s  [,dictsize=<dictsize>]\t(default=%u, max=%u)\n",
+				       spaces, s->c->default_dictsize, s->c->max_dictsize);
+			else
+				printf("%s  [,dictsize=<dictsize>]\t(default=<auto>, max=%u)\n",
+				       spaces, s->c->max_dictsize);
 		}
 	}
 	printf(
-- 
2.39.3

