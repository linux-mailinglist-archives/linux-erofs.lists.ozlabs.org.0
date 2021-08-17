Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA0473EEEA1
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Aug 2021 16:38:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Gptv244mCz30Hh
	for <lists+linux-erofs@lfdr.de>; Wed, 18 Aug 2021 00:38:38 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.44;
 helo=out30-44.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Gptts4yrXz30CX
 for <linux-erofs@lists.ozlabs.org>; Wed, 18 Aug 2021 00:38:25 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R291e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0UjSfEIs_1629211085; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UjSfEIs_1629211085) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 17 Aug 2021 22:38:06 +0800
Date: Tue, 17 Aug 2021 22:38:04 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] erofs-utils: add clusterofs zero check to
 write_uncompressed_extent()
Message-ID: <YRvJzLoDgvh11zVt@B-P7TQMD6M-0146.local>
References: <20210817040605.732-1-zbestahu@gmail.com>
 <YRu16nuqv+5YkW4H@B-P7TQMD6M-0146.local>
 <20210817221046.000037aa.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210817221046.000037aa.zbestahu@gmail.com>
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org, huyue2@yulong.com,
 zbestahu@163.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Aug 17, 2021 at 10:10:46PM +0800, Yue Hu wrote:
> Hi Xiang,
> 
> On Tue, 17 Aug 2021 21:13:14 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
> > Hi Yue,
> > 
> > On Tue, Aug 17, 2021 at 12:06:04PM +0800, Yue Hu wrote:
> > > From: Yue Hu <huyue2@yulong.com>
> > > 
> > > No need to reset clusterofs to 0 if it's already 0. Acturally, we also
> > > observed that case frequently. Let's avoid it.
> > > 
> > > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > > ---
> > >  lib/compress.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/lib/compress.c b/lib/compress.c
> > > index 40723a1..a8ebbc1 100644
> > > --- a/lib/compress.c
> > > +++ b/lib/compress.c
> > > @@ -130,7 +130,7 @@ static int write_uncompressed_extent(struct z_erofs_vle_compress_ctx *ctx,
> > >  	unsigned int count;
> > >  
> > >  	/* reset clusterofs to 0 if permitted */
> > > -	if (!erofs_sb_has_lz4_0padding() &&
> > > +	if (!erofs_sb_has_lz4_0padding() && ctx->clusterofs &&  
> > 
> > Also out of curiosity, which means erofs is used without lz4 0padding?
> 
> Yes. We are using legacy compression layout now.

Ok, I think sometime I will seperate it into (non)compact compress
indexes, and (non)0padding. It was once named as legacy just before
Linux < 5.3 didn't support them.

By default, the preferred option now I think is compact and 0padding.

0padding will enable in-place decompression (and LZMA will always
enable it.)
compact will reduce metadata even further as long as the compressed
data is consecutive (e.g. 2 bytes each lcluster for compact indexes
rather than 8 bytes each lcluster for noncompact indexes, but anyway,
either (non)compact metadata can support effective data random access.)

Ok, if it's somewhat kernel 4.19 based code, I'd suggest to upgrade
the codebase at least to 5.4, not because 4.19 doesn't work, but
really for some performance concern....

Thanks,
Gao Xiang
