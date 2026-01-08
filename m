Return-Path: <linux-erofs+bounces-1711-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B348D0197D
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 09:34:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmyrT0R4Vz2xcB;
	Thu, 08 Jan 2026 19:34:49 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767861288;
	cv=none; b=DWfm02t4u0kuW9PYMsxnStqGzwtfHB72MAraGd8rtZzfrTlxVm9IxtVqN9m6akDpmiorB8RaFvmoEU+pnGS5IPCLAybMg3ZF2Oqvvpnu+rqCQYXBl5uj/h1tSSBl+JFjVulXi7uPRFhavoxqavZLACaCfa4KMWmoVfyW60+xjO2aKSzKzXI6io5iweeBJpmJizJYEZD8r5tiw8ytT45co8uGCcVwn99aGu86AJj+QJFcANJ72VvbbLyL8OWuiO0MiDAvmjWTb+E5h1mkj/ZGPlO7vEKA2cJ0moa/LrdvwWvyK/8VFT35hrGijfmDRuFmUrahCjV3rzS2ciPxMdC/zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767861288; c=relaxed/relaxed;
	bh=JkY3oC0eOHfcTpAG17pfNlixKjvrWkpS4f3clKIGIaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KbI8y6ARO05I0U4/Cngn05/tsxo4x+fuIAkhejbVb8G1jlmcJWkYSPKP+cq9jOsUqgRo0zVHmU+uxE+j9AP1NJkd7/zBLOFiQoG9+9nos3Ip3YBPYvbqn/U2u3SLVLehhb3nuJ+hgU+mlGQVejcRuB4JGowzz/6IRO1zsP9kZXOFuTGdnIQM7Zzhx+ID3XYdzactQ17fIxPPwWTCfctLvOwnkxG4dpCTJH8woc+zI62YoBoQuG88rh4C5fjTNfkY83luSdZ1iRrqI0envq67wUuszeIb/GoVTTKJ4MaZ78cjAx2kRv7t40VXCpv7qPldj0ky7h3awgjaYeVUsXBryA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n6EucOB9; dkim-atps=neutral; spf=pass (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n6EucOB9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133; helo=out30-133.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmyrQ55hwz2xZK
	for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 19:34:44 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767861279; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=JkY3oC0eOHfcTpAG17pfNlixKjvrWkpS4f3clKIGIaM=;
	b=n6EucOB93oN24qgHUlz5RqB58YdO1ppF9MOjP630QfyAtGBVXI1QAK/5fHAOAIE27E9+Ix8lBwKNxnm2Q1JdCJOnGb8LoxVns5Fzl2DPbfNYoBS7rUQkA7NanQC7BDbR9DXqigIf+7cPKjfSDobWsp0wq5pT9mKEoh0pCK03TYs=
Received: from 30.221.132.104(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wwc.SPm_1767861275 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Jan 2026 16:34:37 +0800
Message-ID: <b1296059-0bc6-49eb-ae6c-15d60c7a8b89@linux.alibaba.com>
Date: Thu, 8 Jan 2026 16:34:35 +0800
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
To: Amir Goldstein <amir73il@gmail.com>
Cc: Sheng Yong <shengyong2021@gmail.com>, LKML
 <linux-kernel@vger.kernel.org>, linux-fsdevel
 <linux-fsdevel@vger.kernel.org>, Dusty Mabe <dusty@dustymabe.com>,
 =?UTF-8?Q?Timoth=C3=A9e_Ravier?= <tim@siosm.fr>,
 =?UTF-8?B?QWxla3PDqWkgTmFpZMOpbm92?= <an@digitaltide.io>,
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
 <CAOQ4uxgcbauFza8ZsZebhTZJT-zwfydy2ofWOw-hqJbVRF+GCg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAOQ4uxgcbauFza8ZsZebhTZJT-zwfydy2ofWOw-hqJbVRF+GCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2026/1/8 16:24, Amir Goldstein wrote:
> On Thu, Jan 8, 2026 at 9:05 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
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
> Your fs, your decision.
> 
> But what are you actually saying?
> Are you saying that reading from file backed fscache has similar
> stack usage to reading from file backed erofs?

Nope, I just don't want to be bothered with fscache in any
cases since it's already deprecated, IOWs I don't want such
setup works:
  erofs (file-backed) + erofs(fscache) + ...

I just want to allow
  erofs(APEX) + erofs(bdev) + ...

cases since Android users use it

in addition to
  ovl^2 + erofs + ext4 / xfs /... (composefs, containerd and ...)

Does that make sense?

> Isn't filecache doing async file IO?

But as I said, AIO is not a must, it can still
fallback to sync I/Os.

> 
> If we regard fscache an extra unaccounted layer, because of all the
> sync operations that it does, then we already allowed this setup a long
> time ago, e.g. fscache+nfs+ovl^2.
> 
> This could be an argument to support the claim that stack usage of
> file+erofs+ovl^2 should also be fine.

Anyway, I'm not sure how many users really use that so
I won't speak of that.

Thanks,
Gao Xiang

> 
> Thanks,
> Amir.


