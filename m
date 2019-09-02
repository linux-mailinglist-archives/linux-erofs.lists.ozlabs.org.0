Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 780F0A57AE
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 15:34:11 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MWJc0gTVzDqY6
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 23:34:08 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MWJS6604zDqTq
 for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2019 23:33:59 +1000 (AEST)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 325AC2557631AFB90083;
 Mon,  2 Sep 2019 21:33:54 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 2 Sep 2019 21:33:53 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Mon, 2 Sep 2019 21:33:53 +0800
Date: Mon, 2 Sep 2019 21:33:02 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 07/21] erofs: use erofs_inode naming
Message-ID: <20190902133302.GA63268@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190901055130.30572-1-hsiangkao@aol.com>
 <20190901055130.30572-8-hsiangkao@aol.com>
 <20190902121021.GG15931@infradead.org>
 <20190902121306.GA2664@architecture4>
 <20190902124737.GB8369@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190902124737.GB8369@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme719-chm.china.huawei.com (10.1.199.115) To
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
 Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christoph,

On Mon, Sep 02, 2019 at 05:47:37AM -0700, Christoph Hellwig wrote:
> On Mon, Sep 02, 2019 at 08:13:06PM +0800, Gao Xiang wrote:
> > Hi Christoph,
> > 
> > On Mon, Sep 02, 2019 at 05:10:21AM -0700, Christoph Hellwig wrote:
> > > >  {
> > > > -	struct erofs_vnode *vi = ptr;
> > > > -
> > > > -	inode_init_once(&vi->vfs_inode);
> > > > +	inode_init_once(&((struct erofs_inode *)ptr)->vfs_inode);
> > > 
> > > Why doesn't this use EROFS_I?  This looks a little odd.
> > 
> > Thanks for your reply and suggestion...
> > EROFS_I seems the revert direction ---> inode to erofs_inode
> > here we need "erofs_inode" to inode...
> > 
> > Am I missing something?.... Hope not....
> 
> No, you are not.  But the cast still looks odd.  Why not:
> 
> 	struct erofs_inode *ei = ptr;
> 
> 	inode_init_once(&ei->vfs_inode);

That is the old way, I thought you don't like the extra variable...
https://lore.kernel.org/linux-erofs/20190830154551.GA11571@infradead.org/
I am ok with either form, anyway, let me use the old way....

Thanks,
Gao Xiang

