Return-Path: <linux-erofs+bounces-216-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 928A3A97DAF
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Apr 2025 06:03:41 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Zj57X0f9fz2yMD;
	Wed, 23 Apr 2025 14:03:36 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745381016;
	cv=none; b=XFqrEdn2WuI38yKqe8qiF3HmfIQd/UVGXk0D/e03+h2hAPhcY4yirrNp5b4EvXzomNBH3lkdG209nxPGD6APyWZ2vMwMbPkwsRypaEo6qaAtyThYJcLi98MCnN5czmg/u44H6QNhhp3FhXCB7ZYmehyv9ILE5ia5QW1BUMftE/dgDYENC0TVWq0owMIF0/7P0ia1PXGUHewtc0sh0IbuURUJe21zve4fbQ92cnGpdRLxjR+vNdRGcUvME93HPS+X8nmkoqZjWypgXqyszRk//ZoHVAmmJ00HP9zPu1zNwiByw4zZQQFKZkgCT0SYNiORO0Ydg5DkRMAXEybKPMUPPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745381016; c=relaxed/relaxed;
	bh=sEsKAWQ6ercVp7cRPavLEhhmptGGRcHOf5HhMke53qU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcZM5KjBTYy10rN51aDOrNBFlj736qLO4JTQrK0veziYeDteNDoq3ErJVsy/ye/sNBGzb60gogb2Jt/0665QU6En6au2XXUyHlvcQGdd0dB7jdP9MJFLdRA8+4mW3k6UDQoO5PnZl8WUQx0udB0BGgMc5e0MjVezb83OFm3zWOVUiY979jYDKwjBL6TTnwIGfyoogRHsp5xJAVQbCWrHgMwA7dqoh0jQBq0/edACHziR2ilmHJD7P75qfiFrVB5v6XZgcAh8tO5keuGvcFS1aEFtpAWf/wW8kz+Tu1Otz/f0YGsyBdElP6RAITyjKANaBzB2IfmMA8/XQRKhFy36/A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=t9yA1Q9e; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=t9yA1Q9e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::633; helo=mail-ej1-x633.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Zj57V3rVFz2xlK
	for <linux-erofs@lists.ozlabs.org>; Wed, 23 Apr 2025 14:03:34 +1000 (AEST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-ac6ed4ab410so849716166b.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 22 Apr 2025 21:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745381009; x=1745985809; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sEsKAWQ6ercVp7cRPavLEhhmptGGRcHOf5HhMke53qU=;
        b=t9yA1Q9eGTBG19mp+xdb2oX3IuOvB2fVv2KtPnwROAuPCR2iqCWxio1x4XmbZqCIU4
         b28jIIERa6MiZAURCU1c5TSOJthz7tn/yzqKBd6qP1lVe4cLgjSvrgVUgHyDldyeELav
         2MroA1VnjLwmFX1LS7AZxsCqnR/Pk7DsgEj8pMVpO3wOp4rFxHF97uHKQpqK3nLThqUB
         NpPi/rsZWPoyUgLyodr2exwiQIaYP8SIytA39Pib7KjDerb47Nt7WOa7BOnUya4VyZdw
         NDNVOkaI0ETjquZM4O7MFHTV1MTxlyGaryK5UbCPv1qboqjEfPx9k9rNes5Fy4Vd7pqH
         6sYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745381009; x=1745985809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sEsKAWQ6ercVp7cRPavLEhhmptGGRcHOf5HhMke53qU=;
        b=F0boherZVKSCd7rCkIOG6yfmLZqQLP77bCYueSCPZSvz1VxtoYT2D3eJ1jXXgQUnGM
         +IutnMxnVG1UDTXcB52U9cF8u/K1V3a5ShaQWCwJ9JWmzGmneZ18B8IybwgzNyCMCZGX
         Im56LTNOo1v9xLbcXEFmoQ4GhozJQUI8FBcDc0UHeKkwFp1NAEfxx0u0PirDPJLhmRDi
         DNK6UhMVDbX1P4rw1csk7u4JZUbZTd2kAhnK7me9Zafv2wIAc5bhTmz0gmFuOfxEspGI
         Uarw7lpldOGS9kjFP+NNXZIaJiaDedr0by02fXtUsAiS4Mwz+eJcgEMSqo5pGWk14i1n
         Vpfw==
X-Gm-Message-State: AOJu0YymNpTviAd++6bvvtgy5Tx+vUX90Jp4Bn/yezjvtXgYkRW/vnwN
	SzxN/yAzE3LTqSacRI9qQ84jcldoJcr89ZvnPvcwATz6v8188gAQVEuiKDI7978jfsWBhGTfOL2
	E4yxutxoilqRCSU0RD/LosnWFDVv99p0BNAmz
X-Gm-Gg: ASbGncv+CcC5HHgn0RnhxGds4ec+AV/xtv2A58vwAnfeSmonH5nX575e8d/JlvJTwwF
	++1XwCTdFTwebVsPe/KodQTDky/4Oil9eNG9Mgrmp3hsjBnhygg+2zG8IqknmZ5PdIPbDF/4cX8
	lhc3DlzWSZs37E5iEaBQ==
X-Google-Smtp-Source: AGHT+IG2hQRFHZCruzqyHNTCSbKVoad8NGLwftg2olIH1TLMgSCl8qIOGnRYXmKp4b5vplSlTZlrkgmHAZm0Twr2M5g=
X-Received: by 2002:a17:907:3d8e:b0:ac4:76e:cdc1 with SMTP id
 a640c23a62f3a-acb74b372bfmr1197543566b.21.1745381009127; Tue, 22 Apr 2025
 21:03:29 -0700 (PDT)
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
MIME-Version: 1.0
References: <20250422234546.2932092-1-dhavale@google.com> <7a433a6f-4c35-493c-94a7-0f925ed52230@linux.alibaba.com>
In-Reply-To: <7a433a6f-4c35-493c-94a7-0f925ed52230@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Tue, 22 Apr 2025 21:03:16 -0700
X-Gm-Features: ATxdqUHNIzFZtPoi0_hhnWqVp_TxLrcGudCIAQBWCUwpvzJUhD5KEx4TBUdlXqc
Message-ID: <CAB=BE-QXYR-3-Jtfk8WpLRM6xus5Vo5Xja=sJgQbDpraOnUyNA@mail.gmail.com>
Subject: Re: [PATCH v3] erofs: lazily initialize per-CPU workers and CPU
 hotplug hooks
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Gao,
Thanks for the review, I will work on v4 to address remaining items.

-Sandeep.

