Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A621FC317
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jun 2020 02:57:46 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49mmrR0yGRzDqF1
	for <lists+linux-erofs@lfdr.de>; Wed, 17 Jun 2020 10:57:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::d44;
 helo=mail-io1-xd44.google.com; envelope-from=andreas.gruenbacher@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=Tgh6zIu9; dkim-atps=neutral
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com
 [IPv6:2607:f8b0:4864:20::d44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49mmrJ1yhPzDq6k
 for <linux-erofs@lists.ozlabs.org>; Wed, 17 Jun 2020 10:57:30 +1000 (AEST)
Received: by mail-io1-xd44.google.com with SMTP id y5so719325iob.12
 for <linux-erofs@lists.ozlabs.org>; Tue, 16 Jun 2020 17:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pEQnZOnPBJbDchwbmEUUZLW0wYE5G6XsMaI0bdt7ET4=;
 b=Tgh6zIu9SlKqTUKI4lExwCDwAAHFKxlTCElshDvOm1mn12iYD4/DlZalieO/RImp9r
 LOfdrsTqINnmMIAwC9mdceqa/wMyw0Auk9KnlvF4RPcnGvBFJBKHV1DcaOHVsC8ZJlyj
 EWU6xc0nQ7onqRbgGSdDKr9j6yTVOkffRg7YhoJMYTrD0VbKc2wSWqiWF1vx5t2+TlDQ
 0H1Q/EcYDHCiJ7V1yZRhtkqBnN46jbkGbvZxmeW2dZ9q6NUSkrxTmZ4rnGe1GGysIgBd
 ew/2hyGURcasW9W+HnGwp+PirW2QERWh+ZXINj7JdG6J0FXvqGEWoCoh1SMLGG1V6Vsg
 vn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pEQnZOnPBJbDchwbmEUUZLW0wYE5G6XsMaI0bdt7ET4=;
 b=uQ8GFWXioVWdxXFlDD1h8w2djg0ki3lk5hksjIqUoThIU67zBGxByAlayQFC899ez0
 aZx30byhmE73NARmwJoMRyHMI5ahBmVpR+0yF9Lr+hneHGNXWPVy8gmOnuNqEx7v0tOb
 fEuSkJ4aOqsVcOhCRIeWlPHhvVlq2HLusgATyQxgPqxRF7czbYLvQueISIi8v15jxu6L
 WE0UtMQ6oRIiuMt8PcGfo/dMKoH0XZZkec9uE1h/cDHuXuK2CVGYmxoDYv5CoND2c5le
 H0oRWuV8XuptbZKdUqx5M5MuHsGKCYFUtrqu1F4va95IQskGzCDFOjKxJcTyDUOyvGRr
 SUAQ==
X-Gm-Message-State: AOAM530lQpKRcEh06CEMSTrh7ZfMdLTW2coN/+hPIcQUYp4GTMeStlUz
 QZozeEqWHIBtl0T0jNACsf6Qi7cSTbsvw0dmU2g=
X-Google-Smtp-Source: ABdhPJyA0Elba10YCloQoueU20W+3sFrfsTj5mkkigBe/qlBKVyzKzAbesXkHefLeqBLcqq7m6UegL8dAN6/zvs9CGg=
X-Received: by 2002:a5d:9413:: with SMTP id v19mr5708100ion.105.1592355445894; 
 Tue, 16 Jun 2020 17:57:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-17-willy@infradead.org>
 <CAHc6FU4m1M7Tv4scX0UxSiVBqkL=Vcw_z-R7SufL8k7Bw=qPOw@mail.gmail.com>
 <20200617003216.GC8681@bombadil.infradead.org>
In-Reply-To: <20200617003216.GC8681@bombadil.infradead.org>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Wed, 17 Jun 2020 02:57:14 +0200
Message-ID: <CAHpGcMK6Yu0p-FO8CciiySqh+qcWLG-t3hEaUg-rqJnS=2uhqg@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH v11 16/25] fs: Convert mpage_readpages to
 mpage_readahead
To: Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
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
 Andreas Gruenbacher <agruenba@redhat.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, John Hubbard <jhubbard@nvidia.com>,
 Steven Whitehouse <swhiteho@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Junxiao Bi <junxiao.bi@oracle.com>, linux-xfs <linux-xfs@vger.kernel.org>,
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

Am Mi., 17. Juni 2020 um 02:33 Uhr schrieb Matthew Wilcox <willy@infradead.org>:
>
> On Wed, Jun 17, 2020 at 12:36:13AM +0200, Andreas Gruenbacher wrote:
> > Am Mi., 15. Apr. 2020 um 23:39 Uhr schrieb Matthew Wilcox <willy@infradead.org>:
> > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > >
> > > Implement the new readahead aop and convert all callers (block_dev,
> > > exfat, ext2, fat, gfs2, hpfs, isofs, jfs, nilfs2, ocfs2, omfs, qnx6,
> > > reiserfs & udf).  The callers are all trivial except for GFS2 & OCFS2.
> >
> > This patch leads to an ABBA deadlock in xfstest generic/095 on gfs2.
> >
> > Our lock hierarchy is such that the inode cluster lock ("inode glock")
> > for an inode needs to be taken before any page locks in that inode's
> > address space.
>
> How does that work for ...
>
> writepage:              yes, unlocks (see below)
> readpage:               yes, unlocks
> invalidatepage:         yes
> releasepage:            yes
> freepage:               yes
> isolate_page:           yes
> migratepage:            yes (both)
> putback_page:           yes
> launder_page:           yes
> is_partially_uptodate:  yes
> error_remove_page:      yes
>
> Is there a reason that you don't take the glock in the higher level
> ops which are called before readhead gets called?  I'm looking at XFS,
> and it takes the xfs_ilock SHARED in xfs_file_buffered_aio_read()
> (called from xfs_file_read_iter).

Right, the approach from the following thread might fix this:

https://lore.kernel.org/linux-fsdevel/20191122235324.17245-1-agruenba@redhat.com/T/#t

Andreas
