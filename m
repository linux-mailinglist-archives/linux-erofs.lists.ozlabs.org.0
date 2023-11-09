Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE927E73E3
	for <lists+linux-erofs@lfdr.de>; Thu,  9 Nov 2023 22:51:09 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X8QQJnCK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X8QQJnCK;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SRFyM2SZTz3bxZ
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Nov 2023 08:51:07 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X8QQJnCK;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X8QQJnCK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=agruenba@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SRFyH1C11z2xpd
	for <linux-erofs@lists.ozlabs.org>; Fri, 10 Nov 2023 08:51:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699566659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SEe5Lm1QSY9l0OHsCk0EbXQqbDGAdhAs53cCOGquA04=;
	b=X8QQJnCKtYJ/lmHZo204XsGeL7BQVhCtwfKESshqTCZT1t/paA0Aw+IP8L/UjYsblySvxO
	BDg0/Ck1wxit9Z7N7PjUlLRLgB4ol1eaeA1LOOkxACOZJ4N+VoFft+ZSIagDhN21SOBfG2
	CST8GPndm+gc1bRu3RWq/bL7JuXuGcg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699566659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SEe5Lm1QSY9l0OHsCk0EbXQqbDGAdhAs53cCOGquA04=;
	b=X8QQJnCKtYJ/lmHZo204XsGeL7BQVhCtwfKESshqTCZT1t/paA0Aw+IP8L/UjYsblySvxO
	BDg0/Ck1wxit9Z7N7PjUlLRLgB4ol1eaeA1LOOkxACOZJ4N+VoFft+ZSIagDhN21SOBfG2
	CST8GPndm+gc1bRu3RWq/bL7JuXuGcg=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-TOLwlj-fN5uvtoJLU0ttMw-1; Thu, 09 Nov 2023 16:50:58 -0500
X-MC-Unique: TOLwlj-fN5uvtoJLU0ttMw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc23f2226fso14510945ad.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 09 Nov 2023 13:50:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699566657; x=1700171457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEe5Lm1QSY9l0OHsCk0EbXQqbDGAdhAs53cCOGquA04=;
        b=e1FmkybUg7vGMAjH3MgMd6LloGMqIcxMqM/bKljuuFsqb2ar0fvMQ8ztODeqBqbb1c
         W1VCjnRnI7HJjdjkUo8L1wJvHTbH4PCeJId7nQNdHS1G/3gzZqtizmXi96qOSHCr0+1c
         qIxq1RT2S9w9hRaHuFUiRfj8BKzdeAJQRVurwIIVMZ+/J6byagdWV/h7gQHgnTiWdzU6
         Pj2wO1I4ENQJ+mjw8BAkSd8iH8XcmA021+od/viNuJYhZtbwavm79T7fLhMzS42EbAzh
         ltRlgjeyDsRve3K5Y0pruCL4gaw5sP2Q4qq7ybp6Wb6XQeAvxjbZfgkBg5CX4m0ZNDlE
         R7oA==
X-Gm-Message-State: AOJu0Yw2YVv6XQO7PBgbv2uPiwSczKxdo4/0iyu64ZawmlVQCOoNi3Lk
	DsMHxuotAmlL7jEXEJSa0xLIW2WBlIZAye2MnwYq5QqSi8Fp2fpQXkXZK4bjqMr+b1CJiHS/rr+
	0mglaSs616FDl01BUhGBjV4ThJcp1Vvr5I5zAdsRl
X-Received: by 2002:a17:903:32c8:b0:1cc:4985:fc04 with SMTP id i8-20020a17090332c800b001cc4985fc04mr7490416plr.66.1699566657077;
        Thu, 09 Nov 2023 13:50:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyG4JtpfIMVQSiIgVG/wUB85vTa7ZYZB8EAxgeOBn9j0yJtEeYqTI6/TevKMgPEnNnnhq8hyhOkkpCwkjzLqg=
X-Received: by 2002:a17:903:32c8:b0:1cc:4985:fc04 with SMTP id
 i8-20020a17090332c800b001cc4985fc04mr7490395plr.66.1699566656820; Thu, 09 Nov
 2023 13:50:56 -0800 (PST)
