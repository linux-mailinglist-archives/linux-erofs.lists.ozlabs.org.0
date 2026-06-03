Return-Path: <linux-erofs+bounces-3509-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id d2HrICqMH2o0nAAAu9opvQ
	(envelope-from <linux-erofs+bounces-3509-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 03 Jun 2026 04:06:34 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C3F63395C
	for <lists+linux-erofs@lfdr.de>; Wed, 03 Jun 2026 04:06:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=cDhD8zKl;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3509-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3509-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVWK12zvYz2xg3;
	Wed, 03 Jun 2026 12:06:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780452389;
	cv=none; b=N0C5P6iGqeLTM2p3WYsuidLazNsskYCeQNrQWC+p7YxgT626cCVHKxuueZpsTtHtBxoPRnI5m3pDgEL1JpXE2m57XfZXkNjhidGsL7kCTQBfnpmGB4f9EqMiY+XZHThioHpFL6oLFM5ZTfdct5gTTGFZ63gw5lz8I+54lapLXCXhwy7Uwse8hKnO6BVQx9mtLVbl8jqPneQsW59gy7MjmUUKHY+FRISGCtZPQL9Rle0DSHnTzZ/f/LZxLJe/4VubIJRKpsXTiWQt3EekDD5tdxd2hPkrDDh8W5SZXmYu/+maVbVs3QiHajII30uYWFyJqLcDupFxQy6yuiafIJPNVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780452389; c=relaxed/relaxed;
	bh=wklCdgcCOUgpYZZkeky9ktyPzP2fKBHSAtH4gW7FTTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cGjmo9ahkcr1srzvBDIMWwQEQq+NixHljcBmoPtXsSi79Z/OZIHvJrkaRIu8mYU6Apg4p0z6xFNa3nS+6IpknMpiZarkJcl0Mr6ovEI0kbdTybHdeuDbCZBsii/S0wj9+QxCcdOjVCIGW0rhGWs0uCUwqMrZ6+rbjBtydRdzA0U5WY6T2Inh5Tff4vDxN8LD+1Kutc5KGMrRs7kGQSkSNsaQ7BJ/gkUesFBWKQ3sDBcmySrZpecBzTKYK1yLtyjdVPrBivuplpgd59NB8gc+V/J/6qYoywSGwYNuiurdQpLrWWyskYCVUM0d3nEZxb1p/IrLJXqS5CWGCQqUm/NFIA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cDhD8zKl; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVWJy67crz2xc2
	for <linux-erofs@lists.ozlabs.org>; Wed, 03 Jun 2026 12:06:24 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780452380; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wklCdgcCOUgpYZZkeky9ktyPzP2fKBHSAtH4gW7FTTQ=;
	b=cDhD8zKlYu986V4pskem0+dZKvPVOWKZO4DmLcl74K1Ud2yMvhf3BD4UN2/LvkUQWqTQ805m3+bhPpSPGFySRAjTPrT1qIT6oYU5SH05WflQPwrnS0FDgE5rCJM/wyAbSY7MRS1KjnS4KZWj158g/X1RojQx6a8EzMgTNWQrno4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X45rI3T_1780452374;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X45rI3T_1780452374 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 03 Jun 2026 10:06:18 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: s3: use CURLINFO_CONTENT_LENGTH_DOWNLOAD_T if possible
Date: Wed,  3 Jun 2026 10:06:13 +0800
Message-ID: <20260603020613.1974534-1-hsiangkao@linux.alibaba.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3509-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:from_mime,linux.alibaba.com:dkim,alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 88C3F63395C

To resolve the following warning:

remotes/s3.c: In function 's3erofs_get_object_size':
remotes/s3.c:1352:9: warning: 'CURLINFO_CONTENT_LENGTH_DOWNLOAD' is deprecated: since 7.55.0. Use CURLINFO_CONTENT_LENGTH_DOWNLOAD_T [-Wdeprecated-declarations]
 1352 |         ret = curl_easy_getinfo(curl, CURLINFO_CONTENT_LENGTH_DOWNLOAD,
      |         ^~~

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/remotes/s3.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/remotes/s3.c b/lib/remotes/s3.c
index 870e0971b6ee..245efe5c77d8 100644
--- a/lib/remotes/s3.c
+++ b/lib/remotes/s3.c
@@ -1325,7 +1325,11 @@ static int s3erofs_get_object_size(struct s3erofs_vfile *s3vf)
 	struct erofs_s3 *s3 = s3vf->s3;
 	CURL *curl = s3->easy_curl;
 	long http_code = 0;
+#if (LIBCURL_VERSION_NUM >= 0x073700)
+	curl_off_t content_length;
+#else
 	double content_length = 0;
+#endif
 	int ret;
 
 	ret = s3erofs_prepare_url(&req, s3->endpoint, s3vf->bucket,
@@ -1349,7 +1353,11 @@ static int s3erofs_get_object_size(struct s3erofs_vfile *s3vf)
 		return -EIO;
 	}
 
+#if (LIBCURL_VERSION_NUM >= 0x073700)
+	ret = curl_easy_getinfo(curl, CURLINFO_CONTENT_LENGTH_DOWNLOAD_T,
+#else
 	ret = curl_easy_getinfo(curl, CURLINFO_CONTENT_LENGTH_DOWNLOAD,
+#endif
 				&content_length);
 	if (ret != CURLE_OK)
 		return -EIO;
-- 
2.43.5


