Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5E523F0FD0
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Aug 2021 02:59:49 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqmdH58zTz30Gv
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Aug 2021 10:59:47 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.56;
 helo=out30-56.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GqmdD3Cj5z301N
 for <linux-erofs@lists.ozlabs.org>; Thu, 19 Aug 2021 10:59:42 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R221e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=alimailimapcm10staff010182156082;
 MF=hsiangkao@linux.alibaba.com; NM=1; PH=DS; RN=8; SR=0;
 TI=SMTPD_---0UjtBNTL_1629334764; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UjtBNTL_1629334764) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 19 Aug 2021 08:59:26 +0800
Date: Thu, 19 Aug 2021 08:59:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Liu Bo <bo.liu@linux.alibaba.com>
Subject: Re: [PATCH 1/2] erofs: introduce chunk-based file on-disk format
Message-ID: <YR2s7Gj7RDl7TaVn@B-P7TQMD6M-0146.local>
References: <20210818070713.4437-1-hsiangkao@linux.alibaba.com>
 <20210818222804.GA73193@rsjd01523.et2sqa>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210818222804.GA73193@rsjd01523.et2sqa>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Peng Tao <tao.peng@linux.alibaba.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Eryu Guan <eguan@linux.alibaba.com>,
 Liu Jiang <gerry@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Bo,

On Thu, Aug 19, 2021 at 06:28:04AM +0800, Liu Bo wrote:
> On Wed, Aug 18, 2021 at 03:07:12PM +0800, Gao Xiang wrote:

...

> > +	EROFS_INODE_CHUNK_BASED			= 4,
> >  	EROFS_INODE_DATALAYOUT_MAX
> >  };
> >  
> > @@ -90,6 +96,19 @@ static inline bool erofs_inode_is_data_compressed(unsigned int datamode)
> >  #define EROFS_I_ALL	\
> >  	((1 << (EROFS_I_DATALAYOUT_BIT + EROFS_I_DATALAYOUT_BITS)) - 1)
> >  
> > +/* indicate chunk blkbits, thus `chunksize = blocksize << chunk blkbits' */
> 
> A typo in the quotation marks.  (`chunksize = ) should be ('chunksize =)

Such usage is like below:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0e389028ad75412ff624b304913bba14f8d46ec4
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=78128fabd022240852859c0b253972147593690b
I'm fine in either way. I'll update it in the next version or when
submitting.

> 
> Otherwise it looks good.
> 
> Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>

Thanks for the review!

Thanks,
Gao Xiang

> 
> thanks,
> liubo
> 
