Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 087C670FBC9
	for <lists+linux-erofs@lfdr.de>; Wed, 24 May 2023 18:39:14 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QRH2R6cb0z3f7w
	for <lists+linux-erofs@lfdr.de>; Thu, 25 May 2023 02:39:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VMKqCu1R;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VMKqCu1R;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dwysocha@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VMKqCu1R;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VMKqCu1R;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QRH2M58wCz3f6Q
	for <linux-erofs@lists.ozlabs.org>; Thu, 25 May 2023 02:39:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684946342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIRDFYHmrI2ea9PgJ9cG2BzagPncv2WifE6ykqY/z1c=;
	b=VMKqCu1RKEB3in3Sq1c1+nVWrN8wtX29mkOlu/PEGJBcwBnnOfkVjDLs2LMU4Y3u6+KvA0
	yE2HWmlZSFEc9Dg/5oU5PGaRqTnJL2D0lt88xLhY4zHFm8sIdWCwAFV1CYFnyj/+ZXnoXb
	oOg7RAlkbIWl5SICCXnj/MjO90dhT0o=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684946342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hIRDFYHmrI2ea9PgJ9cG2BzagPncv2WifE6ykqY/z1c=;
	b=VMKqCu1RKEB3in3Sq1c1+nVWrN8wtX29mkOlu/PEGJBcwBnnOfkVjDLs2LMU4Y3u6+KvA0
	yE2HWmlZSFEc9Dg/5oU5PGaRqTnJL2D0lt88xLhY4zHFm8sIdWCwAFV1CYFnyj/+ZXnoXb
	oOg7RAlkbIWl5SICCXnj/MjO90dhT0o=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-5f0gHL3CNTGAGRVv4SmHcw-1; Wed, 24 May 2023 12:38:59 -0400
X-MC-Unique: 5f0gHL3CNTGAGRVv4SmHcw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1ae65e23bfcso4157245ad.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 24 May 2023 09:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684946338; x=1687538338;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIRDFYHmrI2ea9PgJ9cG2BzagPncv2WifE6ykqY/z1c=;
        b=Uib9JSigpqBKHUc1x5eAp5epH3f6ay6vZgVnZZLiYH1s3zt7Pjll4zxf+IOqBc7tjN
         T9zsRyubhd+x2eSfG8b8rBJVVl1HBetsJxcs6fRAFjKI/Oy40s0F4yUiXOhAdPONtcq2
         U1JipXkUTjWcw6T85wLGbRl13QOYVhmaxnbtUG9BlM5OySrqBW+eqbfynYoJIVzLLs+M
         B0WCgT778V3h8Z+LsBR8aCybYIXw2fvkdimLjnxxI2wabMow7v/hF9LuEMJrOXOpBImp
         KtlBgJTegxgdXWeXgSFjhv08+C5SFRMJqfV2WG6j+EPxJDsPLDuUPgo3MFl6vnOe0v29
         0AcQ==
X-Gm-Message-State: AC+VfDzg8IhqHkNEHAk6mm+eRg07weXTHTEmodRPqXqIFjIrn40XZuTt
	4KBnvZ50IUl+KWbNIUh2AzhxhyMyGi3HhjPe3Wibu/fuuHp9IDKodhwcSj+aa/DL7wO1NOFb/Up
	7hAx+0yr0GhMgrlqhrakpmxEG1Iy6ZQfVjRYydUpj
X-Received: by 2002:a17:903:428a:b0:1ac:4a41:d38d with SMTP id ju10-20020a170903428a00b001ac4a41d38dmr15831010plb.51.1684946337863;
        Wed, 24 May 2023 09:38:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7QhwNbEG7dVnvKUcvcrF5VXTCpluYFQoMIGO7odXS8eF4N7acYVvSWWvlkVR9tfx1GsK6DpUi0zEDdnwhFY7c=
X-Received: by 2002:a17:903:428a:b0:1ac:4a41:d38d with SMTP id
 ju10-20020a170903428a00b001ac4a41d38dmr15830993plb.51.1684946337555; Wed, 24
 May 2023 09:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230216150701.3654894-1-dhowells@redhat.com> <CALF+zO=w2Gyz6JtzEoFgTVjH67-_CuTaK7e+2yoHEwXZ8bPx_A@mail.gmail.com>
In-Reply-To: <CALF+zO=w2Gyz6JtzEoFgTVjH67-_CuTaK7e+2yoHEwXZ8bPx_A@mail.gmail.com>
From: David Wysochanski <dwysocha@redhat.com>
Date: Wed, 24 May 2023 12:38:21 -0400
Message-ID: <CALF+zO=Y8dMsJ79RYp1e7n9B5_0=segpqW9_tetBqPhFiQcZxA@mail.gmail.com>
Subject: Re: [Linux-cachefs] [PATCH v6 0/2] mm, netfs, fscache: Stop read
 optimisation when folio removed from pagecache
To: David Howells <dhowells@redhat.com>, Matthew Wilcox <willy@infradead.org>
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
Cc: linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Jeff Layton <jlayton@kernel.org>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>, linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org, v9fs-developer@lists.sourceforge.net, ceph-devel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org, linux-afs@lists.infradead.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, May 16, 2023 at 3:29=E2=80=AFPM David Wysochanski <dwysocha@redhat.=
com> wrote:
>
> On Thu, Feb 16, 2023 at 10:07=E2=80=AFAM David Howells <dhowells@redhat.c=
om> wrote:
> >
> > Hi Willy,
> >
> > Is this okay by you?  You said you wanted to look at the remaining uses=
 of
