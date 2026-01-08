Return-Path: <linux-erofs+bounces-1720-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF88FD02A2C
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 13:30:23 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dn44F471Fz2yGl;
	Thu, 08 Jan 2026 23:30:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.124
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767875421;
	cv=none; b=UReNXOZ6U1NV7WtPlIqBTCTFaxw6pj6R/adi40SBgsFbZkQkWqPzY8PrLQekHFEdAdD9/qfLutQBCJXDLq5k5mbXfJppgiH4Gwoq6tdiBJJ/P8VMcRhsTZnewy58x6NwoUsl9k7vdGI0K2rVIpSLQcciAO3TdU6OeTYQXfkJ+59mnnVtVPkDlFMnvfk7xMiyxIuWGo0dx5oMe+NHIjC8kuxjHKx9xemedwlCS6KyiB3wlrkZh4aBh964IXMc11M0Gf58mQNywmtjsNPMqqrp2P7YLT6e6MKd5ubYU+t1TnmWH1LcjGTWNkiTp1DcoCcaq6/zSdYzRXzZS8Me36TOHA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767875421; c=relaxed/relaxed;
	bh=rpTnL+IU5xSnUkIXNyhmHEj7xuQTvMOaA3Ro0rIO+c8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evOOIIlAPEW+1Dq5419C6K6m/eC4CyMIwV/mhr4eUp3aHLTF+wMYV5Lf1xxOSVM0LxtnG3oiBwTSjWcS7wVGrBUNf5AL4/n3YhwirDfAPUPdr9idSky9hEHGQh2FGy9ziihT49debEBvIvsUqHnKViu2ctpyw+/1SlOkVMTvwJvYbhXlhr7lMeYOh4S+HdAeGda6yKzm+OzkdpG26D/ClhNKscPRkJ2Thqtn87QN2MAJWnu0fTtZ5eBqYA6/CK5supt8cgoSkcDYoZ/6A0U7Slk7VrZieHUy3AZealj8knTIiTBTa6cPhdJpMdMBQU2ezMuyo44zloRwQP5qSJdLPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SJQrSbfl; dkim-atps=neutral; spf=pass (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SJQrSbfl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dn44C1cyHz2yGL
	for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 23:30:16 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767875411; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=rpTnL+IU5xSnUkIXNyhmHEj7xuQTvMOaA3Ro0rIO+c8=;
	b=SJQrSbflQafUyBDi15TKZwsizGEmmyJWv0K0zCdLFU8DhDFYnsk1/PynsUtCfjaBeptwoEjCFc3U1MlBiTaCJvtnCgamA60xTPRIC95aLLNXMExLWH30yHOchXuFVemzn1RiViens6xQPIcwk6wyJJJLN7B8XiZQXLejIFuA+S8=
Received: from 30.251.32.236(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwcgDrv_1767875409 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Jan 2026 20:30:10 +0800
Message-ID: <c805ff35-654f-44e2-92ce-0e2c367ac377@linux.alibaba.com>
Date: Thu, 8 Jan 2026 20:30:08 +0800
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
Subject: Re: [PATCH v2] erofs: don't bother with s_stack_depth increasing for
 now
To: David Laight <david.laight.linux@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Sheng Yong
 <shengyong2021@gmail.com>, LKML <linux-kernel@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Dusty Mabe <dusty@dustymabe.com>, =?UTF-8?Q?Timoth=C3=A9e_Ravier?=
 <tim@siosm.fr>, =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>,
 Alexander Larsson <alexl@redhat.com>, Christian Brauner
 <brauner@kernel.org>, Miklos Szeredi <mszeredi@redhat.com>,
 Zhiguo Niu <niuzhiguo84@gmail.com>, shengyong1@xiaomi.com,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
References: <0c34f3fa-c573-4343-b8ea-6832530f0069@linux.alibaba.com>
 <20260106170504.674070-1-hsiangkao@linux.alibaba.com>
 <3acec686-4020-4609-aee4-5dae7b9b0093@gmail.com>
 <41b8a0bb-96d3-4eba-a5b8-77b0b0ed4730@linux.alibaba.com>
 <121cb490-f13a-4957-97be-ea87baa10827@linux.alibaba.com>
 <CAOQ4uxg14FYhZvdjZ-9UT3jVyLCbM1ReUdESSXgAbezsQx7rqQ@mail.gmail.com>
 <4b427f6f-3b26-4dc8-bf6f-79eeabf6ba84@linux.alibaba.com>
 <20260108102613.33bbc6d4@pumpkin>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20260108102613.33bbc6d4@pumpkin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi David,

On 2026/1/8 18:26, David Laight wrote:
> On Thu, 8 Jan 2026 16:05:03 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
>> Hi Amir,
>>
>> On 2026/1/8 16:02, Amir Goldstein wrote:
>>> On Thu, Jan 8, 2026 at 4:10 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> ...
>>
>>>>>>
>>>>>> Hi, Xiang
>>>>>>
>>>>>> In Android APEX scenario, apex images formatted as EROFS are packed in
>>>>>> system.img which is also EROFS format. As a result, it will always fail
>>>>>> to do APEX-file-backed mount since `inode->i_sb->s_op == &erofs_sops'
>>>>>> is true.
>>>>>> Any thoughts to handle such scenario?
>>>>>
>>>>> Sorry, I forgot this popular case, I think it can be simply resolved
>>>>> by the following diff:
>>>>>
>>>>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>>>>> index 0cf41ed7ced8..e93264034b5d 100644
>>>>> --- a/fs/erofs/super.c
>>>>> +++ b/fs/erofs/super.c
>>>>> @@ -655,7 +655,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>>>>                     */
>>>>>                    if (erofs_is_fileio_mode(sbi)) {
>>>>>                            inode = file_inode(sbi->dif0.file);
>>>>> -                       if (inode->i_sb->s_op == &erofs_sops ||
>>>>> +                       if ((inode->i_sb->s_op == &erofs_sops && !sb->s_bdev) ||
>>>>
>>>> Sorry it should be `!inode->i_sb->s_bdev`, I've
>>>> fixed it in v3 RESEND:
>>>
>>> A RESEND implies no changes since v3, so this is bad practice.
>>>    
>>>> https://lore.kernel.org/r/20260108030709.3305545-1-hsiangkao@linux.alibaba.com
>>>>   
>>>
>>> Ouch! If the erofs maintainer got this condition wrong... twice...
>>> Maybe better using the helper instead of open coding this non trivial check?
>>>
>>> if ((inode->i_sb->s_op == &erofs_sops &&
>>>         erofs_is_fileio_mode(EROFS_I_SB(inode)))
>>
>> I was thought to use that, but it excludes fscache as the
>> backing fs.. so I suggest to use !s_bdev directly to
>> cover both file-backed mounts and fscache cases directly.
> 
> Is it worth just allocating each fs a 'stack needed' value and then
> allowing the mount if the total is low enough.
> This is equivalent to counting the recursion depth, but lets erofs only
> add (say) 0.5.
> Ideally you'd want to do static analysis to find the value to add,
> but 'inspired guesswork' is probably good enough.

That is a good alternative way but I could also use some
realistic issue such as how to evaluate stack usage under
the block layer.

And the rule exposing to userspace becomes complex if we
do in such way.

> 
> Isn't there also a big difference between recursive mounts (which need
> to do read/write on the underlying file) and overlay mounts (which just
> pass the request onto the lower filesystem).

As for EROFS, we only care read since it's safe enough
but I won't speak of write paths (like sb_writers and
journal nesting for example, and I don't want to spread
the discussion since it's much unrelated to the topic).

I agree but as I said above, it makes the rule more
complex and users have no idea when it can mount and
when it cannot mount.

Anyway, I think for the current 16k kernel stack,
FILESYSTEM_MAX_STACK_DEPTH = 3 is safe enough to provide
an abundant margin for the underlay storage stack.
I have no idea how to prove it strictly but I think it's
roughly provable to show the stack usages when reaching
the real backing fs (e.g. the remaining stack size when
reaching the real backing fs) and
FILESYSTEM_MAX_STACK_DEPTH 2 was an arbitary one too.

Thanks,
Gao Xiang

> 
> 	David
> 
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> Thanks,
>>> Amir.
>>
>>


