Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DA53FF32C
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Sep 2021 20:21:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H0q4s0hx2z2yLq
	for <lists+linux-erofs@lfdr.de>; Fri,  3 Sep 2021 04:21:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KZO3g5S/;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=KZO3g5S/; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H0q4m4bnhz2xfP
 for <linux-erofs@lists.ozlabs.org>; Fri,  3 Sep 2021 04:21:28 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99B5261041;
 Thu,  2 Sep 2021 18:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630606886;
 bh=44DLHjL939OemOnIN1/VdzLyyxAZ2hVSWSI7E3ypWvU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=KZO3g5S/N3lilzVtOABmurSqX4WR8b3Q2yohwgQbgd00ue248U0DSuWQaXgQsiKmU
 jSx0eo7eAHLYO1wLo2pO2snJwG0XrsyESDus912BITtP/+IdcmRcnNpLcqwbn75RUj
 m1D1wqSL9WYCOnTWvnvZaYQE4hBI0tLwmRxsC3KTRQ2gRITj+qY3Kz4GH6wx02z1KB
 VggxEueaCiiPuhueoexcH2BLCjh9x3MlFIcCn6nTeswTUiqqHjaY1Tb/GiEGAf5RmK
 edTE/CemVojmSou7B36A1cLXTHWU/tCiP7hlUWYm4Z2TP+3FZRRBfNfSOAaeQUOwoB
 Sckv4hMqwDQPg==
Date: Fri, 3 Sep 2021 02:20:55 +0800
From: Gao Xiang <xiang@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] erofs updates for 5.15-rc1
Message-ID: <20210902182053.GB26537@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-erofs@lists.ozlabs.org,
 Dan Williams <dan.j.williams@intel.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Huang Jianan <huangjianan@oppo.com>, Yue Hu <huyue2@yulong.com>,
 Miao Xie <miaoxie@huawei.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 Peng Tao <tao.peng@linux.alibaba.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>
References: <20210831225935.GA26537@hsiangkao-HP-ZHAN-66-Pro-G1>
 <CAHk-=wi7gf_afYhx_PYCN-Sgghuw626dBNqxZ6aDQ-a+sg6wag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wi7gf_afYhx_PYCN-Sgghuw626dBNqxZ6aDQ-a+sg6wag@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Peng Tao <tao.peng@linux.alibaba.com>, Miao Xie <miaoxie@huawei.com>,
 LKML <linux-kernel@vger.kernel.org>, Joseph Qi <joseph.qi@linux.alibaba.com>,
 Yue Hu <huyue2@yulong.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Liu Jiang <gerry@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Sep 02, 2021 at 09:18:59AM -0700, Linus Torvalds wrote:
> On Tue, Aug 31, 2021 at 4:00 PM Gao Xiang <xiang@kernel.org> wrote:
> >
> > All commits have been tested and have been in linux-next. Note that
> > in order to support iomap tail-packing inline, I had to merge iomap
> > core branch (I've created a merge commit with the reason) in advance
> > to resolve such functional dependency, which is now merged into
> > upstream. Hopefully I did the right thing...
> 
> It all looks fine to me. You have all the important parts: what you
> are merging, and _why_ you are merging it.
> 
> So no complaints, and thanks for making it explicit in your pull
> request too so that I'm not taken by surprise.

Yeah, thanks. That was my first time to merge another tree due to hard
dependency like this. I've gained some experience from this and will be
more confident on this if such things happen in the future. :)

Thanks,
Gao Xiang

> 
>          Linus
