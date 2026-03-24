Return-Path: <linux-erofs+bounces-2974-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLybA9W4wmlilAQAu9opvQ
	(envelope-from <linux-erofs+bounces-2974-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Mar 2026 17:16:21 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A41B318D1C
	for <lists+linux-erofs@lfdr.de>; Tue, 24 Mar 2026 17:16:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgFXK2yqdz2ynP;
	Wed, 25 Mar 2026 03:16:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=103.117.158.51 arc.chain=zohomail.in
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774368977;
	cv=pass; b=aQjVWAgEOBAcj/j6djqOLdjMZqVvQXnQ74RxosRTWf9a1oQfdSjljqozu4Nuh7r9jbAfth2wDGIH7ZIHSLvCsCLGLK30u9gz6mDwFlNPnhAUOBGrBYxZKwD+UmBo9zOXJNsSTSIh8mQ7TdNagU3SSnLlp/jjY+BV9+e7+jrP5J0qiTwlIXm34cJ251AJZvUqkIYrMpwBviDrXOXzAZ0xS7vZi6GkfPhxaie2mIJ5WVR7AiOr7ewsvfhdhLHejLVVhGCXq8QtmWXemhE1KVBtUWxn6hpJESCw9MP/zsUlgE6AfpENH6h4lKG5w57C8ZFgcISTTWvO+qniUZgKa5/Ykw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774368977; c=relaxed/relaxed;
	bh=+WI++kOTqi7mz8D8lTRYTMhI62tW/HNeXU3Z/361cpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eM9LxnYfHvtvV5/VQHZxFR0l1GOgPxkMhPiduFAs2Z4jCysl2YDiAFnoxQHmxrIx3NdP07FgACY25N67IBzyeZgiLF4L/s0OLjYPZR6sLpChe9O6nKdkJxo/fX/rTavY/Oagw45rkmNosWnGrkufYCuiQOzSsF1yuFJR3dduqKc10VU/ipF+eTcyJ0ASBdaS23ujtaFz/p2mis8shoA9qRmwxdiafsN4T1McM2VdAJfZQNdPWg1T9veRZu76srfd/Ygcr2aPKpB20sO22jdUleB31iheBl/SaM9T5UTZFkq8QwdSUquxR7a0t6MFIb2ZDj9T2weQJfMExl7oKLAnKw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in; dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=WyOycYPI; dkim-atps=neutral; spf=pass (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org) smtp.mailfrom=vnsh.in
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=WyOycYPI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vnsh.in (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgFXH66wHz2ygf
	for <linux-erofs@lists.ozlabs.org>; Wed, 25 Mar 2026 03:16:15 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774368969; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=IsLKoe4i8YWxXTBrN5QesO6qlSreLWmGOWGy7L4GJyvQompv/PDInLjStZ7eSHVOtvEplJfj72RM+lslk4LQDlDRa90boSq7x7TYvYgx0ECBjPqydi0LVtpwJc4IXbP3I4gQgAAmuQaiSipjUqUb56aJ7CvV3Y54gNWWaybyZXo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1774368969; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=+WI++kOTqi7mz8D8lTRYTMhI62tW/HNeXU3Z/361cpg=; 
	b=IzZOHsdZR+Om5LLJjt35POk2iXimGguAIJdCzsgXExaPiDWfVR/Uj430kpHTHCC09NNuQuEn9QM/9gFdUed481ELJE6RhBWzv5rk2jwH6ilgLNm1KWdQAvoaPyWbAzNxmflo8RK8e+JqYQE2X2EZEakjFJDk9Ad/3vedYrkgKZI=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=vnsh.in;
	spf=pass  smtp.mailfrom=ch@vnsh.in;
	dmarc=pass header.from=<ch@vnsh.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774368969;
	s=zoho; d=vnsh.in; i=ch@vnsh.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=+WI++kOTqi7mz8D8lTRYTMhI62tW/HNeXU3Z/361cpg=;
	b=WyOycYPI6UNb+7yg10tgZa+1DjNu4tWnFPNJ+6Hr87PJjqoRwZhyAGBqICAvRyWj
	wCybBt3nvB2jFjqQKGQN1d2nT44vTUPV1JTzGElmX09T9cWnTkqbhRwzx+gls09dYHV
	vv7ffpjCIk2Px6pZY2NiLepSxe/SNZUGT4MDt7lw=
Received: by mx.zoho.in with SMTPS id 1774368968793779.5420310647254;
	Tue, 24 Mar 2026 21:46:08 +0530 (IST)
From: Vansh Choudhary <ch@vnsh.in>
To: linux-erofs@lists.ozlabs.org
Cc: Vansh Choudhary <ch@vnsh.in>
Subject: [PATCH] erofs-utils: tar: bound-check PAX header parsing
Date: Tue, 24 Mar 2026 16:16:08 +0000
Message-ID: <20260324161608.36697-1-ch@vnsh.in>
X-Mailer: git-send-email 2.43.0
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
X-ZohoMailClient: External
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[vnsh.in:s=zoho];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-2974-lists,linux-erofs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[vnsh.in];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ch@vnsh.in,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[vnsh.in:+];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	TAGGED_RCPT(0.00)[linux-erofs];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vnsh.in:dkim,vnsh.in:email,vnsh.in:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 0A41B318D1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

NUL-terminate PAX header buffers before parsing them with sscanf().

Also reject PAX header lengths larger than UINT_MAX.

Fixes: 95d315fd7958 ("erofs-utils: introduce tarerofs")
Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
 lib/tar.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/lib/tar.c b/lib/tar.c
index cb77f39..70bf091 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -471,7 +471,9 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
 	char *buf, *p;
 	int ret;
 
-	buf = malloc(size);
+	if (size == UINT_MAX)
+		return -EIO;
+	buf = malloc((size_t)size + 1);
 	if (!buf)
 		return -ENOMEM;
 	p = buf;
@@ -479,6 +481,7 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
 	ret = erofs_iostream_bread(ios, buf, size);
 	if (ret != size)
 		goto out;
+	buf[size] = '\0';
 
 	while (p < buf + size) {
 		char *kv, *key, *value;
@@ -870,6 +873,8 @@ out_eot:
 		st.st_mode = S_IFIFO;
 		break;
 	case 'g':
+		if ((u64)st.st_size > UINT_MAX)
+			goto invalid_tar;
 		ret = tarerofs_parse_pax_header(&tar->ios, &tar->global,
 						st.st_size);
 		if (ret)
@@ -884,6 +889,8 @@ out_eot:
 		}
 		goto restart;
 	case 'x':
+		if ((u64)st.st_size > UINT_MAX)
+			goto invalid_tar;
 		ret = tarerofs_parse_pax_header(&tar->ios, &eh, st.st_size);
 		if (ret)
 			goto out;
-- 
2.43.0


