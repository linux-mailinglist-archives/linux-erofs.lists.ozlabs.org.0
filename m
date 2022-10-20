Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A73605A26
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Oct 2022 10:49:50 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MtLrX2bvsz3cfB
	for <lists+linux-erofs@lfdr.de>; Thu, 20 Oct 2022 19:49:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RbDjjmZb;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org; envelope-from=chao@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RbDjjmZb;
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MtLrQ0cjLz3c2Q
	for <linux-erofs@lists.ozlabs.org>; Thu, 20 Oct 2022 19:49:41 +1100 (AEDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 1CB1C61A78;
	Thu, 20 Oct 2022 08:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C175BC4347C;
	Thu, 20 Oct 2022 08:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1666255778;
	bh=k6Q3lhZz1PgZiJfwCgaOdN9aQHwyrMWGPtO0uO6xdFs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RbDjjmZbIYRApL8c1P5kp/De1nRQxIOn7V1hTkAXPsaBRH6C9tLi3nZBacRlNJVbk
	 9qw1Jwi6IuaKIyjbh/C4c4UOwbM9xkKwfrMR/WDvgWtH4TGojJbFWvUaEFBO8uIS4E
	 k9UNFzAD/EQhHG6EFapXBVqTS7CJIEyTSaEZG5+IS6RaZgMbgnysLjy4I20TZfI8fJ
	 RfAHVKDNukEhEDKPHt2eWV877JrnYtGvK2Xm9tx4yAfuGbu7Pnh+BkDPS4OMUFPGVE
	 Mo6ZR/nP02RQvE0IZiUOn1pOFr8bfNrqp3a10DC0jq7+wu7j33zgIFkgt8M/M0KClf
	 95tIXSiH6+knA==
Message-ID: <64640ad2-45c5-d07e-60ab-a14e5de5998a@kernel.org>
Date: Thu, 20 Oct 2022 16:49:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] erofs: fix possible memory leak in erofs_init_sysfs()
Content-Language: en-US
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Yang Yingliang <yangyingliang@huawei.com>
References: <20221018073947.693206-1-yangyingliang@huawei.com>
 <Y09fJXi42XV/PF4W@B-P7TQMD6M-0146.local>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Y09fJXi42XV/PF4W@B-P7TQMD6M-0146.local>
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
Cc: Joseph Qi <joseph.qi@linux.alibaba.com>, gregkh@linuxfoundation.org, linux-erofs@lists.ozlabs.org, huangjianan@oppo.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 2022/10/19 10:21, Gao Xiang wrote:
> Hi Yingliang,
> 
> On Tue, Oct 18, 2022 at 03:39:47PM +0800, Yang Yingliang wrote:
>> Inject fault while probing module, kset_register() may fail,
>> if it fails, but the refcount of kobject is not decreased to
>> 0, the name allocated in kobject_set_name() is leaked. Fix
>> this by calling kset_put(), so that name can be freed in
>> callback function kobject_cleanup().
>>
>> unreferenced object 0xffff888101d228c0 (size 8):
>>    comm "modprobe", pid 276, jiffies 4294722700 (age 13.151s)
>>    hex dump (first 8 bytes):
>>      65 72 6f 66 73 00 ff ff                          erofs...
>>    backtrace:
>>      [<00000000e2a9a4a6>] __kmalloc_node_track_caller+0x44/0x1b0
>>      [<00000000b8ce02de>] kstrdup+0x3a/0x70
>>      [<000000004a0e01d2>] kstrdup_const+0x63/0x80
>>      [<00000000051b6cda>] kvasprintf_const+0x149/0x180
>>      [<000000004dc51dad>] kobject_set_name_vargs+0x56/0x150
>>      [<00000000b30f0bad>] kobject_set_name+0xab/0xe0
>>
>> Fixes: 168e9a76200c ("erofs: add sysfs interface")
>> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> 
> Thanks for the catch, the issue itself seems true.  However, I found
> several fses all have this issue.
> 
> After I did some discussion with Joseph Qi offline, I'd like to wait
> for the conclusion of the following thread:
> https://lore.kernel.org/r/bf27f347-5ced-98e5-f188-659cc2a9736f@linux.alibaba.com
> 
> Since I tend to think kset_put() should be one fail step of
> kset_register().

I guess in error path, it missed to free kobj->name which was allocated by
kobject_set_name(&erofs_root.kobj, "erofs"), so calling kset_put() here looks
fine?

Thanks,

> 
> Thanks,
> Gao Xiang
> 
>> ---
>>   fs/erofs/sysfs.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
>> index 783bb7b21b51..653b35001bc5 100644
>> --- a/fs/erofs/sysfs.c
>> +++ b/fs/erofs/sysfs.c
>> @@ -254,8 +254,10 @@ int __init erofs_init_sysfs(void)
>>   	kobject_set_name(&erofs_root.kobj, "erofs");
>>   	erofs_root.kobj.parent = fs_kobj;
>>   	ret = kset_register(&erofs_root);
>> -	if (ret)
>> +	if (ret) {
>> +		kset_put(&erofs_root);
>>   		goto root_err;
>> +	}
>>   
>>   	ret = kobject_init_and_add(&erofs_feat, &erofs_feat_ktype,
>>   				   NULL, "features");
>> -- 
>> 2.25.1
