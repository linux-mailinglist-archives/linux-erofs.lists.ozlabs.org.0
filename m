Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id B65C6879457
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Mar 2024 13:43:36 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Kk6oypxX;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TvCxL3qCyz3dRc
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Mar 2024 23:43:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=Kk6oypxX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TvCxF2HQqz3c9y
	for <linux-erofs@lists.ozlabs.org>; Tue, 12 Mar 2024 23:43:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710247403; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xtM9aY6SWYqjDROp4jwvC6V2Z3G8WDscA4P1tW8RqII=;
	b=Kk6oypxXFLd2XYQWCdSJ/tf56Fi1Le3Y78Ag8CvphqQ2D2DjHLYGjg2ItRnoOQKy7Xg3G5SG8QcS0W/WYM7C8gZZTwICiWYEln9MeiqN1FxTDL42qhwu3Ixqb0YxJpBOacWtC4AnLqUZPx9uCHHRL/QDg4ehlthkVhGl3uGgZy8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W2LwUhj_1710247400;
Received: from 192.168.33.9(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W2LwUhj_1710247400)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 20:43:21 +0800
Message-ID: <12bdda23-6450-4a16-8515-6dc180a890a3@linux.alibaba.com>
Date: Tue, 12 Mar 2024 20:43:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: mkfs.erofs fails (failed to build shared xattrs, err 61)
To: Gael Donval <gael.donval@manchester.ac.uk>,
 "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>
References: <4abed942399fb29933f0fa85cc55d3d795ae8bcd.camel@manchester.ac.uk>
 <57655d61-6ba7-4188-a96f-898cfadd7176@linux.alibaba.com>
 <2ee401fe-cbc7-446e-8d28-c79e3f95e886@linux.alibaba.com>
 <691120bfed626b78cc1107166f2fd964ca23ce99.camel@manchester.ac.uk>
 <25e533ad-e32c-419c-85c8-b8d4feb782a2@linux.alibaba.com>
 <fa2f6c2a5fa56a74f857329fb30e06f900c22358.camel@manchester.ac.uk>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <fa2f6c2a5fa56a74f857329fb30e06f900c22358.camel@manchester.ac.uk>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>



On 2024/3/12 20:01, Gael Donval wrote:
> On Tue, 2024-03-12 at 19:37 +0800, Gao Xiang wrote:
>>
>>
>> On 2024/3/12 19:07, Gael Donval wrote:
>>>> On 2024/3/12 18:44, Gao Xiang wrote:
>>>>> Hi Gael,
>>>>>
>>>>> On 2024/3/12 17:57, Gael Donval wrote:
>>>>>> Dear list,
>>>>>>
>>>>>>       $ mkdir foo && touch foo/bar && mkfs.erofs foo.erofs.img
>>>>>> foo
>>>>>>       mkfs.erofs 1.7.1
>>>>>>       <E> erofs: failed to build shared xattrs: [Error 61] No
>>>>>> data
>>>>>> available
>>>>>>       <E> erofs:     Could not format the device : [Error 61]
>>>>>> No
>>>>>> data available
>>>>>> That is at a location backed by BTRFS (btrfs-progs v6.7.1) on
>>>>>> kernel 6.8.0.
>>>>>>
>>>>>> If I use a TMPFS-supported folder instead all goes well.
>>>>>>
>>>>>>
>>>>>> Of course (NB "-x-1"),
>>>>>>
>>>>>>       $ mkdir foo && touch foo/bar && mkfs.erofs -x-1
>>>>>> foo.erofs.img
>>>>>> foo
>>>>>>
>>>>>> also works but is not how mkfs.erofs is meant to work in the
>>>>>> general case.
>>>>>
>>>>> Thanks for your feedback.
>>>>>
>>>>> Currently I don't have some BTRFS environment, I could set up
>>>>> one
>>>>> later.
>>>>> Yet in parallel could you provide a full message of
>>>>> "strace mkfs.erofs -x-1 foo.erofs.img foo" on BTRFS too?
>>>>
>>>> sorry, I meant "strace mkfs.erofs foo.erofs.img foo"
>>>
>>> Hi,
>>>
>>> Here it is.
>>>
>>
>> The problem here is that BTRFS could extract their internal
>> xattrs ("inode properties") in their own namespace which
>> don't belong to the original file itself like:
>>
>> XATTR_BTRFS_PREFIX "compression" -> btrfs.compression = zstd
>>
>> I think I need to introduce something to formally ignore
>> these xattrs like: `--xattrs-exclude=pattern`:
>> https://urldefense.com/v3/__https://www.gnu.org/software/tar/manual/html_node/Extended-File-Attributes.html__;!!PDiH4ENfjr2_Jw!Dqu_tH2zT_TKEhHNi2CZToYlmYFeZayWE1BQVQjZBZq4egjYS1bAVS7BasQJ9BETJoVINPEB-p06y7izIUmWk-2VnofOQZwLrw$
>>   [gnu[.]org]
> 
> I think that could work but a mode where EROFS keep the XATTRS it
> recognises and ignore the ones it doesn't would probably prove useful
> in the general case.
> 
> I would suggest a --strict-xattrs mode behaving like it does today,
> requiring explicit --xattrs-exclude to whitelist XATTRS.
> 
> The default would be a relaxed mode where ignored XATTRS are reported
> on stderr at INFO level. Would that make sense and be alright?

Yes, but that needs a new version (maybe erofs-utils 1.8) though.

Also I'm not sure how tar --xattrs works for "btrfs.compression",
does it also work in a relaxed mode? Could you give more inputs
& tries with "tar --xattrs"?

> 
> Is there anything the BTRFS people could do to make their FS easier to
> work with?

Nope, I think it's unrelated to BTRFS but such xattrs are almost
meaningless for EROFS to keep (since they are their own xattrs.)

Thanks,
Gao Xiang

> 
> Gaël
> 
>>
>> Thanks,
>> Gao Xiang
>>
>>> Thanks for your help,
>>> Gaël
>>>
>>>
> 
