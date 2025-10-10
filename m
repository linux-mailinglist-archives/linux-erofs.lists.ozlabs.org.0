Return-Path: <linux-erofs+bounces-1168-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB4ABCBD45
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Oct 2025 08:54:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cjct94LBMz2xQ0;
	Fri, 10 Oct 2025 17:54:25 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.99
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760079265;
	cv=none; b=gynC9UHL+lgTlJ0/y9riROO0sQmGTpnKT+vg/+34uan2xzpYU/UgJ5BNV62OVtwnQTtK7qjdi+siUfB4voOt+djS7mKP1wdL6o/+aqpSSDw71T3eEh1RAIg/RpB+AY3fb0v9Yf/dwWywlbouQf/8Kbn0yG5duD9A4wihZ02W/6kLUnGmL9pE78KzUGBsfL0QGJYiHjdje9oDlZ1EcWg0Un8fRs/DU+YvKCswDQ76fy/ODc0oGdseeeEUw5TLDK3F4lQvbCitCaBxi9LlS7elIm86jr4s9H2bMoUmBhCPdHeTvCJmCVcTihp5mqjKI3X27a+glW7bXZbmzBeNQ09N2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760079265; c=relaxed/relaxed;
	bh=6kbDw9qEEb1IZ5CuIAIXEivOCQ2/B+pTStcVjdt0rkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dvokc/AMky/eUZz6UxZ1aHS22arXDE/sqgRplddkoZNkCJnoTlT0sw2jf/1XqF0+M3zMKpN0JZE9fWVhKPAdHflqF0c1JIqD4x/37p0mZB/6fyZlZc9A7gEdwzCYZDzvJcq6pPrBqZJ1/5+aRIBHHWcNHftp3yJ6OP9dzXvLQuDM8SpoDwOkR0OBsqiqP3mJpT/DqEMJae0ei2CvgZzkH4Edd4G6twvMKHU68tsw7E5qC3G51uzgMx5x64SHXKkKY5UwKaFXDlCaLXTaaoQ8Eup1kR9Iwy/qbtFQoe/IlLuN0aNP6Kqqu0540bzIdezzs3Aqpym3ioe3Tsr53fiMlQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=c2SC7IbJ; dkim-atps=neutral; spf=pass (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=c2SC7IbJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cjct71l7sz2xPx
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Oct 2025 17:54:21 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760079257; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=6kbDw9qEEb1IZ5CuIAIXEivOCQ2/B+pTStcVjdt0rkE=;
	b=c2SC7IbJSuCHwk8e4Fj8p4zJM5iWBNFxwluMSRUHv2JIHbiFknfGsdkRPf0BEpuTgpwjMwmZIkJ5rnkiIakTjgJHTXtXIU4o1KEO/+5tCZTX0Cc8noQa6XkA0+fVNBsoKwaiV+QSPq0kY/sbQeQRpusxT6L3b5bBY2uU0e8Azr4=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WpsV4jC_1760079250 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 10 Oct 2025 14:54:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mount: nbd: retry indefinitely on network I/O errors
Date: Fri, 10 Oct 2025 14:54:09 +0800
Message-ID: <20251010065409.104382-1-hsiangkao@linux.alibaba.com>
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

Due to an NBD protocol limitation, the status code for
erofs_nbd_send_reply_header() has already been sent before the data
arrives.

A better solution will be considered later.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mount/main.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index d98e1e9..ccf4193 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -596,11 +596,9 @@ static void *erofsmount_nbd_loopfn(void *arg)
 
 		erofs_nbd_send_reply_header(ctx->sk.fd, rq.cookie, 0);
 		pos = rq.from;
-		rem = erofs_io_sendfile(&ctx->sk, &ctx->vd, &pos, rq.len);
-		if (rem < 0) {
-			err = -errno;
-			break;
-		}
+		do {
+			rem = erofs_io_sendfile(&ctx->sk, &ctx->vd, &pos, rq.len);
+		} while (rem < 0);
 		err = __erofs_0write(ctx->sk.fd, rem);
 		if (err) {
 			if (err > 0)
-- 
2.43.5


