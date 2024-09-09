Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077DD9713CC
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 11:34:13 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4X2M9G6x2dz2yNs
	for <lists+linux-erofs@lfdr.de>; Mon,  9 Sep 2024 19:34:10 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1725874448;
	cv=none; b=ohD1/594HUcBylENsmfKqrNKfTSN4BFKG6nkgK6NMIR7x6bTdsr/Bq9hFQs2kacI1w/HhI0BESPxXQ3ov9sfiuscVHsVdgMZDAw2Goc+qqKbTgLeRiZ0LRXZil6T+ozdVFHONDvXEC8V1JKNvrPw0Sg1spF7sHhXwc6rhtVnoOLoal7bth9E88nsCVPmM8Joc3mgdGi+8jyx/MXGmljUc0o2Wp2Mze0uDIxdPf1cci7KFAyEi9kEPfDfaJm2Sb23uL4beZyjIedLMzmfdATSWG9LPNjHdCk/BdHo+TEKuvWEYFoOGC0nZoG4kix5cZ0R1NYPkKAw/AFKBTDe14T1SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1725874448; c=relaxed/relaxed;
	bh=T4hUsv0yjv+WAPqRLUWhVKmtYrsB6pTAAB2+nzxSTEw=;
	h=DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=cDjo211D9mnUqnkCNW1IhlHHJi9J7mqhAK4IxSQf5Le13YIXvQ0rRiWUf4TeY1wFvSVZe9RgnLRrMQGHx+uBf1JucLpInzbJU4KwbIQXgBjw1xbrln5h6qydzqCwuFL6L1cug80DQsb9IZ7g4sRrjNul/0XE/MNlO5jitdhyYnnFboXhbjr4C9k2TnxxP1x6iLQKHQm1CmUpES7boKWkkYWKAwyRps11NbBBmtgYFiAzijiiCWnpfs6JXY3fXb5lLI/MRLePXvHMfL6jpUc2B+GLAfYDpRYSQ6h1A6Jg8i0xlx/M1fvbG+/xw+2aLIruGfZbV+GscvQecnezzCJ1zg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UVPE/fZC; dkim-atps=neutral; spf=pass (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=UVPE/fZC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4X2M9B73rYz2xXV
	for <linux-erofs@lists.ozlabs.org>; Mon,  9 Sep 2024 19:34:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725874440; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=T4hUsv0yjv+WAPqRLUWhVKmtYrsB6pTAAB2+nzxSTEw=;
	b=UVPE/fZC6ctgGkFi5s90uIIEEaIsr5OwwhuoT3s8/imoodfvpayuUw9Qc6XgO93E9UMRAvmRvT3sh4QlxgCcDpc7DDJ/CbA+DHDeM6nTddKh0GdoXQWXMLJQC7QBWW2dlW96r+toTIg4ofpI6YVQ8nsNx/a2K19O0YcFq6QAITo=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WEbT2FT_1725874435)
          by smtp.aliyun-inc.com;
          Mon, 09 Sep 2024 17:33:59 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Subject: [PATCH] erofs-utils: lib: tar: allow pax headers with empty names
Date: Mon,  9 Sep 2024 17:33:54 +0800
Message-ID: <20240909093354.1712460-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, Colin Walters <walters@verbum.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Usually, `exthdr.name`s are set as "%d/PaxHeaders.%p/%f" [1].

However, since both `GNU tar` and `bsdtar` can process empty
`exthdr.name`s, let's allow them too.

[1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/pax.html
Reported-by: Colin Walters <walters@verbum.org>
Fixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")
Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 lib/tar.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/lib/tar.c b/lib/tar.c
index 7e89b92..6d35292 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -283,9 +283,9 @@ static long long tarerofs_otoi(const char *ptr, int len)
 	inp[len] = '\0';
 
 	errno = 0;
-	val = strtol(ptr, &endp, 8);
-	if ((!val && endp == inp) |
-	     (*endp && *endp != ' '))
+	val = strtol(inp, &endp, 8);
+	if ((*endp == '\0' && endp == inp) |
+	    (*endp != '\0' && *endp != ' '))
 		errno = EINVAL;
 	return val;
 }
@@ -663,18 +663,19 @@ restart:
 		goto out;
 	}
 	tar->offset += sizeof(*th);
-	if (*th->name == '\0') {
-		if (e) {	/* end of tar 2 empty blocks */
-			ret = 1;
-			goto out;
-		}
-		e = true;	/* empty jump to next block */
-		goto restart;
-	}
 
 	/* chksum field itself treated as ' ' */
 	csum = tarerofs_otoi(th->chksum, sizeof(th->chksum));
 	if (errno) {
+		if (*th->name == '\0') {
+out_eot:
+			if (e) {	/* end of tar 2 empty blocks */
+				ret = 1;
+				goto out;
+			}
+			e = true;	/* empty jump to next block */
+			goto restart;
+		}
 		erofs_err("invalid chksum @ %llu", tar_offset);
 		ret = -EBADMSG;
 		goto out;
@@ -692,6 +693,11 @@ restart:
 		ckksum += (int)((char*)th)[j];
 	}
 	if (!tar->ddtaridx_mode && csum != cksum && csum != ckksum) {
+		/* should not bail out here, just in case */
+		if (*th->name == '\0') {
+			DBG_BUGON(1);
+			goto out_eot;
+		}
 		erofs_err("chksum mismatch @ %llu", tar_offset);
 		ret = -EBADMSG;
 		goto out;
-- 
2.43.5

