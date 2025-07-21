Return-Path: <linux-erofs+bounces-681-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21555B0B9AD
	for <lists+linux-erofs@lfdr.de>; Mon, 21 Jul 2025 03:03:05 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4blhw6555rz30WT;
	Mon, 21 Jul 2025 11:03:02 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::92e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1753059782;
	cv=none; b=oORIPjvrRdP8Qe//HzbtbSvqqhOOELezQqGzWMIXTDiCQrJapJzJk+bA5iVgwUeMgXRlYcwPKfyDZGj+Kyog9vs1vnk9to8yavhNvhpxDRJ1f23kD57MzEf/HME0SENeGG8vqevULSTJ2aedhOfAC4XUG8gRHtUvFl2FvAhVepb+yQVlG+MSg7l6J30ZjahR2uy2E72ITRUDP47Bp3VmcIAL4amc/uB/Qu6gK6pkhKjHfpZcctxhydOpNj4fEoY7SAguja/3KgRnFmRYYTHSCdJ3Qwh3Cog3UNga8g9WSUiaJxC08cZIqaWwbbQEo0UKC8KywQ30KFbb8yT16Z6wtA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1753059782; c=relaxed/relaxed;
	bh=TUWA5dQohEpiNzIiLQ5yB5KcDd7NwkYx6hF+GZtItHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AtgDz9HwSLItzUt0NNMq2eqXTRWIt1dHHkeBqrby3QiPx0rT9BMmpgnlWiryltqdzylEgo0rc/FvK6WJVObvk+1Jt+43bV4OOCIrZ0e1az6gJhgd8sZKZaDDDMmWrnQhSbVw8XT7i18UFq3rVHEC/3K16YITx4iAiXlMz1zQ4oxQ5udfAGU+1Dov4ToCoLdLxnoeW1WIpDTwBXx7qlcoEc1Xb7bQMvEA44fxovha5FotBDO/zPEQEapAQ5IqAB2jDhy0dlIRwerLfGewE72BoXbft3s1BrF70Wzqr+/8ieyfMWt7hhuYI/k0D4JK0ChJqlUv7t7CDmr+LO2AVA0yNA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=e/TlEvlE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::92e; helo=mail-ua1-x92e.google.com; envelope-from=21cnbao@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=e/TlEvlE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::92e; helo=mail-ua1-x92e.google.com; envelope-from=21cnbao@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4blhw5403hz2yfx
	for <linux-erofs@lists.ozlabs.org>; Mon, 21 Jul 2025 11:03:00 +1000 (AEST)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-87f32826f22so5254300241.0
        for <linux-erofs@lists.ozlabs.org>; Sun, 20 Jul 2025 18:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753059777; x=1753664577; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUWA5dQohEpiNzIiLQ5yB5KcDd7NwkYx6hF+GZtItHM=;
        b=e/TlEvlE/SdXYtOAdnHZVQAFnHLrufo/GgxJvctcxVdvMtoI7o/hEsPkc105N9NRBD
         nWhz/giFfgZCnuOyZi7zwSgZMfihc3Ji7YtpN/QAN06T8lIAPm7jFOxcoi6ErID4OR92
         Rw6wgExlgYZc4bThh9LYIk+tPYnpnp/wIbQvowKorfT6C3uct3AHyi3D8zIPhRbeYToA
         gFUVQPfWoJMi8bFP30HyrdYd0mwsb64f0s9G3HvC5SDYP7Lj+dczs3w4q1pR9xr/IoEl
         1uqMnpspxAzIIwEoM5I0SMCHW2y5Hn/STFqGj4Pl7yaQo3eHIQcwK4s/LxOSpu/eHIEk
         yPOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753059777; x=1753664577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TUWA5dQohEpiNzIiLQ5yB5KcDd7NwkYx6hF+GZtItHM=;
        b=tYUT05AVQzwwVkClnz6Qx8WNkqyF8142h3Ex3+uIYnzVPoj0KPEqzVhnWY/WKxsKTA
         D1FoZ2GZfXHpzHM8ALnJyYCsvQg+A4MSi8a2dTxkdLyMfYBT5lm2AF919SeL3/OGIewm
         5AxcneLVKH1Dxa+msF7cZWfu4/I5ReRe2pskWaA6/dmPpSeUX1eQkp7du1rfW5DrEmuc
         CgfXwlmMNjdm/yh+N08kWa/x75R+iGKTFbOa1d/eziY4yWOGMg/UxEPlge+Pmuk0B9vk
         5BhKtOX+t5WIVyapBvg1V8R/EClKqvkXEAlo2bKbkA+cxsa290wWimZ0mZEMYTbaZJ6x
         qqtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVEPLBo/yWUux2AfCrA1Mvh4DJsaOx58H2vdPxpSx8b0C3XrfhCIG7vW6sx89FfWMzUfVEsz6p9yvJe6w==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzeNG2Zv7VJMyheWt+OYN6p1PwIQyW8v6oWHpVMYSjT4ufgyzH/
	3GvT99t7wh9Rq6IA4Xze0pimhNQXmbFbHvd1MZXYvHFr1wqlxt5s3IsGnh//KV9GNAGpZiosSNO
	jazTYiQK+Cutz9YS2yRHsMj+XB+5recY=
