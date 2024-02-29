Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED8886BF59
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Feb 2024 04:12:50 +0100 (CET)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=2s3sXLGH;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TlbrH4VSQz3cTT
	for <lists+linux-erofs@lfdr.de>; Thu, 29 Feb 2024 14:12:47 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sijam-com.20230601.gappssmtp.com header.i=@sijam-com.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=2s3sXLGH;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=sijam.com (client-ip=2607:f8b0:4864:20::112f; helo=mail-yw1-x112f.google.com; envelope-from=asai@sijam.com; receiver=lists.ozlabs.org)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tlbr83hMwz3bnL
	for <linux-erofs@lists.ozlabs.org>; Thu, 29 Feb 2024 14:12:40 +1100 (AEDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-6095dfcb461so4264097b3.2
        for <linux-erofs@lists.ozlabs.org>; Wed, 28 Feb 2024 19:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sijam-com.20230601.gappssmtp.com; s=20230601; t=1709176354; x=1709781154; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GQOLTBloVZrA5mzh4NkdsFj5TsuWAnL2cL4pdSsIY8I=;
        b=2s3sXLGHi15KsmvBYUB98/I3t8K4anOrs4AN4KUy7IzAiRYEJIHmu9RQfrRuA0JWP4
         LVwPrmdOWvPoPqJzRejLZ/95jSsYu2bksgpba7cXDld4T+HHYkcddaKis7Yl9JOqrXNn
         wJkHukD+XbHqp8kGbvymPIXvNoMf4lXmqhfav52D9Sm6h7NE3mSIzCTIox3UJ92K1Ngy
         Lcb2D3aUDt4z01tOWzKUK2IdXwdQ5/s1NMToNI+80yE1LsWO0/K3WU2Sk6YvGfw8qbYG
         PwoeiPSOte2GV/Rd57OLbLHLs0+UzWUuPrVcL0nkzpnFglo1TvJxFSdXm9Ew8cy9frly
         z56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709176354; x=1709781154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GQOLTBloVZrA5mzh4NkdsFj5TsuWAnL2cL4pdSsIY8I=;
        b=gu1LmH+UWpzmkwNxvvMpddL7IecrWiTPoAH4j+PfVDgYlxx6cvr1Srn3lM/P2OoR9W
         axpvEtICLPjG/9r41OdoSfonsx1n/wYicyIUOY7fon0QLnn8L02MEY3U0cVEr5KJz//j
         l+T4vAOkr5lQS91vCvU7VqISRaBYBtn8sVfEt3MVypD43G06l09QCTewXCjdhWDRkE10
         /1xk/HW7mBPe8eKSRGuEjyirS8FENu9Z8HRjiLjtc2RBGg/kFBQYSkNJMWHLPvlVCJqY
         gbf7LKOl1Lyg6f3HG8Jw/yeCCL1DPvvjflPRVS12dUsVrPWLxIC944cuySebSWtOQmRr
         xMSw==
X-Forwarded-Encrypted: i=1; AJvYcCVf5fGtpX/nE7WO4xWQSMFfRz+F5cQIMPODu/rWA1X2E3ViQWEPP2Qi+l44xJgMgV75xx0k5iLxYSA+uLwSzAVaKUIZUEfPAD8jayJS
X-Gm-Message-State: AOJu0YzrvyACdZmGqF0dcMYbj+5LCA4qrKrb/hsfoai4PFnUdRkKIZcz
	tiVRFvDeB4pjFHjlE83Bx5aJXJwfX64cXFzHOVnPAmMCapx84tec71zAPXsga1/n6b8DhbK0hw2
	15ne1j/2F0zxd5C7W05nsLu3+pS1uKyWH3LTcLw==
X-Google-Smtp-Source: AGHT+IGvhJtyPll2FWDtEcpJf/2w4ifRW49vrPxR/bOEKhY5Z5AT+4XQPa0mRHAlNggrTCDbDocKP6S0yts+A0l1RSY=
X-Received: by 2002:a5b:34d:0:b0:dc7:6f13:61e2 with SMTP id
 q13-20020a5b034d000000b00dc76f1361e2mr1270ybp.58.1709176354675; Wed, 28 Feb
 2024 19:12:34 -0800 (PST)
MIME-Version: 1.0
References: <20240225142759.340165-1-zhaoyifan@sjtu.edu.cn>
In-Reply-To: <20240225142759.340165-1-zhaoyifan@sjtu.edu.cn>
From: Noboru Asai <asai@sijam.com>
Date: Thu, 29 Feb 2024 12:12:23 +0900
Message-ID: <CAFoAo-+1crK3Oh7ftbWHk0WY7y-9=3ii3iX-W6anDvEfcgPJtg@mail.gmail.com>
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
Cc: hsiangkao@linux.alibaba.com, linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs" <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

> - remove inter-file compression support from this patchset

Do you have any problems about inter-file compression functionarity?
Or make steps (split this functionarity as separate patch set)?
I'm testing v1 patch set and I have no problem like making wrong images for=
 now.
(I couldn't apply v2 patch set without rejects.)

2024=E5=B9=B42=E6=9C=8825=E6=97=A5(=E6=97=A5) 23:28 Yifan Zhao <zhaoyifan@s=
jtu.edu.cn>:

>
> change log since v2:
> - squash per-worker tmpfile commit into previous PATCH
> - give static global variable `erofs_` prefix
> - remove inter-file compression support from this patchset
> - introduce a new `z_erofs_file_compress_ctx` struct to divide the segmen=
t
>   context from the file context
> - remove the patch related to pring warning from this patchset, which may=
 be
>   supported later with atomic variables
>
> Gao Xiang (1):
>   erofs-utils: add a helper to get available processors
>
> Yifan Zhao (3):
>   erofs-utils: introduce multi-threading framework
>   erofs-utils: mkfs: add --worker=3D# parameter
>   erofs-utils: mkfs: introduce inner-file multi-threaded compression
>
>  configure.ac              |  17 +
>  include/erofs/compress.h  |   1 +
>  include/erofs/config.h    |   5 +
>  include/erofs/internal.h  |   3 +
>  include/erofs/workqueue.h |  37 ++
>  lib/Makefile.am           |   4 +
>  lib/compress.c            | 690 +++++++++++++++++++++++++++++++-------
>  lib/compressor.c          |   2 +
>  lib/config.c              |  16 +
>  lib/workqueue.c           | 132 ++++++++
>  mkfs/main.c               |  38 +++
>  11 files changed, 827 insertions(+), 118 deletions(-)
>  create mode 100644 include/erofs/workqueue.h
>  create mode 100644 lib/workqueue.c
>
> --
> 2.44.0
>
