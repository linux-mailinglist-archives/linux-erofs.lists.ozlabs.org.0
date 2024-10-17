Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFE19A1CE3
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Oct 2024 10:17:20 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4XTgfv60Gzz3bgV
	for <lists+linux-erofs@lfdr.de>; Thu, 17 Oct 2024 19:17:11 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1729153030;
	cv=none; b=gYsD1nLEA5rcfjEIXbmw1FRQGsyYMP8HVMumdr3K1yDDJfHHuT0x4Al42TluT1aleggTLjNf/yoQId5wMdJylGF8luk6NdSeFWgZE+4yYVPxdZegdwxyP1SurT4gwrYfmep/gMW4BcUSONcEJ09ltiCnqEezOTMNoMVN/QDusdY90UDGdWSzx7ElzA85zzEHZ0GpMAm3PyxAa+arxJz0VkYDlYxmGUrDIiWcw9mciVhzFP9itt+BFQSuoIid0cJpv6OIz8RWrNJHbVhOtQSlXRmUeM0wz9eL/wQjLUcfdPwQNYrGyOaeUIvCzVPxQfqRX5X4duIG008gUxEsdJq0WA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1729153030; c=relaxed/relaxed;
	bh=lgdtE/cjkREEUIcIbl6cLW0HqkfNtPyPRowWoZLEyrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gyNPUcv8Pn5RivJkMVQ6f0keIkw3c2OmOSUszxsgat7QMdJQ52mKaQDUrtJfw86Wn0lwVjygny2XwKXJhXWcd7MmSIFa0Lj3UvOUZKGUzmm0qlswYIbJnZOmIaaMkr9QT+FejtThSGEWaixNfK4HQ5IqO5oQq/sZuFe3rVzzVIrYZfRUimTrUO/yizNug6M0H/4idzd/mDob/ZNcYrMHpHis2CWvBPlB8qeFRTJ3ARdR0mi/saJGKUT1udUlrdM736L2ECOfL+eYl011JSHqifiMunmVdPOzP797cca02d4eWhjhlU0jHs26LiFgh8fRfsGQPzK97dqIENhwhVFUmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YHOSUD1K; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=YHOSUD1K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4XTgfm6bY0z2xbY
	for <linux-erofs@lists.ozlabs.org>; Thu, 17 Oct 2024 19:17:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1729153018; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=lgdtE/cjkREEUIcIbl6cLW0HqkfNtPyPRowWoZLEyrk=;
	b=YHOSUD1KDk8WEgBzGBs4idqnAsMULoW78iGKK+soB1AeLI8rYOtQDaBN8hwHY0W8zaW+4f8570g+O8w7wgMXy7Wjjbvt/d16g4AIRv/RnC4jE4E0tV1fnaxJW7F1zBL6uKtd0DjdgV7fWVZWP6fnqV/ezJL7xXMEPaKDOQ+62os=
Received: from 30.221.129.137(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WHKAp-e_1729153015 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Oct 2024 16:16:56 +0800
Message-ID: <dcbf0903-67a2-4b8e-b43b-d6b9cf195a5a@linux.alibaba.com>
Date: Thu, 17 Oct 2024 16:16:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] fs: erofs: support PG_mappedtodisk flag for folios
 with zero-filled
To: Barry Song <21cnbao@gmail.com>
References: <20241017074346.35284-1-21cnbao@gmail.com>
 <ca27aa75-40a4-4c82-8d84-7968b2ab89d4@linux.alibaba.com>
 <0fa18bcf-9af6-4c99-ad57-613fa38ff741@linux.alibaba.com>
 <CAGsJ_4yLK3sCeJNdZRKxD2tSdMVFRBp9eq-1mAMu7UT=gqpA_Q@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAGsJ_4yLK3sCeJNdZRKxD2tSdMVFRBp9eq-1mAMu7UT=gqpA_Q@mail.gmail.com>
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
Cc: linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, huyue2@coolpad.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/10/17 16:09, Barry Song wrote:
> On Thu, Oct 17, 2024 at 9:00 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2024/10/17 15:58, Gao Xiang wrote:
>>> Hi Barry,
>>>
>>> On 2024/10/17 15:43, Barry Song wrote:
>>>> From: Barry Song <v-songbaohua@oppo.com>
>>>>
>>>> When a folio has never been zero-filled, mark it as mappedtodisk
>>>> to allow other software components to recognize and utilize the
>>>> flag.
>>>>
>>>> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
>>>
>>> Thanks for this!
>>>
>>> It looks good to me as an improvement as long as PG_mappedtodisk
>>> is long-term lived and useful to users.
>>>
>>> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
>>
> 
> thanks!
> 
>> BTW, I wonder if iomap supports this since uncompressed EROFS
>> relies on iomap paths...
> 
> In the core layer, I only see fs/buffer.c's block_read_full_folio()
> and fs/mpage.c's mpage_readahead() and mpage_readahead()
> supporting this. I haven't found any code in iomap that sets the
> flag.
> 
> I guess erofs doesn't call the above functions for non-compressed
> files?

mpage are obsoleted interfaces (of course EROFS could use
them instead, see my backport to centos 7 [1]), and iomap
is used for recent unencoded I/O use cases.

It would be better to add support for iomap too, but I guess
PG_mappedtodisk has very few users in the upstream kernel,
so they might ask for further use cases tho ;-)

Thanks,
Gao Xiang

[1] https://github.com/erofs/kmod-erofs/blob/main/src/data.c#L249

> 
>>
>> Thanks,
>> Gao Xiang
> 
> Barry

