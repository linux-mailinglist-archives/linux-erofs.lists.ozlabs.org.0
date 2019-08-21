Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDF596F88
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 04:32:18 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46CsBS1d04zDqnB
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Aug 2019 12:32:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.189; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46CsBL6FDqzDqgr
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Aug 2019 12:32:10 +1000 (AEST)
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id AAA6243E135E022D3262;
 Wed, 21 Aug 2019 10:32:03 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 21 Aug 2019 10:32:03 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 21 Aug 2019 10:32:02 +0800
Date: Wed, 21 Aug 2019 10:31:22 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 2/2] staging/erofs: Balanced braces around a few
 conditional statements.
Message-ID: <20190821023122.GA159802@architecture4>
References: <1566346700-28536-1-git-send-email-caitlynannefinn@gmail.com>
 <1566346700-28536-3-git-send-email-caitlynannefinn@gmail.com>
 <7aaca457a3d3feb951082d0659eec568a908971f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7aaca457a3d3feb951082d0659eec568a908971f.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme713-chm.china.huawei.com (10.1.199.109) To
 dggeme762-chm.china.huawei.com (10.3.19.108)
X-CFilter-Loop: Reflected
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
Cc: devel@driverdev.osuosl.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Caitlyn <caitlynannefinn@gmail.com>, linux-erofs@lists.ozlabs.org,
 "Tobin C . Harding" <me@tobin.cc>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Aug 20, 2019 at 07:26:46PM -0700, Joe Perches wrote:
> On Tue, 2019-08-20 at 20:18 -0400, Caitlyn wrote:
> > Balanced braces to fix some checkpath warnings in inode.c and
> > unzip_vle.c
> []
> > diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
> []
> > @@ -915,21 +915,21 @@ static int z_erofs_vle_unzip(struct super_block *sb,
> >  	mutex_lock(&work->lock);
> >  	nr_pages = work->nr_pages;
> >  
> > -	if (likely(nr_pages <= Z_EROFS_VLE_VMAP_ONSTACK_PAGES))
> > +	if (likely(nr_pages <= Z_EROFS_VLE_VMAP_ONSTACK_PAGES)) {
> >  		pages = pages_onstack;
> > -	else if (nr_pages <= Z_EROFS_VLE_VMAP_GLOBAL_PAGES &&
> > -		 mutex_trylock(&z_pagemap_global_lock))
> > +	} else if (nr_pages <= Z_EROFS_VLE_VMAP_GLOBAL_PAGES &&
> > +		 mutex_trylock(&z_pagemap_global_lock)) {
> 
> Extra space after tab

There is actually balanced braces in linux-next.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/staging/erofs/zdata.c#n762

> 
> >  		pages = z_pagemap_global;
> > -	else {
> > +	} else {
> >  repeat:
> >  		pages = kvmalloc_array(nr_pages, sizeof(struct page *),
> >  				       GFP_KERNEL);
> >  
> >  		/* fallback to global pagemap for the lowmem scenario */
> >  		if (unlikely(!pages)) {
> > -			if (nr_pages > Z_EROFS_VLE_VMAP_GLOBAL_PAGES)
> > +			if (nr_pages > Z_EROFS_VLE_VMAP_GLOBAL_PAGES) {
> >  				goto repeat;
> > -			else {
> > +			} else {
> 
> Unnecessary else

There is not the "goto repeat" in linux-next anymore.
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/staging/erofs/zdata.c#n765

Thanks,
Gao Xiang

> 
> >  				mutex_lock(&z_pagemap_global_lock);
> >  				pages = z_pagemap_global;
> >  			}
> 
> 
