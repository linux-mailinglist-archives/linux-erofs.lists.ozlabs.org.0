Return-Path: <linux-erofs+bounces-631-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 481E3B06C15
	for <lists+linux-erofs@lfdr.de>; Wed, 16 Jul 2025 05:21:44 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bhhDK67vTz30T0;
	Wed, 16 Jul 2025 13:21:37 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:4860:4864:20::44"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1752636097;
	cv=none; b=Akudb2GoImPst2eywDbzjfIsvujOehTnmKJlcePsUxGL5mCySIHxU48sLgis8CPmtpA4BIbTuFMQ+J/f1x39I8IaBQcZ/jdfjJYV5TdbBA+UMLFCQtt6fMd039Pcgj4u71MM8JwtGaI77E13HUuu568/xHTfOyvmdDySTWJ4BQZI9AHKSioFEc12mqs/vh2ApsjwuDB5Ylh0hqL+XNCMxmvMmI49RpC5tkmooGnS8e4gxX53fimuzDGQeI+hWX8JRyKJVhwmuZnLZ4e4zXHhciW8ZgirpXHzBT7RXkBEFCBwsGqGC8rZRSWKD4Qvvsd/tzHEkRkF3Flt14VO7gIXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1752636097; c=relaxed/relaxed;
	bh=InUiyMm7gr3COTuSD5WM9WcRkq/+CKpu41nT3AXnmRI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=C0wSC6XBH+9O7xINEwusIwwftIAZ7nwDSo9vxKcJ8VBbjZ/Qkw/3VXKvv1o3ToB6WEL1HRUdXbWgVxvBIkjs0hx/KiZhNKbDLAgive2tISrHlL7IOncXghGhb7CqcsxfJ5gndiIsQ82GWuluWfAL6OiHy3BxXRAWwLiawHtkYCkJ8jHbOFdQ6gb+k4WFszL27YuCrj99nPqqZmvImV8h1gbMhXQxiswyu2rM0K2+jLOabLZogdATnI0OmYkG6HznIplb5JGgTsPCmvSO0IkNhVVzaVFnjDeVYFLBkFQGM9zIKvGtIyviLkF1hkEYWF99KhKq88ufhgn73p0c/RkV1Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RFeiLlZW; dkim-atps=neutral; spf=pass (client-ip=2001:4860:4864:20::44; helo=mail-oa1-x44.google.com; envelope-from=nzzhao.sigma@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RFeiLlZW;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2001:4860:4864:20::44; helo=mail-oa1-x44.google.com; envelope-from=nzzhao.sigma@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bhhDH4fXlz2ySY
	for <linux-erofs@lists.ozlabs.org>; Wed, 16 Jul 2025 13:21:34 +1000 (AEST)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-2c6ed7efb1dso4042901fac.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 15 Jul 2025 20:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752636090; x=1753240890; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=InUiyMm7gr3COTuSD5WM9WcRkq/+CKpu41nT3AXnmRI=;
        b=RFeiLlZWx2Eg5FnUiw9IzIoOlXhJ1IFr10jxm6cp3k2eghtWlyKNrwIi0TTyiqCFOq
         wNbc4GHRd7OXgrm3Sw32J3np242TcwrUyX47EN9YW5z3R2PGlTwgBoMJhqIjXs94zrmS
         xjpXaMxrHZBpvMZid3edhA4ZsMEgVMykE0O5WVlhefx9g3qAoGGtixeD41D8VlqzlhvS
         YNuKIw5+D+iIeWT/bKPURDabk+R31cm3uPRAqbDt3s5Ar9fjNLhoWhPSc+5xqucdzcvK
         iacWv2FStE4AuwKPaLPdWnZJI7MBOvMakEOoIo/j+iscyXnokERZgKkjYay9ivXY1ZfL
         TI+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752636090; x=1753240890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=InUiyMm7gr3COTuSD5WM9WcRkq/+CKpu41nT3AXnmRI=;
        b=AkLtO1hSx+EhEGRIH+4fvIFCLWYXRLVgtUBplVGgQRR5mw8tYCnIg7oaB91PfJBzO/
         YptUADVr2bWbFbnlbs2ILK9n3n7yvk91fC/eA+96p8pczqRfWxL5j19Lzg4zbDFZKOcy
         ETiY7VMg6x9KGmI+Zrx2xTMALf2iyRHmroyRzQlUSMuow5WRrC4VUggO1Ds13V40njEA
         Ps2DJM6F/6rPA3+kYGKjh6S9UkwArD8fvwufz+n+04bArrlNAu8seoP2dKMiAqwKUQFv
         l99zGy+LnfpIcipQsJ8oPHuRF4uzohw94cQl4qi4SFJ3IsqkCNIWRRsxLvtAhICMuu7z
         j+nA==
X-Forwarded-Encrypted: i=1; AJvYcCV4bD1OUqgKbtLn12xVbVkPb3O55TRQqtsKFiAdx17oho4TyMfmQkL2dhQu8mReASjq/DYkqRv16cGSnw==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz8Tk85SaLb3lR90cKjGasfrotYlTcAbGf2CmyQo81dPpRRFNIP
	9RC92KvvZmyokvbcERg8kzw1BBIBMX/E2jqA9o6S3uvaMJVfSvdF/XUxp6JCoKFOKw+IXe8SnkK
	7Vw44d0rcaMQf9cZn2RJvTfUkAePnC5Y=
X-Gm-Gg: ASbGncsNI7IJZ6z9QVB4wMToyTk8ZTJqRdou8q0wNxDQ9n0PFdQmF7YWKvM0YuD3ekj
	TzJ8gZtfTVR0DFbC1kHclEUYpTit2Q3wHmd1uvHK1J3bp5vGaUEKM9DvRCzFxX11pNjo6J+rvDW
	+GKIgY/7i5ry2enme70rfJJQHPMxd86TJ3UFOXUlzWsGlBu5xEDXCxxv2Zv555wJt6jeZ91Rsz1
	7cVqpvekFqMPLiR
X-Google-Smtp-Source: AGHT+IFyLwkV9mILJQbV+kbn7RjvFiGLh7yKX5x2YaAx2SKlK7xvUhTjS6vpStp4kfPeSkmgwOKnQtHPTOz5BVne74A=
X-Received: by 2002:a05:6870:d88a:b0:2d5:336f:1b5c with SMTP id
 586e51a60fabf-2ffb24d192amr988390fac.34.1752636090098; Tue, 15 Jul 2025
 20:21:30 -0700 (PDT)
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
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
Date: Wed, 16 Jul 2025 11:21:18 +0800
X-Gm-Features: Ac12FXxyvfNuoq6EvJBxQuF0ETJxEKTBdNSnwB_ChV1lMjyZmff8pJLBThDiALw
Message-ID: <CAMLCH1HCPByhWGQjix6040fZuZhjkj19k=4pqmNzPDtGeZ0Q6A@mail.gmail.com>
Subject: Re: [f2fs-dev] Compressed files & the page cache
To: Matthew Wilcox <willy@infradead.org>
Cc: almaz.alexandrovich@paragon-software.com, Chao Yu <chao@kernel.org>, clm@fb.com, 
	dhowells@redhat.com, dsterba@suse.com, dwmw2@infradead.org, jack@suse.cz, 
	"jaegeuk@kernel.org" <jaegeuk@kernel.org>, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-cifs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	"linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>, linux-fsdevel@vger.kernel.org, 
	linux-mtd@lists.infradead.org, netfs@lists.linux.dev, nico@fluxnic.net, 
	ntfs3@lists.linux.dev, pc@manguebit.org, phillip@squashfs.org.uk, 
	richard@nod.at, sfrench@samba.org, xiang@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

Dear Matthew and other filesystem developers,

I've been experimenting with implementing large folio support for
compressed files in F2FS locally, and I'd like to describe the
situation from the F2FS perspective.

> First, I believe that all filesystems work by compressing fixed-size
> plaintext into variable-sized compressed blocks.

Well, yes. F2FS's current compression implementation does compress
fixed-size memory into variable-sized blocks. However, F2FS operates
on a fixed-size unit called a "cluster." A file is logically divided
into these clusters, and each cluster corresponds to a fixed number of
contiguous page indices. The cluster size is 4 << n pages, with n
typically defaulting to 0 (making a 4-page cluster).

F2FS can only perform compression on a per-cluster basis; it cannot
operate on a unit larger than the logical size of a cluster. So, for a
16-page folio with a 4-page cluster size, we would have to split the
folio into four separate clusters. We then perform compression on each
cluster individually and write back each compressed result to disk
separately.We cannot perform compression on the whole large chunk of
folio. In fact, the fact that a large folio can span multiple clusters
was the main headache in my attempt to implement large folio support
for F2FS compression.

Why is this the case? It's due to F2FS's current on-disk layout for
compressed data. Each cluster is prefixed by a special block address,
COMPRESS_ADDR, which separates one cluster from the next on disk.
Furthermore, after F2FS compresses the original data in a cluster, the
space freed up within that cluster remains reserved on disk; it is not
released for other files to use. You may have heard that F2FS
compression doesn't actually save space for the user=E2=80=94this is the
reason. In F2FS, the model is not what we might intuitively expect=E2=80=94=
a
large chunk of data being compressed into a series of tightly packed
data blocks on disk (which I assume is the model other filesystems
adopt).

So, regarding:

> So, my proposal is that filesystems tell the page cache that their minimu=
m
> folio size is the compression block size. That seems to be around 64k,
> so not an unreasonable minimum allocation size.


F2FS doesn't have a uniform "compression block size." It purely
depends on the configured cluster size, and the resulting compressed
size is determined by the compression ratio. For example, a 4-page
cluster could be compressed down to a single block.

Regarding the folio order, perhaps we could set its maximum order to
match the cluster size, while keeping the minimum order at 0. However,
for smaller cluster sizes, this would completely limit the potential
of using larger folios. My own current implementation makes no
assumptions about the maximum folio order. As I am a student, I lack
extensive experience, so it's difficult for me to evaluate the pros
and cons of these two approaches. I believe Mr Chao Yu could provide a
more constructive suggestion on this point.

Thinking about a possible implementation for your proposal of a 64KB
size and in-place compression in the context of F2FS, I think the
possible approach may be to set the maximum folio order to 4 pages.
This would align with the default cluster size (especially relevant as
F2FS moves to support 16K pages and blocks). We could then perform
compression in-place, eliminating the need for scratch pages (which
are the compressed pages/folios in the F2FS context) and also disable
per-page dirty tracking for that folio.

However, F2FS has fallback logic for when compression fails during
writeback. The original F2FS logic still relies on per-page dirty
tracking for writes. If we were to completely remove per-page tracking
for the folio,then in compression failure case we would bear the cost
of one write amplification.

These are just my personal thoughts on your proposal. I believe Mr
Chao Yu can provide more detailed insights into the specifics of F2FS.

Best regards

