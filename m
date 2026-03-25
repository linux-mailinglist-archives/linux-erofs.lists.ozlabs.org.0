Return-Path: <linux-erofs+bounces-3006-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPS5KzsdxGnlwQQAu9opvQ
	(envelope-from <linux-erofs+bounces-3006-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 18:36:59 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA09F329F2F
	for <lists+linux-erofs@lfdr.de>; Wed, 25 Mar 2026 18:36:58 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgvGw00Dcz2yY0;
	Thu, 26 Mar 2026 04:36:56 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::42a" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774460215;
	cv=pass; b=ELPBinQO1QVH3LwcYArab11V4QK5bPUgp8/y+Dq3ivyL3gqiC3AQlQl8LW+zVn+1+9/vyFsF2fT0eP1j/4JGIvZQLdlUttdeXLg3z2qP6r4VX4HIqXwRV61+/9ErHcDHYzqVETG6/ucK5v2DVhiyoxzcH8H5xu5BKGgBsA5khSWy9ZOEJmucVLg/0JqBKlfIWxET1wmBB2L+HEs7tQG9r7oW9qunrreTBQHpBIvSGbP4hnpGs2jQqF8XDwMEzrNPBWDYVgyeEeCKiXU0ndvArAtWYRXcgGJycgIXCcpXYMyuOJnJZZToZhFZKZHCtzzFj+HIFe3c4yzdSU43yBAPgg==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774460215; c=relaxed/relaxed;
	bh=560A6QjyhPKgUbe2CXEHtEc1ptAHKSEox2yVMb4TCwU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ooK1X9QUKNIZquXl9ACAMoDN6KpQMgF4Dr0sX72+G99bNwTOH16hLq9/hVvTRzc8ID0PqNimrt+K2pmR30WApUjfPfgtpc6HFBdRP9m2h2SP7ri2RX9iaPlVsDtiOntlt8W9iqGVSDr/2Ox9jA9lJsVYsUfizvjo8F+e5wKVB2oZJ3jfT0M47bVxzchw9TWOCPAXS1bazRJuiqxTEQRuaZ33rxTNdFxGSy1fLOqUbX1uEE+89extVhw3uPJpd2wYV9I1Tmf2+4VCp7IOG21Zonq6DbtkHF5iTRnVAxyJ06mpaKqmByGOlVapAbeYO610LSt9Vadhyk7HKKvk18kIRQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ZuUNqArP; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org) smtp.mailfrom=paul-moore.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ZuUNqArP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=paul-moore.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=paul@paul-moore.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgvGt29ZKz2yVL
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 04:36:53 +1100 (AEDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-8298fad2063so73011b3a.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 25 Mar 2026 10:36:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774460210; cv=none;
        d=google.com; s=arc-20240605;
        b=GQy1hBbNcluEHWHZWs/2LYQxgDj9GGxY2jcpJe6niX2BQ7zDw2dn1ZW49tB76QyXWl
         qLqgf5+Jc29WWmvtXQzyRRZElhxaZmorkjFJiua0xORLAjNIUNTWYyOdOQ7kqJnjpvbL
         2O2v2zh/jDi7+VldxKydJDYOndJLAv8XWehDVAsSgf/6vDkzHIzJu5k9gtA4LmXagXvZ
         9zCo0o7QqislkPCtvihz0+H23jsnzyL9riJoWWu8UMfsIuaLxeKow2epn8IHTIpGfnpF
         WHT9lDOGdRCdMdp9oHVnnP0ldmoknl3ZCO2GMlLR4PnTL6V6aKJAN4xkz0eI+IAa+IPA
         Fl1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=560A6QjyhPKgUbe2CXEHtEc1ptAHKSEox2yVMb4TCwU=;
        fh=zT1NlagizopyUzw6GjH6kadD2sdVKILxnuA+mGVnOKc=;
        b=KOqYtMPitLRoVMVFL/BtO05QQDAtoctN2sIByJ/uF8UKtJEYtQC7bVCtLZnvQpD/ZZ
         4PPievScgZHncmvXgqDHaygTC7CV3s8qvOJbNfdlpZzQr/XeqnEQivprUnMcuADvPYE6
         3A+xp5+X3wsHuK30GnVtNXrdRd2F3U1fl9crfRu3XD1WZPxK3Dcf9KXJXgx8RkEI4AVI
         JA5XnUvW6CQAtVSc+Gta1Qcy+PUD4A45T7bDedZujuaAvrGgVsFpdLuk/R7NhG/+ZB//
         j41HFHGrofTHhUD4O5MxRwx0hAgIOLJHPqAfCaSmO6p73ksDq14r4bUwO+kKmq+LhmFl
         VGrg==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1774460210; x=1775065010; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=560A6QjyhPKgUbe2CXEHtEc1ptAHKSEox2yVMb4TCwU=;
        b=ZuUNqArPqZ3YCiYDn1FdUOQwQgbniGIDbb4Zc/dbRU+pUyE3JjNE8BD32gMSJijvw1
         JLwkqh0Ab2hdm6MVMcdc8D+axdXBA2bV/PmnW4Ap+S1O/+gG2bULWu04kqOJiK5ItoOv
         NzB94ZzSz1YIYf0Wevqwe2mWBw6W271CTxEOPc8yqS8e/OxIXq3cokn9QSoEX0AothQt
         XDj22AlPnbC/P3sCXKQHVsPV0RDPb0uVLakdeRTK6qL9V849aAZD3adiWSB4/Y+8wbXP
         VKEAXRWMvfjfOa70150YsArPJv6Zm+BXsM70VvNTwn7e9hmL/OWCZ42OyEEIc1oobYh7
         4LzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774460210; x=1775065010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=560A6QjyhPKgUbe2CXEHtEc1ptAHKSEox2yVMb4TCwU=;
        b=tYDKlZtB7B4vazUdt9NwPdXHy0utPdIOhPJT5qmn0vMJacFoXyxHaFN7ZLPpSCGsW+
         QWSSR6wKH67Mn/WcE5D0vN641lxjRLSXBBuijrju7U4+H/dxB/iWHnUV6lGe/ynCJmxD
         If1fbr4BCqPTVftPYSoYPKU2r2HgZW5ZJhrCb82+Ey9P6jPv81oUHw6K0Mvl5zpwU3nX
         KHnRNXMQsIvbphsnec+19YJwiPkD3VXV2yyYip0gh7dBb3ZFf7hf+td9CP1l1/0gGk/Q
         EvL+bDh4SuUhAcCY4F/PQcQGK4ALkHHV2J57V0yYyOyqgADt3dgvfFvE8Qvu9bFnFKmu
         /R7g==
X-Forwarded-Encrypted: i=1; AJvYcCXEaGVSqpx07VlLVL6fGByY+TsI6YnsQf4TcbEO8WWv2sg0orClGIeewAQphS/Rx0tdvdTyvcBq5Z6p0w==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyMYQTFKfl8zhg8U2U+s/yEx6AaWmkozeOYcqvMAj89lL64iYpl
	zcqeV2h73+GXAizFEZp2ossh6jXBvWydBvoVk5RVnfRIkff2tCovUve+aB9CgluO/7wNqZxSsHT
	C7ymRCxeeI3ueSQY7ph9bBXtgl5r7L2RRx3XZ3mZX
X-Gm-Gg: ATEYQzxmXrnITQapsOZqGXBpCUgYSR00Q9Sm1mUZaXSSJZbwPmvz9aJdWo7MPljPUh6
	4g3wO9677pZjHoA04suwYZ/ymW2c9sD+iBeYNwxJbSTWw50/LMoKaKEaWDBjDtgNAW58OPGTtrL
	N+FEP4uNCEIFFv9aGFB9xEebPPYFpsAZlLtqNzcL5KkBEdNLynsxEPCIPmd05REjj5Qt9MXipvn
	yQJPI+B87U5wWQ+CdmHDbsLz7vyYpTqts64H2xEIb13KjpS6Yw1TG44GYxpKZN4GmbTXF3/pl+C
	e76IlNk=
X-Received: by 2002:a05:6a00:4219:b0:827:2ee0:411f with SMTP id
 d2e1a72fcca58-82c6de7aa7cmr3962195b3a.4.1774460210073; Wed, 25 Mar 2026
 10:36:50 -0700 (PDT)
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
References: <20260323042510.3331778-4-paul@paul-moore.com> <20260323042510.3331778-5-paul@paul-moore.com>
 <CAKCV-6t=m-8eu1xoTORnLwhG4kQB5u1v5diJDQDFcat=tH8WgA@mail.gmail.com>
In-Reply-To: <CAKCV-6t=m-8eu1xoTORnLwhG4kQB5u1v5diJDQDFcat=tH8WgA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 25 Mar 2026 13:36:37 -0400
X-Gm-Features: AaiRm53RXGI_5fUjjLSR_a0KxLZyxKMzyTIPSX8PFvRbx9JxRVkJ2AR_0Hlvr9w
Message-ID: <CAHC9VhRNOGk0dGERbD+RRLTWebZu1-7cbvB0a2D0njbnqBRNXQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/2] lsm: add backing_file LSM hooks
To: Ryan Lee <ryan.lee@canonical.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-erofs@lists.ozlabs.org, Amir Goldstein <amir73il@gmail.com>, 
	Gao Xiang <xiang@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3006-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS(0.00)[m:ryan.lee@canonical.com,m:linux-security-module@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-unionfs@vger.kernel.org,m:linux-erofs@lists.ozlabs.org,m:amir73il@gmail.com,m:xiang@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[paul@paul-moore.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.ozlabs.org,gmail.com,kernel.org];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,mail.gmail.com:mid,canonical.com:email]
