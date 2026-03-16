Return-Path: <linux-erofs+bounces-2721-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOqIM9yft2l/TgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2721-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 07:14:52 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B358295054
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 07:14:52 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ4Z15qJtz2ygh;
	Mon, 16 Mar 2026 17:14:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773641689;
	cv=none; b=OzTU9l288JgZvm267cc+oFijPiLFLFIJid1YydbYjl+AyB33khfBtOtZSXUWP7WbfsRUJEiXuOB0Yp6RuCmP/9MoY8B1IDrTEcrEWRZt/RUfiNJSOX8swtD5tbEP0HS79HLLlRYTNYG8ZSoozsJmk5HBO/ZWZPdne54oznWKnnjyqOKa1vqPCqguBCyOP6Gk10hqHTOcQ6mQVAluud44obzShPnXe2KFgBrEpYNBwZ/aFvcSn5VAa5n1S/HO6qwn5a+IggrTyUr/imNbiwMiUZQSaa5B8hUkcLBdFyXdYKfs5qQGkivODlNvnqpnGTN32VshbsWTbDY7wMwcJtoiVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773641689; c=relaxed/relaxed;
	bh=m8B4sKVaxI4rrlvjYoMgN/WF/Ymdz6OtAklRiAArGB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=flGBfgKKNmd3kHN7PIhbQITy/V2fWeCOtz4D4v0+zC84bp2YTOQd8X/iPF2jRrY4aXP9E7SBr8XqEwzg0fWLWZTcqvdpUXaYCox+EWUB5PqKnDynsr3+MidNAKiL6iaF6KzQOCCwSCjFl07EWjrUer2zgSnV0D+JaC89vCGUxGWaYeN5xydU2JXSG5mIX9AIBdW5HTQ9mjJkX1elGyi/bsdxtQVrszWv0jUhsx+A0Sx2GnccHswdA21X2RimHVRnCT4GuNnUd7lEwj/2tvEWgwmipyw5RaKwW4N38mzR3XK36JXC6sL0LlfenQxwRwck+X2EJwTaG9dzV6CejflkhQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WwnWynKA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=WwnWynKA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ4Z11Qc7z2xlP
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 17:14:49 +1100 (AEDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2aecf52fa69so3666845ad.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 23:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773641687; x=1774246487; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m8B4sKVaxI4rrlvjYoMgN/WF/Ymdz6OtAklRiAArGB0=;
        b=WwnWynKAA1FurCpo1c6JlSrS6LtI0OnJexOZ/7nMvURNZZsReTxJqgL2ds/Q6oRJyg
         GocI54AMNvR43FMtxZ5QXPCeNWXU+E7bzcGYtykN2WT/op5gbslPDg5IQYatP27ug5Bu
         DQN1MpNhYUUC/FzPsjDLlKLoVNFERRP/sqe2bDIIhvPlvstsuZ14NgQBDiug9ztvsZ1G
         fZkjOJGcuYmTIwbMveGXf4f7iqKcIJNkE4TGx00t8aHHeb1Z1UbW4lsi4cSfQ1JXWft3
         j6sC61NQAjyO8Y7BbXUj04BJaKmK2DZC54i3EJP6j24iJZUw03zKs7Zv+w2eV7O7au1t
         E3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773641687; x=1774246487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m8B4sKVaxI4rrlvjYoMgN/WF/Ymdz6OtAklRiAArGB0=;
        b=c2zjXHWwAglgb2wEZfz2X2isLfXlG/e7bFQZOQfYLz7OvGN5GpOev9xd+4twFArWe1
         lz6xhndn9Jje2mD7HCuTjUup/FrmIAGFCAJGMQ1Am5xdCUG8tGw8f9D/QHsGuOLzakx5
         RuunYAlQ/z2dvFFMfic+XKoHa1QFSssduR63JVkzaKwiUc1oXbWeT9AcacqMGWmAOQct
         urDLiFHcmQE+nxYwtx1pi/NKtb8kMJsJutlUCY+Y0zxpFakioL91IJBujVKRjD7SL7Sh
         NUA6nuiwx7a8UR5iLj5VhqwQPlsQ6TJzvfnsavltLeb3gTLhWx2HWoAEDA0GDVLZSw1a
         PZFA==
X-Gm-Message-State: AOJu0YxpF9TXpLMS0FlQ8jDFrO+GGxTMwxbB7EFZlmvVZmjaI5kBo23b
	qnX7tx/vEoPVcNJFVvLR83Kia4jVGJsDOfYViqKrsXt36f16ADS5Ih2RoIUXCBkv
X-Gm-Gg: ATEYQzwREOVr3aVXBUaxRKArjVLwG4r8BlHDOpMsgkgIRfhsVEtE5dS3bRW05fK3pbh
	wlS+PdYKbPrCF1XPRw7uTTqkoRbYQNDKXNJx5ZLNak+REpYSFl6jee2oy87PV8lFaH/AYA/vZpD
	f9GhOawXZQEcT7a2NgrbLfXdvddh19fl7U6ntwLWKKuRXh5531EH1crRM/Wfv7zd28edaBFkVHo
	Du7JtieqAUJS3sLtCWYUsHvZAT82N+zTYsm2uG2XRULvGIVfjdpqIE74BDykK+QfIWcaAJ1+I+X
	qoa3PW9HfqBtozYKAeksHwu7fDnF3ww/sDjZV361HatRi5bObolyMInUiXMQlVnK5c4nILwMEzo
	L+1WE9ZDWyYmT4+6VCKq014BAxI3zVIRkgI6eVIu4Of/aP3pRgeMQmSI/83qOoo08CjlqvhSsOP
	0Pb3md4EE8xk2flnQZjgT0wl+stP8Neel59hVHATVKpKfP1VzCuJjGc2QaQbnQK5uV5DmNHL8Za
	9rgZThmjOlc8UEYcsMnQZGBjwHEoqgAhqZN
X-Received: by 2002:a17:90b:380a:b0:35b:a760:1a44 with SMTP id 98e67ed59e1d1-35ba7601dc4mr310202a91.2.1773641686841;
        Sun, 15 Mar 2026 23:14:46 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([112.196.126.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b9303eb9bsm3969010a91.8.2026.03.15.23.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 23:14:46 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	yifan.yfzhao@foxmail.com,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH 2/2] erofs-utils: lib/tar: reject negative size= value in PAX header
Date: Mon, 16 Mar 2026 06:14:35 +0000
Message-ID: <20260316061435.13437-3-singhutkal015@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316061435.13437-1-singhutkal015@gmail.com>
References: <20260316061435.13437-1-singhutkal015@gmail.com>
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
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,foxmail.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2721-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[singhutkal015@gmail.com,linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 3B358295054
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The PAX extended header size= field is parsed into a signed long
long but no check is made for negative values before assigning to
eh->st.st_size. A crafted PAX header with size=-1 passes the
existing format check, resulting in a negative file size that can
cause incorrect memory allocation and heap corruption in subsequent
read or seek operations.

Add an explicit check to reject negative size= values with -EINVAL.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/tar.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/lib/tar.c b/lib/tar.c
index be86984..cbe62be 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -546,6 +546,11 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
 					ret = -EIO;
 					goto out;
 				}
+                                if (lln < 0) {
+                                	erofs_err("invalid negative size= in PAX header");
+                                	ret = -EINVAL;
+                                	goto out;
+                                }
 				eh->st.st_size = lln;
 				eh->use_size = true;
 			} else if (!strncmp(kv, "uid=", sizeof("uid=") - 1)) {
-- 
2.43.0