X-Gm-Gg: ASbGncsKeAhM6cEZLenJ8tscQCY/i6sk3VQpANVDuAM/2uogHtvnVmDtW4mHR2PGkPh
	T+xhqFPA7KKfzVtFBnO5GRgzaPg5lHcMcAktHPvYTeOYxdQSVM6wo1WRx44ajDWl2WPXfXZOTSu
	jcEpFpwAY5Ic0/84skkL0+75fAWwCevcEPq6RAdlQcYbVexInCgCGezBWnG/r9CCY6RAmkJJKV1
	mBsrg8=
X-Google-Smtp-Source: AGHT+IEmfqw92aWBN5S+l0I76SU0igPCpvqCsAsKehe4/Ig+tf7XCtcGuzfl8boXl3T7O5lTenPtedOe1kc4xTvXkm8=
X-Received: by 2002:a05:6102:30c8:10b0:4e9:9221:46d5 with SMTP id
 ada2fe7eead31-4f9a863ff9fmr3911618137.3.1753059777443; Sun, 20 Jul 2025
 18:02:57 -0700 (PDT)
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
References: <aHa8ylTh0DGEQklt@casper.infradead.org> <e5165052-ead3-47f4-88f6-84eb23dc34df@linux.alibaba.com>
 <b61c4b7f-4bb1-4551-91ba-a0e0ffd19e75@linux.alibaba.com>
In-Reply-To: <b61c4b7f-4bb1-4551-91ba-a0e0ffd19e75@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 21 Jul 2025 09:02:45 +0800
X-Gm-Features: Ac12FXxvyCQ0eeZOJnljUPiNW1hOMFbnyUUqpvxURHtPLurlhEFVPbwv81doELM
Message-ID: <CAGsJ_4xJjwsvMpeBV-QZFoSznqhiNSFtJu9k6da_T-T-a6VwNw@mail.gmail.com>
Subject: Re: Compressed files & the page cache
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
	David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org, 
	Nicolas Pitre <nico@fluxnic.net>, Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>, 
	linux-erofs@lists.ozlabs.org, Jaegeuk Kim <jaegeuk@kernel.org>, 
	linux-f2fs-devel@lists.sourceforge.net, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, 
	Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org, 
	David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, 
	Paulo Alcantara <pc@manguebit.org>, 
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, ntfs3@lists.linux.dev, 
	Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, 
	Phillip Lougher <phillip@squashfs.org.uk>, Hailong Liu <hailong.liu@oppo.com>, 
	Qu Wenruo <quwenruo.btrfs@gmx.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

