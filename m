Return-Path: <linux-erofs+bounces-250-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B58A9FC8D
	for <lists+linux-erofs@lfdr.de>; Mon, 28 Apr 2025 23:49:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZmcYM41G4z2yyJ;
	Tue, 29 Apr 2025 07:49:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745876983;
	cv=none; b=GKjCo7TRcEv36c5YtlkqZ2jsx/7YTFzP1NMGV2mu5gFYu19uEOwH458iBCnLHC3Rjabii6eZKMRTcJ5ZsS03sQWsQ349T0t7WAN/x9Az4Sp5BYlIWzjF5K30Rr4SHzLLiUUL2yRbntAm4zj0AhM8owkfRja4pMPUuRRzXeFd9ay1bECuKsovULIfOMLI6/EHjU9GYsmOcRt9KJszwhnTG9AHS6JzTpisuS4tuCZFjY0AKalJoZzvj+MffudK0ZFVMB+S/bz/sl8gfmGdMK2DIglhcWoAinDo5MyE9GIpQhPID5OLYB3QRA0MbRCw8Ok6zcLLgV2XtWxaVudmGpLApQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745876983; c=relaxed/relaxed;
	bh=+X7+Sy3CmnHgJcf9KaxAsnYxZIlm7xiKcJg4Tb8SkUk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cbdisyYDLsdciZSM2NLRaiYmPB+YX8RFnUffM90YnmXN4P8gKf0v4kT23ExC0bat/KE1+VZMCbHp9ypbXCQCxwzr/uz0UTWN186AFRQrsd4LVeKaxtsr+11ZQb1T3301pk8OnI94voyV9mjX7cctT6unRdo2sDmzYKMKclQdndhJIqbNjirpXrXXlihhq7YL8fkP8GohNOkqWtHl6XggWSJt4mc102QKYvJ/zjkw/EbozjGehpKj59rxY5pQC0J8nGxZNm0GdRKQLEy/JlTysPiJSiV0xaJfhe1kqbePBMp2Ao+u0vhEbKtK8Cg0OENT3/nn4rLL2eCBgjwMMijbGQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=kP6Ko9i+; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=kP6Ko9i+;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::62a; helo=mail-ej1-x62a.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZmcYK62qBz2ywC
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 07:49:41 +1000 (AEST)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-ac2c663a3daso1045916466b.2
        for <linux-erofs@lists.ozlabs.org>; Mon, 28 Apr 2025 14:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745876977; x=1746481777; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+X7+Sy3CmnHgJcf9KaxAsnYxZIlm7xiKcJg4Tb8SkUk=;
        b=kP6Ko9i+Dfd2cL/HjUV1hNUTcrOl17EI4O+yoUCk0NomoF20BtDXf/ItHE7iWcfgkH
         5LbICRuwXI8bgSOqlCc27ug3o5DvwrtwiJY/JojYICbirz1XiKwM4XvlO2+PdlGyKaLg
         t7mwtaHBsq9sjFOZPkf406WJnToTZ3M6FKPABSzA16JHiMlOvACCKVkRsnVQQulcoTrH
         3M/qvTYazJ397sN2q8/ICDbmer2/W8VB0tGjy9NqsRHKKYernuLkZ8Ma9GD0+k9OPQI8
         JBjy5JavAYqPNVYSUa8RYHeOtWLO5+RJe5/VX95P7Qxq097qLzr8MVjvFjNB9Lm7s4Hb
         6jGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745876977; x=1746481777;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+X7+Sy3CmnHgJcf9KaxAsnYxZIlm7xiKcJg4Tb8SkUk=;
        b=oc9Gvgi5bWSxqtsUF3PWh6zUyiaZ2Z/zSG6PBXbggr/4lmAzTI8T5wwUp5AlGFq3Mr
         noOi7N3IdiO82g8avmVEheBrAp3AhiLt+YQnDEXAV7qUTxrWLLY7m22le6b7KyAipdWT
         HPGWOQMaH5Hk5zaem8WRW4BcJKaSAP1omElvpTwWoSBxFbISzJubdqy58eKu0POL+jKO
         gfT839JwaTn+6zoD3rzHPRnzrGUHqHjGuZn+LyZFmRF37Zp/p1wDQznJkjS8pLVarX4p
         ApQTt+gz5M8XVgl/4umkcVnAIhN09YN60SdpU0/pxnwB7UoIDaX7nywBY7cpFXZ/MahV
         RRIQ==
