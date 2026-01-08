Return-Path: <linux-erofs+bounces-1709-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C42D0180D
	for <lists+linux-erofs@lfdr.de>; Thu, 08 Jan 2026 09:05:18 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4dmyBM5fkTz2yG3;
	Thu, 08 Jan 2026 19:05:15 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1767859515;
	cv=none; b=UNkVSZ9FPsJ3T7vVoqvNTFiFI13u7fY5c2edqecyJTzsWx7P8j2M85TUJuDdGBRCB1/n28IhQzva+vykDVxxUIAxNtfuXddnurVsIi0me0sSPFBDu86WU6NK9a6vAdaLsMqsMGw23LHuir11MfYDh7jkLr6cgJRj3hsJJ3vHuIqpXM9IDOwOTDw28bra/LPp/EcqbIjFXiC/6FHv8kfwDkTw/lPqg93HWmvilfvZC2+iBL/uRLF47uqT+9vO+WG+3wB+sf97kPz1tZnN9ySvgZqfoMsBaLvWaGUuwok2vG4/PkeeXRPOW1jy5lDlFT1Wm545uT4mgRTkASQxweV8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1767859515; c=relaxed/relaxed;
	bh=CHryCxdnsqo2fHXKwdwy6HGEwzhP78fiP+irxJgS+DE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWtRflHvmBTLEYyAS2ntPOTOEATXqzxteTu6tljS6KDBETFnUX1BcH+f2nQOWxEvsrUUC71tkQLTLe+dRa1QtLo5fV5Fl6HcPdzdzRtFnRbuAmFyDylLGg87m9O0dLS0Fv93Y/yJs9WJzGHOiVGbXipFM3BvDs8d7lLdoF2hHOOoB9uX9PoOC3Gj7mbFOUtCn91TGNpJbTU5EaCsTJAC6gUbzVBT0C4kSzu/T/qjPGeKBSc0H9LfLOd30rjFFj+ubtz40zOvMyQZBXovfSa+fJOiUBWyOUGnodJc0EqMYZkXyY87koBfhcwz2NykpyiOHTZG6GqTAwXlKOMjENDYDQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cdBnrbSF; dkim-atps=neutral; spf=pass (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=cdBnrbSF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.113; helo=out30-113.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4dmyBJ63Yzz2xjN
	for <linux-erofs@lists.ozlabs.org>; Thu, 08 Jan 2026 19:05:11 +1100 (AEDT)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1767859506; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CHryCxdnsqo2fHXKwdwy6HGEwzhP78fiP+irxJgS+DE=;
	b=cdBnrbSFaGZnl/mx/BPnQWG9sI5fVdocCSPNu05nXsyltWMOayqu5q3CIcBjN+RQWYA1O5e/qJYh8kdbw3VXO7EM9v4FZQNEy2hVo8E7PXfWX74OtlGQO/LloV1+V1g+844L1OaJS9Y7RWRLJ7/n/irz2hqICLVqooYiqqBMPvI=
Received: from 30.221.132.104(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WwbyGqs_1767859503 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 08 Jan 2026 16:05:05 +0800
Message-ID: <4b427f6f-3b26-4dc8-bf6f-79eeabf6ba84@linux.alibaba.com>
Date: Thu, 8 Jan 2026 16:05:03 +0800
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
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAOQ4uxg14FYhZvdjZ-9UT3jVyLCbM1ReUdESSXgAbezsQx7rqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Hi Amir,

On 2026/1/8 16:02, Amir Goldstein wrote:
> On Thu, Jan 8, 2026 at 4:10 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

...

>>>>
>>>> Hi, Xiang
>>>>
>>>> In Android APEX scenario, apex images formatted as EROFS are packed in
>>>> system.img which is also EROFS format. As a result, it will always fail
>>>> to do APEX-file-backed mount since `inode->i_sb->s_op == &erofs_sops'
>>>> is true.
>>>> Any thoughts to handle such scenario?
>>>
>>> Sorry, I forgot this popular case, I think it can be simply resolved
>>> by the following diff:
>>>
>>> diff --git a/fs/erofs/super.c b/fs/erofs/super.c
>>> index 0cf41ed7ced8..e93264034b5d 100644
>>> --- a/fs/erofs/super.c
>>> +++ b/fs/erofs/super.c
>>> @@ -655,7 +655,7 @@ static int erofs_fc_fill_super(struct super_block *sb, struct fs_context *fc)
>>>                    */
>>>                   if (erofs_is_fileio_mode(sbi)) {
>>>                           inode = file_inode(sbi->dif0.file);
>>> -                       if (inode->i_sb->s_op == &erofs_sops ||
>>> +                       if ((inode->i_sb->s_op == &erofs_sops && !sb->s_bdev) ||
>>
>> Sorry it should be `!inode->i_sb->s_bdev`, I've
>> fixed it in v3 RESEND:
> 
> A RESEND implies no changes since v3, so this is bad practice.
> 
>> https://lore.kernel.org/r/20260108030709.3305545-1-hsiangkao@linux.alibaba.com
>>
> 
> Ouch! If the erofs maintainer got this condition wrong... twice...
> Maybe better using the helper instead of open coding this non trivial check?
> 
> if ((inode->i_sb->s_op == &erofs_sops &&
>        erofs_is_fileio_mode(EROFS_I_SB(inode)))

I was thought to use that, but it excludes fscache as the
backing fs.. so I suggest to use !s_bdev directly to
cover both file-backed mounts and fscache cases directly.

Thanks,
Gao Xiang

> 
> Thanks,
> Amir.


