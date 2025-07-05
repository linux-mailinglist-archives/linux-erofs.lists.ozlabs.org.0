Return-Path: <linux-erofs+bounces-529-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA09DAF9F20
	for <lists+linux-erofs@lfdr.de>; Sat,  5 Jul 2025 10:25:29 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4bZ3Tx5cxQz2xQ4;
	Sat,  5 Jul 2025 18:25:25 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1751703925;
	cv=none; b=A6DkudhFJJ6ExbC3jr+oUetBegNxLGJooFUu4UXyLKKm45jko6tH2aY0Rq+lXN6vTXdvitnvye3LmrZKgUDJ+/vHDRTJFI/2JpZIQIhx6nW6NjqLwBxnMi7GXqIPIMHuNftehajPxgGaGPhTuZw/YNH6HXjRI286e/N/X13czPB7Re07/weLkhnIvAZ4gUhOjYKN8rzA/HIFrm7Ah5VJpMcZVS3YGAtM/J7tBPSN0wo192vLTHtqid8ij4CmK9pU0exCrZMsvkN+42gF25Et0cHCH8qqf1DXknvMQKnB6VVrSedwdO5YM2SDgdHUYnwfyu8DZnCZzs/WFy74HvkWsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1751703925; c=relaxed/relaxed;
	bh=8Xc+RrKRkVhogq9Hh4/YneHPfHiF4ZnROZihNBJ1ydI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxA4uA65l17B0DDb4DYk6a7ETOWoctwqG4G0HIy3KOyWdjXUGnX9N48zYoCxlXrQOkCHGBFnGaVrCdWowwECJtz7MRt/B4ZlPYuV6yZJKshicpxCZ0ZaiU7zg0oTDJS9z5jcQH3B0G7Opl6D2/0Fve7NqNqVj6DKz8w6Xdj6pzQO+Y/ACJ1NexKbu8zg0Wr6ERkJZJ/hs3Js5t1YjvbGStOmyAPzQDNXswb/+poaqXMtF0S529UZBOipuR+9T7zIvnrjDf5MAu7jkpIAbIOP04Vl/m6haGFLVo/Ok2WXz0LOM9XvbG7Jw4zCF75k0VcwtbXTtDUa2ECXWeHhyqNWnA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nKwd9R7R; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=nKwd9R7R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::62d; helo=mail-ej1-x62d.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4bZ3Tv5Lwtz2xCW
	for <linux-erofs@lists.ozlabs.org>; Sat,  5 Jul 2025 18:25:23 +1000 (AEST)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-acb5ec407b1so261278766b.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 05 Jul 2025 01:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751703918; x=1752308718; darn=lists.ozlabs.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8Xc+RrKRkVhogq9Hh4/YneHPfHiF4ZnROZihNBJ1ydI=;
        b=nKwd9R7RsE8N9I1qPCMT8Ts3/z8dJwayuDUHaf0n0H9cSzz/W0E46f2OFZnXzxeHmI
         /qJALI0Xv42G4iYdM8VyjfPmVr5wde+T3AHfdtwf0iu9tico5SQHPFWzDTK0Dcyu05U1
         l3NUCKQsaA5nhxpJRiQmW4hmnUCnGz5AwWJWDT2L6zIEo03BDI2LYsrvIsOprD3c7Vz0
         sVGm5y1eiBI9sDIcVQfhS5tTYgZz72G31JoqKfF3RCBBjDuWvy5674mxf68kzYwlTy+Z
         MCK9yC4fNlzQSvWe6uB6rVtLdHu/M3jGsZsLEjrW09uowWmC8T9ztfqJ90D0Og/9unE3
         zsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751703918; x=1752308718;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Xc+RrKRkVhogq9Hh4/YneHPfHiF4ZnROZihNBJ1ydI=;
        b=XYCNo64wGh/ejx4GypolhSjZ5RRbGLLHuVCQoZwAPLdmkqCkY9rxMupNqXlOflBx7N
         tWaocjXDUC+NfJc2nXz6MK+OOT0U+s7TyQ9a+FrE/dPCDsGXnD0Ou62MoXlVU3mxii4D
         CchIloS9Whiitip1SCs1Gc3DPtdCkC61RRFjmUBeOTy4hdl7iVb0yNPMhjNBvhLjhpyq
         j494BWzrSQbnjF2hwG7MwGjKpV3ET2oB+NEswAkHkgQMya7rgn3kn3IjO3IqrSegc8tr
         GCK9UnT3ZCySkpYAhSerfF64+I/Qm5AYFLGjNUSavfEU15/SNu1tCo5ZiGCbT8hhitpH
         PE9w==
X-Forwarded-Encrypted: i=1; AJvYcCWLTr6u9rY/3UOMPfYhHOQa0R5ZANpQEbukJB9QMdXoNkvcphuyJt+ZqC2uuEc5pFFq7Mvx2AuQ1tE6xQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxF+Ouq7TK6b6u+LyG0nEa57Pj6jUltAAR6lTAi+XYz3hmBdU4X
	fYTyz6RGaUxfJzZnKjMfZKbJFcifSAlqUiJGcfPXyN335swEAsbE+tGrhxux250P+xbeg3/oU5K
	jfm7R98Fq+ZSi60jXrZzrozcrSSN0aGo=
