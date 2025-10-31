Return-Path: <linux-erofs+bounces-1307-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC48C234D7
	for <lists+linux-erofs@lfdr.de>; Fri, 31 Oct 2025 06:47:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cyVPm18f5z2xWc;
	Fri, 31 Oct 2025 16:47:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1761889676;
	cv=none; b=ODFmzsbNW7RWMu6luhSi2xcZHnSLLwsYZYL2w4wJAjKsdXJ+Lpwgc5HXKdtkyptDCi9XUBOELhA3MXceZ3a0yprLcytLGAjFs2bxe8Jio05kJ9FWTid8QbRqXuNaogkDNqO7NMwjlzqeUFfXF/EQB9I4H58ZoniJvmk+FB6ewRw+g4rzVda71wvirpz42DPIvQQlqt7oTJXkgWgk7NDq+PBrT1Nav63o7Bh6PcPG14cEGJ47Ldl8HFtmUvIqGjbexT59vn4d2G5CRJ4k1isrdL8jCHUtjyIEYkB3ujxc9NXMIbFuW7vq3PVix4QrM5Leb5N6EvnCIpt5ONQo44hPvw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1761889676; c=relaxed/relaxed;
	bh=wfeFgdZvyu0jYTVA6vIV7jCk6gqYdTkVFzYAV142tGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P1IN68olse8SbGqrGHus0PnxUrKAon1Y2NsAmoYYO75bOnz3raYxoLdfBjBp5+f+EI/y2Z8+wZzVY6yuRrrWptm5rly6ctlmplae9Ig27fct2ADSoEfiGzfjrNb+6+xh+QIVxJ7OQYuarUhwfQ5FnEwIAxNO4fwD3mohJTqpDcWXYOWC3pRjmN2ZaoL/UPdp4SRr9xYXXUupJBdEOrQlKI+Hu/0RT8EltOoSyWaJ198ooKuoNuuApM+lkxplXJCCd/XxM8gwEDOj0ROfCYTmBNpMh9AMrPR5dhxk8uhQp/OTxekeFeiw+8Lu8NY4roy/CSq0odyQdnCRr1eYT5Zh9Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XlhvSGTI; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=XlhvSGTI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cyVPj6VRcz2xS2
	for <linux-erofs@lists.ozlabs.org>; Fri, 31 Oct 2025 16:47:52 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761889667; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wfeFgdZvyu0jYTVA6vIV7jCk6gqYdTkVFzYAV142tGo=;
	b=XlhvSGTIiEn3MbLL+lv4c9dW2EYB3MdJSnnND4LYnZGxgEJFq9tRsFH5FPa/G/YlWjVkwblRHX8hHzoioUY/qwA492kj6mdVARS2FhOwXIxQZFrHBRW4Vnq1PNk04667iAQTFoEByrvRTIEo1b/fcIaCuXj9qRk5c4h2N31rCrg=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WrNt.oV_1761889660 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Oct 2025 13:47:45 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Robert Morris <rtm@csail.mit.edu>
Subject: [PATCH] erofs: avoid infinite loop due to incomplete zstd-compressed data
Date: Fri, 31 Oct 2025 13:47:39 +0800
Message-ID: <20251031054739.1814530-1-hsiangkao@linux.alibaba.com>
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

Currently, the decompression logic incorrectly spins if compressed
data is truncated in crafted (deliberately corrupted) images.

Fixes: 7c35de4df105 ("erofs: Zstandard compression support")
Reported-by: Robert Morris <rtm@csail.mit.edu>
Closes: https://lore.kernel.org/r/50958.1761605413@localhost
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
Actually I suspect multi-shot decompressor lzma may have a similar
issue (but it seems deflate is not), will check later.

 fs/erofs/decompressor_zstd.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/erofs/decompressor_zstd.c b/fs/erofs/decompressor_zstd.c
index b4bfe14229f9..e38d93bb2104 100644
--- a/fs/erofs/decompressor_zstd.c
+++ b/fs/erofs/decompressor_zstd.c
@@ -172,7 +172,6 @@ static int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 	dctx.bounce = strm->bounce;
 
 	do {
-		dctx.avail_out = out_buf.size - out_buf.pos;
 		dctx.inbuf_sz = in_buf.size;
 		dctx.inbuf_pos = in_buf.pos;
 		err = z_erofs_stream_switch_bufs(&dctx, &out_buf.dst,
@@ -188,14 +187,18 @@ static int z_erofs_zstd_decompress(struct z_erofs_decompress_req *rq,
 		in_buf.pos = dctx.inbuf_pos;
 
 		zerr = zstd_decompress_stream(stream, &out_buf, &in_buf);
-		if (zstd_is_error(zerr) || (!zerr && rq->outputsize)) {
+		dctx.avail_out = out_buf.size - out_buf.pos;
+		if (zstd_is_error(zerr) ||
+		    ((rq->outputsize + dctx.avail_out) && (!zerr || (zerr > 0 &&
+				!(rq->inputsize + in_buf.size - in_buf.pos))))) {
 			erofs_err(sb, "failed to decompress in[%u] out[%u]: %s",
 				  rq->inputsize, rq->outputsize,
-				  zerr ? zstd_get_error_name(zerr) : "unexpected end of stream");
+				  zstd_is_error(zerr) ? zstd_get_error_name(zerr) :
+					"unexpected end of stream");
 			err = -EFSCORRUPTED;
 			break;
 		}
-	} while (rq->outputsize || out_buf.pos < out_buf.size);
+	} while (rq->outputsize + dctx.avail_out);
 
 	if (dctx.kout)
 		kunmap_local(dctx.kout);
-- 
2.43.5


