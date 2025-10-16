Return-Path: <linux-erofs+bounces-1187-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F722BE14F8
	for <lists+linux-erofs@lfdr.de>; Thu, 16 Oct 2025 04:48:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cnC7d6b0Mz2yQH;
	Thu, 16 Oct 2025 13:48:29 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760582909;
	cv=none; b=PoLbGmNaHsk5zSUFr45wf2sYQqnfgbXq5ERA3QAIaSpikrGZmyHrxEO3cA3huM7Df5xm62cZ/jFf57PcCB0L/aBvlqUqG7blsXC7a3hQe1JepoJHlnQaA+T2uAwFK8yKz4j2cp7vQ87tEOCMis1kQtpKfRzWCC52zbozMRXg0A0JZhpApac4tHP+ZDC9ArtXk481strAapaqI+HW6UVRLNifGo2LwQkmUp6nDdSEpdaSN6tazQ5l5beLzUMiLIHmC42sFgUTRbFGtL5Wo4v11AlseJqAVo8JyowSxOwEIj70P/h0PPtNw2U9HX+ItsMfsv9TzQHW6WuTZ955+EqBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760582909; c=relaxed/relaxed;
	bh=Qo6vdEDkApS2mFPI3GLGBw3gdmrpYYI8z4dUzti+jzY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TO0tG4CuPDMtMD/+TzdlXa5H0KWQQWfAheplYMdH51Xf6WaTjdVJ+hJeIRvcjWF6/C7GLhu56bWBGcu4YQbTyGGyjI0z/JNHjM5qgujsrHhjUqPdRkzwfqWfPJ0zLMWm5qQjMHeWbE+Hwe/XJhF5bfzI06dQoG0/eQiA9zqSagpfEgzZg7Vjw70fGnpcaMwk+n6lw5D8ZJSVqlSH/vApnQqyBqysCckR1ezhaM7eJZs7czvizwAVyHq0pY+cBvuOrBuv2hecrfVfQsNBY0FNMBthiZEWZ7zrMMIFo/VL9lwna3BQkfTvm70+YAfUQn6cj74B2RuoPKtWaMDMbxrgfQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=m/An3fWu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=m/An3fWu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cnC7b2X6hz2yqq
	for <linux-erofs@lists.ozlabs.org>; Thu, 16 Oct 2025 13:48:25 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760582901; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Qo6vdEDkApS2mFPI3GLGBw3gdmrpYYI8z4dUzti+jzY=;
	b=m/An3fWupXDQe/yI23Na/aqKuotIPy6w3zuErYjCMs7KgYBVya7NXx7WygcIdCwEnpCZGPHkp0ZRXtztR1Gz439G8UrkKywikSsHd0amcSWwlJsyfsv6p5lg6dolvxDdat+LEBK4UsUhCwHpPSFFpo38xMpkRficrA9dam6mlww=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqIZVhW_1760582896 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 16 Oct 2025 10:48:20 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/7] erofs-utils: lib: fix a misuse of `params->all_fragments`
Date: Thu, 16 Oct 2025 10:48:09 +0800
Message-ID: <20251016024815.2750927-1-hsiangkao@linux.alibaba.com>
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

Should use `all_fragments` to skip special inodes.

Fixes: 7c153f1875dc ("erofs-utils: lib: migrate advance compression configurations")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/compress.c b/lib/compress.c
index b7ca3ad..7f34b66 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1873,7 +1873,7 @@ void *erofs_begin_compressed_file(struct erofs_importer *im,
 	ictx->fragemitted = false;
 	ictx->dedupe = false;
 
-	if (params->all_fragments && !inode->fragment_size) {
+	if (all_fragments && !inode->fragment_size) {
 		ret = erofs_pack_file_from_fd(inode, fd, ictx->tofh);
 		if (ret)
 			goto err_free_idata;
-- 
2.43.5


