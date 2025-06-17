Return-Path: <linux-erofs+bounces-451-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C79CADCA1E
	for <lists+linux-erofs@lfdr.de>; Tue, 17 Jun 2025 13:57:48 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bM53F6gSMz30MZ;
	Tue, 17 Jun 2025 21:57:45 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2604:1380:4641:c500::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1750161465;
	cv=none; b=KOt7fgOsoi5aXm3lfEU5KhUkvS/8wVsrvnhToNoYEfWH16LtPAqj3crQV+Cu0Yhcfrmd88hNDRlBHW2C8klxcaNnTRKRHkizWulPcZvxWu3cKSQUl32FWwqzIypJqrXQF7JQ8eUBH1C2PcEQrTisW35LWYJI7li52jtCGdw8G/MMsHuLSd7pYR1HzgbLCphAUDb7gvTwfKPt10hclc2sN6W9O/CVVhoC9GkCzaszhMdBOKwHpR4aAuPEJsDWaJX0BMDnoirJdT64Nj2eL11WjRzflY60swTQbtYGKMEB7TNDV6bIQzyHeq0k5OokaoUxp5/oYcf1OMzC7QJYM890ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1750161465; c=relaxed/relaxed;
	bh=m/RRUe7oOlBQaMrRU0yW5gAkiYkQQmiPrVoU6uzcycQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMpyqxzONmaAtfXsvX6rjIO09oBqazHNEZRL1vl0+npvssra+4EkOTaqMBg27aFcYPMe/pruPWm4obRkppi8Nb7Zh84eaRFWieLXrvkQByzRjyUreZkVfa0uEKlEJn07P2ZriyqFLOIV2AkSLLzf3P2UlGe1V57H6isDrGmgZeWfpSr5oAqY8SMFE3j4PFqLHFxcsthz9bWkALM20AH4sh7ilysKSf9wPBbs9fA2co3IjQmU1RmRkJHPOEM1sJ59N5Bt36DhBwr+z48EwlifIRZJwSZ8bDlLUr2fxM94+aMWeYBu3KCOROIB7IS+mPGCBcgAo92+Qg8TwUxN3/TSrg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ANNRMLSM; dkim-atps=neutral; spf=pass (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ANNRMLSM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bM53F1N2kz309v
	for <linux-erofs@lists.ozlabs.org>; Tue, 17 Jun 2025 21:57:45 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 81BE95C3AD7;
	Tue, 17 Jun 2025 11:55:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EC2DC4CEE3;
	Tue, 17 Jun 2025 11:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750161462;
	bh=T+hj+yayJhfzqGA9kWHW1UQw8dsCOqK3Vx6p1g+lWhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ANNRMLSMbFJxF0/0JcpxGnRgNC2cM3iQk05j0kIN5dUOf6a+6FhzXEhCV9tljSO6h
	 v2e3uV6HAxpTWa31kRKsnVAXQkLyFD1xYm1QZjMvIFL3ouF6AXeudY39YUcGZrolsh
	 RyM2TZ/EQMyqQ6Y6s4GUWKP0gK9gINzD7L4jwsfBCJ1suak/ya3jB5me4TnYO/YFrF
	 BrbHmvsabgMYM9Mbit9yWCy+NDOo9GjZfXkkWr9NdZCIoi7MIoTDvDFU7neHyJvL+Q
	 sCBOLJVwQyL5L44PlP9UgERzG7VA2X0BjHsxmPcW0plFtm6qxZnaOBFYXof6KFwTQp
	 Bv2/tmMRJtG5w==
Date: Tue, 17 Jun 2025 13:57:17 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Jens Axboe <axboe@kernel.dk>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Eric Van Hensbergen <ericvh@kernel.org>, 
	Latchesar Ionkov <lucho@ionkov.net>, Dominique Martinet <asmadeus@codewreck.org>, 
	Christian Schoenebeck <linux_oss@crudebyte.com>, David Sterba <dsterba@suse.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Benjamin LaHaise <bcrl@kvack.org>, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	Kent Overstreet <kent.overstreet@linux.dev>, "Tigran A . Aivazian" <aivazian.tigran@gmail.com>, 
	Kees Cook <kees@kernel.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, 
	Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, Tyler Hicks <code@tyhicks.com>, 
	Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>, 
	Jeffle Xu <jefflexu@linux.alibaba.com>, Sandeep Dhavale <dhavale@google.com>, 
	Hongbo Li <lihongbo22@huawei.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, 
	Viacheslav Dubeyko <slava@dubeyko.com>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Yangtao Li <frank.li@vivo.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>, David Woodhouse <dwmw2@infradead.org>, 
	Dave Kleikamp <shaggy@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Ryusuke Konishi <konishi.ryusuke@gmail.com>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
	Joseph Qi <joseph.qi@linux.alibaba.com>, Bob Copeland <me@bobcopeland.com>, 
	Mike Marshall <hubcap@omnibond.com>, Martin Brandenburg <martin@omnibond.com>, 
	Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.org>, 
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, 
	Tom Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, 
	Zhihao Cheng <chengzhihao1@huawei.com>, Hans de Goede <hdegoede@redhat.com>, 
	Carlos Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Naohiro Aota <naohiro.aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, 
	Dan Williams <dan.j.williams@intel.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-afs@lists.infradead.org, linux-aio@kvack.org, linux-unionfs@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-mm@kvack.org, linux-btrfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, 
	linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH 10/10] fs: replace mmap hook with .mmap_prepare for
 simple mappings
