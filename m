Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9224161D1
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Sep 2021 17:13:39 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HFdwJ6q1Yz2ynG
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Sep 2021 01:13:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QzbPTYuE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QzbPTYuE; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HFdwG4bk6z2xXf
 for <linux-erofs@lists.ozlabs.org>; Fri, 24 Sep 2021 01:13:34 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E3DE61107;
 Thu, 23 Sep 2021 15:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1632410012;
 bh=mOC7FdQdjTIAxxIgBlh19xNgYctoW/1KW2f4ltIRwOs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=QzbPTYuE/Ex9WyYsMRH5XreZ9GDgqJZtLVs7qppdnE3vytbbX06zTCivHQSSDGOmv
 vtfDFdG08lIEwEptWL/PinvZCMgLqCEOPLxeCZ/o3LHWd1mmpBtH277oUXrgKrW1KZ
 WjsL79EjIEXassRiWyDePshre5rskXK/T5rul5ATD9ygh6XqtM52AFFKHsSb6maU8C
 fCwMZRmNxV9T0e9W4CO/ph8OsOYof8ms9DycXLzmH/T19FejcF2Km/KFxR6+eExzG8
 mDNGkLMW/GVfB2/ofPJCkSDy1wDMiYr25DfCN2Vas7XwrKX2+NUhtuZXB4ilBrF7p3
 UfQtnhXUX963Q==
Subject: Re: [PATCH] erofs: fix compacted_2b if compacted_4b_initial > totalidx
To: Gao Xiang <hsiangkao@linux.alibaba.com>, Yue Hu <zbestahu@gmail.com>
References: <20210914035915.1190-1-zbestahu@gmail.com>
 <YUAm+kOdKcCzgcEy@B-P7TQMD6M-0146.local>
 <20210914125748.00003cd2.zbestahu@gmail.com>
 <YUxp1rsN0Ce88YQI@B-P7TQMD6M-0146.local>
From: Chao Yu <chao@kernel.org>
Message-ID: <f9f2e7a1-7248-c5b2-64b4-2d5f91d68b6c@kernel.org>
Date: Thu, 23 Sep 2021 23:13:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUxp1rsN0Ce88YQI@B-P7TQMD6M-0146.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Cc: linux-kernel@vger.kernel.org, zbestahu@163.com, huyue2@yulong.com,
 linux-erofs@lists.ozlabs.org, zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2021/9/23 19:49, Gao Xiang wrote:
> On Tue, Sep 14, 2021 at 12:57:48PM +0800, Yue Hu wrote:
>> On Tue, 14 Sep 2021 12:37:14 +0800
>> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>> On Tue, Sep 14, 2021 at 11:59:15AM +0800, Yue Hu wrote:
>>>> From: Yue Hu <huyue2@yulong.com>
>>>>
>>>> Currently, the whole indexes will only be compacted 4B if
>>>> compacted_4b_initial > totalidx. So, the calculated compacted_2b
>>>> is worthless for that case. It may waste CPU resources.
>>>>
>>>> No need to update compacted_4b_initial as mkfs since it's used to
>>>> fulfill the alignment of the 1st compacted_2b pack and would handle
>>>> the case above.
>>>>
>>>> We also need to clarify compacted_4b_end here. It's used for the
>>>> last lclusters which aren't fitted in the previous compacted_2b
>>>> packs.
>>>>
>>>> Some messages are from Xiang.
>>>>
>>>> Signed-off-by: Yue Hu <huyue2@yulong.com>
>>>
>>> Looks good to me,
>>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>>
>>> (although I think the subject title would be better changed into
>>>   "clear compacted_2b if compacted_4b_initial > totalidx"
>>
>> Yeah, 'clear' is much better for this change.
>>
>> Thanks.
>>
>>>   since 'fix'-likewise words could trigger some AI bot for stable
>>>   kernel backporting..)
>>>
>>> Thanks,
>>> Gao Xiang
>>>
>>>> ---
>>>>   fs/erofs/zmap.c | 3 ++-
>>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
>>>> index 9fb98d8..aeed404 100644
>>>> --- a/fs/erofs/zmap.c
>>>> +++ b/fs/erofs/zmap.c
>>>> @@ -369,7 +369,8 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
>>>>   	if (compacted_4b_initial == 32 / 4)
>>>>   		compacted_4b_initial = 0;
>>>>   
>>>> -	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
>>>> +	if ((vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) &&
>>>> +	    compacted_4b_initial <= totalidx) {
> 
> btw, I've fixed up the build error due to redundant brace '{' when
> applying...

It looks good to me after above fix.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
