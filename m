Return-Path: <linux-erofs+bounces-492-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 44683AE81CF
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Jun 2025 13:45:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bS0PH6Jmwz307K;
	Wed, 25 Jun 2025 21:45:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750851923;
	cv=none; b=Ggrt1oW0LjvAL/GBStipwP0dAYhgHlSVhglnY4O3XUjV5Wa9dv0znJbA8skgEAcvQu+TX8K9zsCu96getQYPFqzV5F9HT1F2ZAgLrC2IwVOkEarr+TwGha2tm3ArRgxsSINN0Pu9X5nCMDbR0mhqSF0XRA4tnO4Q8qrHLkYF2XOOl/nwc80wJrIpPM9xKHdBcKCBoMfhL0ObKUk3GuecB4OMzZp/S9jviBOzRwQXj9INWrODcaTljly1bhwbf3DpnxLyKF9nJAR6yaxLY4u8lBkiRRbMsNincgEeobDdTiqO82WPx36M4uueMlyRUM7TnEiQPtnHruf0Xw+ROpFtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750851923; c=relaxed/relaxed;
	bh=8fHddFzOdlUvnZn2LML8d9njcV7H81ywUTBk6/7WSuk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kcm9Kc8f5zy7zLz7Jk9xT/AGrQH+9/e07viyy2qS326jcyz7f6GC0vWznwrZ18+F0CzGqgRmB7neuncBgwiAb9Ra0xr/O1kJ1mZptb4EMz/LGekv25GOT5mqN67n1YV9F0Wan6atOcvATcD2xOAtvZpJAzqhaCVUgOfK/e8yMTKK+aZwMbb5ryZuzYFqgwfu/ANzSt4v8McD7QfQCq6RiKfVGuks2GxCQbzL+0fh5ijRfrq0EcGIPQ3OEtFgn5szB+tWD8KSvurN8M/b3PunF0yp0Ud0i6RSB80IkuT6zvLIoQDgKv+k3fhngvvHkuaPMcZrB7ClA6377k819VKIvA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Mb1gXlRO; dkim-atps=neutral; spf=pass (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Mb1gXlRO;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.101; helo=out30-101.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bS0PG1dPxz2xHZ
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Jun 2025 21:45:21 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1750851917; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8fHddFzOdlUvnZn2LML8d9njcV7H81ywUTBk6/7WSuk=;
	b=Mb1gXlRO8xbEjHKkO4cqRXLSTGyLQjQ6MZbio0aNtOcHHTNFQ15Nu1FCEshCWVD9WsqCZ5efHbDCOrYYEOyWBgzbPmwpGYkqmXvOnBI8f9DkLTp9e8qq8ZICFCdiPZcatahdcj2S2mW7CFxer09lcuvJFKJRv5TSoqvuKDKx1Cc=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WexvaRN_1750851910 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Jun 2025 19:45:15 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH] erofs-utils: tar: handle negative GNU mtime properly
Date: Wed, 25 Jun 2025 19:45:09 +0800
Message-ID: <20250625114509.2205795-1-hsiangkao@linux.alibaba.com>
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

EROFS natively supports pre-1970 timestamps for file data archiving,
and this was already handled when building from directories.

Fixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/tar.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/tar.c b/lib/tar.c
index 941fad2..72c12ed 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -283,7 +283,7 @@ static long long tarerofs_otoi(const char *ptr, int len)
 	inp[len] = '\0';
 
 	errno = 0;
-	val = strtol(inp, &endp, 8);
+	val = strtoll(inp, &endp, 8);
 	if ((*endp == '\0' && endp == inp) |
 	    (*endp != '\0' && *endp != ' '))
 		errno = EINVAL;
@@ -292,16 +292,17 @@ static long long tarerofs_otoi(const char *ptr, int len)
 
 static long long tarerofs_parsenum(const char *ptr, int len)
 {
+	errno = 0;
 	/*
 	 * For fields containing numbers or timestamps that are out of range
 	 * for the basic format, the GNU format uses a base-256 representation
 	 * instead of an ASCII octal number.
 	 */
-	if (*(char *)ptr == '\200') {
+	if (*(char *)ptr == '\200' || *(char *)ptr == '\377') {
 		long long res = 0;
 
 		while (--len)
-			res = (res << 8) + (u8)*(++ptr);
+			res = (res << 8) | (u8)*(++ptr);
 		return res;
 	}
 	return tarerofs_otoi(ptr, len);
-- 
2.43.5


