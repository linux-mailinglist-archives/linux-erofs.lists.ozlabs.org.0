Return-Path: <linux-erofs+bounces-3033-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK6lCSUPxWkI6AQAu9opvQ
	(envelope-from <linux-erofs+bounces-3033-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 11:49:09 +0100
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 36952333C0C
	for <lists+linux-erofs@lfdr.de>; Thu, 26 Mar 2026 11:49:08 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhL9s5ggsz2yhG;
	Thu, 26 Mar 2026 21:49:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774522145;
	cv=none; b=ivgdBcIvMf4PK1eKV8yf3MYP/Ua4kaF/LScO4IEgIJNmZIS/E/OUZR8w7pLavG3rIglMQhtQxYe8I8KtN7Zq5yD3oOvKi8nh4tpv3mBjDFqXihARo3Q37fSJCgb0/FobTTDQnLSCPyyesUB1BUoiK1574ido9dtWfBPw6FTgMjG/vpXsrinWM2xVhwa5XgycAbpnWWYu7ca4FtUqtfDiOImp5EZg8ylOQmmjkone5CA849/PLTXZn9IRL7E6kHOkVgrrZyqZT25ZFi2b1fj1inpGqpfYTJJbN0BrPdaEvumCk4JBOposcdzudRPm6emImUGIs+Am1iBDklcEy8iV0g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774522145; c=relaxed/relaxed;
	bh=Mn1xHOZ5T8WKdwjK43BW3DNavK71FNOkzxdS3qUbBYU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NvhBSfYRAD5ioBAQTI438afqrUvbSCEsjqZzHEiroF2tRE4I5z9e9SyarrsAxSsFyCcGInBmJhjnG1V4M7XEhVzXNPp6DnGWHn3aqUvJxFVRoUKX37wqeQpZpoCo6HSFX9OW0Hy8yb+aaPiVWZ2yNzeGhOeZUn7NGu5Hytmh9YBWMf1WyTw4JKYw+IyyiFDJ4d4Ll0CJ86WuNhoPp9kpZsLB72X5BCPNLQF7cLsRryCJp9K4yZd5RKstIQ3XP80NIhSYfUsqxGk8xKk34Tisei+6OSXWW1VCDcUChXPOEZ+3e6KkW1HXnGJRAIU4+34wLgGDUMlvyBbBhDsxeoPZTg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=adityakammati.me; spf=pass (client-ip=209.85.208.41; helo=mail-ed1-f41.google.com; envelope-from=adityakammati.workspace@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=adityakammati.me
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.208.41; helo=mail-ed1-f41.google.com; envelope-from=adityakammati.workspace@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhL9r5DlPz2xN8
	for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 21:49:04 +1100 (AEDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-667acaeae82so1347416a12.3
        for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 03:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774522140; x=1775126940;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mn1xHOZ5T8WKdwjK43BW3DNavK71FNOkzxdS3qUbBYU=;
        b=mXDY1FPtML8cCcCqTTF2TNl+BafkPtbIcR9hf3WbZfvdafpPnIQsBSdgDrOWv/mOkg
         jGfIb1qAnfsbTRsb5pgusmGbPAJY717liozP1bIw/qXRhYo7yapP17Glk1V29XPd0bZZ
         dzOrDr2onEAK3V8MjKqu/skMXvr+MMFhJOk2msLsWqiqH6Im7GwthtmjeIrFTWC0+JuQ
         yyoBk3AfTqmqXmg1D66kVJLbilS2s7JtigeAIOrXrl6ZIQQ/eWLvbX+8lLEJMCkJfYV2
         4fYjNsQ4tloftFeIFHEY3mk/wyxEKbaC3ok3m04G0mF/4wBJH95QGQ9Tk1+ywE7/iKwu
         Q5fg==
X-Forwarded-Encrypted: i=1; AJvYcCXP2CrRbSNYWeWYIWBp1K22c8+itmI3MjfQQZkCYGPtj/u3A9s/dPDwGIDgsyhj+2EIBU0pWhv41uU5nQ==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyIz/5h9C1asb3qlEUQAep+dd2+Ns/IpUHszqtSr/v2hiVhGnRC
	hyxUkBEgtNjvgxs9kmQ8UlEC4HKDy2ZKXTWZhF+lxA7g316yw2BVlKoFHATqki/B9L0=
X-Gm-Gg: ATEYQzxnrfdLDTDHGHx3LKcLM3mnwmGlvvW/QyQxBK6sBz/ZnmU1eT7GiLrhYLVRY0e
	ek0JmgunS+4AKfkxVyxFU7tZlUKfKdVmg6KE+3DMKsdYX3bGsROKK1/N5nZkUwN9jIqvp3027oh
	zW+HF0Z1uOjiMC8kcq7FQhYFKfCFyj8SM5G+MFyV2zhKD5fWVaG6BaP1IJyT+YDfpVOCjkr4ulJ
	dxt26m7pvEyaKB8pfNqD0equZJNkE2vpyY6gND0pXhotIx+0OSPix1LxbiO2T+B88D7pDJ9caLa
	FRThAvjVaxmqFrHl/mDIJKF1MSv0dPVaxc5lphEIIqRanxtDFROybBgZIZXThGBo5fNOudyAj2z
	9T5lSH3BPzMNoH4ANyNJv1IibexxO9tF9QBgCzVlqO/6UyrEXZJFhqb2cAx51afqv21bM/H7dbL
	t5Wmr0D6IYl9sd88wphuIb/gSuX2YSk9Yvba8x2QiU4AZc+3Yv35RY80IvWdECCzI6exlHrCvXK
	8sIDov72G/TKPAwtAcwrMZaxqlRk3OWeS+b3MlNQTQ=
X-Received: by 2002:a05:6402:400a:b0:663:d74e:9253 with SMTP id 4fb4d7f45d1cf-66a826e17dfmr5259197a12.30.1774522139955;
        Thu, 26 Mar 2026 03:48:59 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-66ad6a4c4b3sm845517a12.22.2026.03.26.03.48.58
        for <linux-erofs@lists.ozlabs.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 03:48:58 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b97a06d7629so112767366b.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 26 Mar 2026 03:48:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXuix2srh6+zm+BnF+ht1keNa4WZM/cbCV2brZQQ5E7eyy/MlRwtA2lwbGQwkQ5bfKOMZeiVTXsQO5jZw==@lists.ozlabs.org
X-Received: by 2002:a17:907:806:b0:b97:cc05:61b9 with SMTP id
 a640c23a62f3a-b9a3f19f050mr546569866b.15.1774522138260; Thu, 26 Mar 2026
 03:48:58 -0700 (PDT)
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
References: <20260326104544.509518-1-dhowells@redhat.com> <20260326104544.509518-8-dhowells@redhat.com>
In-Reply-To: <20260326104544.509518-8-dhowells@redhat.com>
From: Aditya <dev@adityakammati.me>
Date: Thu, 26 Mar 2026 16:18:46 +0530
X-Gmail-Original-Message-ID: <CA+yaA_=gpTnueByzFNYrqNL_qSC2rE4iGDjLHtJap-=_rhE3HQ@mail.gmail.com>
X-Gm-Features: AQROBzAXov3KNbV6FNafWthVKp5kTPNbjxUaNaGD8qgMiIq26Xy5U1VILZdh43E
Message-ID: <CA+yaA_=gpTnueByzFNYrqNL_qSC2rE4iGDjLHtJap-=_rhE3HQ@mail.gmail.com>
Subject: Re: [PATCH 07/26] cachefiles: Fix excess dput() after end_removing()
To: David Howells <dhowells@redhat.com>
Cc: Christian Brauner <christian@brauner.io>, Matthew Wilcox <willy@infradead.org>, 
	Christoph Hellwig <hch@infradead.org>, Paulo Alcantara <pc@manguebit.com>, Jens Axboe <axboe@kernel.dk>, 
	Leon Romanovsky <leon@kernel.org>, Steve French <sfrench@samba.org>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Eric Van Hensbergen <ericvh@kernel.org>, Dominique Martinet <asmadeus@codewreck.org>, 
	Ilya Dryomov <idryomov@gmail.com>, Trond Myklebust <trondmy@kernel.org>, netfs@lists.linux.dev, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org, v9fs@lists.linux.dev, 
	linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, NeilBrown <neil@brown.name>, 
	Paulo Alcantara <pc@manguebit.org>
Content-Type: multipart/alternative; boundary="000000000000b27dd5064deb21a2"
X-Spam-Status: No, score=0.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.50 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:112.213.38.117:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[multipart/alternative,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[adityakammati.me];
	FREEMAIL_CC(0.00)[brauner.io,infradead.org,manguebit.com,kernel.dk,kernel.org,samba.org,chenxiaosong.com,auristor.com,codewreck.org,gmail.com,lists.linux.dev,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,brown.name,manguebit.org];
	TAGGED_FROM(0.00)[bounces-3033-lists,linux-erofs=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:christian@brauner.io,m:willy@infradead.org,m:hch@infradead.org,m:pc@manguebit.com,m:axboe@kernel.dk,m:leon@kernel.org,m:sfrench@samba.org,m:chenxiaosong@chenxiaosong.com,m:marc.dionne@auristor.com,m:ericvh@kernel.org,m:asmadeus@codewreck.org,m:idryomov@gmail.com,m:trondmy@kernel.org,m:netfs@lists.linux.dev,m:linux-afs@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:ceph-devel@vger.kernel.org,m:v9fs@lists.linux.dev,m:linux-erofs@lists.ozlabs.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:neil@brown.name,m:pc@manguebit.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[dev@adityakammati.me,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dev@adityakammati.me,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:112.213.32.0/21, country:AU];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,auristor.com:email,mail.gmail.com:mid,brown.name:email,manguebit.org:email,infradead.org:email,lists.ozlabs.org:helo,lists.ozlabs.org:rdns]
X-Rspamd-Queue-Id: 36952333C0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000b27dd5064deb21a2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Why are this bulk fixes

On Thu, 26 Mar 2026 at 4:17=E2=80=AFPM, David Howells <dhowells@redhat.com>=
 wrote:

> When cachefiles_cull() calls cachefiles_bury_object(), the latter eats th=
e
> former's ref on the victim dentry that it obtained from
> cachefiles_lookup_for_cull().  However, commit 7bb1eb45e43c left the dput
> of the victim in place, resulting in occasional:
>
>   WARNING: fs/dcache.c:829 at dput.part.0+0xf5/0x110, CPU#7:
> cachefilesd/11831
>   cachefiles_cull+0x8c/0xe0 [cachefiles]
>   cachefiles_daemon_cull+0xcd/0x120 [cachefiles]
>   cachefiles_daemon_write+0x14e/0x1d0 [cachefiles]
>   vfs_write+0xc3/0x480
>   ...
>
> reports.
>
> Actually, it's worse than that: cachefiles_bury_object() eats the ref it
> was
> given - and then may continue to the now-unref'd dentry it if it turns ou=
t
> to
> be a directory.  So simply removing the aberrant dput() is not sufficient=
.
>
> Fix this by making cachefiles_bury_object() retain the ref itself around
> end_removing() if it needs to keep it and then drop the ref before
> returning.
>
> Fixes: bd6ede8a06e8 ("VFS/nfsd/cachefiles/ovl: introduce start_removing()
> and end_removing()")
> Reported-by: Marc Dionne <marc.dionne@auristor.com>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: NeilBrown <neil@brown.name>
> cc: Paulo Alcantara <pc@manguebit.org>
> cc: netfs@lists.linux.dev
> cc: linux-afs@lists.infradead.org
> cc: linux-fsdevel@vger.kernel.org
> ---
>  fs/cachefiles/namei.c | 36 +++++++++++++++++++++---------------
>  1 file changed, 21 insertions(+), 15 deletions(-)
>
> diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
> index e5ec90dccc27..20138309733f 100644
> --- a/fs/cachefiles/namei.c
> +++ b/fs/cachefiles/namei.c
> @@ -287,14 +287,14 @@ int cachefiles_bury_object(struct cachefiles_cache
> *cache,
>         if (!d_is_dir(rep)) {
>                 ret =3D cachefiles_unlink(cache, object, dir, rep, why);
>                 end_removing(rep);
> -
>                 _leave(" =3D %d", ret);
>                 return ret;
>         }
>
>         /* directories have to be moved to the graveyard */
>         _debug("move stale object to graveyard");
> -       end_removing(rep);
> +       dget(rep);
> +       end_removing(rep); /* Drops ref on rep */
>
>  try_again:
>         /* first step is to make up a grave dentry in the graveyard */
> @@ -304,8 +304,10 @@ int cachefiles_bury_object(struct cachefiles_cache
> *cache,
>
>         /* do the multiway lock magic */
>         trap =3D lock_rename(cache->graveyard, dir);
> -       if (IS_ERR(trap))
> -               return PTR_ERR(trap);
> +       if (IS_ERR(trap)) {
> +               ret =3D PTR_ERR(trap);
> +               goto out;
> +       }
>
>         /* do some checks before getting the grave dentry */
>         if (rep->d_parent !=3D dir || IS_DEADDIR(d_inode(rep))) {
> @@ -313,25 +315,27 @@ int cachefiles_bury_object(struct cachefiles_cache
> *cache,
>                  * lock */
>                 unlock_rename(cache->graveyard, dir);
>                 _leave(" =3D 0 [culled?]");
> -               return 0;
> +               ret =3D 0;
> +               goto out;
>         }
>
> +       ret =3D -EIO;
>         if (!d_can_lookup(cache->graveyard)) {
>                 unlock_rename(cache->graveyard, dir);
>                 cachefiles_io_error(cache, "Graveyard no longer a
> directory");
> -               return -EIO;
> +               goto out;
>         }
>
>         if (trap =3D=3D rep) {
>                 unlock_rename(cache->graveyard, dir);
>                 cachefiles_io_error(cache, "May not make directory loop")=
;
> -               return -EIO;
> +               goto out;
>         }
>
>         if (d_mountpoint(rep)) {
>                 unlock_rename(cache->graveyard, dir);
>                 cachefiles_io_error(cache, "Mountpoint in cache");
> -               return -EIO;
> +               goto out;
>         }
>
>         grave =3D lookup_one(&nop_mnt_idmap, &QSTR(nbuffer),
> cache->graveyard);
> @@ -343,11 +347,12 @@ int cachefiles_bury_object(struct cachefiles_cache
> *cache,
>
>                 if (PTR_ERR(grave) =3D=3D -ENOMEM) {
>                         _leave(" =3D -ENOMEM");
> -                       return -ENOMEM;
> +                       ret =3D -ENOMEM;
> +                       goto out;
>                 }
>
>                 cachefiles_io_error(cache, "Lookup error %ld",
> PTR_ERR(grave));
> -               return -EIO;
> +               goto out;
>         }
>
>         if (d_is_positive(grave)) {
> @@ -362,7 +367,7 @@ int cachefiles_bury_object(struct cachefiles_cache
> *cache,
>                 unlock_rename(cache->graveyard, dir);
>                 dput(grave);
>                 cachefiles_io_error(cache, "Mountpoint in graveyard");
> -               return -EIO;
> +               goto out;
>         }
>
>         /* target should not be an ancestor of source */
> @@ -370,7 +375,7 @@ int cachefiles_bury_object(struct cachefiles_cache
> *cache,
>                 unlock_rename(cache->graveyard, dir);
>                 dput(grave);
>                 cachefiles_io_error(cache, "May not make directory loop")=
;
> -               return -EIO;
> +               goto out;
>         }
>
>         /* attempt the rename */
> @@ -404,8 +409,10 @@ int cachefiles_bury_object(struct cachefiles_cache
> *cache,
>         __cachefiles_unmark_inode_in_use(object, d_inode(rep));
>         unlock_rename(cache->graveyard, dir);
>         dput(grave);
> -       _leave(" =3D 0");
> -       return 0;
> +       _leave(" =3D %d", ret);
> +out:
> +       dput(rep);
> +       return ret;
>  }
>
>  /*
> @@ -812,7 +819,6 @@ int cachefiles_cull(struct cachefiles_cache *cache,
> struct dentry *dir,
>
>         ret =3D cachefiles_bury_object(cache, NULL, dir, victim,
>                                      FSCACHE_OBJECT_WAS_CULLED);
> -       dput(victim);
>         if (ret < 0)
>                 goto error;
>
>
>
>
>

--000000000000b27dd5064deb21a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Why are this bulk fixes</div><div><br><div class=3D"gmail=
_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu,=
 26 Mar 2026 at 4:17=E2=80=AFPM, David Howells &lt;<a href=3D"mailto:dhowel=
ls@redhat.com">dhowells@redhat.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;pad=
ding-left:1ex">When cachefiles_cull() calls cachefiles_bury_object(), the l=
atter eats the<br>
former&#39;s ref on the victim dentry that it obtained from<br>
cachefiles_lookup_for_cull().=C2=A0 However, commit 7bb1eb45e43c left the d=
put<br>
of the victim in place, resulting in occasional:<br>
<br>
=C2=A0 WARNING: fs/dcache.c:829 at dput.part.0+0xf5/0x110, CPU#7: cachefile=
sd/11831<br>
=C2=A0 cachefiles_cull+0x8c/0xe0 [cachefiles]<br>
=C2=A0 cachefiles_daemon_cull+0xcd/0x120 [cachefiles]<br>
=C2=A0 cachefiles_daemon_write+0x14e/0x1d0 [cachefiles]<br>
=C2=A0 vfs_write+0xc3/0x480<br>
=C2=A0 ...<br>
<br>
reports.<br>
<br>
Actually, it&#39;s worse than that: cachefiles_bury_object() eats the ref i=
t was<br>
given - and then may continue to the now-unref&#39;d dentry it if it turns =
out to<br>
be a directory.=C2=A0 So simply removing the aberrant dput() is not suffici=
ent.<br>
<br>
Fix this by making cachefiles_bury_object() retain the ref itself around<br=
>
end_removing() if it needs to keep it and then drop the ref before returnin=
g.<br>
<br>
Fixes: bd6ede8a06e8 (&quot;VFS/nfsd/cachefiles/ovl: introduce start_removin=
g() and end_removing()&quot;)<br>
Reported-by: Marc Dionne &lt;<a href=3D"mailto:marc.dionne@auristor.com" ta=
rget=3D"_blank">marc.dionne@auristor.com</a>&gt;<br>
Signed-off-by: David Howells &lt;<a href=3D"mailto:dhowells@redhat.com" tar=
get=3D"_blank">dhowells@redhat.com</a>&gt;<br>
cc: NeilBrown &lt;<a href=3D"mailto:neil@brown.name" target=3D"_blank">neil=
@brown.name</a>&gt;<br>
cc: Paulo Alcantara &lt;<a href=3D"mailto:pc@manguebit.org" target=3D"_blan=
k">pc@manguebit.org</a>&gt;<br>
cc: <a href=3D"mailto:netfs@lists.linux.dev" target=3D"_blank">netfs@lists.=
linux.dev</a><br>
cc: <a href=3D"mailto:linux-afs@lists.infradead.org" target=3D"_blank">linu=
x-afs@lists.infradead.org</a><br>
cc: <a href=3D"mailto:linux-fsdevel@vger.kernel.org" target=3D"_blank">linu=
x-fsdevel@vger.kernel.org</a><br>
---<br>
=C2=A0fs/cachefiles/namei.c | 36 +++++++++++++++++++++---------------<br>
=C2=A01 file changed, 21 insertions(+), 15 deletions(-)<br>
<br>
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c<br>
index e5ec90dccc27..20138309733f 100644<br>
--- a/fs/cachefiles/namei.c<br>
+++ b/fs/cachefiles/namei.c<br>
@@ -287,14 +287,14 @@ int cachefiles_bury_object(struct cachefiles_cache *c=
ache,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!d_is_dir(rep)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D cachefiles_=
unlink(cache, object, dir, rep, why);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 end_removing(rep);<=
br>
-<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _leave(&quot; =3D %=
d&quot;, ret);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* directories have to be moved to the graveyar=
d */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 _debug(&quot;move stale object to graveyard&quo=
t;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0end_removing(rep);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dget(rep);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0end_removing(rep); /* Drops ref on rep */<br>
<br>
=C2=A0try_again:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* first step is to make up a grave dentry in t=
he graveyard */<br>
@@ -304,8 +304,10 @@ int cachefiles_bury_object(struct cachefiles_cache *ca=
che,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* do the multiway lock magic */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 trap =3D lock_rename(cache-&gt;graveyard, dir);=
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(trap))<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return PTR_ERR(trap=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (IS_ERR(trap)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D PTR_ERR(tra=
p);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* do some checks before getting the grave dent=
ry */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rep-&gt;d_parent !=3D dir || IS_DEADDIR(d_i=
node(rep))) {<br>
@@ -313,25 +315,27 @@ int cachefiles_bury_object(struct cachefiles_cache *c=
ache,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* lock */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_rename(cache=
-&gt;graveyard, dir);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 _leave(&quot; =3D 0=
 [culled?]&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -EIO;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!d_can_lookup(cache-&gt;graveyard)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_rename(cache=
-&gt;graveyard, dir);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cachefiles_io_error=
(cache, &quot;Graveyard no longer a directory&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (trap =3D=3D rep) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_rename(cache=
-&gt;graveyard, dir);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cachefiles_io_error=
(cache, &quot;May not make directory loop&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (d_mountpoint(rep)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_rename(cache=
-&gt;graveyard, dir);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cachefiles_io_error=
(cache, &quot;Mountpoint in cache&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 grave =3D lookup_one(&amp;nop_mnt_idmap, &amp;Q=
STR(nbuffer), cache-&gt;graveyard);<br>
@@ -343,11 +347,12 @@ int cachefiles_bury_object(struct cachefiles_cache *c=
ache,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (PTR_ERR(grave) =
=3D=3D -ENOMEM) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 _leave(&quot; =3D -ENOMEM&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return -ENOMEM;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ret =3D -ENOMEM;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cachefiles_io_error=
(cache, &quot;Lookup error %ld&quot;, PTR_ERR(grave));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (d_is_positive(grave)) {<br>
@@ -362,7 +367,7 @@ int cachefiles_bury_object(struct cachefiles_cache *cac=
he,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_rename(cache=
-&gt;graveyard, dir);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dput(grave);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cachefiles_io_error=
(cache, &quot;Mountpoint in graveyard&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* target should not be an ancestor of source *=
/<br>
@@ -370,7 +375,7 @@ int cachefiles_bury_object(struct cachefiles_cache *cac=
he,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_rename(cache=
-&gt;graveyard, dir);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dput(grave);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cachefiles_io_error=
(cache, &quot;May not make directory loop&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIO;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto out;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* attempt the rename */<br>
@@ -404,8 +409,10 @@ int cachefiles_bury_object(struct cachefiles_cache *ca=
che,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __cachefiles_unmark_inode_in_use(object, d_inod=
e(rep));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unlock_rename(cache-&gt;graveyard, dir);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dput(grave);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0_leave(&quot; =3D 0&quot;);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0_leave(&quot; =3D %d&quot;, ret);<br>
+out:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dput(rep);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
@@ -812,7 +819,6 @@ int cachefiles_cull(struct cachefiles_cache *cache, str=
uct dentry *dir,<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D cachefiles_bury_object(cache, NULL, dir=
, victim,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FSCACHE_OBJECT_W=
AS_CULLED);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0dput(victim);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret &lt; 0)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto error;<br>
<br>
<br>
<br>
<br>
</blockquote></div></div>

--000000000000b27dd5064deb21a2--

