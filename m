Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AE6E869A3F
	for <lists+linux-erofs@lfdr.de>; Tue, 27 Feb 2024 16:22:26 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=mbaynton-com.20230601.gappssmtp.com header.i=@mbaynton-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=gEq3y99N;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Tkh7415Szz3cZB
	for <lists+linux-erofs@lfdr.de>; Wed, 28 Feb 2024 02:22:24 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=mbaynton-com.20230601.gappssmtp.com header.i=@mbaynton-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=gEq3y99N;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=mbaynton.com (client-ip=2607:f8b0:4864:20::534; helo=mail-pg1-x534.google.com; envelope-from=mike@mbaynton.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tkh6x4V3Jz3bsd
	for <linux-erofs@lists.ozlabs.org>; Wed, 28 Feb 2024 02:22:17 +1100 (AEDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5ce942efda5so3478109a12.2
        for <linux-erofs@lists.ozlabs.org>; Tue, 27 Feb 2024 07:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbaynton-com.20230601.gappssmtp.com; s=20230601; t=1709047334; x=1709652134; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3TY5tinsK1U8Fdmrl7Ft+N7zoZve8+mNOTL5C82Wcy8=;
        b=gEq3y99NmQ8Ivg3L3luNgAwP9C7Vax5W9C/fWXjT7iySfpaaF07UJ79L7fZ7NIZLF2
         uaR+XTngPDw401hVha7IPjc6a83K45knVJztMwJtUwNXxgvUCcNH/6ZowUnaeqLqeg6m
         a2+lZDnSgkXDhS45bS7jotUMqmXC0EuJh67O8BopIfXAjwPuJihaNCYvZHWuVYkzjW3h
         9oE0k/3VRFVbj/4Rj2nMIPUtwKIhBWun1TNipDwCWyH+mXs7Wj5Z+S9vrwGBsgIAYllE
         ub0Na/cWnhTNIn2diNU5NOCZLrWh7iJ4hrbD1uKc/MwRa5/2qpEyj3Q5Zi7t0oK8Xfig
         ASNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047334; x=1709652134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TY5tinsK1U8Fdmrl7Ft+N7zoZve8+mNOTL5C82Wcy8=;
        b=mBpNJ+2QtYp1zwD5pqh+68NjzW+RD2yWh+vXe2bJbXwPl3HhmzRaALuCkYHkAH9GtY
         DKO/ekg8vEju30oPSZo701Ab5OS7Hruq33aa5qwmd0NJIgNfe1RfMiU/38kjrxgv0nPX
         qFM01Zhs2oeuleQ1mwsHNM0jlHXN07t9eNGWOPOFL9qoA4J5XkfEckl4J5YaxQHv6Kpm
         d4oI/Mvx6kSrQXqF79Vrji9S7KxGwpJx8/BwMXBoQLaHx4Cl5wTXllUw9sVaackF3JTQ
         2LN/Cqu9+n/CTa3+QzWYqPmflCyXU7NDiRLAK1vFeDrwg4kIKGWuSuxjQVBaoCMQN0Z6
         joTw==
X-Gm-Message-State: AOJu0YykkMmv0Lifi1rPG9jSJaW9ghfOGVJgBLc5DM2lEoKISsJ6XsNO
	KvGYqH1M6HyWtDx0RbPDJxuuz8gQiDBd39suuo83V0vNj+6JD3XH8pLtSr+Olbol/9wsxLKCVre
	5O6S2JYVzftCaEYNU7pelBs9PGtv7nrES/cSPRdFtw61rjmupt+Y=
X-Google-Smtp-Source: AGHT+IFAH26Or4aCzI/h+LloMO76KU+vHK2CK3mOCWxWGjTXwNaXeF7dW0nKGLhemRmHWsrqYgeo+sdcMeT8K2UMpfs=
X-Received: by 2002:a17:90a:728e:b0:299:3511:1554 with SMTP id
 e14-20020a17090a728e00b0029935111554mr8373234pjg.40.1709047334445; Tue, 27
 Feb 2024 07:22:14 -0800 (PST)
MIME-Version: 1.0
References: <20359e03-f7aa-4531-b0d1-b76e9950f233@linux.alibaba.com> <20240227084221.342635-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240227084221.342635-1-hsiangkao@linux.alibaba.com>
From: Mike Baynton <mike@mbaynton.com>
Date: Tue, 27 Feb 2024 09:22:03 -0600
Message-ID: <CAM56kJTvu7cQZmK5-6SKb=ObkHsYtG663gsRQOAndj=3UY-aaQ@mail.gmail.com>
Subject: Re: [PATCH v2] erofs-utils: mkfs: Support tar source without data
To: linux-erofs@lists.ozlabs.org
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
Cc: Gao Xiang <hsiangkao@linux.alibaba.com>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Tue, Feb 27, 2024 at 2:42=E2=80=AFAM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Hi Mike,
>   Just some minor changes for applying to -dev development codebase.
> Does it look good to you?
>   (I will apply this version to -experimental for testing.)

Looks pretty good to me, thank you! Looks like I should have created
the patch against -dev.

This modifies the --help text and includes tar twice, was that intentional?

 --tar=3DX               generate a full or index-only image from a
tarball(-ish) source
                       (X =3D f|i|headerball; f=3Dfull mode, i=3Dindex mode=
,
                                            headerball=3Dfile data is
omited in the source stream)
 --tar=3D[fi]            generate an image from tarball(s)
