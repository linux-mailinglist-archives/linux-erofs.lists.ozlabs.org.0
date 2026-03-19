Return-Path: <linux-erofs+bounces-2862-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MFoKOtAvGm7vwIAu9opvQ
	(envelope-from <linux-erofs+bounces-2862-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 19:31:07 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id C47CD2D103A
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 19:31:06 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcDm83YmDz2ypW;
	Fri, 20 Mar 2026 05:31:04 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::52d" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773945064;
	cv=pass; b=YadctgEY3WbppHU+FGdTkex1kV5uV+tofsRv58IsbECVKuC+YlpdE3tA4i52syTZRMZ4Jitu490sPlZjPTQOSwbFTiuDD4MLps7DCvlq0+vypwHro+ANtY5a2zvAVu+5zdBTGr2Jf/8Vg9UoJy82XNDVboW5XO6EjCNJWx7bQN1LyIg7WskdSyaR2gQp7OnPgHQjiR/Ursimv8UlYbD9C4l02CB0SOisNcOxd8s6XMgf7Al7vIpvMeEstmf8wtqlb/rhB0FDIh2cR8nG1m5TTZ+nlf/CvPyZ1GGIEBkBMpjign07CMBlBMXrCNmqSLJaRPXIMoDIHGEqOb1m4jjkvQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773945064; c=relaxed/relaxed;
	bh=FJV4dFXvSmt1MChF30a7mY59ejZaZEAqv6m7VOg5tb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5MtH6iPwEaUtDTqg99xs1AIJmeswEo/VbqbCmg+tkaE3HAqS0BZ/omhwRhK08PX48lIakXBh8wU7LBPch4H22zTokY1wfBFR2e7GFLRNP0N6OGsLYuMeotTM9a3e8G//jDYoX04kvq5aZaLWk2hS+mK3XaCOZLF910tFu4/ZdRqR3KXD6cZnx95BYK3TpW5HLxLSSG2aUJ5pJcNG9uVQa1VHBX1yJ2O4HOG/Y56eTtff37RkZ8GUjj6Cm0v63ViSFcFGXMOR29dY6WbB13Rhjy15JjkTDmLm06j6HSTMHREMrAjBxSr2UrVYShknk19A8lm+c8WUNvfuKv5gPV9EA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IQd4auJs; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=IQd4auJs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::52d; helo=mail-ed1-x52d.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcDm63Fmnz2xVT
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 05:31:02 +1100 (AEDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-6618bc129acso2018502a12.2
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 11:31:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773945058; cv=none;
        d=google.com; s=arc-20240605;
        b=PW5WQakcYHuxtg7Yc0zYSsnH4C+Km6EejBY5P9qNjN93jL2VD3DRAecYjA9xAq7c0E
         xsQQEspptSFsYqIruWfTKaZhLqI/7gCIi3fzZ8cMwJ7EEgGj2V8bfgV7pMttieHIbya+
         Px0L5Ge6H8XMtNA1M4tfititq+4HtQsf0pEWJy+ZvWtmmi4Hs3bw4weP1cdZ5oG3/eES
         QxrRtsvTo4DykngeMJECaGEj7uNFmYU4PfGVkcSPWapkaGEv07fZ2g2/oaNgiteNDgsh
         06D6hJG9TIP8TXYUIinqJKltUq1YTZKx9DNOKKvIvIXF+/LU0v6TdrbOXZ08jq2h6P4p
         842Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FJV4dFXvSmt1MChF30a7mY59ejZaZEAqv6m7VOg5tb8=;
        fh=ce6oQim/MVNXj2MHIM8Wmo/N8spYom20eUuDFFkjkBg=;
        b=jSWiPy9pRh3O+eRg2UE3y2BazbjGtZJma/l2/mfwhbteelhGF8cMsQQJdM4eaGkPh7
         aJ6BT9TKi04Px455Igz+BitlB6j0qkaRuyQwS1XlhLBiEHkVzu4JRMatRbxmb6Nxk+DE
         6nL94T7Y9TytzUWU6qFuYvB4X+txL+h6TsRSYN5dBJ/Lw+kbnEeDS/7CCVEC7rnPTiUK
         NUY0City/3/pIWT9D04Dir9j9bEXVOrQ8XiEzucvXebTuTUZ7K/k2TartuatWbV5sabd
         /jQT05nd0YS4XL/maDIAAxmbIQOSTyn/VXYcCTY6Owyp/4GyWgdhe/Yjzw5fIW6Kkmls
         ihLQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773945058; x=1774549858; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FJV4dFXvSmt1MChF30a7mY59ejZaZEAqv6m7VOg5tb8=;
        b=IQd4auJsGhvhUiWBIRTnOfDAAyqJxdZe2unwq+rIXgh4OkCXKZbULC9UsJtUEo+AGc
         yA46nEV5xtOhe9a4cewy2cIMR6FB/cuHSm8iLYtR9oILIcOmPQmGnDEs3a6zB/1MQ2pP
         LxB7OIhEi+f+kQXLxXMkC8F4WIi/z4sSPeN1WrGPHW8waK0rwbsxx5MF24BcYd6brYF5
         +6/Ex9jnjd9pWJrhSpIfcJffhKirIxi9/LaTIUASydZ6ENshAvJMbnBwerg4WkINFJNt
         O5/+MJZr+6+P52dimCBPrb2GyC/c1mwylvqbRqn1gVAaocJUGKZQdmjT96Hhlv59J4Gm
         FQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773945058; x=1774549858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FJV4dFXvSmt1MChF30a7mY59ejZaZEAqv6m7VOg5tb8=;
        b=ny5fEa0KH4pDfIwj3gKqcLaDE8p7mSjm4j9D4iJHvRMnTUJnpYDWI9uX7ZgetyjauD
         7jZPgEKDC20G5Ek6LQLtERNRDYjpuuJnA3LNXdF3Wij1KbPIRr/X7n73KufvBMI6ohPY
         n3nN3XH+iE8Cn5CpmkKS1zp3Uw13JEU9TFVN/3GacEF6kTHmaafRb/tXDIO/Z5NNVf/h
         ojyU7VN0wkbTX9OqmrPGZN1x81YUDLM/vs75VKJ/QjQvgrO080ZxDd4CMv1ljnMFmoYo
         0swYOI+Utab/PzW37+GeD8b7/EDDdvRYSuZoYmv6Kdw5C7ahqdbUIYqFt5LLMN9rk4LU
         qspg==
X-Forwarded-Encrypted: i=1; AJvYcCWT5TMIa+TcK1sqSrJsilmHywW0PvvLtj3B4ICZrm3H9dTBO2Ck6dGXtHbl8LJjxjH45BMjAcdU7Hu9ow==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxP3Ls5fK/6xFHejEjIZ/CFEvo0hwbx3vivmdcSMxgc/UsmMUa8
	2M63LBIthRVWWw3qpsQEA5jDuomDxmZnOz+m+FYlw3N/+baa2AK4jfDzrE+PZ1bwYlpgxhzmRI/
	gMkhFP8tO2/o6QvIfVpdaA9uGZZ2dFhY=
X-Gm-Gg: ATEYQzx76wmOiUbHNhYFtNGbZ82YkLTPRGY06uTCLJAfE2pukYsOB6WATK4124HJ22h
	o8mQw7jOWlxGeEiXTimixktdVctO1OrxvlhG+Zvshz0cp//ghQJE8Mx1QeAfU19QAEhmFhucomg
	E1opwiEh5Pjv/+GdGxXY4yZluJDf3aGIisQ/kVE/TFcDhyvVr4icnGlO1IPsIW3dT9f2/PwfqVZ
	KV4LWnrY/7lkrNGC9W9Es3xyOkGl+z0wySZ1Rq+QagXaYJXshZpci16kNZ3UltusM0chc3qau5d
	aYT8Zc0B+xOJLauF2r/YvaLJB8B1poxD9rXezDIWQA==
X-Received: by 2002:a17:906:c802:b0:b93:a3db:a68c with SMTP id
 a640c23a62f3a-b982f3e0617mr18697866b.40.1773945058029; Thu, 19 Mar 2026
 11:30:58 -0700 (PDT)
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
 <CAOQ4uxiS1uM=mn4q6CQfganba1XcqyXYmXfQceWdfUVRFK_Pvg@mail.gmail.com> <CAHC9VhQDXHh_=X-OKD9oN8fapVXBwLakNp4rEHLUL0cQ1RSteA@mail.gmail.com>
In-Reply-To: <CAHC9VhQDXHh_=X-OKD9oN8fapVXBwLakNp4rEHLUL0cQ1RSteA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 19 Mar 2026 19:30:46 +0100
X-Gm-Features: AaiRm52lvBNmAkQT7DVWo0zF8FRRxYDmyiueu4eOodN3UFl0EjhqJc-Pr5qKv7g
Message-ID: <CAOQ4uxinSLXKWjMgwyA2A_UU5e+6ZjbdsFUY-+f9DMfQcxH0qA@mail.gmail.com>
Subject: Re: [PATCH] fs: allow vfs code to open an O_PATH file with negative dentry
To: Paul Moore <paul@paul-moore.com>
Cc: Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Miklos Szeredi <miklos@szeredi.hu>, Gao Xiang <xiang@kernel.org>, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, 
	syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-0.70 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2862-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:paul@paul-moore.com,m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:miklos@szeredi.hu,m:xiang@kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.965];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs,f34aab278bf5d664e2be];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C47CD2D103A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 4:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Thu, Mar 19, 2026 at 10:50=E2=80=AFAM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> > On Thu, Mar 19, 2026 at 2:13=E2=80=AFPM Christian Brauner <brauner@kern=
