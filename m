Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F90B7E73DB
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Nov 2023 22:50:40 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IU0rwsPE;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IU0rwsPE;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SRFxk6RQqz3bX1
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Nov 2023 08:50:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IU0rwsPE;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IU0rwsPE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=agruenba@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SRFxg04S6z2yts
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Nov 2023 08:50:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699566624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RfLDwoRp1AgagZ4sj107hwERh+DKKg2aeHYKEBXwEg=;
	b=IU0rwsPEIXr9/VqJfJGvEFXXsuwiEa+ndajcGH472dPbLIBlVa+rVZNs922d5DVcLbzB7u
	bLbsZmFae8wdYmfIWGF+IZS81kaTG81DXOCSNdVttU3AQsdoLFQJArBL+hmoPhjeCnUW9N
	NMQJUJ28fW1hPtr4Zedf0A1mFaTwJRc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699566624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RfLDwoRp1AgagZ4sj107hwERh+DKKg2aeHYKEBXwEg=;
	b=IU0rwsPEIXr9/VqJfJGvEFXXsuwiEa+ndajcGH472dPbLIBlVa+rVZNs922d5DVcLbzB7u
	bLbsZmFae8wdYmfIWGF+IZS81kaTG81DXOCSNdVttU3AQsdoLFQJArBL+hmoPhjeCnUW9N
	NMQJUJ28fW1hPtr4Zedf0A1mFaTwJRc=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-CK4DDvRUPnieWl8AVuNs6Q-1; Thu, 09 Nov 2023 16:50:21 -0500
X-MC-Unique: CK4DDvRUPnieWl8AVuNs6Q-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5bdd8eee498so1202289a12.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 09 Nov 2023 13:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699566620; x=1700171420;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RfLDwoRp1AgagZ4sj107hwERh+DKKg2aeHYKEBXwEg=;
        b=UYE27Cps5nkQEBoTJFo+aaQ+G4deo0fkp7lmZooecHsmMuf3TykxmK5v/AnnEiJ8zZ
         VjqOlDFTKGyDe8MXtFK1G1S+Er+4cSz0qYNFJsBQWbIxJSNFKyigSpd2XIKDd3zhtgj7
         vV/H7jHs5GLz/qIOxws75gZnsCCE3FBG+Z1MaXZ1dqM5jKkOoLwANusaej5OsdPS+fFn
         rGlVhDadybfE9Q4vrQqqqtIEGKGInuLyewEN1RMnhwUxOw63XQqv/l6gpBIjPCtvVomm
         84TVv3O8NZxHchi0VBKpIp+yIzGhv7GlS3wJiNwJEsts11NDl5nVTvKolSVTbZuqgFOD
         rMMA==
X-Gm-Message-State: AOJu0YyLK0fZeFUt8EppVL3DSCICzdASDrZ0/aaiwaBqfbEymvJrSnsq
	NzQn0cGYfrFQZKKqRZ9eK//ElmzRdQpbLPrvxMgSr6SorZdmmcCk/9euKInElTyp63uLlb4/Kd/
	xJ/Na2J2P9diLAIs+cMO9tuB41Z3Dsf7IUnDXPm6b
X-Received: by 2002:a17:903:41ce:b0:1cc:5dd4:7ce5 with SMTP id u14-20020a17090341ce00b001cc5dd47ce5mr7796791ple.19.1699566620566;
        Thu, 09 Nov 2023 13:50:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXBc2hXk+C70TRLFN9EyxRa5fj9jL7XbLvgzaeG0AtHwvCIMfkAS4K9wOLN8chphWgrxWpDONaVxp+KNblyCM=
X-Received: by 2002:a17:903:41ce:b0:1cc:5dd4:7ce5 with SMTP id
 u14-20020a17090341ce00b001cc5dd47ce5mr7796770ple.19.1699566620259; Thu, 09
 Nov 2023 13:50:20 -0800 (PST)
MIME-Version: 1.0
References: <20231107212643.3490372-1-willy@infradead.org> <20231107212643.3490372-2-willy@infradead.org>
In-Reply-To: <20231107212643.3490372-2-willy@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 9 Nov 2023 22:50:08 +0100
Message-ID: <CAHc6FU54SzUm-0eF-GYX2B7w0xTWQ+N6nLx+0xAFshsWUdq2qA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: Add folio_zero_tail() and use it in ext4
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
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
Cc: linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, "Darrick J . Wong" <djwong@kernel.org>, gfs2@lists.linux.dev, Andreas Dilger <adilger.kernel@dilger.ca>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Willy,

On Tue, Nov 7, 2023 at 10:27=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> Instead of unmapping the folio after copying the data to it, then mapping
> it again to zero the tail, provide folio_zero_tail() to zero the tail
> of an already-mapped folio.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/ext4/inline.c        |  3 +--
>  include/linux/highmem.h | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index 9a84a5f9fef4..d5bd1e3a5d36 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -502,9 +502,8 @@ static int ext4_read_inline_folio(struct inode *inode=
, struct folio *folio)
>         BUG_ON(len > PAGE_SIZE);
>         kaddr =3D kmap_local_folio(folio, 0);
>         ret =3D ext4_read_inline_data(inode, kaddr, len, &iloc);
> -       flush_dcache_folio(folio);
> +       kaddr =3D folio_zero_tail(folio, len, kaddr + len);
>         kunmap_local(kaddr);
> -       folio_zero_segment(folio, len, folio_size(folio));
>         folio_mark_uptodate(folio);
>         brelse(iloc.bh);
>
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 4cacc0e43b51..1b81416196dd 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -483,6 +483,44 @@ static inline void memcpy_to_folio(struct folio *fol=
io, size_t offset,
>         flush_dcache_folio(folio);
>  }
>
> +/**
> + * folio_zero_tail - Zero the tail of a folio.
> + * @folio: The folio to zero.
> + * @kaddr: The address the folio is currently mapped to.
> + * @offset: The byte offset in the folio to start zeroing at.
> + *

As Andrew has pointed out, the order of the arguments in the
description doesn't match the order in the function definition. Other
than that, this patch looks good, so

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

> + * If you have already used kmap_local_folio() to map a folio, written
> + * some data to it and now need to zero the end of the folio (and flush
> + * the dcache), you can use this function.  If you do not have the
> + * folio kmapped (eg the folio has been partially populated by DMA),
> + * use folio_zero_range() or folio_zero_segment() instead.
> + *
> + * Return: An address which can be passed to kunmap_local().
> + */
> +static inline __must_check void *folio_zero_tail(struct folio *folio,
> +               size_t offset, void *kaddr)
> +{
> +       size_t len =3D folio_size(folio) - offset;
> +
> +       if (folio_test_highmem(folio)) {
> +               size_t max =3D PAGE_SIZE - offset_in_page(offset);
> +
> +               while (len > max) {
> +                       memset(kaddr, 0, max);
> +                       kunmap_local(kaddr);
> +                       len -=3D max;
> +                       offset +=3D max;
> +                       max =3D PAGE_SIZE;
> +                       kaddr =3D kmap_local_folio(folio, offset);
> +               }
> +       }
> +
> +       memset(kaddr, 0, len);
> +       flush_dcache_folio(folio);
> +
> +       return kaddr;
> +}
> +
>  /**
>   * memcpy_from_file_folio - Copy some bytes from a file folio.
>   * @to: The destination buffer.
> --
> 2.42.0
>

Thanks,
Andreas

