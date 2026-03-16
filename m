Return-Path: <linux-erofs+bounces-2720-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Jr9Ftqft2l/TgEAu9opvQ
	(envelope-from <linux-erofs+bounces-2720-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 07:14:50 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B68295047
	for <lists+linux-erofs@lfdr.de>; Mon, 16 Mar 2026 07:14:49 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fZ4Yz1mVpz2xpn;
	Mon, 16 Mar 2026 17:14:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773641687;
	cv=none; b=XEoKqQ4rwmrprqpsRg7tk607DD8i2kTIwwAC443O/76fsp+coh8tBVqkoi3EnUhdrU1HhdBZAqQC7g5cdh9wgCwrwFpGzfTRVn4S2pREld7Hic7uHw4P4NMdUiAJonWN9lceMbnE4SIWBy2xfl0hWSOKls2q+M0UwH2rnT5ACBBfrHgPPNaVi6+JzZHlDPVjGk1Vasvk5fUjh8BqmiHnIeckLdr/0K9l/+bfU6GcmdNYqK7DlL3p2njQ7M15I6V1/QGVI/MpisLBuiSTe4l+8mv+8JwcNKJGs+K52jmWUerhVoMMc+3K3E4tU2y4tWJF0tcZ7VPKHHKdbUbDuu1+QA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773641687; c=relaxed/relaxed;
	bh=Xtw98uB7v1zHKoslDSeoSegCcIr7J7RAVQq22gnxnlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICwaQU512q7LQzIZ3fKQhXqv9Yu/5oFSO2iR49POil+L4d9WFnMEOL0fvcLMnlfTB4WxmodhYSVKCPp/4vCHGuaPNGG4IZcmm4lujQ84Iei9QQiAA3JP0d8lKs5JE0lRZ3wVX6qFjf9dP1wxa7ha55A/6OsuW00f3GvVBKtNcMom7UPqL4yttrIwpK5wKGD7AOrf0OQ3Ij7FUz/LcAnGxftxDkIGUVSvjXfxrzgKnOdr+/RFpE92QI9s8fS/PWTOxVndJXgY8r6ljY6l2TlTNIx3jkmrNWK1ZKu58Wj5Ctcr5lIOC3Ohauy4ytnRTHgxAh8Rw5fUy3tKuU+pM6gmmg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=euP4+uDU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=euP4+uDU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=singhutkal015@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fZ4Yy3ZZBz2xlP
	for <linux-erofs@lists.ozlabs.org>; Mon, 16 Mar 2026 17:14:46 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2ab08e6c553so3363195ad.3
        for <linux-erofs@lists.ozlabs.org>; Sun, 15 Mar 2026 23:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773641684; x=1774246484; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xtw98uB7v1zHKoslDSeoSegCcIr7J7RAVQq22gnxnlw=;
        b=euP4+uDUgloHVPKGh21dLFjuYtRFXtwtua9Cd3egroz6fRv0QshDM7JrTSnGJAs1lr
         h0h5L53z+DmVUfQgLGLCZlhATXkYpWKkks8LHoT4Pv0VIEUFInN6rKLV5q+DsXW8MZaL
         sfldXzSJ1SE37wdV681KA2/AbIOZlarBza6FDz+gGwTqEcg7j35a6dZLfnOb71wrr9Nw
         6wR2ldV98CJNgcEUhj2OXgvCqwmAnLZx/caSTT9qyHFWYDWaTwTIbo2KkDKvAZDXjDFb
         MwesDMORmCcbLg79fzHify+cjrtb6n0R9BJcbGkl2Z0sIlF9SfyXXacVztCthSDFqmm3
         QBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773641684; x=1774246484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xtw98uB7v1zHKoslDSeoSegCcIr7J7RAVQq22gnxnlw=;
        b=lPJGJQgOXkk4Zrz/VVXIwowtLcoUd6vEl62RpSYSSKTohBMFAdIjNfj9iPy71oE3Dz
         ZU5OtMZJrI7d+5tKgTMoQM5CngEoCJO3NJZg4ccesJrVtRI97TLW0IqLVX4d1DsbTWI3
         N4hBkM/2kJA69IUgq63m5vfAsPL9PSRM9zEZuamdenXA0vOk1VlNpCws8ZfHXTJcYYip
         53x/wVEm2wXasffBwZ7+QQ4X2p6qraRM/OOPK0/UJHf8VpGdE+0e9KNxVtI0CYJlv6OG
         QcgN2u6NXw53Gl73PUMgzdIXECPFbu0IjYPdNDqthACpOJrh29ndrqUI9RBKaBieVeSV
         DnHw==
X-Gm-Message-State: AOJu0YxG1TpYG5c0vLNbscE8heUh3lMB+flSQ72RA1XcNpYyStc9tskN
	kCYDRzpGvo+qLIYg6sxMOqip1mIKZken2Rwa419L4YQlTcv8UcQT81RF5ppg2Oox
X-Gm-Gg: ATEYQzyx/9vx7vJ3juI0YQiu4F1rdcez2sibI3cVxSCKMTIcH0inE1wVMNaXkAnLGvj
	5vvsJtC3KxVNcuGtKj73t+IvFatEsdV5s7+aT/7gMOC3iN+2sBHCG7ocnWTJEeHaGqJ1RTcOVF9
	b3n1PKeDkoWRkwgCQRRmJkny8J66EJ6h1LwfK1houh6ofdF4ol1/w+3KUTskaNuRD+WxfO1SH96
	CgsFG96gOPs/aXlnMPjEgaMb7zQPAkkNBqmOzfvRyi/00Yzpu46X9AsJYCLf2ZBAa2kyJ3usANv
	i7SH++4LtLgnifY/e8djAiiySEo3WpThWy53ve9xpkq/ke+vER7sbrt0UwRXseFFDdpK31tTNmZ
	BODRkdN4dV+RFm/ryzzJM2ONfR3Ebfz7jaeSUqjyRTjrfzSXWM4VYYNPBQ+qC4ED8Gz3GHOTpnt
	BF7SB9RnnRE6tMnmXGAqUol0LFVrOKjSGNitCkqYnPHk7mkXgmHmTUePyt/NvFetZpkYhV+uWeC
	JjMjBtdpuZiIuZtKfLm3UTxykXdrYLEZImB
X-Received: by 2002:a17:90b:1a8f:b0:359:9885:3bc5 with SMTP id 98e67ed59e1d1-35a220a979cmr7330342a91.6.1773641684425;
        Sun, 15 Mar 2026 23:14:44 -0700 (PDT)
Received: from DESKTOP-PU4IGQQ.localdomain ([112.196.126.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35b9303eb9bsm3969010a91.8.2026.03.15.23.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 23:14:44 -0700 (PDT)
From: Utkal Singh <singhutkal015@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	yifan.yfzhao@foxmail.com,
	Utkal Singh <singhutkal015@gmail.com>
Subject: [PATCH 1/2] erofs-utils: lib/tar: skip PAX entries with empty path
Date: Mon, 16 Mar 2026 06:14:34 +0000
Message-ID: <20260316061435.13437-2-singhutkal015@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-2720-lists,linux-erofs=lfdr.de];
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
X-Rspamd-Queue-Id: B8B68295047
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a PAX extended header contains 'path=' with an empty value,
the computed length becomes zero. The subsequent trailing-slash
removal loop accesses eh->path[j - 1] where j is zero, resulting
in an out-of-bounds read and undefined behavior.

Skip such entries to avoid unsafe pointer arithmetic and invalid
filename handling.

Signed-off-by: Utkal Singh <singhutkal015@gmail.com>
---
 lib/tar.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/tar.c b/lib/tar.c
index 26461f8..be86984 100644
--- a/lib/tar.c
+++ b/lib/tar.c
@@ -510,6 +510,8 @@ int tarerofs_parse_pax_header(struct erofs_iostream *ios,
 
 			if (!strncmp(kv, "path=", sizeof("path=") - 1)) {
 				int j = p - 1 - value;
+				if (!j)
+					continue;
 				free(eh->path);
 				eh->path = strdup(value);
 				while (eh->path[j - 1] == '/')
-- 
2.43.0


