Return-Path: <linux-erofs+bounces-2916-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFsuIE+5vmksYgMAu9opvQ
	(envelope-from <linux-erofs+bounces-2916-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 16:29:19 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D385F2E61A2
	for <lists+linux-erofs@lfdr.de>; Sat, 21 Mar 2026 16:29:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fdNdP2m1qz2yds;
	Sun, 22 Mar 2026 02:29:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774106953;
	cv=none; b=WmsgYskjQd+GMXvD0EgDMn/t2eCRQK1LDlEORy+Q24/eQAdDJws2JvdytqXy2NnEj6cXqfWhaBuAlL2+pbvkQqF0UEPCdyQb+UILrK8kw4Hh5Nqh+6qVwPlRO2GIQTjP/7QqVQK1scLZCby8SzIrphaays8xvgVvHYZasFMfc9NpX7LYKsx5jOlrbLkPTuXTX2QcLkQainwYwKKdZptimN02UAiqrAfw1+CybMeVtb1WzWGjlPwsK5Tj71yj/nmvQivWhAjriQR1v3LhfVBEyfYK69ITEaH1XkuDGvVE38TU8TXZ0/74vwRLMTx+2bEhqcTq+AWmSbNpktGyPXekag==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774106953; c=relaxed/relaxed;
	bh=GVPOhSh5XcT3vV0NvTgGJRUFO4J4L4qA+L26HlFyCSA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPnszsPNRiQ/jOlytfGgMcGIK6hkFHSv6zXMByYYs14PDibWSPJWZKJQZKIOw+cvqp2+VOnZ4MQm+IM+rZOIvBTtyzXwclkIPLmC86UT87cMK9BrwuYkh2v/6MNhsLKJjG5nE4UcddRW3RmxYUTHbRswiLzjzaiG0lJJGPcplcy6SBQXgcUb7TnDTWF4TktaklSyj8+QKoTiqDcAX5zcFrIQCqMuBJHxnlnBsSgJW1cGqJoXIvQId0nh9+7Xl2ekH62JVkG3ZsM+Fci5zjiIxtr+aPQodE2yHTYhBPGAVGhYqMpES6/qUbKVO6hD+gp7G6J9D9pb9tWQ1jYzKa6Mdw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NIajtk5R; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=adityakammati.workspace@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=NIajtk5R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com; envelope-from=adityakammati.workspace@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fdNdN4T31z2yC9
	for <linux-erofs@lists.ozlabs.org>; Sun, 22 Mar 2026 02:29:12 +1100 (AEDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-35bb863824fso1455054a91.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 21 Mar 2026 08:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774106950; x=1774711750; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVPOhSh5XcT3vV0NvTgGJRUFO4J4L4qA+L26HlFyCSA=;
        b=NIajtk5RzPT2OafdR838JwoK8YHPWAW6uqBDR72zmymUiEbAsv3m/ubDveTxNoezyv
         V30tz7idNOr26Kp6WUyVXPFkv++dCDbpFLbivODNOwamN6TqCoK2zdAAuwdaTfJzVrrh
         SbgnVg7bHZE9VuMJlNJ3h3ZSujZa/2IdrZ/x8WCRuHbAyJNuiFPycbXpUbmUrqoCfpOl
         5L8i17BQQI/LNBXe0iwUhSJr0Yg235GMp6PjwPJu8LZEdJGBI3PrlAIlQRAq8Nf4z93H
         sx2XvLUSUtc7bemkWH45PeuTL6+4xB6O+zTxhFjdcK8+0pvQX6/bRVAUfkTyXnZinclF
         b0Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774106950; x=1774711750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GVPOhSh5XcT3vV0NvTgGJRUFO4J4L4qA+L26HlFyCSA=;
        b=cCY+0K1PG0gzYrh0XhJ7NMZuAa80262Z7yiJZiApwpOmp0Qb7L07pVfAmJ7p91r6xp
         p8gy9fED/gs/Vmpwv/K5UuoZAugfI8Va4TPgSCoO0W7eY9hgCsYRRy8PkU21v2N1H9UA
         YJH5GvesxqsyyXGeohXP500eucYC7kQev/waubF2SrjSfcYN8KPyK/yTHaukR+FWoUs5
         Xu4OgxEXht11BkDQPdU5je6CB544j5qzjicO2MZiLrHcSWnOFC3XtXKwhh0C62NQjoxb
         sqervsst0+f3yrGz1UlcT/T+mODdSh3Q1LoT7y/b0OYiHkLGeTPVfehrvCMMvcN1PTbO
         Vx9Q==
X-Gm-Message-State: AOJu0Yw5asv5l5WW9QKdFDs8f6zCWuuEkccEaFymxoEYcMR0VTtCvb6a
	HB2UudqEgE+dS2EM/1PFVfdPkkDsngB37c3fwT4hHUnOI42gvndC1R8vt5c+GMDBHfA=
X-Gm-Gg: ATEYQzzSuf4oOGMZ5h4sYbGYCmX0mSXqP6h2h7DeI+1oAa+fscICwJGsiOBkmVF1yjG
	AxV4t60wsaooO5yMjGI1JgSxMpSv+oikTwk2gIzfwTJggfkO9d98Pcekd3SGjDu4PKif8Tf5qJB
	QQmVHq4MxZXqP8CZYt0wE5MBXWA3NOmaE/RrUQ9biGO6dkDo8ap/kicK9CBsDv+6zEbDxBBYBmD
	Gq5pMeoBEPgdM0nW+EJrxFBgp8/k+J5ZLG5UL4ynpzJh2nQclwg0dyllrXRGysZJRPWgVL69KTM
	d2dBfy6fwd4k8FzHSsnwqKLUTd7HF78vkaDVHwgjwTuOZASlSn6riySs+X10NQJdkQBhcj4S3jr
	2iJv6q6HZSRdTySg0mDG+z+zsBwX+oaprZ+p24hJChc1gjS7JjqnuP5K22fPtrQBBujEsVcgurg
	hiC4DW50TLNEUhIyLiE1IIdiWnhToRAp5inm+P4MsYIoaak2152GIqaritum19rKwsuOcL3LEd0
	HIuJceZJ42asXoOO3DqTNtG
X-Received: by 2002:a17:90b:164c:b0:35b:952c:43ae with SMTP id 98e67ed59e1d1-35bd2ba406bmr5734302a91.5.1774106950084;
        Sat, 21 Mar 2026 08:29:10 -0700 (PDT)
Received: from localhost.localdomain ([104.28.157.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35bc6017492sm8395364a91.5.2026.03.21.08.29.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Mar 2026 08:29:09 -0700 (PDT)
From: adigitX <adityakammati.workspace@gmail.com>
To: linux-erofs@lists.ozlabs.org
Cc: adigitX <adityakammati.workspace@gmail.com>
Subject: [RFC PATCH 5/5] erofs-utils: mkfs: enable diskbuf staging for manifest inputs
Date: Sat, 21 Mar 2026 20:58:32 +0530
Message-ID: <20260321152832.29735-6-adityakammati.workspace@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321152832.29735-1-adityakammati.workspace@gmail.com>
References: <20260321152832.29735-1-adityakammati.workspace@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2916-lists,linux-erofs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[adityakammatiworkspace@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D385F2E61A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

---
 mkfs/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mkfs/main.c b/mkfs/main.c
index cb2cdca..3fef5f6 100644
--- a/mkfs/main.c
+++ b/mkfs/main.c
@@ -1986,6 +1986,7 @@ int main(int argc, char **argv)
 		erofs_uuid_generate(g_sbi.uuid);
 
 	if ((source_mode == EROFS_MKFS_SOURCE_TAR && !erofstar.index_mode) ||
+	    (source_mode == EROFS_MKFS_SOURCE_MANIFEST) ||
 	    (source_mode == EROFS_MKFS_SOURCE_S3) ||
 	    (source_mode == EROFS_MKFS_SOURCE_OCI)) {
 		err = erofs_diskbuf_init(1);
-- 
2.51.0


