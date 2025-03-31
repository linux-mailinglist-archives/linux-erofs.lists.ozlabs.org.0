Return-Path: <linux-erofs+bounces-136-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5884BA75E47
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Mar 2025 05:48:34 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZQxtl6L0cz2yfG;
	Mon, 31 Mar 2025 14:48:31 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743392911;
	cv=none; b=LpqBH28hSIMZk7G6qzC6RiAaUFmaz4d3WGaqBYTBkobGph0E2C4ajoUAFtvsc8pQ7lM54NugWBe7yrMODlZqVFXDnuVY/cpyfYeV82Gym6WHCo7HPtVvHTWQCyHmCm3WYmzSfVLPH7+yJg2azQezxRj4Fj9JXjzTn07tU8QUQNje5DMVbu38Bt3A/UOoEAtKXFuhIE6BdaYhXJcCfPjuQ8J40ZjWQB2V+kbG66KLiwS2fZR/pYfeWeNpFZctupGOdyNc2gMHfVzOUdJCgr4owzl+5DLrUHZMI767YxSpD2T1DJYFiY47ED1+ymHWaDPywEJTyBFB1xt2yxTvLoFoVA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743392911; c=relaxed/relaxed;
	bh=/1tccYnotOw1v33dWO3ti6U/9fTCRiTM35LlXUw0cOo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IWYOk59r66vuB263xNslBEIIjiNFXlC7liFPwkc9dpbx/H17LlPCcSGjH92gvkER7JzJY1Sic23zZMsA6VKSXJBdjMRWLdZdFDu0DqDS1VFKhLTKSl5pd9pJKYHqIN6BtQXDuf8Q55WRE7sl51tn320uE1pFvHW0zyh7/CQxPq4xkPQQ1rUxYv+ARgOOzUvkG4X636puMAB/vLVyaWdPBCNQ6I7nR20a+UWBhD2E4MhnxRkhLdzpa3FiT4MTEGje0CQCVpYW9Fh1BbvcGDoPT7BlFPEuGS3GACBZoQYMKYHX9MBq/hTvM15SsEVPk/xonuFra+gEhg0KMlwKT6bKug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HhYNjEZx; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=HhYNjEZx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZQxtk00tmz2yf1
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Mar 2025 14:48:29 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743392904; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=/1tccYnotOw1v33dWO3ti6U/9fTCRiTM35LlXUw0cOo=;
	b=HhYNjEZx/Zvv+T45ijkXD3tdaNNk+/NJ41ipsx/0fY4lJPedarS0Nb44VoqgBp6FaOJf1rOU1g6DSed3liLVP2YmrKUU6564at903N7XNfbInkP6q/zf+/8pFl/nbMSPQgcu8JFP6SlyT3B3DvgcC5yU2db4T5Nu445S/PFBJCg=
Received: from 30.221.130.198(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WTPC6p8_1743392901 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Mar 2025 11:48:21 +0800
Message-ID: <4492c013-4e59-425a-859f-5f8b30fb922d@linux.alibaba.com>
Date: Mon, 31 Mar 2025 11:48:20 +0800
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] erofs: lazily initialize per-CPU workers and CPU
 hotplug hooks
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Sandeep Dhavale <dhavale@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20250331022011.645533-1-dhavale@google.com>
 <20250331022011.645533-2-dhavale@google.com>
 <45548d9e-4cfa-476d-9eaa-b338f994478c@linux.alibaba.com>
 <CAB=BE-S6Brg0e277mdY-d3ZwrGeUe3idz37_FJVaTesAFTGfnQ@mail.gmail.com>
 <330276be-f9cb-4263-85f5-20fe2e10cf72@linux.alibaba.com>
In-Reply-To: <330276be-f9cb-4263-85f5-20fe2e10cf72@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/3/31 11:28, Gao Xiang wrote:
> 
> 
> On 2025/3/31 11:14, Sandeep Dhavale wrote:
>> Hi Gao,
>>> Do we really need to destroy workers on the last mount?
>>> it could cause many unnecessary init/uninit cycles.
>>>
>>> Or your requirement is just to defer per-CPU workers to
>>> the first mount?
>>>
>>> If your case is the latter, I guess you could just call
>>> erofs_init_percpu_workers() in z_erofs_init_super().
>>>
>>>> +{
>>>> +     if (atomic_dec_and_test(&erofs_mount_count))
>>>
>>> So in that case, we won't need erofs_mount_count anymore,
>>> you could just add a pcpu_worker_initialized atomic bool
>>> to control that.
>>>
>> Android devices go through suspend and resume cycles aggressively.
>>
>> And currently long running traces showed that erofs_workers being
>> created and destroyed without active erofs mount.
>> Your suggestion is good and could work for devices which do not use
>> erofs at all.
> 
>> But if erofs is used once (and unmounted later),> we will not destroy the percpu workers.
> 
> Is there a real use case in Android like this?  It
> would be really useful to write down something in the
> commit message.
> 
>>
>> Can you please expand a little bit more on your concern
>>> it could cause many unnecessary init/uninit cycles.
>> Did you mean on the cases where only one erofs fs
>> is mounted at time? Just trying to see if there is a better
>> way to address your concern.
> 
> My concern is that it could slow down the mount time (on
> the single mount/unmount) if there are too many CPUs
> (especially on the server side.. 96 CPUs or more...)
> 
> Or I guess if kworker CPU hotplug is not used at all
> for Android if "suspend and resume" latency is really
> important, could we just add a mode to always initialize
> pcpu kworkers for all possible CPUs.

Ok, ignore this part after more thinking.

Thanks,
Gao Xiang

