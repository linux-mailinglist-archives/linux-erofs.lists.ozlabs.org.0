Return-Path: <linux-erofs+bounces-155-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EB8A7F2D6
	for <lists+linux-erofs@lfdr.de>; Tue,  8 Apr 2025 04:53:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZWrJ00KnSz2ySK;
	Tue,  8 Apr 2025 12:53:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1744080831;
	cv=none; b=QJYB0z1U+dxhdHajHq3D+Zfn8ZazrTCdHhgDmucRjmtSOA//WK9nBN2E90YTXJvif7+UCy9VPiJPnJ6idPT9CsKmxk8eL9wjJ8KBf2PlsiRBNjRzdp8PON4dWFI5oj205otlsKEnzYswV8lVcOIj1HuAGrmXeSeZo5auXul1iQo9WKxbKuEG0KMJMHmu4or1eZytvwIr1N7qcLN+mYeGx3j7A3rcyjMCgGUWi6DsIVoInPRhsc1eIgFXf1l0Eep83nT5LIjI4uFywXkYsvxbnP8t+dOZ32tU4/FoAT4h+iH5lXGePWNC/YRXmwAGsZvi0Es3mJqtPxD78JPWbh0f/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1744080831; c=relaxed/relaxed;
	bh=JSnTV4PmMT7b+okjFJJLObktyI4t4Kd1JhMVGXGauQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MO1ZWt2qpOa9VniNvBcJj79Iizy37teFfDt6Mrf4lPEVVsNftuiThsm6k/XrHBCFU5lHvVLUZXlmVqMfNNiuLPbfT6fZR1OhzLZrHJZIYL+2dB2Xw5Os2gK9xmohAJqXdSSM9IqooeNty6EuIJACbIb3/SafGL/XHlA3w0RcK3TzwcPwmCMs9IUlsBp3jyVw/mgIMtmbbXwx+pwvs9BTWdfnQOMMDm52Y6TuKsFO2P9hftDYXTesFjo0idL9BYj7JoG/AuwXk84E4jHyX/tC1kMP3VjGs/IaT+Lv1ifdUuu2dEuqMMm4nweU1egSHztM4nIDt9XdMgfFuB9evTA3wA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=uMNRkQmU; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org) smtp.mailfrom=google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=uMNRkQmU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZWrHy0pP4z2yGZ
	for <linux-erofs@lists.ozlabs.org>; Tue,  8 Apr 2025 12:53:49 +1000 (AEST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-ac345bd8e13so846863566b.0
        for <linux-erofs@lists.ozlabs.org>; Mon, 07 Apr 2025 19:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744080823; x=1744685623; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JSnTV4PmMT7b+okjFJJLObktyI4t4Kd1JhMVGXGauQI=;
        b=uMNRkQmUKrcJu6n5SYObgDOIacS7xSKfSTJEVhcAxisQ+Zb7fUGLroGLODfMCXEbuO
         f1yGfgmeOgl9+qUnp+IwNAGYr00Jzynd71P9Pr8VbuzqVFt5yaQ9lxy0klt6CWO5AAD6
         IGmx+mpoucylqfh58fII5c8FzasEmddA5dH3+JogKEiCfIrCUGpLG0aXXW6Tuxzzw6kA
         DW9/K37p8hbnDLL3w7GUmGmlg7UAGmQ5nDrFnUWmoDugPBGNvKhPK/xaYavg1uM9185F
         NtB6FNvNavwk4U0FBvJCSeBnOAYMkw/4BZp8Lue5FpX5BEMO6kXfEkQqhegylQ8FeiZZ
         U93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744080823; x=1744685623;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JSnTV4PmMT7b+okjFJJLObktyI4t4Kd1JhMVGXGauQI=;
        b=WUNDTaQ5IsSLvf2/QuJXcM/1kXPS0oa8R9gndAQ887kgXqTMvdV9wfo2TF12MgqbUk
         lapVGk5hQ45Et/+ddx1vfUicknxQrasYeYl596Qm3QFAhLDFbXWLgritpKBZtReHFd1D
         cCCe1a2tXq7f/RFlrOzO4BDdJs7E4aiOTYpcqopSDRi/vNIDY608aN1OS++zsUeH6syg
         wvN66garZQBKaoR0PcveTSKFP93zTj5GcCZRhzmvT35IMza1ZRy+R9bbKEeL41bVqa1h
         m/OJrMDn9jAl3bk27G+IO9JyErOaHlbqx6Wk4Mwj9rKax318sIz+WVm9nsb4MTPeGYbW
         w9Fw==
X-Gm-Message-State: AOJu0YzqzuyHNw6cLsPD2eF6yFAx5syBkHN+Xe7CoXCWtJw47fyU4RFM
	q9ZZ5/qWJGa+tfnAnyXCoZzxzMCoCZOGAJjnIhFNeEqUW03OrYGI/wR+Cuzjklp1AtE6CkzXKrM
	4nFMhKftoFtBmvMxoJSvIKIHt7/zdgdU6kYT42hENsN/wrghJJA==
X-Gm-Gg: ASbGncuBj8CyklIAcMKuUx+Doc0+uRHpf47l1HrqlEszDxYpjf9TB79pYUcUlA++VBl
	S0HkygIlFXiT1LevJvastmPJxpgucskNojaw0s8/PJP21xVkgDMYIL/F5Ia3JLsJ6Arc8JooZGK
	0ucgUHrhQQoeumuil/Z1u2Bw==
X-Google-Smtp-Source: AGHT+IHlcqYNcX8B0/Zx2AdzDvmOwtgNyjDp1ePH/T4zUMJaUxzHPwxKSgSniNlHyTwL30urRwEANvNnHX51MtR0z+Y=
X-Received: by 2002:a17:907:7d86:b0:ac4:5f1:a129 with SMTP id
 a640c23a62f3a-ac7e720cb38mr1042124066b.15.1744080823170; Mon, 07 Apr 2025
 19:53:43 -0700 (PDT)
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
References: <20250402202728.2157627-1-dhavale@google.com>
In-Reply-To: <20250402202728.2157627-1-dhavale@google.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Mon, 7 Apr 2025 19:53:32 -0700
X-Gm-Features: ATxdqUFEJuSyV6HyEV28vR135wtROOrYXjKc0PsrH0NPUtiodTsokitMORsBsAo
Message-ID: <CAB=BE-TzPKSsHo_nvMuGkB_4JbbP8OZ81ce=76y-28nAeZiniQ@mail.gmail.com>
Subject: Re: [PATCH v2] erofs: lazily initialize per-CPU workers and CPU
 hotplug hooks
To: linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>
Cc: hsiangkao@linux.alibaba.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-16.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi,
Gentle ping for review in case this slipped through the list.

Thanks,
Sandeep.

