Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785DAA166A9
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 07:26:42 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Yc0jW73kxz304s
	for <lists+linux-erofs@lfdr.de>; Mon, 20 Jan 2025 17:26:39 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1737354398;
	cv=none; b=SrAaXV2uDNN1fWrxxIpoNr8npSdbUMWAjqWc2ckEhUFN9vGR1MwmB44GOtHfqqXOq0op5Uf36E9aOQXCYyR0zNlqoJR9+de3CUKaUIGTMruMUA+nleJBAWqGJMNr89tBFbZgUKUH/JcXpP3+U1GuwQUJbks2d6OGX5OSnML3gV6CxqxWpoicvrULw4xk9WqrUG2Ca77xCMQc2W3hFtUnxsYR3O8fdr0II0GWlR1v1EyhPtFCPEhiklw0FUbq4RVB9rmAym7dEsxYUutXWNgMzPd+V1rL8fxKMObLx2Bj5NWeAITxWPg3iHOqNrrqDjLUVG2GjKgqdgT6/lyfrCVszA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1737354398; c=relaxed/relaxed;
	bh=GxeJUFNz0OaxopDu6NkPKgwOylPe4O1HFdsSsue6jdk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+fBg5z3Jsvl2oh26bpDDUFM8/mN+beWB09g8X74j2+rva5H2lrgaEs46sXfpQlvrxRMPBUuOw0HAwumH+Lddl3lukiKdi5OZwc5RDwXVMtaRDc9BCGC9E5FyTLgFJxBivahOiwSK43b/V/t8uGkQ3SjPm536BUDDOJW6Rww55noLZ6j5Tzw8WyPz6vyLvUJIAFoJxUT0xmpRnxtvn0Mu1vsxZ9TtC//YVLIyDKRbMWha+s4L3MCu6sorvVpH9srN/vJ0oAYlM3VNlNjCl2GcNg1El6W8gs7SnahGf0OKV+IxRIMsmxiOOil2roeH39APQGYFDqGZwkV1A/lmixH0w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mm8MyIXh; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=mm8MyIXh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Yc0jS42nFz2ywM
	for <linux-erofs@lists.ozlabs.org>; Mon, 20 Jan 2025 17:26:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737354390; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GxeJUFNz0OaxopDu6NkPKgwOylPe4O1HFdsSsue6jdk=;
	b=mm8MyIXh+LxpWf+Wnu4MGPAAoA3mAOK2gAHVZ1or5+i4beOS9vVcFXprku5ULJcm0I/JsEE0mOgbWIMBrqwbBgmHqOotOXyAumB8rQ1s3tP41lw886ZJNp2w8pNIEGT0sQqYL5Qrv9gxg2k+I8lJZlVdsMKm9jIyAwN1aaUULWY=
Received: from 30.221.129.118(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WNwwPbS_1737354389 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 20 Jan 2025 14:26:29 +0800
Message-ID: <52678f1c-ee7d-441f-a423-5796e47e0a33@linux.alibaba.com>
Date: Mon, 20 Jan 2025 14:26:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] erofs: file-backed mount supports direct io
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org, chao@kernel.org
References: <20250115070936.119975-1-lihongbo22@huawei.com>
 <635ede9a-b5eb-4630-88ba-2826022d5585@linux.alibaba.com>
 <fbd5850c-e431-4914-81eb-ec3ff42419a4@huawei.com>
 <f0a6b66e-0427-4c66-8c69-20c6c362e55f@linux.alibaba.com>
 <dd9beb64-3bdb-4f49-a94b-21c039325558@huawei.com>
 <47f74598-1b2f-4308-a8b8-18fc40bafe6d@linux.alibaba.com>
 <0e6a0fac-e9fd-4d5a-ae44-58f575d3da13@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <0e6a0fac-e9fd-4d5a-ae44-58f575d3da13@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.0
X-Spam-Checker-Version: SpamAssassin 4.0.0 (2022-12-13) on lists.ozlabs.org
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



On 2025/1/20 14:16, Hongbo Li wrote:
> 
> 
> On 2025/1/20 11:46, Gao Xiang wrote:
>>
>>
>> On 2025/1/20 11:43, Hongbo Li wrote:
>>>
>>>
>>> On 2025/1/20 11:10, Gao Xiang wrote:
>>>>
>>>>
>>>> On 2025/1/20 11:02, Hongbo Li wrote:
>>>>>
>>>>>
>>>>
>>>> ...
>>>>
>>>>>>>   }
>>>>>>> +static int erofs_fileio_scan_iter(struct erofs_fileio *io, struct kiocb *iocb,
>>>>>>> +                  struct iov_iter *iter)
>>>>>>
>>>>>> I wonder if it's possible to just extract a folio from
>>>>>> `struct iov_iter` and reuse erofs_fileio_scan_folio() logic.
>>>>> Thanks for reviewing. Ok, I'll think about reusing the erofs_fileio_scan_folio logic in later version.
>>>>
>>>> Thanks.
>>>>
>>>>>
>>>>> Additionally, for the file-backed mount case, can we consider removing the erofs's page cache and just using the backend file's page cache? If in this way, it will use buffer io for reading the backend's mounted files in default, and it also can decrease the memory overhead.
>>>>
>>>> I think it's too hacky for upstreaming, since EROFS can only
>>>> operate its own page cache, otherwise it should only support
>>>> overlayfs-like per-inode sharing.
>>>>
>>>> Per-extent sharing among different filesystems is too hacky
>>> It just like the dax mode of erofs (but instead of the dax devices, it's a backend file). It does not share the page among the different filesystems, because there is only the backend file's page cache. I found the whole io path is similar to this direct io mode.
>>
>> How do you handle a VMA which is consecutive as an
>> EROFS file, but actually mapping to different part
>> of the underlay inode, or even different underlay
>> inodes?
> 
> The mmap is indeed a trouble, I'm still trying to figure out how to solve it. :)

Actually I don't think it's a clean feature, also
the upcoming page cache sharing feature already covers
the related use cases.

Thanks,
Gao Xiang

> 
> Thanks,
> Hongbo
> 
>>
>> It just cause the current MM layer broken, but FSDAX
>> mode is a complete different story.
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> Thanks,
>>> Hongbo
>>>
>>>> on the MM side, but if you have some detailed internal
>>>> requirement, you could implement downstream.
>>>>
>>>> Thanks,
>>>> Gao Xiang
>>>>
>>>>>
>>>>> This is just my initial idea, for uncompressed mode, this should make sense. But for compressed layout, it needs to be verified.
>>>>>
>>>>> Thanks,
>>>>> Hongbo
>>>>>
>>>>>>
>>>>>> It simplifies the codebase a lot, and I think the performance
>>>>>> is almost the same.
>>>>>>
>>>>>> Otherwise currently it looks good to me.
>>>>>>
>>>>>> Thanks,
>>>>>> Gao Xiang
>>>>
>>

