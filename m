Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B52B705718
	for <lists+linux-erofs@lfdr.de>; Tue, 16 May 2023 21:30:02 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QLRCD16Bqz3f7Y
	for <lists+linux-erofs@lfdr.de>; Wed, 17 May 2023 05:30:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jQZjHrKE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jQZjHrKE;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=dwysocha@redhat.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jQZjHrKE;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jQZjHrKE;
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QLRC43yY1z3f6B
	for <linux-erofs@lists.ozlabs.org>; Wed, 17 May 2023 05:29:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684265388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9UrkqIYKxvK9jQQrJXRaqEAIFWUC38gkJPtkDfF+s0=;
	b=jQZjHrKEyMPpO6wAVJSc1C7EYXzJoJ6UlA376aMGkAoDVuWL2E2FbMFQ9i3YwseWSGzKRt
	E44RxffD8JEoM9cJM7fj5Y9h4Z+Ub0hDhygKoW2HZqf/vDf7onXP8BA6f4ZfqDuDw1GqOf
	460pOshDbwQrrHzg1l7HMsQtkPV+gik=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1684265388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t9UrkqIYKxvK9jQQrJXRaqEAIFWUC38gkJPtkDfF+s0=;
	b=jQZjHrKEyMPpO6wAVJSc1C7EYXzJoJ6UlA376aMGkAoDVuWL2E2FbMFQ9i3YwseWSGzKRt
	E44RxffD8JEoM9cJM7fj5Y9h4Z+Ub0hDhygKoW2HZqf/vDf7onXP8BA6f4ZfqDuDw1GqOf
	460pOshDbwQrrHzg1l7HMsQtkPV+gik=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-RcqQlGbpO6mmQh8roaYrEw-1; Tue, 16 May 2023 15:29:46 -0400
X-MC-Unique: RcqQlGbpO6mmQh8roaYrEw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2533e0cd8f2so8995a91.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 16 May 2023 12:29:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684265385; x=1686857385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t9UrkqIYKxvK9jQQrJXRaqEAIFWUC38gkJPtkDfF+s0=;
        b=LtjDJP4Pn3hgo5MmfBmS+pSpSxgowMKag60lhmdHOCCfm3zVo+MkThE0i3/Mnt3WbA
         VwzrPtwRmSBmOkhbPE3z2pHJuRjz7W8gueXaG5qBPy+EI8jkAhxtZDpsO9senEG+oXIY
         o/wQsYyGXFc1hw8bVI/NDVg2FMzLCOhvLplGNPiB8hZFXTeuCIGizymwS5PcLF5bscKE
         tsW73C2Kru814kDkAJQyqqC5xBFs2HcwjGllctKM/gl9DUGJ5trG7qFAT2Hs9E7jQh+s
         xj8wE+5ybSmkqcqRfHMt1jTy5wNm3mI2pELhvSbuvxQ1N3cRIslrNTaqVzxS0enRJaek
         yZbg==
X-Gm-Message-State: AC+VfDxznnwd75qcOj45D8pdQLh85enmIjKSPj7BL4AC5L7bWEWzvjeW
	lf2TqKs4bV/jkYV5xeIMymn+YiyMC6xXHMKrtu90ESLzmU59k1rLbeDm7Mhk3PmknsLZ8WdTflz
	ZehXfDi4r6ZeKu+y/1BwjrGNnuAU+ZTnUtgkVtspC
X-Received: by 2002:a17:90a:8049:b0:24d:e929:56cf with SMTP id e9-20020a17090a804900b0024de92956cfmr37452322pjw.39.1684265385700;
        Tue, 16 May 2023 12:29:45 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5gBFGff4dAZMhxmbGkiocJy63rZyONMUQ6rm3VRtZFYy02jZIS98cu+nLLPRraC5I03lzcx85+v3rvPJQsVd4=
X-Received: by 2002:a17:90a:8049:b0:24d:e929:56cf with SMTP id
 e9-20020a17090a804900b0024de92956cfmr37452303pjw.39.1684265385415; Tue, 16
 May 2023 12:29:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230216150701.3654894-1-dhowells@redhat.com>
In-Reply-To: <20230216150701.3654894-1-dhowells@redhat.com>
From: David Wysochanski <dwysocha@redhat.com>
Date: Tue, 16 May 2023 15:29:09 -0400
Message-ID: <CALF+zO=w2Gyz6JtzEoFgTVjH67-_CuTaK7e+2yoHEwXZ8bPx_A@mail.gmail.com>
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

