Return-Path: <linux-erofs+bounces-532-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD09AFA01C
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Jul 2025 14:53:59 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bZ9Rl353Bz2y06;
	Sat,  5 Jul 2025 22:53:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.119
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751720035;
	cv=none; b=bj9Eq1CovidQz0+0FQcbPlmmZOiA222sLGC1kkt2HNdHTFC2ARsvhSBrddU4io3mtJcm8ySKSoe90VMop6p8FyopjdZwO4msdbpQ884zCkSsZx54GdRtEJsYTYDrx8YcLnf4g0FJTOhBWEQQyIZPJF9YOma964PIrqTyrLqAA0lhABoLt0eTUS5+uIFyFoZNTehovd+AO3o/2aALBKoOIJJoJsesZ36Cm/mlMsKryb03nGhbSwF40NtW4VvVSNG0KNBHVDAs65L01yIPaKHKfULvPQwgtRJ/sbPbx8KeaC4DpawSyc78zdx0kQZL98b89BEqLoYO1qJMmoqSc8e9QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751720035; c=relaxed/relaxed;
	bh=juLHIhc6Kg7XwmirEVvDNY2x5c6t4QUT4lg69+0ZoNA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Umx3bu1PJ3lZ6+WVzNNaJg+wpnhvhsKvgE7vhpN+oR6E9XvLmPV4i8kAQKsWfzVIMYTR+7C4+AvnNYnZ/cb6mAh6pwhQtjM9AXHLFpT5panol88ozYe+FD//l6GzT7fHwIEn3gTs6xoSXsc3MOW+cKVlxFQCPOC8PLNdyl1EVn3n8M1HYFJlfbi+MNWZ/MGU2IGtnoZII1yVqPgsyBTIMOW5VrspI1TW2apgSm8ekWghN7Di1cvHsgS2GR3xp5AYJBoPXgM82omoSNF5mQyyAJMY4cJgcoOf1H1Tk+v2X7OV2rmKzAJlql8He2cX17f+AlbJlBkKw2qQry8TBQPPoA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sCy/oKWC; dkim-atps=neutral; spf=pass (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=sCy/oKWC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.119; helo=out30-119.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bZ9Rj3skJz2xQ4
	for <linux-erofs@lists.ozlabs.org>; Sat,  5 Jul 2025 22:53:52 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751720028; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=juLHIhc6Kg7XwmirEVvDNY2x5c6t4QUT4lg69+0ZoNA=;
	b=sCy/oKWCWE/hoKCbK0U6/IV59K8suBN4M4szHAE7y9RNklaSMFNNk5YmM0UJOW2YFnlQKqzIJV9MoffMguTJUdTsx//9aWtPNEuxysqDdFMzmcmAbrxkJogLp14AHxcf8tiIiij6qI01DB4SCb71w/eVev85LmiTCkzyq9NE9Yw=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WhYUKJp_1751720025 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 05 Jul 2025 20:53:46 +0800
Message-ID: <91cf62b5-45d5-40b6-b4e4-ec768f850361@linux.alibaba.com>
Date: Sat, 5 Jul 2025 20:53:44 +0800
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 2/4] erofs: introduce page cache share feature
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
 Hongzhen Luo <hongzhen@linux.alibaba.com>,
 Daan De Meyer <daan.j.demeyer@gmail.com>,
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>,
 =?UTF-8?Q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
 lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org,
 Gao Xiang <xiang@kernel.org>, Jan Kara <jack@suse.cz>,
 Jeff Layton <jlayton@kernel.org>, Matthew Wilcox <willy@infradead.org>
References: <20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org>
 <20250703-work-erofs-pcs-v1-2-0ce1f6be28ee@kernel.org>
 <12e59170-7435-4fae-a485-9cb105c378d1@linux.alibaba.com>
 <CAOQ4uxhhDS2XAKNnENEWfDrbp6+SX7Q_BY9OLo4QA4Jf0fHuvw@mail.gmail.com>
 <33817204-2455-4b8b-940e-072fad58191d@linux.alibaba.com>
 <CAOQ4uxjFcw7+w4jfjRKZRDitaXmgK1WhFbidPUFjXFt_6Kew5A@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAOQ4uxjFcw7+w4jfjRKZRDitaXmgK1WhFbidPUFjXFt_6Kew5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/5 20:34, Amir Goldstein wrote:
> On Sat, Jul 5, 2025 at 12:58 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> Hi Amir,
>>
>> On 2025/7/5 16:25, Amir Goldstein wrote:
>>
>> ...
>>
>>>
>>> 2. When is it ok to use the backing_file helpers?
>>>
>>> The current patch allocates a struct file with
>>> alloc_file_pseudo() and not a struct backing_file,
>>> so using the backing_file helpers is going to be awkward and
>>> misleading and I think in this case it will we wize to refrain
>>> from using a local var name backing_file.
>>>
>>> The thing that you need to ask yourself is do you want
>>> backing_file_set_user_path() for the erofs shared inode.
>>
>> Yes, agreed, that should be improved as you said.
>>
>>>
>>> That means, what do you want users to see when they
>>> look at /proc/self/map_files symlinks.
>>>
>>> With the current patch set I believe they will see a symlink to
>>> something like "[erofs_pcs_f]" for any mapped file
>>> which is somewhat odd.
>>
>> Agreed.
>>
>>>
>>> I think it would have been nice if users saw something like
>>> "[erofs_pcs_md5digest:XXXXXXX]"
>>
>> But if we use `overlay.metacopy` for example, it's not
>> a string anymore. IOWs, I'd like to support binary
>> footprint too.
>>
>> And I tend to avoid md5 calcuation or something in
>> the kernel.  The kernel just uses footprint xattrs
>> instead.
>>
>>> IMO, making the page cache dedupe visible in map_files is
>>> a very nice feature.
>>>> Overlayfs took the approach that users are expecting to see
>>> the actual path of the (non-anonymous) file that they mapped
>>> when looking at map_files symlinks.
>>> If you do not display the path to erofs mount in map_files,
>>> then lsof will not be able to blame a process with mapped files
>>> as the reason for keeping erofs mount busy.
>>
>> I think users should see `the actual path` rather than
>> "[erofs_pcs_xxxxx]" too, but I don't have any chance to
>> check this part yet.
>>
>> If it's possible for overlayfs, I guess it's possible for
>> erofs page cache sharing, maybe?
>>
> 
> Yes, I am sorry if that wasn't clear.
> If you want the map_files to show the user mapped file's path,
> you can use the backing_file helpers and more specifically
> backing_file_open() and all should work as in overlayfs.

Yep, makes sense, and a quick look I think we should leverage
`file_real_path()` to reveal the user-shown file's path.

But I also think erofs don't need every backingfile infra as
you said we don't need to override_creds and call in the
underlay fs but that use erofs io directly instead.

> 
> Obviously, you'd need to wrap the back_file helper with
> erofs specific logic, such as don't allow dio and such.

I think maybe only `struct backing_file` is really needed
to support the user mapped file's path.

Other thing it seems a overkill to use `fs/backing-file.c`
for inode page cache use cases.

Also, maybe I misunderstand your point. I think DIO can
work too, .read_iter() should be per-sb and we may just
use the original DIO logic and pass down iocb and iov etc?
Since only mmap i/o needs to be handled via anon inodes.

Thanks,
Gao Xiang

> 
> Thanks,
> Amir.


