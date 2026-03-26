Return-Path: <linux-erofs+bounces-3042-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCu7A3osxWnb7gQAu9opvQ
	(envelope-from <linux-erofs+bounces-3042-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 13:54:18 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A5C23358A8
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 13:54:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhNyF52P1z2yd7;
	Thu, 26 Mar 2026 23:54:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=103.117.158.51 arc.chain=zohomail.in
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774529653;
	cv=pass; b=ZB0d1jPaqEkkW7eVaV8yKVedEgwtp4fhM2PKmcWT8v2i9RgIP1Raw83002Dmsw+c+hS4/pr8XYAFQnG1dqAu4idt2LsHvl7h91eUOw1DcSdxmK0WUzlzXlw0UB3O6Piu8PUk1dZdH9aJra+CSvy4Fk8Xrm2RStE6ziyfydubaG6hILNy87KpT8ckctbFgzOixDX0C3/TSrHKhb9zFMNM0+RIMX/ja77omYvX8kRiVZh4pRdifWg7NpvHA+WRsDTB/7gcntpfZWv33FzNevAM8mrOY5evtwQPX9VktRMneK8RIOQIuWGocReDt6PhYqqfSC787IqLwU5/bGVslnJUyQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774529653; c=relaxed/relaxed;
	bh=R26Jz05ItG1ubmhs27gagP1HK7qzlrsqSQavHEFxFYU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FfTt47egLXsRxt+f9pRacfvV/viH3EsGrak4w88i0nVru+I/gv0sfidU/LXlXI5zYP86Ja/heCAYM0quezSzTljXhkcWExNaJSk1laPxqyeGTichl652Akp8j+ZwB/Pv7eClrHDy2iBXcxiJnPWTneq7RhtOi5Iufe9gtPEX1vEJBXpStZtEpYmK6726X7pUXicsoi1Jnh5NKaSMMaz5Syth8bGJEnpdsLMO7UMfUFl+c/KvHrOBktsa22GvuO/zHJmZlNqxEUldbxQLKZG/M1NLx/ua4cTI/iuZhDJo3SDmishe44gStixVaD3KCEsff4p5KLPenTLXLH3/6+Og8w==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in; dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=eqdklICL; dkim-atps=neutral; spf=pass (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org) smtp.mailfrom=vnsh.in
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=eqdklICL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vnsh.in (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhNyD2rQtz2yS4
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 23:54:12 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774529647; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=cC/CAMjIqK1MLQdNB/RkrRNluWBoRGatAacbgXnCXk3QJR8ttk0QfNSl6AV/jwS9cReDN4rTlSnvG8MphkLdeh1smL2KUGm8pNXrlsDst/lR6MWaNOovgRiGEcYFfuDJ7ekFaLzoEhChiDgPa4/QE5jGPVnNFECwKFEcmPcRkgQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1774529647; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=R26Jz05ItG1ubmhs27gagP1HK7qzlrsqSQavHEFxFYU=; 
	b=VDRc64hCYeX0BvQkHVkIOAo3UKG0D9nWm+dWmjky6batSeyL6fVYBKvCpCQ/m5aoawbKsiqFC8xu9Vr6UJR3s5pGPILKolr2rIU67i+zNwyDPmxkNQi3N07rA2mGOzi1Tr2QZcXzlZ31+OfvZFO0GtiokScpq+oiu1M4BT02ptg=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=vnsh.in;
	spf=pass  smtp.mailfrom=ch@vnsh.in;
	dmarc=pass header.from=<ch@vnsh.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774529647;
	s=zoho; d=vnsh.in; i=ch@vnsh.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=R26Jz05ItG1ubmhs27gagP1HK7qzlrsqSQavHEFxFYU=;
	b=eqdklICLfGw8wJSDspmRXDjh+BeOtld7+QQZJ0YMkaxWxq1oWP2DlvNQjeQ2CFtI
	rPdpCBHtoehMXZiUtl0fpw024YoxAmxwzVWavIeXK8RTS5475sHPLfrJycLMf+NSij3
	PUx7UL3iG51P5N0qEM4tKduFnNdDaxiCmAR9J1ak=
Received: by mx.zoho.in with SMTPS id 1774529646445211.9969267172828;
	Thu, 26 Mar 2026 18:24:06 +0530 (IST)
From: Vansh Choudhary <ch@vnsh.in>
To: linux-erofs@lists.ozlabs.org
Cc: Vansh Choudhary <ch@vnsh.in>
Subject: [PATCH] erofs-utils: tar: guard empty PAX path trimming
Date: Thu, 26 Mar 2026 12:54:06 +0000
Message-ID: <20260326125406.61001-1-ch@vnsh.in>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[vnsh.in:s=zoho];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-3042-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: 6A5C23358A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Avoid reading eh->path[j - 1] when a PAX path record carries an
empty value.

Check that j is non-zero before trimming trailing slashes from the
duplicated path buffer.

Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
 lib/tar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/tar.c b/lib/tar.c
index 77754fd..24e0413 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -517,7 +517,7 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
 				int j = p - 1 - value;
 				free(eh->path);
 				eh->path = strdup(value);
-				while (eh->path[j - 1] == '/')
+				while (j && eh->path[j - 1] == '/')
 					eh->path[--j] = '\0';
 			} else if (!strncmp(kv, "linkpath=",
 					sizeof("linkpath=") - 1)) {
-- 
2.43.0


