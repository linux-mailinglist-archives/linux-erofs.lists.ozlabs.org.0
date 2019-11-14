Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 385EFFBDA0
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2019 02:49:04 +0100 (CET)
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47D4CJ6WjBzF6HN
	for <lists+linux-erofs@lfdr.de>; Thu, 14 Nov 2019 12:49:00 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.187; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47D4C74KmNzF6Cr
 for <linux-erofs@lists.ozlabs.org>; Thu, 14 Nov 2019 12:48:49 +1100 (AEDT)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id C3E10F01B3652DADF131
 for <linux-erofs@lists.ozlabs.org>; Thu, 14 Nov 2019 09:48:40 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 14 Nov 2019 09:48:40 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Thu, 14 Nov 2019 09:48:40 +0800
Date: Thu, 14 Nov 2019 09:51:10 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Li Guifu <blucerlee@gmail.com>, Li Guifu <bluce.liguifu@huawei.com>
Subject: Re: [PATCH v2] erofs-utils: complete missing memory handling
Message-ID: <20191114015110.GA155186@architecture4>
References: <20191112112650.143498-1-gaoxiang25@huawei.com>
 <20191113170335.17621-1-blucerlee@gmail.com>
 <20191114002428.GA2809@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20191114002428.GA2809@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme704-chm.china.huawei.com (10.1.199.100) To
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
Cc: Miao Xie <miaoxie@huawei.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Thu, Nov 14, 2019 at 08:24:31AM +0800, Gao Xiang via Linux-erofs wrote:
> Hi Guifu,
> 
> On Thu, Nov 14, 2019 at 01:03:35AM +0800, Li Guifu wrote:
> > From: Li Guifu <bluce.liguifu@huawei.com>
> > 
> > memory allocation failure should be handled
> > properly in principle.
> > 
> > Signed-off-by: Li Guifu <bluce.liguifu@huawei.com>
> > [ Gao Xiang: due to Huawei outgoing email limitation,
> >   I have to help Guifu send out his patches at work. ]
> > Signed-off-by: Gao Xiang <gaoxiang25@huawei.com>
> > Signed-off-by: Li Guifu <blucerlee@gmail.com>
> > ---
> 
> As a common practice, It's perferred to leave some useful
> comments at this about what you modified compared wtih
> the last version.
> 
> >  lib/inode.c | 21 ++++++++++++++++++---
> >  1 file changed, 18 insertions(+), 3 deletions(-)
> > 
> > diff --git a/lib/inode.c b/lib/inode.c
> > index 86c465e..b6c2b13 100644
> > --- a/lib/inode.c
> > +++ b/lib/inode.c
> > @@ -264,6 +264,8 @@ int erofs_write_dir_file(struct erofs_inode *dir)
> >  	if (used) {
> >  		/* fill tail-end dir block */
> >  		dir->idata = malloc(used);
> > +		if (!dir->idata)
> > +			return -ENOMEM;
> >  		DBG_BUGON(used != dir->idata_size);
> >  		fill_dirblock(dir->idata, dir->idata_size, q, head, d);
> >  	}
> > @@ -286,6 +288,8 @@ int erofs_write_file_from_buffer(struct erofs_inode *inode, char *buf)
> >  	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
> >  	if (inode->idata_size) {
> >  		inode->idata = malloc(inode->idata_size);
> > +		if (!inode->idata)
> > +			return -ENOMEM;
> >  		memcpy(inode->idata, buf + blknr_to_addr(nblocks),
> >  		       inode->idata_size);
> >  	}
> > @@ -347,9 +351,14 @@ int erofs_write_file(struct erofs_inode *inode)
> >  	inode->idata_size = inode->i_size % EROFS_BLKSIZ;
> >  	if (inode->idata_size) {
> >  		inode->idata = malloc(inode->idata_size);
> > -
> > +		if (!inode->idata) {
> > +			errno = ENOMEM;
> > +			goto fail;
> > +		}

When I revisited this patch, I noticed it's some weird to operate `errno' here.

The same sequence "close(fd); return -ENOMEM;" is indeed some unclean, but
I think you could make a separate cleanup patch then.

I will resend PATCH v3 since you aren't able to post public mail at work
and apply it to experimental branch.

Thanks,
Gao Xiang

> >  		ret = read(fd, inode->idata, inode->idata_size);
> >  		if (ret < inode->idata_size) {
> > +			free(inode->idata);
> > +			inode->idata = NULL;
> 
> Anyway, it seems the diffstat is this line.
> I think it' better than v1 so let's use this version.
> 
> Thanks,
> Gao Xiang
> 
