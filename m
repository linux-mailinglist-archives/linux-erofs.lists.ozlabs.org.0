Return-Path: <linux-erofs+bounces-3789-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nk3zLYgvQ2rYTwoAu9opvQ
	(envelope-from <linux-erofs+bounces-3789-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jun 2026 04:52:56 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 300DA6DFE80
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jun 2026 04:52:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=yM2Tg02r;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3789-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3789-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gq73t45qhz2ydn;
	Tue, 30 Jun 2026 12:52:42 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782787962;
	cv=none; b=E5Cqli0KwlV5cLkPn+oLb+5MpKZE89CbF0bDhDrL7/TMWZtI9luFtbcbRGmNV9G7tZfDpHa9lDbboqtD3/90mN7y6c13JUne6vdCXA9JI+mmk+WU9+M00PFc1bzZqrhEDMivhMGv0A7TPdLsV0CGQB/jdeWtYJFOLg6OGCQM8OamAsiIvjjBxcPpZejjMWrN/47S66uMiI460Wtvzbgx361j3/mr+m0j4ZiYT+zFgH73EodlNbjYJ+15+spoTD5yJJ1Li4O3JaoWHT0ZiR84oAG8KURPtIrZXlnyzNdeDcDGf8B48kvDX34E2/wnFtwmo2nfmzHkAGg0GNefiGuwwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782787962; c=relaxed/relaxed;
	bh=m+1WkG8Tsig8RYWrER4ow7rSfWecNZk5XkRqn509qhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XKY5/y8VCwGA9SiHD7vgvg8qgEq1BWBqJOB/zZfIcA6OIKMsHd0+x3FGFk4tP82qAyeViDEwbDe46B1z+d4EgFiU2vCttoHXj0IOsWoLjGuE63S8pR2NP+BUumfJcA/s1mIHy/yksz+KaXEG+REHOQRFQvwrKgY20GqF47xVwmhkAPCPSxLSmSqxO13i+Knv6WucK2n1mGsgp3uftmAU4YrYZpERuHH9J7RFHbgKiVN9lf4YXkwDzQ5CtBYhX/twp/GGbT5iNiBiZp9otF3+Z/hCcxcW3eiWQnhVoYiK+tgadrU0vdLeqi9nAwsw+EAXG+Gkes8f30w4I+IPW1WvGg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=yM2Tg02r; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gq73s4jG5z2ybR
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jun 2026 12:52:41 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782787957; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=m+1WkG8Tsig8RYWrER4ow7rSfWecNZk5XkRqn509qhs=;
	b=yM2Tg02riCR5ANcIrg1YrNusZcjhFvehupVtf+0C9XBn+zlorNtQ6yz74Zf3387ItuQsxc+o4QONE7meGcUwsntxXQunfK89OyO7TY0+0kMisk28eEwLOX3XkvD00313Y7CuohcqYr4DyxwzNr9XCVzjiD9WXnpqz10kd/2CVRw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X5zS2qs_1782787954;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5zS2qs_1782787954 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Jun 2026 10:52:34 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 7/7] erofs-utils: lib: silence `INTEGER_OVERFLOW`
Date: Tue, 30 Jun 2026 10:52:24 +0800
Message-ID: <20260630025224.3955763-7-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260630025224.3955763-1-hsiangkao@linux.alibaba.com>
References: <20260630025224.3955763-1-hsiangkao@linux.alibaba.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3789-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime,alibaba.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 300DA6DFE80

Coverity-id: 647247
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/inode.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/inode.c b/lib/inode.c
index 9f1553e8db2b..267694f83fdf 100644
--- a/lib/inode.c
+++ b/lib/inode.c
@@ -670,10 +670,13 @@ static int erofs_write_unencoded_data(struct erofs_inode *inode,
 	if (bh) {
 		bmgr = (struct erofs_bufmgr *)bh->block->buffers.fsprivate;
 		pos = erofs_btell(bh, false);
+		if (__erofs_unlikely(pos == EROFS_NULL_ADDR))
+			return -EFAULT;
+
 		do {
 			len = min_t(u64, remaining,
 				    round_down(UINT_MAX, 1U << sbi->blkszbits));
-			ret = erofs_io_xcopy(bmgr->vf, pos, vf, len, noseek);
+			ret = erofs_io_xcopy(bmgr->vf, (off_t)pos, vf, len, noseek);
 			if (ret)
 				return ret;
 			pos += len;
-- 
2.43.5


