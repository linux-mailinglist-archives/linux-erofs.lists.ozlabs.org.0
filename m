Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BC03F442C
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Aug 2021 06:25:11 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GtK0N5TnDz307v
	for <lists+linux-erofs@lfdr.de>; Mon, 23 Aug 2021 14:25:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=ewzl5+Xo;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::b2d;
 helo=mail-yb1-xb2d.google.com; envelope-from=bmeng.cn@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=ewzl5+Xo; dkim-atps=neutral
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com
 [IPv6:2607:f8b0:4864:20::b2d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4GtK0H6Dhnz2yLs
 for <linux-erofs@lists.ozlabs.org>; Mon, 23 Aug 2021 14:25:02 +1000 (AEST)
Received: by mail-yb1-xb2d.google.com with SMTP id k65so31544550yba.13
 for <linux-erofs@lists.ozlabs.org>; Sun, 22 Aug 2021 21:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3LDFMzyQL/mzKHZyVgysvmvnMZsaBYET9rLreiv/l8A=;
 b=ewzl5+Xo05zgRG3rfVKwYsOzBE0NbuZuESVlD9qBnaqfdQzE+PahY7DaoCVQuPMXW8
 3ndw3HN3mVaMgBT5Eivh50H0b1Sqd5harIAc0Plq9i1kSgwp6apP3poYVQFQZavpGwZi
 Dy1RfQ6HJTCoTQUCVoWPQo8ceC+orjddz3Q3Rwtg1sxGASOY8LlD41ZLoQI7SCiCwm6G
 XfbEu0Ft+aZVfJZgea4/TWStH/8SFyov2fakN7p0lbsX62PmwqVWxEn1PCkH1HobPmWS
 2vbmBjvPDbEgOTPXcr0LUCWG3z9Sl2l7+HJ9tZ0/fRMQ8kYAQTO6TJVLMGKWFjrSW7l/
 Cf5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3LDFMzyQL/mzKHZyVgysvmvnMZsaBYET9rLreiv/l8A=;
 b=g1+E87sN8GlJWiovVy/xOZUEvL9GNekOfjjVPPi5wyeNLyEzrOEA2+z/aVPOZF0aQM
 FqXXAplH5yhN1FTrGrE8B79vg1xcxlP0oluF1ZH8u4Nbp+KnIBypaK1PE8NIOYVQKP4i
 lja35qwS1zQ0+RJdwal40ax85vgBl30JFUWS7bpauV+NCOJcsaPSyG6AtQ7yM9u52x69
 YtkwxLhoJrm8Mv7+M3fBXF7xrlJJxuPUcxfaWGXvTSB8M0shaeBrGmitOcFSGsJ1jqPr
 f34JMhY7ZF3dr05NZIO0BbFX4i3sGDuKYnmEQiyp6PfGGTCiyO++4NJn2Xruy0ERDmQZ
 a8jg==
X-Gm-Message-State: AOAM530yQbzDdA7Wr6nlliI+stnR2H8m1AfeNOP3NZLovcxiiNkNOso8
 9nU/kWVVDznZhLLAIO+0OKIq9BfXYwsulXI4gvQ=
X-Google-Smtp-Source: ABdhPJxsxyyyHoLbFERT/CFw2f0WhxZPMLwZrDIgKQjAkDZk/kfEBqOJQQ8Hbcv94/CD8PQE+wJNISe1P4fqdvOPe+k=
X-Received: by 2002:a25:ac87:: with SMTP id x7mr805078ybi.332.1629692699374;
 Sun, 22 Aug 2021 21:24:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210822154843.10971-1-jnhuang95@gmail.com>
In-Reply-To: <20210822154843.10971-1-jnhuang95@gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 23 Aug 2021 12:24:48 +0800
Message-ID: <CAEUhbmU0Y7+-ZF5KQLi4=kaa06VLcbjs=_n7jdH1hZBgPSC69w@mail.gmail.com>
Subject: Re: [PATCH 1/3] fs/erofs: new filesystem
To: Huang Jianan <jnhuang95@gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Aug 23, 2021 at 12:03 AM Huang Jianan <jnhuang95@gmail.com> wrote:
>
> From: Huang Jianan <huangjianan@oppo.com>
>
> Add erofs filesystem support.
>
> The code is adapted from erofs-utils in order to reduce maintenance
> burden and keep with the latest feature.
>
> This patch mainly deals with uncompressed files.
>
> Signed-off-by: Huang Jianan <jnhuang95@gmail.com>

From and SoB should be the same person.

> ---
>  fs/Kconfig          |   1 +
>  fs/Makefile         |   1 +
>  fs/erofs/Kconfig    |  12 ++
>  fs/erofs/Makefile   |   7 +
>  fs/erofs/data.c     | 124 ++++++++++++++
>  fs/erofs/erofs_fs.h | 384 ++++++++++++++++++++++++++++++++++++++++++++
>  fs/erofs/fs.c       | 230 ++++++++++++++++++++++++++
>  fs/erofs/internal.h | 203 +++++++++++++++++++++++
>  fs/erofs/namei.c    | 238 +++++++++++++++++++++++++++
>  fs/erofs/super.c    |  65 ++++++++
>  fs/fs.c             |  22 +++
>  include/erofs.h     |  19 +++
>  include/fs.h        |   1 +
>  13 files changed, 1307 insertions(+)
>  create mode 100644 fs/erofs/Kconfig
>  create mode 100644 fs/erofs/Makefile
>  create mode 100644 fs/erofs/data.c
>  create mode 100644 fs/erofs/erofs_fs.h
>  create mode 100644 fs/erofs/fs.c
>  create mode 100644 fs/erofs/internal.h
>  create mode 100644 fs/erofs/namei.c
>  create mode 100644 fs/erofs/super.c
>  create mode 100644 include/erofs.h
>

Regards,
Bin
