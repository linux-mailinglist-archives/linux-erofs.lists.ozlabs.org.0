Return-Path: <linux-erofs+bounces-2299-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLHLH+x4i2lcUgAAu9opvQ
	(envelope-from <linux-erofs+bounces-2299-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Feb 2026 19:29:00 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9530E11E526
	for <lists+linux-erofs@lfdr.de>; Tue, 10 Feb 2026 19:28:59 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f9VSn0GBWz2xRq;
	Wed, 11 Feb 2026 05:28:57 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770748136;
	cv=none; b=ejM38zTysyX40eTV8gdy1W1yggj9WcjNM0VHy1eqMKjFN/wCHQxhJ2qQmCgC6QC4I+AOmsfijATctHWCha2Te6i3ENVnFdYJVS7KVdcajFbZpFuUzJTvq7pKq9j8MP/I+fxJgJ6DKO18guZ5+0gz9gPcI9Lar9q3woyLDo4seiFrtA4fFI5erOSONi6ZvTb08Pan4pcXHrDx9/bd1GzxYtYsdAeXWaZCcxAQw8wlt+lHcQkhUDYOIusOR4RAqFk4h74qhMwih8O24rMMCi7S3u8SetmrmFOa3xEWBAEOBEFLQQnXrQINZEHlYQmrOV7bHEaC2KUMaFqryFMFXguiYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770748136; c=relaxed/relaxed;
	bh=MbKRMTXK/WFGV+Sw+lCGD3rVt5jJsFHbgFlcOxAWjTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z0N1fRifXveowQtGs248CUStR3ycF8gjf9MwpzE5W8ZVejyVVULzrTOO3pF6sf5Qe4oUWaAa3pAEO2FOOgpYYKZgYgGmq6DkI9jGJEMTD7hIRvqmP0Y61oSKiC2faFTgfKcR82LQBSIHLlFmEJWZBmW8xSQVdgGQ9hC7IKN6UOrnmg+yR5rzliAi5WXFwRML8s5Sp45Z2OoxKRJV6QKMSbB30/jTkn6De/6P6M3PDgLZaA8uD++Azrph9yJg4mWEu2mjgt4/u+6NYae5HX7I6sKxNhKXxQRvz6F9Y8p+RYnoUFrhiIOWzsHhKHvxRPPGn98Qi2emHlCC1/Iy7O63XA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=j1cEIRb/; dkim-atps=neutral; spf=pass (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=j1cEIRb/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f9VSk4Lx5z2xQ1
	for <linux-erofs@lists.ozlabs.org>; Wed, 11 Feb 2026 05:28:52 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1770748127; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MbKRMTXK/WFGV+Sw+lCGD3rVt5jJsFHbgFlcOxAWjTQ=;
	b=j1cEIRb/rUM3m4dO4Kj5np3F38VT4QBI63Fv7k+g0XrCKyZOMg5lBkQOCi5Q4K18WmtdiiRhDSxKaoAVCV2417v7r32O3famHQ9Mf2BLFhwW7kzo5k2tz3SyAtYUft3pj+GVcsTRVnQ+GIqo5y/1DQ8KDLMBAjuyeedFT1cw9nI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wz-5er5_1770748121 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 11 Feb 2026 02:28:45 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	Benjamin Drung <bdrung@posteo.de>
Subject: [PATCH] erofs-utils: manpage: document missing --quiet option for mkfs.erofs
Date: Wed, 11 Feb 2026 02:28:40 +0800
Message-ID: <20260210182840.2108213-1-hsiangkao@linux.alibaba.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2299-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsiangkao@linux.alibaba.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,posteo.de:email,alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim]
X-Rspamd-Queue-Id: 9530E11E526
X-Rspamd-Action: no action

Reported-by: Benjamin Drung <bdrung@posteo.de>
Closes: https://github.com/erofs/erofs-utils/issues/36
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 man/mkfs.erofs.1 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/man/mkfs.erofs.1 b/man/mkfs.erofs.1
index cc5a3109ac7f..4316214ff1e2 100644
--- a/man/mkfs.erofs.1
+++ b/man/mkfs.erofs.1
@@ -240,6 +240,9 @@ Use extended inodes instead of compact inodes if the file modification time
 would overflow compact inodes. This is the default. Overrides
 .BR --ignore-mtime .
 .TP
+.B "\-\-quiet"
+Quiet execution (do not write anything to standard output.)
+.TP
 .BI "\-\-sort=" MODE
 Inode data sorting order for tarballs as input.
 
-- 
2.43.5


