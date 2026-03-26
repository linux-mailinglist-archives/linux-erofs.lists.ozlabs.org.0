Return-Path: <linux-erofs+bounces-3012-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EYuJmMLxWma5wQAu9opvQ
	(envelope-from <linux-erofs+bounces-3012-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 11:33:07 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B08343336BE
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 11:33:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhKqM6fL8z2yS4;
	Thu, 26 Mar 2026 21:33:03 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=103.117.158.51 arc.chain=zohomail.in
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774521183;
	cv=pass; b=lX8C/9ZVA7/8F4ImzQR7EkoK+s8sejYk/FcCDy8xxAbdzvil6kFON723Xe0ljx6k/HSBV7RjF7EUwk6p3ELqjp3iIFe5fS6wJgs1y1D67+b21cYQfoCsUKiY0wgICfu1xi5OAm3a9SzF6EOXTP9E6Sxn8HRlaxjvkcCTdkNxwDNFe0xCKoMa2UKHNZLG63baI77Ts8JiKCtuPH+1a3UzeaJatM2KNv4fMwKq5PwbXx1PT/P2xPZ93WB2uIWTtTBQgouXVo8tFK9BActPy9HpI3tR0ofBt2543NW0wTD5kfZcUSUZdJUXxVQwNQUeN3nunDkTh2/tT9Bcz6GCblaKCw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774521183; c=relaxed/relaxed;
	bh=tIxTga/wk3b2Njr0Rt9t20LBuhoOiFUzKzvVh4DP4iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GVRGnFXbmmbKxcRX0pqtelzMVLLcL76a8tlf7XRgdfJ29YgeIRFsIkVJsAijGt+JYZhYJlfMYTjHOOAvbaQyP0vtCUEUB6IEuOQznkYR/nF8Vntz0XYZDZR0cpb4pwTXygvlhXsmECpBTpG5WCe36uESlIrd1DLiJL8ZIikteOC4+xubCmtMgNwilKMFY68QoK+RantT2mikn/n0s5lFAb3DtylEntrR9sh1qleYPex7MyEWNzbgHAsg4Je2/oyCJCX8rBa6JNE1ucmNiLZrcHh6qg7UjfmYONzL2C1s9PMPg03QE8b9yeLhHsuTvcdy+euTgDhTb4Uv7XPuNMNkRg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in; dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=DGLRnNhf; dkim-atps=neutral; spf=pass (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org) smtp.mailfrom=vnsh.in
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=DGLRnNhf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vnsh.in (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhKqL4KcVz2xlM
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 21:33:02 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774521175; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=NUbFoAw5D74wzGMXX5Degct1ICWNJQfjGhTZYfJAzeLbZaJOSa/D8499GqqI/7UVcxLa2YC2sSYUn/uNAretCOWiwTGKbhP9xT0TemddUnqd5/1NWf26eaO3Wb+TGZvsbMAnc0w4pDNS6UzgHPoEZVuGtrYe2/rnEkoA/36yliU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1774521175; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=tIxTga/wk3b2Njr0Rt9t20LBuhoOiFUzKzvVh4DP4iQ=; 
	b=a38eNlsHho8PQ29FczDARvPSOqMDx3OjQDtF/X+nxYLC/ToDFquCGZ2+RhibiDYXOaYRkvCXhIkai47gfiK0iH3BibNRJBDah7iHQsYgpNh7U0Z6U7vM3K3kzA5gV+bOApSPOawo3bn/8SwvPXt6Yw4R/s6BaaUkFcOct4TZ9J8=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=vnsh.in;
	spf=pass  smtp.mailfrom=ch@vnsh.in;
	dmarc=pass header.from=<ch@vnsh.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774521175;
	s=zoho; d=vnsh.in; i=ch@vnsh.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=tIxTga/wk3b2Njr0Rt9t20LBuhoOiFUzKzvVh4DP4iQ=;
	b=DGLRnNhfZr5i1jqSLTxnrsDphLxdb4E94yKA20dmCkMALUAprA0fEDxgrPZQgQ93
	BEwYrf0MNS/hQxdCkV+X/T0fkfBczEWJamKURDMBupvcL37W4tq6XlI+I6tYm7dDE20
	+l4fm3DS0ijHBl2hIfy/0AdedK8IW3v2fs+qtQGg=
Received: by mx.zoho.in with SMTPS id 1774521174773628.6457214836197;
	Thu, 26 Mar 2026 16:02:54 +0530 (IST)
From: Vansh Choudhary <ch@vnsh.in>
To: linux-erofs@lists.ozlabs.org
Cc: Vansh Choudhary <ch@vnsh.in>
Subject: [PATCH] erofs-utils: tar: fix multi-chunk metadata reads
Date: Thu, 26 Mar 2026 10:32:54 +0000
Message-ID: <20260326103254.32152-1-ch@vnsh.in>
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
	TAGGED_FROM(0.00)[bounces-3012-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: B08343336BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Advance the destination buffer in erofs_iostream_bread() after each
erofs_iostream_read() call.

Without that, metadata reads that span multiple stream chunks keep
overwriting the start of the output buffer, which can corrupt PAX
headers, GNU long names, long links, and other buffered metadata.

Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
 lib/tar.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/tar.c b/lib/tar.c
index 70bf091..77754fd 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -250,6 +250,7 @@ int erofs_iostream_read(struct erofs_iostream *ios, void **buf, u64 bytes)
 int erofs_iostream_bread(struct erofs_iostream *ios, void *buf, u64 bytes)
 {
 	u64 rem = bytes;
+	u8 *dst = buf;
 	void *src;
 	int ret;
 
@@ -257,7 +258,8 @@ int erofs_iostream_bread(struct erofs_iostream *ios, void *buf, u64 bytes)
 		ret = erofs_iostream_read(ios, &src, rem);
 		if (ret < 0)
 			return ret;
-		memcpy(buf, src, ret);
+		memcpy(dst, src, ret);
+		dst += ret;
 		rem -= ret;
 	} while (rem && ret);
 
-- 
2.43.0


