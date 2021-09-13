Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0594089A3
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Sep 2021 12:59:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H7Nl71t14z2yKJ
	for <lists+linux-erofs@lfdr.de>; Mon, 13 Sep 2021 20:58:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=S/pfew6n;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (sender SPF authorized) smtp.mailfrom=163.com
 (client-ip=220.181.12.18; helo=m12-18.163.com; envelope-from=zbestahu@163.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=S/pfew6n; dkim-atps=neutral
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
 by lists.ozlabs.org (Postfix) with ESMTP id 4H7Nkz3lTkz2yHb
 for <linux-erofs@lists.ozlabs.org>; Mon, 13 Sep 2021 20:58:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=cXS37
 ga9lIUCDu3UszJeebR03eW18Sxrg0lTQIziZWI=; b=S/pfew6nNArZoIK01Ql+a
 IRyNqWhAsO8VyY6UalKDvoth+aQ+zR04ta1UI9qx9vRRrHyUzQY9wPnPtXEuN/IA
 nmcEvFaDlEShAjuuNdJNGqg8YQDWIMul+aJj+mHg1mbA2IFXJeFhGZ3QXzzEDn1h
 58Oy5xQoNlJUlzRL1dVsPs=
Received: from rockpi4b (unknown [112.20.66.82])
 by smtp14 (Coremail) with SMTP id EsCowAAHmsvdLj9hkPaCAg--.37957S2;
 Mon, 13 Sep 2021 18:58:38 +0800 (CST)
Date: Mon, 13 Sep 2021 18:58:36 +0800
From: Yue Hu <zbestahu@163.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] erofs: fix compacted_{4b_initial, 2b} when
 compacted_4b_initial > totalidx
Message-ID: <20210913185836.088e7059.zbestahu@163.com>
In-Reply-To: <YT8VvOyXIDdyD7WI@B-P7TQMD6M-0146.local>
References: <20210913072405.1128-1-zbestahu@gmail.com>
 <YT8QbaAEkqBw//R0@B-P7TQMD6M-0146.local>
 <20210913170016.00007580.zbestahu@gmail.com>
 <YT8VvOyXIDdyD7WI@B-P7TQMD6M-0146.local>
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: EsCowAAHmsvdLj9hkPaCAg--.37957S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF45tF1Dur48KFy8CFW7Arb_yoW5GFy7pr
 ZrKF48Ja4vqFn2yw1xtw1rXF48tw4kCr4UW34YqFy0qr90kFn3Jr18tF98uF1UXw1fKr40
 vF4Uu3Z3CFW7Ar7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ufb1nUUUUU=
X-Originating-IP: [112.20.66.82]
X-CM-SenderInfo: p2eh23xdkxqiywtou0bp/1tbitBINEVSIm3o6hQABs5
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
Cc: linux-kernel@vger.kernel.org, huyue2@yulong.com,
 linux-erofs@lists.ozlabs.org, zhangwen@yulong.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xiang,

On Mon, 13 Sep 2021 17:11:24 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Mon, Sep 13, 2021 at 05:00:16PM +0800, Yue Hu wrote:
> > On Mon, 13 Sep 2021 16:48:45 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >   
> > > Hi Yue,
> > > 
> > > On Mon, Sep 13, 2021 at 03:24:05PM +0800, Yue Hu wrote:  
> > > > From: Yue Hu <huyue2@yulong.com>
> > > > 
> > > > mkfs.erofs will treat compacted_4b_initial & compacted_2b as 0 if
> > > > compacted_4b_initial > totalidx, kernel should be aligned with it
> > > > accordingly.    
> > > 
> > > There is no difference between compacted_4b_initial or compacted_4b_end
> > > for compacted 4B. Since in this way totalidx for compact 2B won't larger
> > > than 16 (number of lclusters in a compacted 2B pack.)  
> > 
> > However, we can see compacted_2b is a big number for this case. It should
> > be pointless.  
> 
> Does it has some real impact?

No real impact to correct result.

> 
> compacted_4b_initial is only used for the alignment use for the
> first compacted_2b so that each compacted_2b pack won't cross
> the block (page) boundary. And compacted_4b_end is for the last
> lclusters aren't fitted in any compacted_2b pack.
> 
> If compacted_4b_initial > totalidx, I think the whole indexes
> would be compacted 4B and handled in
> 
> 	if (lcn < compacted_4b_initial) {
> 		amortizedshift = 2;
> 		goto out;
> 	}

Yes, it is. 

My point is why we need compacted_2b here for this case. If it's
not helpful/used for next code logic, we should remove/avoid it.
I think that may cause some misunderstanding and consume unneeded
CPU resources.

Thanks.

> 
> Thanks,
> Gao Xiang
> 
> > 
> > Thanks.
> >   
> > > 
> > > So it can be handled in either compacted_4b_initial or compacted_4b_end
> > > cases, because there are all compacted 4B.
> > > 
> > > Thanks,
> > > Gao Xiang
> > >   
> > > > 
> > > > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > > > ---
> > > >  fs/erofs/zmap.c | 5 ++++-
> > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
> > > > index 9fb98d8..4f941b6 100644
> > > > --- a/fs/erofs/zmap.c
> > > > +++ b/fs/erofs/zmap.c
> > > > @@ -369,7 +369,10 @@ static int compacted_load_cluster_from_disk(struct z_erofs_maprecorder *m,
> > > >  	if (compacted_4b_initial == 32 / 4)
> > > >  		compacted_4b_initial = 0;
> > > >  
> > > > -	if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
> > > > +	if (compacted_4b_initial > totalidx) {
> > > > +		compacted_4b_initial = 0;
> > > > +		compacted_2b = 0;
> > > > +	} else if (vi->z_advise & Z_EROFS_ADVISE_COMPACTED_2B)
> > > >  		compacted_2b = rounddown(totalidx - compacted_4b_initial, 16);
> > > >  	else
> > > >  		compacted_2b = 0;
> > > > -- 
> > > > 1.9.1    


