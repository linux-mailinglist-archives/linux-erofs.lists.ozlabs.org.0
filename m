Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEDE3F1426
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Aug 2021 09:12:42 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqwvX3twNz3bYK
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Aug 2021 17:12:40 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133;
 helo=out30-133.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GqwvT3Jbwz3bWL
 for <linux-erofs@lists.ozlabs.org>; Thu, 19 Aug 2021 17:12:35 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R541e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0UjzCI5U_1629357133; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UjzCI5U_1629357133) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 19 Aug 2021 15:12:14 +0800
Date: Thu, 19 Aug 2021 15:12:12 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Joseph Qi <joseph.qi@linux.alibaba.com>
Subject: Re: [PATCH v2 2/2] erofs: support reading chunk-based uncompressed
 files
Message-ID: <YR4ETD4sPl356Ci9@B-P7TQMD6M-0146.local>
References: <20210818070713.4437-1-hsiangkao@linux.alibaba.com>
 <20210819063310.177035-1-hsiangkao@linux.alibaba.com>
 <20210819063310.177035-2-hsiangkao@linux.alibaba.com>
 <e5daab20-ed0a-70de-1f37-0613454a52c3@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e5daab20-ed0a-70de-1f37-0613454a52c3@linux.alibaba.com>
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
Cc: Tao Ma <boyu.mt@taobao.com>, LKML <linux-kernel@vger.kernel.org>,
 Peng Tao <tao.peng@linux.alibaba.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 Eryu Guan <eguan@linux.alibaba.com>, Liu Jiang <gerry@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Joseph,

On Thu, Aug 19, 2021 at 02:37:50PM +0800, Joseph Qi wrote:
> 
> 
> On 8/19/21 2:33 PM, Gao Xiang wrote:

...

> > diff --git a/fs/erofs/inode.c b/fs/erofs/inode.c
> > index d13e0709599c..4408929bd6f5 100644
> > --- a/fs/erofs/inode.c
> > +++ b/fs/erofs/inode.c
> > @@ -2,6 +2,7 @@
> >  /*
> >   * Copyright (C) 2017-2018 HUAWEI, Inc.
> >   *             https://www.huawei.com/
> > + * Copyright (C) 2021, Alibaba Cloud
> >   */
> >  #include "xattr.h"
> >  
> > @@ -122,7 +123,9 @@ static struct page *erofs_read_inode(struct inode *inode,
> >  		/* total blocks for compressed files */
> >  		if (erofs_inode_is_data_compressed(vi->datalayout))
> >  			nblks = le32_to_cpu(die->i_u.compressed_blocks);
> > -
> > +		else if (vi->datalayout == EROFS_INODE_CHUNK_BASED)
> > +			/* fill chunked inode summary info */
> > +			vi->chunkformat = le16_to_cpu(die->i_u.c.format);
> 
> Better to add braces for if/else.

Thanks for the kind suggestion. Here is single statement, I've checked
coding-style in Documentation. It's no necessary to use brace for this.
And checkpatch didn't report anything.

Also, I found some reference at
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/mm/vmscan.c?h=v5.13#n3066

But anyway, I could update it when applying, either looks good to me.

Thanks,
Gao Xiang
