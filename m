Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BB953E470
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Jun 2022 14:38:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LGtMJ6Rtjz3bkq
	for <lists+linux-erofs@lfdr.de>; Mon,  6 Jun 2022 22:38:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WFjBHSQs;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=145.40.68.75; helo=ams.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WFjBHSQs;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LGtMF45p6z2yn3
	for <linux-erofs@lists.ozlabs.org>; Mon,  6 Jun 2022 22:38:33 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 417EDB81155;
	Mon,  6 Jun 2022 12:38:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAEAC341C0;
	Mon,  6 Jun 2022 12:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654519110;
	bh=i1AQKA4HtlMyrYOHB4sVJmXfHi0KPoNVjyHoEYQypPE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WFjBHSQsJZCrS60VD5dYqx9OgJQJwgPjQ14cTJ35P+LBrxPS36b7Z70ay8As9mov8
	 YFDQu0jxeoaQ0qWh83rKYS0EbbWBH1hWu7tAoX0HuP6qOi4AXrIPtDx2MhuC1CkXmV
	 NJqxjDbi91UiY0wLQyI6gWdhoz4pAP3mvo6MT4HqGawDzb/NuJS2FxipS1E6Wy3vQx
	 KdPPpoMzr4yNkOoVDOSMC3pqNZ2cT1Z13v9wtqUuSru2wWvLQ1+p8deY6Ta1r4l4Z/
	 Y6fDK56KfsjjpksE4RmvmOktD/1EVehP5cRQrW4+eTQAQSu5W66PLueGbtUFULcCZN
	 6gyvZKy7WOWbg==
Message-ID: <de70aae8-4b39-cfb1-54a3-2e6b2e3c920d@kernel.org>
Date: Mon, 6 Jun 2022 20:38:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] MAINTAINERS: erofs: add myself as reviewer
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Jeffle Xu <jefflexu@linux.alibaba.com>
References: <20220606021103.89211-1-jefflexu@linux.alibaba.com>
 <Yp1oIye4FM+uU0a+@B-P7TQMD6M-0146.local>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Yp1oIye4FM+uU0a+@B-P7TQMD6M-0146.local>
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
Cc: joseph.qi@linux.alibaba.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/6/6 10:36, Gao Xiang wrote:
> On Mon, Jun 06, 2022 at 10:11:03AM +0800, Jeffle Xu wrote:
>> Glad to contribute the fscache mode to erofs. Sincerely I recommend
>> myself as the reviewer to maintain these codes.
>>
>> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> 
> Thanks for taking time on EROFS and looking after this.
> Acked-by: Gao Xiang <xiang@kernel.org>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 1309e1496c23..6cd8b3631cc0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -7388,6 +7388,7 @@ EROFS FILE SYSTEM
>>   M:	Gao Xiang <xiang@kernel.org>
>>   M:	Chao Yu <chao@kernel.org>
>>   R:	Yue Hu <huyue2@coolpad.com>
>> +R:	Jeffle Xu <jefflexu@linux.alibaba.com>
>>   L:	linux-erofs@lists.ozlabs.org
>>   S:	Maintained
>>   T:	git git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git
>> -- 
>> 2.27.0
