Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0924D5C74
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 08:39:20 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KFHr56jQpz2yxW
	for <lists+linux-erofs@lfdr.de>; Fri, 11 Mar 2022 18:39:17 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.54;
 helo=out30-54.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-54.freemail.mail.aliyun.com
 (out30-54.freemail.mail.aliyun.com [115.124.30.54])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KFHr00pB6z2xBV
 for <linux-erofs@lists.ozlabs.org>; Fri, 11 Mar 2022 18:39:10 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V6sjQC7_1646984341; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V6sjQC7_1646984341) by smtp.aliyun-inc.com(127.0.0.1);
 Fri, 11 Mar 2022 15:39:03 +0800
Date: Fri, 11 Mar 2022 15:39:00 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH 1/2] erofs: clean up z_erofs_extent_lookback
Message-ID: <Yir8lBR2gyN1CJ8D@B-P7TQMD6M-0146.local>
References: <20220310182743.102365-1-hsiangkao@linux.alibaba.com>
 <20220311151232.00003619.zbestahu@gmail.com>
 <Yir6HNsdYFdLVwEN@B-P7TQMD6M-0146.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yir6HNsdYFdLVwEN@B-P7TQMD6M-0146.local>
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
Cc: huyue2@coolpad.com, linux-erofs@lists.ozlabs.org,
 LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Mar 11, 2022 at 03:28:28PM +0800, Gao Xiang wrote:
> On Fri, Mar 11, 2022 at 03:12:32PM +0800, Yue Hu wrote:
> > On Fri, 11 Mar 2022 02:27:42 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> > 
> > > Avoid the unnecessary tail recursion since it can be converted into
> > > a loop directly in order to prevent potential stack overflow.
> > > 
> > > It's a pretty straightforward conversion.
> > > 
> > > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > > ---
> > >  fs/erofs/zmap.c | 67 ++++++++++++++++++++++++-------------------------
> > >  1 file changed, 33 insertions(+), 34 deletions(-)
> > > 
> > > diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> > > index b4059b9c3bac..572f0b8151ba 100644
> > > --- a/fs/erofs/zmap.c
> > > +++ b/fs/erofs/zmap.c
> > > @@ -431,48 +431,47 @@ static int z_erofs_extent_lookback(struct z_erofs_maprecorder *m,
> > >  				   unsigned int lookback_distance)
> > >  {
> > >  	struct erofs_inode *const vi = EROFS_I(m->inode);
> > > -	struct erofs_map_blocks *const map = m->map;
> > >  	const unsigned int lclusterbits = vi->z_logical_clusterbits;
> > > -	unsigned long lcn = m->lcn;
> > > -	int err;
> > >  
> > > -	if (lcn < lookback_distance) {
> > > -		erofs_err(m->inode->i_sb,
> > > -			  "bogus lookback distance @ nid %llu", vi->nid);
> > > -		DBG_BUGON(1);
> > > -		return -EFSCORRUPTED;
> > > -	}
> > > +	while (m->lcn >= lookback_distance) {
> > > +		unsigned long lcn = m->lcn - lookback_distance;
> > > +		int err;
> > 
> > may better to declare variable 'lclusterbits' in loop just like 'err' usage?
> 
> I'm fine with either way. Ok, will post the next version later.

Oh, I just noticed that you mean `lclusterbits', I think it won't
change in this function, so I don't tend to move it into the inner
loop.

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
