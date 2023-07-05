Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67224747E6B
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 09:43:25 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BgbP87cJ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BgbP87cJ;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Qws8q10pXz30Py
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 17:43:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BgbP87cJ;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BgbP87cJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alexl@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Qws8k447Yz2yxs
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jul 2023 17:43:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688542994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKZLTnkLqcKqaST+ccHAre8EUSS+fXNkgS5OJVWD5Oo=;
	b=BgbP87cJ6az6Tr2zCJg6UCk70o9c68iQPdWQ4PJgtKJlwVvunkAcbn6dVVdGogde0HVHpl
	YVHan4GZDljUYfKIRafXrvJwbEbbRBd2BIsm7hrfMV+lmgFSbrzCQ0EQO1gYT1klOe5nZn
	mJva+K7wWsFFEuXhpHgR/fwiD8Nbdq4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688542994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKZLTnkLqcKqaST+ccHAre8EUSS+fXNkgS5OJVWD5Oo=;
	b=BgbP87cJ6az6Tr2zCJg6UCk70o9c68iQPdWQ4PJgtKJlwVvunkAcbn6dVVdGogde0HVHpl
	YVHan4GZDljUYfKIRafXrvJwbEbbRBd2BIsm7hrfMV+lmgFSbrzCQ0EQO1gYT1klOe5nZn
	mJva+K7wWsFFEuXhpHgR/fwiD8Nbdq4=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-WAM7m4rzNHW-W2vf4eIOwQ-1; Wed, 05 Jul 2023 03:43:12 -0400
X-MC-Unique: WAM7m4rzNHW-W2vf4eIOwQ-1
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3461a3ebbedso8360795ab.0
        for <linux-erofs@lists.ozlabs.org>; Wed, 05 Jul 2023 00:43:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688542991; x=1691134991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GKZLTnkLqcKqaST+ccHAre8EUSS+fXNkgS5OJVWD5Oo=;
        b=eu+ax8LmEUM8iosNhMacq4uSyqrA1YraUT5AniTFBmrUkKGoQds00VT3rXzy2iiiYm
         3aZ9/bZZ/RHuo2yJqyu7gboVbH1vkbGc++rEx42yOf4DCszNyojFBOYV2wu7nrYvfbYm
         efamllRljMg6kVYB9Mln4zJiLMgR4dni4vy1jJhiNJqkPkRgRWFK5aFdFDwWT24oSM3D
         jn8W6AixLEtE6v6DM0fLfC3aHG6bPy06ZHbFOzjmKgTnvsJtiALTo5P1FQepT3cbZvvo
         3o65Ktx8RkvgegMrl7ZK+2iOncz1bHSwq5qqFJMhqfac/Elyy5tcujrA/zeqoQCYbyw0
         +NOw==
X-Gm-Message-State: ABy/qLYY1p+zZMrgPccjviDrmBjQijvo8fZmkrLoB90f2oXv77IxyCdH
	pfAXzN7VoUrQtc0c1iQUsTnfgPI/JGlOy9MSbCVHWbWf3GEL/3/YNsF2aIIV2Nry/Tddg88bb9s
	5oNszaeDLinM02lPi/khiMr9ap1YDS3k5Rg61v84T
X-Received: by 2002:a92:c841:0:b0:345:968b:a147 with SMTP id b1-20020a92c841000000b00345968ba147mr14782758ilq.14.1688542991605;
        Wed, 05 Jul 2023 00:43:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGtfy/xAZixl1ClSishhtHJk4LSH8tlURUodcX+AX6bJXxTnD8w23VWDLTUJFB6SvB1JtVDB0L0NCLy35u2PV4=
X-Received: by 2002:a92:c841:0:b0:345:968b:a147 with SMTP id
 b1-20020a92c841000000b00345968ba147mr14782742ilq.14.1688542991315; Wed, 05
 Jul 2023 00:43:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230705070427.92579-1-jefflexu@linux.alibaba.com>
 <20230705070427.92579-2-jefflexu@linux.alibaba.com> <2eda59f2-a302-04a5-08de-c4ab7cf2e744@linux.alibaba.com>
