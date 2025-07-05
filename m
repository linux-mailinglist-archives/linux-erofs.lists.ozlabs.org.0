Return-Path: <linux-erofs+bounces-534-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C15AFA0A9
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Jul 2025 17:14:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bZDZ15gCBz2y06;
	Sun,  6 Jul 2025 01:14:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.30.112
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751728473;
	cv=none; b=D7TVXW0x28SJbf6MONIWGmKW5S95YdGoP6XFe3KFHtFF8u7l6k/D8r31pNRV87Fk59/5AapasObYrLSfhZcrRESSFlaH2bP27u9ZUZ7x1UnsiJSy0fgFkgaz4XOWTAPoqgyXyaS98f+37CykF9qbu3asMjGswsXGk9J5wPwdicSIEogQmFix5MHjKY9YWtFAvO9CyXEDVhtjKKyo6D1kT8ui04GIJJu/1tg7U4m2eTkLTqBc0vqxELwLdb5NQX9dVpPIl8Vz+GBJu3Y7a9h+2jiIGT+baqxkpDdKHO56cKHinWPloiUu5GsV2O6KQz1SezElIwK8+flUnZIZHN62nA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751728473; c=relaxed/relaxed;
	bh=6IH2FTdtCkWQwRoANalTM9eNkJzdpbT2TLP1ZIM/3aY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NY7bT+hqNgoz6RGXfaI9tF8VFgbKjPxu+BkjNWjQf8+qe2hOV4S4pDNirhLBaH8A7rfnHdVQGECKPzoecvcdlrl3g/97tOuHPXrp1bbrDjuaqUp6/YY2MBvInmYpqp8WgSvu4tqYhsL/01iHcRUWTxWP7eo6KskyhQ4tU6UN61ucodLnvqbayq1vFfoy3iBZm45RXlF6yKa/7/sW1R8duE2OoMTykqRDXQLNUCjtZotZjhHaeAzFPfkItFNcWZOMLk4s3F3shOF2+b3mBMuiPBsxatDSn4Bx4LJHDMTtM4QtoWuYpdAmm/V5vgNm/IW7KVoHhGiLbVlblFnGxGljOg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PtaGuKLu; dkim-atps=neutral; spf=pass (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.alibaba.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=PtaGuKLu;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bZDYz5kgvz2xHZ
	for <linux-erofs@lists.ozlabs.org>; Sun,  6 Jul 2025 01:14:30 +1000 (AEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1751728465; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=6IH2FTdtCkWQwRoANalTM9eNkJzdpbT2TLP1ZIM/3aY=;
	b=PtaGuKLuYavWeRLH04f71NCTocn4pjxpg0Qz1Y8Jspk6Sr0IQes3zOsN8rH38iyyPsQwET1SUXWOXDVzduU6ePLRx/13Gyo4AIQQo/nCrdiERINrga8siTzlmdxNIVoGuUulhwF+qP2fBW2Wyeatwydsi4ps/X2Z2c2RQvJXRYU=
Received: from 30.170.233.0(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WhaXNuc_1751728462 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 05 Jul 2025 23:14:23 +0800
Message-ID: <f1a02047-8db5-4d77-8873-ff8378f4d2bc@linux.alibaba.com>
Date: Sat, 5 Jul 2025 23:14:21 +0800
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
 <91cf62b5-45d5-40b6-b4e4-ec768f850361@linux.alibaba.com>
 <CAOQ4uxi3WK77ezJiYt+evBwh1TH0OTUSNw+CD6e2VEdy_e2pew@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAOQ4uxi3WK77ezJiYt+evBwh1TH0OTUSNw+CD6e2VEdy_e2pew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-15.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org



On 2025/7/5 21:53, Amir Goldstein wrote:
> On Sat, Jul 5, 2025 at 2:53 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>>
>>
>> On 2025/7/5 20:34, Amir Goldstein wrote:
>>> On Sat, Jul 5, 2025 at 12:58 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>>>
>>>> Hi Amir,
>>>>
>>>> On 2025/7/5 16:25, Amir Goldstein wrote:
>>>>
>>>> ...
>>>>
>>>>>
>>>>> 2. When is it ok to use the backing_file helpers?
>>>>>
>>>>> The current patch allocates a struct file with
>>>>> alloc_file_pseudo() and not a struct backing_file,
>>>>> so using the backing_file helpers is going to be awkward and
>>>>> misleading and I think in this case it will we wize to refrain
>>>>> from using a local var name backing_file.
>>>>>
>>>>> The thing that you need to ask yourself is do you want
>>>>> backing_file_set_user_path() for the erofs shared inode.
>>>>
>>>> Yes, agreed, that should be improved as you said.
>>>>
>>>>>
>>>>> That means, what do you want users to see when they
>>>>> look at /proc/self/map_files symlinks.
>>>>>
>>>>> With the current patch set I believe they will see a symlink to
>>>>> something like "[erofs_pcs_f]" for any mapped file
>>>>> which is somewhat odd.
>>>>
>>>> Agreed.
>>>>
>>>>>
>>>>> I think it would have been nice if users saw something like
>>>>> "[erofs_pcs_md5digest:XXXXXXX]"
>>>>
>>>> But if we use `overlay.metacopy` for example, it's not
>>>> a string anymore. IOWs, I'd like to support binary
>>>> footprint too.
>>>>
>>>> And I tend to avoid md5 calcuation or something in
>>>> the kernel.  The kernel just uses footprint xattrs
>>>> instead.
>>>>
>>>>> IMO, making the page cache dedupe visible in map_files is
>>>>> a very nice feature.
>>>>>> Overlayfs took the approach that users are expecting to see
>>>>> the actual path of the (non-anonymous) file that they mapped
>>>>> when looking at map_files symlinks.
>>>>> If you do not display the path to erofs mount in map_files,
>>>>> then lsof will not be able to blame a process with mapped files
>>>>> as the reason for keeping erofs mount busy.
>>>>
>>>> I think users should see `the actual path` rather than
>>>> "[erofs_pcs_xxxxx]" too, but I don't have any chance to
>>>> check this part yet.
>>>>
>>>> If it's possible for overlayfs, I guess it's possible for
>>>> erofs page cache sharing, maybe?
>>>>
>>>
>>> Yes, I am sorry if that wasn't clear.
>>> If you want the map_files to show the user mapped file's path,
>>> you can use the backing_file helpers and more specifically
>>> backing_file_open() and all should work as in overlayfs.
>>
>> Yep, makes sense, and a quick look I think we should leverage
>> `file_real_path()` to reveal the user-shown file's path.
>>
>> But I also think erofs don't need every backingfile infra as
>> you said we don't need to override_creds and call in the
>> underlay fs but that use erofs io directly instead.
>>
> 
> True.
> 
>>>
>>> Obviously, you'd need to wrap the back_file helper with
>>> erofs specific logic, such as don't allow dio and such.
>>
>> I think maybe only `struct backing_file` is really needed
>> to support the user mapped file's path.
>>
>> Other thing it seems a overkill to use `fs/backing-file.c`
>> for inode page cache use cases.
> 
> True.
> 
>>
>> Also, maybe I misunderstand your point. I think DIO can
>> work too, .read_iter() should be per-sb and we may just
>> use the original DIO logic and pass down iocb and iov etc?
>> Since only mmap i/o needs to be handled via anon inodes.
>>
> 
> The title of the patch set is page cache sharing
> and DIO has nothing to do with page cache so I thought it
> wasn't relevant.
> 
> If the inodes are also sharing the backing disk blocks,
> then I guess you can do dio either on the shared inode
> or the original inode, but it doesn't matter much.
> 
> I meant that the only part of backing_file_read_iter()
> for which you may want to consider the helper is the aio
> part, but since aio is only for directo io, I think there is
> no real benefit of erofs to use the helper.

Agreed, thank you Amir!

Thanks,
Gao Xiang

> 
> Thanks,
> Amir.


