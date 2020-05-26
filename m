Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A7341E1FA8
	for <lists+linux-erofs@lfdr.de>; Tue, 26 May 2020 12:29:47 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49WVZb4Tw4zDqPT
	for <lists+linux-erofs@lfdr.de>; Tue, 26 May 2020 20:29:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=mykernel.net (client-ip=163.53.93.243;
 helo=sender2-op-o12.zoho.com.cn; envelope-from=cgxu519@mykernel.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=mykernel.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=mykernel.net header.i=cgxu519@mykernel.net
 header.a=rsa-sha256 header.s=zohomail header.b=Io4Trp7p; 
 dkim-atps=neutral
Received: from sender2-op-o12.zoho.com.cn (sender2-op-o12.zoho.com.cn
 [163.53.93.243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49WVZR0KZQzDqJH
 for <linux-erofs@lists.ozlabs.org>; Tue, 26 May 2020 20:29:32 +1000 (AEST)
ARC-Seal: i=1; a=rsa-sha256; t=1590488944; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=VOoRmmX1uIDsZjbExDPtuMwjUmE/nWRmhIwNLamRd1XlPNJtzYs9lmKhM7rslaHFYPjK/R2mALkOfCICup3jllsjZ1SPG4Mq+X39sPeppWqB5NLmGKbQMGVNTFKfHVcTsWiaG67SrQ5Pq+AiwLJpj6fXotNRQJSvYwWGeVNS45w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1590488944;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To;
 bh=P8irp18v5lKNuPnDqdAyjhKFRYNxhOeg48V9h21XVPs=; 
 b=MZZI0fwH+B/mXzC7NOonPPj5ZFKIjrnwnWneSsyFDyWf3j6AfzEDK0peWhj8gIACymLDNK3+JCypH6xagOmanPYK6VQfmIGKVn2whEd6KD+Zym6AFvLaBfU65ORsqsKrHkfclSeQ2oGFInN0aNdTyamcOnZ2KsCwNO870yrKu9c=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=mykernel.net;
 spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
 dmarc=pass header.from=<cgxu519@mykernel.net>
 header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1590488944; 
 s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
 h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
 bh=P8irp18v5lKNuPnDqdAyjhKFRYNxhOeg48V9h21XVPs=;
 b=Io4Trp7pCKpSpKpeT1rLqLaESZOCOa1uQlltHc7+KkvvfIgJtnPECXuaYOzKoWBR
 cSko11Xr7U+hp3qoDDB2QYnSS63zJvFcNGxXJjEZAGvRUHka5t7VV8Jx2+5C8HhOgQl
 N5Q17xlX4r4tzPpdX8w1J0PXLH61vKvj6dKcVjuk=
Received: from [192.168.166.138] (218.18.229.179 [218.18.229.179]) by
 mx.zoho.com.cn with SMTPS id 1590488941038691.6155128419869;
 Tue, 26 May 2020 18:29:01 +0800 (CST)
Subject: Re: [PATCH] erofs: code cleanup by removing ifdef macro surrounding
To: Gao Xiang <hsiangkao@redhat.com>
References: <20200526090343.22794-1-cgxu519@mykernel.net>
 <20200526094939.GB8107@hsiangkao-HP-ZHAN-66-Pro-G1>
From: cgxu <cgxu519@mykernel.net>
Message-ID: <4c4a7f7d-c3b7-9093-ae76-32ad258e29a6@mykernel.net>
Date: Tue, 26 May 2020 18:29:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200526094939.GB8107@hsiangkao-HP-ZHAN-66-Pro-G1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ZohoCNMailClient: External
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On 5/26/20 5:49 PM, Gao Xiang wrote:
> Hi Chengguang,
> 
> On Tue, May 26, 2020 at 05:03:43PM +0800, Chengguang Xu wrote:
>> Define erofs_listxattr and erofs_xattr_handlers to NULL when
>> CONFIG_EROFS_FS_XATTR is not enabled, then we can remove many
>> ugly ifdef macros in the code.
>>
>> Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
>> ---
>> Only compile tested.
>>
>>   fs/erofs/inode.c | 6 ------
>>   fs/erofs/namei.c | 2 --
>>   fs/erofs/super.c | 4 +---
>>   fs/erofs/xattr.h | 7 ++-----
>>   4 files changed, 3 insertions(+), 16 deletions(-)
>>
>> diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
>> index 3350ab65d892..7dd4bbe9674f 100644
>> --- a/fs/erofs/inode.c
>> +++ b/fs/erofs/inode.c
>> @@ -311,27 +311,21 @@ int erofs_getattr(const struct path *path, struct kstat *stat,
>>   
>>   const struct inode_operations erofs_generic_iops = {
>>   	.getattr = erofs_getattr,
>> -#ifdef CONFIG_EROFS_FS_XATTR
>>   	.listxattr = erofs_listxattr,
>> -#endif
> 
> It seems equivalent. And it seems ext2 and f2fs behave in the same way...

I posted similar patch for ext2 and Jack merged to
his tree the other day, though that series also
included a real bugfix. I also posted similar patch
to f2fs, so if erofs and f2fs merge these patches
then all three will behave in the same way, ;-)

You may refer below link for the detail.

https://lore.kernel.org/linux-ext4/20200522044035.24190-2-cgxu519@mykernel.net/


> But I'm not sure whether we'd return 0 (if I didn't see fs/xattr.c by mistake)
> or -EOPNOTSUPP here... Some thoughts about this? >
> Anyway, I'm fine with that if return 0 is okay here, but I'd like to know your
> and Chao's thoughts about this... I will play with it later as well.

Originally, we set erofs_listxattr to ->listxattr only
when the config macro CONFIG_EROFS_FS_XATTR is enabled,
it means that erofs_listxattr() never returns -EOPNOTSUPP
in any case, so actually there is no logic change here,
right?


Thanks,
cgxu

