Return-Path: <linux-erofs+bounces-2919-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KK7BU3dvml3ggMAu9opvQ
	(envelope-from <linux-erofs+bounces-2919-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 19:02:53 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2792E6A82
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 19:02:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdS2Z59qnz2yfs;
	Sun, 22 Mar 2026 05:02:46 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip=103.117.158.51 arc.chain=zohomail.in
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774116166;
	cv=pass; b=h5kkVM0N6S/9yi1PyPw6soV5pL1HDZZit8C/opbX/STXH6l6BeOwW18Io9OJJqR61J0h9DYDFvMZ8ae4pRoljyIRQnnP2G2FnbXudcff3WPI5Z1lVqinlffGUD/hYbz8/Is8swRUZFtTm6nE5aG0KD7ESCwrNmFIXdkRn1XMg49yQcTjM8flvdLefAQWEviuRKP8FRtilgrZRXUQCgHNVhXLV7lhmW9wezJsmZJf3mA8RMFY1W/1gqikOCkNQvSHnYq2oDpjptIcDWYUnOaIYogebdhNs2MxJvTLpnCjxtU03vOWTs0cl9br4s+jzQfgjsUdCRVdPf2vhrBV/6CcCg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774116166; c=relaxed/relaxed;
	bh=dinM+KRBNVO9jAa4yr772KySedSy3OnXZNHpLMKfdww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bxgw/MAl7bqnmXjruDE8PZNTS7GLafJ9nGJ1nAvNNAh5uBN5P0s981wuYeGvNb8Sc7ia8y5A7WYTPjk0inoYfL8HDfEz6f9wfVmpE2vpNs2hq+mwuFnZvbyautoVs6qjW37QKa8Lx5nUHwQHlNcVGOoCKVAuYYifLF4RzcUHO4ADG0VkDRePz4gTAAM4HBssg2pYnXF6mWc6BoDta+/c2yapdb5bSCkCOAuFTyL/gt5cMxufYRinKABzGDm5LB3efHpkW0nKwkzF1pTNLON9jgsfqYZFDkMXLstVhBLsmw7ReIuvHNLjSZMKTJFxgCp/ziVP1wBEuymSSh3Al2CWRg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in; dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=AOrtc7GK; dkim-atps=neutral; spf=pass (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org) smtp.mailfrom=vnsh.in
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=vnsh.in
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=vnsh.in header.i=ch@vnsh.in header.a=rsa-sha256 header.s=zoho header.b=AOrtc7GK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=vnsh.in (client-ip=103.117.158.51; helo=sender-of-o51.zoho.in; envelope-from=ch@vnsh.in; receiver=lists.ozlabs.org)
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdS2Y0hycz2yYq
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 05:02:44 +1100 (AEDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774116160; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=bqSwq6uZwd6VGW2zRH+m3t6Hz/hQ57Cq/ky94qHjVNrAKHRwm/vZdUg4NJC062giNmNuTl6llreqC8gg7OFpbmvFd6ajGHScRLgkOL0+sJMV7IGHkXzv65wSqxkGz4Wgm12nA9Va2/DdS7va4+74xo+WCzWcow6JoMu1uiUtqs4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1774116160; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dinM+KRBNVO9jAa4yr772KySedSy3OnXZNHpLMKfdww=; 
	b=TNiDWnAi9YXX+krOx3p7iI7lzmlf5Sb8zamqezcn8dzPAjZ4k/6IlXjXsPvz/S1BPx1/12HFl416azwiK6E6Otp61GP7yQlvdPYrvym/VhbTyipA2A4Fs2Gthsm44hWRIBYbbNv+5FhUor2a2V1gral5kcs6wy2HZ3arJEevz0E=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=vnsh.in;
	spf=pass  smtp.mailfrom=ch@vnsh.in;
	dmarc=pass header.from=<ch@vnsh.in>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774116160;
	s=zoho; d=vnsh.in; i=ch@vnsh.in;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=dinM+KRBNVO9jAa4yr772KySedSy3OnXZNHpLMKfdww=;
	b=AOrtc7GKmqZjVpYZDPrHDBMbhWxUImt8NRfjMaymLwMf9epbqxR56gyvebZO2F3a
	AjuPn4FLdK4BT+/PzEmHh7SYlZGe8LSv6zf3VvuXGMeINzBuZpooS9kqBwvPuB5NUXD
	e9hO+mxgmYb7w5XXMxdGVvvegcgOsA8NwoRZqrUE=
Received: by mx.zoho.in with SMTPS id 1774116159377898.0814336638659;
	Sat, 21 Mar 2026 23:32:39 +0530 (IST)
From: Vansh Choudhary <ch@vnsh.in>
To: linux-erofs@lists.ozlabs.org
Cc: Vansh Choudhary <ch@vnsh.in>
Subject: [PATCH] erofs-utils: mkfs: bound-check s3 passwd_file credentials
Date: Sat, 21 Mar 2026 18:02:39 +0000
Message-ID: <20260321180239.36249-1-ch@vnsh.in>
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
	TAGGED_FROM(0.00)[bounces-2919-lists,linux-erofs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,vnsh.in:dkim,vnsh.in:email,vnsh.in:mid]
X-Rspamd-Queue-Id: 5E2792E6A82
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mkfs_parse_s3_cfg_passwd() only checked the total passwd_file size,
which left two issues in the parser:

- a file exactly as large as the temporary buffer left no room for the
  trailing NUL byte;
- either credential could still exceed its destination buffer after the
  string is split at ':'.

Use sizeof(buf) for the temporary buffer check and reject overlong
access key or secret key fields before copying them out.

This keeps the existing parsing flow intact while making the bounds
checks match the actual destination sizes.

Signed-off-by: Vansh Choudhary <ch@vnsh.in>
---
 mkfs/main.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mkfs/main.c b/mkfs/main.c
index 58c18f9..eb13aba 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -663,7 +663,7 @@ static int mkfs_parse_s3_cfg_passwd(const char *filepath, char *ak, char *sk)
 		erofs_warn("passwd_file %s should not be accessible by group or others",
 			   filepath);
 
-	if (st.st_size > S3_ACCESS_KEY_LEN + S3_SECRET_KEY_LEN + 3) {
+	if (st.st_size >= sizeof(buf)) {
 		erofs_err("passwd_file %s is too large (size: %llu)", filepath,
 			  st.st_size | 0ULL);
 		ret = -EINVAL;
@@ -687,6 +687,12 @@ static int mkfs_parse_s3_cfg_passwd(const char *filepath, char *ak, char *sk)
 	}
 	*colon = '\0';
 
+	if (strlen(buf) > S3_ACCESS_KEY_LEN ||
+	    strlen(colon + 1) > S3_SECRET_KEY_LEN) {
+		ret = -EINVAL;
+		goto err;
+	}
+
 	strcpy(ak, buf);
 	strcpy(sk, colon + 1);
 
-- 
2.43.0


