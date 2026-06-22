Return-Path: <linux-erofs+bounces-3698-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DOncKCSvOGq4fwcAu9opvQ
	(envelope-from <linux-erofs+bounces-3698-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 05:42:28 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A47C6AC510
	for <lists+linux-erofs@lfdr.de>; Mon, 22 Jun 2026 05:42:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=ZOtA1kL0;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3698-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3698-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gkDXs4Y1qz2yVd;
	Mon, 22 Jun 2026 13:42:21 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782099741;
	cv=none; b=a9WsewDI80b8mI8HaRAlIO1UyJC5dOwrgR4Ck0oNvXM7LCwjKNFCf7eJB+dVEKGkKgZ+57TWtPU69Ytesu5SpVqrkgoU+/vuadLAccMmyuHi4EKPdhrrCbFtgxYr6XMyM3Ig/51qIYimZv6DHAtRLje6CHZfm3RKE1TvT5L4Rv5GI1Ty+viWUBfVvVyy1BjUBhM70q19st1pG75pntIFmwI+FUvUpy9MfCaAiMrxbxWav6UkqTy2CoD3WD+sJcchkH7OpOzgLfh/Lba4uQ0dHyneLtZpqEkqgv0QRSKSltppc44HHOXbxkvnYSuKduf0ozrI023uC4V0PBeL2jWwlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782099741; c=relaxed/relaxed;
	bh=7ovTf7l0wy3Fx0EY9949fVau2mCftdSE6nJpgWYIhwA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fHEjKBteV91YwDUvj/cETrWo4pza2u1VIw4khgjTExBoeyQq4GOoxzhH3dyF/olne6FkwzomCZxEM6UldJX+ojP/Qe1NDc8jQo2XtOjwokPwc6nFv7fSTyHqP1+36UNLP/1SiMe+Od4grFZzTONvUrD/V5v0sehLXYG1LhY9KLBXTUmjR6zNyExDMLir4Rv+8wnBF8NJfk2EstBr0/Qubn8+w7lb+QeSManPt2mN2dN0jfLQvCZhQ4ls9Zep8yeTR4uAirXsN3nMO2y7IKKoPrBA2uAQOZaFmH0htKJth943fx23SR+Ejk9LUhaox+p/J8+HYdH8zFxsokfQkmA5Bw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=ZOtA1kL0; dkim-atps=neutral; spf=pass (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gkDXq2vhsz2yVP
	for <linux-erofs@lists.ozlabs.org>; Mon, 22 Jun 2026 13:42:16 +1000 (AEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=7ovTf7l0wy3Fx0EY9949fVau2mCftdSE6nJpgWYIhwA=;
	b=ZOtA1kL0+XbIDPK55L7mGkKQf5otG8/sCropAGax9ZF+PnlcUOKwJdwdb20/JNfcK+AFcQ79H
	AoCrtd8sJI+vXsd3Y4/AHxHvrEvsRBIdYmaGl0JHFFcp5HjpyJa0qmspZFGs9UBDm46ALxZQ5vS
	BZzbTnAigqhukSQLRj+xdHs=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gkDLD2WTBz1K982;
	Mon, 22 Jun 2026 11:33:08 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id 1758A405D3;
	Mon, 22 Jun 2026 11:42:11 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemr100010.china.huawei.com
 (7.202.195.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 22 Jun
 2026 11:42:10 +0800
From: Yifan Zhao <zhaoyifan28@huawei.com>
To: <linux-erofs@lists.ozlabs.org>, <hsiangkao@linux.alibaba.com>
CC: <zhukeqian1@huawei.com>, <zhaoyifan28@huawei.com>
Subject: [PATCH 1/2] erofs-utils: lib: don't abort on compression fallback
Date: Mon, 22 Jun 2026 11:40:51 +0800
Message-ID: <20260622034052.1047677-1-zhaoyifan28@huawei.com>
X-Mailer: git-send-email 2.47.3
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
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3698-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	HAS_XOIP(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foxmail.com:email,huawei.com:dkim,huawei.com:email,huawei.com:mid,huawei.com:from_mime,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3A47C6AC510

From: Yifan Zhao <yifan.yfzhao@foxmail.com>

-ENOSPC can be a normal compression fallback when fragments are off.
Keep the global compression context reusable for that case while
preserving the fatal state for real errors.

Fixes: a729584ef975 ("erofs-utils: mkfs: avoid hanging if fragment is on and tmpdir is full")
Reported-by: Bastian Schmitz <8330902+bshm@users.noreply.github.com>
Closes: https://github.com/erofs/erofs-utils/issues/50
Assisted-by: Codex:GPT-5.5
Signed-off-by: Yifan Zhao <zhaoyifan28@huawei.com>
---
 lib/compress.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/lib/compress.c b/lib/compress.c
index ea07409..2a43b81 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -2031,7 +2031,11 @@ err_free_idata:
 out:
 #ifdef EROFS_MT_ENABLED
 	pthread_mutex_lock(&ictx->mutex);
-	ictx->seg_num = ret < 0 ? INT_MAX : 0;
+	if (ret < 0 && (ret != -ENOSPC || inode->fragment_size))
+		/* mark as failed to avoid further processing */
+		ictx->seg_num = INT_MAX;
+	else
+		ictx->seg_num = 0;
 	pthread_cond_signal(&ictx->cond);
 	pthread_mutex_unlock(&ictx->mutex);
 #endif
-- 
2.47.3


