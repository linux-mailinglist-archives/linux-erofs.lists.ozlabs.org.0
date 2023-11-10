Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EBB7E7F42
	for <lists+linux-erofs@lfdr.de>; Fri, 10 Nov 2023 18:51:00 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fcNVgWsI;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SRmZp2F0Vz3cT9
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Nov 2023 04:50:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=fcNVgWsI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::12c; helo=mail-lf1-x12c.google.com; envelope-from=andreas.gruenbacher@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SRmZl0Ktsz2xl6
	for <linux-erofs@lists.ozlabs.org>; Sat, 11 Nov 2023 04:50:53 +1100 (AEDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-507975d34e8so3280324e87.1
        for <linux-erofs@lists.ozlabs.org>; Fri, 10 Nov 2023 09:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699638645; x=1700243445; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=grt+fXmmJ/9GQKnvSpOXZR4bNa7UBy05x/HGBJsWED0=;
        b=fcNVgWsIrdJ/WWLePcxbCqeszNgusKQ7EImkCh2ynHtQivAIZnwTrDT7B2odb11DN7
         D1CErmnptiCy562ZF655hJunZkMswDsDmx7JzbeS0VDDVFWQJxdpShrszLGGSjmhdRGG
         7AdC7mI3SkpZ2i+W2j/eus0EmRBrHLnhS3IJi2G/P6PNqDaf0u1ID6JqoAxyAChMaEG4
         M8sgumXx4MBUw3nYhmooFR8CLUxxI1I3PYPaqhTSYzitoolw1bbZVY4bVlOZHS7yUTrb
         K6tGnTlxkdVBqiTOwq6Qd1z3qoRw1SPAl0bBv9C/ip7WRwt6ItgueqhNOn6CO8uncj0W
         jNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699638645; x=1700243445;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=grt+fXmmJ/9GQKnvSpOXZR4bNa7UBy05x/HGBJsWED0=;
        b=tfJhpO9Z8nzcDeZOi1GxF3OxYW1tEjHOt5yCowLWQsyr+pEj8pyq5Lx6vj8WQdd/2c
         i1yZ8HzgajIQ9S34h0j2M2tk3DBk81Smykr7rX4nt3djo5wuAEd3PQeGOIn4wD3jLEoK
         Pdo46MHC0Mdo7T1hAlGt9kZhlRvrO+D2JzTdas8KdMGeUKsHJRKLu+UqZ66LEABI7G3X
         Se6YiuP4i8fbyFhk0/fZ1jd9SLavWrbvk7D4O/l2aqxyZVQq4TBJAtXrM8y/07s5fIj5
         yQrhF4bZQWk8DUMzyoWcDI3Uzqrao6Z1r8STox1jnQv6qojm6RyUvZJrVH0R3PnN/37T
         GLlQ==
X-Gm-Message-State: AOJu0Yy7BZbAF/Z/w6+/J3HzxLhOwK8qQ1U3MS0Ep+ODRYLliY88gX1M
	dh8jfHRR76s6h1oIgjQGxHPakybznSmnThToLgI=
X-Google-Smtp-Source: AGHT+IFh8ABulKL4lvR+Y27vT3gC7Y6r+A/cUSNaE107DZZDGksZhMpoVeGCNcPb4JO3asUj1EER8G3o9QliCpYHcLY=
X-Received: by 2002:ac2:55a3:0:b0:507:a12c:558c with SMTP id
 y3-20020ac255a3000000b00507a12c558cmr4208700lfg.46.1699638645020; Fri, 10 Nov
 2023 09:50:45 -0800 (PST)
MIME-Version: 1.0
References: <20231107212643.3490372-1-willy@infradead.org> <20231107212643.3490372-3-willy@infradead.org>
 <CAHc6FU550j_AYgWz5JgRu84mw5HqrSwd+hYZiHVArnget3gb4w@mail.gmail.com> <ZU5jx2QeujE+868t@casper.infradead.org>
In-Reply-To: <ZU5jx2QeujE+868t@casper.infradead.org>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Fri, 10 Nov 2023 18:50:33 +0100
Message-ID: <CAHpGcMK5ODLzONNJiVAzLwxF9BKnFo=h+dP=TEtUXxDc+u+gkw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: Add folio_fill_tail() and use it in iomap
To: Matthew Wilcox <willy@infradead.org>
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
Cc: linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, Andreas Gruenbacher <agruenba@redhat.com>, "Darrick J . Wong" <djwong@kernel.org>, gfs2@lists.linux.dev, Andreas Dilger <adilger.kernel@dilger.ca>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Am Fr., 10. Nov. 2023 um 18:09 Uhr schrieb Matthew Wilcox <willy@infradead.=
org>:
> On Thu, Nov 09, 2023 at 10:50:45PM +0100, Andreas Gruenbacher wrote:
> > On Tue, Nov 7, 2023 at 10:27=E2=80=AFPM Matthew Wilcox (Oracle)
> > <willy@infradead.org> wrote:
> > > +static inline void folio_fill_tail(struct folio *folio, size_t offse=
t,
> > > +               const char *from, size_t len)
> > > +{
> > > +       char *to =3D kmap_local_folio(folio, offset);
> > > +
> > > +       VM_BUG_ON(offset + len > folio_size(folio));
> > > +
> > > +       if (folio_test_highmem(folio)) {
> > > +               size_t max =3D PAGE_SIZE - offset_in_page(offset);
> > > +
> > > +               while (len > max) {
> > > +                       memcpy(to, from, max);
> > > +                       kunmap_local(to);
> > > +                       len -=3D max;
> > > +                       from +=3D max;
> > > +                       offset +=3D max;
> > > +                       max =3D PAGE_SIZE;
> > > +                       to =3D kmap_local_folio(folio, offset);
> > > +               }
> > > +       }
> > > +
> > > +       memcpy(to, from, len);
> > > +       to =3D folio_zero_tail(folio, offset, to);
> >
> > This needs to be:
> >
> > to =3D folio_zero_tail(folio, offset  + len, to + len);
>
> Oh, wow, that was stupid of me.  I only ran an xfstests against ext4,
> which doesn't exercise this code, not gfs2 or erofs.  Thanks for
> fixing this up.
>
> I was wondering about adding the assertion:
>
>         VM_BUG_ON((kaddr - offset) % PAGE_SIZE);
>
> to catch the possible mistake of calling kmap_local_folio(folio, 0)
> instead of kmap_local_folio(folio, offset).  But maybe that's
> sufficiently unlikely a mistake to bother adding a runtime check for.

folio_zero_tail() is a bit of an obscure function, so I'm not sure if
there will be additional callers. The parameters are described as:

 * @offset: The byte offset in the folio to start zeroing at.
 * @kaddr: The address the folio is currently mapped to.

What about changing the @kaddr description to 'the (mapped) address
within the folio to start zeroing at' or similar?

Andreas
