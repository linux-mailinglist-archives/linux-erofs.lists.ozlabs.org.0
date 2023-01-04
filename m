Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47E765CC27
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 04:32:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NmwCn3wxlz3bT4
	for <lists+linux-erofs@lfdr.de>; Wed,  4 Jan 2023 14:32:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.7; helo=out30-7.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-7.freemail.mail.aliyun.com (out30-7.freemail.mail.aliyun.com [115.124.30.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NmwCc6sWyz2xbC
	for <linux-erofs@lists.ozlabs.org>; Wed,  4 Jan 2023 14:32:43 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VYpnecm_1672803157;
Received: from 30.97.49.3(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VYpnecm_1672803157)
          by smtp.aliyun-inc.com;
          Wed, 04 Jan 2023 11:32:39 +0800
Message-ID: <5236b19c-763f-9a5b-a0c1-4c59fa7c6d05@linux.alibaba.com>
Date: Wed, 4 Jan 2023 11:32:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [RFC PATCH] erofs-utils: fsck: support fragments
To: Yue Hu <zbestahu@gmail.com>
References: <20221224094319.10317-1-zbestahu@gmail.com>
 <fa1df3e5-9158-4381-5315-d243f77542a6@linux.alibaba.com>
 <20230104112445.000075d8.zbestahu@gmail.com>
From: Xiang Gao <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230104112445.000075d8.zbestahu@gmail.com>
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
Cc: Yue Hu <huyue2@coolpad.com>, linux-erofs@lists.ozlabs.org, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2023/1/4 11:24, Yue Hu wrote:
> Hi Xiang,
> 
> On Wed, 4 Jan 2023 10:48:40 +0800
> Xiang Gao <hsiangkao@linux.alibaba.com> wrote:
> 
>> Hi Yue,
>>
>> 在 2022/12/24 17:43, Yue Hu 写道:
>>> From: Yue Hu <huyue2@coolpad.com>
>>>
>>> Add compressed fragments support for fsck.erofs.
>>>
>>> Signed-off-by: Yue Hu <huyue2@coolpad.com>
>>> ---
>>>    fsck/main.c | 41 +++++++++++++++++++++++++++++++++++++++--
>>>    lib/zmap.c  |  1 +
>>>    2 files changed, 40 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fsck/main.c b/fsck/main.c
>>> index 2a9c501..9babc61 100644
>>> --- a/fsck/main.c
>>> +++ b/fsck/main.c
>>> @@ -421,6 +421,31 @@ static int erofs_verify_inode_data(struct erofs_inode *inode, int outfd)
>>>    		if (!(map.m_flags & EROFS_MAP_MAPPED) || !fsckcfg.check_decomp)
>>>    			continue;
>>>    
>>> +		if (map.m_flags & EROFS_MAP_FRAGMENT) {
>>> +			struct erofs_inode packed_inode = {
>>> +				.nid = sbi.packed_nid,
>>> +			};
>>
>> Sorry for late response.
>>
>> a question... why don't we just rely on z_erofs_read_data()?
> 
> We may fall back to uncompressed mode for packed inode due to 'ENOSPC'.

I think we could just export parts of erofs_pread() to clean up the 
whole erofs_verify_inode_data()...

Thanks,
Gao Xiang