On Thu, Feb 16, 2023 at 10:07=E2=80=AFAM David Howells <dhowells@redhat.com=
> wrote:
>
> Hi Willy,
>
> Is this okay by you?  You said you wanted to look at the remaining uses o=
f
> page_has_private(), of which there are then three after these patches, no=
t
> counting folio_has_private():
>
>         arch/s390/kernel/uv.c:          if (page_has_private(page))
>         mm/khugepaged.c:                    1 + page_mapcount(page) + pag=
e_has_private(page)) {
>         mm/migrate_device.c:            extra +=3D 1 + page_has_private(p=
age);
>
> --
> I've split the folio_has_private()/filemap_release_folio() call pair
> merging into its own patch, separate from the actual bugfix and pulled ou=
t
> the folio_needs_release() function into mm/internal.h and made
> filemap_release_folio() use it.  I've also got rid of the bit clearances
> from the network filesystem evict_inode functions as they doesn't seem to
> be necessary.
>
> Note that the last vestiges of try_to_release_page() got swept away, so I
> rebased and dealt with that.  One comment remained, which is removed by t=
he
> first patch.
>
> David
>
> Changes:
> =3D=3D=3D=3D=3D=3D=3D=3D
> ver #6)
>  - Drop the third patch which removes a duplicate check in vmscan().
>
> ver #5)
>  - Rebased on linus/master.  try_to_release_page() has now been entirely
>    replaced by filemap_release_folio(), barring one comment.
>  - Cleaned up some pairs in ext4.
>
> ver #4)
>  - Split has_private/release call pairs into own patch.
>  - Moved folio_needs_release() to mm/internal.h and removed open-coded
>    version from filemap_release_folio().
>  - Don't need to clear AS_RELEASE_ALWAYS in ->evict_inode().
>  - Added experimental patch to reduce shrink_folio_list().
>
> ver #3)
>  - Fixed mapping_clear_release_always() to use clear_bit() not set_bit().
>  - Moved a '&&' to the correct line.
>
> ver #2)
>  - Rewrote entirely according to Willy's suggestion[1].
>
> Link: https://lore.kernel.org/r/Yk9V/03wgdYi65Lb@casper.infradead.org/ [1=
]
> Link: https://lore.kernel.org/r/164928630577.457102.8519251179327601178.s=
tgit@warthog.procyon.org.uk/ # v1
> Link: https://lore.kernel.org/r/166844174069.1124521.10890506360974169994=
.stgit@warthog.procyon.org.uk/ # v2
> Link: https://lore.kernel.org/r/166869495238.3720468.4878151409085146764.=
stgit@warthog.procyon.org.uk/ # v3
> Link: https://lore.kernel.org/r/1459152.1669208550@warthog.procyon.org.uk=
/ # v3 also
> Link: https://lore.kernel.org/r/166924370539.1772793.13730698360771821317=
.stgit@warthog.procyon.org.uk/ # v4
> Link: https://lore.kernel.org/r/167172131368.2334525.8569808925687731937.=
stgit@warthog.procyon.org.uk/ # v5
> ---
> %(shortlog)s
> %(diffstat)s
>
> David Howells (2):
>   mm: Merge folio_has_private()/filemap_release_folio() call pairs
>   mm, netfs, fscache: Stop read optimisation when folio removed from
>     pagecache
>
>  fs/9p/cache.c           |  2 ++
>  fs/afs/internal.h       |  2 ++
>  fs/cachefiles/namei.c   |  2 ++
>  fs/ceph/cache.c         |  2 ++
>  fs/cifs/fscache.c       |  2 ++
>  fs/ext4/move_extent.c   | 12 ++++--------
>  fs/splice.c             |  3 +--
>  include/linux/pagemap.h | 16 ++++++++++++++++
>  mm/filemap.c            |  2 ++
>  mm/huge_memory.c        |  3 +--
>  mm/internal.h           | 11 +++++++++++
>  mm/khugepaged.c         |  3 +--
>  mm/memory-failure.c     |  8 +++-----
>  mm/migrate.c            |  3 +--
>  mm/truncate.c           |  6 ++----
>  mm/vmscan.c             |  8 ++++----
>  16 files changed, 56 insertions(+), 29 deletions(-)
>
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-cachefs
>

Willy, and David,

Can this series move forward?
This just got mentioned again [1] after Chris tested the NFS netfs
patches that were merged in 6.4-rc1

[1] https://lore.kernel.org/linux-nfs/CAAmbk-f_U8CPcTQM866L572uUHdK4p5iWKnU=
Qs4r8fkW=3D6RW9g@mail.gmail.com/

