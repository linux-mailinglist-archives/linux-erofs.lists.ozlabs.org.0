Return-Path: <linux-erofs+bounces-3168-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJMwOlwKzmkwkgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3168-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:19:08 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 183AF38463C
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:19:08 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmWs56qqsz2yYK;
	Thu, 02 Apr 2026 17:19:05 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=115.124.28.54
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775110745;
	cv=none; b=JAdXNofWJ/DV4e1S1f4D8mGrcEmDJCy9FZZuKlU6Qg8DjiOsut1osP04zMC2ewTuPNm5RPYnsgLhi1+mmucAAUiW6BQPYMHANS1yLZ4sHO9Ngab+CIvSlM1qRfBrxqW4gtULcohx9xXSxSyZi2dhZQYduMafS/32BP0GfH8N9aLDY7xyumW7JNCpHFO/nCoj1lFDhI6z8sPqQQPf+jGMKhK9GH9EXgt40yaSuPR3e2O4L+pfypuwPWa4TwzlLYMjdcs27uOm6BE64exLhquiwag7qPlTaYGLQ8/syQnmntf6SW2T8WDum2kUQShKbOqbvlvjQ8/dNJKwoGqLf485jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775110745; c=relaxed/relaxed;
	bh=DY9d+H66AT6/2taPUzRSy4vUW6aWz5JmsgfHjNZRFAo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cs0uaEclIvSRGwU2DdEPV45Lj00VQsNzZ2noKB4Arc6Ykz2RMt9whYHFO/dgz0Exag90HVoNZR4mOEZ5k+6UAQgh8GlJYctuqbBzg/bv6xjd6GFyJwMUZ5Pq47H/f02d7ja17WVbtk/wskcfaRwDAhJkL2HCZMYX/Ac6ZNQVL7hFBxjGPdA98g3Ay7DCmHkHdGnSxB8Vlc2WBciLxh9geoCUBF1ltPTuE64Sp8hUTKHvZkNlwDwyIJQn5Uxnrx1V9A98TLlkxQH2IDFajapeTq9i+wXpUDBnqbYwxurep4Fuxm7NBNi1I6TlkcHVaB2i1pttjLxd3A10SvXdjtABXQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com; spf=pass (client-ip=115.124.28.54; helo=out28-54.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org) smtp.mailfrom=cyzhu.com
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=cyzhu.com
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cyzhu.com (client-ip=115.124.28.54; helo=out28-54.mail.aliyun.com; envelope-from=hudson@cyzhu.com; receiver=lists.ozlabs.org)
Received: from out28-54.mail.aliyun.com (out28-54.mail.aliyun.com [115.124.28.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmWs50FmRz2ySk
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 17:19:04 +1100 (AEDT)
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.06788492|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0338976-0.00911713-0.956985;FP=9794852074026476709|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033068016216;MF=hudson@cyzhu.com;NM=1;PH=DS;RN=2;RT=2;SR=0;TI=SMTPD_---.h3P5aJy_1775110703;
Received: from smtpclient.apple(mailfrom:hudson@cyzhu.com fp:SMTPD_---.h3P5aJy_1775110703 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 02 Apr 2026 14:19:00 +0800
Content-Type: text/plain;
	charset=utf-8
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: [PATCH 2/2] erofs-utils: switch other source files into MIT
 license
From: hudsonZhu <hudson@cyzhu.com>
In-Reply-To: <20260402060907.2268323-2-hsiangkao@linux.alibaba.com>
Date: Thu, 2 Apr 2026 14:18:49 +0800
Cc: linux-erofs@lists.ozlabs.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <259FC907-213F-4D0E-AC69-2015D9D15F62@cyzhu.com>
References: <20260402060907.2268323-1-hsiangkao@linux.alibaba.com>
 <20260402060907.2268323-2-hsiangkao@linux.alibaba.com>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)
X-Spam-Status: No, score=0.0 required=3.0 tests=RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-1.00 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[cyzhu.com];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-3168-lists,linux-erofs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	TO_DN_SOME(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[hudson@cyzhu.com,linux-erofs@lists.ozlabs.org];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,autogen.sh:url,huawei.com:url,makefile.am:url,sjtu.edu.cn:email,tencent.com:email]
X-Rspamd-Queue-Id: 183AF38463C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reviewed-by: Chengyu Zhu <hudsonzhu@tencent.com>

> 2026=E5=B9=B44=E6=9C=882=E6=97=A5 14:09=EF=BC=8CGao Xiang =
<hsiangkao@linux.alibaba.com> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Let's switch other source files to MIT license since we're absolutely
> NOT working on secret rocket science, so licenses should not be
> a bottleneck to innovation in the Cloud Native and AI era.
>=20
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> COPYING                    | 14 +++++++-------
> Makefile.am                |  2 +-
> autogen.sh                 |  2 +-
> contrib/Makefile.am        |  2 +-
> contrib/stress.c           |  2 +-
> dump/Makefile.am           |  2 +-
> dump/main.c                |  2 +-
> fsck/Makefile.am           |  2 +-
> fsck/main.c                |  2 +-
> fuse/Makefile.am           |  2 +-
> fuse/macosx.h              |  2 +-
> fuse/main.c                |  2 +-
> man/Makefile.am            |  2 +-
> mkfs/Makefile.am           |  2 +-
> mkfs/main.c                |  2 +-
> mount/Makefile.am          |  2 +-
> mount/main.c               |  2 +-
> scripts/get-version-number |  2 +-
> 18 files changed, 24 insertions(+), 24 deletions(-)
>=20
> diff --git a/COPYING b/COPYING
> index e781cc21ff15..81aee791f173 100644
> --- a/COPYING
> +++ b/COPYING
> @@ -3,13 +3,13 @@ erofs-utils uses two different license patterns:
>  - most liberofs files in `lib` and `include` directories
>    use GPL-2.0+ OR MIT dual license;
>=20
> - - all other files use GPL-2.0+ license, unless
> -   explicitly stated otherwise.
> + - all other files use MIT license, unless explicitly stated
> +   otherwise.
>=20
> Relevant licenses can be found in the LICENSES directory.
>=20
> -This model is selected to emphasize that
> -files in `lib` and `include` directories are designed to be included =
in
> -3rd-party applications, while all other files are intended to be used
> -"as is", as part of their intended scenarios, with no intention to
> -support 3rd-party integration use cases.
> +This model is selected to emphasize that erofs-utils can be =
integrated
> +into various ecosystems as much as possible.
> +
> +However, liberofs should be GPL-2.0+ OR MIT dual license since some
> +parts can be shared with the Linux kernel.
> diff --git a/Makefile.am b/Makefile.am
> index 7cb93a697627..e79222e965a9 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0+
> +# SPDX-License-Identifier: MIT
>=20
> ACLOCAL_AMFLAGS =3D -I m4
>=20
> diff --git a/autogen.sh b/autogen.sh
> index fd81db4d6fb3..89c510c35cab 100755
> --- a/autogen.sh
> +++ b/autogen.sh
> @@ -1,5 +1,5 @@
> #!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0+
> +# SPDX-License-Identifier: MIT
>=20
> aclocal && \
> autoheader && \
> diff --git a/contrib/Makefile.am b/contrib/Makefile.am
> index 4eb7abed8856..5bedb9441b2e 100644
> --- a/contrib/Makefile.am
> +++ b/contrib/Makefile.am
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0+
> +# SPDX-License-Identifier: MIT
> # Makefile.am
>=20
> AUTOMAKE_OPTIONS	=3D foreign
> diff --git a/contrib/stress.c b/contrib/stress.c
> index 0ef8c67c126b..65773bce9e27 100644
> --- a/contrib/stress.c
> +++ b/contrib/stress.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: MIT
> /*
>  * stress test for EROFS filesystem
>  *
> diff --git a/dump/Makefile.am b/dump/Makefile.am
> index c2e0c745a640..2611fd28c762 100644
> --- a/dump/Makefile.am
> +++ b/dump/Makefile.am
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0+
> +# SPDX-License-Identifier: MIT
> # Makefile.am
>=20
> AUTOMAKE_OPTIONS =3D foreign
> diff --git a/dump/main.c b/dump/main.c
> index 78c50d511587..6c7258a5db40 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: MIT
> /*
>  * Copyright (C) 2021-2022 HUAWEI, Inc.
>  *             http://www.huawei.com/
> diff --git a/fsck/Makefile.am b/fsck/Makefile.am
> index 488b401c8995..8eebadd7d1e5 100644
> --- a/fsck/Makefile.am
> +++ b/fsck/Makefile.am
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0+
> +# SPDX-License-Identifier: MIT
> # Makefile.am
>=20
> AUTOMAKE_OPTIONS =3D foreign
> diff --git a/fsck/main.c b/fsck/main.c
> index 16a354f460a8..21ada195edab 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: MIT
> /*
>  * Copyright 2021 Google LLC
>  * Author: Daeho Jeong <daehojeong@google.com>
> diff --git a/fuse/Makefile.am b/fuse/Makefile.am
> index 1e8f518bad1d..9fe560849336 100644
> --- a/fuse/Makefile.am
> +++ b/fuse/Makefile.am
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0+
> +# SPDX-License-Identifier: MIT
>=20
> AUTOMAKE_OPTIONS =3D foreign
> noinst_HEADERS =3D $(top_srcdir)/fuse/macosx.h
> diff --git a/fuse/macosx.h b/fuse/macosx.h
> index 81ac47f551d6..4bb4bb75d5a2 100644
> --- a/fuse/macosx.h
> +++ b/fuse/macosx.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: MIT */
> #ifdef __APPLE__
> #undef LIST_HEAD
> #endif
> diff --git a/fuse/main.c b/fuse/main.c
> index b6347828eacf..40f8684abe43 100644
> --- a/fuse/main.c
> +++ b/fuse/main.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: MIT
> /*
>  * Created by Li Guifu <blucerlee@gmail.com>
>  * Lowlevel added by Li Yiyan <lyy0627@sjtu.edu.cn>
> diff --git a/man/Makefile.am b/man/Makefile.am
> index b9b598954725..88bf3a16d995 100644
> --- a/man/Makefile.am
> +++ b/man/Makefile.am
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0+
> +# SPDX-License-Identifier: MIT
>=20
> dist_man_MANS =3D mkfs.erofs.1 dump.erofs.1 fsck.erofs.1
>=20
> diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
> index aaefc11dadc3..386455aced67 100644
> --- a/mkfs/Makefile.am
> +++ b/mkfs/Makefile.am
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0+
> +# SPDX-License-Identifier: MIT
>=20
> AUTOMAKE_OPTIONS =3D foreign
> bin_PROGRAMS     =3D mkfs.erofs
> diff --git a/mkfs/main.c b/mkfs/main.c
> index eb13abaec92b..5006f76fa73b 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: MIT
> /*
>  * Copyright (C) 2018-2019 HUAWEI, Inc.
>  *             http://www.huawei.com/
> diff --git a/mount/Makefile.am b/mount/Makefile.am
> index 7f6efd8b7cf5..637029d4475a 100644
> --- a/mount/Makefile.am
> +++ b/mount/Makefile.am
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0+
> +# SPDX-License-Identifier: MIT
> # Makefile.am
>=20
> AUTOMAKE_OPTIONS =3D foreign
> diff --git a/mount/main.c b/mount/main.c
> index b6a2deca4d85..e09e58533ecc 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: MIT
> #define _GNU_SOURCE
> #include <dirent.h>
> #include <fcntl.h>
> diff --git a/scripts/get-version-number b/scripts/get-version-number
> index d216b7a424e0..484baebf53c6 100755
> --- a/scripts/get-version-number
> +++ b/scripts/get-version-number
> @@ -1,5 +1,5 @@
> #!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> +# SPDX-License-Identifier: MIT
>=20
> scm_version()
> {
> --=20
> 2.43.5
>=20


