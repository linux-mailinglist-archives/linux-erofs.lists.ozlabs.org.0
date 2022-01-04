Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AD8483ED7
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jan 2022 10:06:24 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JSmv24gxqz2yn3
	for <lists+linux-erofs@lfdr.de>; Tue,  4 Jan 2022 20:06:22 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JSmty3zYHz2xBF
 for <linux-erofs@lists.ozlabs.org>; Tue,  4 Jan 2022 20:06:16 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0V0u6ZRm_1641287154; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0V0u6ZRm_1641287154) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 04 Jan 2022 17:05:55 +0800
Date: Tue, 4 Jan 2022 17:05:53 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH v2 1/5] erofs: introduce meta buffer operations
Message-ID: <YdQN8Q4UsLgZVR+c@B-P7TQMD6M-0146.local>
References: <20220102040017.51352-1-hsiangkao@linux.alibaba.com>
 <20220102040017.51352-2-hsiangkao@linux.alibaba.com>
 <6fbbd94a-7c68-6798-4248-d9c0807bd89d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6fbbd94a-7c68-6798-4248-d9c0807bd89d@kernel.org>
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
Cc: Liu Bo <bo.liu@linux.alibaba.com>, Yue Hu <huyue2@yulong.com>,
 linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Tue, Jan 04, 2022 at 03:54:08PM +0800, Chao Yu wrote:
> On 2022/1/2 12:00, Gao Xiang wrote:
> > In order to support subpage and folio for all uncompressed files,
> > introduce meta buffer descriptors, which can be effectively stored
> > on stack, in place of meta page operations.
> > 
> > This converts the uncompressed data path to meta buffers.
> > 
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >   fs/erofs/data.c     | 97 +++++++++++++++++++++++++++++++++++----------
> >   fs/erofs/internal.h | 13 ++++++
> >   2 files changed, 89 insertions(+), 21 deletions(-)
> > 
> > diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> > index 4f98c76ec043..6495e16a50a9 100644
> > --- a/fs/erofs/data.c
> > +++ b/fs/erofs/data.c
> > @@ -22,6 +22,56 @@ struct page *erofs_get_meta_page(struct super_block *sb, erofs_blk_t blkaddr)
> >   	return page;
> >   }
> > +void erofs_unmap_metabuf(struct erofs_buf *buf)
> > +{
> > +	if (buf->kmap_type == EROFS_KMAP)
> > +		kunmap(buf->page);
> > +	else if (buf->kmap_type == EROFS_KMAP_ATOMIC)
> > +		kunmap_atomic(buf->base);
> 
> Once user calls this function, .base should be invalidated.
> 
> buf->base = NULL;

Thanks for your suggestion!

Since buf->kmap_type will be switched to EROFS_NO_KMAP, so buf->base
is completely ignored (IOWs, it's unnecessary to reset buf->base..),
however I'm fine to set buf->base = NULL here either.

Thanks,
Gao Xiang 

> 
> Otherwise, it looks good to me.
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,
> 
