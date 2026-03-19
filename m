Return-Path: <linux-erofs+bounces-2863-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALwPGyVEvGmAwAIAu9opvQ
	(envelope-from <linux-erofs+bounces-2863-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 19:44:53 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A483A2D1372
	for <lists+linux-erofs@lfdr.de>; Thu, 19 Mar 2026 19:44:51 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcF3z5GNwz2ypW;
	Fri, 20 Mar 2026 05:44:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1030" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773945887;
	cv=pass; b=lYWNlwn4uRCTv/St5zUpYDLW4+1hqRs1jelrNZThJPnN+XWbArdM2C31Lw8itkOqVkSMRHsWoDD+K0IeZRw1SNCfUq0krUH0R6rHSpdrJwx0/M0gH3c1nuvESgtml4OXcFwbg/8eMnKb5Wja5Q2ygHJH/6zfEMaPfhkHCHi4SCeuQKqvGPct+kj+E6gQKpw0pq+xiOPTJBw7HHjKcKAtbsYsW2N/fm6LP1HU5QnaYWjepbkLJXRwYGusycsaX/IjaDRvcsJdTryJKTweRXdnd816AxH3GyddNThY6HMY5eSmcukrcTtq3rFAdTWK8vZN9w0DI/QaVqRJN9ddMxBR2A==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773945887; c=relaxed/relaxed;
	bh=3LpRx2Ah23pGDXkHY7jaWEi08gxAWhSArXDD9NIs44I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cGxqM/8XRuib0aUdJTeWAJTwqQE7M1IFtZvXWpzDVNOn9XTmo9+PPZ9vKRP5qcxNhYQ67OnJYY5Jz6qCz2bzA4Gr9AjnX35G0ckkx6qMnSOlR/NKlIXlQnEizp2Z0/EMo3UrTVAv8RfF2gxfkK+geQZgfbzl4grxguy/XsIGsRggY9rE0AeoXeCjpzdCZ3inWYjV8e4M2p3V9DHbJjxZ74e7h9tC19K5x76BKeDMCLUPlMW9w84zVOQEZKmoOmbFZsJGON5POyTchtrwxYfCzzx+d5bov59fXskcRifggAQKxiZi2zZyVRTioNMfkD0lcWtasmwiEirOvMX9VREOOA==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=MQdoJj0x; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=MQdoJj0x;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcF3y2Lg8z2xjQ
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 05:44:45 +1100 (AEDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-35a02f3b8feso605973a91.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 19 Mar 2026 11:44:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773945882; cv=none;
        d=google.com; s=arc-20240605;
        b=QL6wZmpyBZeAnaI/W9AisTGFpTeMI0o5Ki5/UNQ3t553/XdaDbNfvigvwhUbXbaJQs
         gNxYhKEU/CfD1MMMCw45BOkggLyTJ8rE9eUFCtGbQ1lXl1wXkNzreksy6nyhEA5p+Ki/
         a2gOEXA8pr2j4yUv/P865oW4er0hC2BKxFQm4sfGSa435HSXCeWkbSr9KT1oC8Z2AW5n
         GbmKiSf1Oybgz3p4CkMx2ItVOwjoH+JtpeT0BsCPR82xJvvz4DTahkv6BLJuEHK/Ser8
         KMF2xsXhVjv+wz4X1zO93U0RWB8kiKMf+3R92cX9TSL6zvwDUBglzMT9QFllhStgJhYC
         uUVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3LpRx2Ah23pGDXkHY7jaWEi08gxAWhSArXDD9NIs44I=;
        fh=6tiNQjNeQTuCvW6btGxwUSHSM5IzSu2BHES861Kv18M=;
        b=kFOTBR3CLRmKe4DZfyExtMUr4bnhmq2oSZhtwq6uWCp2ynKdDaX6KYV/mYJNv7aqKR
         bvEfto/w1Nkr7+iR+mbH5pTGQ1+fvrhvYihRLfsYkJ1o6O9UzJZNB0Va+onFJ+Z4402E
         ZmWe0qHaS96uV17feu7Eqqs4Xqu4ULEY34UmfkG7YYvzLQv58jKUKLWyiQjFaad8EFgX
         XphgTwxswhUpsOZQwvGRPW0QB6yyXljVEY4bBXpLkQvR/NVQI1DmMQ172R2oXyWiY9Qs
         xbowkP2oNxfEwG/dYfs8ntkscYYA7qe0wAcLxks58IhKEnU98nysCy63PHEjWmwM+3Vh
         Rz7w==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773945882; x=1774550682; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LpRx2Ah23pGDXkHY7jaWEi08gxAWhSArXDD9NIs44I=;
        b=MQdoJj0xBXqRbThs+rx89Lf/52LVGebO37a5V8GVYruKfKJ9ZwBn0bnGtY9Uwimr46
         o+jldQehBhByw66o2nqXuxNgtzN5BRQKfd4YqIvULXwG/zWHdiLJZUTR9QQDfHSqDahG
         18ctEDD2OBKJUpM3/pHGDQOd6fEJ6CUAMBelDR4Pa9XPQcWtwxhnIa7t6Eq5veaWNAIH
         71hInweYTL0K/q7ALymx62osO0ulWcXCj6GCVJsFSLPc3TdJlY5crNwoYmxv1X0xyVSz
         R3CAqcZs0j98mKCjTWgVE07WzubBS+QTiX265WXhRJ58n4i8FDvtWaNDLooT7sOf941H
         fbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773945882; x=1774550682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3LpRx2Ah23pGDXkHY7jaWEi08gxAWhSArXDD9NIs44I=;
        b=jvz7+dMYtMtvMyREogZeFre76dl6jzXTl7tT/ARvoTu/mLTFpebkyqeosVbTG/1Qx4
         akUGCtOkDE0aa1qnU06joXCq4/N+lqFanl4FtooKvPKQOZuuAaG9/sHIoAnqw+UH406X
         2p/+Y3H2CO9Xwx6qz+isPWyuzOxdsFCR6qJ8ev2IaTEFNRkk8zL4qv2Lv/i3cs9EQaHP
         Lli1T2URsWqTJ4OSv/u3kxtBx9+IKO2lQYRg40VDCz7Ugp6Rtk7NPqvIaiqFkEG3cloz
         EwEkaNVXQ3NsWFlE1CifYbE/e/8wJMvQdE/SdoiX2IgLsZH+2oAiDk1G6aRVvjjbQgPs
         gwFA==
X-Forwarded-Encrypted: i=1; AJvYcCVTyHpCkfMMwFIbsbuLdzAjSW7OHVIPpPC2yvI5lxQJIB0ZLd4gaG0imVW0/7i2G3Wem1ZQAzGBRUP5cA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyOqU9yvZv10box7YKW5RyrQ+wvx+exsyZdrlwiAPatjmxq6S4P
	6JuwT49mkdonav2QJfxMFc2CL1HfK+PLG1tL73ZgTaH/6b3LbL1mqocM7tmB18VDA9kYhWs6ilP
	BGFTaqomyG2/UwsjSrLpQt4tlDlES1wnvnLrkzVk8
X-Gm-Gg: ATEYQzyKwi5bQApWb92LvHtFYtKm7iMZLLa6EUH3LwH3IUB8jdq86e8kWI0xsJqdR4H
	2xF7aUGz2OYKSSKWXsXHtowzwAtiuirZ/zbEjYzrzBIbN1VjBiButsCfcS3bfn3wat+HNgdwY0z
	fI3iyM6v//mJe/9P9tQytPbsiHuti3hiTpOulH9oVCPej8KrCURaH7+zBHZ8lxwZz/N3a2xN70M
	x0ZpAMwKlr3781wzdNsNEo/uDGFV9NuObjRMjrt4Qs/pysyav1mXkQjhFvVqNQkUBk4N1h4uimG
	aodMr8pOSmjtle9P6A==
X-Received: by 2002:a17:90b:3d85:b0:35b:91e1:e110 with SMTP id
 98e67ed59e1d1-35bd2cb726cmr153296a91.20.1773945881632; Thu, 19 Mar 2026
 11:44:41 -0700 (PDT)
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
 <CAHC9VhQDXHh_=X-OKD9oN8fapVXBwLakNp4rEHLUL0cQ1RSteA@mail.gmail.com> <CAOQ4uxinSLXKWjMgwyA2A_UU5e+6ZjbdsFUY-+f9DMfQcxH0qA@mail.gmail.com>
In-Reply-To: <CAOQ4uxinSLXKWjMgwyA2A_UU5e+6ZjbdsFUY-+f9DMfQcxH0qA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 19 Mar 2026 14:44:30 -0400
X-Gm-Features: AaiRm50mWSepRO31-IrCKePpEwYDJfx_2t8PZ8Bwv853YChliBvO2jCDu0_F2bc
Message-ID: <CAHC9VhQbT1jPXN-nqmoNS4DGkYGWrVkO9-C1k-9zjYU9cRDi0A@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2863-lists,linux-erofs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.994];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs,f34aab278bf5d664e2be];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,mail.gmail.com:mid,paul-moore.com:dkim,paul-moore.com:email,paul-moore.com:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: A483A2D1372
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 2:30=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> On Thu, Mar 19, 2026 at 4:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Thu, Mar 19, 2026 at 10:50=E2=80=AFAM Amir Goldstein <amir73il@gmail=
.com> wrote:
> > > On Thu, Mar 19, 2026 at 2:13=E2=80=AFPM Christian Brauner <brauner@ke=
rnel.org> wrote:
> > > > On Thu, Mar 19, 2026 at 01:46:16PM +0100, Amir Goldstein wrote:
> > > > > The fields f_mapping, f_wb_err, f_sb_err are irrelevant for O_PAT=
H file.
> > > > > Skip setting them for O_PATH file, so that the O_PATH file could =
be
> > > > > opened with a negative dentry.
> > > > >
> > > > > This is not something that a user should be able to do, but vfs c=
ode,
> > > > > such as ovl_tmpfile() can use this to open a backing O_PATH tmpfi=
le
> > > > > before instantiating the dentry.
> > > > >
> > > > > Reported-by: syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.co=
m
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > > ---
> > > > >
> > > > > Christian,
> > > > >
> > > > > This patch fixes the syzbot report [1] that the
> > > > > backing_file_user_path_file() patch [2] introduces.
> > > > >
> > > > > This is not the only possible fix, but it is the cleanest one IMO=
.
> > > > > There is a small risk in introducing a state of an O_PATH file wi=
th
> > > > > NULL f_inode, but I (and the bots that I asked) did not find any
> > > > > obvious risk in this state.
> > > > >
> > > > > Note that specifically, the user path inode is accessed via d_ino=
de()
> > > > > and not via file_inode(), which makes this safe for file_user_ino=
de()
> > > > > callers.
> > > > >
> > > > > BTW, I missed this regression with the original patch because I
> > > > > only ran the quick overlayfs sanity test.
> > > > >
> > > > > Now I ran a full quick fstest cycle and verified that the O_TMPFI=
LE
> > > > > test case is covered and that the bug is detected.
> > > > >
> > > > > WDYT?
> > > > >
> > > > > Thanks,
> > > > > Amir.
> > > > >
> > > > > [1] https://syzkaller.appspot.com/bug?extid=3Df34aab278bf5d664e2b=
e
> > > > > [2] https://lore.kernel.org/linux-fsdevel/20260318131258.1457101-=
1-amir73il@gmail.com/
> > > > >
> > > > >  fs/open.c | 7 ++++---
> > > > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > > > >
> > > > > diff --git a/fs/open.c b/fs/open.c
> > > > > index 91f1139591abe..2004a8c0d9c97 100644
> > > > > --- a/fs/open.c
> > > > > +++ b/fs/open.c
> > > > > @@ -893,9 +893,6 @@ static int do_dentry_open(struct file *f,
> > > > >
> > > > >       path_get(&f->f_path);
> > > > >       f->f_inode =3D inode;
> > > > > -     f->f_mapping =3D inode->i_mapping;
> > > > > -     f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> > > > > -     f->f_sb_err =3D file_sample_sb_err(f);
> > > > >
> > > > >       if (unlikely(f->f_flags & O_PATH)) {
> > > > >               f->f_mode =3D FMODE_PATH | FMODE_OPENED;
> > > > > @@ -904,6 +901,10 @@ static int do_dentry_open(struct file *f,
> > > > >               return 0;
> > > > >       }
> > > > >
> > > > > +     f->f_mapping =3D inode->i_mapping;
> > > > > +     f->f_wb_err =3D filemap_sample_wb_err(f->f_mapping);
> > > > > +     f->f_sb_err =3D file_sample_sb_err(f);
> > > > > +
> > > > >       if ((f->f_mode & (FMODE_READ | FMODE_WRITE)) =3D=3D FMODE_R=
EAD) {
> > > > >               i_readcount_inc(inode);
> > > > >       } else if (f->f_mode & FMODE_WRITE && !special_file(inode->=
i_mode)) {
> > > >
> > > > I think this is really ugly and I'm really unhappy that we should a=
djust
> > > > initialization of generic vfs code for this. My preference is to pu=
sh
> > > > the pain into the backing file stuff. And my ultimate preference is=
 for
> > > > this backing file stuff to be removed again for a simple struct pat=
h.
> > > > We're working around some more fundamental cleanup here imho.
> > >
> > > Fair enough, we can rip the entire thing from vfs if you don't like i=
t.
> > > The user path file can be opened and stored internally by selinux
> > > without adding all the associated risks in vfs.
> > >
> > > Paul,
> > >
> > > Please see compile tested code at:
> > > https://github.com/amir73il/linux/commits/user_path_file/
> >
> > No.  Definitely no.  Ignoring the fact that there is no reason we
> > should pushing this into the LSM, doing it in this way means it is
> > very likely that each LSM wanting to provide mmap/mprotect controls on
> > overlayfs will have to create a new O_PATH file.  No.
> >
> > ... and let me preemptively comment that this doesn't belong in the
> > LSM framework either.
> >
> > As Christian already mentioned, this really needs to be addressed in
> > the backing file code, please do it there.
>
> OK, will give it another try.

Thanks, please let me know if there is anything I can do to help, e.g.
testing, etc.

--=20
paul-moore.com

