Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C4C78E9C5
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 11:49:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RbxFZ5vtBz3bT8
	for <lists+linux-erofs@lfdr.de>; Thu, 31 Aug 2023 19:49:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.98; helo=out30-98.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RbxFS08Y0z3bT8
	for <linux-erofs@lists.ozlabs.org>; Thu, 31 Aug 2023 19:48:59 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0Vqxsgrf_1693475330;
Received: from 30.97.49.22(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vqxsgrf_1693475330)
          by smtp.aliyun-inc.com;
          Thu, 31 Aug 2023 17:48:52 +0800
Message-ID: <70e8cf13-7824-c54b-9b93-46b7302b9a5a@linux.alibaba.com>
Date: Thu, 31 Aug 2023 17:48:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: Optimizing write_uncompressed_file_from_fd()
To: Daan De Meyer <daan.j.demeyer@gmail.com>, linux-erofs@lists.ozlabs.org
References: <CAO8sHcmZZORnrJXA=QzmGkYNkNWn7M+amAK_DZ19-WL4kLUvpw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAO8sHcmZZORnrJXA=QzmGkYNkNWn7M+amAK_DZ19-WL4kLUvpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 2023/8/31 17:33, Daan De Meyer wrote:
> Hi,
> 
> For hacking on systemd, we build disk images using mkosi, and use an erofs filesystem for the /usr directory. When hacking on systemd, we would like to be able to rebuild the disk image as fast as possible. One part of rebuilding the image that takes a while is generating the erofs filesystem. I had a look at the mkfs source code for erofs and noticed that in
> write_uncompressed_file_from_fd(), there is no usage of FICLONERANGE or copy_file_range() to speed up copying data from the filesystem to the erofs filesystem. Would it be possible to use either of these to make copying data in mkfs.erofs faster when the data does not need to be compressed?

Thanks for the email!

Yes, that is indeed useful, actually mmap I/Os can be used
to boost up write_uncompressed_file_from_fd () as well...
Actually many enhancements are limited by the current
development resource (multithreaded compression support might
be the top-1 priority for userspace side from end users),
but I have to resolve them one-by-one since EROFS is still a
quite young project compared to other approaches and beyond
the original targeted use cases (so most Android vendors won't
pay any attention to improvements that are not critically
important for their scenarios.)

I mostly focus on some kernel improvements since Google needs
us to support 16k page size + 4k EROFS block size.  That is
currently my top thing to resolve first...

(quite limited by real world time...)

Thanks,
Gao Xiang

> 
> Cheers,
> 
> Daan De Meyer
