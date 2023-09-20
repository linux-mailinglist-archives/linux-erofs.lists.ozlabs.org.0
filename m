Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 987D47A71FA
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 07:24:52 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rr6RQ3F4Rz3byh
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 15:24:50 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.112; helo=out30-112.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rr6RH5Lrdz2yNX
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Sep 2023 15:24:40 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VsTpY3k_1695187474;
Received: from 30.97.48.198(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VsTpY3k_1695187474)
          by smtp.aliyun-inc.com;
          Wed, 20 Sep 2023 13:24:35 +0800
Message-ID: <f20142f6-a47a-4c73-b5c1-48afa318940b@linux.alibaba.com>
Date: Wed, 20 Sep 2023 13:24:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: Optimizing write_uncompressed_file_from_fd()
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Daan De Meyer <daan.j.demeyer@gmail.com>, linux-erofs@lists.ozlabs.org
References: <CAO8sHcmZZORnrJXA=QzmGkYNkNWn7M+amAK_DZ19-WL4kLUvpw@mail.gmail.com>
 <70e8cf13-7824-c54b-9b93-46b7302b9a5a@linux.alibaba.com>
In-Reply-To: <70e8cf13-7824-c54b-9b93-46b7302b9a5a@linux.alibaba.com>
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

Hi Daan,

On 2023/8/31 17:48, Gao Xiang wrote:
> Hi Daan,
> 
> On 2023/8/31 17:33, Daan De Meyer wrote:
>> Hi,
>>
>> For hacking on systemd, we build disk images using mkosi, and use an erofs filesystem for the /usr directory. When hacking on systemd, we would like to be able to rebuild the disk image as fast as possible. One part of rebuilding the image that takes a while is generating the erofs filesystem. I had a look at the mkfs source code for erofs and noticed that in
>> write_uncompressed_file_from_fd(), there is no usage of FICLONERANGE or copy_file_range() to speed up copying data from the filesystem to the erofs filesystem. Would it be possible to use either of these to make copying data in mkfs.erofs faster when the data does not need to be compressed?
> 
> Thanks for the email!
> 
> Yes, that is indeed useful, actually mmap I/Os can be used
> to boost up write_uncompressed_file_from_fd () as well...
> Actually many enhancements are limited by the current
> development resource (multithreaded compression support might
> be the top-1 priority for userspace side from end users),
> but I have to resolve them one-by-one since EROFS is still a
> quite young project compared to other approaches and beyond
> the original targeted use cases (so most Android vendors won't
> pay any attention to improvements that are not critically
> important for their scenarios.)
> 
> I mostly focus on some kernel improvements since Google needs
> us to support 16k page size + 4k EROFS block size.  That is
> currently my top thing to resolve first...
> 
> (quite limited by real world time...)

I already checked this part, it optimizes about 100ms for
the linux source code tree on my own developping machine.

Also after some profiling, there are some other stuffs that
needs to be optmized as well (e.g. optimize metadata write
counts)

Anyway, I'm about releasing erofs-utils v1.7.  I tend to
resolve this in the next version and there are a lot
TODOs on my side.

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
>>
>> Cheers,
>>
>> Daan De Meyer
