Return-Path: <linux-erofs+bounces-3060-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SATdNUYDyGnugAUAu9opvQ
	(envelope-from <linux-erofs+bounces-3060-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 17:35:18 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAB534F2D5
	for <lists+linux-erofs@lfdr.de>; Sat, 28 Mar 2026 17:35:16 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fjjmD33t3z2ySc;
	Sun, 29 Mar 2026 03:35:08 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::529" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774715708;
	cv=pass; b=FYkXYP9/+zAKN/NVuRZItgqGGHoeTAmbJsNMQClAx3Y+2o5j0yl+TeMvfFXflW/4ZuYawE5WSOv7erM8iHUR0AAdKZQFGxYRH9MYAJL2XftfInduiLbbh17PlON+E0bOmkRzBlxMmn2yr0AnTJ1fclOTxJ0lt6ejpaAxbbTnTmEwJ8WclOo07TAap9zmdgzRtTijVlUAXIeAfY+OBE82kGuHQXNjhfeTfYJajkGHU8x25z0xJm1uP0ANtLBws1LA8wbOpT7zHs3IW9WXWEjg4aYVQXdXBNPLTVWFttS4WFggSHDUlXdghegu+YqGEZ6QzDfIHAESXRSszSOczceKfA==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774715708; c=relaxed/relaxed;
	bh=Ususnq+NIOoRs4YDsb/bU1UpkObKkRjHaCrFz3SAoog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M58D+PIJ6bJU2h8myqrn+sG8GELn/R7CVm3plJ7hoi9VnwvhUynzn9DwDgnD7fIRwvD77gkHumif5GjeanTLL3IRHS2ivrM2gLbW85glgLH1dqGjO0yyu/FE3maltvS5VwDx8es7fIAcLnaVx6Kjo3ug9ifyU4YKcG+mEJ8yZEbYlji5Ni2dw9llbPbKu2DxvkH0I6dwP/DElB8QPOAZPiXvSkAeQnDXIt16qORUn4fpDtOl4wyE+taqKJGeZvv5/CCANPYs9MlBmyWKt5WXylGg+LzQHv1/FbA35HCWY8PuixmotXURaEKA5yYCBsrTVhbw8rbKyTOyI/tg2fmhFg==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Xz0E42uU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Xz0E42uU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fjjmB68Gwz2xN8
	for <linux-erofs@lists.ozlabs.org>; Sun, 29 Mar 2026 03:35:05 +1100 (AEDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-c7393536e53so1231962a12.2
        for <linux-erofs@lists.ozlabs.org>; Sat, 28 Mar 2026 09:35:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774715702; cv=none;
        d=google.com; s=arc-20240605;
        b=XpTNZ/bSfgcVFN6us42HR48qv5aHZpWzjnALvecp8r6gqBbtm6l4N9FyunRdUwQXkB
         rxeZC57ROILqNw82jTn+ovVTDe/AkxzeFTHAodYpQ6NGiJREGq1sGfjyCdq/R1WwEs2I
         rHH8Y6rOi0diQItq03kOKCj8lTfm9zherK5Px5FXObCGEPwa9rI/0raNch+/mdePxq0h
         NO3Or1cgCT4MTNHoefFHbPBUbrC0f2VblUcRpizPMz7Akf/FGxCaQb0RQOzZvRJZYIAX
         F9/zxGI5ZnHVOvzGj3aZ+cgT1FvkdkpFv7L54XDCuNptGXop3yiHoFMEEu8IK5TBO/Dd
         aPbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ususnq+NIOoRs4YDsb/bU1UpkObKkRjHaCrFz3SAoog=;
        fh=kYb8zdpBm9LaO/JP1oFdJua+4wmQR76EVR1d7Gfa0mU=;
        b=Zq2+4fZxjEEYhwputKMah86KDm/gyp1oz/vKJ6igeh9nHXZoYMyRvvtKKzWs0rhn9q
         rrxAl7yd4Sk5fJgbdy5iC5JD2iSEwIHqPJCQIKqVqArTwc0hzCECVe3QW10OszqDQd2K
         Snk/88DHmZN9BvwuoT2VjxwFx3Itie9gXK1+KLAQJIuGLeDmyJLUjTtzE1PYgbHv1Gk+
         0XUadCqxoL/pgme1Y52PXTgD0kBl67bhnd26tdUYgHt2/KXcqc7/koIMvO7Do/ZtV/T1
         1XIy5IFk2O0nuv+CvLROLFXSmaAZfN/sFoZZvBvrEhyqPpgmODdzRoakFfrYeOlbz2GW
         Qj5Q==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774715702; x=1775320502; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ususnq+NIOoRs4YDsb/bU1UpkObKkRjHaCrFz3SAoog=;
        b=Xz0E42uUTR+M0wF4SuSRUhYeg19TPOgou6fdS37Cnaio85Fwd7NEn6HfsPk6nEgrr2
         PWon729pAqcsj8RMM8ZTknYISbkndLLsAqd9TNv1RVd9a3Is9yggoEiXN0NW5X3QsqiO
         ZX29eGwjuuVo0wh6hbsx4JZf5Y+5Gftn5NfE0wD/daczz2OUOqLCAjoaWgrcMQlVw88N
         Gn3hFVr8LqVmZPHmP6URGUn3CkwKQvcGY4CyhMe9TNYNPqzUkhdg8d0oSiRDGCwqSuk4
         rlGEeLftT+rK5bw0qZOhNeIpsAaaAT+HOsvp8ET/MK5UePa1g0o71gfgA1BV1XRpSUUh
         /Zlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774715702; x=1775320502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ususnq+NIOoRs4YDsb/bU1UpkObKkRjHaCrFz3SAoog=;
        b=axmZtVMyQGBNhvTB8boMFOq3CzVbMNpDK9uPU3lo8WuCCwY//ekqy2bCQxm3R8wzfz
         0zcUfHIxid85taYN6YPohPFHOfO51fWJbGmBndk84fNPXC8eun4Qt9YXnAOxblxUnYRU
         RJdDBPe0xFT/fID8Yneh1UD8mYih7qiJva8aMHOXLYrJhzSLjT9nZnEi4/0i/ZZRMp4J
         rwtKkrZ/fozyKU84T5Okj2wJ1mOt6DVqAvWat0P5+a6BedHJTUWusjQVzVXZjNbOig6V
         Wv1Jbc2AZFrBSlAZwPChm7nnLsaSaqHNUfINKqVM2z4pl6b+ETGgYWCf3V2Q5/qCVpdI
         h0LQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8q2reMSXrpjxQM6wijZc/eIF1Na+2LSEGBzNoJZSnsXpfqsU2HHqTOp4Nie8qtQlh7vu8bXsHdiV69Q==@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxwt+jCklzoipXHyFWK9gs5/8667TuByLbSuAwyCRJBga+D/msS
	5nRHF5UhIK9arZrkKL4YFx/SiIwRzjhagolzk/vuZ2AAIsMncpXk523E7ILyN0UMf6sBS2rclBk
	u6sdEAPV+grB2KonexVNIDOdNowViZil4kC2pdxil
X-Gm-Gg: ATEYQzwHGWCzbzffd9K21GlhvSMWGudRCHu8zgT9Wd6sCs4pbTLDDK1zt10urEM6hPp
	As+YmgAFGfIayoLP8fcxHH5hPrJMLlaMaf4zB3F8lMay46klTkPAOylI2JKd3Rymf0qEC2e0ewB
	v7tbtOAiIxttHRLCfqTqGHvVq1gyjO7Lwjk43PAxg+Gk4ZPWf/vsEpIBf6kHvMRtxiGBEjMYY8V
	aoZ+2oLoE8XHhdguAtRyiQGdCmZIUeBLQyOVgoWLJhsw2hN8ia/ynQGZcG2zpn+em2PpbEZkiFv
	j3ZaDh8=
X-Received: by 2002:a17:902:e812:b0:2b0:5fa0:3afa with SMTP id
 d9443c01a7336-2b0cdc9ef75mr73151175ad.27.1774715702275; Sat, 28 Mar 2026
 09:35:02 -0700 (PDT)
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
References: <20260327220446.353103-4-paul@paul-moore.com> <20260327220446.353103-5-paul@paul-moore.com>
 <CAOQ4uxjvCYRLcRM-JGgtCPXKRB1agCBacN1tmR7hDR9TLdVS4w@mail.gmail.com>
In-Reply-To: <CAOQ4uxjvCYRLcRM-JGgtCPXKRB1agCBacN1tmR7hDR9TLdVS4w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 28 Mar 2026 12:34:50 -0400
X-Gm-Features: AQROBzCPb0SK1-R-ZrfrAvua_40DjlegqsKhZho-n3cMPQ3__jjQot92OFc74FM
Message-ID: <CAHC9VhQQZ69LAGZE2DSyM_qidTJ8oGfqSSvysrO6r9BAXW9mkQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] lsm: add backing_file LSM hooks
To: Amir Goldstein <amir73il@gmail.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Gao Xiang <xiang@kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=ARC_SIGNED,ARC_VALID,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[paul-moore.com,none];
	R_DKIM_ALLOW(-0.20)[paul-moore.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:amir73il@gmail.com,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:xiang@kernel.org,m:brauner@kernel.org,m:miklos@szeredi.hu,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3060-lists,linux-erofs=lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	DKIM_TRACE(0.00)[paul-moore.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,paul-moore.com:dkim,paul-moore.com:email,paul-moore.com:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 7FAB534F2D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 28, 2026 at 4:29=E2=80=AFAM Amir Goldstein <amir73il@gmail.com>=
 wrote:
> On Fri, Mar 27, 2026 at 11:05=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> >
> > Stacked filesystems such as overlayfs do not currently provide the
> > necessary mechanisms for LSMs to properly enforce access controls on th=
e
> > mmap() and mprotect() operations.  In order to resolve this gap, a LSM
> > security blob is being added to the backing_file struct and the followi=
ng
> > new LSM hooks are being created:
> >
> >  security_backing_file_alloc()
> >  security_backing_file_free()
> >  security_mmap_backing_file()
> >
> > The first two hooks are to manage the lifecycle of the LSM security blo=
b
> > in the backing_file struct, while the third provides a new mmap() acces=
s
> > control point for the underlying backing file.  It is also expected tha=
t
> > LSMs will likely want to update their security_file_mprotect() callback
> > to address issues with their mprotect() controls, but that does not
> > require a change to the security_file_mprotect() LSM hook.
> >
> > There are a two other small changes to support these new LSM hooks.  We
> > pass the user file associated with a backing file down to
> > alloc_empty_backing_file() so it can be included in the
> > security_backing_file_alloc() hook, and we constify the file struct fie=
ld
> > in the LSM common_audit_data struct to better support LSMs that need to
> > pass a const file struct pointer into the common LSM audit code.
> >
> > Thanks to Arnd Bergmann for identifying the missing EXPORT_SYMBOL_GPL()
> > and supplying a fixup.
> >
> > Cc: stable@vger.kernel.org
> > Acked-by: Christian Brauner <brauner@kernel.org>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
>
> I 100% agree with Christian.
> This is much better than my O_PATH file hack

I'm not surprised that both you and Christian prefer this solution, it
moves all the pain of resolving this issue to the individual LSMs.
Just look at how the SELinux code has changed, even trying to pretty
it up as best as possible, it's objectively much uglier now, not to
mention more complicated.

From my perspective the root cause of this issue lies in the
overlayfs/backing-file design, specifically how overlayfs hides
multiple files under a single file so that it can plug into the
existing VFS/userspace paradigm of a single file.  While the design
and abstraction are no doubt very clever things, and for the most part
they "just work", there are definitely some corner cases that require
special handling, e.g. LSM access controls around mprotect().  In my
opinion, the burden of hiding any ugliness associated with this
special handling lies with the subsystem implementing the abstraction,
which is why I was pushing for a solution where the VFS and/or
backing-file layer would provide the user file (or a stand-in) for the
LSMs to use.  Unfortunately, that was not something the overlayfs and
VFS communities were willing to tolerate, so those of us in the LSM
space were left with a terrible choice: accept that the overlayfs/VFS
folks don't care and hack around the shortcomings of overlayfs, or
leave a public vulnerability for an unknown period of time while the
overlayfs/VFS folks argue over a solution, with the a non-trivial
chance that the LSMs would need to hack around the problem anyway.

That's my view of were things were at, and why I begrudgingly took
this approach.  I'm sure you have your own perspecitve, and I'm not
going to be surprised if you view this primarily as a LSM problem;
it's a common viewpoint amongst Linux kernel maintainers not
responsible for a LSM.

> It is also what Miklos had initially suggested.

Perhaps I've lost the mail, but going back to when this issue was
first discovered, I don't see anything from Miklos relating to this in
either my inbox or the mailing lists.

> > diff --git a/fs/file_table.c b/fs/file_table.c
> > index aaa5faaace1e..0bdc26cae138 100644
> > --- a/fs/file_table.c
> > +++ b/fs/file_table.c
> > @@ -50,6 +50,7 @@ struct backing_file {
> >                 struct path user_path;
> >                 freeptr_t bf_freeptr;
> >         };
>
> Shouldn't we wrap this with
> #ifdef CONFIG_SECURITY

Sure, I'll change that.

> > +       void *security;
>
> please initialize it in init_file()

We lack a clean way to access the backing_file struct in init_file().
I placed the security_backing_file_alloc() initializer in
alloc_empty_backing_file() as it was the first place where we could
both allocate the necessary LSM blob and initialize it with the data
from the user file at the same time.

If you want to intialize backing_file->security in init_file(),
init_file() we will need to add a FMODE_BACKING check in init_file and
split the security_backing_file_alloc() hook into two: one in
init_file() to do the allocation and basic init, one in
alloc_empty_backing_file() to capture the necessary user file data.

Do you still prefer to move the backing_file->security initializtion
into init_file()?

> > +void *backing_file_security(const struct file *f)
> > +{
> > +       return backing_file(f)->security;
>
> I think LSM code should be completely responsible for this ptr
> assignment/free so you should export
>
> void **backing_file_security_ptr(const struct file *f)
> {
>        return &backing_file(f)->security;
> }

Doing so would require us to also move the backing_file struct
definition into include/linux/backing-file.h (or similar), which I
tried very hard to avoid as I suspected you would not approve of that.
I figured if you had wanted to expose the struct definition you would
have defined it in backing-file.h as opposed to file_table.c.

Would you like me to move the backing_file struct definition into
include/linux/backing-file.h?

> > @@ -73,8 +79,11 @@ static inline void file_free(struct file *f)
> >                 percpu_counter_dec(&nr_files);
> >         put_cred(f->f_cred);
> >         if (unlikely(f->f_mode & FMODE_BACKING)) {
> > -               path_put(backing_file_user_path(f));
> > -               kmem_cache_free(bfilp_cachep, backing_file(f));
> > +               struct backing_file *ff =3D backing_file(f);
> > +
> > +               security_backing_file_free(&ff->security);
>
> Why do you need to add this in vfs code?
>
> Can't you do the same in security_file_free(f)?
>         if (unlikely(f->f_mode & FMODE_BACKING))
>                 security_backing_file_free(backing_file_security_ptr(f));

See my comments above regarding the visibility of the backing_file struct.

> > +               path_put(&ff->user_path);
> > +               kmem_cache_free(bfilp_cachep, ff);
> >         } else {
> >                 kmem_cache_free(filp_cachep, f);
> >         }
> > @@ -290,7 +299,8 @@ struct file *alloc_empty_file_noaccount(int flags, =
const struct cred *cred)
> >   * This is only for kernel internal use, and the allocate file must no=
t be
> >   * installed into file tables or such.
> >   */
> > -struct file *alloc_empty_backing_file(int flags, const struct cred *cr=
ed)
> > +struct file *alloc_empty_backing_file(int flags, const struct cred *cr=
ed,
> > +                                     const struct file *user_file)
> >  {
> >         struct backing_file *ff;
> >         int error;
> > @@ -306,6 +316,11 @@ struct file *alloc_empty_backing_file(int flags, c=
onst struct cred *cred)
> >         }
> >
> >         ff->file.f_mode |=3D FMODE_BACKING | FMODE_NOACCOUNT;
> > +       error =3D security_backing_file_alloc(&ff->security, user_file)=
;> +       if (unlikely(error)) {
> > +               fput(&ff->file);
> > +               return ERR_PTR(error);
> > +       }
> >         return &ff->file;
> >  }
> >  EXPORT_SYMBOL_GPL(alloc_empty_backing_file);
>
> Maybe, and I am not sure,
> alloc_empty_backing_file() should call ONLY
>             error =3D security_backing_file_alloc(&ff->file, user_file);
>
> Instead of security_file_alloc() AND security_backing_file_alloc()
> and security_backing_file_alloc() can make use of
> backing_file_security_ptr() accessor internally?

This is another case of the code being structured so that we don't
need to expose the backing_file struct definition to the LSMs.  If you
would prefer to expose the backing_file struct in include/linux I can
probably make a few additional simplifications to the code.

--=20
paul-moore.com

