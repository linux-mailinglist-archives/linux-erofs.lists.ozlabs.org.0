Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCA91FF274
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2020 14:53:19 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49nhgc5RFlzDrJ7
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2020 22:53:16 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=205.139.110.61;
 helo=us-smtp-delivery-1.mimecast.com; envelope-from=agruenba@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=h7Ftdw1W; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=h7Ftdw1W; 
 dkim-atps=neutral
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49nhWd1s36zDrGw
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jun 2020 22:46:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592484377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jx2chy+DXXXPslp3yfr/ExQZEB8p36U9cp+dBBsmha4=;
 b=h7Ftdw1WTmPytI2eIit/SWPmSzK6eAJPPK5WnFzNeImRDPOgmU4UbF07fZMqn28Lgn/Isn
 f1tAGW+XUov5PUGD9D5FdA5ppKS3t8F5l4neaqCFjA5VCGCdQbWQcCOi4OdZYxKX9WIuBg
 7IQc4CeH4+El7k8T/bQC/sUyYwm2eN0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592484377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jx2chy+DXXXPslp3yfr/ExQZEB8p36U9cp+dBBsmha4=;
 b=h7Ftdw1WTmPytI2eIit/SWPmSzK6eAJPPK5WnFzNeImRDPOgmU4UbF07fZMqn28Lgn/Isn
 f1tAGW+XUov5PUGD9D5FdA5ppKS3t8F5l4neaqCFjA5VCGCdQbWQcCOi4OdZYxKX9WIuBg
 7IQc4CeH4+El7k8T/bQC/sUyYwm2eN0=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-vH2BVQy_MKCHqIZjegPqmA-1; Thu, 18 Jun 2020 08:46:15 -0400
X-MC-Unique: vH2BVQy_MKCHqIZjegPqmA-1
Received: by mail-ot1-f71.google.com with SMTP id w20so2539506oth.20
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jun 2020 05:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Jx2chy+DXXXPslp3yfr/ExQZEB8p36U9cp+dBBsmha4=;
 b=QhRcPorEkhphsVcGHDbwDaogEBn1LrrH1E8UWUhLn3kAoo2K4FJKm6Eu5miv4ceZ8g
 Xmkz8QjISIQpSCyc84Znb2jhKjbanJ2Ghr/q8tqJ9yxKTxloYOUo/dnjayGipOwoULKQ
 8qSVWcENdAA1a1ZJgg9g720SFTqZglZzDbZzvSDN3r1vlop9JNRzOdgoJla7npAVWrx0
 BC/jt4TJ7LBjxigu2NzgFJT3Dx7aYdMIbY1anUnFp0SfiTeQ4LvuQFXKSbo1PHGbr54q
 VIr30myODSvCsj7P+ZaR6/bxu+Gy+8tr5b8WTngF1sgeBCLECrhVS24ewkKHg+K8oPSK
 4wQQ==
X-Gm-Message-State: AOAM530N/qOt67uQMhGiSr90kDK9L4/GsiXUwaWzh1eBoI5+NbiYBHQv
 KH3Zdxz3Xgh9O5h89em25p117WYmoYajuzgIaZaTSri4Zd2+kzoDfeRvSG1k9L0srLDESGKLthA
 +5188cn9SepKDy8MHxMEmoQKT9QtDNSfb4o8OBh2H
X-Received: by 2002:a05:6830:10c8:: with SMTP id
 z8mr3014466oto.95.1592484374677; 
 Thu, 18 Jun 2020 05:46:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzOwYhxZwvrmXCEEJ4lNIcITT1uhrr+sNqXkjoRh5QLgqAWYsSVfGAkiWuBNYfSRh2ekFx49DQ8VN9O2a7lFfU=
