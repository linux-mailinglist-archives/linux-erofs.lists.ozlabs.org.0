Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 10E9C455485
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Nov 2021 07:01:40 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hvq1Y6zt6z2ync
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Nov 2021 17:01:37 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hvq1T45Lcz2yLd
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Nov 2021 17:01:29 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0Ux8pCKb_1637215271; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Ux8pCKb_1637215271) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 18 Nov 2021 14:01:12 +0800
Date: Thu, 18 Nov 2021 14:01:10 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Yue Hu <zbestahu@gmail.com>
Subject: Re: [PATCH v4 6/6] erofs-utils: get compression algorithms directly
 on mapping
Message-ID: <YZXsJki1fHGt+BTb@B-P7TQMD6M-0146.local>
References: <20211116094939.32246-1-hsiangkao@linux.alibaba.com>
 <20211116094939.32246-7-hsiangkao@linux.alibaba.com>
 <20211118135133.00002c4e.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211118135133.00002c4e.zbestahu@gmail.com>
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
Cc: Yan Song <imeoer@linux.alibaba.com>, Peng Tao <tao.peng@linux.alibaba.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, Liu Bo <bo.liu@linux.alibaba.com>,
 Changwei Ge <chge@linux.alibaba.com>, Liu Jiang <gerry@linux.alibaba.com>,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Nov 18, 2021 at 01:51:33PM +0800, Yue Hu wrote:
> On Tue, 16 Nov 2021 17:49:39 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

...

> >  	map->m_pa = blknr_to_addr(m.pblk);
> > -	map->m_flags |= EROFS_MAP_MAPPED;
> >  
> >  	err = z_erofs_get_extent_compressedlen(&m, initial_lcn);
> >  	if (err)
> >  		goto out;
> >  
> > +	if (m.headtype == Z_EROFS_VLE_CLUSTER_TYPE_PLAIN)
> > +		map->m_algorithmformat = Z_EROFS_COMPRESSION_SHIFTED;
> > +	else
> > +		map->m_algorithmformat = vi->z_algorithmtype[0];
> > +
> >  	if (flags & EROFS_GET_BLOCKS_FIEMAP) {
> >  		err = z_erofs_get_extent_decompressedlen(&m);
> >  		if (!err)
> 
> Reviewed-by: Yue Hu <huyue2@yulong.com>
> 

Thanks for the review, will apply to dev branch later.

Thanks,
Gao Xiang

> Thanks.
