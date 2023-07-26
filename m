Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F1276338B
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jul 2023 12:26:45 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ndKso9yU;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4R9qnb1qyCz3bmP
	for <lists+linux-erofs@lfdr.de>; Wed, 26 Jul 2023 20:26:43 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ndKso9yU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1; helo=dfw.source.kernel.org; envelope-from=jlayton@kernel.org; receiver=lists.ozlabs.org)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4R9qnR5b5mz2ysp
	for <linux-erofs@lists.ozlabs.org>; Wed, 26 Jul 2023 20:26:35 +1000 (AEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5AF2261A40;
	Wed, 26 Jul 2023 10:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DDF4C433C7;
	Wed, 26 Jul 2023 10:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690367190;
	bh=5KYTw7QzTyvtxBFV3dygoBH0PeFk0S7OnkeeUk9b43Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ndKso9yUYsbZwpDHng42ep2CAfco3wLs2OV40nFjqGLYD9AEcWQWsW6ETt5eznwfc
	 cv1pssJER1sswKXyNjOiTQENkKxQk0VK7z2g3ch3Yi2JD1b11x0Zkl0EFgKozkvsxy
	 f1dZ8Uzp9NvZuR0ShQq2ncjDBcvWQLsdpHvv+hCoNZE8CswlcoELNBb87INDiV++T7
	 H3FxOmXTcDxptDoUUj0sqZ+IrTepfzb2qKKeU0koRPwfU0de4m8txUllhzV58rHcVD
	 p+AU8vMVOdefcjxtH+iRA3W4CG6/XXiQ3a2jG5SNH585qxa35MBMZ5O8U7Wt7Y0BFJ
	 4GDCTXheHD02g==
Message-ID: <9b3292b65d3c63c50e671c47ed90304c4a8d1af9.camel@kernel.org>
Subject: Re: [PATCH v6 3/7] tmpfs: bump the mtime/ctime/iversion when page
 becomes writeable
From: Jeff Layton <jlayton@kernel.org>
To: Hugh Dickins <hughd@google.com>
Date: Wed, 26 Jul 2023 06:26:23 -0400
In-Reply-To: <42c5bbe-a7a4-3546-e898-3f33bd71b062@google.com>
References: <20230725-mgctime-v6-0-a794c2b7abca@kernel.org>
	 <20230725-mgctime-v6-3-a794c2b7abca@kernel.org>
	 <42c5bbe-a7a4-3546-e898-3f33bd71b062@google.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
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
Cc: Latchesar Ionkov <lucho@ionkov.net>, Martin Brandenburg <martin@omnibond.com>, Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, Christian Schoenebeck <linux_oss@crudebyte.com>, Dave Chinner <david@fromorbit.com>, David Howells <dhowells@redhat.com>, Chris Mason <clm@fb.com>, Andreas Dilger <adilger.kernel@dilger.ca>, Hans de Goede <hdegoede@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, codalist@coda.cs.cmu.edu, linux-afs@lists.infradead.org, Mike Marshall <hubcap@omnibond.com>, Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org, Eric Van Hensbergen <ericvh@kernel.org>, Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Richard Weinberger <richard@nod.at>, Mark Fasheh <mark@fasheh.com>, Tyler Hicks <code@tyhicks.com>, cluster-devel@redhat.com, coda@cs.cmu.edu, linux-mm@kvack.org, linux-f2fs-devel@lists.sourcefor
 ge.net, Ilya Dryomov <idryomov@gmail.com>, Iurii Zaikin <yzaikin@google.com>, Namjae Jeon <linkinjeon@kernel.org>, Trond Myklebust <trond.myklebust@hammerspace.com>, Shyam Prasad N <sprasad@microsoft.com>, ecryptfs@vger.kernel.org, Kees Cook <keescook@chromium.org>, ocfs2-devel@lists.linux.dev, Anthony Iliopoulos <ailiop@suse.com>, Josef Bacik <josef@toxicpanda.com>, Tom Talpey <tom@talpey.com>, Tejun Heo <tj@kernel.org>, Yue Hu <huyue2@coolpad.com>, Alexander Viro <viro@zeniv.linux.org.uk>, linux-mtd@lists.infradead.org, David Sterba <dsterba@suse.com>, Jaegeuk Kim <jaegeuk@kernel.org>, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>, OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Jan Harkes <jaharkes@cs.cmu.edu>, Christian Brauner <brauner@kernel.org>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Joseph Qi <joseph.qi@linux.alibaba.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, v9fs@lists.linux.dev, ntfs3@lists.linux.dev, samba-technical@lists.samba.or
 g, linux-kernel@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>, Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, devel@lists.orangefs.org, Anna Schumaker <anna@kernel.org>, Jan Kara <jack@suse.com>, Bob Peterson <rpeterso@redhat.com>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Sungjong Seo <sj1557.seo@samsung.com>, linux-erofs@lists.ozlabs.org, linux-nfs@vger.kernel.org, linux-btrfs@vger.kernel.org, Joel Becker <jlbec@evilplan.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, 2023-07-25 at 18:39 -0700, Hugh Dickins wrote:
> On Tue, 25 Jul 2023, Jeff Layton wrote:
>=20
> > Most filesystems that use the pagecache will update the mtime, ctime,
> > and change attribute when a page becomes writeable. Add a page_mkwrite
> > operation for tmpfs and just use it to bump the mtime, ctime and change
> > attribute.
> >=20
> > This fixes xfstest generic/080 on tmpfs.
>=20
> Huh.  I didn't notice when this one crept into the multigrain series.
>=20
> I'm inclined to NAK this patch: at the very least, it does not belong
> in the series, but should be discussed separately.
>=20
> Yes, tmpfs does not and never has used page_mkwrite, and gains some
> performance advantage from that.  Nobody has ever asked for this
> change before, or not that I recall.
>=20
> Please drop it from the series: and if you feel strongly, or know
> strong reasons why tmpfs suddenly needs to use page_mkwrite now,
> please argue them separately.  To pass generic/080 is not enough.
>=20
> Thanks,
> Hugh
>=20

Dropped.

This was just something I noticed while testing this series. It stood
out since I was particularly watching for timestamp-related test
failures. I don't feel terribly strongly about it.

Thanks!

> >=20
> > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > ---
> >  mm/shmem.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >=20
> > diff --git a/mm/shmem.c b/mm/shmem.c
> > index b154af49d2df..654d9a585820 100644
> > --- a/mm/shmem.c
> > +++ b/mm/shmem.c
> > @@ -2169,6 +2169,16 @@ static vm_fault_t shmem_fault(struct vm_fault *v=
mf)
> >  	return ret;
> >  }
> > =20
> > +static vm_fault_t shmem_page_mkwrite(struct vm_fault *vmf)
> > +{
> > +	struct vm_area_struct *vma =3D vmf->vma;
> > +	struct inode *inode =3D file_inode(vma->vm_file);
> > +
> > +	file_update_time(vma->vm_file);
> > +	inode_inc_iversion(inode);
> > +	return 0;
> > +}
> > +
> >  unsigned long shmem_get_unmapped_area(struct file *file,
> >  				      unsigned long uaddr, unsigned long len,
> >  				      unsigned long pgoff, unsigned long flags)
> > @@ -4210,6 +4220,7 @@ static const struct super_operations shmem_ops =
=3D {
> > =20
> >  static const struct vm_operations_struct shmem_vm_ops =3D {
> >  	.fault		=3D shmem_fault,
> > +	.page_mkwrite	=3D shmem_page_mkwrite,
> >  	.map_pages	=3D filemap_map_pages,
> >  #ifdef CONFIG_NUMA
> >  	.set_policy     =3D shmem_set_policy,
> > @@ -4219,6 +4230,7 @@ static const struct vm_operations_struct shmem_vm=
_ops =3D {
> > =20
> >  static const struct vm_operations_struct shmem_anon_vm_ops =3D {
> >  	.fault		=3D shmem_fault,
> > +	.page_mkwrite	=3D shmem_page_mkwrite,
> >  	.map_pages	=3D filemap_map_pages,
> >  #ifdef CONFIG_NUMA
> >  	.set_policy     =3D shmem_set_policy,
> >=20
> > --=20
> > 2.41.0

--=20
Jeff Layton <jlayton@kernel.org>
