Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1F1A585C
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 15:48:09 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MWck3Y7szDqhH
	for <lists+linux-erofs@lfdr.de>; Mon,  2 Sep 2019 23:48:06 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=suse.cz
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=dsterba@suse.cz;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=suse.cz
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MWW54H30zDqXV
 for <linux-erofs@lists.ozlabs.org>; Mon,  2 Sep 2019 23:43:13 +1000 (AEST)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 89671ADFB;
 Mon,  2 Sep 2019 13:43:09 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
 id CA0C1DA796; Mon,  2 Sep 2019 15:43:29 +0200 (CEST)
Date: Mon, 2 Sep 2019 15:43:29 +0200
From: David Sterba <dsterba@suse.cz>
To: Gao Xiang <hsiangkao@aol.com>
Subject: Re: [PATCH v6 05/24] erofs: add inode operations
Message-ID: <20190902134329.GU2752@twin.jikos.cz>
Mail-Followup-To: dsterba@suse.cz, Gao Xiang <hsiangkao@aol.com>,
 Christoph Hellwig <hch@infradead.org>,
 Gao Xiang <gaoxiang25@huawei.com>, Jan Kara <jack@suse.cz>,
 Dave Chinner <david@fromorbit.com>,
 LKML <linux-kernel@vger.kernel.org>, Miao Xie <miaoxie@huawei.com>,
 devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Amir Goldstein <amir73il@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Pavel Machek <pavel@denx.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-fsdevel@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-erofs@lists.ozlabs.org
References: <20190802125347.166018-1-gaoxiang25@huawei.com>
 <20190802125347.166018-6-gaoxiang25@huawei.com>
 <20190829102426.GE20598@infradead.org>
 <20190901093326.GA6267@hsiangkao-HP-ZHAN-66-Pro-G1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190901093326.GA6267@hsiangkao-HP-ZHAN-66-Pro-G1>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
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
Reply-To: dsterba@suse.cz
Cc: devel@driverdev.osuosl.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-erofs@lists.ozlabs.org, Jan Kara <jack@suse.cz>,
 "Darrick J . Wong" <darrick.wong@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>,
 LKML <linux-kernel@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Christoph Hellwig <hch@infradead.org>, Pavel Machek <pavel@denx.de>,
 David Sterba <dsterba@suse.cz>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Miao Xie <miaoxie@huawei.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Sun, Sep 01, 2019 at 05:34:00PM +0800, Gao Xiang wrote:
> > > +static int read_inode(struct inode *inode, void *data)
> > > +{
> > > +	struct erofs_vnode *vi = EROFS_V(inode);
> > > +	struct erofs_inode_v1 *v1 = data;
> > > +	const unsigned int advise = le16_to_cpu(v1->i_advise);
> > > +	erofs_blk_t nblks = 0;
> > > +
> > > +	vi->datamode = __inode_data_mapping(advise);
> > 
> > What is the deal with these magic underscores here and various
> > other similar helpers?
> 
> Fixed in
> https://lore.kernel.org/linux-fsdevel/20190901055130.30572-17-hsiangkao@aol.com/
> 
> underscores means 'internal' in my thought, it seems somewhat
> some common practice of Linux kernel, or some recent discussions
> about it?... I didn't notice these discussions...

I know about a few valid uses of the underscores:

* pattern where the __underscored version does not do locking, while the other
  does
* similarly for atomic and non-atomic version
* macro that needs to manipulate the argument name (like glue some
  prefix, so the macro does not have underscores and is supposed to be
  used instead of the function with underscores that needs the full name
  of a variable/constant/..
* underscore function takes a few more parameters to further tune the
  behaviour, but most users are fine with the defaults and that is
  provided as a function without underscores
* in case you have just one function of the kind, don't use the underscores

I can lookup examples if you're interested or if the brief description
is not sufficient. The list covers what I've seen and used, but the list
may be incomplete.
