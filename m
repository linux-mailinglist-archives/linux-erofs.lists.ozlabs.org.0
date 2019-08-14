Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7710B8C5DA
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2019 04:08:23 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 467Y042NPXzDqgf
	for <lists+linux-erofs@lfdr.de>; Wed, 14 Aug 2019 12:08:20 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.188; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 467XzG5JwZzDqfd
 for <linux-erofs@lists.ozlabs.org>; Wed, 14 Aug 2019 12:07:38 +1000 (AEST)
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 9A83CD4BD8C37ABD350E;
 Wed, 14 Aug 2019 10:07:35 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 14 Aug 2019 10:07:35 +0800
Received: from 138 (10.175.124.28) by dggeme762-chm.china.huawei.com
 (10.3.19.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 14
 Aug 2019 10:07:34 +0800
Date: Wed, 14 Aug 2019 10:24:42 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] staging: erofs: removing an extra call to iloc() in
 fill_inode()
Message-ID: <20190814022442.GA28602@138>
References: <20190813203840.13782-1-pratikshinde320@gmail.com>
 <20190814015944.GA11254@138>
 <418907b6-0b6b-3b08-c6fd-939a206f061f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <418907b6-0b6b-3b08-c6fd-939a206f061f@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Originating-IP: [10.175.124.28]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
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
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Aug 14, 2019 at 09:56:09AM +0800, Chao Yu wrote:
> On 2019/8/14 9:59, Gao Xiang wrote:
> > Hi Pratik,
> > 
> > On Wed, Aug 14, 2019 at 02:08:40AM +0530, Pratik Shinde wrote:
> >> in fill_inode() we call iloc() twice.Avoiding the extra call by
> >> storing the result.
> >>
> >> Signed-off-by: Pratik Shinde <pratikshinde320@gmail.com>
> > 
> > I have no objection of this patch, but I'd like to
> > hear Chao/Greg's idea about this...
> 
> It looks more clean. :)
> 
> Nitpick, maybe change 'inode_loc' to shorter 'iloc' will be better.

iloc is the name of static inline helper function in internal.h
used for shorter lines...

Thanks,
Gao Xiang

> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> > 
> > Thanks,
> > Gao Xiang
> > 
> >> ---
> >>  drivers/staging/erofs/inode.c | 7 ++++---
> >>  1 file changed, 4 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/staging/erofs/inode.c b/drivers/staging/erofs/inode.c
> >> index 4c3d8bf..d82ba6c 100644
> >> --- a/drivers/staging/erofs/inode.c
> >> +++ b/drivers/staging/erofs/inode.c
> >> @@ -167,11 +167,12 @@ static int fill_inode(struct inode *inode, int isdir)
> >>  	int err;
> >>  	erofs_blk_t blkaddr;
> >>  	unsigned int ofs;
> >> +	erofs_off_t inode_loc;
> >>  
> >>  	trace_erofs_fill_inode(inode, isdir);
> >> -
> >> -	blkaddr = erofs_blknr(iloc(sbi, vi->nid));
> >> -	ofs = erofs_blkoff(iloc(sbi, vi->nid));
> >> +	inode_loc = iloc(sbi, vi->nid);
> >> +	blkaddr = erofs_blknr(inode_loc);
> >> +	ofs = erofs_blkoff(inode_loc);
> >>  
> >>  	debugln("%s, reading inode nid %llu at %u of blkaddr %u",
> >>  		__func__, vi->nid, ofs, blkaddr);
> >> -- 
> >> 2.9.3
> >>
> > .
> > 
