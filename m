Return-Path: <linux-erofs+bounces-3787-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kwqjMYgvQ2rZTwoAu9opvQ
	(envelope-from <linux-erofs+bounces-3787-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jun 2026 04:52:56 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA466DFE7F
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jun 2026 04:52:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=vBi+Pswy;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3787-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3787-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gq73r46kkz2xHK;
	Tue, 30 Jun 2026 12:52:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782787960;
	cv=none; b=cOdMnKiu484n7c+UzgA3pbcUfhIt+0LnV0ZzQO8DrmLeaknNPLqHrtwuxG6Fwkhvnl19B3kW87N/G42XONyC3ldgM/EgQttQzzhabGu1PtlrFcu4lzVseOP0z57il1uvXEEMePI94fadEPqq3pDs1VSGg+d+tyb82DgemzgYU15ECEE5t7zVkdndl5KM4MMt3TDLX0Ve0xsafdowrgiCfB7dcawmsGRuhdCJ2iIXOV3c+MmpbfG3kaVfytXTAbmxHfKK30C7B6B7a9fUB8qB2cBWnLfrqFQUh+vuGf6OJTRaQeE49kppFpD/KP+b/DgRmICNLuHGtv9Uz7zU6H+oQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782787960; c=relaxed/relaxed;
	bh=OGVZlrDg6gXKcEAbbEvD1WBHleNRRMtLiM+LXawwryI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8L3hoGQGljA8ZyVKwi0w9tjlRVT4LKgtEibKJfY+e/2azjtbpbf5gTIxOx2t0tz0MUF+EyzlPiNHAZz2FKpP/dBo9gW1Yc3zv9AqmWNnYxFS2ig/dY0PwJCTDYcVssl1LaOwEbtsfIhnvJI5/pg7ZINW4Ou6yJPaehX4VXJOs1l+9agVbwTM/rK/RXYEUz4eJILvg5uEUfJXEkfHrRwbMrB1mQmTpQUTTIFUfQhwYvsA39K+cpsiDXUeS/1T1S4yrxxvZUGGfWPQeWIK/yoEVS6pN0bxpAkSBpNBn37bTkY3Zd5H+fvjdV4DOatbsRPXHRf1qNwbUhHUJn/iH8hlw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vBi+Pswy; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gq73q5VC4z2yZ6
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jun 2026 12:52:39 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782787956; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=OGVZlrDg6gXKcEAbbEvD1WBHleNRRMtLiM+LXawwryI=;
	b=vBi+PswyhpRDyEyGt9u/qqiEmAXEQZiJIc98sYLDMdAICKXUwN1pl3KvwEJEkjX283qXgoPSWo7r+Ng7maFKDdjNcPuznG2UzvEglOuy/ZDrm6xz1jLHQ6EsAf/BaE2nZlYjdsTI2V6hRdoS2jvc0vImvXdjhfK/IpL30ndeGUQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X5zS2q2_1782787952;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5zS2q2_1782787952 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Jun 2026 10:52:33 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 5/7] erofs-utils: lib: fix `STRING_NULL` in nbd.c
Date: Tue, 30 Jun 2026 10:52:22 +0800
Message-ID: <20260630025224.3955763-5-hsiangkao@linux.alibaba.com>
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
	TAGGED_FROM(0.00)[bounces-3787-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: 2BA466DFE7F

Coverity-id: 647257
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/backends/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/backends/nbd.c b/lib/backends/nbd.c
index c488053d99d3..db0df44990b6 100644
--- a/lib/backends/nbd.c
+++ b/lib/backends/nbd.c
@@ -82,6 +82,7 @@ long erofs_nbd_in_service(int nbdnum)
 		return err;
 	}
 	close(fd);
+	s[sizeof(s) - 1] = '\0';
 	return strtol(s, NULL, 10);
 }
 
-- 
2.43.5


