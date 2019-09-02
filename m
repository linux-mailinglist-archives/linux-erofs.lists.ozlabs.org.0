Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A53FA587F
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 15:57:16 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MWqF1mk7zDqcv
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 23:57:13 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MWp91DFczDqZm
 for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2019 23:56:16 +1000 (AEST)
Received: from DGGEMM401-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 483E9D60EC475B9922D5;
 Mon,  2 Sep 2019 21:56:12 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM401-HUB.china.huawei.com (10.3.20.209) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Sep 2019 21:56:11 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 2 Sep 2019 21:56:11 +0800
Date: Mon, 2 Sep 2019 21:55:20 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: <dsterba@suse.cz>
Subject: Re: [PATCH v6 05/24] erofs: add inode operations
Message-ID: <20190902135519.GD2664@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-6-gaoxiang25@huawei.com>
 <20190829102426.GE20598@infradead.org>
 <20190901093326.GA6267@hsiangkao-HP-ZHAN-66-Pro-G1>
 <20190902134329.GU2752@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190902134329.GU2752@twin.jikos.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme707-chm.china.huawei.com (10.1.199.103) To
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
Cc: devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-erofs@lists.ozlabs.org, Amir Goldstein <amir73il@gmail.com>,
 Jan Kara <jack@suse.cz>, "Darrick J . Wong" <darrick.wong@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Dave Chinner <david@fromorbit.com>, LKML <linux-kernel@vger.kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Pavel Machek <pavel@denx.de>,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi David,

On Mon, Sep 02, 2019 at 03:43:29PM +0200, David Sterba wrote:
> On Sun, Sep 01, 2019 at 05:34:00PM +0800, Gao Xiang wrote:
> > > > +static int read_inode(struct inode *inode, void *data)
> > > > +{
> > > > +	struct erofs_vnode *vi = EROFS_V(inode);
> > > > +	struct erofs_inode_v1 *v1 = data;
> > > > +	const unsigned int advise = le16_to_cpu(v1->i_advise);
> > > > +	erofs_blk_t nblks = 0;
> > > > +
> > > > +	vi->datamode = __inode_data_mapping(advise);
> > > 
> > > What is the deal with these magic underscores here and various
> > > other similar helpers?
> > 
> > Fixed in
> > https://lore.kernel.org/linux-fsdevel/20190901055130.30572-17-hsiangkao@aol.com/
> > 
> > underscores means 'internal' in my thought, it seems somewhat
> > some common practice of Linux kernel, or some recent discussions
> > about it?... I didn't notice these discussions...
> 
> I know about a few valid uses of the underscores:
> 
> * pattern where the __underscored version does not do locking, while the other
>   does
> * similarly for atomic and non-atomic version
> * macro that needs to manipulate the argument name (like glue some
>   prefix, so the macro does not have underscores and is supposed to be
>   used instead of the function with underscores that needs the full name
>   of a variable/constant/..
> * underscore function takes a few more parameters to further tune the
>   behaviour, but most users are fine with the defaults and that is
>   provided as a function without underscores
> * in case you have just one function of the kind, don't use the underscores
> 
> I can lookup examples if you're interested or if the brief description
> is not sufficient. The list covers what I've seen and used, but the list
> may be incomplete.

Thanks, I learn a lot from the above. [thumb]

Thanks,
Gao Xiang

