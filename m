Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E139536D2A
	for <lists+linux-erofs@lfdr.de>; Sat, 28 May 2022 15:54:40 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L9NT72MDsz3blX
	for <lists+linux-erofs@lfdr.de>; Sat, 28 May 2022 23:54:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ENyK/Kh2;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4601:e00::1; helo=ams.source.kernel.org; envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ENyK/Kh2;
	dkim-atps=neutral
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4L9NT46Ys3z2yjC
	for <linux-erofs@lists.ozlabs.org>; Sat, 28 May 2022 23:54:32 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 33068B8273B;
	Sat, 28 May 2022 13:54:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CABAAC34100;
	Sat, 28 May 2022 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1653746068;
	bh=16QmJOXv5FA2FQ51XVO8E/GjNdwb2ImY5kcBHOqS2ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ENyK/Kh2YBKMWCvv4bsg/AAPThIet3SejzYYlJHuMzGEC6fNiGmsKfBxRZSEEQbiZ
	 JlSRXu+YoebiCmXPxLN2ASvq4KV0BrO5nqYGnBR9I1w/g6Fs60zWO9jnxi8TCAlPf8
	 tAntWar9dz+Ut7HDyPNNMyO9gnOgh5DJqqKu1LxVbzCeQk3Ym7F1QYfASaKj6CIR20
	 vQTADazjJ99yhkRGtFAUOZpuI5RedCoGeJNGEJS8Dp0hBcskpcujs42cMnhhAl6OMW
	 O5IpGCHu46xg1bqAeNgIyRGkOrHKH9qwbty5Mzoa5Dequ4B65Te2G0Pj94eehAPwqf
	 722T2lng+w0bg==
Date: Sat, 28 May 2022 21:54:19 +0800
From: Gao Xiang <xiang@kernel.org>
To: JeffleXu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH] erofs: fix crash when enable tracepoint
 cachefiles_prep_read
Message-ID: <YpIpiyVUDNHpw75Y@debian>
Mail-Followup-To: JeffleXu <jefflexu@linux.alibaba.com>,
	Xin Yin <yinxin.x@bytedance.com>, hsiangkao@linux.alibaba.com,
	chao@kernel.org, linux-erofs@lists.ozlabs.org
References: <20220527101800.22360-1-yinxin.x@bytedance.com>
 <dfc3c10a-5f95-cfa3-53ba-d159d2a2f50b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dfc3c10a-5f95-cfa3-53ba-d159d2a2f50b@linux.alibaba.com>
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
Cc: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, Xin Yin <yinxin.x@bytedance.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, May 27, 2022 at 08:01:14PM +0800, JeffleXu wrote:
> Hi, thanks for catching this.
> 
> 
> On 5/27/22 6:18 PM, Xin Yin wrote:
> > RIP: 0010:trace_event_raw_event_cachefiles_prep_read+0x88/0xe0
> > [cachefiles]
> > Call Trace:
> >   <TASK>
> >   cachefiles_prepare_read+0x1d7/0x3a0 [cachefiles]
> >   erofs_fscache_read_folios+0x188/0x220 [erofs]
> >   erofs_fscache_meta_readpage+0x106/0x160 [erofs]
> >   do_read_cache_folio+0x42a/0x590
> >   ? bdi_register_va.part.14+0x1a7/0x210
> >   ? super_setup_bdi_name+0x76/0xe0
> >   erofs_bread+0x5b/0x170 [erofs]
> >   erofs_fc_fill_super+0x12b/0xc50 [erofs]
> > 
> > This tracepoint uses rreq->inode, should set it when allocating.
> > 
> > Fixes: d435d53228dd ("erofs: change to use asynchronous io for fscache
> > readpage/readahead")
> 
> The "Fixes" line should better be one single line. But no worry, I think
> Gao Xiang will fix this then :)

Yeah,

> 
> > Signed-off-by: Xin Yin <yinxin.x@bytedance.com>
> > ---
> >  fs/erofs/fscache.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> > index a5cc4ed2cd0d..8e01d89c3319 100644
> > --- a/fs/erofs/fscache.c
> > +++ b/fs/erofs/fscache.c
> > @@ -17,6 +17,7 @@ static struct netfs_io_request *erofs_fscache_alloc_request(struct address_space
> >  	rreq->start	= start;
> >  	rreq->len	= len;
> >  	rreq->mapping	= mapping;
> > +	rreq->inode	= mapping->host;
> >  	INIT_LIST_HEAD(&rreq->subrequests);
> >  	refcount_set(&rreq->ref, 1);
> >  	return rreq;
> 
> Otherwise, LGTM.
> 
> Reviewed-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> 

Thanks, applied.

Thanks,
Gao Xiang

> -- 
> Thanks,
> Jeffle