On Wed, Jul 16, 2025 at 8:28=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
>
>
> On 2025/7/16 07:32, Gao Xiang wrote:
> > Hi Matthew,
> >
> > On 2025/7/16 04:40, Matthew Wilcox wrote:
> >> I've started looking at how the page cache can help filesystems handle
> >> compressed data better.  Feedback would be appreciated!  I'll probably
> >> say a few things which are obvious to anyone who knows how compressed
> >> files work, but I'm trying to be explicit about my assumptions.
> >>
> >> First, I believe that all filesystems work by compressing fixed-size
> >> plaintext into variable-sized compressed blocks.  This would be a good
> >> point to stop reading and tell me about counterexamples.
> >
> > At least the typical EROFS compresses variable-sized plaintext (at leas=
t
> > one block, e.g. 4k, but also 4k+1, 4k+2, ...) into fixed-sized compress=
ed
> > blocks for efficient I/Os, which is really useful for small compression
> > granularity (e.g. 4KiB, 8KiB) because use cases like Android are usuall=
y
> > under memory pressure so large compression granularity is almost
> > unacceptable in the low memory scenarios, see:
> > https://erofs.docs.kernel.org/en/latest/design.html
> >
> > Currently EROFS works pretty well on these devices and has been
> > successfully deployed in billions of real devices.
> >
> >>
> >>  From what I've been reading in all your filesystems is that you want =
to
> >> allocate extra pages in the page cache in order to store the excess da=
ta
> >> retrieved along with the page that you're actually trying to read.  Th=
at's
> >> because compressing in larger chunks leads to better compression.
> >>
> >> There's some discrepancy between filesystems whether you need scratch
> >> space for decompression.  Some filesystems read the compressed data in=
to
> >> the pagecache and decompress in-place, while other filesystems read th=
e
> >> compressed data into scratch pages and decompress into the page cache.
> >>
> >> There also seems to be some discrepancy between filesystems whether th=
e
> >> decompression involves vmap() of all the memory allocated or whether t=
he
> >> decompression routines can handle doing kmap_local() on individual pag=
es.
> >>
> >> So, my proposal is that filesystems tell the page cache that their min=
imum
> >> folio size is the compression block size.  That seems to be around 64k=
,
> >> so not an unreasonable minimum allocation size.  That removes all the
> >> extra code in filesystems to allocate extra memory in the page cache.>=
 It means we don't attempt to track dirtiness at a sub-folio granularity
> >> (there's no point, we have to write back the entire compressed bock
> >> at once).  We also get a single virtually contiguous block ... if you'=
re
> >> willing to ditch HIGHMEM support.  Or there's a proposal to introduce =
a
> >> vmap_file() which would give us a virtually contiguous chunk of memory
> >> (and could be trivially turned into a noop for the case of trying to
> >> vmap a single large folio).
> >
> > I don't see this will work for EROFS because EROFS always supports
> > variable uncompressed extent lengths and that will break typical
> > EROFS use cases and on-disk formats.
> >
> > Other thing is that large order folios (physical consecutive) will
> > caused "increase the latency on UX task with filemap_fault()"
> > because of high-order direct reclaims, see:
> > https://android-review.googlesource.com/c/kernel/common/+/3692333
> > so EROFS will not set min-order and always support order-0 folios.
> >
> > I think EROFS will not use this new approach, vmap() interface is
> > always the case for us.
>
> ... high-order folios can cause side effects on embedded devices
> like routers and IoT devices, which still have MiBs of memory (and I
> believe this won't change due to their use cases) but they also use
> Linux kernel for quite long time.  In short, I don't think enabling
> large folios for those devices is very useful, let alone limiting
> the minimum folio order for them (It would make the filesystem not
> suitable any more for those users.  At least that is what I never
> want to do).  And I believe this is different from the current LBS
> support to match hardware characteristics or LBS atomic write
> requirement.

Given the difficulty of allocating large folios, it's always a good
idea to have order-0 as a fallback. While I agree with your point,
I have a slightly different perspective =E2=80=94 enabling large folios for
those devices might be beneficial, but the maximum order should
remain small. I'm referring to "small" large folios.

Still, even with those, allocation can be difficult =E2=80=94 especially
since so many other allocations (which aren't large folios) can cause
fragmentation. So having order-0 as a fallback remains important.

It seems we're missing a mechanism to enable "small" large folios
for files. For anon large folios, we do have sysfs knobs=E2=80=94though the=
y
don=E2=80=99t seem to be universally appreciated. :-)

Thanks
Barry

