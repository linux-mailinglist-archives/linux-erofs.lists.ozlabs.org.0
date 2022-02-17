Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C974B95A8
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Feb 2022 02:49:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jzd7118jTz3bcC
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Feb 2022 12:49:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.132;
 helo=out30-132.freemail.mail.aliyun.com;
 envelope-from=jefflexu@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jzd6s3DC1z30Md
 for <linux-erofs@lists.ozlabs.org>; Thu, 17 Feb 2022 12:49:37 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R271e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=jefflexu@linux.alibaba.com;
 NM=1; PH=DS; RN=15; SR=0; TI=SMTPD_---0V4fQwYM_1645062566; 
Received: from 30.225.24.49(mailfrom:jefflexu@linux.alibaba.com
 fp:SMTPD_---0V4fQwYM_1645062566) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 17 Feb 2022 09:49:27 +0800
Message-ID: <a3da9289-665d-ea37-5ab9-b97b883f694f@linux.alibaba.com>
Date: Thu, 17 Feb 2022 09:49:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.0
Subject: Re: [PATCH v4 05/23] cachefiles: introduce new devnode for on-demand
 read mode
Content-Language: en-US
To: Greg KH <gregkh@linuxfoundation.org>
References: <bd9cb3bb-e29c-d4b3-e9bf-915b9771b553@linux.alibaba.com>
 <20220215111335.123528-1-jefflexu@linux.alibaba.com>
 <YgzWkhXCnlNDADvb@kroah.com>
 <becd656c-701c-747e-f063-2b9867cbd3d2@linux.alibaba.com>
 <Yg0421B10PPwunI+@kroah.com>
From: JeffleXu <jefflexu@linux.alibaba.com>
In-Reply-To: <Yg0421B10PPwunI+@kroah.com>
Content-Type: text/plain; charset=UTF-8
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
Cc: linux-erofs@lists.ozlabs.org, willy@infradead.org,
 linux-kernel@vger.kernel.org, dhowells@redhat.com, joseph.qi@linux.alibaba.com,
 linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
 gerry@linux.alibaba.com, torvalds@linux-foundation.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2/17/22 1:48 AM, Greg KH wrote:
> On Wed, Feb 16, 2022 at 08:49:35PM +0800, JeffleXu wrote:
>>>> +struct cachefiles_req_in {
>>>> +	uint64_t id;
>>>> +	uint64_t off;
>>>> +	uint64_t len;
>>>
>>> For structures that cross the user/kernel boundry, you have to use the
>>> correct types.  For this it would be __u64.
>>
>> OK I will change to __xx style in the next version.
>>
>> By the way, I can't understand the disadvantage of uintxx_t style.
> 
> The "uint*" types are not valid kernel types.  They are userspace types
> and do not transfer properly in all arches and situations when crossing
> the user/kernel boundry.  They are also in a different C "namespace", so
> should not even be used in kernel code, although a lot of people do
> because they are used to writing userspace C code :(

OK. "uint*" types are defined in ISO C library, while it seems that
linux kernel doesn't expect any C library [1].

[1] https://kernelnewbies.org/FAQ/LibraryFunctionsInKernel

Thanks for explaining it.

-- 
Thanks,
Jeffle
