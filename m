Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E556591D98
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Aug 2022 04:34:21 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M51hC0NM8z3bNj
	for <lists+linux-erofs@lfdr.de>; Sun, 14 Aug 2022 12:34:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Rs7/zZdh;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com; envelope-from=wata2ki@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=Rs7/zZdh;
	dkim-atps=neutral
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M51h7265cz2xHd
	for <linux-erofs@lists.ozlabs.org>; Sun, 14 Aug 2022 12:34:15 +1000 (AEST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-31f443e276fso41282337b3.1
        for <linux-erofs@lists.ozlabs.org>; Sat, 13 Aug 2022 19:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=uuDdH+gmqBKLKnNAFvghpVVJr8t7/HW2G029iBfAV+Y=;
        b=Rs7/zZdhX/bjU5XAXKbap0jJ8p4bYziszCStChYGPOgy2hFVAplYMWuHi7qTn45PS3
         6YOrn4yL5fmpc4pFSM9ked7sZ8zMvJXl35ahtwIiVI8MyCXuNPel2yYZRGnGiE7F1m9K
         Cky7/+4TO21DUo/t07mwie67GYmfuASx1kAE5OQqkCyoqnvlNXrOfxlodWJK6QJKMGvR
         FTfl6KWvEEPusThAt/m2IIjRo/y9qPRH/MwMC5m41eRBzfg2nUm+eb7uF8b3M/uWV5pf
         xdGZgsIAMEPjkc/IJlxKE8tNFb/ELi83ZZ6Y5Scnqv3R+6rhMK6/P0kNsSGT6cdC620A
         FEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=uuDdH+gmqBKLKnNAFvghpVVJr8t7/HW2G029iBfAV+Y=;
        b=rnypIiCVfITvdtYkzadw1dLltMuDjOILoK4+9quH4zAIl9fCIqO7CAD7Idl6t2rdhd
         MdRTt6gEwoDw64BxwtKBTNjM/TbuZWAcCuASWZ/+PXf0rQ21zHXHNuc3uF7QPHP7uEN1
         ikt3tVYTd2XV0FVeZ5eFv4f3T6Q04nB0I8w/DmqbSBdXUg0XbnUIZCI2NdZJLoQSgssd
         08XTlbBz32jr+WHp0m+L7tRoF00RFrnWajy8KnHPOE3QOt3lB6GZbHA2XdctFGDDJyov
         zkLjw4dtQl8EJMLazGryMGtGSgWQVumuQjQ8R77mNrYJ5g8XSqu2jAOmEbKQg1dT2lre
         Hw9g==
X-Gm-Message-State: ACgBeo02vigc6aPkMBs18M+aRLDZaTrMR/AsOuXS74hic3Sh3Gwlv6kU
	i7mqnMbdTS2Dkk3Zf5yeAvPA0WJfV7OcFYQQ1Vg=
X-Google-Smtp-Source: AA6agR5jZvvKm+OBEy9nGGaMV02MR3ARU8xAPys2py6VVyNfWUoANWTnuy58x6E/eYArSa4pJwYuI/R/JgKbzOgBnu4=
X-Received: by 2002:a0d:d6c8:0:b0:325:1853:1d1b with SMTP id
 y191-20020a0dd6c8000000b0032518531d1bmr9217753ywd.31.1660444451392; Sat, 13
 Aug 2022 19:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <CABBJnRbpAxGB644x=fBRK5GOrjxYawZE-zrhHnRHQbz5Lzp-CQ@mail.gmail.com>
 <YvKj8aZp/6bg/Nxv@debian> <CABBJnRaP8XWbKiYVxbtdiJ0ViFz0hhkwTPnBA004aetZx_5nhQ@mail.gmail.com>
 <YvKrs6J5zBPzFYpF@B-P7TQMD6M-0146.local> <CABBJnRYOHLX25FmB3rhmcqEHRS28NKwNAuEihi0JDj0NoQkoDg@mail.gmail.com>
 <20220812094941.00001031.zbestahu@gmail.com>
In-Reply-To: <20220812094941.00001031.zbestahu@gmail.com>
From: Naoto Yamaguchi <wata2ki@gmail.com>
Date: Sun, 14 Aug 2022 11:33:59 +0900
Message-ID: <CABBJnRbtr6S-d8-a+z1uhKQdH6V5gZF+J3GPnTSL+9v11gg+ow@mail.gmail.com>
Subject: Re: RFC: erofs-utils:mkfs: add unprivileged container use-case support
To: Yue Hu <zbestahu@gmail.com>
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Thank you Gao and Yue

I success to submit patch using app password.
Very thank you for your support.

Thanks,
Naoto Yamaguchi,
a member of Automotive Grade Linux Instrument Cluster EG.

2022=E5=B9=B48=E6=9C=8812=E6=97=A5(=E9=87=91) 10:47 Yue Hu <zbestahu@gmail.=
com>:
>
> Hi Naoto,
>
> On Fri, 12 Aug 2022 08:04:40 +0900
> Naoto Yamaguchi <wata2ki@gmail.com> wrote:
>
> > Hi Gao
> >
> > I created patch for submit,  but it couldn't send using git
> > send-email.   Google updated security, it blocked smtp based send
> > email by git maybe....
>
> As Xiang said, check below about 'app password' if you want:
>
> https://fmsinc.com/MicrosoftAccess/email/smtp/app-password/index.htm
>
> Thanks.
>
> >
> > Can I submit using github pull request to
> > https://github.com/hsiangkao/erofs-utils ?
> >
> > Thanks,
> > Naoto Yamaguchi,
> > a member of Automotive Grade Linux Instrument Cluster EG.
>
