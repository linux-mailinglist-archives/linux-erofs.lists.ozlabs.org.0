Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F116E3D091A
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jul 2021 08:43:26 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GV5d86YVRz307g
	for <lists+linux-erofs@lfdr.de>; Wed, 21 Jul 2021 16:43:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=ecOTEGbN;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::131;
 helo=mail-lf1-x131.google.com; envelope-from=andreas.gruenbacher@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ecOTEGbN; dkim-atps=neutral
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com
 [IPv6:2a00:1450:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GV5d25HLzz2yP1
 for <linux-erofs@lists.ozlabs.org>; Wed, 21 Jul 2021 16:43:17 +1000 (AEST)
Received: by mail-lf1-x131.google.com with SMTP id v6so1598502lfp.6
 for <linux-erofs@lists.ozlabs.org>; Tue, 20 Jul 2021 23:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=yScSiVlrT7uuBYr0A0fKZlvdo+1Nk40dqOsnX8Hctkk=;
 b=ecOTEGbNLLFz2y6GiZbCEf2DsTpcUuOEqjf8x29vCj2OsZlQAc1WwbFFneJ7vKksXy
 IMRgblsvaK0KF0Z6z8WChNYTN9gxlcrd8VmLrp89b/cUvpzKvGn7juD/0wmg9OpVDmLf
 z1BFq0cDr1ARrHD1MbasOq0rDBDV31vRq8ciW5TDYTVNxI39qehx/mHzLpjHjGWq5quL
 5HEUuD5OPVRPJJZxPCn+JmuNkrXEuZ0cDqQ0kbfRTlX+Y+mwFkO/E5diy+HQ6z2VuqOF
 TyNK4OWt+dYSiwCuJb8Fht5ddpe2BfIb/kJV1pcT1Udg4NFJbdSTvf8oD9ruS8KGucyP
 o+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:content-transfer-encoding;
 bh=yScSiVlrT7uuBYr0A0fKZlvdo+1Nk40dqOsnX8Hctkk=;
 b=FXT2IotlgpOfgoUZeSAWcKQ7G3M1wGLX8+iDgeBbntpq3VqUW+nySDccJWCqyJVnSa
 0AZW0R6e/bNOJFMThMy3oG7J9TO58aOub0CPz8QQCp/g3RCCWiVZ382nFqupHAkHz94N
 bymkZefe7y6UhwPP9PAPk2hBV9gk3nz6pjR7KXwpG8XR7EyK8SDEf64J6XYL7LrO6+m1
 V4CNkNWPXwPGq6NhCneIlJgzHgubK7ZuqJRrie8T1yNJdceLVIOyhnPk3HgxVJNviVwJ
 djSmzadfXyjUrYXf7lECk58QUjH10i9fi1RCKJjfnwLSyBgEUmuzJ3eqhWelWkgtICcK
 tBkQ==
X-Gm-Message-State: AOAM5302gdFDXO5REiyt0pjUFS65dJBhSHnYFC33NYQdLdDC0mXmjdrQ
 rmN58UaAv27gu7Ez7W9ZOVnzFyqrVZdUpNNrGDE=
X-Google-Smtp-Source: ABdhPJxxZrS1hLgC5AylmXUMWG461QjehxNs5N9XXF+wghnstGUAe7F/ABISs12JRz+m0SwCOKgJWWh3BXeCuJkJH1U=
X-Received: by 2002:ac2:5482:: with SMTP id t2mr24806101lfk.135.1626849793424; 
 Tue, 20 Jul 2021 23:43:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210720133554.44058-1-hsiangkao@linux.alibaba.com>
 <20210720204224.GK23236@magnolia> <YPc9viRAKm6cf2Ey@casper.infradead.org>
 <YPdkYFSjFHDOU4AV@B-P7TQMD6M-0146.local> <20210721001720.GS22357@magnolia>
 <YPdrSN6Vso98bLzB@B-P7TQMD6M-0146.local>
 <CAHpGcM+8cp81=bkzFf3sZfKREM9VbXfePpXrswNJOLVcwEnK7A@mail.gmail.com>
 <YPeMRsJwELjoWLFs@B-P7TQMD6M-0146.local>
In-Reply-To: <YPeMRsJwELjoWLFs@B-P7TQMD6M-0146.local>
From: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date: Wed, 21 Jul 2021 08:43:00 +0200
Message-ID: <CAHpGcMJg5TOhexLdN8HgGoFhB8kbn1FdAD8Z2XEK9C7oHptFwA@mail.gmail.com>
Subject: Re: [PATCH v4] iomap: support tail packing inline read
To: =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 linux-erofs@lists.ozlabs.org, 
 Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Am Mi., 21. Juli 2021 um 04:54 Uhr schrieb Gao Xiang
<hsiangkao@linux.alibaba.com>:
> Hi Andreas,
>
> On Wed, Jul 21, 2021 at 04:26:47AM +0200, Andreas Gr=C3=BCnbacher wrote:
> > Am Mi., 21. Juli 2021 um 02:33 Uhr schrieb Gao Xiang
> > <hsiangkao@linux.alibaba.com>:
> > > > And since you can only kmap one page at a time, an inline read grab=
s the
> > > > first part of the data in "page one" and then we have to call
> > > > iomap_begin a second time get a new address so that we can read the=
 rest
> > > > from "page two"?
> > >
> > > Nope, currently EROFS inline data won't cross page like this.
> > >
> > > But in principle, yes, I don't want to limit it to the current
> > > EROFS or gfs2 usage. I think we could make this iomap function
> > > more generally (I mean, I'd like to make the INLINE extent
> > > functionity as general as possible,
> >
> > Nono. Can we please limit this patch what we actually need right now,
> > and worry about extending it later?
>
> Can you elaborate what it will benefit us if we only support one tail
> block for iomap_read_inline_data()? (I mean it has similar LOC changes,
> similar implementation / complexity.) The only concern I think is if
> it causes gfs2 regression, so that is what I'd like to confirm.

iomap_read_inline_data supports one inline page now (i.e., from the
beginning of the file). It seems that you don't need more than one
tail page in EROFS, right?

You were speculating about inline data in the middle of a file. That
sounds like a really, really bad idea to me, and I don't think we
should waste any time on it.

> In contrast, I'd like to avoid iomap_write_begin() tail-packing because
> it's complex and no fs user interests in it for now. So I leave it
> untouched for now.

I have no idea what you mean by that.

> Another concern I really like to convert EROFS to iomap is I'd like to
> support sub-page blocksize for EROFS after converting. I don't want to
> touch iomap inline code again like this since it interacts 2 directories
> thus cause too much coupling.
>
> Thanks,
> Gao Xiang
>
> >
> > > my v1 original approach
> > > in principle can support any inline extent in the middle of
> > > file rather than just tail blocks, but zeroing out post-EOF
> > > needs another iteration) and I don't see it add more code and
> > > complexity.
> >
> > Thanks,
> > Andreas

Andreas
