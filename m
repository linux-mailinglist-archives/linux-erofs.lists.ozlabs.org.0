Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD162D413E
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 12:40:25 +0100 (CET)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CrZq75ZszzDqmF
	for <lists+linux-erofs@lfdr.de>; Wed,  9 Dec 2020 22:40:19 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=63.128.21.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=hsiangkao@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=hYvMtFrj; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hYvMtFrj; 
 dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CrZpp4QrPzDqkb
 for <linux-erofs@lists.ozlabs.org>; Wed,  9 Dec 2020 22:40:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607513999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LQQtBr/xncf1OOMfe6ZF4U94fqdAGaQDE6cOcjJoC+4=;
 b=hYvMtFrjCU3SzgWpDJMRpFZ0/d03MDuVotGVsJU/rKQqmY7f+L3t1zChxMBHwGpVhm8BEN
 IA/+aR7rOErFwT0rfrtcuOjDdBD043TjY2AEpuXwUDoAG4SrMgXGwVBRCsDPi8fwyi29A1
 BOk5LA57l6cv49LUMbCkIxa0rCCWPDM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607513999;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LQQtBr/xncf1OOMfe6ZF4U94fqdAGaQDE6cOcjJoC+4=;
 b=hYvMtFrjCU3SzgWpDJMRpFZ0/d03MDuVotGVsJU/rKQqmY7f+L3t1zChxMBHwGpVhm8BEN
 IA/+aR7rOErFwT0rfrtcuOjDdBD043TjY2AEpuXwUDoAG4SrMgXGwVBRCsDPi8fwyi29A1
 BOk5LA57l6cv49LUMbCkIxa0rCCWPDM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-F33wMEUjPIm1I0idySfB2Q-1; Wed, 09 Dec 2020 06:39:57 -0500
X-MC-Unique: F33wMEUjPIm1I0idySfB2Q-1
Received: by mail-pj1-f72.google.com with SMTP id o13so808862pjp.1
 for <linux-erofs@lists.ozlabs.org>; Wed, 09 Dec 2020 03:39:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LQQtBr/xncf1OOMfe6ZF4U94fqdAGaQDE6cOcjJoC+4=;
 b=lj4zjGf+CLK0s+repJ1o6ZDB+yPBuuccrRyFa5bt3aj0ueUE1MrfUwLb2V8sbvHP6D
 4Mi0gV/zozdLXzoefL1bbrt4MDUSEajecY3qtjQbgw6hVGWtnhycCVuJ2w5W9+afPqrw
 lFUEEqadT/qDZCbfOKd5mvGbxu6Pmv/D+ZwyMwJ+wTCq75N+JZV2VSHihFJ9R1WpWzwN
 +xOCA1xhKLufNZAP0Y8upRE5322P0ebDZD32d4G5PZDJ6OBvlKM9yCuM9Y2k67CAHvsc
 66VIIFwLLpOAW2xUk2O+hft+43aTUwQgGfIotOY3gktxcRGywXa1E0mlzj0P3Mc/SRfZ
 1LfQ==
X-Gm-Message-State: AOAM533vsVeed6rHaJbuJsDJBnfzNaY1C/FUN082YYscAHrfVOCWAK1R
 OyXZwPZ2RSqGH4gXB9NIlYubMTsxkU0FCWYknPH/+6DG/U2wwTG0HY2vnfhDVJHNH/8lOnINslo
 OFVIgOjJDdrpiiMJSoAawcNYx
X-Received: by 2002:a17:90a:a393:: with SMTP id
 x19mr1885228pjp.8.1607513993353; 
 Wed, 09 Dec 2020 03:39:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwu1ZInadIHVy+SdexMutvdjrIhjmSkYMi9geOWjK6ltOjroPKdDiaQxAFCYJyTpFkUIg4+dg==
X-Received: by 2002:a17:90a:a393:: with SMTP id
 x19mr1885211pjp.8.1607513993162; 
 Wed, 09 Dec 2020 03:39:53 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id ci2sm1843192pjb.40.2020.12.09.03.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Dec 2020 03:39:52 -0800 (PST)
