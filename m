Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FD244B0AE
	for <lists+linux-erofs@lfdr.de>; Tue,  9 Nov 2021 16:51:00 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HpXWk25vgz2yQw
	for <lists+linux-erofs@lfdr.de>; Wed, 10 Nov 2021 02:50:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=j4OElYzB;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:20::22c;
 helo=mail-lj1-x22c.google.com; envelope-from=daeho43@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=j4OElYzB; dkim-atps=neutral
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HpXWb0YfBz2yJ5
 for <linux-erofs@lists.ozlabs.org>; Wed, 10 Nov 2021 02:50:48 +1100 (AEDT)
Received: by mail-lj1-x22c.google.com with SMTP id e11so17934050ljo.13
 for <linux-erofs@lists.ozlabs.org>; Tue, 09 Nov 2021 07:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZPWANDd/Uy5JLY/W0viJSdKA3Q7++uwgk22nrGDJyYo=;
 b=j4OElYzBY6k6xOlBUMOgSolhZ7GqNHMDGA5CrwT4T9iss7VkixTh83FSpP1fu3vhWA
 mWfNjc56Cgyquq15LsCHFFqdz9HyFRL15hMuI05R/1vaN74HDH3Gmdfogc36+8MWGGce
 o0k+DefDgqiWD5S12gs3XcPPM7JSU2wheg9D09E0HCiK69d27185Bg5gYRpbMEgG1SFq
 05zH3zD1BZC0rbq5s6LqBIVtAPHKlbG1IeWR+Rx1JVX7dby7+mbLyHv+SCdaOlatiuqK
 FTiLOtEb2g/mvVR+R5fNrD2HyqTmXPXoFC0KXj4xIbuR9Ibua+q4nd7GMJUqtWGC43T1
 gM5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZPWANDd/Uy5JLY/W0viJSdKA3Q7++uwgk22nrGDJyYo=;
 b=5BsUXVEPTfl9yYTW0VJMBc7lxaViaK8LJmcGnOqaKcd2zH1gRZB2tLF95B0Z+OdOmo
 FCDDhUDkVVK97MYND6uPJKozJx1OKXiZAWz+8eoCn4fUYHTOsNPEHiGB2gNC7Iu3sAKV
 WEIvWbM3xrLfGkB5ULiGqJ1Qcy25Mxug1GUf5p1aCQQtzl5wrSpU5R3PGEup2I/3yYnL
 CK9MYov6h3mhvfwURyW6/rmJ+/laHaP4kwp5Psmq0sQGOBumsgqVX9o0JpDy2bHiJOka
 4BML6DJy9dMy9ChZ1377NU4h7WvLShCOovmZECBQ1DiIXspkZRP/OjBbIElS2bE5rym9
 moww==
X-Gm-Message-State: AOAM5331P6RO54NvnoEOcuwiWbA9BsQr/zUQTsJq6IvhblEtZ98B+ezG
 sv+n/wxH1Fdx35fqgiF1Cwp0+OPnnqBcrtiEEbE=
X-Google-Smtp-Source: ABdhPJwktgratRedrNDL1aQ3bGza9NCgi//HmCWaKz5ilpSeUC0oexc0LsfeNOsUDcRKX8nwJ4RK/fP3hnhoNd1VSPg=
X-Received: by 2002:a05:651c:612:: with SMTP id
 k18mr9222062lje.260.1636473039937; 
 Tue, 09 Nov 2021 07:50:39 -0800 (PST)
MIME-Version: 1.0
References: <20211029171312.2189648-1-daeho43@gmail.com>
 <YYpaySr6vGEfwduR@B-P7TQMD6M-0146.local>
In-Reply-To: <YYpaySr6vGEfwduR@B-P7TQMD6M-0146.local>
From: Daeho Jeong <daeho43@gmail.com>
Date: Tue, 9 Nov 2021 07:50:28 -0800
Message-ID: <CACOAw_zJgxwQnQTgcU4DfsxN5gFCgAONU4B3A1dR79ccJSLBfA@mail.gmail.com>
Subject: Re: [PATCH v3] erofs-utils: introduce fsck.erofs
To: Gao Xiang <hsiangkao@linux.alibaba.com>
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
Cc: Daeho Jeong <daehojeong@google.com>, linux-erofs@lists.ozlabs.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, miaoxie@huawei.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

2021=EB=85=84 11=EC=9B=94 9=EC=9D=BC (=ED=99=94) =EC=98=A4=EC=A0=84 3:26, G=
ao Xiang <hsiangkao@linux.alibaba.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> Hi Daeho,
>
> On Fri, Oct 29, 2021 at 10:13:12AM -0700, Daeho Jeong wrote:
> > From: Daeho Jeong <daehojeong@google.com>
> >
> > I made a fsck.erofs tool to check erofs filesystem image integrity
> > and calculate filesystem compression ratio.
> > Here are options to support now.
> >
> > fsck.erofs [options] IMAGE
> > -V      print the version number of fsck.erofs and exit.
> > -d#     set output message level to # (maximum 9)
> > -p      print total compression ratio of all files
> > -c      check if all compressed files are well decompressed
> >
> > Signed-off-by: Daeho Jeong <daehojeong@google.com>
>
> Applied with some minor updates, e.g. update .gitignore, etc.
> https://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs-utils.git/com=
mit/?id=3Df44043561491255c37903a9ad1334f2e88c95005
>
> Thanks,
> Gao Xiang

Hi Gao,

Many thanks~! :)

>
