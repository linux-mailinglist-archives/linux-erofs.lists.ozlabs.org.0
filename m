Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF25575CDE
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 09:59:36 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LkkKK42JQz3c51
	for <lists+linux-erofs@lfdr.de>; Fri, 15 Jul 2022 17:59:33 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.43; helo=out30-43.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LkkKD16kNz30LR
	for <linux-erofs@lists.ozlabs.org>; Fri, 15 Jul 2022 17:59:25 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJOMovn_1657871957;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJOMovn_1657871957)
          by smtp.aliyun-inc.com;
          Fri, 15 Jul 2022 15:59:19 +0800
Date: Fri, 15 Jul 2022 15:59:17 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH 07/16] erofs: switch compressed_pages[] to bufvec
Message-ID: <YtEeVR4V/N9m/WXO@B-P7TQMD6M-0146.local>
References: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
 <20220714132051.46012-8-hsiangkao@linux.alibaba.com>
 <20220715155323.00005df4.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220715155323.00005df4.zbestahu@gmail.com>
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
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Fri, Jul 15, 2022 at 03:53:23PM +0800, Yue Hu wrote:
> On Thu, 14 Jul 2022 21:20:42 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
> > Convert compressed_pages[] to bufvec in order to avoid using
> > page->private to keep onlinepage_index (decompressed offset)
> > for inplace I/O pages.
> > 
> > In the future, we only rely on folio->private to keep a countdown
> > to unlock folios and set folio_uptodate.
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >  fs/erofs/zdata.c | 113 +++++++++++++++++++++++------------------------
> >  fs/erofs/zdata.h |   4 +-
> >  2 files changed, 57 insertions(+), 60 deletions(-)
> > 
> > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > index 757d352bc2c7..f2e3f07baad7 100644
> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -134,7 +134,7 @@ static int z_erofs_create_pcluster_pool(void)
> >  
> >  	for (pcs = pcluster_pool;
> >  	     pcs < pcluster_pool + ARRAY_SIZE(pcluster_pool); ++pcs) {
> > -		size = struct_size(a, compressed_pages, pcs->maxpages);
> > +		size = struct_size(a, compressed_bvecs, pcs->maxpages);
> >  
> >  		sprintf(pcs->name, "erofs_pcluster-%u", pcs->maxpages);
> >  		pcs->slab = kmem_cache_create(pcs->name, size, 0,
> > @@ -287,16 +287,16 @@ struct z_erofs_decompress_frontend {
> >  
> >  	struct page *candidate_bvpage;
> >  	struct z_erofs_pcluster *pcl, *tailpcl;
> > -	/* a pointer used to pick up inplace I/O pages */
> > -	struct page **icpage_ptr;
> >  	z_erofs_next_pcluster_t owned_head;
> > -
> >  	enum z_erofs_collectmode mode;
> >  
> >  	bool readahead;
> >  	/* used for applying cache strategy on the fly */
> >  	bool backmost;
> >  	erofs_off_t headoffset;
> > +
> > +	/* a pointer used to pick up inplace I/O pages */
> > +	unsigned int icur;
> 
> not a pointer?

Here `pointer' means a cursor or called sub-index.

Thanks,
Gao Xiang
