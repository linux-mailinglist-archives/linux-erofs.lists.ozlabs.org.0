Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34158948720
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Aug 2024 03:58:42 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=R2Bty1b2;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WdGgM57YWz3cYW
	for <lists+linux-erofs@lfdr.de>; Tue,  6 Aug 2024 11:58:39 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=R2Bty1b2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WdGgG5byxz3bNs
	for <linux-erofs@lists.ozlabs.org>; Tue,  6 Aug 2024 11:58:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722909507; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=XV1lOsv6h2Wb1FyYmCAk21IlMxBStDq9Lyk8jIyvFYQ=;
	b=R2Bty1b2jcHLYxk9ThNseD/wGOAdN2KTx/FHsHWrMHtqr1UTSD+etSlhJ70Ur8j07698JugvRsvPMDGHBztl2mI3ReTQUi27v7bt7SXNZ5SbmG2XiX0Y8xpvapBMmQwp5bM03rFQiM4DBF5sYfKq9BO2TBwMELJ/KRJQ5TXrgng=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0WCDMO.g_1722909504;
Received: from 30.221.130.21(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WCDMO.g_1722909504)
          by smtp.aliyun-inc.com;
          Tue, 06 Aug 2024 09:58:26 +0800
Message-ID: <048cdb79-d9d3-41fe-bfc6-41e656054fda@linux.alibaba.com>
Date: Tue, 6 Aug 2024 09:58:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: lib: fix potential overflow issue
To: Sandeep Dhavale <dhavale@google.com>,
 Hongzhen Luo <hongzhen@linux.alibaba.com>
References: <20240805032510.2637488-1-hongzhen@linux.alibaba.com>
 <CAB=BE-Q=wWXuai+pMgQMEBe0oODRNM7MVkzu5bZ2K60JmXZv2w@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-Q=wWXuai+pMgQMEBe0oODRNM7MVkzu5bZ2K60JmXZv2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Sandeep,

On 2024/8/6 02:39, Sandeep Dhavale via Linux-erofs wrote:
> On Sun, Aug 4, 2024 at 8:25 PM Hongzhen Luo <hongzhen@linux.alibaba.com> wrote:
>>
>> Coverity-id: 502377
>>
>> Signed-off-by: Hongzhen Luo <hongzhen@linux.alibaba.com>
>> ---
>>   lib/kite_deflate.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/lib/kite_deflate.c b/lib/kite_deflate.c
>> index a5ebd66..e52e382 100644
>> --- a/lib/kite_deflate.c
>> +++ b/lib/kite_deflate.c
>> @@ -817,7 +817,8 @@ static const struct kite_matchfinder_cfg {
>>   /* 9 */ {32, 258, 258, 4096, true},    /* maximum compression */
>>   };
>>
>> -static int kite_mf_init(struct kite_matchfinder *mf, int wsiz, int level)
>> +static int kite_mf_init(struct kite_matchfinder *mf, unsigned int wsiz,
>> +                       int level)
>>   {
>>          const struct kite_matchfinder_cfg *cfg;
>>
>> --
>> 2.43.5
>>
> 
> Hi Hongzhen,
> Can you please explain to me where the potential overflow is? Checkers
> can be smart so easy for me to miss.
> I see a below check in kitle_me_init()
> 
>      if (wsiz > kHistorySize32 || (1 << ilog2(wsiz)) != wsiz)
>            return -EINVAL;
> 
> So any larger value than kHistorySize32 which is (1U << 15) is already
> rejected. So what overflow case is this int => unsigned int type
> conversion solving?

The latest coverity scan can be found at:
https://scan.coverity.com/projects/erofs-erofs-utils

If you're interested in the result details, I could send a coverity
membership invitation to you so that you could find more comments
on the website.

Since coverity reports are important for several vendors, if it's
not quite insane, maybe we need to address anyway.

Thanks,
Gao Xiang

> 
> Thanks,
> Sandeep.
