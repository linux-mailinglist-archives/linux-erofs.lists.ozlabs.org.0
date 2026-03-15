Return-Path: <linux-erofs+bounces-2710-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK00ESAFt2k3LgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2710-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 20:14:40 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A7429234B
	for <lists+linux-erofs@lfdr.de>; Sun, 15 Mar 2026 20:14:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fYnwB4zQFz2yYy;
	Mon, 16 Mar 2026 06:14:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773602074;
	cv=none; b=lZg2XXMwmlk4fGiC30ySjbfx9geZsGF9NFgPJJa7rSqN1btbhd2TipcwIHw/A2XlQheoDTD+aSiQZUuDSNS9IA1dSK0orY/sn/gndX4gPnGwVPPVBQUDqlLaDruWJQW5gMLt8l4jZRpsdIPS9LehMba2eXppOVzvOfwrl480GuqYHF4r8g+MGGF3BXW7nn6fEGT/qZLNO6tTEodPkEfH6VLVoL+bcl/D3fxhIeV1xlxyvZUZCirzcmGTqgcbNOvd5KUlfMiNFRSrYKIC8Bnq5RDbbqR/j9nXVrqw0Bftrpq6pv4B9wpIC7hA2JmZsBwAhJnUo/8nZHZ+uNtMWCxi1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773602074; c=relaxed/relaxed;
	bh=gKT4KzFOZbfFFXBkQ5CzhIs6y2Zb7knSg1UfIad0JAM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IUx+8iolRR4sPZQv9DzWntMxxyMJte2Nnbkf01yOs8dDYxefkJX+E5d15LimST4rTY+V9RH0AA6hnvJNnQg4NDwpjeG5ZgWWzs/AkkCRre813bYOE1Ke6Cmy3Ci3qG1HkoooJ/X+6KlLTvnP5XuFMRoYJm5qY/hEYBwZcbclr6qjrzYBz5sUICGXjbrpyrxiEv9dVbojEtJN2maTQMKDX0lkyP7fscUaSD9TejeVgDfN1t3S4A3ezRtpcp3TjH8RyUzZXi+SjhbEKGK/dKxPm1thDe4AxPmn37UHaTdQQNG2Y8eUrPDjqY+UpI8iWDsZUZ5Y2lzJAsjbXnvPlYNjbQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Bfa2CZMs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=lasyaprathipati@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Bfa2CZMs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=lasyaprathipati@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fYnw86lggz2xnl
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 06:14:32 +1100 (AEDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-829b8b6c4d0so3138156b3a.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 12:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773602068; x=1774206868; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gKT4KzFOZbfFFXBkQ5CzhIs6y2Zb7knSg1UfIad0JAM=;
        b=Bfa2CZMsV2F5KhzKLMrPFxP/FYpSLZShK8p5lKmez4i+JbET8WyGqGREqa8GwTOlA+
         RRPp5JLezqJf2tH5eh4ydUgqFHLN0SlLq06cvpWTqCfYWLh8lhICFPjhb9m5f3dBjYh9
         rgev880WfGW2IlO9ibDFr5IKpUEJ0iIzT8Yzf8DtIf9WJ7GIwxFZDzBl2IQn8YqlrjEE
         XRE1WqR4yKmZkgq09xNewKbbbV2JdesZWHUpztsGI5Go0cGhtEehP9D8uie6rIoqhX8N
         oW/uRVNRGCS2VB8h87H0DBWlY5CPjOczC3Lx8IpiQbxF13U7+NjdYH31N7mMmLYwTr9O
         EXqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773602068; x=1774206868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gKT4KzFOZbfFFXBkQ5CzhIs6y2Zb7knSg1UfIad0JAM=;
        b=lE5Gw2vUxiOG2/R3u1EoG94tzmjHjHoGcmAzhGkksULxXoqbc6qUUbeHMKevLC0Yiz
         Fn6HdtYFY0IxH+C7W5fH+LAcNjPQTAM+PV7tzRuRBrq4sWSHkM1rw5E+zf8fSqh2qDxm
         uA0TV+5YnhTrgjA7W8KBPbJLpz/D6ecVI+FPwkxDxI8QgR1gIai0/w0beSt7KyFOCYee
         Zg21QqAvEZx8Ci1lt9jieoHlD3/8LiOiWorXVlXPYpgWDllttiN8Ll1x76KiIc6RkFxA
         r/F3c26fqpqNoLwa5VJHM5M/NtHZzqo0pFnGhfB92dTXWtNyC9yPr7RpnOhL91MxyPTg
         Phrw==
X-Gm-Message-State: AOJu0YzqhHgt0FQmtoq8VURuGOyBTYR7dXuQTpaA6UBy7nVa89qgLacn
	qryVa61t67YqgFoy3YP0OeTn/pQIsaJRh1eAAlk0qhamY9hGzLCbYAenIL1LQdpRHyk=
X-Gm-Gg: ATEYQzw5KONbm2i5LS3cdmioPQ47M90GZzLgrWqQ2x5gwvAWXPVPqXd0FHX4Rrgojpm
	67OWeuByS/DZrBn146QuMSXQQe4N4h+fOsHs/CcbpTPHfX0g0IKSwKRS9hMiWyqinTsxrpzDsl6
	Bq3wA/0nerjYtlrlT4gWvbqjiX6eCW+IXyn84IaTtPB5/GJNSUCAGIFDMKaYsNiOJyDFQbH4yT3
	wnzZOcSCde6m6thsG77Mal6pVWhDffaPuK9n/CHheoolg5w4m30gZDP0TEGFQMXUHRfUCX9eDVc
	PS7DtaPcNpSJLFKvmcUdOtbKMbXaYekFzulZquo26j2a4KZXchw7OSTnIQ5eIrOxTsraN9Nt9PI
	/dWSqm7JqFVXnqjYnZke2BZ35hz8Yws1eDaTvRfRYSv5fr2g/4cKmZN7W89XZw3AoY9EgdYB2Sc
	gKf6CRoSoAaNBz6/y0yrcIwebQ4nHr2p2+XoxRFvKxrArWqH2RVw==
X-Received: by 2002:a05:6a00:4b55:b0:81e:af19:34bc with SMTP id d2e1a72fcca58-82a198d6e1bmr9223644b3a.36.1773602068143;
        Sun, 15 Mar 2026 12:14:28 -0700 (PDT)
Received: from DESKTOP-FQUTRMK.localdomain ([49.204.108.77])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a0725e0cdsm11238026b3a.16.2026.03.15.12.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 12:14:27 -0700 (PDT)
From: Sri Lasya <lasyaprathipati@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: gaoxiang25@huawei.com,
	Sri Lasya <lasyaprathipati@gmail.com>
Subject: [PATCH] erofs-utils: lib: fix potential NULL pointer dereference in docker_config.c
Date: Sun, 15 Mar 2026 19:14:22 +0000
Message-ID: <20260315191422.1392-1-lasyaprathipati@gmail.com>
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
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2710-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[lasyaprathipati@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: A4A7429234B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Signed-off-by: Sri Lasya <lasyaprathipati@gmail.com>
---
 lib/remotes/docker_config.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/remotes/docker_config.c b/lib/remotes/docker_config.c
index 00db1bb..b346ee8 100644
--- a/lib/remotes/docker_config.c
+++ b/lib/remotes/docker_config.c
@@ -38,7 +38,6 @@ static char *docker_config_path(void)
 {
 	const char *dir;
 	char *path = NULL;
-
 	dir = getenv("DOCKER_CONFIG");
 	if (dir) {
 		if (!*dir)
@@ -203,6 +202,8 @@ int erofs_docker_config_lookup(const char *registry,
 		}
 
 		entry = json_object_iter_peek_value(&it);
+                if (!entry)
+			continue;
 		if (json_object_object_get_ex(entry, "auth", &auth_field)) {
 			b64 = json_object_get_string(auth_field);
 			if (b64 && *b64) {
-- 
2.43.0


