Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D00409346C6
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2024 05:36:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1721273768;
	bh=Wt7lmJk0o/objhtGQ4WoGrrou53RGRqlAr7Lt600BRU=;
	h=Date:Subject:To:References:In-Reply-To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=jPFad0aP1F6QkEdIftMsbkg3znlmI655Co3k2yqUUaPbRP2IsxWDo3P7uC/jbV/3W
	 gfADiK0JXgfaRoI59bN/YCZIaO25ZJQoqsvEVaotPVCyPRWmhYk0VNIqEriKk5VYTv
	 nPLc+WcymVpAHuGaQVFX7US93QBhfy9Qz5QNQsXJpxvbRIEWJo2lKKSizwnFBhIcNT
	 eULLcg9XcbZRZzDPBGItEBkhhOYLMDyqEr99YxwueiVssxEGlQ2dUyDVbw+1Snw/EG
	 /KGKv4tuDSwjxBkutvn7aPWpC5ADaoIo/wvhXl7otJNgNS6aSO9slcdRUcRfklXNJv
	 AC8w9U/QZF99A==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4WPdkc6XXjz3cbQ
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jul 2024 13:36:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=szxga08-in.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4WPdkW66TGz3bq0
	for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jul 2024 13:36:00 +1000 (AEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WPdck5XKFz1JClN;
	Thu, 18 Jul 2024 11:31:02 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 71CA418009E;
	Thu, 18 Jul 2024 11:35:55 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 18 Jul 2024 11:35:55 +0800
Message-ID: <4f477570-bea7-4008-b823-b3d94fc81243@huawei.com>
Date: Thu, 18 Jul 2024 11:35:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs: support STATX_DIOALIGN
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <xiang@kernel.org>,
	<chao@kernel.org>, <huyue2@coolpad.com>, <jefflexu@linux.alibaba.com>,
	<dhavale@google.com>, <dhowells@redhat.com>
References: <20240716124534.2358151-1-lihongbo22@huawei.com>
 <afe7b51b-b235-4ad5-80a5-16e0e61e149e@linux.alibaba.com>
 <9e531afd-45e8-471b-8074-8ae5c90aceb0@huawei.com>
 <e0f9d85f-3b5f-49e7-b702-8c41188de44f@linux.alibaba.com>
Content-Language: en-US
In-Reply-To: <e0f9d85f-3b5f-49e7-b702-8c41188de44f@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)
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
From: Hongbo Li via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: netfs@lists.linux.dev, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/7/18 10:41, Gao Xiang wrote:
> 
> 
> On 2024/7/17 14:34, Hongbo Li wrote:
>>
>>
>> On 2024/7/17 10:00, Gao Xiang wrote:
>>> Hi,
>>>
>>> On 2024/7/16 20:45, Hongbo Li wrote:
>>>> Add support for STATX_DIOALIGN to erofs, so that direct I/O
>>>> alignment restrictions are exposed to userspace in a generic
>>>> way.
>>>>
>>>> [Before]
>>>> ```
>>>> ./statx_test /mnt/erofs/testfile
>>>> statx(/mnt/erofs/testfile) = 0
>>>> dio mem align:0
>>>> dio offset align:0
>>>> ```
>>>>
>>>> [After]
>>>> ```
>>>> ./statx_test /mnt/erofs/testfile
>>>> statx(/mnt/erofs/testfile) = 0
>>>> dio mem align:512
>>>> dio offset align:512
>>>> ```
>>>>
>>>> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
>>>> ---
>>>>   fs/erofs/inode.c | 19 +++++++++++++++++++
>>>>   1 file changed, 19 insertions(+)
>>>>
>>>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>>>> index 5f6439a63af7..9325a6f0058a 100644
>>>> --- a/fs/erofs/inode.c
>>>> +++ b/fs/erofs/inode.c
>>>> @@ -342,6 +342,25 @@ int erofs_getattr(struct mnt_idmap *idmap, 
>>>> const struct path *path,
>>>>       stat->attributes_mask |= (STATX_ATTR_COMPRESSED |
>>>>                     STATX_ATTR_IMMUTABLE);
>>>> +    /*
>>>> +     * Return the DIO alignment restrictions if requested.
>>>> +     *
>>>> +     * In erofs, STATX_DIOALIGN is not supported in ondemand mode and
>>>> +     * the compressed file, so in these cases we report no DIO 
>>>> support.
>>>> +     */
>>>> +    if ((request_mask & STATX_DIOALIGN) && S_ISREG(inode->i_mode)) {
>>>> +        stat->result_mask |= STATX_DIOALIGN;
>>>> +        if (!erofs_is_fscache_mode(inode->i_sb) &&
>>>> + !erofs_inode_is_data_compressed(EROFS_I(inode)->datalayout)) {
>>>> +            struct block_device *bdev = inode->i_sb->s_bdev;
>>>> +            unsigned int bsize = (bdev) ? 
>>>> bdev_logical_block_size(bdev) :
>>>> +                        i_blocksize(inode);
>>>
>>> I guess in this way you could always use
>>>              stat->dio_mem_align = bdev_logical_block_size(bdev);
>>>              stat->dio_offset_align = stat->dio_mem_align;
>>> ? since bdev won't be NULL.
>>>
>> Yeah, only the EROFS_FS_ONDEMAND config is on, the s_bdev can be NULL.
> 
> Would you mind sending a v2 to fix this?  At least, s_bdev is always
> non-NULL currently.
> 
> I could apply this for this cycle.
> 
I'm working on ondemand direct io mode. This will affect the 
STATX_DIOALIGN result for erofs_is_fscache_mode case (.ie the 
dio_mem_align is i_blocksize(inode) in erofs over fscache). Should we 
apply this first and then modify it after the direct io is supported in 
ondemand erofs?

Thanks,
Hongbo

> Thanks,
> Gao Xiang
> 
>>
>> Thanks,
>> Hongbo
>>
>>> Otherwise it looks good to me.
>>>
>>> Thanks,
>>> Gao Xiang
