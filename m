Return-Path: <linux-erofs+bounces-2898-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QG1dGBQ6vmlQJwMAu9opvQ
	(envelope-from <linux-erofs+bounces-2898-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 07:26:28 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 753AF2E3A78
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 07:26:27 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fd8b41K6bz2ydn;
	Sat, 21 Mar 2026 17:26:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774074384;
	cv=none; b=Oim/iiSRC56hsEAMvp0ODgmfcFkClCAZpSLJcwa2RPbxiMmvnTA0kjj+fy/L8R2OlW8h7vZ05y+mfB6mve9KivAFmHnoYR1HnMWkfXRjTRe5FlVsgk4YbEMX8Bhx01HWNoDTHImaaNe7Zrb56Rz1QG6HGrWUud/oxLJVs49p4IIonurHeFANIedCm5cPJTJBAVYb7trG4tZpBoWUEiL6Iuer4phoJnkO2GUWC9/RpQUfd/WZRR7P56KYzOQt7AiZbOwfD/ehPQyqFKN84srOXjzezKC88ntrorsULgvCAStAPqcHJiDV6I0ULNrqnD6BY/uK9cfCzZNSNGU4pfmUmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774074384; c=relaxed/relaxed;
	bh=Ultho8EO+D8rLbaSyWjefzS7ugedp0AIIb44dXddBJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFt9v8OvYEhYEZQrVwFeTRHIRxZISEH3UNDlj0Q1BMdyH0FqJ+7SORN6W0wy7C0D0vJ+Nh6FpON6QhAQS1kSzWQyzx5yGm1eW2zJrXevNyBtp+0JwM6bNHhiXCXR/AyDKr9sovMfZoOnvu2MPkB7DPw6icKJnqVUB/RkeJpTey3o9/H01tJljG2yLbyVBSfhQhi9iuJTJY33kjRvo6IPcTy2fqm7uc3ig7B7kkgbplUvLRyvrIK8blGuhbRxtGHGno1eyUIkdCOdLOcn/TUL91VMidfP8/3xbcukzjBKXNsOBoCBacH0espHytHtQ6o8PQcTK9WxG5RPxSHdw+im/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MG5zb6ta; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=MG5zb6ta;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=newajay.11r@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fd8b340m0z2yYq
	for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 17:26:23 +1100 (AEDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so33687685ad.2
        for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 23:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774074381; x=1774679181; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ultho8EO+D8rLbaSyWjefzS7ugedp0AIIb44dXddBJM=;
        b=MG5zb6tay66Gbq0qedyMgy+rKg+GQBhbcpkmcYBNTEYM8RUFBXvGGIrUY7JvwiZO8O
         jzBS2YmgHeO6xAnlX0Np+zbV9wiwUs+XhKh+pQ7k7j5czvrVdhDi9LFarVeXCpmZrwAq
         PzZaghY2S8v1c8OKIOSuqo1ADKNeEuVXTjrp0qQnIpjfXvjtn8/wo57vwlYjav13NIm5
         jSWyY5obuaTR8PXd/4nobCDklRSxiFbW4H1lpYpdGe2YyxFlnH7vrO/+Niyh/kZHyoRa
         k+iRJS4TBVnkPzDaYMbIOdzjK4v8i7adnFyy6bnQSpeE1sJcuHWGdl+jTo2VOaIJTs+H
         QX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774074381; x=1774679181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ultho8EO+D8rLbaSyWjefzS7ugedp0AIIb44dXddBJM=;
        b=Jp7bYa6ZexrBx5k70DrIGqIe0+b3o1txoBSCljTsUxiOsQBunZEV4by9KbY3fef4pR
         RWyh8LSul1T6AivWGWp5MfLmAehV46MgQe4znCwMqM8BgrMZzX1HuMyJ+b4YTrDxxYNC
         uyMn6WTBosGisd1lLiajN7rmZuSjIfDfRxLTQgDqVQSiIMpxrJRXj1zrF/untRBaJvTy
         DzB9PacU0aWVJFzGk+RxpPulZaQZVvrIPF8g5sQA1HP4nWWnG0UQARpmNQQN0FomnQ1t
         9WtiYebenVmTribQTy5wQhvKzSHhAtGMYY2+ZeO4mQlpBoXAmRdyT5F7qsgBwF1bXYgp
         g92Q==
X-Gm-Message-State: AOJu0YwlzPUZwDBrn8dJejCYmpM5l59QZTviGnja97tyMKgmxq++r7a7
	vqzXhh04DeKkMlExoNdhXHkQIS6ExpQCxqM6Y/FxEUx/0FoIubRvwfbfwpaDkQ==
X-Gm-Gg: ATEYQzyvh5vQpClNoOjpOVZVplMGuI+T95PsVF+jh81yI6HE8UHQvg8K08KeHlF2zFg
	cZ+/QOTOzBGwSFJOTMx0zVLUoyCIBd0YFw6KeImTHN86j3+QEQO3h+bp0FQZ+NoRMc/TNKdSpzZ
	m4j67ORvxE6vYkJfwqDawf7ud1lqMHk2xmT/1vzvLgaHm3WIo50ihmQrXUwapwKaaaAMCEMsuOS
	2l4Bye5D+gHuaAoADRI9ZpU535Rp7vnWmKlL0Ju3H6+nL7g7aVjMwoybAtTVJBwuj92jYS3yBX2
	9rvBVgERmoFIuBtA/TczJ5ZoRUX8ki0v4i4/jypbtHOn1bfS8+huvUI+aLL1DFRqRWzGtVH5+hE
	BjyajHLv5GL5V4GirrdLsBQP7P6qk8dfdAbqnKCUpZ5Qj/GVUPZQ7zGah174EoiQX9snIXNo2MV
	BOT/WuFtue8kyO7KQxRx+us3utu3ZLe2iZaapA
X-Received: by 2002:a17:902:ecc1:b0:2b0:5923:5194 with SMTP id d9443c01a7336-2b08279743fmr54835475ad.27.1774074381262;
        Fri, 20 Mar 2026 23:26:21 -0700 (PDT)
Received: from LAPTOP-TNA2GCLL ([2409:4043:4ccb:27:b9f0:ed0e:8874:a784])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b08354b109sm56661575ad.31.2026.03.20.23.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 23:26:20 -0700 (PDT)
From: Ajay Rajera <newajay.11r@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org,
	Ajay Rajera <newajay.11r@gmail.com>
Subject: [PATCH v2 2/2] erofs-utils: lib: fix memory leak in erofs_gzran_builder_init error path
Date: Sat, 21 Mar 2026 11:56:04 +0530
Message-ID: <20260321062604.1905-2-newajay.11r@gmail.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <20260321062604.1905-1-newajay.11r@gmail.com>
References: <20260321062604.1905-1-newajay.11r@gmail.com>
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
X-Spamd-Result: default: False [-1.70 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2898-lists,linux-erofs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[newajay11r@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 753AF2E3A78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When inflateInit2() fails, erofs_gzran_builder_init() returns an ERR_PTR(-EFAULT)
but forgets to free the previously allocated erofs_gzran_builder struct (gb),
resulting in a memory leak.

Fix by calling free(gb) before returning the error.

Signed-off-by: Ajay Rajera <newajay.11r@gmail.com>
---
 lib/gzran.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/gzran.c b/lib/gzran.c
index dffb20a..8a01825 100644
--- a/lib/gzran.c
+++ b/lib/gzran.c
@@ -50,8 +50,10 @@ struct erofs_gzran_builder *erofs_gzran_builder_init(struct erofs_vfile *vf,
 	strm->avail_in = 0;
 	strm->next_in = Z_NULL;
 	ret = inflateInit2(strm, 47);	/* automatic zlib or gzip decoding */
-	if (ret != Z_OK)
+	if (ret != Z_OK) {
+		free(gb);
 		return ERR_PTR(-EFAULT);
+	}
 	gb->vf = vf;
 	gb->span_size = span_size;
 	gb->totout = gb->totin = 0;
-- 
2.51.0.windows.1