> > page_has_private(), of which there are then three after these patches, =
not
> > counting folio_has_private():
> >
> >         arch/s390/kernel/uv.c:          if (page_has_private(page))
> >         mm/khugepaged.c:                    1 + page_mapcount(page) + p=
age_has_private(page)) {
> >         mm/migrate_device.c:            extra +=3D 1 + page_has_private=
(page);
> >
> > --
> > I've split the folio_has_private()/filemap_release_folio() call pair
> > merging into its own patch, separate from the actual bugfix and pulled =
out
> > the folio_needs_release() function into mm/internal.h and made
> > filemap_release_folio() use it.  I've also got rid of the bit clearance=
s
> > from the network filesystem evict_inode functions as they doesn't seem =
to
> > be necessary.
> >
> > Note that the last vestiges of try_to_release_page() got swept away, so=
 I
> > rebased and dealt with that.  One comment remained, which is removed by=
 the
> > first patch.
> >
> > David
> >
> > Changes:
> > =3D=3D=3D=3D=3D=3D=3D=3D
> > ver #6)
> >  - Drop the third patch which removes a duplicate check in vmscan().
> >
> > ver #5)
> >  - Rebased on linus/master.  try_to_release_page() has now been entirel=
y
> >    replaced by filemap_release_folio(), barring one comment.
> >  - Cleaned up some pairs in ext4.
> >
> > ver #4)
> >  - Split has_private/release call pairs into own patch.
> >  - Moved folio_needs_release() to mm/internal.h and removed open-coded
> >    version from filemap_release_folio().
> >  - Don't need to clear AS_RELEASE_ALWAYS in ->evict_inode().
> >  - Added experimental patch to reduce shrink_folio_list().
> >
> > ver #3)
> >  - Fixed mapping_clear_release_always() to use clear_bit() not set_bit(=
).
> >  - Moved a '&&' to the correct line.
> >
> > ver #2)
> >  - Rewrote entirely according to Willy's suggestion[1].
> >
> > Link: https://lore.kernel.org/r/Yk9V/03wgdYi65Lb@casper.infradead.org/ =
[1]
> > Link: https://lore.kernel.org/r/164928630577.457102.8519251179327601178=
.stgit@warthog.procyon.org.uk/ # v1
> > Link: https://lore.kernel.org/r/166844174069.1124521.108905063609741699=
94.stgit@warthog.procyon.org.uk/ # v2
> > Link: https://lore.kernel.org/r/166869495238.3720468.487815140908514676=
4.stgit@warthog.procyon.org.uk/ # v3
> > Link: https://lore.kernel.org/r/1459152.1669208550@warthog.procyon.org.=
uk/ # v3 also
> > Link: https://lore.kernel.org/r/166924370539.1772793.137306983607718213=
17.stgit@warthog.procyon.org.uk/ # v4
> > Link: https://lore.kernel.org/r/167172131368.2334525.856980892568773193=
7.stgit@warthog.procyon.org.uk/ # v5
> > ---
> > %(shortlog)s
> > %(diffstat)s
> >
> > David Howells (2):
> >   mm: Merge folio_has_private()/filemap_release_folio() call pairs
> >   mm, netfs, fscache: Stop read optimisation when folio removed from
> >     pagecache
> >
> >  fs/9p/cache.c           |  2 ++
> >  fs/afs/internal.h       |  2 ++
> >  fs/cachefiles/namei.c   |  2 ++
> >  fs/ceph/cache.c         |  2 ++
> >  fs/cifs/fscache.c       |  2 ++
> >  fs/ext4/move_extent.c   | 12 ++++--------
> >  fs/splice.c             |  3 +--
> >  include/linux/pagemap.h | 16 ++++++++++++++++
> >  mm/filemap.c            |  2 ++
> >  mm/huge_memory.c        |  3 +--
> >  mm/internal.h           | 11 +++++++++++
> >  mm/khugepaged.c         |  3 +--
> >  mm/memory-failure.c     |  8 +++-----
> >  mm/migrate.c            |  3 +--
> >  mm/truncate.c           |  6 ++----
> >  mm/vmscan.c             |  8 ++++----
> >  16 files changed, 56 insertions(+), 29 deletions(-)
> >
> > --
> > Linux-cachefs mailing list
> > Linux-cachefs@redhat.com
> > https://listman.redhat.com/mailman/listinfo/linux-cachefs
> >
>
> Willy, and David,
>
> Can this series move forward?
> This just got mentioned again [1] after Chris tested the NFS netfs
> patches that were merged in 6.4-rc1
>
> [1] https://lore.kernel.org/linux-nfs/CAAmbk-f_U8CPcTQM866L572uUHdK4p5iWK=
nUQs4r8fkW=3D6RW9g@mail.gmail.com/

Sorry about the timing on the original email as I forgot it lined up
with LSF/MM.

FYI, I tested with 6.4-rc1 plus these two patches, then I added the NFS
hunk needed (see below).  All my tests pass now[1], and it makes sense
from all the ftraces I've seen on test runs that fail (cachefiles_prep_read
trace event would show "DOWN no-data" even after data was written
previously).

This small NFS hunk needs added to patch #2 in this series:

diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index 8c35d88a84b1..d4a20748b14f 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -180,6 +180,10 @@ void nfs_fscache_init_inode(struct inode *inode)
                                               &auxdata,      /* aux_data *=
/
                                               sizeof(auxdata),
                                               i_size_read(inode));
+
+       if (netfs_inode(inode)->cache)
+               mapping_set_release_always(inode->i_mapping);
+
 }

 /*

[1] https://lore.kernel.org/linux-nfs/CALF+zOn_qX4tcT2ucq4jD3G-1ERqZkL6Cw7h=
x75OnQF0ivqSeA@mail.gmail.com/

