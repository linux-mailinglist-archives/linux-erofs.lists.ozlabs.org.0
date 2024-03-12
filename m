Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED5F8795DA
	for <lists+linux-erofs@lfdr.de>; Tue, 12 Mar 2024 15:16:15 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=G/ta4A76;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TvG0F2JFdz3dSJ
	for <lists+linux-erofs@lfdr.de>; Wed, 13 Mar 2024 01:16:13 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=G/ta4A76;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.97; helo=out30-97.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TvG035LSdz3bsn
	for <linux-erofs@lists.ozlabs.org>; Wed, 13 Mar 2024 01:16:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710252956; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=0XVjU05muQ/IZvsDL+avnJjvmc19VXb+jh3kRaCLsj0=;
	b=G/ta4A76ZkrNzF3vbn/Tzqu7kDVxK0+wn6QCcGxzo6d4M94LML5u8DnaE7ZOosV1fkTRiwZK41hRw8vhw1ThWWWgbR36/IlpGFCoPPZrSjikHyaorT45XbkdpP33+cmUwaoyZbbGbG1KICm7YbX8QyZJc+VSK44gZVJ5xytTlsc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0W2M5yeo_1710252954;
Received: from 30.25.206.44(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W2M5yeo_1710252954)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 22:15:55 +0800
Message-ID: <4dfda4c0-4dab-4517-879e-72af0981f474@linux.alibaba.com>
Date: Tue, 12 Mar 2024 22:15:53 +0800
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
 <12bdda23-6450-4a16-8515-6dc180a890a3@linux.alibaba.com>
 <876af3499c628f385de3416788754cdb38962471.camel@manchester.ac.uk>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <876af3499c628f385de3416788754cdb38962471.camel@manchester.ac.uk>
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



On 2024/3/12 21:14, Gael Donval wrote:
> On Tue, 2024-03-12 at 20:43 +0800, Gao Xiang wrote:
>>

...

>> Yes, but that needs a new version (maybe erofs-utils 1.8) though.
> 
> Of course!
> 
>>
>> Also I'm not sure how tar --xattrs works for "btrfs.compression",
>> does it also work in a relaxed mode? Could you give more inputs
>> & tries with "tar --xattrs"?
> 
> Tar just stores XATTRS as their own field. When I
> 
>     $ tar --xattrs -cf foo.tar foo
> 
> and inspect the tar file it appears XATTRS are stored as arbitrary
> SCHILY attributes:
> 
>     ./PaxHeaders/foo0000644000000000000000000000020114574033222010776
>     xustar0030 mtime=1710241426.458097911
>     30 atime=1710241426.458097911
>     30 ctime=1710241426.458097911
>     39 SCHILY.xattr.btrfs.compression=zstd
>     foo/0000755000175000017500000000000014574033222011551
>     5ustar00gdonvalgdonval
>     [...]
> 
> So tar blindly serializes everything.
> 
> 
>>
>>>
>>> Is there anything the BTRFS people could do to make their FS easier
>>> to
>>> work with?
>>
>> Nope, I think it's unrelated to BTRFS but such xattrs are almost
>> meaningless for EROFS to keep (since they are their own xattrs.)
> 
> Ah that's interesting.
> 
> I suspect that in this instance the xattrs would not be useful at all
> but other components like SELinux uses xattrs to perform MAC and who
> knows what other xattrs-based schemes exist out there...

EROFS will keep common xattrs like selinux, but EROFS doesn't keep
btrfs. namespace (or other arbitrary xattr namespaces) like other
filesystems like ext4, xfs, f2fs, squashfs, etc.  EROFS only supports
"user.", "trusted." and some "system." domains.  In other words, If
EROFS has its own xattr namespace, I think other fses won't support
"erofs." too, also see:

https://lore.kernel.org/r/20230420092739.75464-1-o451686892@gmail.com

Because that is simple, you don't even know if the content in some
arbitrary namespace is static or dynamic.  Or if it has some security
issue to keep them.

> 
> Would it make sense then to do what tar does and blindly serialize (and
> expose) everything and provide a --xattrs-exclude=pattern in case
> people want something more fine-grained?

As I said above.

Thanks,
Gao Xiang

> 
> The only main problem currently is that erofs tries to be smart about
> xattrs and errors out when it does not know about something. It should
> really be more graceful.> 
> Thanks,
> Gaël
> 
> 
>>
>> Thanks,
>> Gao Xiang
>>
>>>
>>> Gaël
>>>
>>>>
>>>> Thanks,
>>>> Gao Xiang
>>>>
>>>>> Thanks for your help,
>>>>> Gaël
>>>>>
>>>>>
>>>
> 
