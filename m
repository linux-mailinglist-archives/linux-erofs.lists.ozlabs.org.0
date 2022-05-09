Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB02F51F2F4
	for <lists+linux-erofs@lfdr.de>; Mon,  9 May 2022 05:29:51 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KxRW15sQrz3c7Q
	for <lists+linux-erofs@lfdr.de>; Mon,  9 May 2022 13:29:49 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43;
 helo=out30-43.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com
 (out30-43.freemail.mail.aliyun.com [115.124.30.43])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KxRVs2Vvcz3bd9
 for <linux-erofs@lists.ozlabs.org>; Mon,  9 May 2022 13:29:39 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R881e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=6; SR=0; TI=SMTPD_---0VCcZKZu_1652066971; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0VCcZKZu_1652066971) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 09 May 2022 11:29:33 +0800
Date: Mon, 9 May 2022 11:29:29 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Xin Yin <yinxin.x@bytedance.com>
Subject: Re: [External] Re: [PATCH v2] erofs: change to use asyncronous io
 for fscache readpage/readahead
Message-ID: <YniKmToYBm5Nmbk6@B-P7TQMD6M-0146.local>
Mail-Followup-To: Xin Yin <yinxin.x@bytedance.com>,
 JeffleXu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
 linux-erofs@lists.ozlabs.org, linux-cachefs@redhat.com,
 linux-fsdevel@vger.kernel.org
References: <20220507083154.18226-1-yinxin.x@bytedance.com>
 <dfcbda24-3969-f374-b209-81c3818246c1@linux.alibaba.com>
 <CAK896s68f5Snrip8TYPfDbObOpNoTtWW+0WBXzTiJbadAShGrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK896s68f5Snrip8TYPfDbObOpNoTtWW+0WBXzTiJbadAShGrg@mail.gmail.com>
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
Cc: dhowells@redhat.com, linux-cachefs@redhat.com, linux-erofs@lists.ozlabs.org,
 linux-fsdevel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, May 09, 2022 at 11:05:47AM +0800, Xin Yin wrote:
> On Sat, May 7, 2022 at 9:08 PM JeffleXu <jefflexu@linux.alibaba.com> wrote:
> >
> >
> >
> > On 5/7/22 4:31 PM, Xin Yin wrote:
> > > Use asyncronous io to read data from fscache may greatly improve IO
> > > bandwidth for sequential buffer read scenario.
> > >
> > > Change erofs_fscache_read_folios to erofs_fscache_read_folios_async,
> > > and read data from fscache asyncronously. Make .readpage()/.readahead()
> > > to use this new helper.
> > >
> > > Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> > > ---
> >
> > s/asyncronous/asynchronous/
> > s/asyncronously/asynchronously/
> >
> Thanks for pointing this out , I will fix it.
> 
> > BTW, "convert to asynchronous readahead" may be more concise?
> >
> You mean the title of this patch?  But, actually we also change to use
> this asynchronous io helper for .readpage() now , so I think we need
> to point this in the title. right ?

No worries, I pushed this for 0day ci yesterday, Jeffle may send out
another v11 with this patch included if needed.

Thanks,
Gao Xiang

> 
> Thanks,
> Xin Yin
> > Apart from that, LGTM
> >
> > Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> >
> >
> > --
> > Thanks,
> > Jeffle
