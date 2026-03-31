Return-Path: <linux-erofs+bounces-3135-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMNCMaRDy2l+FAYAu9opvQ
	(envelope-from <linux-erofs+bounces-3135-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 05:46:44 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A23363BDC
	for <lists+linux-erofs@lfdr.de>; Tue, 31 Mar 2026 05:46:43 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flDZ911skz2ybQ;
	Tue, 31 Mar 2026 14:46:41 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774928801;
	cv=none; b=gthiJ0/05WiSCc9IizabKHrFVSJIKV7YfStwy2iNohy4067Z5qACHC24MMUAyO9xzqj4iHx63k92X/UC0LrGOHcRWMcAewaKtuteZ9PJO5fbQr+yOLP+bAthU+/h0UYg7aLwAQqUtUxuOcuApAEUvI8aA6N/O2GD2qGZwocsPZfF0jPOED6sppNQmRt3f0ZVDJ1jbI0Hqs9R64IxZZmZr1FdEeaoE9oaRw8KmSr1mi4mRfDFP+pOTmp8BlWCElsN+18qwYzXNlqJ5hLvVrqAea13FN842LIeZXdCDH2Z1hxQ3MXxJq/NCa0kAihzg2qJMprsamSKrSef0woEgAi1XA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774928801; c=relaxed/relaxed;
	bh=zy4AmIm0yN4RililkSbv6Ow12X9TuxGtqsseDxGhsIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B42cDHrYgwmcYsiFx4CzYvSCfqsJddkqBQtyPTZv9TxJKM3KTZoe4uPQwMNV6dTbDYujAq5t3KKP4LGxMsUuQ2Ue1uNq5gRxYEn9x/1J7N0f63qVkDMlf5WG0RvMSSf0hSNVjLB7RXgQo98vW1N5lJXUyBOsBOTVvfm7FEU9EWD1uMkUw7/Nxv6ynJx9UjRd6H3EOlShozo2GXDsfUR2wiVhwpap8EIOflrQjOV0VekwSW0tI6GAsfdM1RZ6uT0gSDBZ6rD03iN8d5vKA5Scx2zJJbBqF5Ml/2jlVGAm+Bn78fixNgIxSvGUJ8qhXhnI5+QPK24K91EolBT9dEb8wA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sN2PPho0; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sN2PPho0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42c; helo=mail-pf1-x42c.google.com; envelope-from=zhanxusheng1024@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flDZ81SVHz2xlK
	for <linux-erofs@lists.ozlabs.org>; Tue, 31 Mar 2026 14:46:39 +1100 (AEDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-82cd5c07f93so256858b3a.1
        for <linux-erofs@lists.ozlabs.org>; Mon, 30 Mar 2026 20:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774928797; x=1775533597; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zy4AmIm0yN4RililkSbv6Ow12X9TuxGtqsseDxGhsIo=;
        b=sN2PPho0HeHLr69JrbCG6NgomDe4MO784arQOAkk46VWi20qS6aiwTOVljejKBmqwS
         +maKXLVgAsZJXZgAcMHLzRVkFhgaijjLI20o/MrRD6bRMDkPQTWDfjw0aP9ofTOy9jNi
         ACAtFwl/JTmLjjm5p2MKNzWGDDZ9ZLme5UlJdS20DULu9HkUCX3ybIXU8nJLYA3n+mFb
         TCkWp3p6ExfuJJ9/tK6m5AjQnLZV+89ZhLy84jilXdoB1hkiGXprTrrzYtVsUP0NaIDQ
         4ciclewLhnVbN50v55hPThwScfxxRMxsDjj5mT9EY6AIo7HQ+HqEk6npumS3WrWglVcd
         Bmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774928797; x=1775533597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zy4AmIm0yN4RililkSbv6Ow12X9TuxGtqsseDxGhsIo=;
        b=YmRCbC/0IdDYxlV05BfgB+RIVHzYQpCrmkBR2kARg5kkmAIQqKjg27ZIXE64/q2TIZ
         OkAN6DM3nPQJsFKIYpWZn5mfVXJ8G/IWMzLh0JYHZqMar6TaxMaLR7FYVLl94vuGZz/k
         KzY/78WLgfazdVcD9rv3bRHaqkKR425hJ5OC1OZkgpTDVflxL9dvAqv3wagW+ydFixiN
         kHJFpAUTTfvmV2tKJoA3SNDGty3/cMDOmjYOqzbK8p2fmWbU1LeIzr9ifRT49mYL0Ioi
         r2Kpml0HUH3X81UZnkcEbusqr0mcs1K+Bb4y0rCWWG4yN/aezqwf/Aosm0qXUCMIfksH
         fE6w==
X-Forwarded-Encrypted: i=1; AJvYcCX8MtxgUHUrBzKPzk7kaqeegYIewXdw2V2C/5zHxd07CUxYnXa9lSkY1WfPnnqyKcu0NY+r/eq3wok1xQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzxCLkGSLLzxwARz2cY+ptqJ4kd8+19DiMVzjqN23nb/L9GQlI3
	a8yx2OMRUt8xDQzzcRaOyc5k06XNDTd50yJnHTx5Ab09dPBslHuJeOWf
X-Gm-Gg: ATEYQzxkMiUHRwL+xFcezzXMCbZfnvhN8mdRQEtIUpcpZnffnQiCiXqhrVkBCvABY8V
	YkjYPNAJFe63P3yvGpGXaxBKQhNaMCsk5MxWl2ID3zjIvBJN1GD1Um6h9S8QFbqhAMWJ+Y5qx8R
	wuvo6jRV9ltLjkD3QNa/VoZ8fplKvbnb1ly3bz6SKqBiC8hHrM06bQoyN8B/T1ACiSAE9EkV6bp
	lvspsMByEXslJD6Px88TSzNh001Eh1XUxqo0LVuxmwJBzGWzPq2swkWn1ngKOFDyf88nsXUOny4
	8OlSmvGDGlob9xbUfBenZ4qHhdsnWZZDAs6eiCA+0Q0wBKj8A5o7obt1FoP9asVSUD8AY6zqdXy
	NSsbQsokMWsN47JeoJqX1uwTwkh6hNO3Rzfc+scByfyxP/diIu8VvoOq+a3bW2DdehGw+auNFMP
	DVXlFeZ3Q8PShiWCdNMKX9lZ6MrU29Umy9jkjj7e6B02XDeiY=
X-Received: by 2002:a05:6a00:1ac8:b0:82a:5ef0:210b with SMTP id d2e1a72fcca58-82c95e8804cmr14266081b3a.15.1774928797010;
        Mon, 30 Mar 2026 20:46:37 -0700 (PDT)
Received: from DESKTOP-MOQC9AF.mioffice.cn ([43.224.245.237])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82caf5408efsm7894067b3a.2.2026.03.30.20.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 20:46:36 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Gao Xiang <xiang@kernel.org>
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>,
	linux-erofs@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	Zhan Xusheng <zhanxusheng@xiaomi.com>
Subject: [PATCH] [PATCH v2] erofs: fix missing folio_unlock causing lock imbalance
Date: Tue, 31 Mar 2026 11:46:31 +0800
Message-ID: <20260331034631.21945-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260331033300.21366-1-zhanxusheng@xiaomi.com>
References: <20260331033300.21366-1-zhanxusheng@xiaomi.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:xiang@kernel.org,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:zhanxusheng@xiaomi.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3135-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhanxusheng1024@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,xiaomi.com:email,xiaomi.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: D3A23363BDC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

folio_trylock() in erofs_try_to_free_all_cached_folios() may
successfully acquire the folio lock, but the subsequent check
for erofs_folio_is_managed() can skip unlocking when the folio
is not managed by EROFS.

As Gao Xiang pointed out, this condition should not happen in
practice because compressed_bvecs[] only holds valid cached folios
at this point — any non-managed folio would have already been
detached by z_erofs_cache_release_folio() under folio lock.

Fix this by adding DBG_BUGON() to catch unexpected folios
and ensure folio_unlock() is always called.

Suggested-by: Gao Xiang <hsiangkao@linux.alibaba.com>
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/erofs/zdata.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index fe8121df9ef2..b566996a0d1a 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -605,8 +605,7 @@ static int erofs_try_to_free_all_cached_folios(struct erofs_sb_info *sbi,
 			if (!folio_trylock(folio))
 				return -EBUSY;
 
-			if (!erofs_folio_is_managed(sbi, folio))
-				continue;
+			DBG_BUGON(!erofs_folio_is_managed(sbi, folio));
 			pcl->compressed_bvecs[i].page = NULL;
 			folio_detach_private(folio);
 			folio_unlock(folio);
-- 
2.43.0


