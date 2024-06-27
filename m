Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB9F91A6A6
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 14:36:36 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Eg4pGVad;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W8yjs1H6Kz3cW7
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 22:36:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Eg4pGVad;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132; helo=out30-132.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W8yjm1HfKz3cCM
	for <linux-erofs@lists.ozlabs.org>; Thu, 27 Jun 2024 22:36:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719491781; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+UTNcXBkq3GJuTAU/mYkDlf2oXIwxKDW06AYr6EJHoU=;
	b=Eg4pGVadTfs0YrSG/fznNRIc0r4oddr0pDWvovns5ENliBaSTRKYBff5xQ73mPk1jy7XtscXsZaXbKXeMN780j97StZfbGCSi54Yl5IUVozU4/G7/QwbX6zfy1N3X/euzVOBl4OnNkQaLBL8bxoYE3R3AJ6KCCySek9860uxqKg=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033023225041;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W9Mlcq2_1719491778;
Received: from 30.97.48.200(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9Mlcq2_1719491778)
          by smtp.aliyun-inc.com;
          Thu, 27 Jun 2024 20:36:19 +0800
Message-ID: <2abcf8cf-5cfc-4932-a544-ee0788bb2ed3@linux.alibaba.com>
Date: Thu, 27 Jun 2024 20:36:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6.6] erofs: fix NULL dereference of dif->bdev_handle in
 fscache mode
To: Greg KH <gregkh@linuxfoundation.org>
References: <20240627091345.3569167-1-lihongbo22@huawei.com>
 <c1426293-7a86-49fd-a807-d577438a7828@huawei.com>
 <9e81761d-e769-4b14-b72c-77b74e707364@linux.alibaba.com>
 <2a427366-0f63-4024-a3b3-759a4f902061@linux.alibaba.com>
 <2024062733-cradle-imprecise-002f@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2024062733-cradle-imprecise-002f@gregkh>
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
Cc: brauner@kernel.org, jack@suse.cz, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Greg,

On 2024/6/27 19:16, Greg KH wrote:
> On Thu, Jun 27, 2024 at 05:50:26PM +0800, Gao Xiang wrote:
>>
>>
>> On 2024/6/27 17:35, Gao Xiang wrote:
>>>
>>>
>>> On 2024/6/27 17:11, Hongbo Li wrote:
>>
>> ..
>>
>>>>
>>>> The reason is the same with 8bd90b6ae7856("erofs: fix NULL dereference of dif->bdev_handle in fscache mode") in mainline. So we should backport this
>>>> patch into stable linux-6.6.y to avoid this bug.
>>>
>>> Yes, commit 8bd90b6ae785 should be backported to
>>> Linux 6.6.y LTS immediately.
>>
>> BTW, It seems that
>>
>> commit "erofs: Convert to use bdev_open_by_path()" was
>> backported as a dependency since v6.6.23 even I
>> explicitly commented that this patch is unnecessary
>> and I tend to manually backport instead as below:
>>
>> https://lore.kernel.org/r/ZgDHG8Ucl3EkY4ZS@debian
>>
>>
>> However, my comment was eventually ignored and
>> some other related fix like
>> "erofs: fix NULL dereference of dif->bdev_handle in fscache mode"
>>
>> wasn't backported along with
>> "erofs: Convert to use bdev_open_by_path()"
> 
> Sorry, I missed that somehow, my fault.
> 
>> So the affected 6.6 LTS versions seem to be
>> v6.6.23 ~ v6.6.35 (current)
> 
> So what specifically should we do here?

Thanks for the reply..  Honestly I'd like to revert

block: Provide bdev_open_* functions
erofs: Convert to use bdev_open_by_path()
erofs: fix handling kern_mount() failure

Not quite sure if they can be cleanly reverted, but
since the upstream doen't have 'bdev_handle' anymore,
I will resend a proper backport for
"erofs: fix handling kern_mount() failure".

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h
