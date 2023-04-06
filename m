Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D80A16D93BE
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 12:13:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PsclM4BTsz3fJd
	for <lists+linux-erofs@lfdr.de>; Thu,  6 Apr 2023 20:13:19 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.99; helo=out30-99.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PsclH1BRTz3chw
	for <linux-erofs@lists.ozlabs.org>; Thu,  6 Apr 2023 20:13:13 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VfSm3Uv_1680775985;
Received: from 30.97.49.15(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VfSm3Uv_1680775985)
          by smtp.aliyun-inc.com;
          Thu, 06 Apr 2023 18:13:07 +0800
Message-ID: <cc219a52-e89c-b7e7-5bfd-0124f881a29f@linux.alibaba.com>
Date: Thu, 6 Apr 2023 18:13:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH 2/3] erofs: convert to use kobject_is_added()
To: Greg KH <gregkh@linuxfoundation.org>, Yangtao Li <frank.li@vivo.com>
References: <20230406093056.33916-1-frank.li@vivo.com>
 <20230406093056.33916-2-frank.li@vivo.com>
 <2023040635-duty-overblown-7b4d@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2023040635-duty-overblown-7b4d@gregkh>
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
Cc: naohiro.aota@wdc.com, rafael@kernel.org, damien.lemoal@opensource.wdc.com, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, huyue2@coolpad.com, jth@kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Greg,

On 2023/4/6 18:03, Greg KH wrote:
> On Thu, Apr 06, 2023 at 05:30:55PM +0800, Yangtao Li wrote:
>> Use kobject_is_added() instead of directly accessing the internal
>> variables of kobject. BTW kill kobject_del() directly, because
>> kobject_put() actually covers kobject removal automatically.
>>
>> Signed-off-by: Yangtao Li <frank.li@vivo.com>
>> ---
>>   fs/erofs/sysfs.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/erofs/sysfs.c b/fs/erofs/sysfs.c
>> index 435e515c0792..daac23e32026 100644
>> --- a/fs/erofs/sysfs.c
>> +++ b/fs/erofs/sysfs.c
>> @@ -240,8 +240,7 @@ void erofs_unregister_sysfs(struct super_block *sb)
>>   {
>>   	struct erofs_sb_info *sbi = EROFS_SB(sb);
>>   
>> -	if (sbi->s_kobj.state_in_sysfs) {
>> -		kobject_del(&sbi->s_kobj);
>> +	if (kobject_is_added(&sbi->s_kobj)) {
> 
> I do not understand why this check is even needed, I do not think it
> should be there at all as obviously the kobject was registered if it now
> needs to not be registered.

I think Yangtao sent a new patchset which missed the whole previous
background discussions as below:
https://lore.kernel.org/r/028a1b56-72c9-75f6-fb68-1dc5181bf2e8@linux.alibaba.com

It's needed because once a syzbot complaint as below:
https://lore.kernel.org/r/CAD-N9QXNx=p3-QoWzk6pCznF32CZy8kM3vvo8mamfZZ9CpUKdw@mail.gmail.com

I'd suggest including the previous backgrounds at least in the newer patchset,
otherwise it makes me explain again and again...

Thanks,
Gao Xiang

> 
> Meta-comment, we need to come up with a "filesystem kobject type" to get
> rid of lots of the boilerplate filesystem kobject logic as it's
> duplicated in every filesystem in tiny different ways and lots of times
> (like here), it's wrong.
> 
> kobjects were not designed to be "used raw" like this, ideally they
> would be wrapped in a subsystem that makes them easier to be used (like
> the driver model), but filesystems decided to use them and that usage
> just grew over the years.  That's evolution for you...> 
> thanks,
> 
> greg k-h
