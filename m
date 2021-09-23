Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 302D9415D0C
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Sep 2021 13:50:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HFYPN1DXZz2yn8
	for <lists+linux-erofs@lfdr.de>; Thu, 23 Sep 2021 21:50:00 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HFYPJ1Zgmz2y6F
 for <linux-erofs@lists.ozlabs.org>; Thu, 23 Sep 2021 21:49:51 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R131e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0UpKskVP_1632397782; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UpKskVP_1632397782) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 23 Sep 2021 19:49:44 +0800
Date: Thu, 23 Sep 2021 19:49:42 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH] erofs: fix compacted_2b if compacted_4b_initial > totalidx
Message-ID: <YUxp1rsN0Ce88YQI@B-P7TQMD6M-0146.local>
References: <20210914035915.1190-1-zbestahu@gmail.com>
 <YUAm+kOdKcCzgcEy@B-P7TQMD6M-0146.local>
 <20210914125748.00003cd2.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210914125748.00003cd2.zbestahu@gmail.com>
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
Cc: linux-kernel@vger.kernel.org, zbestahu@163.com, huyue2@yulong.com,
 linux-erofs@lists.ozlabs.org, zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Sep 14, 2021 at 12:57:48PM +0800, Yue Hu wrote:
> On Tue, 14 Sep 2021 12:37:14 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
> > On Tue, Sep 14, 2021 at 11:59:15AM +0800, Yue Hu wrote:
> > > From: Yue Hu <huyue2@yulong.com>
> > > 
> > > Currently, the whole indexes will only be compacted 4B if
> > > compacted_4b_initial > totalidx. So, the calculated compacted_2b
> > > is worthless for that case. It may waste CPU resources.
> > > 
> > > No need to update compacted_4b_initial as mkfs since it's used to
> > > fulfill the alignment of the 1st compacted_2b pack and would handle
> > > the case above.
> > > 
> > > We also need to clarify compacted_4b_end here. It's used for the
> > > last lclusters which aren't fitted in the previous compacted_2b
> > > packs.
> > > 
> > > Some messages are from Xiang.
> > > 
> > > Signed-off-by: Yue Hu <huyue2@yulong.com>  
> > 
> > Looks good to me,
> > Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > 
> > (although I think the subject title would be better changed into
> >  "clear compacted_2b if compacted_4b_initial > totalidx"
> 
> Yeah, 'clear' is much better for this change.
> 
> Thanks.
> 
> >  since 'fix'-likewise words could trigger some AI bot for stable
> >  kernel backporting..)
> > 
> > Thanks,
> > Gao Xiang
> > 
> > > ---
> > >  fs/erofs/zmap.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> > > index 9fb98d8..aeed404 100644
> > > --- a/fs/erofs/zmap.c
> > > +++ b/fs/erofs/zmap.c
> > > @@ -369,7 +369,8 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> > >  	if (compacted_4b_initial == 32 / 4)
> > >  		compacted_4b_initial = 0;
> > >  
> > > -	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
> > > +	if ((vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B) &&
> > > +	    compacted_4b_initial <= totalidx) {

btw, I've fixed up the build error due to redundant brace '{' when
applying...

Thanks,
Gao Xiang

> > >  		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
> > >  	else
> > >  		compacted_2b = 0;
> > > -- 
> > > 1.9.1  
