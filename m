Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A3D7BCA93
	for <lists+linux-erofs@lfdr.de>; Sun,  8 Oct 2023 01:57:45 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4S32Kg12Jyz30hj
	for <lists+linux-erofs@lfdr.de>; Sun,  8 Oct 2023 10:57:43 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.124; helo=out30-124.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4S32KW1rnKz2yjD
	for <linux-erofs@lists.ozlabs.org>; Sun,  8 Oct 2023 10:57:33 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R881e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vtc4zLx_1696723037;
Received: from 192.168.3.4(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Vtc4zLx_1696723037)
          by smtp.aliyun-inc.com;
          Sun, 08 Oct 2023 07:57:19 +0800
Message-ID: <73c11706-a682-f594-8be2-dd4091fb4aa8@linux.alibaba.com>
Date: Sun, 8 Oct 2023 07:57:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v1] erofs-utils: Fix cross compile with autoconf
To: Sandeep Dhavale <dhavale@google.com>
References: <20231005224008.817830-1-dhavale@google.com>
 <531b8a1b-efbb-8fcb-a0f8-018c8650611f@linux.alibaba.com>
 <CAB=BE-RR4MsevBPbrmr-QmH8ihzTnQhrQuJoh1Fr6BquP9AS8A@mail.gmail.com>
 <9ef1b3c3-9d3c-5639-1859-6d419b2a9594@linux.alibaba.com>
 <CAB=BE-RrTeqUUqvkYCckoJXou4tf9zKd_xN4KTCk0kh5yp9Saw@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAB=BE-RrTeqUUqvkYCckoJXou4tf9zKd_xN4KTCk0kh5yp9Saw@mail.gmail.com>
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
Cc: kernel-team@android.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Sandeep,

On 2023/10/7 22:51, Sandeep Dhavale wrote:
> On Sat, Oct 7, 2023 at 1:25 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

...

>>
> Hi Gao,
> That cannot work because AS_RUN_IFELSE() is only invoked if
> MAX_BLOCK_SIZE is not set.
> 
>    # Detect maximum block size if necessary
>    AS_IF([test "x$MAX_BLOCK_SIZE" = "x"], [
>      AC_CACHE_CHECK([sysconf (_SC_PAGESIZE)], [erofs_cv_max_block_size],
>                   AC_RUN_IFELSE([AC_LANG_PROGRAM(
>    [[
>    #include <unistd.h>
>    #include <stdio.h>
> ...
> 
> Cross compilation works if MAX_BLOCK_SIZE is set today as is without
> any fix. Cross compilation only fails when MAX_BLOCK_SIZE is not set
> AND the configure script tries to detect because there is no action
> defined regarding what should be erofs_cv_max_block_size.

Yes, I know MAX_BLOCK_SIZE is not set here. My only concern is that
hardcoded 4096 is involved many times.

I've applied this original version. But I think we might need to
clean up multiple 4096 later...

Thanks,
Gao Xiang

> 
> Thanks,
> Sandeep.
