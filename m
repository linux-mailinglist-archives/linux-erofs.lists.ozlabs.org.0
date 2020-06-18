Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BEA1FF681
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2020 17:23:14 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49nm0b480zzDrMH
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2020 01:23:11 +1000 (AEST)
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
 header.a=rsa-sha256 header.s=bombadil.20170209 header.b=EuLHMlaV; 
 dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49nlZ80LmTzDrJq
 for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jun 2020 01:03:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Transfer-Encoding
 :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=UL+8ApV4cJJsaL9i1XR4k0qibz3XspT8vONGVk524kc=; b=EuLHMlaVNrGT+gpgg4ZOy214Lf
 /NetdKt4msEGn/SdU6wS7Vb3Nicec9n/1E16Pv5CLgJpT25JAXyLZqTClcv5dthiCzHK32BiNFyNn
 2Vtkj1cmYSbWiXKfh18xDTiF4w22UEYWsdQ5WG/abzsVteDtOAX8vWZ3bKmb0ydVHdoW/dmfLoAdv
 rcWXcFdBrgdT+0Rnct9YP5xWZ5E6pNPsBKwkf9wU8u6uAxjlRbX/tFeF4hooENdTFNAX/QSEm8LMc
 hZs29nl0IRtyQgR2KBWEayJ7IYD2dzdJAKDyw0r1yoEP6TVl666nT/5G8UpJw9LpuF0WelqGPXar4
 ortJ5rhQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jlw4L-0003On-LK; Thu, 18 Jun 2020 15:03:09 +0000
Date: Thu, 18 Jun 2020 08:03:09 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [Cluster-devel] [PATCH v11 16/25] fs: Convert mpage_readpages to
 mpage_readahead
Message-ID: <20200618150309.GP8681@bombadil.infradead.org>
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-17-willy@infradead.org>
 <CAHc6FU4m1M7Tv4scX0UxSiVBqkL=Vcw_z-R7SufL8k7Bw=qPOw@mail.gmail.com>
 <20200617003216.GC8681@bombadil.infradead.org>
 <CAHpGcMK6Yu0p-FO8CciiySqh+qcWLG-t3hEaUg-rqJnS=2uhqg@mail.gmail.com>
 <20200617022157.GF8681@bombadil.infradead.org>
 <CAHc6FU7NLRHKRJJ6c2kQT0ig8ed1n+3qR-YcSCWzXOeJCUsLbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU7NLRHKRJJ6c2kQT0ig8ed1n+3qR-YcSCWzXOeJCUsLbA@mail.gmail.com>
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
 Andreas =?iso-8859-1?Q?Gr=FCnbacher?= <andreas.gruenbacher@gmail.com>,
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

On Thu, Jun 18, 2020 at 02:46:03PM +0200, Andreas Gruenbacher wrote:
> On Wed, Jun 17, 2020 at 4:22 AM Matthew Wilcox <willy@infradead.org> wrote:
> > On Wed, Jun 17, 2020 at 02:57:14AM +0200, Andreas Grünbacher wrote:
> > > Right, the approach from the following thread might fix this:
> > >
> > > https://lore.kernel.org/linux-fsdevel/20191122235324.17245-1-agruenba@redhat.com/T/#t
> >
> > In general, I think this is a sound approach.
> >
> > Specifically, I think FAULT_FLAG_CACHED can go away.  map_pages()
> > will bring in the pages which are in the page cache, so when we get to
> > gfs2_fault(), we know there's a reason to acquire the glock.
> 
> We'd still be grabbing a glock while holding a dependent page lock.
> Another process could be holding the glock and could try to grab the
> same page lock (i.e., a concurrent writer), leading to the same kind
> of deadlock.

What I'm saying is that gfs2_fault should just be:

+static vm_fault_t gfs2_fault(struct vm_fault *vmf)
+{
+	struct inode *inode = file_inode(vmf->vma->vm_file);
+	struct gfs2_inode *ip = GFS2_I(inode);
+	struct gfs2_holder gh;
+	vm_fault_t ret;
+	int err;
+
+	gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
+	err = gfs2_glock_nq(&gh);
+	if (err) {
+		ret = block_page_mkwrite_return(err);
+		goto out_uninit;
+	}
+	ret = filemap_fault(vmf);
+	gfs2_glock_dq(&gh);
+out_uninit:
+	gfs2_holder_uninit(&gh);
+	return ret;
+}

because by the time gfs2_fault() is called, map_pages() has already been
called and has failed to insert the necessary page, so we should just
acquire the glock now instead of trying again to look for the page in
the page cache.
