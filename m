Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E85F74CB7A
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 07:03:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QzsMc2jM1z3bP2
	for <lists+linux-erofs@lfdr.de>; Mon, 10 Jul 2023 15:03:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131; helo=out30-131.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QzsMX71Lhz2yyX
	for <linux-erofs@lists.ozlabs.org>; Mon, 10 Jul 2023 15:03:03 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vmy4O50_1688965378;
Received: from 30.97.48.247(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vmy4O50_1688965378)
          by smtp.aliyun-inc.com;
          Mon, 10 Jul 2023 13:02:59 +0800
Message-ID: <1a107593-e411-70a0-b6b8-3c34a9036ff3@linux.alibaba.com>
Date: Mon, 10 Jul 2023 13:02:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] erofs: fix two loop issues when read page beyond EOF
To: Chunhai Guo <guochunhai@vivo.com>, "xiang@kernel.org" <xiang@kernel.org>,
 "chao@kernel.org" <chao@kernel.org>
References: <20230708062432.67344-1-guochunhai@vivo.com>
 <97875049-8df9-e041-61ca-d90723ba6e82@linux.alibaba.com>
 <d6ee4571-64d6-ebd2-4adb-83f33e5e608d@vivo.com>
 <fd738d38-17de-4b61-e4e8-d4f98ef8d1db@linux.alibaba.com>
 <ac05d6e3-79b4-a470-2a30-8c809c277209@vivo.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ac05d6e3-79b4-a470-2a30-8c809c277209@vivo.com>
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
Cc: "huyue2@coolpad.com" <huyue2@coolpad.com>, "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/7/10 12:35, Chunhai Guo wrote:
> 
> 
> On 2023/7/10 11:37, Gao Xiang wrote:
>>
>>
>> On 2023/7/10 11:32, Chunhai Guo wrote:
>>> Hi Xiang,
>>>
>>> On 2023/7/8 17:00, Gao Xiang wrote:
>>>> Hi Chunhai,
>>>>
>>>> On 2023/7/8 14:24, Chunhai Guo wrote:
>>>>> When z_erofs_read_folio() reads a page with an offset far beyond EOF, two
>>>>> issues may occur:
>>>>> - z_erofs_pcluster_readmore() may take a long time to loop when the offset
>>>>>      is big enough, which is unnecessary.
>>>>>        - For example, it will loop 4691368 times and take about 27 seconds
>>>>>          with following case.
>>>>>            - offset = 19217289215
>>>>>            - inode_size = 1442672
>>>>> - z_erofs_do_read_page() may loop infinitely due to the inappropriate
>>>>>      truncation in the below statement. Since the offset is 64 bits and
>>>>> min_t() truncates the result to 32 bits. The solution is to replace
>>>>> unsigned int with another 64-bit type, such as erofs_off_t.
>>>>>        cur = end - min_t(unsigned int, offset + end - map->m_la, end);
>>>>>        - For example:
>>>>>            - offset = 0x400160000
>>>>>            - end = 0x370
>>>>>            - map->m_la = 0x160370
>>>>>            - offset + end - map->m_la = 0x400000000
>>>>>            - offset + end - map->m_la = 0x00000000 (truncated as unsigned int)
>>>>
>>>> Thanks for the catch!
>>>>
>>>> Could you split these two into two patches?
>>>>
>>>> how about using:
>>>> cur = end - min_t(erofs_off_t, offend + end - map->m_la, end)
>>>> for this?
>>>>
>>>> since cur and end are all [0, PAGE_SIZE - 1] for now, and
>>>> folio_size() later.
>>>
>>> OK. I will split the patch.
>>>
>>> Sorry that I can not understand what is 'offend' refer to and what do you mean. Could you please describe it more clearly?
>>
>> Sorry, there is a typo here, I meant 'offset'.
>>
>> `cur` and `end` both are not exceed 4096 if your page_size
>> is 4096.
>>
>> Does
>> cur = end - min_t(erofs_off_t, offset + end - map->m_la, end)
>>
>> fix your issue?
> 
> Yes. I think this will fix this issue. Do you mean the below change is unncessary?
>  >>>> -    unsigned int cur, end, spiltted;
>  >>>> +    erofs_off_t cur, end;
>  >>>> +    unsigned int spiltted;

Yes, please help send a fix for this!

Thanks,
Gao Xiang