X-Gm-Gg: ASbGnctyGdplR2u4s8rE8o9u1kM29yiW8qp4NLlIFPpcma9dlH2CSR7kXzHi8oyaKy0
	xjWNS5F7NT/BUT7XwpTxZUtSCo+jivl5QV7i+00r3uucuFDpVfjxIqnZ6gBb0J5W9ztYcKbnO1g
	N0qic+ptRXpZqIDEcXjzftmTui0L8rIRiyShAl29vbgW8=
X-Google-Smtp-Source: AGHT+IHAPgkfIp7KLuXN8o025fCFgjcZ+aafANHYUih2OzOk08UNgmxdaFMuvtRfy5y7wQ6GuesUUSpzV+vl35Cy9rc=
X-Received: by 2002:a17:907:1b1d:b0:adb:4342:e898 with SMTP id
 a640c23a62f3a-ae3fbd14d5amr515087466b.28.1751703917530; Sat, 05 Jul 2025
 01:25:17 -0700 (PDT)
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
References: <20250703-work-erofs-pcs-v1-0-0ce1f6be28ee@kernel.org>
 <20250703-work-erofs-pcs-v1-2-0ce1f6be28ee@kernel.org> <12e59170-7435-4fae-a485-9cb105c378d1@linux.alibaba.com>
In-Reply-To: <12e59170-7435-4fae-a485-9cb105c378d1@linux.alibaba.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 5 Jul 2025 10:25:06 +0200
X-Gm-Features: Ac12FXzeaTD4CGclH-rmtCjj8msXi6SKn3Wrg4NFnMgYxAGG8wbz88KXIg-k0Gs
Message-ID: <CAOQ4uxhhDS2XAKNnENEWfDrbp6+SX7Q_BY9OLo4QA4Jf0fHuvw@mail.gmail.com>
Subject: Re: [PATCH RFC 2/4] erofs: introduce page cache share feature
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: Christian Brauner <brauner@kernel.org>, Hongzhen Luo <hongzhen@linux.alibaba.com>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Lennart Poettering <lennart@poettering.net>, 
	Mike Yuan <me@yhndnzj.com>, =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>, 
	lihongbo22@huawei.com, linux-erofs@lists.ozlabs.org, 
	Gao Xiang <xiang@kernel.org>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org

> > +}
> > +
> > +/*
> > + * TODO: Hm, could we leverage our fancy new backing file infrastructure
> > + * as for overlayfs and fuse?
>
> If some code can be lifted up as a vfs helper, it would be
> much helpful as the backing file infrastructure was lifted
> from overlayfs.
>
> But I'm not sure if it's really needed for now anyway
> because it's only EROFS-specific, and I only maintain and
> can speak of EROFS.
>
> > + */
> > +static struct file *erofs_pcs_alloc_file(struct file *file,
> > +                                      struct inode *ano_inode)
> > +{
> > +     struct file *ano_file;
> > +
> > +     ano_file = alloc_file_pseudo(ano_inode, erofs_pcs_mnt, "[erofs_pcs_f]",
> > +                                  O_RDONLY, &erofs_file_fops);
> > +     file_ra_state_init(&ano_file->f_ra, file->f_mapping);
> > +     ano_file->private_data = EROFS_I(file_inode(file));
> > +     return ano_file;
> > +}
> > +
>
> ...
>
> > +
> > +/*
> > + * TODO: Amir, you've got some experience in this area due to overlayfs
> > + * and fuse. Does that work?
> > + */
>
>
>
> Hi Amir,
>
> I do think it will work, if you have chance please help
> take a quick look too.
>
> It's much similar to overlayfs, the difference is that the real
> inodes is not in some other fs, but anon inodes from a pseudo
> sb which shares among the whole host to share page cache for
> containers.
>

I will answer that from two different POV.

1. Will the backing_file helpers reduce much complicated code?

Not really IMO, because EROFS shared inode does not support
dio/aio and does not require override_cred(), so the remaining bit
of read_ite/splice_read/mmap are pretty trivial IMO.

2. When is it ok to use the backing_file helpers?

The current patch allocates a struct file with
alloc_file_pseudo() and not a struct backing_file,
so using the backing_file helpers is going to be awkward and
misleading and I think in this case it will we wize to refrain
from using a local var name backing_file.

The thing that you need to ask yourself is do you want
backing_file_set_user_path() for the erofs shared inode.

That means, what do you want users to see when they
look at /proc/self/map_files symlinks.

With the current patch set I believe they will see a symlink to
something like "[erofs_pcs_f]" for any mapped file
which is somewhat odd.

I think it would have been nice if users saw something like
"[erofs_pcs_md5digest:XXXXXXX]"
IMO, making the page cache dedupe visible in map_files is
a very nice feature.

Overlayfs took the approach that users are expecting to see
the actual path of the (non-anonymous) file that they mapped
when looking at map_files symlinks.
If you do not display the path to erofs mount in map_files,
then lsof will not be able to blame a process with mapped files
as the reason for keeping erofs mount busy.

Thanks,
Amir.

