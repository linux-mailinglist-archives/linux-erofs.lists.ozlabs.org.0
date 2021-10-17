Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFD5430A36
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Oct 2021 17:32:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HXPC73G0Nz2yp9
	for <lists+linux-erofs@lfdr.de>; Mon, 18 Oct 2021 02:32:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o7BAR9re;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=o7BAR9re; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HXPC23P46z2ymF
 for <linux-erofs@lists.ozlabs.org>; Mon, 18 Oct 2021 02:32:30 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF03D60E74;
 Sun, 17 Oct 2021 15:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634484748;
 bh=FQ2C52uWsYrTnBdz5DRM1rNifGCmmzFajq3YqCREayE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=o7BAR9re4guIutpqLJG8nv77TlxxfKsQMgpx5AiWy0yRmGhx82DroeIfCwDMcDQXr
 VyIdfkOd5ZsfpriI5n+FIpGesu8zB0qppjLEKALyYaeOoa59FxPIz6PFWVjxVVTmVn
 VwgA01cULl4P5ApZjOHqsNxNd7WqLWDMtAkr8tKFvXXk0ANfZcLTsTFE4worJN6ML3
 0NKZN7+lU2e3wwJd/agu57XDWhyDoQDTFNpZL39McEgS3/O9GIRECV9H6PGX5OkWMA
 0HBQnE/xXR1XFnSaPLMZgEXm1+21XawKUGJWStaoUdjhnj3+HP/SxVZj+vYlXlitJj
 XTlZpb9wZuNFA==
Date: Sun, 17 Oct 2021 23:32:05 +0800
From: Gao Xiang <xiang@kernel.org>
To: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v3 2/3] erofs: introduce the secondary compression head
Message-ID: <20211017153202.GA4054@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Chao Yu <chao@kernel.org>, Gao Xiang <xiang@kernel.org>,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Yue Hu <zbestahu@gmail.com>,
 Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20211008200839.24541-3-xiang@kernel.org>
 <20211009181209.23041-1-xiang@kernel.org>
 <c3ad3f92-6a35-acbb-923a-21611d232689@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c3ad3f92-6a35-acbb-923a-21611d232689@kernel.org>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Sun, Oct 17, 2021 at 11:27:54PM +0800, Chao Yu wrote:
> On 2021/10/10 2:12, Gao Xiang wrote:
> > From: Gao Xiang <hsiangkao@linux.alibaba.com>
> > 
> > Previously, for each HEAD lcluster, it can be either HEAD or PLAIN
> > lcluster to indicate whether the whole pcluster is compressed or not.
> > 
> > In this patch, a new HEAD2 head type is introduced to specify another
> > compression algorithm other than the primary algorithm for each
> > compressed file, which can be used for upcoming LZMA compression and
> > LZ4 range dictionary compression for various data patterns.
> > 
> > It has been stayed in the EROFS roadmap for years. Complete it now!
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> > v2: https://lore.kernel.org/r/20211008200839.24541-3-xiang@kernel.org
> > changes since v2:
> >   - simplify z_algorithmtype check suggested by Yue.
> > 
> >   fs/erofs/erofs_fs.h |  8 +++++---
> >   fs/erofs/zmap.c     | 38 ++++++++++++++++++++++++++------------
> >   2 files changed, 31 insertions(+), 15 deletions(-)
> > 
> > diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> > index b0b23f41abc3..f579c8c78fff 100644
> > --- a/fs/erofs/erofs_fs.h
> > +++ b/fs/erofs/erofs_fs.h
> > @@ -21,11 +21,13 @@
> >   #define EROFS_FEATURE_INCOMPAT_COMPR_CFGS	0x00000002
> >   #define EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER	0x00000002
> >   #define EROFS_FEATURE_INCOMPAT_CHUNKED_FILE	0x00000004
> > +#define EROFS_FEATURE_INCOMPAT_COMPR_HEAD2	0x00000008
> >   #define EROFS_ALL_FEATURE_INCOMPAT		\
> >   	(EROFS_FEATURE_INCOMPAT_LZ4_0PADDING | \
> >   	 EROFS_FEATURE_INCOMPAT_COMPR_CFGS | \
> >   	 EROFS_FEATURE_INCOMPAT_BIG_PCLUSTER | \
> > -	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE)
> > +	 EROFS_FEATURE_INCOMPAT_CHUNKED_FILE | \
> > +	 EROFS_FEATURE_INCOMPAT_COMPR_HEAD2)
> >   #define EROFS_SB_EXTSLOT_SIZE	16
> > @@ -314,9 +316,9 @@ struct z_erofs_map_header {
> >    */
> >   enum {
> >   	Z_EROFS_VLE_CLUSTER_TYPE_PLAIN		= 0,
> > -	Z_EROFS_VLE_CLUSTER_TYPE_HEAD		= 1,
> > +	Z_EROFS_VLE_CLUSTER_TYPE_HEAD1		= 1,
> >   	Z_EROFS_VLE_CLUSTER_TYPE_NONHEAD	= 2,
> > -	Z_EROFS_VLE_CLUSTER_TYPE_RESERVED	= 3,
> > +	Z_EROFS_VLE_CLUSTER_TYPE_HEAD2		= 3,
> 
> It needs to update comments above as well.

okay, let me revise them now.

Thanks,
Gao XIang

> 
> Thanks,
