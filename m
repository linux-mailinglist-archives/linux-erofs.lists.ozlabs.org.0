Return-Path: <linux-erofs+bounces-1070-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEAEB940D8
	for <lists+linux-erofs@lfdr.de>; Tue, 23 Sep 2025 04:59:57 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4cW4TR2Nh3z3cYR;
	Tue, 23 Sep 2025 12:59:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1758596395;
	cv=none; b=Fihl2OxArXmr2VrrFzDYT1WS+YNCcXMd9RLgRJLzHt4NDJ4XK1BBe+GdmfZ0vg34cmVLv+cyMrWOQmJmOA7PyeNHwk964t4gCSIa3otqGPBqqufPHngmyHTltgcXhnF5obPE64CUEXlEcoRZHjEO+qJkOmC06HDmqnEfP8319PZ7cMlgHnSDImAuHCWoU0mYi6DN9f0Jbw51XKU41KzsbaHh35uyT1Adc3myT/HQfkZJZf7WXKylmcwNCFww98rRZZZo6Bk/ReuofiMmnUrgX0J5g+HFnKB+uCXU1ejcYS3P4/nld1/iw3zUNIYcZ3iBxGn5nk3U0FPw/+AqUEX0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1758596395; c=relaxed/relaxed;
	bh=kgrXGCmAhHxdrrJB3eGb66sb+W6dglY9weYRSTA5p1E=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=keNpbYo6fO5fg3a8gQo5AN33MsABjZLID0fch2GFU4WcFaMN1uVqRWjJU8X1Efm5odI4n9fi94PF+lUdqC0Srlxudm4xU0wqMAIj4e40leuM2Yyo5bZlFrC6X2zTQNlJA0LvRIW4U4HkwDHruV7rpPX/6HkgFpOP0nKS+qD/5EW6E7xpdCsJzMj5EqtmeDm5vh0CvC/GMDxcW7R7eJTR4Qfq2YwjhoduIysW9EZ8hpz/yqqG11owy1igwn3P5AA9lg/TBYDgfQX6dpjXLipfWT9YSjBTX8VwkeV3S4rNygawcs3fsQoYQXIdvqmmW4KdUZOHrSZrFJyLITX+jQ6Qsw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X9BCBNkb; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=X9BCBNkb;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=chao@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4cW4TQ3m7Dz3cYP
	for <linux-erofs@lists.ozlabs.org>; Tue, 23 Sep 2025 12:59:54 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C12C543EB1;
	Tue, 23 Sep 2025 02:59:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EAA2C4CEF0;
	Tue, 23 Sep 2025 02:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758596392;
	bh=5CC23e1eVoOYG4acE9P3u8bvarC+BnDsfHv4kMfuvj0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=X9BCBNkbX5gnUO8k6mfJ01tcVw2omOQY/OqLiOSVdby+qfmtAwtR5nDTT6Fqp9Jee
	 a1ZXdDdgub8dD8JkSnkbbTKL0y5CD7O9Pyu8Ex+KDATE36flwchCjmWBWCSTzWQraw
	 4ygiOFKwB0EeRV8hkGnt1dnP8PndKProY41EUISTm9XCBTIql23z8tVeZ8aWMRWWap
	 qsmbXPwbeyoKdzt3qOb4bk4SKKESKU54CrKS4G/jYcZw1NJEDXhzcg/D5khwXXruL6
	 Nbfv8kbhAPb1t9Hewr/pxrG+iEZXQlF/jceziWWTtM48YnoVDMJtCWIywBo84dwUjK
	 quX6yi6dKdXMQ==
Message-ID: <221cc0ee-60a7-4672-987b-cd80a5b13590@kernel.org>
Date: Tue, 23 Sep 2025 10:59:49 +0800
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
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] erofs: Add support for FS_IOC_GETFSLABEL
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Bo Liu <liubo03@inspur.com>,
 xiang@kernel.org
References: <20250922092937.2055-1-liubo03@inspur.com>
 <906f54dd-5c7d-47b3-b591-50197786cf33@kernel.org>
 <85be6910-3aa2-4e88-ac16-989fde00c38e@linux.alibaba.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <85be6910-3aa2-4e88-ac16-989fde00c38e@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On 9/23/25 10:34, Gao Xiang wrote:
> Hi Chao,
> 
> On 2025/9/23 10:23, Chao Yu wrote:
>> On 9/22/25 17:29, Bo Liu wrote:
>>> From: Bo Liu (OpenAnolis) <liubo03@inspur.com>
>>>
>>> Add support for reading to the erofs volume label from the
>>> FS_IOC_GETFSLABEL ioctls.
>>>
>>> Signed-off-by: Bo Liu (OpenAnolis) <liubo03@inspur.com>
>>> ---
> 
> ...
> 
>>>   +long erofs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
>>
>> #ifdef CONFIG_COMPAT
>>
>>> +long erofs_compat_ioctl(struct file *filp, unsigned int cmd,
>>> +            unsigned long arg);
> 
> Since it's a function declaration, when CONFIG_COMPAT is not defined,
> there is no user to use erofs_compat_ioctl(), so I think it is fine
> to just leave the declaration here?

Xiang,

Sure, it won't affect compile and link, we can leave it as it is since it's trivial.

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>>
>> #endif
>>
>> Thanks,
>>
>>> +
>>
> 
> 


