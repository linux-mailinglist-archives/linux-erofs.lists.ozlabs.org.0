Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9110747E71
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 09:45:05 +0200 (CEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LXrqwoyh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LXrqwoyh;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4QwsBl5WdHz30Py
	for <lists+linux-erofs@lfdr.de>; Wed,  5 Jul 2023 17:45:03 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LXrqwoyh;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LXrqwoyh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=redhat.com (client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=alexl@redhat.com; receiver=lists.ozlabs.org)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4QwsBg4R5gz2yxs
	for <linux-erofs@lists.ozlabs.org>; Wed,  5 Jul 2023 17:44:59 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688543096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhqSMESVuEfcbYSiCIUoig5V/WvTsij8RzmIN+JFlXI=;
	b=LXrqwoyhy4gOGIHJsSQBKCvaCfTgHjAxfHUFAZsUSlVKR/I8qb2gY0JzeI30k5Vsf/Jxt3
	wh/kVXuCA39pj6a8Gc7Kyjzgizm3dA2J/KC5zCr0pxkkvaxhn5UB3yYfXYBJS/vtfN9ZjR
	Q3PSndXVpfVpUcxgW+5tdHKN7Pq3//8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1688543096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xhqSMESVuEfcbYSiCIUoig5V/WvTsij8RzmIN+JFlXI=;
	b=LXrqwoyhy4gOGIHJsSQBKCvaCfTgHjAxfHUFAZsUSlVKR/I8qb2gY0JzeI30k5Vsf/Jxt3
	wh/kVXuCA39pj6a8Gc7Kyjzgizm3dA2J/KC5zCr0pxkkvaxhn5UB3yYfXYBJS/vtfN9ZjR
	Q3PSndXVpfVpUcxgW+5tdHKN7Pq3//8=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-gw_7kDdEMA6Z1FBGS4wlKA-1; Wed, 05 Jul 2023 03:44:55 -0400
X-MC-Unique: gw_7kDdEMA6Z1FBGS4wlKA-1
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7866b037d4dso152605639f.3
        for <linux-erofs@lists.ozlabs.org>; Wed, 05 Jul 2023 00:44:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688543094; x=1691135094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xhqSMESVuEfcbYSiCIUoig5V/WvTsij8RzmIN+JFlXI=;
        b=EBOncGcsZNP4Ltbn61QhmyhJaMlmeUAVSIc/izkyULQv609VwTFT5h5KjqQiMJV5Pt
         6m1KSrz6fci+NIleVw6BrGjB2ruMADXRpjQrQxLDqdq47MpKSY5nehPceiewysw7gpUC
         8YROAQ9YbFrCMxuROWU0K8+wn8FHksrps7yxYLp9RErD4zo2x1o6HtgjELbHRSP9udIp
         TprwtWofkN7cRfHZ1xAUKCvBrNrn7cbhIatpXBAJLFgpn94NttZeLV36HqYBQRWelkt1
         7M54OFK3RdZtFtejk9TZbsUkeH2gQXO6SKxaFiwNvNnUXvrzCZoAmyI/322+gPbszz5p
         gn5g==
X-Gm-Message-State: ABy/qLbHzV5A+OiX0qQDCX5pgC7PiM/8AHRPyvFfN7ZwxUP6D7ew0k7k
	ovFKAHzog4Qs9VQSyXYwwIjKEeMQcHU+xsX/pFgmTijbreVE2/86opgmXSf01FnzFc7nx9BKUAR
	DKp1cFQ3+oPR5iRzJcY3zkxxsgkDQyYrffOL7tDaq
X-Received: by 2002:a05:6e02:549:b0:345:baef:842b with SMTP id i9-20020a056e02054900b00345baef842bmr14200081ils.25.1688543094491;
        Wed, 05 Jul 2023 00:44:54 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGNIYLOK2akZqWKGP7b3X3MwsItf7MK568KWs0SIYlJKsXPb6PqP0sY6tuV5P0aUcze0VULeHSI/Fu9IbiQXo0=
X-Received: by 2002:a05:6e02:549:b0:345:baef:842b with SMTP id
 i9-20020a056e02054900b00345baef842bmr14200070ils.25.1688543094240; Wed, 05
 Jul 2023 00:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230705070427.92579-1-jefflexu@linux.alibaba.com> <20230705070427.92579-3-jefflexu@linux.alibaba.com>
In-Reply-To: <20230705070427.92579-3-jefflexu@linux.alibaba.com>
From: Alexander Larsson <alexl@redhat.com>
Date: Wed, 5 Jul 2023 09:44:43 +0200
Message-ID: <CAL7ro1GuPZE8ek=uvfHEqGFrbbt=NO1=oO8_B-dVBF9go=StSg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] erofs: boost negative xattr lookup with bloom filter
To: Jingbo Xu <jefflexu@linux.alibaba.com>
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
Cc: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org, huyue2@coolpad.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Wed, Jul 5, 2023 at 9:04=E2=80=AFAM Jingbo Xu <jefflexu@linux.alibaba.co=
m> wrote:
>
> The bit value for the bloom filter map has a reverse semantics for
> compatibility.  That is, the bit value of 0 indicates existence, while
> the bit value of 1 indicates the absence of corresponding xattr.
>
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/erofs/internal.h |  2 ++
>  fs/erofs/xattr.c    | 12 ++++++++++++
>  2 files changed, 14 insertions(+)
>
> diff --git a/fs/erofs/internal.h b/fs/erofs/internal.h
> index 36e32fa542f0..7e447b48a46b 100644
> --- a/fs/erofs/internal.h
> +++ b/fs/erofs/internal.h
> @@ -251,6 +251,7 @@ EROFS_FEATURE_FUNCS(fragments, incompat, INCOMPAT_FRA=
GMENTS)
>  EROFS_FEATURE_FUNCS(dedupe, incompat, INCOMPAT_DEDUPE)
>  EROFS_FEATURE_FUNCS(xattr_prefixes, incompat, INCOMPAT_XATTR_PREFIXES)
>  EROFS_FEATURE_FUNCS(sb_chksum, compat, COMPAT_SB_CHKSUM)
> +EROFS_FEATURE_FUNCS(xattr_filter, compat, COMPAT_XATTR_FILTER)
>
>  /* atomic flag definitions */
>  #define EROFS_I_EA_INITED_BIT  0
> @@ -270,6 +271,7 @@ struct erofs_inode {
>         unsigned char inode_isize;
>         unsigned int xattr_isize;
>
> +       unsigned long xattr_name_filter;
>         unsigned int xattr_shared_count;
>         unsigned int *xattr_shared_xattrs;
>
> diff --git a/fs/erofs/xattr.c b/fs/erofs/xattr.c
> index 40178b6e0688..1137723303d3 100644
> --- a/fs/erofs/xattr.c
> +++ b/fs/erofs/xattr.c
> @@ -5,6 +5,7 @@
>   * Copyright (C) 2021-2022, Alibaba Cloud
>   */
>  #include <linux/security.h>
> +#include <linux/xxhash.h>
>  #include "xattr.h"
>
>  struct erofs_xattr_iter {
> @@ -87,6 +88,7 @@ static int erofs_init_inode_xattrs(struct inode *inode)
>         }
>
>         ih =3D it.kaddr + erofs_blkoff(sb, it.pos);
> +       vi->xattr_name_filter =3D le32_to_cpu(ih->h_name_filter);
>         vi->xattr_shared_count =3D ih->h_shared_count;
>         vi->xattr_shared_xattrs =3D kmalloc_array(vi->xattr_shared_count,
>                                                 sizeof(uint), GFP_KERNEL)=
;
> @@ -392,7 +394,10 @@ int erofs_getxattr(struct inode *inode, int index, c=
onst char *name,
>                    void *buffer, size_t buffer_size)
>  {
>         int ret;
> +       uint32_t bit;
>         struct erofs_xattr_iter it;
> +       struct erofs_inode *vi =3D EROFS_I(inode);
> +       struct erofs_sb_info *sbi =3D EROFS_SB(inode->i_sb);
>
>         if (!name)
>                 return -EINVAL;
> @@ -401,6 +406,13 @@ int erofs_getxattr(struct inode *inode, int index, c=
onst char *name,
>         if (ret)
>                 return ret;
>
> +       if (erofs_sb_has_xattr_filter(sbi)) {

As I said in my other mail. I would really like this to just always do
the filter check. It should be safe as older fs:es have zero in place
here, and doing this allows me to create composefs images with the
bloom filters that also work with older kernels.

> +               bit =3D xxh32(name, strlen(name), EROFS_XATTR_FILTER_SEED=
 + index);
> +               bit &=3D EROFS_XATTR_FILTER_MASK;
> +               if (test_bit(bit, &vi->xattr_name_filter))
> +                       return -ENOATTR;
> +       }
> +
>         it.index =3D index;
>         it.name =3D (struct qstr)QSTR_INIT(name, strlen(name));
>         if (it.name.len > EROFS_NAME_LEN)
> --
> 2.19.1.6.gb485710b
>


--=20
=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D=
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D
 Alexander Larsson                                Red Hat, Inc
       alexl@redhat.com         alexander.larsson@gmail.com

