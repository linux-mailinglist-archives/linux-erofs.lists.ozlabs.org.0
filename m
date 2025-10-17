Return-Path: <linux-erofs+bounces-1226-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5BABE846F
	for <lists+linux-erofs@lfdr.de>; Fri, 17 Oct 2025 13:20:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cp2Rj0Qzbz3cZL;
	Fri, 17 Oct 2025 22:20:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1760700016;
	cv=none; b=S1ggylaaC4ShGdtfi8bNpven4ytnh9VdiOkUDYVXk/Y6v9UyOeibI9JBCa2qfobUSorodSFKZY3sAU8neGFP/zcb9/3BKZsArXNvQKomvHUW3eG5BA+wjQ27l2a5epMVOPD1HkjfzVzBTwIKzM0Fbp95UKSvquf+ZyyQgtpqVufx4s7pR7vudz6NiTntDk1MfDSGKwe9LbtNyaR+AjggwEifUE3Hjq3LIrO4n57/GoMLMjuxlAjBTUZGtgv88SGN8PfiDxtxmBIDPqgr7wKdx2o4R6q8wHdkx5tiQ9hQRqvgl0K3XSekGqILv2CQs4ohmIbGU6QD68jf4iK6qut4nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1760700016; c=relaxed/relaxed;
	bh=D7Y446ncyV5ljVEbh9+gIrFOKZy/zXmFp84iyyVDx0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dRuzNXGPBJKNQyaWQX9PrRW929dCOC2Qqbclm+2iQ3pQZ2t1q67LuCHU7S7tlTOlvpGnxEqsEKmY/F/zanzFPLV7QrTWIpVGmAXtA0/iwPS04TIVq5rnf7nsdCYZv4mItYEGM2rkSwYncAahHl3tw2gmlxERG75qep4RAXk+rGXiAzEQfX8KIrysoka0DR19OkpBtBLxP1L6PIKDTsOLMhW9FWI0PIFtddjBF2pjldF2AU760sW1RdWeVEEdG9AfuruD5iPv6PzPFP5hEja+QKpeS3tVfxXXMlQZvce0nnnk2OVSvh42Vl9uAPLaunY5BpwlglbG6n2OleSCGUAy2g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vbIRcJeB; dkim-atps=neutral; spf=pass (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vbIRcJeB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cp2Rg0M8Jz3cYg
	for <linux-erofs@lists.ozlabs.org>; Fri, 17 Oct 2025 22:20:13 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760700009; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=D7Y446ncyV5ljVEbh9+gIrFOKZy/zXmFp84iyyVDx0U=;
	b=vbIRcJeB/eCiOgULPFGp2ReXuSYNd3nzY3vEn8y9lvwmH8nh/vrM8Qzk/pgjA0azAZi/SUlUdGYJfG3KV6v3GbH26a/In/bWMCmptDfTYDkcKK5vnUkuq8RGaWu2uc0aT0TI6AgD8QMK1TRAgqb96QHY+0S/0y9Tkop64WnKSrs=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WqPWSp3_1760700004 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 17 Oct 2025 19:20:08 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 1/2] erofs-utils: lib: fix erofs_io_sendfile() again
Date: Fri, 17 Oct 2025 19:20:01 +0800
Message-ID: <20251017112002.1254940-1-hsiangkao@linux.alibaba.com>
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

The number of bytes written should be returned.

Fixes: 29466e7f1cbf ("erofs-utils: lib: fix erofs_io_sendfile()")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/io.c     | 13 +++++++------
 mount/main.c | 12 ++++++------
 2 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/lib/io.c b/lib/io.c
index 440f69b..90d2e54 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -581,6 +581,7 @@ ssize_t erofs_io_sendfile(struct erofs_vfile *vout, struct erofs_vfile *vin,
 			  off_t *pos, size_t count)
 {
 	ssize_t read, written;
+	size_t rem = count;
 
 	if (vin->ops || vout->ops) {
 		if (vin->ops && vin->ops->sendfile)
@@ -600,13 +601,13 @@ ssize_t erofs_io_sendfile(struct erofs_vfile *vout, struct erofs_vfile *vin,
 			}
 			break;
 		}
-		count -= written;
+		rem -= written;
 	} while (written);
 #endif
-	while (count) {
+	while (rem) {
 		char buf[max(EROFS_MAX_BLOCK_SIZE, 32768)];
 
-		read = min_t(u64, count, sizeof(buf));
+		read = min_t(u64, rem, sizeof(buf));
 		if (pos)
 			read = erofs_io_pread(vin, buf, read, *pos);
 		else
@@ -615,17 +616,17 @@ ssize_t erofs_io_sendfile(struct erofs_vfile *vout, struct erofs_vfile *vin,
 			written = read;
 			break;
 		}
-		count -= read;
+		rem -= read;
 		if (pos)
 			*pos += read;
 		do {
 			written = erofs_io_write(vout, buf, read);
 			if (written < 0)
-				break;
+				return written;
 			read -= written;
 		} while (read);
 	}
-	return written < 0 ? written : count;
+	return written < 0 ? written : count - rem;
 }
 
 int erofs_io_xcopy(struct erofs_vfile *vout, off_t pos,
diff --git a/mount/main.c b/mount/main.c
index 53bd2b2..e25134c 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -577,7 +577,7 @@ static void *erofsmount_nbd_loopfn(void *arg)
 
 	while (1) {
 		struct erofs_nbd_request rq;
-		ssize_t rem;
+		ssize_t written;
 		off_t pos;
 
 		err = erofs_nbd_get_request(ctx->sk.fd, &rq);
@@ -597,13 +597,13 @@ static void *erofsmount_nbd_loopfn(void *arg)
 		erofs_nbd_send_reply_header(ctx->sk.fd, rq.cookie, 0);
 		pos = rq.from;
 		do {
-			rem = erofs_io_sendfile(&ctx->sk, &ctx->vd, &pos, rq.len);
-			if (rem == -EINTR) {
-				err = rem;
+			written = erofs_io_sendfile(&ctx->sk, &ctx->vd, &pos, rq.len);
+			if (written == -EINTR) {
+				err = written;
 				goto out;
 			}
-		} while (rem < 0);
-		err = __erofs_0write(ctx->sk.fd, rem);
+		} while (written < 0);
+		err = __erofs_0write(ctx->sk.fd, rq.len - written);
 		if (err) {
 			if (err > 0)
 				err = -EIO;
-- 
2.43.5


