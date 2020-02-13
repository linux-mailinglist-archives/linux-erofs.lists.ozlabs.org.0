Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 5516915CEBF
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Feb 2020 00:43:08 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48JY3Y4lDXzDqVQ
	for <lists+linux-erofs@lfdr.de>; Fri, 14 Feb 2020 10:43:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=song@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=default header.b=cPo6gRm2; dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48JY3T43JRzDq7k
 for <linux-erofs@lists.ozlabs.org>; Fri, 14 Feb 2020 10:43:01 +1100 (AEDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 81DC92467C
 for <linux-erofs@lists.ozlabs.org>; Thu, 13 Feb 2020 23:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1581637378;
 bh=QvXr0ccIUZIRsqUcy6mdX4RvItZ/HQGPAVqIR5RAVyo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=cPo6gRm2riJCg2de4KFKjGUPyih5I99+ID98XQlsTTxOWt9KQ5Pfqdzsd5F8lPb46
 PWQzSbOz7vIG+xvGz7PfCbmDfooxlwTbJpl1r0D3JFRAOkqSLvkxfK8/0KLnmSKU0Y
 1H66ieYG9DmRRXq2PvYmmF1St6fRqy/EY5GTTf3U=
Received: by mail-lj1-f174.google.com with SMTP id q8so8598210ljj.11
 for <linux-erofs@lists.ozlabs.org>; Thu, 13 Feb 2020 15:42:58 -0800 (PST)
X-Gm-Message-State: APjAAAXac1kMVlb4hZ1Mm6vQKDpOmbOZkGhPkVhkBfeCBFdl2dQ3ANfL
 DIaslcF9raCOj2Fx0vBjV68C3yiMacEjZeWEYLc=
X-Google-Smtp-Source: APXvYqyMTY5BiLP/4jYWIAjsVYrB8h/h7Ek++s0e6pxXO6PqFXN3+xu4BLWRYI1/YeOOm0rQ6bFf5+MVwGHlLSORLHc=
X-Received: by 2002:a2e:a553:: with SMTP id e19mr168246ljn.64.1581637376641;
 Thu, 13 Feb 2020 15:42:56 -0800 (PST)
MIME-Version: 1.0
References: <20200213141823.2174236-1-mplaneta@os.inf.tu-dresden.de>
 <20200213153645.GA11313@redhat.com>
 <82715589-8b59-5cfd-a32f-1e57871327fe@os.inf.tu-dresden.de>
In-Reply-To: <82715589-8b59-5cfd-a32f-1e57871327fe@os.inf.tu-dresden.de>
From: Song Liu <song@kernel.org>
Date: Thu, 13 Feb 2020 15:42:45 -0800
X-Gmail-Original-Message-ID: <CAPhsuW70_HtmxA0qmUVLk4L+Ls5t=0j0k5D4fbT4fNY59L2UpQ@mail.gmail.com>
Message-ID: <CAPhsuW70_HtmxA0qmUVLk4L+Ls5t=0j0k5D4fbT4fNY59L2UpQ@mail.gmail.com>
Subject: Re: Remove WQ_CPU_INTENSIVE flag from unbound wq's
To: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
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
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Mike Snitzer <snitzer@redhat.com>,
 Zhou Wang <wangzhou1@hisilicon.com>, open list <linux-kernel@vger.kernel.org>,
 linux-raid <linux-raid@vger.kernel.org>, dm-devel@redhat.com,
 linux-crypto@vger.kernel.org, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 Alasdair Kergon <agk@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Feb 13, 2020 at 8:19 AM Maksym Planeta
<mplaneta@os.inf.tu-dresden.de> wrote:
>
>
>
> On 13/02/2020 16:36, Mike Snitzer wrote:
> > On Thu, Feb 13 2020 at  9:18am -0500,
> > Maksym Planeta <mplaneta@os.inf.tu-dresden.de> wrote:
> >
> >> The documentation [1] says that WQ_CPU_INTENSIVE is "meaningless" for
> >> unbound wq. I remove this flag from places where unbound queue is
> >> allocated. This is supposed to improve code readability.
> >>
> >> 1. https://www.kernel.org/doc/html/latest/core-api/workqueue.html#flags
> >>
> >> Signed-off-by: Maksym Planeta <mplaneta@os.inf.tu-dresden.de>
> >
> > What the Documentation says aside, have you cross referenced with the
> > code?  And/or have you done benchmarks to verify no changes?
> >
>
> It seems so from the code. Although, I'm not 100% confident. I did not
> run benchmarks, instead I relied that on the assumption that
> documentation is correct.

From the code, WQ_CPU_INTENSIVE is only used to set
WORKER_CPU_INTENSIVE, and WORKER_CPU_INTENSIVE is only used
as part of WORKER_NOT_RUNNING, which includes WORKER_UNBOUND.
So, I agree that with current code, WQ_CPU_INTENSIVE with WQ_UNBOUND
is same as WQ_UNBOUND alone.

However, I don't think it is necessary to make the changes. They don't really
improve readability of the code.

Thanks,
Song
