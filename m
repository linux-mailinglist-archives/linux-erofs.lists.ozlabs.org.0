Return-Path: <linux-erofs+bounces-134-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id ED540A75E3D
	for <lists+linux-erofs@lfdr.de>; Mon, 31 Mar 2025 05:28:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ZQxRW3CKMz2yFP;
	Mon, 31 Mar 2025 14:28:23 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1743391703;
	cv=none; b=T+vYU6APTMYb5rjkZ1Q1HFx2HDHsl2GJq9sZRIK1GPL9YdX2vHePh49n0qsw9IKyGuJ4R0IlFH1OBwSW6vkbxxh/1e7PPl6y1pL0RzcmOdzKK+ZPoZ3xes4Is6HL1rGa108loxBGiTGu6E3Eh6qi1wc53QN67JL/hklsoCC+BGOuqJmaG4P+UZF6h67WxWtnLVkxEuURYPVlDiWIlAJnabeJsuQshUlT9O8LnCKGIuCD9ipsg4YHuWCqCbZA05Nprzxyelt6ZS7udhmZXPxl/l8NKikFlJ4gSx9dcvxxtyoVa5ScEPBwcJoXpqUEKFa5cRzLcKqN18oMbxwAoBmV0w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1743391703; c=relaxed/relaxed;
	bh=NADBr/d3flraf0wF9z+q9LSnttyURdpjOtRNoIb5bdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mOI2DxOpSfoOh8il02cWlj2pqmJIP0iK2PEd7u0qu/EmhJz1vZ66wlwroCYkg1D473+otrFWzONm3o8S1XDy8mu2IR/VQZgn7ZWSRn/KMfcE3iIwxW3i4uUcfo2xTueWnH1UaB+orR/WmZf7H20yBNu6dMM8025grJwzvlXlxdVVYNtNddagDLH0xZVJl5bhiXUVrnSKjhaEunYAZBoOuIq1vpRy7fwh1nIX2pfOUWdBUF1mTNJqQz51XYXp3lkUb6Tyd0v+M3B4ug//EaCu1U0knqtdqHK6PTiky2ayovw8fOisy2Iva7AXox/9qOzYpBpq6kwe2hJtPn3aYfqZBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mZzc2bZG; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mZzc2bZG;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ZQxRT29pmz2yDH
	for <linux-erofs@lists.ozlabs.org>; Mon, 31 Mar 2025 14:28:20 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1743391696; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NADBr/d3flraf0wF9z+q9LSnttyURdpjOtRNoIb5bdQ=;
	b=mZzc2bZGwB1LLE0WaSqg/rr8URPPpl0dROVFFQgo1fr+vbERaw683glOqtTPTjbOnZNziT/zlsqIxOdY4mLZ+YPhZw0o7O0d4I2OVXUi8vSwIom7bjOBlXH3lDFp7af7cYyDRmyvK66mHtd28x2TSWkrInTfzR3KZa/bDsf0CQU=
Received: from 30.221.130.198(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WTP6l9M_1743391694 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Mar 2025 11:28:15 +0800
Message-ID: <330276be-f9cb-4263-85f5-20fe2e10cf72@linux.alibaba.com>
Date: Mon, 31 Mar 2025 11:28:14 +0800
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
To: Sandeep Dhavale <dhavale@google.com>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>,
 Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
 Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20250331022011.645533-1-dhavale@google.com>
 <20250331022011.645533-2-dhavale@google.com>
 <45548d9e-4cfa-476d-9eaa-b338f994478c@linux.alibaba.com>
 <CAB=BE-S6Brg0e277mdY-d3ZwrGeUe3idz37_FJVaTesAFTGfnQ@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-S6Brg0e277mdY-d3ZwrGeUe3idz37_FJVaTesAFTGfnQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/3/31 11:14, Sandeep Dhavale wrote:
> Hi Gao,
>> Do we really need to destroy workers on the last mount?
>> it could cause many unnecessary init/uninit cycles.
>>
>> Or your requirement is just to defer per-CPU workers to
>> the first mount?
>>
>> If your case is the latter, I guess you could just call
>> erofs_init_percpu_workers() in z_erofs_init_super().
>>
>>> +{
>>> +     if (atomic_dec_and_test(&erofs_mount_count))
>>
>> So in that case, we won't need erofs_mount_count anymore,
>> you could just add a pcpu_worker_initialized atomic bool
>> to control that.
>>
> Android devices go through suspend and resume cycles aggressively.
> 
> And currently long running traces showed that erofs_workers being
> created and destroyed without active erofs mount.
> Your suggestion is good and could work for devices which do not use
> erofs at all.

> But if erofs is used once (and unmounted later),> we will not destroy the percpu workers.

Is there a real use case in Android like this?  It
would be really useful to write down something in the
commit message.

> 
> Can you please expand a little bit more on your concern
>> it could cause many unnecessary init/uninit cycles.
> Did you mean on the cases where only one erofs fs
> is mounted at time? Just trying to see if there is a better
> way to address your concern.

My concern is that it could slow down the mount time (on
the single mount/unmount) if there are too many CPUs
(especially on the server side.. 96 CPUs or more...)

Or I guess if kworker CPU hotplug is not used at all
for Android if "suspend and resume" latency is really
important, could we just add a mode to always initialize
pcpu kworkers for all possible CPUs.

Thanks,
Gao Xiang