MIME-Version: 1.0
References: <20231107212643.3490372-1-willy@infradead.org> <20231107212643.3490372-3-willy@infradead.org>
In-Reply-To: <20231107212643.3490372-3-willy@infradead.org>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 9 Nov 2023 22:50:45 +0100
Message-ID: <CAHc6FU550j_AYgWz5JgRu84mw5HqrSwd+hYZiHVArnget3gb4w@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: Add folio_fill_tail() and use it in iomap
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

On Tue, Nov 7, 2023 at 10:27=E2=80=AFPM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
> The iomap code was limited to PAGE_SIZE bytes; generalise it to cover
> an arbitrary-sized folio, and move it to be a common helper.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/iomap/buffered-io.c  | 14 ++------------
>  include/linux/highmem.h | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 40 insertions(+), 12 deletions(-)
>
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index f72df2babe56..093c4515b22a 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -305,28 +305,18 @@ static int iomap_read_inline_data(const struct ioma=
p_iter *iter,
>  {
>         const struct iomap *iomap =3D iomap_iter_srcmap(iter);
>         size_t size =3D i_size_read(iter->inode) - iomap->offset;
> -       size_t poff =3D offset_in_page(iomap->offset);
>         size_t offset =3D offset_in_folio(folio, iomap->offset);
> -       void *addr;
>
>         if (folio_test_uptodate(folio))
>                 return 0;
>
> -       if (WARN_ON_ONCE(size > PAGE_SIZE - poff))
> -               return -EIO;
> -       if (WARN_ON_ONCE(size > PAGE_SIZE -
> -                        offset_in_page(iomap->inline_data)))
> -               return -EIO;
>         if (WARN_ON_ONCE(size > iomap->length))
>                 return -EIO;
>         if (offset > 0)
>                 ifs_alloc(iter->inode, folio, iter->flags);
>
> -       addr =3D kmap_local_folio(folio, offset);
> -       memcpy(addr, iomap->inline_data, size);
> -       memset(addr + size, 0, PAGE_SIZE - poff - size);
> -       kunmap_local(addr);
> -       iomap_set_range_uptodate(folio, offset, PAGE_SIZE - poff);
> +       folio_fill_tail(folio, offset, iomap->inline_data, size);
> +       iomap_set_range_uptodate(folio, offset, folio_size(folio) - offse=
t);
>         return 0;
>  }
>
> diff --git a/include/linux/highmem.h b/include/linux/highmem.h
> index 1b81416196dd..0fbb60ffefc9 100644
> --- a/include/linux/highmem.h
> +++ b/include/linux/highmem.h
> @@ -521,6 +521,44 @@ static inline __must_check void *folio_zero_tail(str=
uct folio *folio,
>         return kaddr;
>  }
>
> +/**
> + * folio_fill_tail - Copy some data to a folio and pad with zeroes.
> + * @folio: The destination folio.
> + * @offset: The offset into @folio at which to start copying.
> + * @from: The data to copy.
> + * @len: How many bytes of data to copy.
> + *
> + * This function is most useful for filesystems which support inline dat=
a.
> + * When they want to copy data from the inode into the page cache, this
> + * function does everything for them.  It supports large folios even on
> + * HIGHMEM configurations.
> + */
> +static inline void folio_fill_tail(struct folio *folio, size_t offset,
> +               const char *from, size_t len)
> +{
> +       char *to =3D kmap_local_folio(folio, offset);
> +
> +       VM_BUG_ON(offset + len > folio_size(folio));
> +
> +       if (folio_test_highmem(folio)) {
> +               size_t max =3D PAGE_SIZE - offset_in_page(offset);
> +
> +               while (len > max) {
> +                       memcpy(to, from, max);
> +                       kunmap_local(to);
> +                       len -=3D max;
> +                       from +=3D max;
> +                       offset +=3D max;
> +                       max =3D PAGE_SIZE;
> +                       to =3D kmap_local_folio(folio, offset);
> +               }
> +       }
> +
> +       memcpy(to, from, len);
> +       to =3D folio_zero_tail(folio, offset, to);

This needs to be:

to =3D folio_zero_tail(folio, offset  + len, to + len);

> +       kunmap_local(to);
> +}
> +
>  /**
>   * memcpy_from_file_folio - Copy some bytes from a file folio.
>   * @to: The destination buffer.
> --
> 2.42.0
>

Reviewed-by: Andreas Gruenbacher <agruenba@redhat.com>

Thanks,
Andreas

