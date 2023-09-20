Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 636C67A71C9
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 07:12:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1695186749;
	bh=uZzH8qcviIM0spHwhWA/yzVUe4eHI6P6oae8d2oGofU=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=aDsE+1Iue2birw9W7VtN6Q5l4eO2QVJEtdS6CyvH6EGMfwyCXv1LYcN+smscMpt4D
	 UIOt+qIR6B8SAHgih5we0i9Wfo9UXPus1hGsNkXLGFuoFKyX8LR/HdXSWLaEnuAcVv
	 uK8GmrG1hNsiHXRWpzuyunYy6lyvX8GmrtaWg+P2mjAZEvESHdpJ8HiZ3USTV3R+s4
	 IsUp+HnMLNi0XFPhqjPWQUaCPN3FkxHWiANZmZ4JjpFUnktgkneB7k0D2qNMeV/+Ln
	 GJPFK13YKUfmSMcNJIGieDtUXwyc3P80XNUOY42GbWJvTEEeklw6bpqK3VprCMfGVw
	 BpS1LghyXvU1g==
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rr6992VCfz3byH
	for <lists+linux-erofs@lfdr.de>; Wed, 20 Sep 2023 15:12:29 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=ZO96Jams;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::92e; helo=mail-ua1-x92e.google.com; envelope-from=dhavale@google.com; receiver=lists.ozlabs.org)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rr6954yg7z2ysB
	for <linux-erofs@lists.ozlabs.org>; Wed, 20 Sep 2023 15:12:24 +1000 (AEST)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7a8b682b0c8so1223207241.1
        for <linux-erofs@lists.ozlabs.org>; Tue, 19 Sep 2023 22:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695186741; x=1695791541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZzH8qcviIM0spHwhWA/yzVUe4eHI6P6oae8d2oGofU=;
        b=G2EHe8f6zXHMCN0Fpc2fqyeLOaLYMF7qAc7m7BOvkNq79l2z1d0jF+ee1NMwLdu234
         /gLmWTtIavQxJfG/Brev5IFG2GPA8R4zsLsYQYvPp9dG63GcD697KJ56y95fqVlcdjQu
         ndaUphb5fxNYtpt8xJJhTrv9kHnShYVqpVRmJ5H2whSH7xM2hKdG8lA1FB3ayquylN+P
         vluxivhJd4rCSxASd5YHa6+JHoCmoB++LhAQM+79tJ0IvFsfcHoHqy0i9yBa8IXaojvA
         rCsUr7OdLERQUW6r9drfK8KqbEXP2p2SdRzkThYv1Hrzcm/TcHbpp+g1HcB+wq0joxcT
         +s+A==
X-Gm-Message-State: AOJu0YyS4lxjaPsDteUQDevxvP6yFm03UONWLNOSO6TIDe8vmmP03dee
	kbqT+IXXJF7IdVLU/awxHBXzsJHPGTG931ug2VT0yg==
X-Google-Smtp-Source: AGHT+IF+ShHo+607BzKtQoXRTTafHxF8inzKwm7D3jHOh5lelaQEBurs8gSN0kq6wJwPzi/H5z6YnJLaI2yCuW/wOdc=
X-Received: by 2002:a1f:6d42:0:b0:496:b3b7:5d4c with SMTP id
 i63-20020a1f6d42000000b00496b3b75d4cmr1204791vkc.16.1695186740916; Tue, 19
 Sep 2023 22:12:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230919210220.3657736-1-dhavale@google.com> <d5a14c5f-81df-bc60-ccd5-f70f7b13597d@linux.alibaba.com>
In-Reply-To: <d5a14c5f-81df-bc60-ccd5-f70f7b13597d@linux.alibaba.com>
Date: Tue, 19 Sep 2023 22:12:09 -0700
Message-ID: <CAB=BE-Sqd6p6OZtgrTNCRTMtbB7AB9hj-zDzTWv+52Kd4iWncg@mail.gmail.com>
Subject: Re: [PATCH v1] erofs-utils: lib: Restore memory address before free()
To: Gao Xiang <hsiangkao@linux.alibaba.com>
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
From: Sandeep Dhavale via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Sandeep Dhavale <dhavale@google.com>
Cc: kernel-team@android.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Sep 19, 2023 at 7:07=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Hi Sandeep,
>
> On 2023/9/20 05:02, Sandeep Dhavale wrote:
> > We move `idx` pointer as we iterate through for loop based on `count`. =
If
> > we error out from the loop, restore the pointer to allocated memory
> > before calling free().
> >
> > Fixes: 39147b48b76d ("erofs-utils: lib: add erofs_rebuild_load_tree() h=
elper")
> > Signed-off-by: Sandeep Dhavale <dhavale@google.com>
>
> Thanks for the report!
>
> > ---
> >   lib/rebuild.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/lib/rebuild.c b/lib/rebuild.c
> > index 27a1df4..8739c53 100644
> > --- a/lib/rebuild.c
> > +++ b/lib/rebuild.c
> > @@ -188,6 +188,7 @@ static int erofs_rebuild_fixup_inode_index(struct e=
rofs_inode *inode)
> >       inode->u.chunkformat |=3D chunkbits - sbi.blkszbits;
> >       return 0;
> >   err:
> > +     idx =3D inode->chunkindexes;
> >       free(idx);
>
> I think we could just
>
>         free(inode->chunkindexes);
>         inode->chunkindexes =3D NULL;
>
> I will apply like this directly.
>
Hi Gao,
Yes, this looks much better.

Thanks,
Sandeep.

> Thanks,
> Gao Xiang
>
> >       inode->chunkindexes =3D NULL;
> >       return ret;