X-Gm-Message-State: AOJu0YydAyC0VYeHhaDS//VDu8ZeSgmWo6bjmVgbk8FMCU2slWdwTrSp
	+RahxyST8dP2ioKuDkYMLSbGp4bmhw+OsAODLlRXEU2Ky4+r7GQlj2H0N6xBxh0idlmLJD4dcfJ
	lDHllbYJVqZoIJyiufjj9W0gcXEUFNGUgZXGi
X-Gm-Gg: ASbGncuuAMklOZemDx9XIuN0R42rUElYcFGm2zXbAlBh6+rUvdNEdCvR6tN7pXxMAko
	gaN/4VuB4AS7Y4vi21QCXQIQT134f/1w4WAcx8fiyeYhRjqur3JOrTvzQPNXd7FijRD6visRYfY
	cBlHX3bKPL43JGt++U7GQenGIAoDYHkRFrUC9PoIYb/8/c3r9U8eEo
X-Google-Smtp-Source: AGHT+IEhiL11RcDgB5cdm/WKbBzF4reBDVGF/eKqJBGAFN4+OR+rR4wotFOAWpQCpwoRviJDtI5D1kPWUosQ4mYyNnQ=
X-Received: by 2002:a17:907:9495:b0:ace:6882:510d with SMTP id
 a640c23a62f3a-ace848f79d2mr984974166b.24.1745876976648; Mon, 28 Apr 2025
 14:49:36 -0700 (PDT)
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
References: <20250423061023.131354-1-dhavale@google.com> <894ca2d3-e680-4395-9887-2b6060fc8096@kernel.org>
In-Reply-To: <894ca2d3-e680-4395-9887-2b6060fc8096@kernel.org>
From: Sandeep Dhavale <dhavale@google.com>
Date: Mon, 28 Apr 2025 14:49:25 -0700
X-Gm-Features: ATxdqUFDtwc5SK3EYtcYAuQ_6XyuzSDvFJe-PtDs8peDgGVgf_ScKK1LcKd9hxc
Message-ID: <CAB=BE-Ru31S1Qq0Gmi9UXtaL6k4dcLdTUa-CJbmhuXb7a2dSeQ@mail.gmail.com>
Subject: Re: [PATCH v4] erofs: lazily initialize per-CPU workers and CPU
 hotplug hooks
To: Chao Yu <chao@kernel.org>
Cc: linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>, 
	hsiangkao@linux.alibaba.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Chao,

>
> - mount #1                              - mount #2
>  - z_erofs_init_pcpu_workers
>   - atomic_xchg(, 1)
>                                          - z_erofs_init_pcpu_workers
>                                           - atomic_xchg(, 1)
>                                           : return 0 since atomic variable is 1
>                                           it will run w/o percpu workers and hotplug
>   : update atomic variable to 1
>   - erofs_init_percpu_workers
>   : fail
>   - atomic_set(, 0)
>   : update atomic variable to 0 & fail the mount
>
> Can we add some logs to show we succeed/fail to initialize workers or
> hotplugs? As for mount #2, it expects it will run w/ them, but finally
> it may not. So we'd better have a simple way to know?
>
> Thanks,
>
What you have laid out as race, indeed can happen if
erofs_init_percpu_workers() fails with ENOMEM. For me that is still
not catastrophic as workqueue fallback is in place so the filesystem
is still functional.  And at the next mount, the logic will be
reattempted as the atomic variable is reset to 0 after failure.

If you still think we need to have a log message, I will be happy to
spin up the next revision with logging for ENOMEM.

Thanks for the review!

Regards,
Sandeep.

