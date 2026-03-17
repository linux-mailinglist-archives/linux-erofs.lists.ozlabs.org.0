Return-Path: <linux-erofs+bounces-2802-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJu7M3lnuWmZDwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2802-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 15:38:49 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CEE2AC200
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Mar 2026 15:38:48 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZvj11ddnz2yh4;
	Wed, 18 Mar 2026 01:38:45 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::534"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773758325;
	cv=none; b=SdOpdlFeFTLzb1nWx1zWqw7pC4RwR7YQbucbZAlUeiKkWRjifBXJzU3r8wK3d24uzTxbBXKsRNbswxNCWbK4LbjAJ4y6oou9E8pBjn+UIJfgu+E4U3J84MRjAt8DiZNg/dY/QOJHmnpBbjoEvXbjjQjNGcySW5SZ45LKsyETLjT41/4+DRpIr1v08Qdsyi1ddlmvc8IMLHDSqKixTBdtSOvNqCJaQOmH7nOmyc+Sb4iTWJfihd0CilGApIbqpPp2M9sFy0hOnfa6cn4s+XBPgzmwrcVbSJPOdXMscqnYlOWx8F0F7saSTfaiXctvQB3KhXBJoBKpw5njxKqAB8MRSw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773758325; c=relaxed/relaxed;
	bh=TtcmYUojTiDhOiE5c5tLdWVhEHrY2H7PxB8q7aiHAOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=je1s70s4e8Bq0W8RvcymsBXdr50ROaI21svM6S1E3+KQtN5YGx/nj/5YYYo0ALYtBI3OUvZAmQj8VsDyWl9+s7TI17Luj5lLolBjoyMxhEyiM7bje1OE8NgWjjgdzNEt8glkpOqjMMJYC2fHJasJ0v34C/FM0wzsqvjfqDqnmRiu+YuHt5x4i6t5Ju43z/rqsrw0IwwjNmZXPU+W0hfS0DTlNeAc+R3hJgKGzm3zRnRpeA9xkROsZxonsvhfYvuKSYJms0g5/Jg2i8zVlUSDkpSQUnvbz/ExSVgB5R1uROEh1eas29cAYgzAkBotfGyLTm7gMfNbvH2by7xNI5ea+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QVwzoq+p; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=lasyaprathipati@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QVwzoq+p;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=lasyaprathipati@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZvj026xkz2ySq
	for <linux-erofs@lists.ozlabs.org>; Wed, 18 Mar 2026 01:38:43 +1100 (AEDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-c7412b07f22so275978a12.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 17 Mar 2026 07:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773758320; x=1774363120; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TtcmYUojTiDhOiE5c5tLdWVhEHrY2H7PxB8q7aiHAOU=;
        b=QVwzoq+pkBFR5zjwn3KBt80tbqinv6K3Ddkk0bxq3BCb1F1OYpCUXY60aqT/tgGKpb
         2eaNOqbW4bnlxIgxvLdv5XpHW0nUYG5oa7VTWL/32Sm2yELX8Frtuhy2m37VH9xSKgaM
         /q4e781gLaX9Kf+V+aKeI8mzA/jOtQgOiCpqA9OM5qiZOvgl/21LhZxA98gEVhPoEGLE
         6jhAYjTdqnUqvFtJF3ZxDM5CBSzYZRIrWXXuL1wefCQjNaU7SBROO7wt0x1esW68qLJv
         SKQ3am4eYuw9FLwd+3alOVlLPn1wKvr66v7cQys7+zf8pYbXhbQ6SlNmRVMh8Xa4sBO4
         rzxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773758320; x=1774363120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtcmYUojTiDhOiE5c5tLdWVhEHrY2H7PxB8q7aiHAOU=;
        b=nScEKrXlGqzd73XuZcQY5dj+ucDDbp6d4GRLFbxztN7c6m67QZgRkbmk4UgQ675hPP
         WF3/dKBk/DrwuE6VQRZTPS3GmVdS3YdX2DQdBn+h0OGQn6L1/wCTWAChv4tEHIZ2C5EU
         GF716aWlngtfWbdVR45/kMNrfB479fWaI3lvtq11/dxQbGZf2VQtcxLuexCR8ITIdikP
         jFrRfkUxlLjT+4OBP8uttwoGOqr9ekgkkuEYPPq7/z6xldpshZmVCZ8kLYGsn0zyQyvm
         2BNzKc9HuaL1tuO3bMckM+b9OPAZ0a8mX/ib0YaIrcGZ2nL8w77rQKHIGxNrPFxfu4rF
         ItBA==
X-Gm-Message-State: AOJu0Yx8UhrAJApDD45yprMGtifj0bm8V78dN4pVftGy2QmuyXIXmmQP
	d1b3gmLDhOjt6QQkrvauD5MtdoXuwrjqPzHqB0bxvRxdM+QuwgGPBjx/RvXX8TZj
X-Gm-Gg: ATEYQzyJyc/9bqQyRQ78875xdI35VLLLY+fGUBJfflAqSrhM8akHQUezy+XE1NEhMeL
	S8VlAIrHi1MprZN4P7bUogJhVslX3iFjlJuESPrb0pEWOycOh4hUAZpFDBnTVDHixvOEFgUBRLl
	iBVDPaNrYYBzLAM0/7SSjyrGqU3jqZTQrbWowg16plndWFc4KQD1yg37WoXqmFcCOx3z4OTJbGk
	LdxYd6WTDAcTyJWxWdNUWNTZG4LGs7Qb1P4bd8ytT7SvMjdZob6ZNGmR/5WeTGk8z8UTACJGbE8
	/j9HChi9VH0QFKhsLV6tTYWf9evKBEsi8NJJzndG6/GznoVfgUc78VN9dB/B4x4WEDD+65oN3Mw
	rgeIaAPnjurtoMYD5+WcCcDlgk7N0FW/mvgOAQyPyFTDBxldRN4Iy0jLr703kbFBKkPij6xYunS
	xXv4scAOmdSZhm2qzeEPkaJm9OuH72jlfy2ME4vCuSysIbF/uTm3c=
X-Received: by 2002:a17:902:e812:b0:2ae:5346:d4e6 with SMTP id d9443c01a7336-2b0637144bamr36561965ad.28.1773758319679;
        Tue, 17 Mar 2026 07:38:39 -0700 (PDT)
Received: from DESKTOP-FQUTRMK.localdomain ([49.204.111.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece7edd1fsm185972935ad.47.2026.03.17.07.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 07:38:39 -0700 (PDT)
From: lasyaprathipati@gmail.com
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	Sri Lasya <lasyaprathipati@gmail.com>
Subject: [PATCH] erofs-utils: lib: fix potential NULL pointer dereference in docker config
Date: Tue, 17 Mar 2026 14:38:16 +0000
Message-ID: <20260317143816.12645-1-lasyaprathipati@gmail.com>
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
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-2802-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[lasyaprathipati@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: E0CEE2AC200
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Sri Lasya <lasyaprathipati@gmail.com>

Signed-off-by: Sri Lasya <lasyaprathipati@gmail.com>
---
 lib/remotes/docker_config.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/lib/remotes/docker_config.c b/lib/remotes/docker_config.c
index 6401c1b..74ef5e6 100644
--- a/lib/remotes/docker_config.c
+++ b/lib/remotes/docker_config.c
@@ -60,6 +60,8 @@ static char *docker_config_path(void)
 
 static char *read_file_to_string(const char *path)
 {
+	if (!path)
+		return NULL;
 	FILE *fp;
 	struct stat st;
 	char *buf;
@@ -182,10 +184,12 @@ int erofs_docker_config_lookup(const char *registry,
 		return -EINVAL;
 	}
 
-	if (!json_object_object_get_ex(root, "auths", &auths_obj)) {
-		erofs_dbg("no \"auths\" in docker config.json");
+	if (!json_object_object_get_ex(root, "auths", &auths_obj) ||
+		!json_object_is_type(auths_obj, json_type_object)) {
+
+		erofs_err("invalid or missing 'auths' in docker config");
 		json_object_put(root);
-		return -ENOENT;
+		return -EFSCORRUPTED;
 	}
 
 	struct json_object_iterator it = json_object_iter_begin(auths_obj);
@@ -202,10 +206,8 @@ int erofs_docker_config_lookup(const char *registry,
 		}
 
 		entry = json_object_iter_peek_value(&it);
-                if (!entry) {
-			json_object_iter_next(&it);
+                if (!entry)
 			continue;
-		}
 		if (json_object_object_get_ex(entry, "auth", &auth_field)) {
 			b64 = json_object_get_string(auth_field);
 			if (b64 && *b64) {
-- 
2.43.0


