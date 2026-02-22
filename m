Return-Path: <linux-erofs+bounces-2344-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WscPGBiOmmnlcQMAu9opvQ
	(envelope-from <linux-erofs+bounces-2344-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Feb 2026 06:03:20 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C4A16E7E3
	for <lists+linux-erofs@lfdr.de>; Sun, 22 Feb 2026 06:03:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fJX1Z4sH7z30Sv;
	Sun, 22 Feb 2026 16:03:14 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1771736594;
	cv=none; b=FHW0oPwZcCc6VVLVhk3wUr5qYnEBHB3S5e7nKAJYg0pD8UVn0kDnKj0oaHk5srj/Yfrx1w5RQObfK0wg8TmSygwRx1cgiaMtoPGnXMr40MygnXIkXwOHeionbiiIOmDQEEx9dWGhE7iBgYFxMSmdKWlwahDd+xtqhkMgoD8uFjzcPUpr8Kzm1Lv0lJje09dfR6DaZZpoCY9Fs/jtKg9X4WrWRrf0+W7OWH0q31+9EXkNNd7Wed6vC3YxDUz/XYAtc6eXJyaXCRqx3WNjKlWaW3TmHtDwer+0Qozu61dI37K3yK4UbC/V7adUMn/Svli1I3uPWvwI1/ytKEBKzJMo1g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1771736594; c=relaxed/relaxed;
	bh=8Ip7vg8wP9vkBS6+cJF6uYwxdhQzY3VsATZPq9kHnLE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CMqkH9d4vj2Dgg6I1Ggs7KUK1kN8ArE5gkYVpVCJulGnadHeR8tU0w7z0U0PrqaillPKa1/ohE931G+vXj1X2AIT2xrQzMMe+3OqpXzwIbJXSYnzeFhLrgetIIg3OT9w5vMyIaUyEB9WGaRlHdUzq0xQf1k/dDlWEi/rM04t4SJnC020LLXJAfDx0YOiRNWZMjXq+xUg32Dr+AkmSmZozUJtFyw5Dl9aiOjL33haMAPL2NS6xF1tHANPnv8LvYmJDl4twvLlZL8imPGclPu2Eaefz67x6pQXyjw1pC0QmOcLCAobekeAVnyLxWcgZEvlAllcmUZKxtZLVlm34g7HoQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=S+MwRl+J; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=nithurshen@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=S+MwRl+J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102d; helo=mail-pj1-x102d.google.com; envelope-from=nithurshen@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fJX1X6ZJkz2xm5
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Feb 2026 16:03:11 +1100 (AEDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-356337f058aso1375523a91.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Feb 2026 21:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771736588; x=1772341388; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ip7vg8wP9vkBS6+cJF6uYwxdhQzY3VsATZPq9kHnLE=;
        b=S+MwRl+JtP9Vne9k26KFFhiH+2s7i1CQmGk9zy6GEyc0wYQvY5HZ0/AwKF6l3S81CI
         qOdfee9AKbczDBbMqOAYQjGcDuuVeJmtBarRgI+LwAqCPbO+/B/ql5Qaz9JBVhrSaSsG
         lzetZZydrcxdiTub6Uo0K8Va97lbtQSwXzJCEL0nl7eYvqcgTo5pmrASJ0L7FIJlZ7m0
         brH5//aEvo5M6iCAWvrXsdFh7iRFaPvA1aq8LQKOSjtS4Uu+EMxJBlnOfHbtdnP1G787
         1zeKFOuWHNRzvM+sZokiBz2bFNLEtxVcZl0wddZ+1AnuT/Vw6rgfRkPY8PUTRbDXPJuq
         gAbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771736588; x=1772341388;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ip7vg8wP9vkBS6+cJF6uYwxdhQzY3VsATZPq9kHnLE=;
        b=dzadPEAs4pM9DT9b0a62jgqUBNRgB40MDPM1y9Vypi+gHoo7CEtxWNcvimkcnUqaUq
         7CC2dGxLCdjJPSnFbFAF9vzLjKUxhrFuw0HMXSqUQB8N3C48Q5NdTdcX463qIBYwzMao
         6idKPuXIp8EtY62GsKwluXiKNMPbCtdDVOogvnHQgl73UszDmccbKTPGrCMpKjqII16w
         2jbYyw+QPCq47I+Cw9xdQwGuEjiXfgNYeS20mdAJfWS//60nvqIXuu087JQ2OQtRXPkk
         NKfI9Rhwt9M2j6I34xepNnHVpnBTAhqUJVSj+4FXndMhjEGt/nxoVXlN9SbqSkgcqEFv
         oqUA==
X-Gm-Message-State: AOJu0YxZuA8/VBzLIMfF3eqw8Kr0Qnshjk3u/sBayagjqJHShmD8/iaQ
	et9c5FYQhhxzcD0xkPdPen4VMFcX+8DLt3gQWVSFTm4O2z1soqqb9fv1QLb4MzUk
X-Gm-Gg: AZuq6aI/8ARE5v/SLuXdinpwHgQycBIdgbOaj2wBkyXztWGV7fQCxr5jB7L6I3Z7RaZ
	AQIdKv2RGBfw7vMb3tf1Hx+T3OTXI6icPqPN8+PeROUOd2t0uLu7LoR6Pm8fZ9iwptyjB04c3UQ
	WGiiJ9OdOMU8YoZZP1ui2IcHca/Jc61iMLLvEUpKTcBDQvzrIG/sOiGcJMmaRqEFCGeqbGWZysF
	MJ4qgi6agcHg4hUmHHScZ7dGlFbCB2z7MVK/liO4NnlBU16lOfN7Yf0EQNjaGNWY+rNrPGxha/G
	hTM9h9AwuIRlxqlMQKd/3DkyBDKAHZVV9/AEjbU92lKxg1dYL3J+4Zsar6H07uxI4SVzbK0bifL
	546oGYkgqBtnKPvomURUMoyGEjtjW7cwOb8CLkYyuCPEbaVgZvGT8LOdf++4J9XWgMvdkzDWi8V
	yCVAqrDhj1WJSuf80yvxSx9ZlwKgsieFkzV4FuTcZe3UeFAIz8zoOVRU2hLE59v/gc66beEZLHk
	HQn6A==
X-Received: by 2002:a17:90a:fc43:b0:354:999f:1b22 with SMTP id 98e67ed59e1d1-358ae8d7510mr4229172a91.32.1771736588298;
        Sat, 21 Feb 2026 21:03:08 -0800 (PST)
Received: from ubuntu-arm-nithurshen.SNU.IN ([45.114.151.85])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-358af701c7bsm3463108a91.1.2026.02.21.21.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Feb 2026 21:03:07 -0800 (PST)
From: Nithurshen <nithurshen@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: hsiangkao@kernel.org,
	Nithurshen <nithurshen@gmail.com>
Subject: [PATCH] erofs-utils: lib: fix undefined behavior in zstd dict_size bit shift
Date: Sun, 22 Feb 2026 10:32:19 +0530
Message-ID: <20260222050219.27511-1-nithurshen@gmail.com>
X-Mailer: git-send-email 2.51.0
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.70 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-2344-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[nithurshen@gmail.com,linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C5C4A16E7E3
X-Rspamd-Action: no action

cppcheck static analysis flags that shifting the signed 32-bit literal
`1` by `ilog2(dict_size)` can lead to undefined behavior if the shift
amount reaches or exceeds 31.

This patch casts the literal to `1ULL` to ensure the shift operates
safely on an unsigned 64-bit integer, preventing potential overflows
on different architectures.

Signed-off-by: Nithurshen <nithurshen@gmail.com>
---
 lib/compressor_libzstd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/compressor_libzstd.c b/lib/compressor_libzstd.c
index c475077..f47635e 100644
--- a/lib/compressor_libzstd.c
+++ b/lib/compressor_libzstd.c
@@ -123,10 +123,10 @@ static int erofs_compressor_libzstd_setdictsize(struct erofs_compress *c,
 		} else {
 			dict_size = min_t(u32, Z_EROFS_ZSTD_MAX_DICT_SIZE,
 					  pclustersize_max << 3);
-			dict_size = 1 << ilog2(dict_size);
+			dict_size = 1ULL << ilog2(dict_size);
 		}
 	}
-	if (dict_size != 1 << ilog2(dict_size) ||
+	if (dict_size != 1ULL << ilog2(dict_size) ||
 	    dict_size > Z_EROFS_ZSTD_MAX_DICT_SIZE) {
 		erofs_err("invalid dictionary size %u", dict_size);
 		return -EINVAL;
-- 
2.51.0


