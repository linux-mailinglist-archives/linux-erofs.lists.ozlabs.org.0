Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00AA53E46F
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Jun 2022 14:38:31 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LGtM51SHxz3bkY
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Jun 2022 22:38:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AlwNeBSl;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=AlwNeBSl;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LGtLy6z2pz3bYG
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Jun 2022 22:38:18 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id C5F7EB8191A;
	Mon,  6 Jun 2022 12:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045BDC3411C;
	Mon,  6 Jun 2022 12:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654519093;
	bh=LHCT0MVuCWKJIHCjZdFCmlTd+JmsLHutx4baX8nUikQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=AlwNeBSlk9KylwFTPfiSs0wIuQi7c8M/GqQvt0KNkr85qthmz7w3yKMy+mgGlQiIz
	 jjAJlMuY00OXT9DxeFAMwEZ5VbeZJLtNQ3/zTZYVe7D+Zuz4KVziNnIXO2q9K5ZHqI
	 bITBC/Pa8HvKeHlmMqmmDDL3pxmL3G6s0j0Ho2iKh/Hw8ac48Z85i6Ja/CSWUiji8k
	 PE8J2CutOOUKzioRuKjMSJFydJqW3Etcqa7S+BJsws8dpyEtKxzmBuqbnbxY7BV68G
	 +MngPM5fcUjfeJnGTf4YLjATyvaCmx/PhBwjPe10RriwgwPRPMgqg1nq6aNpM3SERF
	 9O0SFFTiYHwDQ==
Message-ID: <d17777de-13ab-5dcc-e2e7-c8bf1caedbfa@kernel.org>
Date: Mon, 6 Jun 2022 20:38:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] MAINTAINERS: erofs: add myself as reviewer
Content-Language: en-US
To: Yue Hu <huyue2@coolpad.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 zhangwen@coolpad.com, shaojunjun@coolpad.com,
 Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20220605070133.4280-1-huyue2@coolpad.com>
 <Ypxl/MsOGQ6W4Rlf@debian>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Ypxl/MsOGQ6W4Rlf@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: linux-erofs@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Development of Linux EROFS file system <linux-erofs.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linux-erofs/>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Help: <mailto:linux-erofs-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linux-erofs>,
 <mailto:linux-erofs-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/6/5 16:14, Gao Xiang wrote:
> Hi Yue,
> 
> On Sun, Jun 05, 2022 at 03:02:04PM +0800, Yue Hu wrote:
>> I have been doing some erofs patches. Now I have the time and would like
>> to help with the reviews.
>>
>> Signed-off-by: Yue Hu <huyue2@coolpad.com>
> 
> Thanks for working on EROFS these months! Hopefully EROFS could have
> a healthier development then...
> 
> Acked-by: Gao Xiang <xiang@kernel.org>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

> 
> 
> + Jeffle Xu
> 
> (BTW, I'd like to request Jeffle as a EROFS reviewer too due to
>   the fscache feature. Not sure if he's interested in it...)
> 
> Thanks,
> Gao Xiang
> 
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d2691d8a219f..2d0e28d7773b 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7308,6 +7308,7 @@ F:	include/video/s1d13xxxfb.h
>>   EROFS FILE SYSTEM
>>   M:	Gao Xiang <xiang@kernel.org>
>>   M:	Chao Yu <chao@kernel.org>
>> +R:	Yue Hu <huyue2@coolpad.com>
>>   L:	linux-erofs@lists.ozlabs.org
>>   S:	Maintained
>>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
>> -- 
>> 2.17.1
