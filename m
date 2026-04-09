Return-Path: <linux-erofs+bounces-3252-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFD0KN/n12n8UQgAu9opvQ
	(envelope-from <linux-erofs+bounces-3252-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 19:54:39 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CB18F3CE598
	for <lists+linux-erofs@lfdr.de>; Thu, 09 Apr 2026 19:54:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fs6yL6wNzz2yT0;
	Fri, 10 Apr 2026 03:54:34 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=103.117.158.51 arc.chain=zohomail.in
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775757274;
	cv=pass; b=H1xVD+NWKDyXLCklBH5Tpuhz9ERzoZ/WfFiA3ypx4DzpTCqvyz6T/vrZ6gyQCKzJun/N0KAFcblym4FlJIQhXlWkIfWKV8UjSXkCU7t7Y8oi1pTqBIEaMwL0PA554IWnhf7x+kd+0kIGv29Nx+6QslO85K1itQthF34RCe6H3vvKPq+G+3HAG/o4KHgSVgzxGJ9b5xH4t/fen5+fSuDwCWX03b4ck51nfDbaznO7CrpmzmmGJuFGjhW+kJxfg78EksaQ6kZi1U08vXmRdsUio5B/7Bk1I5CxeTEU2UdPGHue/1Wk9wzYNBL4REDDYnEPM9XpoP2QIUlyDfslX8Agkg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775757274; c=relaxed/relaxed;
	bh=LvTtZdG1+L1cPgatGYPM3emEd0Pb5BtMw4DXDdoqypY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DqsqctKMMQaywltMCXvomNeoz6gSlLT+C+RW/6s59fnXePbwcsWS8tsqWw/O9y2LUaubpDpwJDzl9k660bjgpMeamKJuwBXpON9LRwVaoJMUqNaMGdTJNL1ryBn4KXcQPua8JprzSXsPLZ+p4jGDH+f09DIokIa+KgtHur8cVBx1NsgD3o0Wb9hfsLkmAFLo11bzDD2LBZtddDNC063lV1lMEQ5iIzjGc3CuC5UQj8VtylRioHIquG+iYxmdXeGXL0GZTffKx5opNBIBDqivJOFZs70/VSw7VdhJxraUYGksTLMkyWJZ/R2sYgGyGzyiDrEM9KSdoQ/kDprLSGIwvw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in; dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=aaeNknpW; dkim-atps=neutral; spf=pass (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org) smtp.mailfrom=vnsh.in
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=aaeNknpW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vnsh.in (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fs6yK3VJKz2xpn
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Apr 2026 03:54:33 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1775757268; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=CccxS2SeLnarVt3yw8MIzRs1Q1Z6Xiprj07D5cFMq2zTmPEn3+DdLYKx8b2XR4nEJGs/s515Ow6BT6ZK3OXLGzU5Vk10sm/rUUolLSgbLJs6LyWnPjymE/bV6PnmQ4OUosXZrHkcSAEJKicpPlz0Q78uPNUWBedZ6jJyaG5HvNY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1775757268; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=LvTtZdG1+L1cPgatGYPM3emEd0Pb5BtMw4DXDdoqypY=; 
	b=JbKJwkmCLOrMU43mSX/joLrvCvGiOimozT3km6AdjFPeRSXnRo4BSqZ0ITLNg0UWOVK2myfzpWO9HpJm65kqF4NtZEZcgqB0QVP8tibk0LPKEP4P0/xxgLL0ECgzM88FoOSv35pfoheht9mSGVGUZtztCL6USX5vvljwgMnP4nk=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=vnsh.in;
	spf=pass  smtp.mailfrom=ch@vnsh.in;
	dmarc=pass header.from=<ch@vnsh.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1775757268;
	s=zoho; d=vnsh.in; i=ch@vnsh.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=LvTtZdG1+L1cPgatGYPM3emEd0Pb5BtMw4DXDdoqypY=;
	b=aaeNknpWyfkkIeBkwR+FdeR0SV7y0rIEgTcUbiWwRDdy9a8V/FqagdGEdrsrCNPY
	iw6Ogc9n9IsDouGRkkvO39kRvB2OGBcZw49scr2MU0vkgs17N4X/YZM5v12GwxvEUrx
	GVnmVdXWcNJXGQmFwYnktEF3xtgZSEIuK0HP93R4=
Received: by mx.zoho.in with SMTPS id 1775757266548510.31889306885944;
	Thu, 9 Apr 2026 23:24:26 +0530 (IST)
From: Vansh Choudhary <ch@vnsh.in>
To: linux-erofs@lists.ozlabs.org
Cc: Vansh Choudhary <ch@vnsh.in>
Subject: [PATCH] erofs-utils: lib: handle unexpected EOF in erofs_io_xcopy()
Date: Thu,  9 Apr 2026 17:54:25 +0000
Message-ID: <20260409175425.96104-1-ch@vnsh.in>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[vnsh.in:s=zoho];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-3252-lists,linux-erofs=lfdr.de];
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
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vnsh.in:dkim,vnsh.in:email,vnsh.in:mid]
X-Rspamd-Queue-Id: CB18F3CE598
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Treat a zero-length read from erofs_io_read() as an I/O failure when
erofs_io_xcopy() still has data left to copy.

Without that, the copy loop makes no forward progress after an early
EOF and can spin indefinitely.

Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
 lib/io.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/io.c b/lib/io.c
index 0c5eb2c..80b7639 100644
--- a/lib/io.c
+++ b/lib/io.c
@@ -667,12 +667,12 @@ int erofs_io_xcopy(struct erofs_vfile *vout, off_t pos,
 		ret = erofs_io_read(vin, buf, ret);
 		if (ret < 0)
 			return ret;
-		if (ret > 0) {
-			ret = erofs_io_pwrite(vout, buf, pos, ret);
-			if (ret < 0)
-				return ret;
-			pos += ret;
-		}
+		if (!ret)
+			return -EIO;
+		ret = erofs_io_pwrite(vout, buf, pos, ret);
+		if (ret < 0)
+			return ret;
+		pos += ret;
 		len -= ret;
 	} while (len);
 	return 0;
-- 
2.43.0


