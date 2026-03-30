Return-Path: <linux-erofs+bounces-3123-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDn5KYW8ymnh/gUAu9opvQ
	(envelope-from <linux-erofs+bounces-3123-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 20:10:13 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BEC35F985
	for <lists+linux-erofs@lfdr.de>; Mon, 30 Mar 2026 20:10:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkzmw1S1dz2yF1;
	Tue, 31 Mar 2026 05:10:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=103.117.158.51 arc.chain=zohomail.in
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774894208;
	cv=pass; b=fiG851zg1lL76idieKqLn6aPBfso6a+kwzWoN6zxSaLKmxi9Vma6q66+Vgm/TVJD1zqGtl0cRbhGYsZ1SRizLbH5Vw0QaYuKb+AFt+oUAqSOfRzDEbWtCLDUWLA3O5aLYbsBjsd5JAINVWA12WIBlOwePWsKFz7lvNEsRbjQ3bK7j/FUD8tCKGopzamNSyTMcWTT/rp2tQXAg84Iud0+2Z3ooz3axdWDSNVKIT+ZAHQo+uAym5zAe/1eiu8+mqlrWiRp/TQVYpkI0zsTeGUXBjXMFz/gQWZTzVMqH6YNJixCkqxUL5pVkkIod3AIBSIp++jV4PvxV6nV5HPGmmR8YA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774894208; c=relaxed/relaxed;
	bh=QcFmbTS5hSBBtvgOfz4WCcILyevh7tXqPGkJKjtcHsI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XPGpC2AsjWnttuaMXzmOTtWJlp7eMFWf6BuLMokefWetdsYO7QJyHPpXlNrCmNh4O2jxL8DXau+XP3FEY4wUiqHtuXKz2/DmR2k4iNqPTBjDpc1Nka6U50mkZFKoj9yIlCCyGQnqprbiHmBHzOwdgKGpLKsRVmH0qGvNgjMZZ5v4qW1UzvPEjeQQziH0ErygsPkuYZ4GFK1E11/RAdE4Gcdej89oyUsXm/js4huRTc0XNCO7h25lOP6UodYR0mPFU7xVRPsCYR0RWmUfXBD+pGVsbzu4pDFGhtXdPS1K/AiHa0uQS9FBz3+IguztG7fVOGKgkMl+uAeMPMm0NIT6Qw==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in; dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=WP4nZT97; dkim-atps=neutral; spf=pass (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org) smtp.mailfrom=vnsh.in
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=WP4nZT97;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vnsh.in (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkzmt5V6kz2y7r
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 05:10:06 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774894200; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=W+NL3yaTkluQSP7fQd1B5ib1VA1WxobDYgsGJUA1wG0JS7pPP0RqKUyaFLyascX0rfUOymlxISOcCp46KJ+jVRmG8ZYpKffxeeJwQQn+gbXxZONSw7slMqBDoRx8sU3OXGymEz5Nl5n87xFaGhBe5p5ZHkdtJyl9XDDJ39Tv88c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1774894200; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QcFmbTS5hSBBtvgOfz4WCcILyevh7tXqPGkJKjtcHsI=; 
	b=HqxKACeykZPw/F3yePY/rbeyoqaDzpHZaVy8Qf+2wUhFZqpGsS0TEHUdDptjB5sRV1BHpRpVKRNnPn+vzlX2YRqkK1kFO9mbH5pKbdICNNdfltcllS/GUoK99PjYjo0t3D8Xm889cb5vhUryGMLAsfviWUGyNr/vjfjpFYwZXvU=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=vnsh.in;
	spf=pass  smtp.mailfrom=ch@vnsh.in;
	dmarc=pass header.from=<ch@vnsh.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774894200;
	s=zoho; d=vnsh.in; i=ch@vnsh.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QcFmbTS5hSBBtvgOfz4WCcILyevh7tXqPGkJKjtcHsI=;
	b=WP4nZT97AJQvoUs8EjrFOZ49okg1EaNXBeSZRAvXAe3vjh2SNsCjLlgzWrHR35Ve
	EdCV2PTe5SQNsLJreR9vbxMd/UKQ05uXmkJVKbryPV4qBelGNDkIz5C9FeIS5UwJQu7
	in0b3xPlMTjeC+uvN4Npy8/xigZb3FmiVKY0EfwA=
Received: by mx.zoho.in with SMTPS id 1774894198800880.553198395987;
	Mon, 30 Mar 2026 23:39:58 +0530 (IST)
From: Vansh Choudhary <ch@vnsh.in>
To: linux-erofs@lists.ozlabs.org
Cc: Vansh Choudhary <ch@vnsh.in>
Subject: [PATCH] erofs-utils: tar: handle gzread errors
Date: Mon, 30 Mar 2026 18:09:58 +0000
Message-ID: <20260330180958.1372245-1-ch@vnsh.in>
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
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[vnsh.in:s=zoho];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[vnsh.in];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3123-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[ch@vnsh.in,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[vnsh.in:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 01BEC35F985
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Treat gzread() errors as I/O failures before updating the stream
buffer state.

Without that, a negative gzread() result could underflow ios->tail
and leave the reader in a corrupted state.

Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
 lib/tar.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/tar.c b/lib/tar.c
index 39e2321..871779a 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -174,6 +174,14 @@ int erofs_iostream_read(struct erofs_iostream *ios, void **buf, u64 bytes)
 #if defined(HAVE_ZLIB)
 			ret = gzread(ios->handler, ios->buffer + rabytes,
 				     ios->bufsize - rabytes);
+			if (ret < 0) {
+				int errnum;
+				const char *errstr;
+
+				errstr = gzerror(ios->handler, &errnum);
+				erofs_err("failed to gzread: %s", errstr);
+				return -EIO;
+			}
 			if (!ret) {
 				int errnum;
 				const char *errstr;
-- 
2.43.0