el.org> wrote:
> > > On Thu, Mar 19, 2026 at 01:46:16PM +0100, Amir Goldstein wrote:
> > > > The fields f_mapping, f_wb_err, f_sb_err are irrelevant for O_PATH =
file.
> > > > Skip setting them for O_PATH file, so that the O_PATH file could be
> > > > opened with a negative dentry.
> > > >
> > > > This is not something that a user should be able to do, but vfs cod=
e,
> > > > such as ovl_tmpfile() can use this to open a backing O_PATH tmpfile
> > > > before instantiating the dentry.
> > > >
> > > > Reported-by: syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >
> > > > Christian,
> > > >
> > > > This patch fixes the syzbot report [1] that the
> > > > backing_file_user_path_file() patch [2] introduces.
> > > >
> > > > This is not the only possible fix, but it is the cleanest one IMO.
> > > > There is a small risk in introducing a state of an O_PATH file with
> > > > NULL f_inode, but I (and the bots that I asked) did not find any
> > > > obvious risk in this state.
> > > >
> > > > Note that specifically, the user path inode is accessed via d_inode=
()
> > > > and not via file_inode(), which makes this safe for file_user_inode=
()
> > > > callers.
> > > >
> > > > BTW, I missed this regression with the original patch because I
> > > > only ran the quick overlayfs sanity test.
> > > >
> > > > Now I ran a full quick fstest cycle and verified that the O_TMPFILE
> > > > test case is covered and that the bug is detected.
> > > >
> > > > WDYT?
> > > >
> > > > Thanks,
> > > > Amir.
> > > >
> > > > [1] https://syzkaller.appspot.com/bug?extid=3Df34aab278bf5d664e2be
> > > > [2] https://lore.kernel.org/linux-fsdevel/20260318131258.1457101-1-=
amir73il@gmail.com/
> > > >
> > > >  fs/open.c | 7 ++++---
> > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/fs/open.c b/fs/open.c
> > > > index 91f1139591abe..2004a8c0d9c97 100644
> > > > --- a/fs/open.c
> > > > +++ b/fs/open.c
> > > > @@ -893,9 +893,6 @@ static int do_dentry_open(struct file *f,
> > > >
> > > >       path_get(&f->f_path);
> > > >       f->f_inode =3D inode;
> > > > -     f->f_mapping =3D inode->i_mapping;
> > > > -     f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> > > > -     f->f_sb_err =3D file_sample_sb_err(f);
> > > >
> > > >       if (unlikely(f->f_flags & O_PATH)) {
> > > >               f->f_mode =3D FMODE_PATH | FMODE_OPENED;
> > > > @@ -904,6 +901,10 @@ static int do_dentry_open(struct file *f,
> > > >               return 0;
> > > >       }
> > > >
> > > > +     f->f_mapping =3D inode->i_mapping;
> > > > +     f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> > > > +     f->f_sb_err =3D file_sample_sb_err(f);
> > > > +
> > > >       if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) =3D=3D FMODE_REA=
D) {
> > > >               i_readcount_inc(inode);
> > > >       } else if (f->f_mode & FMODE_WRITE && !special_file(inode->i_=
mode)) {
> > >
> > > I think this is really ugly and I'm really unhappy that we should adj=
ust
> > > initialization of generic vfs code for this. My preference is to push
> > > the pain into the backing file stuff. And my ultimate preference is f=
or
> > > this backing file stuff to be removed again for a simple struct path.
> > > We're working around some more fundamental cleanup here imho.
> >
> > Fair enough, we can rip the entire thing from vfs if you don't like it.
> > The user path file can be opened and stored internally by selinux
> > without adding all the associated risks in vfs.
> >
> > Paul,
> >
> > Please see compile tested code at:
> > https://github.com/amir73il/linux/commits/user_path_file/
>
> No.  Definitely no.  Ignoring the fact that there is no reason we
> should pushing this into the LSM, doing it in this way means it is
> very likely that each LSM wanting to provide mmap/mprotect controls on
> overlayfs will have to create a new O_PATH file.  No.
>
> ... and let me preemptively comment that this doesn't belong in the
> LSM framework either.
>
> As Christian already mentioned, this really needs to be addressed in
> the backing file code, please do it there.
>

OK, will give it another try.

Thanks,
Amir.

