Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E46486C559
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Feb 2024 10:34:24 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=A/aKsg0F;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TlmJY4zwkz3dT4
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Feb 2024 20:34:21 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=A/aKsg0F;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::b2d; helo=mail-yb1-xb2d.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org)
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4TlmJS0hjHz3brC
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Feb 2024 20:34:15 +1100 (AEDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso672354276.0
        for <linux-erofs@lists.ozlabs.org>; Thu, 29 Feb 2024 01:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20230601.gappssmtp.com; s=20230601; t=1709199252; x=1709804052; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhibCHMszhik6G8WLeIVE6eBDqoRnTSIe8Ohm/ky8I8=;
        b=A/aKsg0FrE+ujufPCYirrd0qCtO3cXlwxcUVs2BTAz26W83wRFu9LhgKF3pVezaRIJ
         cO27VB76kW276QXkTnK3cNCdbZmdzdfs8OwfDmHEmLnSq6J4eq2CkpuduHbQCS1m4YZD
         n0hrfWlhqbzBYHIjYf/tXZQtdysydHJgWisPQPcfsLUZR2zVIipr3MNnqh2SvdQ0VM5H
         rhTuRUZaUxU4N9Y9fMPodTSxfsnQT8+IFlp/6BcLu6MaFN0YV9sH9r9CwmByefkotekj
         c0ZtHnsBlCI1NLm9xuwi2/wmu1QUPBwQBzQXBIce6oX10CT/QCqzg3vjNR16av4CdC/P
         cddg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709199252; x=1709804052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhibCHMszhik6G8WLeIVE6eBDqoRnTSIe8Ohm/ky8I8=;
        b=ObxcImx3d25RlWzXZYClSVRHpoIixSUvOYD2VVr18PxnqRS9Gsic2e2jvXhaTMW7hq
         NnZljINsHgxyaV83suEUEOCnoSdV9aliLtedDlPpBN4mrtUfnh0G5+GclYaYhOOmTGzO
         Ev9TZ1obGkP6W1vzc2qlEW/GqWXSBqb+kMLnGKlPUcxtZRRJa2l2BQyEaovnpA75NWKf
         FuT9OViaiZG0dtwCVIa0CGw93BMBb/3QqrKeeMMvhx5HUI4kzLlBIkp9sjIQLKpJ3yK/
         7lgtRnqpYYH01BgHJq63pm3vQlmZgrDBSEiayKHrLduLm1zJGPzMvsV2JiF4R1q8YTFy
         8Npg==
X-Gm-Message-State: AOJu0YzBGo+HMQrQHr6pSPDJLs+fUMAvDON9b5PMjwfORsTA+n6eRXoD
	ou0YJyEIsiOcHOGyvwVs/UDt3ThRoZEZeMKgkLljBRJlfd8FtUWccD2mTsPYkCsBRe2Kj58MZYH
	qjXsJedQUU3ZlGWuuAmTpDyxyvWjopjYhLnWhYqKbTOkj4QZXdt4=
X-Google-Smtp-Source: AGHT+IFY/laeR1ERu087nVVoQxGrf9M4IAMcaBjNISnOBIodpUWaQHxOOoh1j/v+6Gi0niA2RRBB2xMn0m5Ac6016Hc=
X-Received: by 2002:a5b:10f:0:b0:dbf:6267:eba4 with SMTP id
 15-20020a5b010f000000b00dbf6267eba4mr1556730ybx.27.1709199252052; Thu, 29 Feb
 2024 01:34:12 -0800 (PST)
MIME-Version: 1.0
References: <20240225142759.340165-1-zhaoyifan@sjtu.edu.cn>
 <CAFoAo-+1crK3Oh7ftbWHk0WY7y-9=3ii3iX-W6anDvEfcgPJtg@mail.gmail.com> <a59dfa27-0961-472a-b7ed-57769123d430@sjtu.edu.cn>
In-Reply-To: <a59dfa27-0961-472a-b7ed-57769123d430@sjtu.edu.cn>
From: Noboru Asai <asai@sijam.com>
Date: Thu, 29 Feb 2024 18:34:01 +0900
Message-ID: <CAFoAo-KCoKneBm2F-didrKGKGVu--A0JH3gNqV0weanVwgScUw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] erofs-utils: mkfs: introduce multi-threaded compression
To: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

> We split the inter-file compression functionality as a separate patch
> set for ease of review. It will be re-sent shortly (maybe a few days)
> after we finish polishing the inner-file patch set.
>
> I am sorry that the v2 patchset cannot be cleanly applied due to my
> missteps, and I believe the latest one (v4) works. Thank you for your
> testing!

Thank you your explanation. I will test v4 and review it.

2024=E5=B9=B42=E6=9C=8829=E6=97=A5(=E6=9C=A8) 13:33 Yifan Zhao <zhaoyifan@s=
jtu.edu.cn>:
>
>
> On 2/29/24 11:12, Noboru Asai wrote:
> >> - remove inter-file compression support from this patchset
> > Do you have any problems about inter-file compression functionarity?
> > Or make steps (split this functionarity as separate patch set)?
> > I'm testing v1 patch set and I have no problem like making wrong images=
 for now.
> > (I couldn't apply v2 patch set without rejects.)
> >
> > 2024=E5=B9=B42=E6=9C=8825=E6=97=A5(=E6=97=A5) 23:28 Yifan Zhao <zhaoyif=
an@sjtu.edu.cn>:
> >
> We split the inter-file compression functionality as a separate patch
> set for ease of review. It will be re-sent shortly (maybe a few days)
> after we finish polishing the inner-file patch set.
>
> I am sorry that the v2 patchset cannot be cleanly applied due to my
> missteps, and I believe the latest one (v4) works. Thank you for your
> testing!
>
>
> Thanks,
>
> Yifan Zhao
>
> >> change log since v2:
> >> - squash per-worker tmpfile commit into previous PATCH
> >> - give static global variable `erofs_` prefix
> >> - remove inter-file compression support from this patchset
> >> - introduce a new `z_erofs_file_compress_ctx` struct to divide the seg=
ment
> >>    context from the file context
> >> - remove the patch related to pring warning from this patchset, which =
may be
> >>    supported later with atomic variables
> >>
> >> Gao Xiang (1):
> >>    erofs-utils: add a helper to get available processors
> >>
> >> Yifan Zhao (3):
> >>    erofs-utils: introduce multi-threading framework
> >>    erofs-utils: mkfs: add --worker=3D# parameter
> >>    erofs-utils: mkfs: introduce inner-file multi-threaded compression
> >>
> >>   configure.ac              |  17 +
> >>   include/erofs/compress.h  |   1 +
> >>   include/erofs/config.h    |   5 +
> >>   include/erofs/internal.h  |   3 +
> >>   include/erofs/workqueue.h |  37 ++
> >>   lib/Makefile.am           |   4 +
> >>   lib/compress.c            | 690 +++++++++++++++++++++++++++++++-----=
--
> >>   lib/compressor.c          |   2 +
> >>   lib/config.c              |  16 +
> >>   lib/workqueue.c           | 132 ++++++++
> >>   mkfs/main.c               |  38 +++
> >>   11 files changed, 827 insertions(+), 118 deletions(-)
> >>   create mode 100644 include/erofs/workqueue.h
> >>   create mode 100644 lib/workqueue.c
> >>
> >> --
> >> 2.44.0
> >>
