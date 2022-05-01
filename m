Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id C068C51628A
	for <lists+linux-erofs@lfdr.de>; Sun,  1 May 2022 10:00:04 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KrdtT6wPlz30QN
	for <lists+linux-erofs@lfdr.de>; Sun,  1 May 2022 18:00:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=bytedance-com.20210112.gappssmtp.com header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256 header.s=20210112 header.b=cY9xiKCl;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bytedance.com (client-ip=2a00:1450:4864:20::22b;
 helo=mail-lj1-x22b.google.com; envelope-from=yinxin.x@bytedance.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=bytedance-com.20210112.gappssmtp.com
 header.i=@bytedance-com.20210112.gappssmtp.com header.a=rsa-sha256
 header.s=20210112 header.b=cY9xiKCl; dkim-atps=neutral
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KrdtM6ZZ6z2xgN
 for <linux-erofs@lists.ozlabs.org>; Sun,  1 May 2022 17:59:53 +1000 (AEST)
Received: by mail-lj1-x22b.google.com with SMTP id bn33so15167443ljb.6
 for <linux-erofs@lists.ozlabs.org>; Sun, 01 May 2022 00:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=bwS6neoJgwAscLo7SMr+briaL7cQkz+klklthFb5lCU=;
 b=cY9xiKClPzQfCMz80gVj3KC8oirqpcOaA49JLl1+D5f+dtBt0xpRAm8iFoK/+NkSUw
 KjJQgwMoGYF6NG4HVB8h4RIK++OlZ/2fPHOjNCOI10JsGKnGnBPFTJU7majqwl91uYl3
 IM8y/RL1P2EfDPdTsf5UhkE34NhiFe8wRaoAsuDKoJtyEYpXDrSE/0iuT0JKzI2xvwLN
 dabg7oqfUWmMgB2K2NVXcHYz1WOCiMOoiI9qFP3zKwA2rtNex2LO03rQcnBra04VgrUA
 MH0T2f5I0oyVUEeTa2VAdIzlvRRKr0JA4tmyHRzZ3Yo40zuNUMO7Q2/FecTh2UBEZ5nY
 b5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=bwS6neoJgwAscLo7SMr+briaL7cQkz+klklthFb5lCU=;
 b=iLwXRg9ENH9Z20j7hEWSUkcsBdNfKa482+wWAQ7tTWNeFHeV87zjIRvXLQR2aO7W4W
 c1eAWCotR2g/HPdvGIZHUk79elztv6zsjhoxDeTu0bo1dLHy78X7LI/pB3G8RCLa64p9
 2MooP7MaDvgUxRplFdSzcSsVkPoU6SpeA6yqQX/kizTJUwtbue6aiW+igB7awg3Ro2hq
 lxGqG3nE9nPdDK3tsz/B5+ksfS+xwJYqUj858w9mjCpyFT8QejOAx4LspYEkXx3kmdol
 nD/NvMJeXz4yZ3Nmcj6vCjYfY/aj9zQAmDfOAiK6Ls5x2wEfQYzwcXWs4jMpRyAc3NRv
 w6Fw==
X-Gm-Message-State: AOAM532CyWnMbps6YxkcxllcmnttlJQufCasCTFnKsSjT2y+Kg6NR816
 nfWl5/ORqlMBPAr++w+iCx34I/MNTabq61DqIez3qw==
X-Google-Smtp-Source: ABdhPJwVs2ZVv+Eaq5VyLrhX5r9W7NBvf4my2q1OF2UJtKn+DFVoi8+nGzLLoOvLndBDI7z5HBcmwn406loffgvhLno=
X-Received: by 2002:a05:651c:4c7:b0:24f:4017:a2ce with SMTP id
 e7-20020a05651c04c700b0024f4017a2cemr4870748lji.5.1651391987333; Sun, 01 May
 2022 00:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220428233849.321495-1-yinxin.x@bytedance.com>
 <YmvbwKSdiCosPhAV@B-P7TQMD6M-0146.local>
In-Reply-To: <YmvbwKSdiCosPhAV@B-P7TQMD6M-0146.local>
From: Xin Yin <yinxin.x@bytedance.com>
Date: Sun, 1 May 2022 15:59:37 +0800
Message-ID: <CAK896s701pZ_VzRUGLA=g5poAc+oqHqD=Swp14AVxND7ZVvg3A@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 0/1] erofs: change to use asynchronous
 io for fscache readahead
To: jefflexu@linux.alibaba.com, xiang@kernel.org, dhowells@redhat.com, 
 linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com, 
 linux-fsdevel@vger.kernel.org, boyu.mt@taobao.com, lizefan.x@bytedance.com
Content-Type: text/plain; charset="UTF-8"
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
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Apr 29, 2022 at 8:36 PM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
> Hi Xin,
>
> On Fri, Apr 29, 2022 at 07:38:48AM +0800, Xin Yin wrote:
> > Hi Jeffle & Xiang
> >
> > I have tested your fscache,erofs: fscache-based on-demand read semantics
> > v9 patches sets https://www.spinics.net/lists/linux-fsdevel/msg216178.html.
> > For now , it works fine with the nydus image-service. After the image data
> > is fully loaded to local storage, it does have great IO performance gain
> > compared with nydus V5 which is based on fuse.
>
> Yeah, thanks for your interest and efforts. Actually I'm pretty sure you
> could observe CPU, bandwidth and latency improvement on the dense deployed
> scenarios since our goal is to provide native performance when the data is
> ready, as well as image on-demand read, flexible cache data management to
> end users.
>
> >
> > For 4K random read , fscache-based erofs can get the same performance with
> > the original local filesystem. But I still saw a performance drop in the 4K
> > sequential read case. And I found the root cause is in erofs_fscache_readahead()
> > we use synchronous IO , which may stall the readahead pipelining.
> >
>
> Yeah, that is a known TODO, in principle, when such part of data is locally
> available, it will have the similar performance (bandwidth, latency, CPU
> loading) as loop device. But we don't implement asynchronous I/O for now,
> since we need to make the functionality work first, so thanks for your
> patch addressing this.
>
> > I have tried to change to use asynchronous io during erofs fscache readahead
> > procedure, as what netfs did. Then I saw a great performance gain.
> >
> > Here are my test steps and results:
> > - generate nydus v6 format image , in which stored a large file for IO test.
> > - launch nydus image-service , and  make image data fully loaded to local storage (ext4).
> > - run fio with below cmd.
> > fio -ioengine=psync -bs=4k -size=5G -direct=0 -thread -rw=read -filename=./test_image  -name="test" -numjobs=1 -iodepth=16 -runtime=60
>
> Yeah, although I can see what you mean (to test buffered I/O), the
> argument is still somewhat messy (maybe because we don't support
> fscache-based direct I/O for now. That is another TODO but with
> low priority.)
>
> >
> > v9 patches: 202654 KB/s
> > v9 patches + async readahead patch: 407213 KB/s
> > ext4: 439912 KB/s
>
> May I ask if such ext4 image is through a loop device? If not, that is
> reasonable. Anyway, it's not a big problem for now, we could optimize
> it later since it should be exactly the same finally.
>

This ext4 image is not through a loop device ,  just the same test
file stored in native ext4.  Actually , after further tests , I could
see that fscache-based erofs with async readahead patch almost achieve
native performance in sequential buffer read cases.

Thanks,
Xin Yin

> And I will drop a message to Jeffle for further review since we're
> closing to another 5-day national holiday.
>
> Thanks again!
> Gao Xiang
>
