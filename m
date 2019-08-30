Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 586FCA3DE6
	for <lists+linux-erofs@lfdr.de>; Fri, 30 Aug 2019 20:47:11 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46KpP80jP0zDr2j
	for <lists+linux-erofs@lfdr.de>; Sat, 31 Aug 2019 04:47:08 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=huawei.com
 (client-ip=45.249.212.255; helo=huawei.com;
 envelope-from=gaoxiang25@huawei.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=huawei.com
Received: from huawei.com (szxga08-in.huawei.com [45.249.212.255])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46KpP42T3jzDr2K
 for <linux-erofs@lists.ozlabs.org>; Sat, 31 Aug 2019 04:47:03 +1000 (AEST)
Received: from DGGEMM404-HUB.china.huawei.com (unknown [172.30.72.55])
 by Forcepoint Email with ESMTP id 6A8539DBA69EB7AA3A3A;
 Sat, 31 Aug 2019 02:46:56 +0800 (CST)
Received: from dggeme762-chm.china.huawei.com (10.3.19.108) by
 DGGEMM404-HUB.china.huawei.com (10.3.20.212) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 31 Aug 2019 02:46:55 +0800
Received: from architecture4 (10.140.130.215) by
 dggeme762-chm.china.huawei.com (10.3.19.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Sat, 31 Aug 2019 02:46:54 +0800
Date: Sat, 31 Aug 2019 02:46:06 +0800
From: Gao Xiang <gaoxiang25@huawei.com>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v6 05/24] erofs: add inode operations
Message-ID: <20190830184606.GA175612@architecture4>
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-6-gaoxiang25@huawei.com>
 <20190829102426.GE20598@infradead.org>
 <20190829115922.GG64893@architecture4>
 <20190830164205.GD29603@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190830164205.GD29603@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.140.130.215]
X-ClientProxiedBy: dggeme708-chm.china.huawei.com (10.1.199.104) To
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
 linux-erofs@lists.ozlabs.org, Theodore Ts'o <tytso@mit.edu>,
 "Darrick J . Wong" <darrick.wong@oracle.com>, Pavel Machek <pavel@denx.de>,
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
 Dave Chinner <david@fromorbit.com>, David Sterba <dsterba@suse.cz>,
 LKML <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Christoph,

On Fri, Aug 30, 2019 at 09:42:05AM -0700, Christoph Hellwig wrote:
> On Thu, Aug 29, 2019 at 07:59:22PM +0800, Gao Xiang wrote:
> > On Thu, Aug 29, 2019 at 03:24:26AM -0700, Christoph Hellwig wrote:
> > 
> > []
> > 
> > > 
> > > > +
> > > > +		/* fill last page if inline data is available */
> > > > +		err = fill_inline_data(inode, data, ofs);
> > > 
> > > Well, I think you should move the is_inode_flat_inline and
> > > (S_ISLNK(inode->i_mode) && inode->i_size < PAGE_SIZE) checks from that
> > > helper here, as otherwise you make everyone wonder why you'd always
> > > fill out the inline data.
> > 
> > Currently, fill_inline_data() only fills for fast symlink,
> > later we can fill any tail-end block (such as dir block)
> > for our requirements.
> 
> So change it when that later changes actually come in.  And even then
> having the checks outside the function is a lot more obvious.

Okay.

> 
> > And I think that is minor.
> 
> The problem is that each of these issues might appear minor on their
> own.  But combined a lot of the coding style choices lead to code that
> is more suitable an obsfucated code contest than the Linux kernel as
> trying to understand even just a few places requires jumping through
> tons of helpers with misleading names and spread over various files.
> 
> > The consideration is simply because iget_locked performs better
> > than iget5_locked.
> 
> In what benchmark do the differences show up?

In a word, no benchmark here, just because
"unsigned long on 32-bit platforms is 4 bytes."
but erofs nid is a 64-bit number.

iget_locked will do find_inode_fast (no callback at all)
rather than iget5_locked --> find_inode (test callback) ->
            inode_insert5(set callback) for each new inode.

For most 64-bit platforms, iget_locked is enough,
32-bit platforms become rare...

Thanks,
Gao Xiang

