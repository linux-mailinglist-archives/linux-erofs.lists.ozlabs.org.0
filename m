Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id C12A8E1487
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Oct 2019 10:43:10 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46ykRJ2fypzDqQH
	for <lists+linux-erofs@lfdr.de>; Wed, 23 Oct 2019 19:43:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=huawei.com (client-ip=45.249.212.255; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46ykR24mfczDqP9
 for <linux-erofs@lists.ozlabs.org>; Wed, 23 Oct 2019 19:42:52 +1100 (AEDT)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.54])
 by Forcepoint Email with ESMTP id 11C1CFFCF3A22F217689;
 Wed, 23 Oct 2019 16:42:45 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 23 Oct 2019 16:42:44 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1713.5; Wed, 23 Oct 2019 16:42:44 +0800
Date: Wed, 23 Oct 2019 16:45:36 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v4] erofs: support superblock checksum
Message-ID: <20191023084536.GA16289@architecture4>
References: <20191022180620.19638-1-pratikshinde320@gmail.com>
 <20191023040557.230886-1-gaoxiang25@huawei.com>
 <f158affb-c5c5-9cbe-d87d-17210bc635fe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f158affb-c5c5-9cbe-d87d-17210bc635fe@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme701-chm.china.huawei.com (10.1.199.97) To
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
Cc: Gao Xiang <xiang@kernel.org>, linux-erofs@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Chao,

On Wed, Oct 23, 2019 at 04:15:29PM +0800, Chao Yu wrote:
> Hi, Xiang, Pratik,
> 
> On 2019/10/23 12:05, Gao Xiang wrote:

<snip>

> >  }
> >  
> > +static int erofs_superblock_csum_verify(struct super_block *sb, void *sbdata)
> > +{
> > +	struct erofs_super_block *dsb;
> > +	u32 expected_crc, nblocks, crc;
> > +	void *kaddr;
> > +	struct page *page;
> > +	int i;
> > +
> > +	dsb = kmemdup(sbdata + EROFS_SUPER_OFFSET,
> > +		      EROFS_BLKSIZ - EROFS_SUPER_OFFSET, GFP_KERNEL);
> > +	if (!dsb)
> > +		return -ENOMEM;
> > +
> > +	expected_crc = le32_to_cpu(dsb->checksum);
> > +	nblocks = le32_to_cpu(dsb->chksum_blocks);
> 
> Now, we try to use nblocks's value before checking its validation, I guess fuzz
> test can easily make the value extreme larger, result in checking latter blocks
> unnecessarily.
> 
> IMO, we'd better
> 1. check validation of superblock to make sure all fields in sb are valid
> 2. use .nblocks to count and check payload blocks following sb

That is quite a good point. :-)

My first thought is to check the following payloads of sb (e.g, some per-fs
metadata should be checked at mount time together. or for small images, check
the whole image at the mount time) as well since if we introduce a new feature
to some kernel version, forward compatibility needs to be considered. So it's
better to make proper scalability, for this case, we have some choices:
 1) limit `chksum_blocks' upbound at runtime (e.g. refuse >= 65536 blocks,
    totally 256M.)
 2) just get rid of the whole `chksum_blocks' mess and checksum the first 4k
    at all, don't consider any latter scalability.

Some perferred idea about this? I plan to release erofs-utils v1.0 tomorrow
and hold up this feature for the next erofs-utils release, but I think we can
get it ready for v5.5 since it is not quite complex feature...

Thanks,
Gao Xiang

