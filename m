Return-Path: <linux-erofs+bounces-3559-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GtPOMEvaJ2qP3QIAu9opvQ
	(envelope-from <linux-erofs+bounces-3559-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Tue, 09 Jun 2026 11:18:03 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 476E465E37E
	for <lists+linux-erofs@lfdr.de>; Tue, 09 Jun 2026 11:18:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=bCJF0ktj;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3559-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 112.213.38.117 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3559-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("lists.ozlabs.org:s=201707:i=1")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gZNc64bLPz2y8p;
	Tue, 09 Jun 2026 19:17:58 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780996678;
	cv=none; b=g86+OXCgp4SfHoWAhDQB1tQwJKc5lndVR07rTXk1V1LULnZRQsVbeJYKv9112CoxZtpXtJ5Hspqco6lGZ0CsVMi+gkMCToBhLtsuT31aELQ0gZGEe9iFLZgDIs53o1UzUiurNUb9vm+DxOgrBQr4pdLvIIDD0NDz1hZmDYAgCbKLq6HbZBjoEuZUf54cc6ZkE4WxmMyZcN605w73Qg9GmX8tUJYo6MPrgo0CmlhFVfxmmlgqDAoziE4ok3ldCgnFReyFusO0yK9r4KOKwhJdzZZfSeWnKZ2/ojttVHDCiKl1LQ80V6MfGjr24X0ZWfGoG6ZyayNOsNS4w4mc6y6aHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780996678; c=relaxed/relaxed;
	bh=4zasA4brykBXeIOyPX6L0V0dN/xUqhjVDO1IW22WDWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BaGLzqmROwfnjcmyy1+s/oNL9m0i90xjlxzIOnhMKkHgFgz39Rv3NN1+1iky4NRhMludtjtBuL8uMh5IsSegxJYr09hjixa8xzjOhDCzDJjHl5sgHaP2p9dANOPDozTwEJrTK36GTcXsLwXXaVzPqPO4/ndIQasICu0+zlT/YwHo41EIYbyFfmJwhyTSx1Bqq5Ml7M5sKZrwHNa3u/y3OOnXED5AAMayjWXD8qf1yOU8Nn0jdUg512tle2V49n2bD08MYtPTOHTYOV0fjAh6EsEcHZWLx4GRq9Mpm2dT6MiaUBL1aun8vCNR4BhZlyk27hjseqmq648GhkXbUFvpRg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bCJF0ktj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=nithurshen.dev@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gZNc55q21z2xM7
	for <linux-erofs@lists.ozlabs.org>; Tue, 09 Jun 2026 19:17:56 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2c0a5354da1so42921755ad.0
        for <linux-erofs@lists.ozlabs.org>; Tue, 09 Jun 2026 02:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780996674; x=1781601474; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zasA4brykBXeIOyPX6L0V0dN/xUqhjVDO1IW22WDWc=;
        b=bCJF0ktjfcT/vg3HQaso4oGssqs1wwtZluP/syK1pcR6tAtMEbtKBTc9nftYblAr7u
         qSUcVEoDqUvJhCgwb15BFGSyUin30EK55dH501cXa0+80F5HZ1+sJBZgV9k6Mu+eqQNA
         e4C/fYSaaqiktaDzMbq/0YN/r4+UYwA3Xh6BNPDEiSyRqngQau4u+Y6hjAhRLFe/lNxO
         iWg56WVv68Wo0DnI8oriM83oqWipuXcdVfnp/nrxU9DAm0iEL72bevUqQVgq1dyZTe/g
         /9pOvckxiNJw6kevIlsedfPgjCLPi/t2Imzz522AlJOkgRaF+VcPDOI/kT/Z9EhFwmCe
         tOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780996674; x=1781601474;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4zasA4brykBXeIOyPX6L0V0dN/xUqhjVDO1IW22WDWc=;
        b=rJi9Oe0nTKSMvZuBSAhthswMcljOGOvz320TjS/3f7GNhVpyJmm/K7vZ03qpIzSo97
         MztNyE2I49MrxmexHSPKo9HQ0U5nLhGCdzxLaDqXnV52o4xcz295pt97WgtVjRLPihiq
         RvnACKqRCOM/nxE65NuYffTlO4k7xS9tS16kmub+3GFiIPW1sp11uR8GiF1tFzrAlZzH
         QcN2DaAdYMPuq6a04uFWfB8CFNe/9QmCUPA889kSa6DxhKKFfJp25qJt18dUVBxvtY15
         2x/DF/ydi/S/2FFU49UFY9ST94KSNq9J2rx+axGhQ4RwX7XzbKlsHlRIyIPZ1SpR5MKe
         eeqw==
X-Forwarded-Encrypted: i=1; AFNElJ/hLDK0bbIIULfTpNHAJLkda4VwFxZhzNupCBqQAu9+UpmVSfs9P1XMHvHSKDFo6lL5eyiNm2kCmxSSKA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzYaB6hRsxJMIINjqm5ulrXHelgZLrkTip/Fco+SjsH992mA3Aa
	dMMJIqG540C/WemlkYwAVH4G20xQK6niSC6xVWAhsjjuzm84yuRcPmYH
X-Gm-Gg: Acq92OFIfuaMzVZ2J7X2jlqSOJjSYzMgyGiUMVBAqgcmOm2Fqlc46zcGm6I0SgacpsV
	RrfHWuqf6tYozw+nzHeJrhQDrt4w0+xYY/xjGS5bAyKCZp17LE2aEfDAHOfZM/a36Tb3TVLk3l4
	Fe7QfQwQ17pRjDlbxi2n3dXn/EUDmfOn3OD8YJ+N+aJzf2pcwjABdo6CjzLfKPPqTSRo9fB7Nzr
	T8b5HSuUw2FfKj61YlqWLY7BJIJhF75EywjozP7iODLSCcK1lo6T86CG/1Xb9xUsa81q4R9N8wr
	pCAK7/TpBIOAMNmyTLyW+yjzseuTWgoRPLjqzvrkwqAV028bMepfkN2m1duvD2+CV+hxlq2GfcH
	hme+0131P4KD6r7aVnglpO4Brm+y0XMUOgB832fgfc/TNZfMUVTsnNEbX01T1EsSh5dbqF1JYab
	nOUQyEovUrVVNyO6frTDVocprPcaErx0FoEOaJB6YVP1t22z41fkBbat2jylq5UejEj1pw/GIEH
	eJy
X-Received: by 2002:a17:903:1a8d:b0:2bd:73f4:8e4f with SMTP id d9443c01a7336-2c1eb74774dmr160023775ad.0.1780996673793;
        Tue, 09 Jun 2026 02:17:53 -0700 (PDT)
Received: from localhost.localdomain ([157.15.11.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e2e2sm201467005ad.49.2026.06.09.02.17.51
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 09 Jun 2026 02:17:53 -0700 (PDT)
From: Nithurshen <nithurshen.dev@gmail.com>
To: nithurshen.dev@gmail.com
Cc: hsiangkao@linux.alibaba.com,
	linux-erofs@lists.ozlabs.org,
	xiang@kernel.org
Subject: [PATCH v3 0/2] fsck.erofs: add multi-threaded decompression
Date: Tue,  9 Jun 2026 14:47:41 +0530
Message-ID: <20260609091743.71420-1-nithurshen.dev@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260523003757.13078-1-nithurshen.dev@gmail.com>
References: <20260523003757.13078-1-nithurshen.dev@gmail.com>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.20 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-3559-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nithurshen.dev@gmail.com,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:nithurshendev@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nithurshendev@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,lists.ozlabs.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 476E465E37E

Hi Xiang,

Thank you for the detailed review of v2. I have addressed all the structural
and style comments in this v3 series:

1. Extracted erofs_cond_t wrappers into a separate include/erofs/cond.h.
2. Replaced sysconf() with erofs_get_available_processors().
3. Refactored the parallel arrays in the decompression task into a clean 
   struct z_erofs_decompress_item array for better memory layout.
4. Fixed all indentation (enforced tabs) and single-statement conditionals/gotos.

This series introduces multi-threaded decompression to fsck.erofs to
decouple I/O from decompression, significantly improving extraction
throughput on multicore systems.

Thanks,
Nithurshen

Nithurshen (2):
  fsck.erofs: introduce multi-threaded decompression with static
    batching
  fsck.erofs: implement algorithm-aware pcluster batching

 fsck/main.c              | 150 ++++++++++++---------------
 include/erofs/cond.h     |  31 ++++++
 include/erofs/internal.h |  20 +++-
 include/erofs/lock.h     |   3 +
 lib/data.c               | 216 +++++++++++++++++++++++++++++----------
 5 files changed, 277 insertions(+), 143 deletions(-)
 create mode 100644 include/erofs/cond.h

-- 
2.52.0


