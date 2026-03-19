Return-Path: <linux-erofs+bounces-2857-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOYmKGkcvGlEsQIAu9opvQ
	(envelope-from <linux-erofs+bounces-2857-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 16:55:21 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFAA2CE157
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 16:55:19 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc9JN1fXWz2ypW;
	Fri, 20 Mar 2026 02:55:16 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1035" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773935716;
	cv=pass; b=lVF4+1EGtKWOYXmhTpwlD/CXLGx0qCN25jXTg/2QzAN23wXja0Dej8wxyV/HRDFyJuk6re1MiejRCpb0kwVwolEV2hJZ7TFzLsOGpG7qgX8b+fzPeaAY8FGr9nOJkjow9w0MIMbjePNTRGEyVhCh3iQgQfZ3IZqScui1sHhYJ/+egx0jHVU8LYxBMEWJPISug88TgGJWwQlcWFfOFCx5iqFHfGvEUaVdGaPXU/0Afb3MkBhAyVcHc31OIluO/vh/jU2DR16ZEbiKnKI57iGJT45TKAbcd1d5QnUaNvPB7zy+J8DOeUZ52QWBhJV0AWBLSgnDRCr+3rCkCVsDmq24sg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773935716; c=relaxed/relaxed;
	bh=5dUObDXy8tyO/dqZjJVHNnud7OeR2yjgyzlwu5eskHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FqeLrDwMgiO3ziv8FmmpZNLwzPR0EtvKf1L4cdFBtZG698v97mxXHWLvD3kC36YWmZCZ4xnP87kCeScdSLjbF2uhRCn4Z33U/wQUnezL8P9Ya6esQhZG7d2G+Dzvw1qVibbrafuRDJuUGivgk/s7lo2ctB0MF9fEwmUPsF3FfO4RdoCTawwROVTiEJ2ssiAjjAqcui+j3FpL86KZopkuNWxQC7fAhNfBZLvbvjX7PuVzNgzoUDAVPvOAW/3I+5FPNaOtpw5mxdjSkICm9aIOGvE64vNAn2CBtATKGGHKkW8Ku0wFgZETklFzR6jcwot5geGpt9xJlxhx9haF/nbp7g==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=V0JgzIyM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=V0JgzIyM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::1035; helo=mail-pj1-x1035.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc9JM1HX5z2ynv
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 02:55:13 +1100 (AEDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-35b95a7444bso777848a91.1
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 08:55:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773935711; cv=none;
        d=google.com; s=arc-20240605;
        b=NswBWA+ubwdjZ8uQDVK8Qi29EH75ZYK09BG5Z0OUTme2qI1CtmiJZphC15JdAuSZWF
         G3hZ8dWl6q3T9/FKu3I9GElcrM8W+laJRFIysp2iyRGQEU3LeSW8kTvxvkFE71+tXFSM
         miXI5OaF4ypL/tKBdIzwWhyJXNFwlFBGP4N2dTm5kZpYMu89pyzo2sly++wxfe0QAaz6
         SfjSG+LYGTEs/LXli54a08lKE7pDGO8SJnoehp44qfnBjnI2l1VFISNO0rbJCHantXrk
         bWf/qsjpwdr25WDrcZIpRrKsUdEW9rSxBvO6LSOJWo4VsV1DyrymAhohKDrV2pqFD6nA
         roqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5dUObDXy8tyO/dqZjJVHNnud7OeR2yjgyzlwu5eskHg=;
        fh=aeIo/PjG3xJZetx4s5KZ4HOoFZqgPYD7rzUXe+Iog+w=;
        b=WWwIktKxnsAmFqU34g/BGMrZhsaU7SIEExBTcasFcKE8J/oOZSpXpMr3r5CQ8+VweY
         psvl1BPtV1kK+uu1dz+cb0KsjaxP095kOMpbV1vC0+/MiSI64H+dxqcXzmeAE6H3FiVS
         pESl0XLWvpY24Db8iJQ8aUEMzReisrAMfeFqe7fDhTDnWciqVif6qvx3roTZkrbRSwAi
         FQX0tZPyr9yUZLjQ+q6+T210PPmHbVmU/dWWyFjS3lqbkt+FN8UeUeLoTztsxiZcPajY
         Ne0He9vQdKQlVq8AMVAZTwV7NfDyo2Q5666erGOE862p5RSc/WWFcjEP2SnQCiU6yUo2
         nJFw==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773935711; x=1774540511; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dUObDXy8tyO/dqZjJVHNnud7OeR2yjgyzlwu5eskHg=;
        b=V0JgzIyMeQXUxTvFyC0bRAQpFwuaWMpgf5i3oxme+g4Y5u+3cAOjyXBNT1BPsQGVLx
         MYhqhfz44fcsr8jxASwLOlTscLwCpiIoV1fC5yLXO1bCW++vNuI9uUUlKldUYew2VflR
         fUHBowe47shlQ2oBOWS9tgtDcXIwyJF/M7FbwqNyvEmFXGj500a2DkJadF+cYUfXN6BK
         n/t9bR+SyEeEkJSnpmi1CPI5kT0pIxsErCn3t9+SNR5FFW6rPzDEMG6A/7KuppRgiucs
         Anq2MaUQUHPrE0+24edYFrHhmxZkrqHbY4Xr2u9UTrG/9G7gMmY3s8yMsMF2ZMw3jgjG
         TSnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773935711; x=1774540511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5dUObDXy8tyO/dqZjJVHNnud7OeR2yjgyzlwu5eskHg=;
        b=XYq1fdMymtPHG/xRtp97yUmRFtLKlDlOUkaRc7i9efWK4jHiYuHISiOdN0FqFNQl0n
         rTq2jXtlpZKEjKaWwoAtLpy9lWEyEQNQ7Ni6/NpLASh8oHaoHWvwBBmpD0bJphWH1tFE
         ydHw5P6fFhs6KQDpLq1YntIdxtYgn+BHZIZzQL9PcwDklcVmzNb9BIrQDvHD/fFLoPI6
         prOlGBiUDtJyeRhFNWo7QrVa8k03ahV/xBYrqwTBoZG0XLs3m6IENXsFApb6HhE/6LVi
         6gW1lw9dzgqaEDWDHdX07f0VKQKYXnqWJQFW324glweHxIN09JKl/kWFeXnPyFOWzG4U
         qQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCWIMMujEom4N82L/kpcOgS5CGtw1QsjGVuAZwAo9T+JjPE9ct9wjqnO9sQLnVoHfVM1Rm1tS9z4VcH0kg==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzVcGdpldvb25ggoSrsjQGKLpymN1A1r0JLev+6c6LKLgpTTDff
	W7BLnqYC5DgSwJnN9j8A4V00NwSgDcZHi1aMYQX9sdC1iLnrkgvypLbmnE6BbYvTQazgse7eS/G
	Bzp9T34htHavBfuEtRUz1E/RamoTRkMH+sY5HVeTR
X-Gm-Gg: ATEYQzyW7UK9TL/lYE0RqkEd10EvKpR20GXPSO+fQAxybnfHc5XJE2R9JBCcDGJ0Roo
	e2N8XFkmo5w/0hQ+BnGn7hrLIpiGUb5pzrF7nrM2ftEB1PB9dAhJvlWNE6cEy/iVx4N5yh6Rgg2
	nq821/Jk4WcPYqXSUJuikxfakc/ARnv+q2XZ+1G9xrtFEQ2xq6jcoOcMdFU02/9yUt5BYApEByX
	5qzh4oec7JiF9cqqwfuIMreRFNNNoPpasnEdtQ1Eeq6EqtP4NYFF994roJ8AV6bNQguaESM8Ikj
	lR3rbkSMjpqFRlxxCw==
X-Received: by 2002:a17:90a:dfcb:b0:359:8e5e:43de with SMTP id
 98e67ed59e1d1-35bb9efae55mr5927149a91.22.1773935711512; Thu, 19 Mar 2026
 08:55:11 -0700 (PDT)
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
References: <20260319124616.1544415-1-amir73il@gmail.com> <20260319-unentbehrlich-reitturnier-f78d9fb01230@brauner>
 <CAOQ4uxiS1uM=mn4q6CQfganba1XcqyXYmXfQceWdfUVRFK_Pvg@mail.gmail.com>
In-Reply-To: <CAOQ4uxiS1uM=mn4q6CQfganba1XcqyXYmXfQceWdfUVRFK_Pvg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Mar 2026 11:54:58 -0400
X-Gm-Features: AaiRm51qlPregfqoGDRQQu1uLckOXRqh7QNN-0XQFNPe0ZKCktL-8XDfXZ3JIYA
Message-ID: <CAHC9VhQDXHh_=X-OKD9oN8fapVXBwLakNp4rEHLUL0cQ1RSteA@mail.gmail.com>
Subject: Re: [PATCH] fs: allow vfs code to open an O_PATH file with negative dentry
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, 
	syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2857-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:amir73il@gmail.com,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:miklos@szeredi.hu,m:xiang@kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.996];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs,f34aab278bf5d664e2be];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: EDFAA2CE157
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 10:50=E2=80=AFAM Amir Goldstein <amir73il@gmail.com=
> wrote:
> On Thu, Mar 19, 2026 at 2:13=E2=80=AFPM Christian Brauner <brauner@kernel=
.org> wrote:
> > On Thu, Mar 19, 2026 at 01:46:16PM +0100, Amir Goldstein wrote:
> > > The fields f_mapping, f_wb_err, f_sb_err are irrelevant for O_PATH fi=
le.
> > > Skip setting them for O_PATH file, so that the O_PATH file could be
> > > opened with a negative dentry.
> > >
> > > This is not something that a user should be able to do, but vfs code,
> > > such as ovl_tmpfile() can use this to open a backing O_PATH tmpfile
> > > before instantiating the dentry.
> > >
> > > Reported-by: syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> > >
> > > Christian,
> > >
> > > This patch fixes the syzbot report [1] that the
> > > backing_file_user_path_file() patch [2] introduces.
> > >
> > > This is not the only possible fix, but it is the cleanest one IMO.
> > > There is a small risk in introducing a state of an O_PATH file with
> > > NULL f_inode, but I (and the bots that I asked) did not find any
> > > obvious risk in this state.
> > >
> > > Note that specifically, the user path inode is accessed via d_inode()
> > > and not via file_inode(), which makes this safe for file_user_inode()
> > > callers.
> > >
> > > BTW, I missed this regression with the original patch because I
> > > only ran the quick overlayfs sanity test.
> > >
> > > Now I ran a full quick fstest cycle and verified that the O_TMPFILE
> > > test case is covered and that the bug is detected.
> > >
> > > WDYT?
> > >
> > > Thanks,
> > > Amir.
> > >
> > > [1] https://syzkaller.appspot.com/bug?extid=3Df34aab278bf5d664e2be
> > > [2] https://lore.kernel.org/linux-fsdevel/20260318131258.1457101-1-am=
ir73il@gmail.com/
> > >
> > >  fs/open.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/open.c b/fs/open.c
> > > index 91f1139591abe..2004a8c0d9c97 100644
> > > --- a/fs/open.c
> > > +++ b/fs/open.c
> > > @@ -893,9 +893,6 @@ static int do_dentry_open(struct file *f,
> > >
> > >       path_get(&f->f_path);
> > >       f->f_inode =3D inode;
> > > -     f->f_mapping =3D inode->i_mapping;
> > > -     f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> > > -     f->f_sb_err =3D file_sample_sb_err(f);
> > >
> > >       if (unlikely(f->f_flags & O_PATH)) {
> > >               f->f_mode =3D FMODE_PATH | FMODE_OPENED;
> > > @@ -904,6 +901,10 @@ static int do_dentry_open(struct file *f,
> > >               return 0;
> > >       }
> > >
> > > +     f->f_mapping =3D inode->i_mapping;
> > > +     f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> > > +     f->f_sb_err =3D file_sample_sb_err(f);
> > > +
> > >       if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) =3D=3D FMODE_READ)=
 {
> > >               i_readcount_inc(inode);
> > >       } else if (f->f_mode & FMODE_WRITE && !special_file(inode->i_mo=
de)) {
> >
> > I think this is really ugly and I'm really unhappy that we should adjus=
t
> > initialization of generic vfs code for this. My preference is to push
> > the pain into the backing file stuff. And my ultimate preference is for
> > this backing file stuff to be removed again for a simple struct path.
> > We're working around some more fundamental cleanup here imho.
>
> Fair enough, we can rip the entire thing from vfs if you don't like it.
> The user path file can be opened and stored internally by selinux
> without adding all the associated risks in vfs.
>
> Paul,
>
> Please see compile tested code at:
> https://github.com/amir73il/linux/commits/user_path_file/

No.  Definitely no.  Ignoring the fact that there is no reason we
should pushing this into the LSM, doing it in this way means it is
very likely that each LSM wanting to provide mmap/mprotect controls on
overlayfs will have to create a new O_PATH file.  No.

... and let me preemptively comment that this doesn't belong in the
LSM framework either.

As Christian already mentioned, this really needs to be addressed in
the backing file code, please do it there.

--=20
paul-moore.com

