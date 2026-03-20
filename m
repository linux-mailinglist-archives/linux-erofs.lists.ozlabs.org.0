Return-Path: <linux-erofs+bounces-2880-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPn3CGs6vWkH8AIAu9opvQ
	(envelope-from <linux-erofs+bounces-2880-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 13:15:39 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 970EF2D9FC7
	for <lists+linux-erofs@lfdr.de>; Fri, 20 Mar 2026 13:15:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fchNQ6mDlz2yYY;
	Fri, 20 Mar 2026 23:15:34 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2a00:1450:4864:20::635" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774008934;
	cv=pass; b=If0sU5OzmXJz+LGj0k/E0Z30/yWPCXwJyj0I/qPUpmGdCb/fFR+W0MFwevpoF/6u4edNy5Zq7x/mSFOMRKjpFByMCQjnRs99gYbUHhQwcUo+DePfskXZMX41qT0cP8YEXhmyeIlLLUVCUR9VBtpcVvFVCVwkdFBZstZqJ4TazpdjVoUXqvMZ9NkiPdI2Kw/CdvuHB9TZrm2nJkQnwEAX0+NwZ3MJhZfvUOHEJ9arLtFi8aqYbL8QcMP6TseMMzLBBabo2lyp0tUZ88uLGlcE9e+yvQXPbbknnlzvGE7TDlrb8gZwjR9ycE1fPvAA8QMO5fUF3o+IM0CY/va+rf4KTA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774008934; c=relaxed/relaxed;
	bh=WBpgvBLWMC/0BhjOb7jBuNoEBM9BBGEAVw/zBHqxLZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iTrVdwU7hoQzKyghjAqikmS0DHw6qBHA2pqiZD3lzIPpEod3eFZKgMkr7RwTvbcq3p5yP8OjOeK1ab0V6eddOw418o/ZhuCH5hSA8xPl5T+nNvvhygAw3qwq6h5Y7tKNzt5lSVedetB/46HQNPcY4g5mrfiyvXBeBoPjOSftd9znQ0HWt2xTSTDAK/EcY60Y0pB/pkwCISwD/+WFJOX2F/dUxbUv0IlU6U43Gtd08ykFjztovOmUgYUmZZdNqo3kfyzzDlX3Q94twittRzt19uZ6STogIi5yJt1Gsptct2ZMZtyrOzowWbpaOmYxVrenwapfupIpunWNW+cr/T+kYg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kFhtRqRL; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=kFhtRqRL;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::635; helo=mail-ej1-x635.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fchNN4fkNz2yWK
	for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 23:15:32 +1100 (AEDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-b93698bb57aso389392266b.0
        for <linux-erofs@lists.ozlabs.org>; Fri, 20 Mar 2026 05:15:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774008927; cv=none;
        d=google.com; s=arc-20240605;
        b=W9fREOyQoLB8FHvfhXAxIBtAr0YbM+5Rq/fYAPV292N/UM1wzYOr9vhH3sKcNnGGNm
         D4THqtBG1dh05TtKsA/YteKEwxHtwhjjAfUdPi1luiSQXyZzLJqIe4GFLeGNNoj1AfGu
         LbgS/UDOYOis9wWZvq1WxkgXrFH3XfI4rl9gQCKJ/tBupKd8jUNgqvtO4p3jUlBbmyFt
         DLbtRyNJu4oEIEturu7DoXEuTIZoIBZSsvWbjDMlMN0CDiRti1SxFYK14hH6NngsZA3G
         hIdysYN66O94DhjP68UwLetlszs1L5ZZX23Iuc4jYaPXb8/pkqtHnaWvrs0d6n6h8C13
         0qsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WBpgvBLWMC/0BhjOb7jBuNoEBM9BBGEAVw/zBHqxLZw=;
        fh=d4rdjhtUsNUalE3Ufo5nHNMAri1vtIfO14T/Ft6l4qI=;
        b=Y3/hCY6qNNfmiUE/AX8Cz1FNQxOcqN/HtLCKKkrhukI8kehkOP6R5/8Tc3RTKyixRz
         7ziUF4/bAaorAnxdHKuh8XyjBD9Slou1s3PkEQbR4jYpA7fptJgavAPhDsA5IPrsYJqz
         gKHxiUHreSj3XdSnGL6xRkNOLFJlkXY703bJXCvQAT9DhascgqGoZXVvbzToq537nljp
         SP6rsmpPRdXrBQFhgEguVo716axh9UTmgcIFprQB/d90J1moMGccqbhwP7a0XPrzo1hI
         fhqYW1gZ6OyWclvyAhqKJf9evdDzZ4FHn6YCz9WPkISB2VkiFQazMHmSPh3Kzuj3MUgL
         rgbQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774008927; x=1774613727; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WBpgvBLWMC/0BhjOb7jBuNoEBM9BBGEAVw/zBHqxLZw=;
        b=kFhtRqRLnoqPb5JGbe2s6YiqESP+P79tEee/YISzM7luC5jZZnrmKPcfbcOjSba/Ob
         /p/yAEHgn2Xjhrx9KWUvoqxwK+khC8z9p2H41udzkfS4YJFYmtwX6jCfPRxdYqCkmZ91
         Y1IkfTtKG1lCAYAfd2ZM9TrHT/XfAfDeKUGXTAaAJWTL299j1tG3s3g3FdhVMwp/x3uZ
         d1DoQHR/dDQYxXCxWt6NVJkVI4s1/J9TEzqHkdorD4kghRGRVCyHLbXFzpOZheYCCEv7
         nqnBtFsTOZfDI3b3zP20PTSUQ8frSHs4zf2GKNBwzXykg7COLPXS8BUibPiPWAh5d30q
         bP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774008927; x=1774613727;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WBpgvBLWMC/0BhjOb7jBuNoEBM9BBGEAVw/zBHqxLZw=;
        b=G/ewrsnAvtvauCy9hlCtIsIyXmTfQIOvuMGUe2UruiWXNP1Hk4eoEeXTSbhCfBTQe5
         gOVrw22kA8VSjLQI5kAJHlGAzacT0pht4905zSzGBehK9ZBM4RxIQvQktijsz+uXCCUk
         nYLL6C1NDSKYx8UzHWGFWyg8slwShvXoOPeAHxLqFqrVG8F4ABm9fqmWkNV1Hpf6vBiy
         f/gqiWJQgh+uRRD6GkCe5uyByFAO72gd2uFyHpWa5xXc3JwUMZ8/4OiRuLJbKpDPx2hw
         ebv9VGJpeR41UFhdsrVELzH7a5Id3zcIZRorEWWVKup7RzTVvI+TKJFJF2qrVW6VH6rD
         yFWw==
X-Forwarded-Encrypted: i=1; AJvYcCVRUxxe+v+pXS2DdLqD5kva4RUQMxb7mfTgPmucHIoQYtK9UB6V2SQ/B3/HStFXX4SKk5I999udQzawoA==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy4zh90fzwbPuJ4yxRgatYq4QSNvnOu7leVdpAEVVE/UmXSswbe
	gR0sOzixEMIsX5OEXfPZluxxPCvW5SU+E5aoNbgEPm67EoK6LCFmxYAT64wcTLNhKxA4h9s0wZR
	JbHG2N7c4wfJ8DTBDGwN46sHfC0lZBIg=
X-Gm-Gg: ATEYQzwPcJoCE4XPObVYVletntKdOlfL1rn++Gubs7Wl6ZkxjMGt866/uluBiMG7Br4
	r5zuUxE0OkdEgFt3uxweZLYNPmf8fK7NRcqNbTWNQHn7sElT9vWjgw54GUN0jzM8HM7/3z4ldD3
	Y5E7LrWViY4xmSIE7Ig8+gz1sKQIkvYaUca3x4H1PQofPY/huY3Mkr4TdjfKvzUW1IXVklH5/Lo
	Bm7KV0Ze/qUtO8EfrKlculg/usHml9TCuY7TII8CK6vBupGN+z0TC46AK8k1PzXISUAZ7iUjyoM
	hZ1T2dCQEh3v6StmIKotqb24siZXiasFbBDyfN+E5Q==
X-Received: by 2002:a17:906:37cb:b0:b97:f2cc:8c3e with SMTP id
 a640c23a62f3a-b982f39b197mr137796766b.10.1774008926368; Fri, 20 Mar 2026
 05:15:26 -0700 (PDT)
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
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 20 Mar 2026 13:15:13 +0100
X-Gm-Features: AaiRm52styHcNjJqwA19Qyu0kuu9684XRXZIH06BjgsInXNVqvN-rIFPkHHA9M4
Message-ID: <CAOQ4uxjQzsFy2cS2Q9pL+NPBryHzoQdrjs4QdUNBpM_7GzukPA@mail.gmail.com>
Subject: Re: [PATCH] fs: allow vfs code to open an O_PATH file with negative dentry
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
	Gao Xiang <xiang@kernel.org>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com, 
	Paul Moore <paul@paul-moore.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-2880-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:viro@zeniv.linux.org.uk,m:miklos@szeredi.hu,m:xiang@kernel.org,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:syzbot+f34aab278bf5d664e2be@syzkaller.appspotmail.com,m:paul@paul-moore.com,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-0.979];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	TAGGED_RCPT(0.00)[linux-erofs,f34aab278bf5d664e2be];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 970EF2D9FC7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 7:30=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Thu, Mar 19, 2026 at 4:55=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
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
> >
>
> OK, will give it another try.
>

Christian,

I pushed another version of the syzbot ovl O_TMPFILE crash fix to:

https://github.com/amir73il/linux/commits/user_path_file/

In a nutshell, created a helper kernel_path_file_open()
instead of modifying do_dentry_open(), with a bit more magic in
ovl_tmpfile().

It's not super pretty, but at least it does not touch any non-backing_file
code paths, so maybe you will be ok with it.

Thanks,
Amir.