In-Reply-To: <2eda59f2-a302-04a5-08de-c4ab7cf2e744@linux.alibaba.com>
From: Alexander Larsson <alexl@redhat.com>
Date: Wed, 5 Jul 2023 09:43:00 +0200
Message-ID: <CAL7ro1GayuYup4V0arhEWZDztFN1Gxx5jwdL3uFaGfQZ4hw41g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] erofs: update on-disk format for xattr name filter
To: Gao Xiang <hsiangkao@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jul 5, 2023 at 9:25=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.c=
om> wrote:
>
>
>
> On 2023/7/5 15:04, Jingbo Xu wrote:
> > The xattr name bloom filter feature is going to be introduced to speed
> > up the negative xattr lookup, e.g. system.posix_acl_[access|default]
> > lookup when running "ls -lR" workload.
> >
> > The number of common used extended attributes (n) is approximately 30.
>
> There are some commonly used extended attributes (n) and the total number
> of these is 31:
>
> >
> >       trusted.overlay.opaque
> >       trusted.overlay.redirect
> >       trusted.overlay.origin
> >       trusted.overlay.impure
> >       trusted.overlay.nlink
> >       trusted.overlay.upper
> >       trusted.overlay.metacopy
> >       trusted.overlay.protattr
> >       user.overlay.opaque
> >       user.overlay.redirect
> >       user.overlay.origin
> >       user.overlay.impure
> >       user.overlay.nlink
> >       user.overlay.upper
> >       user.overlay.metacopy
> >       user.overlay.protattr
> >       security.evm
> >       security.ima
> >       security.selinux
> >       security.SMACK64
> >       security.SMACK64IPIN
> >       security.SMACK64IPOUT
> >       security.SMACK64EXEC
> >       security.SMACK64TRANSMUTE
> >       security.SMACK64MMAP
> >       security.apparmor
> >       security.capability
> >       system.posix_acl_access
> >       system.posix_acl_default
> >       user.mime_type
> >
> > Given the number of bits of the bloom filter (m) is 32, the optimal
> > value for the number of the hash functions (k) is 1 (ln2 * m/n =3D 0.74=
).
> >
> > The single hash function is implemented as:
> >
> >       xxh32(name, strlen(name), EROFS_XATTR_FILTER_SEED + index)
> >
> > where index represents the index of corresponding predefined short name
>
> where `index`...
>
>
>
> > prefix, while name represents the name string after stripping the above
> > predefined name prefix.
> >
> > The constant magic number EROFS_XATTR_FILTER_SEED, i.e. 0x25BBE08F, is
> > used to give a better spread when mapping these 30 extended attributes
> > into 32-bit bloom filter as:
> >
> >       bit  0: security.ima
> >       bit  1:
> >       bit  2: trusted.overlay.nlink
> >       bit  3:
> >       bit  4: user.overlay.nlink
> >       bit  5: trusted.overlay.upper
> >       bit  6: user.overlay.origin
> >       bit  7: trusted.overlay.protattr
> >       bit  8: security.apparmor
> >       bit  9: user.overlay.protattr
> >       bit 10: user.overlay.opaque
> >       bit 11: security.selinux
> >       bit 12: security.SMACK64TRANSMUTE
> >       bit 13: security.SMACK64
> >       bit 14: security.SMACK64MMAP
> >       bit 15: user.overlay.impure
> >       bit 16: security.SMACK64IPIN
> >       bit 17: trusted.overlay.redirect
> >       bit 18: trusted.overlay.origin
> >       bit 19: security.SMACK64IPOUT
> >       bit 20: trusted.overlay.opaque
> >       bit 21: system.posix_acl_default
> >       bit 22:
> >       bit 23: user.mime_type
> >       bit 24: trusted.overlay.impure
> >       bit 25: security.SMACK64EXEC
> >       bit 26: user.overlay.redirect
> >       bit 27: user.overlay.upper
> >       bit 28: security.evm
> >       bit 29: security.capability
> >       bit 30: system.posix_acl_access
> >       bit 31: trusted.overlay.metacopy, user.overlay.metacopy
> >
> > The h_name_filter field is introduced to the on-disk per-inode xattr
> > header to place the corresponding xattr name filter, where bit value 1
> > indicates non-existence for compatibility.
> >
> > This feature is indicated by EROFS_FEATURE_COMPAT_XATTR_FILTER
> > compatible feature bit.
> >
> > Suggested-by: Alexander Larsson <alexl@redhat.com>
> > Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> > ---
> >   fs/erofs/erofs_fs.h | 8 +++++++-
> >   1 file changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/fs/erofs/erofs_fs.h b/fs/erofs/erofs_fs.h
> > index 2c7b16e340fe..b4b6235fd720 100644
> > --- a/fs/erofs/erofs_fs.h
> > +++ b/fs/erofs/erofs_fs.h
> > @@ -13,6 +13,7 @@
> >
> >   #define EROFS_FEATURE_COMPAT_SB_CHKSUM          0x00000001
> >   #define EROFS_FEATURE_COMPAT_MTIME              0x00000002
> > +#define EROFS_FEATURE_COMPAT_XATTR_FILTER    0x00000004
>
> I'd suggest that if we could leave one reserved byte in the
> superblock for now (and checking if it's 0) since
>    1) xattr filter feature is a compatible feature;
>    2) I'm not sure if the implementation could be changed.
>
> so that later implementation changes won't bother compat bits
> again.

I would very much like to generate these bloom filters in composefs
right now, before the composefs v1 format is completely locked down,
and this should be fully possible given that this is a backwards
compat change. But this is only possible if it doesn't require a
feature flag like this that makes old erofs versions not mount the
image.


--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

