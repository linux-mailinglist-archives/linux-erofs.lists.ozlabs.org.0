Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1F258DF33
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Aug 2022 20:38:19 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M2MJn4Pzgz307g
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Aug 2022 04:38:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=IpLl0W6A;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b31; helo=mail-yb1-xb31.google.com; envelope-from=wata2ki@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=IpLl0W6A;
	dkim-atps=neutral
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M2MJk6T6Wz2xHC
	for <linux-erofs@lists.ozlabs.org>; Wed, 10 Aug 2022 04:38:14 +1000 (AEST)
Received: by mail-yb1-xb31.google.com with SMTP id j63so19661225ybb.13
        for <linux-erofs@lists.ozlabs.org>; Tue, 09 Aug 2022 11:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=/S/UjRjX4A7YGXzyj4QeMYN8H8gfTWeBgKN1RawmtdY=;
        b=IpLl0W6AFvmQYfbpMIn203D4pFIuo98J6zI3ThG4gyn68XlumGapH8fsBcjIdcK4R+
         jIuxKsL7XhBq3PmSfV2MqCC5CnvEYrMhOmP+2ItQyVsIh1RPoqZsp2dl+IVjpG1BZRYD
         A6QotZ/CurZGVtVBgluaJXzqqC7lyj5kEwHp+C8G4vc2+17GNVgDttFRVkHDqHYDgG6P
         2JzdaKhH2Z4itUSYdyzkLZff8TvkT6qmFoBJ+RWFvcEDCuUdYGn1NuHg5DqHUU7+Ohpz
         nyjuq8ZwdAnT0K5yDc32oWcg6c6W2KAvIdpxwrBgB0Q4nhV3VckgMmitqm5sJvUL0ceI
         h9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=/S/UjRjX4A7YGXzyj4QeMYN8H8gfTWeBgKN1RawmtdY=;
        b=5GRnWH7+nOvZ4gIsXPo6rPHynG50J5Y3D6IYo5TqmV+Xxd2S/fEc/j7uxJ+HXd3Hch
         XIFoPoE6HahqZK2iWvDuO2kCx3xP8TPHQq+F8HUqBd0KNi+pajYvgYpInYwxDL4cONFX
         IXvf8YpRANyL3pEyjGvyLdPwSe1tFR94T+MV8Mpbd5FoBwFRbVP+ybBBNaTqKfUd5/Fx
         MxD3de1LcdLwS4lYkV4nW2hOjMltGqD+tfzCQq/ZPf6CG2zT9koYb0E6xUhxCQhbEC8c
         SUmmFQMxGsbe80bJuszaWB4tSWBey4Y1dndfjcX7gEojS7nTku4coDpmzB4uGNgSqudB
         Ny8A==
X-Gm-Message-State: ACgBeo29Yxn1x3l1gRNxTSw8BU8GM8ZvrwVi6UU2wjMFhoYtHZb4iIAt
	+XkzwlY7sF7LqYfGgg6J11SN0u6BeFbZWlNd/LY=
X-Google-Smtp-Source: AA6agR4DRHwKGHTRxRWb6jaLqmeBAYXLnooJpbsxdU1BiBHO4uJQ84wd8W1yR4nssI5uSVHtb+ZcypxorEDb2t0Xb+U=
X-Received: by 2002:a25:9849:0:b0:676:d67c:2522 with SMTP id
 k9-20020a259849000000b00676d67c2522mr20282460ybo.487.1660070291189; Tue, 09
 Aug 2022 11:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <CABBJnRbpAxGB644x=fBRK5GOrjxYawZE-zrhHnRHQbz5Lzp-CQ@mail.gmail.com>
 <YvKj8aZp/6bg/Nxv@debian>
In-Reply-To: <YvKj8aZp/6bg/Nxv@debian>
From: Naoto Yamaguchi <wata2ki@gmail.com>
Date: Wed, 10 Aug 2022 03:37:59 +0900
Message-ID: <CABBJnRaP8XWbKiYVxbtdiJ0ViFz0hhkwTPnBA004aetZx_5nhQ@mail.gmail.com>
Subject: Re: RFC: erofs-utils:mkfs: add unprivileged container use-case support
To: Naoto Yamaguchi <wata2ki@gmail.com>, linux-erofs@lists.ozlabs.org
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
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Gao

Thank you for your response.

> Could you give more details about this? EROFS already supports idmapped
> mount for container use cases since 5.19, so I guess uid/gid offsets
> can be set by this?

It's good news for me.  I  investigated LTS version 5.10 and 5.15.  I
didn=E2=80=99t know this new feature.

My work detail, it's easy to share experimental patch in my github.
https://github.com/AGLExport/erofs-utils/commit/d9080b80152c2f9065d98a7a2ac=
36912c74657ac

That will use combination with lxc idmap option.

ex:
Image creation
mkafs.erofs --uid-offset=3D100000 --gid-offset=3D100000 .....

Lxc config
lxc.idmap =3D u 0 100000 65536
lxc.idmap =3D g 0 100000 65536


Thanks,
Naoto Yamaguchi,
a member of Automotive Grade Linux Instrument Cluster EG.