X-Rspamd-Queue-Id: BA09F329F2F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 7:01=E2=80=AFPM Ryan Lee <ryan.lee@canonical.com> w=
rote:
>
> Hi Paul,
>
> I'm currently looking at the patch more closely to implement the hooks
> for AppArmor, but here are some typofixes and the like below:

Thanks Ryan, I appreciate the extra eyes.

> > diff --git a/include/linux/security.h b/include/linux/security.h
> > index 83a646d72f6f..1e4c68d5877f 100644
> > --- a/include/linux/security.h
> > +++ b/include/linux/security.h                          unsigned long p=
rot);
> > @@ -1140,6 +1146,15 @@ static inline void security_file_release(struct =
file *file)
> >  static inline void security_file_free(struct file *file)
> >  { }
> >
> > +int security_backing_file_alloc(void **backing_file_blobp,
> > +                               const struct file *user_file)
> > +{
> > +       return 0;
> > +}
> > +
> > +void security_backing_file_free(void **backing_file_blobp)
> > +{ }
> > +
>
> Should these two placeholders be static inline functions, like the
> other ones around them?

Yes :)  The kernel test robot found the same problem yesterday, I've
already fixed it in my working branch.

> > diff --git a/security/lsm_init.c b/security/lsm_init.c
> > index 573e2a7250c4..020eace65973 100644
> > --- a/security/lsm_init.c
> > +++ b/security/lsm_init.c
> > @@ -293,6 +293,8 @@ static void __init lsm_prepare(struct lsm_info *lsm=
)
> >         blobs =3D lsm->blobs;
> >         lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
> >         lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
> > +       lsm_blob_size_update(&blobs->lbs_backing_file,
> > +                            &blob_sizes.lbs_backing_file);
> >         lsm_blob_size_update(&blobs->lbs_ib, &blob_sizes.lbs_ib);
> >         /* inode blob gets an rcu_head in addition to LSM blobs. */
> >         if (blobs->lbs_inode && blob_sizes.lbs_inode =3D=3D 0)
> > @@ -441,6 +443,8 @@ int __init security_init(void)
> >         if (lsm_debug) {
> >                 lsm_pr("blob(cred) size %d\n", blob_sizes.lbs_cred);
> >                 lsm_pr("blob(file) size %d\n", blob_sizes.lbs_file);
> > +               lsm_pr("blob(backing_file) size %d\n",
> > +                      blob_sizes.lbs_backing_file);
> >                 lsm_pr("blob(ib) size %d\n", blob_sizes.lbs_ib);
> >                 lsm_pr("blob(inode) size %d\n", blob_sizes.lbs_inode);
> >                 lsm_pr("blob(ipc) size %d\n", blob_sizes.lbs_ipc);
> > @@ -462,6 +466,11 @@ int __init security_init(void)
> >                 lsm_file_cache =3D kmem_cache_create("lsm_file_cache",
> >                                                    blob_sizes.lbs_file,=
 0,
> >                                                    SLAB_PANIC, NULL);
> > +       if (blob_sizes.lbs_backing_file)
> > +               lsm_backing_file_cache =3D kmem_cache_create(
> > +                                                  "lsm_backing_file_ca=
che",
> > +                                                  blob_sizes.lbs_file,=
 0,
> > +                                                  SLAB_PANIC, NULL);
>
> Shouldn't blob_sizes.lbs_file here be blob_sizes.lbs_backing_file instead=
?

Good catch, thank you!  I'll have the fix in the next posting.  I'm
hoping to do some more testing today/tomorrow and post a non-RFC patch
by the end of the week.  If you find anything else that looks awry, or
just doesn't work, please let me know.

--=20
paul-moore.com

