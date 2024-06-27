Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FE091A897
	for <lists+linux-erofs@lfdr.de>; Thu, 27 Jun 2024 16:03:56 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=O53Dbx9f;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W90fc57GFz3cWW
	for <lists+linux-erofs@lfdr.de>; Fri, 28 Jun 2024 00:03:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=O53Dbx9f;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W90fW3bWHz3cCM
	for <linux-erofs@lists.ozlabs.org>; Fri, 28 Jun 2024 00:03:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1719497020; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=qyA12MMOzqOe3a+16UP1r9cEQtzk22NN0sbOim2jGNI=;
	b=O53Dbx9fjT30AweScfVr4XEHqFArl4RjrfILrqHPFT3CISekE4NNDh33AA2MzkIIladSsbS4t0gWtje91N7JShIQPHfTd1/wlF4DRRAsU8DRb+G6K1HeOWwiL8mPWv9h8bElc41hsSQYgHY2pmN8X12dVCT/ls/CafVslvrtWrY=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R441e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W9N0EeX_1719497018;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W9N0EeX_1719497018)
          by smtp.aliyun-inc.com;
          Thu, 27 Jun 2024 22:03:39 +0800
Message-ID: <62f71edc-b89d-4d5c-b51b-4eefb838d7fb@linux.alibaba.com>
Date: Thu, 27 Jun 2024 22:03:38 +0800
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
 <2abcf8cf-5cfc-4932-a544-ee0788bb2ed3@linux.alibaba.com>
 <32dce802-692f-4050-b153-d5c4541fd835@linux.alibaba.com>
 <2024062757-throwaway-frugality-0637@gregkh>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <2024062757-throwaway-frugality-0637@gregkh>
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
Cc: brauner@kernel.org, jack@suse.cz, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/6/27 21:22, Greg KH wrote:
> On Thu, Jun 27, 2024 at 08:51:37PM +0800, Gao Xiang wrote:
>>
>>
>> On 2024/6/27 20:36, Gao Xiang wrote:
>>> Hi Greg,
>>>
>>> On 2024/6/27 19:16, Greg KH wrote:
>>
>> ...
>>
>>>>
>>>> So what specifically should we do here?
>>>
>>> Thanks for the reply..  Honestly I'd like to revert
>>>
>>> block: Provide bdev_open_* functions
>>> erofs: Convert to use bdev_open_by_path()
>>> erofs: fix handling kern_mount() failure
>>>
>>> Not quite sure if they can be cleanly reverted, but
>>> since the upstream doen't have 'bdev_handle' anymore,
>>> I will resend a proper backport for
>>> "erofs: fix handling kern_mount() failure".
>>
>> Sigh, I just tried and it seems it causes more
>> conflicts due to my revert.  It seems another churn..
>>
>> Anyway, on 6.6 LTS only the erofs one uses the
>> obsolete `struct bdev_handle`, but I think at least
>> it doesn't cause some serious issue.
>>
>> Hi Greg,
>>
>> Could you just pick up Hongbo's backport to resolve
>> the NULL dereference issue?
> 
> Sure, is that the one earlier in this thread?

Yeah.

> 
> And if so, what is the git commit id of it in Linus's tree?

commit 8bd90b6ae7856dd5000b75691d905b39b9ea5d6b upstream.

Thanks,
Gao Xiang

> 
> thanks,
> 
> greg k-h
