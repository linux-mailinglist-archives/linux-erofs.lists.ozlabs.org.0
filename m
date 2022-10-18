Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A48160359A
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Oct 2022 00:00:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MsSTy00d4z3blt
	for <lists+linux-erofs@lfdr.de>; Wed, 19 Oct 2022 09:00:38 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.42; helo=out30-42.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MsSTv0tvVz2xk6
	for <linux-erofs@lists.ozlabs.org>; Wed, 19 Oct 2022 09:00:33 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VSXTliC_1666130427;
Received: from B-P7TQMD6M-0146.lan(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VSXTliC_1666130427)
          by smtp.aliyun-inc.com;
          Wed, 19 Oct 2022 06:00:29 +0800
Date: Wed, 19 Oct 2022 06:00:27 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: =?utf-8?B?QW5kcsOp?= Goddard Rosa <andre.goddard@gmail.com>
Subject: Re: erofs + zstd : a super combination!
Message-ID: <Y08h+z6CZdnS1XBm@B-P7TQMD6M-0146.lan>
References: <CAGje9yROxonTPdyEmTCC-+7SsR-Zbq-VasySaTtVwu-=HJ7TwQ@mail.gmail.com>
 <Y08Xg53TyxTFlRTR@B-P7TQMD6M-0146.lan>
 <CAGje9yRjZbnnj=oHoP0ccP+_GrmPHSUyCPmNRnmRf-0TJR4OKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGje9yRjZbnnj=oHoP0ccP+_GrmPHSUyCPmNRnmRf-0TJR4OKg@mail.gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

(cc linux-erofs mailing list for archival use only)

On Tue, Oct 18, 2022 at 04:26:09PM -0500, André Goddard Rosa wrote:
> On Tue, Oct 18, 2022 at 4:15 PM Gao Xiang <hsiangkao@linux.alibaba.com>
> wrote:
> 
> > Hi André,
> >
> > On Tue, Oct 18, 2022 at 03:34:18PM -0500, André Goddard Rosa wrote:
> > > Hi Gao Xiang, good day!
> > >
> > > I noticed that you were trying to add support for zstd to erofs in #1399
> > > [1] , but you mentioned it was a low priority at the time. By looking at
> > > this nice article [2], erofs+zstd are probably going to give an excellent
> > > compression rate with a really fast decompression, so it can compress
> > > better than LZ4 with a decompression performance much better than
> > MicroLZMA
> > > (it's outstanding you worked with Lasse Collin on that!) benefitting a
> > lot
> > > of small systems with low memory.
> > >
> > > As you mentioned, some slight variation resembling a binary search could
> > be
> > > done in order to make use of zstd. Also, Yann Collet, lz4&zstd author,
> > > suggested a similar mechanism on #204 [3].
> > >
> > > Because of the great potential for this, I'd like to ask what are your
> > > plans with regard to it. Please let me know if you would need any help
> > with
> > > it or if you have anything in progress or plans you could share with me.
> >
> > There are several ways to make EROFS work with zstd.  Of course [3] will
> > be a way, but I've seen they have a superblock compression support as
> > well. Or I can just compress to several blocks and leave the last
> > remaining block as is even if it's not full.
> >
> > I will try to implment zstd in my spare time in the next few months, but
> > I cannot promise anything.  Since once the implementation is done, it
> > has to be supported all the time in order to make EROFS compatibility.
> > Therefore, the formal version will be done with care.
> >
> 
> Great, thanks for the quick update Gao Xiang!
> 
> Please let me know if you'd benefit from any help in implementing this
> feature. I can definitely help to test too.
> 
> In many cases, the compression speed is less important than the
> decompression time,
> so even if there's no perfectly optimized zstd backend, it could still
> work. Also, it would be

Yes, even we try to compress to several blocks and leave the last remaining
block non-full.  It's still comparable to btrfs or f2fs since they both
work as this way.  And anyway, the decompression side is unrelated to the
compression side.

> really nice if it could be supported on older devices running kernel 4.19+
> like erofs
> originally did.

I mostly work for the upstream kernel and LTS kernels are bugfixes only
so they don't really accept feature backports and I'm afraid I don't
have full time to look after so many old LTS kernels with new features..

Thanks,
Gao Xiang

> 
> Thanks and best regards,
> Andre
