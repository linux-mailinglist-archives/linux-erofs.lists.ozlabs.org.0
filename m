Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C02C1FF970
	for <lists+linux-erofs@lfdr.de>; Thu, 18 Jun 2020 18:40:48 +0200 (CEST)
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49nnk45L3LzDrMT
	for <lists+linux-erofs@lfdr.de>; Fri, 19 Jun 2020 02:40:44 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=207.211.31.81;
 helo=us-smtp-delivery-1.mimecast.com; envelope-from=agruenba@redhat.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=hxibt8FV; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hxibt8FV; 
 dkim-atps=neutral
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [207.211.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49nnjw21KRzDrLj
 for <linux-erofs@lists.ozlabs.org>; Fri, 19 Jun 2020 02:40:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592498432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K+ZmXo1VT3DgmlBxctO5wOawFr9Ym28t9PdelfkR48g=;
 b=hxibt8FVtsacZXhjeiHgnu52J2vvuSBAy0RMzO5DhcHUdI4Eeu0OXK21sDsEG/TIKu55oo
 d4lfZgJeEFGSJAhWaPRNCjAW3KmXDeG9I/QkURCxEjyQKqnpyZ7O7dfKL1fsTD0Tvd8hj0
 r4erpVOnFYkm3a/4HulCcDipdrGebXY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592498432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K+ZmXo1VT3DgmlBxctO5wOawFr9Ym28t9PdelfkR48g=;
 b=hxibt8FVtsacZXhjeiHgnu52J2vvuSBAy0RMzO5DhcHUdI4Eeu0OXK21sDsEG/TIKu55oo
 d4lfZgJeEFGSJAhWaPRNCjAW3KmXDeG9I/QkURCxEjyQKqnpyZ7O7dfKL1fsTD0Tvd8hj0
 r4erpVOnFYkm3a/4HulCcDipdrGebXY=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-eYDWZjt9MeSjO1OvrI1FMA-1; Thu, 18 Jun 2020 12:40:28 -0400
X-MC-Unique: eYDWZjt9MeSjO1OvrI1FMA-1
Received: by mail-ot1-f70.google.com with SMTP id c2so2901082otb.2
 for <linux-erofs@lists.ozlabs.org>; Thu, 18 Jun 2020 09:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=K+ZmXo1VT3DgmlBxctO5wOawFr9Ym28t9PdelfkR48g=;
 b=GNP1nFZRdJMG+AiUROTP20QJlfVo6ICoN0DFpxc3uKT4MNngIRXXxaCpytTozSwZa0
 MKu4b3rILohswhQyw2T2nUNoQ/W0uEtN7U7+pj3q2QXnZ/NFjCL7XuiX+mqebl+UkMiJ
 0R0h0PhTFgbnGdlLsfmn26sAbOvHbwedKFFT6HJM6+zS5ZjipgQOC3i7prQxku8P9850
 76QCzJn07drDeTeEQf5th5x2VaoXAcrELusp1UX9gHE1SVrtBRiHjJ5yurhD9DSeM/Bv
 rDtpKoySaFcBoiqwM0Y8l5rR9KtMCkkb5VOmH3Sqi6fPHBIjrst/ZWrU48WPGfIQCoKI
 Bt4Q==
X-Gm-Message-State: AOAM530M0ZWszTcXSYWTOmGjxkPGyfTe/7jY2tMFSAyTkzPyq9nmRBS7
 KpbUi/1LwIglnaxMrZVny2d1QhnOsBDis1njHUU+7wltZfrhAKjf5pzpaPgz7NvdwETlv6u60yV
 C6jzEfVxQ1I23OR/MD83rpaYAuYCUwYiJqGfrZqyZ
X-Received: by 2002:a05:6830:10c8:: with SMTP id
 z8mr4000198oto.95.1592498427407; 
 Thu, 18 Jun 2020 09:40:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE8nhb2Q0d4GxQpaInRB14NGapvcWpYnTg96Ky3B2ltZU9DxgAABVkj/Ptn9PHhgl8mMoH1G9lpq5ufccfhow=
X-Received: by 2002:a05:6830:10c8:: with SMTP id
 z8mr4000168oto.95.1592498427103; 
 Thu, 18 Jun 2020 09:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200414150233.24495-1-willy@infradead.org>
 <20200414150233.24495-17-willy@infradead.org>
 <CAHc6FU4m1M7Tv4scX0UxSiVBqkL=Vcw_z-R7SufL8k7Bw=qPOw@mail.gmail.com>
 <20200617003216.GC8681@bombadil.infradead.org>
 <CAHpGcMK6Yu0p-FO8CciiySqh+qcWLG-t3hEaUg-rqJnS=2uhqg@mail.gmail.com>
 <20200617022157.GF8681@bombadil.infradead.org>
 <CAHc6FU7NLRHKRJJ6c2kQT0ig8ed1n+3qR-YcSCWzXOeJCUsLbA@mail.gmail.com>
 <20200618150309.GP8681@bombadil.infradead.org>
In-Reply-To: <20200618150309.GP8681@bombadil.infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 18 Jun 2020 18:40:15 +0200
Message-ID: <CAHc6FU6TYTiQ0a0GkN1dhh3VeQKVKrL+eALvuYzZ8nq5jvNHjg@mail.gmail.com>
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

On Thu, Jun 18, 2020 at 5:03 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Jun 18, 2020 at 02:46:03PM +0200, Andreas Gruenbacher wrote:
> > On Wed, Jun 17, 2020 at 4:22 AM Matthew Wilcox <willy@infradead.org> wr=
ote:
> > > On Wed, Jun 17, 2020 at 02:57:14AM +0200, Andreas Gr=C3=83=C2=BCnbach=
er wrote:
> > > > Right, the approach from the following thread might fix this:
> > > >
> > > > https://lore.kernel.org/linux-fsdevel/20191122235324.17245-1-agruen=
ba@redhat.com/T/#t
> > >
> > > In general, I think this is a sound approach.
> > >
> > > Specifically, I think FAULT_FLAG_CACHED can go away.  map_pages()
> > > will bring in the pages which are in the page cache, so when we get t=
o
> > > gfs2_fault(), we know there's a reason to acquire the glock.
> >
> > We'd still be grabbing a glock while holding a dependent page lock.
> > Another process could be holding the glock and could try to grab the
> > same page lock (i.e., a concurrent writer), leading to the same kind
> > of deadlock.
>
> What I'm saying is that gfs2_fault should just be:
>
> +static vm_fault_t gfs2_fault(struct vm_fault *vmf)
> +{
> +       struct inode *inode =3D file_inode(vmf->vma->vm_file);
> +       struct gfs2_inode *ip =3D GFS2_I(inode);
> +       struct gfs2_holder gh;
> +       vm_fault_t ret;
> +       int err;
> +
> +       gfs2_holder_init(ip->i_gl, LM_ST_SHARED, 0, &gh);
> +       err =3D gfs2_glock_nq(&gh);
> +       if (err) {
> +               ret =3D block_page_mkwrite_return(err);
> +               goto out_uninit;
> +       }
> +       ret =3D filemap_fault(vmf);
> +       gfs2_glock_dq(&gh);
> +out_uninit:
> +       gfs2_holder_uninit(&gh);
> +       return ret;
> +}
>
> because by the time gfs2_fault() is called, map_pages() has already been
> called and has failed to insert the necessary page, so we should just
> acquire the glock now instead of trying again to look for the page in
> the page cache.

Okay, that's great.

Thanks,
Andreas

