Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30377BCA99
	for <lists+linux-erofs@lfdr.de>; Sun,  8 Oct 2023 02:10:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4S32c42mjPz30hY
	for <lists+linux-erofs@lfdr.de>; Sun,  8 Oct 2023 11:10:12 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4S32bv6zNlz2ygZ
	for <linux-erofs@lists.ozlabs.org>; Sun,  8 Oct 2023 11:10:01 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VtcCjjR_1696723794;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VtcCjjR_1696723794)
          by smtp.aliyun-inc.com;
          Sun, 08 Oct 2023 08:09:56 +0800
Message-ID: <aa0c0736-ecea-3834-0356-bc9560270223@linux.alibaba.com>
Date: Sun, 8 Oct 2023 08:09:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: errno is set to a negative value in lib/tar.c
To: =?UTF-8?Q?Erik_Sj=c3=b6lund?= <erik.sjolund@gmail.com>,
 linux-erofs@lists.ozlabs.org
References: <CAB+1q0Q3+7s1Lt8uW6DWZ7vfjhEKhG7O7MAQhCuH-C10cr9F4g@mail.gmail.com>
 <ZR8D0ara6HGoH1aB@debian>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZR8D0ara6HGoH1aB@debian>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/10/6 02:43, Gao Xiang wrote:
> Hi Erik,
> 
> On Mon, Oct 02, 2023 at 07:36:08PM +0200, Erik Sjölund wrote:
>> Hi,
>> Does this patch make sense?
>> (I thought errno should be set to a non-negative value)
>> Best regards,
>> Erik Sjölund
> 
> Thanks for the patch.
> 
> I'm on vacation, sorry for late reply.  It looks good to me,
> I will address it when I'm back.

Since this is a one-line patch, I've applied this to -dev
directly.  But in principle we need a proper Signed-off-by
tag at least..

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
>>
>> diff --git a/lib/tar.c b/lib/tar.c
>> index 0744972..8204939 100644
>> --- a/lib/tar.c
>> +++ b/lib/tar.c
>> @@ -241,7 +241,7 @@ static long long tarerofs_otoi(const char *ptr, int len)
>>          val = strtol(ptr, &endp, 8);
>>          if ((!val && endp == inp) |
>>               (*endp && *endp != ' '))
>> -               errno = -EINVAL;
>> +               errno = EINVAL;
>>          return val;
>>   }