Message-ID: <20250617-karibus-abgrenzen-e534b9acd4c7@brauner>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
 <f528ac4f35b9378931bd800920fee53fc0c5c74d.1750099179.git.lorenzo.stoakes@oracle.com>
 <6nktgdc7ygt6hncfnl33d2jlwvlydspiiklwf6oxiqxxcjhzs2@j6f36ktyv774>
X-Mailing-List: linux-erofs@lists.ozlabs.org
List-Id: <linux-erofs.lists.ozlabs.org>
List-Help: <mailto:linux-erofs+help@lists.ozlabs.org>
List-Owner: <mailto:linux-erofs+owner@lists.ozlabs.org>
List-Post: <mailto:linux-erofs@lists.ozlabs.org>
List-Subscribe: <mailto:linux-erofs+subscribe@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-digest@lists.ozlabs.org>,
  <mailto:linux-erofs+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linux-erofs+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6nktgdc7ygt6hncfnl33d2jlwvlydspiiklwf6oxiqxxcjhzs2@j6f36ktyv774>
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Tue, Jun 17, 2025 at 12:28:17PM +0200, Jan Kara wrote:
> On Mon 16-06-25 20:33:29, Lorenzo Stoakes wrote:
> > Since commit c84bf6dd2b83 ("mm: introduce new .mmap_prepare() file
> > callback"), the f_op->mmap() hook has been deprecated in favour of
> > f_op->mmap_prepare().
> > 
> > This callback is invoked in the mmap() logic far earlier, so error handling
> > can be performed more safely without complicated and bug-prone state
> > unwinding required should an error arise.
> > 
> > This hook also avoids passing a pointer to a not-yet-correctly-established
> > VMA avoiding any issues with referencing this data structure.
> > 
> > It rather provides a pointer to the new struct vm_area_desc descriptor type
> > which contains all required state and allows easy setting of required
> > parameters without any consideration needing to be paid to locking or
> > reference counts.
> > 
> > Note that nested filesystems like overlayfs are compatible with an
> > .mmap_prepare() callback since commit bb666b7c2707 ("mm: add mmap_prepare()
> > compatibility layer for nested file systems").
> > 
> > In this patch we apply this change to file systems with relatively simple
> > mmap() hook logic - exfat, ceph, f2fs, bcachefs, zonefs, btrfs, ocfs2,
> > orangefs, nilfs2, romfs, ramfs and aio.
> > 
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> Two small nits below. Otherwise feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 60a621b00c65..37522137c380 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -2330,13 +2330,14 @@ static const struct vm_operations_struct ceph_vmops = {
> >  	.page_mkwrite	= ceph_page_mkwrite,
> >  };
> >  
> > -int ceph_mmap(struct file *file, struct vm_area_struct *vma)
> > +int ceph_mmap_prepare(struct vm_area_desc *desc)
> >  {
> > +	struct file *file = desc->file;
> >  	struct address_space *mapping = file->f_mapping;
> 
> Pointless local variable here...

Agreed, fixed in-tree.

> > -static int exfat_file_mmap(struct file *file, struct vm_area_struct *vma)
> > +static int exfat_file_mmap_prepare(struct vm_area_desc *desc)
> >  {
> > +	struct file *file = desc->file;
> 
> Missing empty line here.

Fixed in-tree.

