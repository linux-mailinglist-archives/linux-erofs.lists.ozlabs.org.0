Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02056A1435
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Feb 2023 01:14:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4PN9P22ybPz3chw
	for <lists+linux-erofs@lfdr.de>; Fri, 24 Feb 2023 11:14:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1677197654;
	bh=TdidChoinEBLrLlt/CurGVixllEMtFuJAvHMgu/NZfo=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=nGrpshCgcK/LPExMekLqVJYXtA8pTyWtlDhz4MozxK++ITlXYqM+WDq04ORV4jm+Q
	 F326fS1RPY64Iaztptr5wNehuKQ0rr86lHQqEX3e1u7nIWOnhS+uKz2HV2QXIJ+HDx
	 V9B8UEGm1l+vQrYBThteJd+uHeY7nuUKd2wg1UVFca93+E73hNoVUpBXh5faa1wQml
	 V9t0eI9Vs3z0OBbeMw3VkKI4Mt/5c/Pj/rKS9ClB1KW2wT0cITlmat/n7Q83Dzo7tu
	 6UzfNJnCV1QbsPjwIvsdLYVLCEQny61qb+5cHqkf6Kxl0zhGbD2O8sQ1glGSqSlY3U
	 jI865Z1YM+j/w==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::22d; helo=mail-oi1-x22d.google.com; envelope-from=dhavale@google.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20210112 header.b=rJDsx+/K;
	dkim-atps=neutral
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4PN9Nt1mbkz3c8G
	for <linux-erofs@lists.ozlabs.org>; Fri, 24 Feb 2023 11:14:04 +1100 (AEDT)
Received: by mail-oi1-x22d.google.com with SMTP id e21so14699827oie.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 23 Feb 2023 16:14:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TdidChoinEBLrLlt/CurGVixllEMtFuJAvHMgu/NZfo=;
        b=FdCyrg1yfO6SkRx3C1GRcEwtgjPKFQWporei78aK6XJ9kOylv/oQueXLZkm+JL3JCe
         ZzNukIT7B/D1A+UCNeS8yP6y5JnheGQ65bFE90ohlSf56Dzdtx2iNpJ4JB46iowCjmIL
         0zG/Ypi81qXl+Jsr0wQ8u9HpnB9YySD/UmpCU1t1pgwV4BzJakqZPgY6e7Fhnk5ys88u
         q8Wpu8FfVHdqEtQug4cA10GXHoUujHQMlZi7KZP6WDqaJPxnJ11TGO7Bk0EbeIszQWw0
         1ujYZ38VLANf+1FvwlI92RGAC72pcXydfbMOdmDQAnYChOtwHKYQPpvfGGFgIO2QWmTu
         Eu+g==
X-Gm-Message-State: AO0yUKXHWdVVGpOz5gOlhqplKwFVxKb/503MMh4DVv4vRVCci1y2GZ/L
	e6XtsSyF4Nwkv1kr8EaUZrxwcMlJIT+QSdBUtwM7Wg==
X-Google-Smtp-Source: AK7set+Pu785rN2AMAsPyHuytxZFqVMOw3qN483f3LOeHCqNR/vsjJGPUIVlB9AeSPnsU8LhcUihzBkG+wVVr1U+WBI=
X-Received: by 2002:a05:6808:8e3:b0:37f:9a01:f661 with SMTP id
 d3-20020a05680808e300b0037f9a01f661mr525076oic.9.1677197641278; Thu, 23 Feb
 2023 16:14:01 -0800 (PST)
MIME-Version: 1.0
References: <20230208093322.75816-1-hsiangkao@linux.alibaba.com>
 <Y/ewpGQkpWvOf7qh@gmail.com> <ca1e604a-92ba-023b-8896-dcad9413081d@linux.alibaba.com>
 <8e067230-ce1b-1c75-0c23-87b926357f96@linux.alibaba.com>
In-Reply-To: <8e067230-ce1b-1c75-0c23-87b926357f96@linux.alibaba.com>
Date: Thu, 23 Feb 2023 16:13:50 -0800
Message-ID: <CAB=BE-SQZA7gETEvxnHmy0FDQ182fUSRoa0bJBNouN33SFx3hQ@mail.gmail.com>
Subject: Re: [PATCH v5] erofs: add per-cpu threads for decompression as an option
To: Gao Xiang <hsiangkao@linux.alibaba.com>
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, Nathan Huckleberry <nhuck@google.com>, Yue Hu <huyue2@coolpad.com>, kernel-team@android.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Feb 23, 2023 at 11:08 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>
>
>
> On 2023/2/24 02:52, Gao Xiang wrote:
> > Hi Eric,
> >
> > On 2023/2/24 02:29, Eric Biggers wrote:
> >> Hi,
> >>
> >> On Wed, Feb 08, 2023 at 05:33:22PM +0800, Gao Xiang wrote:
> >>> From: Sandeep Dhavale <dhavale@google.com>
> >>>
> >>> Using per-cpu thread pool we can reduce the scheduling latency compared
> >>> to workqueue implementation. With this patch scheduling latency and
> >>> variation is reduced as per-cpu threads are high priority kthread_workers.
> >>>
> >>> The results were evaluated on arm64 Android devices running 5.10 kernel.
> >>
> >> I see that this patch was upstreamed.  Meanwhile, commit c25da5b7baf1d
> >> ("dm verity: stop using WQ_UNBOUND for verify_wq") was also upstreamed.
> >>
> >> Why is this more complex solution better than simply removing WQ_UNBOUND?
> >
> > I do think it's a specific issue on specific arm64 hardwares (assuming
> > qualcomm, I don't know) since WQ_UNBOUND decompression once worked well
> > on the hardwares I once used (I meant Hisilicon, and most x86_64 CPUs,
> > I tested at that time) compared with per-cpu workqueue.
> >
> > Also RT threads are also matchable with softirq approach.  In addition,
> > many configurations work without dm-verity.
>
> Also for dm-verity use cases, EROFS will reuse the dm-verity context
> directly rather than kick off a new context.  Yet I'm not sure there
> are still users using EROFS without dm-verity as I said above.
>
> Anyway, the original scheduling issue sounds strange for me (with my
> own landing experiences) in the beginning, and I have no way to
> confirm the cases.  Just hopefully it could be resolved from the
> developer inputs and finally benefit to end users.
>
> I've already did my own stress test with this new configuration as
> well without explicit regression.
>
Hi Eric,
From the dm-verity patch description of removing WQ_UNBOUND it seems
Nathan saw the EROFS wait time was reduced by 51% whereas high pri per-cpu
threads showed me sched latency reduced on avg by ~80%.

So from the description at least it does not look like both patches have
equal benefits. I can't argue about the size and complexity of removing
WQ_UNBOUND if it gives the same benefits, that would have been great.

I will do the app launch tests again to compare these and share.

Thanks,
Sandeep.


> >
> > I don't have more time to dig into it for now but it's important to
> > resolve this problem on some arm64 hardwares first.  Also it's an
> > optional stuff, if the root cause of workqueue issue can be resolved,
> > we could consider drop it then.
> >
> > Thsnka,
> > Gao Xiang
> >
> >>
> >> - Eric