X-Received: by 2002:a05:6830:10c8:: with SMTP id
 z8mr3014426oto.95.1592484374383; 
 Thu, 18 Jun 2020 05:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-17-willy@infradead.org>
 <CAHc6FU4m1M7Tv4scX0UxSiVBqkL=Vcw_z-R7SufL8k7Bw=qPOw@mail.gmail.com>
 <20200617003216.GC8681@bombadil.infradead.org>
 <CAHpGcMK6Yu0p-FO8CciiySqh+qcWLG-t3hEaUg-rqJnS=2uhqg@mail.gmail.com>
 <20200617022157.GF8681@bombadil.infradead.org>
In-Reply-To: <20200617022157.GF8681@bombadil.infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 18 Jun 2020 14:46:03 +0200
Message-ID: <CAHc6FU7NLRHKRJJ6c2kQT0ig8ed1n+3qR-YcSCWzXOeJCUsLbA@mail.gmail.com>
Subject: Re: [Cluster-devel] [PATCH v11 16/25] fs: Convert mpage_readpages to
 mpage_readahead
To: Matthew Wilcox <willy@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
 Steven Whitehouse <swhiteho@redhat.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, John Hubbard <jhubbard@nvidia.com>,
 =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>, Junxiao Bi <junxiao.bi@oracle.com>,
 linux-xfs <linux-xfs@vger.kernel.org>,
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

On Wed, Jun 17, 2020 at 4:22 AM Matthew Wilcox <willy@infradead.org> wrote:
> On Wed, Jun 17, 2020 at 02:57:14AM +0200, Andreas Gr=C3=BCnbacher wrote:
> > Am Mi., 17. Juni 2020 um 02:33 Uhr schrieb Matthew Wilcox <willy@infrad=
ead.org>:
> > >
> > > On Wed, Jun 17, 2020 at 12:36:13AM +0200, Andreas Gruenbacher wrote:
> > > > Am Mi., 15. Apr. 2020 um 23:39 Uhr schrieb Matthew Wilcox <willy@in=
fradead.org>:
> > > > > From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> > > > >
> > > > > Implement the new readahead aop and convert all callers (block_de=
v,
> > > > > exfat, ext2, fat, gfs2, hpfs, isofs, jfs, nilfs2, ocfs2, omfs, qn=
x6,
> > > > > reiserfs & udf).  The callers are all trivial except for GFS2 & O=
CFS2.
> > > >
> > > > This patch leads to an ABBA deadlock in xfstest generic/095 on gfs2=
.
> > > >
> > > > Our lock hierarchy is such that the inode cluster lock ("inode gloc=
k")
> > > > for an inode needs to be taken before any page locks in that inode'=
s
> > > > address space.
> > >
> > > How does that work for ...
> > >
> > > writepage:              yes, unlocks (see below)
> > > readpage:               yes, unlocks
> > > invalidatepage:         yes
> > > releasepage:            yes
> > > freepage:               yes
> > > isolate_page:           yes
> > > migratepage:            yes (both)
> > > putback_page:           yes
> > > launder_page:           yes
> > > is_partially_uptodate:  yes
> > > error_remove_page:      yes
> > >
> > > Is there a reason that you don't take the glock in the higher level
> > > ops which are called before readhead gets called?  I'm looking at XFS=
,
> > > and it takes the xfs_ilock SHARED in xfs_file_buffered_aio_read()
> > > (called from xfs_file_read_iter).
> >
> > Right, the approach from the following thread might fix this:
> >
> > https://lore.kernel.org/linux-fsdevel/20191122235324.17245-1-agruenba@r=
edhat.com/T/#t
>
> In general, I think this is a sound approach.
>
> Specifically, I think FAULT_FLAG_CACHED can go away.  map_pages()
> will bring in the pages which are in the page cache, so when we get to
> gfs2_fault(), we know there's a reason to acquire the glock.

We'd still be grabbing a glock while holding a dependent page lock.
Another process could be holding the glock and could try to grab the
same page lock (i.e., a concurrent writer), leading to the same kind
of deadlock.

Andreas

