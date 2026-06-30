Return-Path: <linux-erofs+bounces-3788-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZVmiMYgvQ2raTwoAu9opvQ
	(envelope-from <linux-erofs+bounces-3788-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jun 2026 04:52:56 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F846DFE81
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Jun 2026 04:52:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=uOMKZKmc;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3788-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3788-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gq73s1xqJz2yZ6;
	Tue, 30 Jun 2026 12:52:41 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1782787961;
	cv=none; b=W4ppKOOEl6EP3jcKd38/5m+lQKBNOsnhjBVuKVkcZ8tehHt9HyIS7wmVv4pV0Thg08a+okKBqzRFujaCnoUKAmec7mmdq+6ZzByLyBw8ud5ax2WLZt+HafS0loU/iIyUnXhp04V3BfBWJIiBWWULzyD4RJMH54fe8/x3gz0yw9qx+R5BmFa/Qkxor9WuYED9GxUaL94vlKcbzGcefJ7vvbSzNBAtml6YxoWz8+WNTkLQ1KqXzv1m7LmM8uQj1BXIriZ6GFfECXAOCLZSVNvUbaV9F3UKjnyB5+WeRFBpw0v/A8pJjrL25W8JP2QA5zgluZlfiaTvlPchE+Y6gLC0xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1782787961; c=relaxed/relaxed;
	bh=r2O/xV3m7KV4Mj0iYQPGTYCu4AC0PsfFbR/vkvbQwGk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDakNmkNWembasKuYvfvSf5mpYAI34kLSukco9fGGy3VHKfjmEa/k2eXEyOoZ2IaLbxwUTXAT/wM1rP1T9B2Q7onxEiqApnHXGLsoN1eBHp/GcAlYTKxORYc0uE+ijJQmU0EnsQ913TJ6FWv/mSD0c37sQgmDl/8JBRKtuulk7PGIB5vMGg9JLhR0CA5oa6/pjQLgeE6xbWN4tItnl5wRZXQR7PY0dgu8WfXQVnSxtgXxLVivp64VeSbUZ1N/Odl91AytfAVP4gqfhdRDlAk2aqsh78c6u5EzP9jupukEXM2odbdTEwDHz1ljGyyRLmMAuck2BLg1Tju2OvxpochjQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=uOMKZKmc; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gq73r2gvYz2ybR
	for <linux-erofs@lists.ozlabs.org>; Tue, 30 Jun 2026 12:52:39 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782787956; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=r2O/xV3m7KV4Mj0iYQPGTYCu4AC0PsfFbR/vkvbQwGk=;
	b=uOMKZKmcNsD10vy5Ggt1m3hkxTvUSacTlMAQUw0dbASGB41oFFRszJ1zkmyRHnXsjB0sxrs/dBsdL7LN12Rj23+yp/7DMbYnwvY+b/RVfIDcU9LMS73U23TtzLuLTZIDrM3lLts0d09ffmDB5J7wFYryvhp5hnuhKHLIIBXnAbU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0X5zS2qP_1782787953;
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0X5zS2qP_1782787953 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Jun 2026 10:52:34 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 6/7] erofs-utils: mount: fix `RESOURCE_LEAK`
Date: Tue, 30 Jun 2026 10:52:23 +0800
Message-ID: <20260630025224.3955763-6-hsiangkao@linux.alibaba.com>
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
	TAGGED_FROM(0.00)[bounces-3788-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:dkim,linux.alibaba.com:mid,linux.alibaba.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 37F846DFE81

Coverity-id: 647246
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 mount/main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mount/main.c b/mount/main.c
index ffe718a0a90f..ec27dcb53eb3 100644
--- a/mount/main.c
+++ b/mount/main.c
@@ -1698,8 +1698,11 @@ static int erofsmount_loopmount(const char *source, const char *mountpoint,
 		return -errno;
 
 	num = ioctl(fd, LOOP_CTL_GET_FREE);
-	if (num < 0)
-		return -errno;
+	if (num < 0) {
+		dfd = -errno;
+		close(fd);
+		return dfd;
+	}
 	close(fd);
 
 	snprintf(device, sizeof(device), "/dev/loop%d", num);
-- 
2.43.5


