Return-Path: <linux-erofs+bounces-259-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id BA10EAA025D
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Apr 2025 08:06:03 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZmqZ040K2z305n;
	Tue, 29 Apr 2025 16:06:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=139.178.84.217
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1745906760;
	cv=none; b=oElLQdsm7hyMJwtChaa3wgsvr8O9E7qajHQ63YeTeWm2Fa4iqWp9Wp3ZyTrHy8F4WSghGx1s5reQXBZfaUMgWNPPp/RonIxGc/vIUP891COv/sXNrhyM8M2N+gZnTbqyMD1MV+B1D5cor08/Kfi5eu2wsVSu0qsPOHlc4FHyOkYvIMXT9dKbDKF6lAZWN/Sukzqu0WSERKl/qoEZF5kCEneNpQxpTCBiu+w8TgjPecn4vkEBTwCwBmJJ4LYqkT/9+ypN6XGlGHIFbfVKtbsel6KlEWdwOvLd740WnXs/g39ulVC8GwbKJjWsJ6jsKQkIahXavo5CATpZ3PaknrtTEw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1745906760; c=relaxed/relaxed;
	bh=iXFcMGqQ/CaGrnhIj8vz7T2gg2HN8WLIqcbEuKJwQis=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oGzkyxyxTe0ETiuE/jFY6vrOaiHAvL4WHQv4hS2heqi+8hFkVf84vqBLy71vCcflpkFHyqgiJL+S4bZ6a2ZKqV+LdTCqTT2Ofgik55LY+tMXMyM9/8ZQGaYku9Rf3dVZbur+ySq1PLxRsOQCNf7Rl9R/gxSyeKPt8Vjp1z4FEGqHnV2CqTvwdPI+qsniEhpyEGapD2d27GC4WidZafO2ictDOnXGs4n/p1s3Dt/lgNVDif9qCvwYSVmDJ8cKbyiLaL4zs3iQ+aHWwN52YS0Ok8X0AkyZEkF4KmyOKDe7+/4GN00coSpJnevv+5oNQkLJ/pp3VvpjcZEs2U/b+c41IQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rjVmOTkn; dkim-atps=neutral; spf=pass (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=rjVmOTkn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZmqYz5MH0z305P
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Apr 2025 16:05:59 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6D4815C3A69;
	Tue, 29 Apr 2025 06:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A861BC4CEE3;
	Tue, 29 Apr 2025 06:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745906757;
	bh=osey/MsMTgZ5rcmu+YckxKbf+eT/klV73D3B34U5ERw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=rjVmOTknBYqZDyu4xqC3gzzRqAGU8STvlr8+VcbXcFQ4a15jcCELyRv2Odzws/AOR
	 j0L2DX8DpFvxGEKP+G2eSOQGqKx4isFxzv/aDaSjAerMwIVJSCjEgl2JibiRCr6zmw
	 hm9zXms6cTOHv2tnKugtP7YkgNFCUyrmeiWOqB5aC91lgCFm1GjNl/Zbfz4DvxV9tz
	 PQmteP3QxQSaMBOXINAkapuLYF5XKop15TrkPbfLTGLhg98rG/Y8t+kHoM7a7jd2DD
	 sbaaprAnCC13BfgAsJnX7LlgmODrS1fzQd9JnTY8H9nC3uDQx+23BemGL+gRZxpmSY
	 Bs10lG8HiaKvQ==
Message-ID: <aced334a-e542-42b9-ade4-00f6773c2d45@kernel.org>
Date: Tue, 29 Apr 2025 14:05:53 +0800
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
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Yue Hu <zbestahu@gmail.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, hsiangkao@linux.alibaba.com,
 kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] erofs: lazily initialize per-CPU workers and CPU
 hotplug hooks
To: Sandeep Dhavale <dhavale@google.com>
References: <20250423061023.131354-1-dhavale@google.com>
 <894ca2d3-e680-4395-9887-2b6060fc8096@kernel.org>
 <CAB=BE-Ru31S1Qq0Gmi9UXtaL6k4dcLdTUa-CJbmhuXb7a2dSeQ@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAB=BE-Ru31S1Qq0Gmi9UXtaL6k4dcLdTUa-CJbmhuXb7a2dSeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
	SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Sandeep,

On 4/29/25 05:49, Sandeep Dhavale wrote:
> Hi Chao,
> 
>>
>> - mount #1                              - mount #2
>>  - z_erofs_init_pcpu_workers
>>   - atomic_xchg(, 1)
>>                                          - z_erofs_init_pcpu_workers
>>                                           - atomic_xchg(, 1)
>>                                           : return 0 since atomic variable is 1
>>                                           it will run w/o percpu workers and hotplug
>>   : update atomic variable to 1
>>   - erofs_init_percpu_workers
>>   : fail
>>   - atomic_set(, 0)
>>   : update atomic variable to 0 & fail the mount
>>
>> Can we add some logs to show we succeed/fail to initialize workers or
>> hotplugs? As for mount #2, it expects it will run w/ them, but finally
>> it may not. So we'd better have a simple way to know?
>>
>> Thanks,
>>
> What you have laid out as race, indeed can happen if
> erofs_init_percpu_workers() fails with ENOMEM. For me that is still
> not catastrophic as workqueue fallback is in place so the filesystem
> is still functional.  And at the next mount, the logic will be
> reattempted as the atomic variable is reset to 0 after failure.

Yeah, correct.

> 
> If you still think we need to have a log message, I will be happy to
> spin up the next revision with logging for ENOMEM.

I guess it will be good to add log for such case, thanks. :)

Thanks,

> 
> Thanks for the review!
> 
> Regards,
> Sandeep.


