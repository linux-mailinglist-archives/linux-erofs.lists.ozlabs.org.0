Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6571FC2BF
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jun 2020 02:32:55 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49mmHm1SRxzDqsp
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jun 2020 10:32:52 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=willy@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=CSK/ewZv; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49mmHZ0McLzDqsQ
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jun 2020 10:32:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=Ul7ITLaJhl7BsoMKtdcDyvgigCHM96XtVRL3WZUxjm4=; b=CSK/ewZv8HSv35avMFwiF1ehwB
 cD9mARby3Jnsxd2q3NU3WJbfxBPOO30ro5qSxuYd1xuUmacXibygc00a8IbXIFvF7taoDFPnbpYuD
 DspL7NDCqcdY9m8XhgG2DT+PlJcmnkpmPylMCkguzGzZ65Dyubhcoa3OtmmWBSATkM9jl1AHXL+4t
 4LA1dKT87umE7qVTpcf9AA7jo/byH2G5bi260qB7PIgEqpqUHOWSlQ/hjwPtFV4VscOSErmfVg2bp
 2WpES85a2aN+/K7Swg7SVGaQfGxlW1Z8c1tR65W+NyTJdrLuyMHceQujiU5Bncj2oO0nUpIXtJDmZ
 6tMkn0Mw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jlM00-0001Vc-Jp; Wed, 17 Jun 2020 00:32:16 +0000
Date: Tue, 16 Jun 2020 17:32:16 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [Cluster-devel] [PATCH v11 16/25] fs: Convert mpage_readpages to
 mpage_readahead
Message-ID: <20200617003216.GC8681@bombadil.infradead.org>
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-17-willy@infradead.org>
 <CAHc6FU4m1M7Tv4scX0UxSiVBqkL=Vcw_z-R7SufL8k7Bw=qPOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU4m1M7Tv4scX0UxSiVBqkL=Vcw_z-R7SufL8k7Bw=qPOw@mail.gmail.com>
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
Cc: cluster-devel <cluster-devel@redhat.com>,
 linux-ext4 <linux-ext4@vger.kernel.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, John Hubbard <jhubbard@nvidia.com>,
 Steven Whitehouse <swhiteho@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Junxiao Bi <junxiao.bi@oracle.com>, linux-xfs@vger.kernel.org,
 William Kucharski <william.kucharski@oracle.com>,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-erofs@lists.ozlabs.org,
 Linux-MM <linux-mm@kvack.org>, ocfs2-devel@oss.oracle.com,
 Bob Peterson <rpeterso@redhat.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jun 17, 2020 at 12:36:13AM +0200, Andreas Gruenbacher wrote:
> Am Mi., 15. Apr. 2020 um 23:39 Uhr schrieb Matthew Wilcox <willy@infradead.org>:
> > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> >
> > Implement the new readahead aop and convert all callers (block_dev,
> > exfat, ext2, fat, gfs2, hpfs, isofs, jfs, nilfs2, ocfs2, omfs, qnx6,
> > reiserfs & udf).  The callers are all trivial except for GFS2 & OCFS2.
> 
> This patch leads to an ABBA deadlock in xfstest generic/095 on gfs2.
> 
> Our lock hierarchy is such that the inode cluster lock ("inode glock")
> for an inode needs to be taken before any page locks in that inode's
> address space.

How does that work for ...

writepage:              yes, unlocks (see below)
readpage:               yes, unlocks
invalidatepage:         yes
releasepage:            yes
freepage:               yes
isolate_page:           yes
migratepage:            yes (both)
putback_page:           yes
launder_page:           yes
is_partially_uptodate:  yes
error_remove_page:      yes

Is there a reason that you don't take the glock in the higher level
ops which are called before readhead gets called?  I'm looking at XFS,
and it takes the xfs_ilock SHARED in xfs_file_buffered_aio_read()
(called from xfs_file_read_iter).

Not that after -rc1 is a great time to be upending the locking model in
a filesystem ... but then, this has been baking in -mm for ten weeks and
the GFS2 mailing list has been on the cc for the patches for five months,
so I don't have a lot of sympathy for this.
