Return-Path: <linux-erofs+bounces-2333-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPgZLgitlWl1TgIAu9opvQ
	(envelope-from <linux-erofs+bounces-2333-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Feb 2026 13:14:00 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36528156433
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Feb 2026 13:13:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fGFmN056Fz2xlq;
	Wed, 18 Feb 2026 23:13:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771416835;
	cv=none; b=dipEgjyy7uv9XLzKg55lakAUYLrNblSutN5ydH13Z/HIJ3Hlu+cf0CtpWibjlj6dyYybsLX/IyavVcCDfww3kZzYiHEZEfP4IJGUGzo79zvUoZL4K2h1vvACkrJ9QNhgHR6T1iPtohnmJYLNKBZS4GxNKA7GLD4Zvqys+SL+HmC7/6Fl6Fy1qP9+IDOwRMj9wcPjz2Y9odwV3DTca/bbrfs5OjDW0ge58AoBUaOSYlN6VsLSgwcw1qSmr58MyIiofZ9kJrNLlARwxnWogcBZ7arlhDCpdJbW6rS/TL9NzX936vsOjkE7qvtpVmZ5q1DpggDo7B10wjvmZZ7pd1IWpw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771416835; c=relaxed/relaxed;
	bh=IwndmcRaO/FGUSe6ZKUnn+9nkg6OLFaotqdh8XFufow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h30m/bZD6LJMrNcWzs+xntKkG7Bxf3pZxH16Ag3hE4TO/2BLAPdW3bJhbWFnhV4W1RsRtKtIT1eBmzjY9ttxlbMmqg1ChwRnVJySnjpTZ04n3EXYx6nf9Tow/t+qpWOaO+Bb2sd3bZ64aiDwt6ImfsTdDh24Z3+sPZvCEanxXX2j13gBozAWM8/LvB9XRHnHYTSBhwSiCB/EzEV33TbRnab1rdURjtrm59swkA+SLqYtCZTspaAhZcnJQJhRs9zLeCGbfTRtVitYCueZyb0s11eZ6o343Nbo3jSZxhdWacfJKf3F9Jta6rzGk0S/PrRb3dfbZc3kuwUOJE34Mef2xQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GnX2ylOB; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=GnX2ylOB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fGFmK0WjGz2x99
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Feb 2026 23:13:51 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1771416825; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=IwndmcRaO/FGUSe6ZKUnn+9nkg6OLFaotqdh8XFufow=;
	b=GnX2ylOB/BXUrn+q2BVriwHxu10wjriW7dBzHcR+dgt1hD6AlL6puirzgVO9/bv4Rf/gKHUSB61LOSMppMv1EfDH6raitj8mhTOpckH5xxPBTlkyy+/9YTCDKJNUeUKm+ODQib8szlFraOWv5m4YjryT/Y5k3ie80bVQbzDZf6I=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WzSY5V9_1771416820 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Feb 2026 20:13:44 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: oliver.yang@linux.alibaba.com,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: mkfs: fix `-Efragments` performance regression
Date: Wed, 18 Feb 2026 20:13:39 +0800
Message-ID: <20260218121339.273715-1-hsiangkao@linux.alibaba.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.70 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2333-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 36528156433
X-Rspamd-Action: no action

Fixes: c75cfaf6956d ("erofs-utils: mkfs: Turn off deduplication under chunk mode with '-E^dedupe'")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/compress.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/compress.c b/lib/compress.c
index 995bc602b145..4a0d890ae87d 100644
--- a/lib/compress.c
+++ b/lib/compress.c
@@ -634,7 +634,7 @@ retry_aligned:
 			may_packing = false;
 			e->length = min_t(u32, e->length, ctx->pclustersize);
 nocompression:
-			if (params->dedupe != EROFS_DEDUPE_FORCE_OFF)
+			if (params->dedupe == EROFS_DEDUPE_FORCE_ON)
 				ret = write_uncompressed_block(ctx, len, dst);
 			else
 				ret = write_uncompressed_extents(ctx, len,
@@ -1382,7 +1382,7 @@ int erofs_commit_compressed_file(struct z_erofs_compress_ictx *ictx,
 
 	if (ptotal)
 		(void)erofs_bh_balloon(bh, ptotal);
-	else if (!params->fragments && params->dedupe == EROFS_DEDUPE_FORCE_OFF)
+	else if (!params->fragments && params->dedupe != EROFS_DEDUPE_FORCE_ON)
 		DBG_BUGON(!inode->idata_size);
 
 	erofs_info("compressed %s (%llu bytes) into %llu bytes",
@@ -1887,7 +1887,7 @@ void *erofs_prepare_compressed_file(struct erofs_importer *im,
 			params->max_compressed_extent_size;
 		ictx->data_unaligned = false;
 	}
-	if (params->fragments && params->dedupe == EROFS_DEDUPE_FORCE_OFF &&
+	if (params->fragments && params->dedupe != EROFS_DEDUPE_FORCE_ON &&
 	    !ictx->data_unaligned)
 		inode->z_advise |= Z_EROFS_ADVISE_INTERLACED_PCLUSTER;
 
-- 
2.43.5


