Return-Path: <linux-erofs+bounces-3664-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nyU7OaeXM2qwDwYAu9opvQ
	(envelope-from <linux-erofs+bounces-3664-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 09:00:55 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6B969DF59
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2026 09:00:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=IvilxN17;
	dkim=pass header.d=huawei.com header.s=dkim header.b=IvilxN17;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3664-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3664-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ggs7k4HDGz2xM7;
	Thu, 18 Jun 2026 17:00:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1781766050;
	cv=none; b=ZoSYCBFqK6A2hseiQd8SPjun2kspptxNXPKv04HQpyE3ISaq+Q9tRsJHMv55q+5bUoPhXo3GjcyjOtfjwcj7X3pgbN0ARCg3O3nVuFaZi2Lgcguz/LNpEp0djYJz9kjQaZfFRttrxjsiQrBYziBC26yZC5RREnU2GyCQ41OBYttHsG7Wew0ahpvTP1IFM416LOHxczX0Njor/TI6ntg942eaRdlNnH7wTwmBbTh2ImPrhn71h63zKV30M7H8TkFPdPqtefTg/HIIrPkCh7oF9g/g6UFnUW82juUMKExZUjNnIA3ow1sakW9PZ7MZTgZZ2BDtkJcuU/xx6MqIfQIVwg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1781766050; c=relaxed/relaxed;
	bh=sv4nRO/s6qNnmUB5IewXcyNfxJ1Ke3DJiwuXmGOkFyo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wx3OGOPnX/FoQZRqpuxv1UwXTiVBjUVhTc+dUlxbigoBfWq53U5P8UAH6vIN2bLpX9tQzqq+bQbXH7r3mheqZlcLPvzi3udw/QCMAgDNPJI+zo2CYK+4V8I1Uf6fai9kS0AjDBgyuVzqmN58G0AUTMucsLWAT/o46M9FIrNwRx1JWlFvYfgPDogdhCDmnWy3cZfKAU0pWUgiHSofnUDU9+jpQIL5evZo/Ur/2L8+VMFnwtfD/WD3ogldqN6Kz8e8J+1gYEyT9VJSxbpqtpASdnozKtJbzZIqo/mvHi06ozrj0x+VQYf6nhWw+23ZmKYrv7+2VLRjpK2Ol2ULDbBzbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=IvilxN17; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=IvilxN17; dkim-atps=neutral; spf=pass (client-ip=113.46.200.217; helo=canpmsgout02.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ggs7f5Hg1z2yRF
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jun 2026 17:00:44 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sv4nRO/s6qNnmUB5IewXcyNfxJ1Ke3DJiwuXmGOkFyo=;
	b=IvilxN17zQkVoCQM3HZWpeEfNknoXCF24H3OYvAlXTxiwquE72oLi/8UJqMHGi+HNt8M/j0h4
	6x804sobRK09LfLmJ/GiTxPewCJgmukK6p0IzU+cYH39TcDLYRl2b623s+r+wDvlCMec7NLLl/K
	D40pbcGDHYG59pcXch8V2No=
Received: from canpmsgout01.his.huawei.com (unknown [172.19.92.178])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4ggrxm2W0XzcbXZ;
	Thu, 18 Jun 2026 14:52:12 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sv4nRO/s6qNnmUB5IewXcyNfxJ1Ke3DJiwuXmGOkFyo=;
	b=IvilxN17zQkVoCQM3HZWpeEfNknoXCF24H3OYvAlXTxiwquE72oLi/8UJqMHGi+HNt8M/j0h4
	6x804sobRK09LfLmJ/GiTxPewCJgmukK6p0IzU+cYH39TcDLYRl2b623s+r+wDvlCMec7NLLl/K
	D40pbcGDHYG59pcXch8V2No=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4ggrxf1cJ2z1T4hX;
	Thu, 18 Jun 2026 14:52:06 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 5775F40577;
	Thu, 18 Jun 2026 15:00:38 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 18 Jun
 2026 15:00:37 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>, <hsiangkao@linux.alibaba.com>
CC: <yekelu1@huawei.com>, <jingrui@huawei.com>, <zhukeqian1@huawei.com>,
	<zhaoyifan28@huawei.com>
Subject: [RFC PATCH 1/3] erofs-utils: lib: directly propagate vfile errors
Date: Thu, 18 Jun 2026 14:59:20 +0800
Message-ID: <20260618065922.1004653-2-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618065922.1004653-1-zhaoyifan28@huawei.com>
References: <20260618065922.1004653-1-zhaoyifan28@huawei.com>
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
Content-Type: text/plain
X-Originating-IP: [10.50.159.234]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr100010.china.huawei.com (7.202.195.125)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3664-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	HAS_XOIP(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4E6B969DF59

Propagate negative vfile ops errors directly instead of using -errno in
z_erofs_compress_segment().

Assisted-by: Codex:GPT-5.5
Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/compress.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index ea07409..e7c60b2 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -1291,14 +1291,16 @@ int z_erofs_compress_segment(struct z_erofs_compress_sctx *ctx,
 	while (ctx->remaining) {
 		const u64 rx = min_t(u64, ctx->remaining,
 				     Z_EROFS_COMPR_QUEUE_SZ - ctx->tail);
-		int ret;
+		ssize_t ret;
 
 		ret = (offset == -1 ?
 			erofs_io_read(vf, ctx->queue + ctx->tail, rx) :
 			erofs_io_pread(vf, ctx->queue + ctx->tail, rx,
 				       ictx->fpos + offset));
+		if (ret < 0)
+			return ret;
 		if (ret != rx)
-			return -errno;
+			return -EIO;
 
 		ctx->remaining -= rx;
 		ctx->tail += rx;
-- 
2.47.3


