Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E72C9960FF
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2024 09:37:22 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XNl8c10SSz3bZs
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Oct 2024 18:37:20 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.130
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1728459438;
	cv=none; b=H/7JTuSKrFsFT5bDH+hOqzatNM2c5NyEgYtmi1OSkx71FW9N3K+IX+V30h23Alv5F/ZrPdkrYzdvIKad4zy7mhckm2bpo2sSfmtg1loknF1OFbaqqvxwl2YAnyn9tW/Bch3/KZSksnS2nwbpT2eCmjP0L9TUyuxtanhtvxKc9YcnWOYzEptqhvP+hfw0QzQZv5QY5m4xa3vFvwAxytBo+LacAGefPkOQSRA7sM09SfHmFcPxLYtlDbZl7dalQYFmPsOVwPQmAGd8f+ZI2kVZA7tTSjUThE+QELsX+7tJQUOero0atWsKqTNnbRiGBLkpNpuahAInUYkEBao40j4obA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1728459438; c=relaxed/relaxed;
	bh=oSl+cGwvm5m4G+tPjkLAH90RmfdMCPQYjH5YWNkUFLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdoBS6M28dGjhNfyN7DwLaoTSaqVrn8Et2J5YGJoYXsgdRU3QLaEcslbp3pJFlvkPaqgWA2daPCFiryn22fDYCtaXhoj1F7A9D+H23RwMBHM5rkILx2JZcuxTR8CkSveOOJvKbQuJ0jenTz9L5AtcYp4gGYUz+DS1q7jAW8HDcb9ujEVkGEZ91tc+10ns5iFVGaq648/GYTT+r3WFaFYTvf/NUggPzSmQR/8Bv5bMz0rCTSO6/Blgl9LNnONhXcUsST5VD4+wEz7j+7FDidyhzoxLvST1oJH5v7HQX1mHCRTLWr8CVZwpdC/YoOCJIkuSBHGoV+y0aL0MnFPvtvI2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=m0ycJI3G; dkim-atps=neutral; spf=pass (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=m0ycJI3G;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.130; helo=out30-130.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XNl8V0W2Vz2xHg
	for <linux-erofs@lists.ozlabs.org>; Wed,  9 Oct 2024 18:37:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728459427; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=oSl+cGwvm5m4G+tPjkLAH90RmfdMCPQYjH5YWNkUFLo=;
	b=m0ycJI3GIQhk9S7tc1FAMozhciYnD8qa606kyAoG+fibgIsdg1VFZPp+VnMK12x6EO3Jc6+u6x1Ib/3ha0yAyvn1gQx//QZLYUJkax2tzcO9bPDjAblxboFRMqRHR9lbGPRKVrMYRErXq6nAxuIKI9wZIGWzKKUlmHPZDywF68w=
Received: from 30.221.130.172(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WGi.FKl_1728459424)
          by smtp.aliyun-inc.com;
          Wed, 09 Oct 2024 15:37:05 +0800
Message-ID: <8a40d27c-28f1-467b-9a9e-359b36ee5e33@linux.alibaba.com>
Date: Wed, 9 Oct 2024 15:37:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] erofs: use get_tree_bdev_flags() to avoid
 misleading messages
To: Christoph Hellwig <hch@infradead.org>
References: <20241009033151.2334888-1-hsiangkao@linux.alibaba.com>
 <20241009033151.2334888-2-hsiangkao@linux.alibaba.com>
 <ZwYxVcvyjJR_FM0U@infradead.org>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <ZwYxVcvyjJR_FM0U@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, LKML <linux-kernel@vger.kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, linux-erofs@lists.ozlabs.org, Allison Karlitskaya <allison.karlitskaya@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christoph,

On 2024/10/9 15:31, Christoph Hellwig wrote:
> On Wed, Oct 09, 2024 at 11:31:51AM +0800, Gao Xiang wrote:
>> Users can pass in an arbitrary source path for the proper type of
>> a mount then without "Can't lookup blockdev" error message.
>>
>> Reported-by: Allison Karlitskaya <allison.karlitskaya@redhat.com>
>> Closes: https://lore.kernel.org/r/CAOYeF9VQ8jKVmpy5Zy9DNhO6xmWSKMB-DO8yvBB0XvBE7=3Ugg@mail.gmail.com
>> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>> ---
>> changes since v1:
>>   - use new get_tree_bdev_flags().
>>
>>   fs/erofs/super.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>> index 666873f745da..b89836a8760d 100644
>> --- a/fs/erofs/super.c
>> +++ b/fs/erofs/super.c
>> @@ -705,7 +705,9 @@ static int erofs_fc_get_tree(struct fs_context *fc)
>>   	if (IS_ENABLED(CONFIG_EROFS_FS_ONDEMAND) && sbi->fsid)
>>   		return get_tree_nodev(fc, erofs_fc_fill_super);
>>   
>> -	ret = get_tree_bdev(fc, erofs_fc_fill_super);
>> +	ret = get_tree_bdev_flags(fc, erofs_fc_fill_super,
>> +		IS_ENABLED(CONFIG_EROFS_FS_BACKED_BY_FILE) ?
>> +			GET_TREE_BDEV_QUIET_LOOKUP : 0);
> 
> Why not pass it unconditionally and provide your own more useful
> error message at the end of the function if you could not find any
> source?

My own (potential) concern is that if CONFIG_EROFS_FS_BACKED_BY_FILE
is off, EROFS should just behave as other pure bdev fses since I'm
not sure if some userspace program really relies on
"Can't lookup blockdev" behavior.

.. Yet that is just my own potential worry anyway.

Thanks,
Gao Xiang