Date: Wed, 9 Dec 2020 19:39:41 +0800
From: Gao Xiang <hsiangkao@redhat.com>
To: Huang Jianan <huangjianan@oppo.com>
Subject: Re: [PATCH v4] erofs: avoid using generic_block_bmap
Message-ID: <20201209113941.GB105731@xiangao.remote.csb>
References: <20201209023930.15554-1-huangjianan@oppo.com>
 <23527fc2-811b-321e-10f1-cb5b50affdbb@huawei.com>
MIME-Version: 1.0
In-Reply-To: <23527fc2-811b-321e-10f1-cb5b50affdbb@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hsiangkao@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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
Cc: guoweichao@oppo.com, linux-erofs@lists.ozlabs.org, zhangshiming@oppo.com,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Jianan,

On Wed, Dec 09, 2020 at 06:08:41PM +0800, Chao Yu wrote:
> On 2020/12/9 10:39, Huang Jianan wrote:
> > iblock indicates the number of i_blkbits-sized blocks rather than
> > sectors.
> > 
> > In addition, considering buffer_head limits mapped size to 32-bits,
> > should avoid using generic_block_bmap.
> > 
> > Fixes: 9da681e017a3 ("staging: erofs: support bmap")
> > Signed-off-by: Huang Jianan <huangjianan@oppo.com>
> > Signed-off-by: Guo Weichao <guoweichao@oppo.com>

Could you send out an updated version? I might get a point to freeze
dev branch since it needs some time on linux-next....

Thanks,
Gao Xiang

> > ---
> >   fs/erofs/data.c | 30 ++++++++++--------------------
> >   1 file changed, 10 insertions(+), 20 deletions(-)
> > 
> > diff --git a/fs/erofs/data.c b/fs/erofs/data.c
> > index 347be146884c..d6ea0a216b57 100644
> > --- a/fs/erofs/data.c
> > +++ b/fs/erofs/data.c
> > @@ -312,36 +312,26 @@ static void erofs_raw_access_readahead(struct readahead_control *rac)
> >   		submit_bio(bio);
> >   }
> > -static int erofs_get_block(struct inode *inode, sector_t iblock,
> > -			   struct buffer_head *bh, int create)
> > -{
> > -	struct erofs_map_blocks map = {
> > -		.m_la = iblock << 9,
> > -	};
> > -	int err;
> > -
> > -	err = erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW);
> > -	if (err)
> > -		return err;
> > -
> > -	if (map.m_flags & EROFS_MAP_MAPPED)
> > -		bh->b_blocknr = erofs_blknr(map.m_pa);
> > -
> > -	return err;
> > -}
> > -
> >   static sector_t erofs_bmap(struct address_space *mapping, sector_t block)
> >   {
> >   	struct inode *inode = mapping->host;
> > +	struct erofs_map_blocks map = {
> > +		.m_la = blknr_to_addr(block),
> > +	};
> > +	sector_t blknr = 0;
> 
> It could be removed?
> 
> >   	if (EROFS_I(inode)->datalayout == EROFS_INODE_FLAT_INLINE) {
> >   		erofs_blk_t blks = i_size_read(inode) >> LOG_BLOCK_SIZE;
> >   		if (block >> LOG_SECTORS_PER_BLOCK >= blks)
> > -			return 0;
> 
> return 0;
> 
> > +			goto out;
> >   	}
> > -	return generic_block_bmap(mapping, block, erofs_get_block);
> > +	if (!erofs_map_blocks(inode, &map, EROFS_GET_BLOCKS_RAW))
> > +		blknr = erofs_blknr(map.m_pa);
> 
> return erofs_blknr(map.m_pa);
> 
> > +
> > +out:
> > +	return blknr;
> 
> return 0;
> 
> Anyway, LGTM.
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> >   }
> >   /* for uncompressed (aligned) files and raw access for other files */
> > 
> 

