Return-Path: <linux-erofs+bounces-3866-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rUlYLbmeTmpVQwIAu9opvQ
	(envelope-from <linux-erofs+bounces-3866-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 21:02:17 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A626729C30
	for <lists+linux-erofs@lfdr.de>; Wed, 08 Jul 2026 21:02:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=JEX79elK;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "linux-erofs+bounces-3866-lists+linux-erofs=lfdr.de@lists.ozlabs.org" designates 2404:9400:21b9:f100::1 as permitted sender) smtp.mailfrom="linux-erofs+bounces-3866-lists+linux-erofs=lfdr.de@lists.ozlabs.org";
	arc=pass ("lists.ozlabs.org:s=201707:i=2")
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwSBq0cwpz2xpn;
	Thu, 09 Jul 2026 05:02:11 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783537331;
	cv=pass; b=M1S6HD+l8ob9+jEQgUvJmi9tsj4JVfZ7kQ1LXsW69cxCrIvi7J7KbeJlU9dyzNVKObpjooIlAA8Yuz+Fnjodp3lRCHu5pFAJgt+x+gGX/iqLjn7QQZHec9B+JyiSTbAqqPZUnYCorv4LYWeAf7smpCzp1OeB1k2x/+45zHIvEr9qIavTlbgOPEBsXDoC9zIvnQ9xkY5E6R6bYQCQjSqeImcdJX/GSZLAgKrxGCxOKjFswwB9OfMB4JPLo0JUPIzPF5J5HZdgGeoObhWvPRh9ij8BepTI4vxbi9lvR7HrtFcBdXgYBW8qEu44kjKxFbKw1ripno8Gzle7AnSRdp9Phw==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783537331; c=relaxed/relaxed;
	bh=h6p7iFMPL0RnoW5Oom2GXslSbFev5CUALqnSA0TrUcg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKXkwVU9m0BR46QCaNACsd04rfwZw2DutIT0Xl4wb+RXGFa+z3cpIEkAsuIOLOHWXbIqV8mGPLxpQIE+2xYu8b9eqZQXcNeR1MXurI+t1Y9MQDmliXx+O9fLbw3/oNNZyQrAc6jnpAB50JKBidJ9416doB0yy+mXtRTx1wsqC9MIzacSU40pItp5uoMHfsJe4JxkJw7EveCY1dCwR4bt4/Sk8Wy6SpGML6LMVqh/IV7RYBncXgZDGokltedSOJl8YEk/6lEnJhA8Qg6lJaCyoOn7FyM3CioIYNAfaUGrcUoskH2aclh64cj5qBmuAk7o0dP2a0gaFBL0C+nQZ27nTQ==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JEX79elK; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::532; helo=mail-ed1-x532.google.com; envelope-from=amir73il@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwSBn11hyz2xll
	for <linux-erofs@lists.ozlabs.org>; Thu, 09 Jul 2026 05:02:08 +1000 (AEST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-698bf053053so1861126a12.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 08 Jul 2026 12:02:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783537325; cv=none;
        d=google.com; s=arc-20260327;
        b=B9kIxMrMM1Tx/25xthYjk+/za6zg+CfnxtCGm1NKxOKxD4tdmsTfmmHNlmdWcLSvjN
         ZkT17oV7jlK3ZHh6ZfYxZyNOtjjqlSual5pUuG/TQlayn2F4UdBExMIr7YkDm1QfyYRu
         B9YJblmRbTjL9F3DwropeQ8LG4VO2GB5VBM5lZ5AjzHkyPdDhbRk+xRG6HoAoRfbyC/t
         BqFH5ctymdKmRDr0EextDL25u0fZ+aQWuTA2Ybp0HUDmgLoOqH6Q+iF8Gh+Bk9qQZugI
         NDuBWw5jdd3+jhX3yCpj5gyQQPWzTG4GJ3weqQG93ojULZZK9tj77KNRTZ0DVcIo7hkk
         0I9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=h6p7iFMPL0RnoW5Oom2GXslSbFev5CUALqnSA0TrUcg=;
        fh=gVO7xi6NghbVuLcwGVs1yBNWhEruj2HYGJefufr2iBI=;
        b=lnttY580bvFlRj992QV7PvvChWN9gyJqcGId5xphgszdXlsytxjB8n/5Wse1IIhuU2
         ywkh0o5UFjJD8OjXbGa274VMy47WEOb095XPF6JRIArQYtTrdWX3XUxTVChnZ6HYSr8K
         Yb7bXNJbtVCNVUPcaxirgxpasAIkQ96gRv92hKZt5ItuPfEvUdsoW43JxvNAwWEzYMBD
         eLXt9o4JEVwFMZ8gfIZFREWthait/CuZNQoyK7DZ59GbKf4IgejAw4eFbX75+ysSbRbv
         hJ/wVb2w7zKeydI1T32jpOkn15WbbzYm/7ayRM88Ao+57IiBrCgLgGoW5SDo7ROZjgyB
         L5LQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783537325; x=1784142125; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=h6p7iFMPL0RnoW5Oom2GXslSbFev5CUALqnSA0TrUcg=;
        b=JEX79elKiQv+WqiNHsJywulcBh7Q/RnWsmTKfv5VRzz1S8jIVz1RrkJc5MIkiDYNPt
         +V2mGymqgrv4YPLTzKRWPTyq19IoYqqnTW5fz1e9HCsHlk7K7BmrIPRH4v5HazLIqDLI
         +fqthy9RSPxt4L+LnEGrt1CGAjUb2YId5D4lL43S8dHIpOyxKI8GQ2gGpQqCqRoCFD6E
         D8rmNozezz4zj98ZGGVezaGEYiNmOhJYQPr90MOrQ/hzK8sIZ9tGO/EYVyolF4J97LxQ
         M4lO/sLZAyuxlPykWROr+AZ2Z12tmBokeoH8r4drkw+uw9TmFoNHtI3WbiJu49s3meZy
         e0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783537325; x=1784142125;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h6p7iFMPL0RnoW5Oom2GXslSbFev5CUALqnSA0TrUcg=;
        b=cl9genrEX0EWS6suqmRUE0doL04vFZomMoDD2Z6GfQ2n56TBkR/B7OG7vlZj4JdFAl
         yXqdMOZCMStMiiFuwOVw/UQmh8G2KTAVSLdl/lgYtwGeOw5Wbn5XQcALPI1im4aKUxkw
         UxO/06JctHVhwZ+2VDViSfzzOIZfQu1bX3N5aZk+K1NByUfFmZYQ+jARB/rJQNAyTFwb
         YWMT8zx52Wj3zAXYxLdzx9EVgkB4SCDX7KzbCt+CJNOsv470au6Pyb34xXlXy/dXB3Cf
         Cq+P1VAuYyOQ9iOiMHlE5+JtkcKIsyCg4LN99Rzaq5i2gnic1G89uKQLWvBzeZL8JnOR
         rIMQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq0QAc29O61rmKSf0tqi6M/NLPQ3D9Ybes9HvmGXZK0HbbqDMrWB5xFjcMDCl9dNbxjiI7P/C/+cjUp5w==@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzHu9Y6kmQRHD9ppeY4AUtAfQ2jeo9R+SVu7f5UU1EMSi+zeTWw
	/rc8JkhWlf6dvCWSkSDMv6yauqTWDRUqQJ+oJQfjr1OAjc7cU29GEKJhoxu/3Bw19c1MrNRZwxo
	P3gFoxm594ZiSPO6fF9vDRhWXlRr1Nas=
X-Gm-Gg: AfdE7cnYJLUeASUxe/ziOKLqMJPWMJtG/3j1X27cVAQLLB0Iof7JxRRg/pChyD7+3eA
	OM2YnVIsPOM5TWkRazi5Ws+yC67wBccIVAtNm1nlqfOPWOXeIvN0WN4+uYWFoxwD4yutie4YxHw
	sjyysxAaACBU5b2DOmTNSDNK+HaeoWploU+wWkzU78hIbfgXzxWwnfwhYh0ry9QeJZ3kmx/bgoO
	1kSS7qA22dsqMrhFGHOyaWVBJjj2QcRCTpinzr9pznyvb5VC4zxMZFWc98KeqBEuZgMuv4reQ==
X-Received: by 2002:a05:6402:1f89:b0:69a:9355:ec35 with SMTP id
 4fb4d7f45d1cf-69ab44b5e42mr1817377a12.41.1783537325129; Wed, 08 Jul 2026
 12:02:05 -0700 (PDT)
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
References: <20260708095831.3381978-1-gscrivan@redhat.com> <CAJfpegsJON=1_84PCGMjASYPFL=Wqsz7dnTAbO3Tdz5DfRQU+g@mail.gmail.com>
 <878q7l8y4y.fsf@redhat.com> <CAJfpegvQ06=2E0V_ADgxwmo7e5weTfOMozmBB-QVNLLWYAm8WQ@mail.gmail.com>
 <87wlv57dt1.fsf@redhat.com> <CAJfpegtTixwWSh9M-9NbwP0nUbJJ9rh0rxqO7BzgK7Su_RpM+A@mail.gmail.com>
 <87o6gh79yi.fsf@redhat.com>
In-Reply-To: <87o6gh79yi.fsf@redhat.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 8 Jul 2026 21:01:53 +0200
X-Gm-Features: AVVi8CcH_8D2AVPgSdZmur5rdOwKhUpVaCHJD-tULtZMblV_EPw4hJoYlLj59_k
Message-ID: <CAOQ4uxgbNhdzKN7tvRmFDpt-8CZWh9pVcMLv25HxJzA0_0WfSg@mail.gmail.com>
Subject: Re: [PATCH] ovl: add ioctls to retrieve layer file descriptors
To: Giuseppe Scrivano <gscrivan@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, 
	linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=disabled version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-3866-lists,linux-erofs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:gscrivan@redhat.com,m:miklos@szeredi.hu,m:linux-unionfs@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-api@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A626729C30

On Wed, Jul 8, 2026 at 5:55=E2=80=AFPM Giuseppe Scrivano <gscrivan@redhat.c=
om> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> writes:
>
> > On Wed, 8 Jul 2026 at 16:32, Giuseppe Scrivano <gscrivan@redhat.com> wr=
ote:
> >
> >> Amir suggested to add that functionality when I've asked for some
> >> feedback before sending the patch here.  I am fine to drop it if this =
is
> >> the consensus although I see its utility from user space.

I was thinking that getting the number of layers or info would be
a good idea to complement getting a layer fd.

I agree that the same information is probably available via statmount
by parsing the upperdir/lowerdir/datadir mount options.

> >
> > How about a completely different interface:
> >
> > int get_fd_opt(const char *name, unsigned int index, unsigned int flags=
);
> >
> > Enumerating layers would be as easy as passing an index stating from
> > zero and stopping when -ERANGE is received.
> >
> > It would work for all filesystems that use files as options.  No more
> > fs specific ioctls.
>
> Is a new syscall really justified for such a narrow use case?
>

I feel the same way.

Giuseppe,

Could you add some high level context in this thread on why you need
this functionality.
I think it's this composefs-rs work. right?
https://github.com/giuseppe/composefs-rs/commits/reuse-mounts-and-prevent-g=
c-overlay/

I must say this seems a bit upside down to me.

If you want to keep a pool of mounted erofs images, you could do that
in userspace -
create a service that indexes mounted erofs images by unique mount point pa=
ths.
Then you can introspect the overlayfs mount options referring to those
mount points.

Going through the kernel to get an fd and reuse that fd for a new
overlayfs mount
sounds like a strange way of accomplishing this.

If the overlayfs mounter is unprivileged, it would have to go through
systemd-mountfsd
to request a mount of erofs trusted image, right?

Can't the same service provide the "is_image_mounted" query which provides
the mount path?

I am not against introspection of overlayfs, but I'd like to understand
the use cases before finalizing the uapi.

Thanks,
Amir.

