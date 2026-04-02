Return-Path: <linux-erofs+bounces-3175-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +K0WERYOzmmnkgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3175-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:35:02 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57CC0384889
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:35:01 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmXCQ5Rp9z2ySk;
	Thu, 02 Apr 2026 17:34:58 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.224
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775111698;
	cv=none; b=iQmBBJeWftnfvjZUm6Bg9/pup8xfX5hZVqEzO+K16Lj1eBnDC1RuCJfMjB8Fv8wMJGrXhhaz424qVAiT9UqdY8vE+hSF2odgCTYKJw++L1mUl1gd1OtqwBHRz3LVZ5DI0jKrbB7K4kr5XYe93czxCf8Z0ypGBytn5gaYQ09xuazO+QfTh5DDQ+74OVuYDIN7kYg/sXy0A+xiJZPWnEaX8T4aZzPUaJik3waV2hjgPWeamnW7RH6TTvw8iIv75M+X78Iu62mJJQeAg3CNAjgYwRI4e9CH88xxiR4/mU4swMweMrEGbE63GqJAqUWsruyevrL36XE3qjRdX7kOzHgKdg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775111698; c=relaxed/relaxed;
	bh=VA4zEmasQ1mR5OEAJ10bkJ3EEuWrPT6h+G6ykxpJ8jU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ltBc42DxbD9tsnYrUeC1Kw/HUn2yn8QBXnquZhGFlDcJG/X/GjDlFG5cM7J0xTrSpUxJpidSbJV5GlM1FKlThQHHk+/rVpwbyLaVxMos5q29DVh90gd7kYw0HM/nI37B80F22SHs0YMrVemjf+JsPiirsIYNXevJ7u3onDlJj7Of1CLNL08SRoeDtoGkGuhbz1ycVyL0FIzG/sq6mjP+eyKwxRwG5q/DnqEgt4tSsGs9x3Z4jP4U/XhH8FA2e0h3776kiEy2+6Ih5k0cc5BUBan5fZbdltD5SAai+hQSbK3LQw/ETJazho58pnk4tdZdJ8wHoHig4/qGre9j+yMaWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=asEs6OIZ; dkim-atps=neutral; spf=pass (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=asEs6OIZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.224; helo=canpmsgout09.his.huawei.com; envelope-from=lihongbo22@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmXCP3fZkz2xln
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 17:34:57 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=VA4zEmasQ1mR5OEAJ10bkJ3EEuWrPT6h+G6ykxpJ8jU=;
	b=asEs6OIZCG+VLNz/Z/Fk6BgXE7wiWl1+z4ycBy6zB4/o4RMXWwJ13HFvO8FpOvpMdT3BSoraq
	S6d+lw8Kz5YB/XcrDDTZTF/TAT3U6xUd7jC2RTGWXxFv+2GQxgfNoi6rSe71rHvDr0QQpzLsUlV
	igFrkQ6oPEMUaIzaGHZcZyQ=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4fmX4D3Byfz1cyTN
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 Apr 2026 14:28:44 +0800 (CST)
Received: from kwepemr500015.china.huawei.com (unknown [7.202.195.162])
	by mail.maildlp.com (Postfix) with ESMTPS id 0630C4048B
	for <linux-erofs@lists.ozlabs.org>; Thu,  2 Apr 2026 14:34:54 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 kwepemr500015.china.huawei.com (7.202.195.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 2 Apr 2026 14:34:53 +0800
Message-ID: <2cc4b2c4-82a6-4d66-971f-8a3524bb0dd1@huawei.com>
Date: Thu, 2 Apr 2026 14:34:52 +0800
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
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] erofs-utils: switch other source files into MIT
 license
Content-Language: en-US
To: <linux-erofs@lists.ozlabs.org>
References: <20260402060907.2268323-1-hsiangkao@linux.alibaba.com>
 <20260402060907.2268323-2-hsiangkao@linux.alibaba.com>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20260402060907.2268323-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.111.104]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemr500015.china.huawei.com (7.202.195.162)
X-Spam-Status: No, score=-0.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=disabled
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-25) on lists.ozlabs.org
X-Spamd-Result: default: False [-2.20 / 15.00];
	ARC_ALLOW(-1.00)[lists.ozlabs.org:s=201707:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2404:9400:21b9:f100::1:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.19)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-3175-lists,linux-erofs=lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-erofs];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[lihongbo22@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	MID_RHS_MATCH_FROM(0.00)[];
	HAS_XOIP(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	DBL_BLOCKED_OPENRESOLVER(0.00)[autogen.sh:url,makefile.am:url,huawei.com:dkim,huawei.com:mid,huawei.com:email,huawei.com:url,lists.ozlabs.org:helo,lists.ozlabs.org:rdns,sjtu.edu.cn:email,alibaba.com:email]
X-Rspamd-Queue-Id: 57CC0384889
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 2026/4/2 14:09, Gao Xiang wrote:
> Let's switch other source files to MIT license since we're absolutely
> NOT working on secret rocket science, so licenses should not be
> a bottleneck to innovation in the Cloud Native and AI era.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Hongbo Li <lihongbo22@huawei.com>

Thanks,
Hongbo

> ---
>   COPYING                    | 14 +++++++-------
>   Makefile.am                |  2 +-
>   autogen.sh                 |  2 +-
>   contrib/Makefile.am        |  2 +-
>   contrib/stress.c           |  2 +-
>   dump/Makefile.am           |  2 +-
>   dump/main.c                |  2 +-
>   fsck/Makefile.am           |  2 +-
>   fsck/main.c                |  2 +-
>   fuse/Makefile.am           |  2 +-
>   fuse/macosx.h              |  2 +-
>   fuse/main.c                |  2 +-
>   man/Makefile.am            |  2 +-
>   mkfs/Makefile.am           |  2 +-
>   mkfs/main.c                |  2 +-
>   mount/Makefile.am          |  2 +-
>   mount/main.c               |  2 +-
>   scripts/get-version-number |  2 +-
>   18 files changed, 24 insertions(+), 24 deletions(-)
> 
> diff --git a/COPYING b/COPYING
> index e781cc21ff15..81aee791f173 100644
> --- a/COPYING
> +++ b/COPYING
> @@ -3,13 +3,13 @@ erofs-utils uses two different license patterns:
>    - most liberofs files in `lib` and `include` directories
>      use GPL-2.0+ OR MIT dual license;
>   
> - - all other files use GPL-2.0+ license, unless
> -   explicitly stated otherwise.
> + - all other files use MIT license, unless explicitly stated
> +   otherwise.
>   
>   Relevant licenses can be found in the LICENSES directory.
>   
> -This model is selected to emphasize that
> -files in `lib` and `include` directories are designed to be included in
> -3rd-party applications, while all other files are intended to be used
> -"as is", as part of their intended scenarios, with no intention to
> -support 3rd-party integration use cases.
> +This model is selected to emphasize that erofs-utils can be integrated
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
>   
>   ACLOCAL_AMFLAGS = -I m4
>   
> diff --git a/autogen.sh b/autogen.sh
> index fd81db4d6fb3..89c510c35cab 100755
> --- a/autogen.sh
> +++ b/autogen.sh
> @@ -1,5 +1,5 @@
>   #!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0+
> +# SPDX-License-Identifier: MIT
>   
>   aclocal && \
>   autoheader && \
> diff --git a/contrib/Makefile.am b/contrib/Makefile.am
> index 4eb7abed8856..5bedb9441b2e 100644
> --- a/contrib/Makefile.am
> +++ b/contrib/Makefile.am
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0+
> +# SPDX-License-Identifier: MIT
>   # Makefile.am
>   
>   AUTOMAKE_OPTIONS	= foreign
> diff --git a/contrib/stress.c b/contrib/stress.c
> index 0ef8c67c126b..65773bce9e27 100644
> --- a/contrib/stress.c
> +++ b/contrib/stress.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: MIT
>   /*
>    * stress test for EROFS filesystem
>    *
> diff --git a/dump/Makefile.am b/dump/Makefile.am
> index c2e0c745a640..2611fd28c762 100644
> --- a/dump/Makefile.am
> +++ b/dump/Makefile.am
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0+
> +# SPDX-License-Identifier: MIT
>   # Makefile.am
>   
>   AUTOMAKE_OPTIONS = foreign
> diff --git a/dump/main.c b/dump/main.c
> index 78c50d511587..6c7258a5db40 100644
> --- a/dump/main.c
> +++ b/dump/main.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: MIT
>   /*
>    * Copyright (C) 2021-2022 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/fsck/Makefile.am b/fsck/Makefile.am
> index 488b401c8995..8eebadd7d1e5 100644
> --- a/fsck/Makefile.am
> +++ b/fsck/Makefile.am
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0+
> +# SPDX-License-Identifier: MIT
>   # Makefile.am
>   
>   AUTOMAKE_OPTIONS = foreign
> diff --git a/fsck/main.c b/fsck/main.c
> index 16a354f460a8..21ada195edab 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: MIT
>   /*
>    * Copyright 2021 Google LLC
>    * Author: Daeho Jeong <daehojeong@google.com>
> diff --git a/fuse/Makefile.am b/fuse/Makefile.am
> index 1e8f518bad1d..9fe560849336 100644
> --- a/fuse/Makefile.am
> +++ b/fuse/Makefile.am
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0+
> +# SPDX-License-Identifier: MIT
>   
>   AUTOMAKE_OPTIONS = foreign
>   noinst_HEADERS = $(top_srcdir)/fuse/macosx.h
> diff --git a/fuse/macosx.h b/fuse/macosx.h
> index 81ac47f551d6..4bb4bb75d5a2 100644
> --- a/fuse/macosx.h
> +++ b/fuse/macosx.h
> @@ -1,4 +1,4 @@
> -/* SPDX-License-Identifier: GPL-2.0+ */
> +/* SPDX-License-Identifier: MIT */
>   #ifdef __APPLE__
>   #undef LIST_HEAD
>   #endif
> diff --git a/fuse/main.c b/fuse/main.c
> index b6347828eacf..40f8684abe43 100644
> --- a/fuse/main.c
> +++ b/fuse/main.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: MIT
>   /*
>    * Created by Li Guifu <blucerlee@gmail.com>
>    * Lowlevel added by Li Yiyan <lyy0627@sjtu.edu.cn>
> diff --git a/man/Makefile.am b/man/Makefile.am
> index b9b598954725..88bf3a16d995 100644
> --- a/man/Makefile.am
> +++ b/man/Makefile.am
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0+
> +# SPDX-License-Identifier: MIT
>   
>   dist_man_MANS = mkfs.erofs.1 dump.erofs.1 fsck.erofs.1
>   
> diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
> index aaefc11dadc3..386455aced67 100644
> --- a/mkfs/Makefile.am
> +++ b/mkfs/Makefile.am
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0+
> +# SPDX-License-Identifier: MIT
>   
>   AUTOMAKE_OPTIONS = foreign
>   bin_PROGRAMS     = mkfs.erofs
> diff --git a/mkfs/main.c b/mkfs/main.c
> index eb13abaec92b..5006f76fa73b 100644
> --- a/mkfs/main.c
> +++ b/mkfs/main.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: MIT
>   /*
>    * Copyright (C) 2018-2019 HUAWEI, Inc.
>    *             http://www.huawei.com/
> diff --git a/mount/Makefile.am b/mount/Makefile.am
> index 7f6efd8b7cf5..637029d4475a 100644
> --- a/mount/Makefile.am
> +++ b/mount/Makefile.am
> @@ -1,4 +1,4 @@
> -# SPDX-License-Identifier: GPL-2.0+
> +# SPDX-License-Identifier: MIT
>   # Makefile.am
>   
>   AUTOMAKE_OPTIONS = foreign
> diff --git a/mount/main.c b/mount/main.c
> index b6a2deca4d85..e09e58533ecc 100644
> --- a/mount/main.c
> +++ b/mount/main.c
> @@ -1,4 +1,4 @@
> -// SPDX-License-Identifier: GPL-2.0+
> +// SPDX-License-Identifier: MIT
>   #define _GNU_SOURCE
>   #include <dirent.h>
>   #include <fcntl.h>
> diff --git a/scripts/get-version-number b/scripts/get-version-number
> index d216b7a424e0..484baebf53c6 100755
> --- a/scripts/get-version-number
> +++ b/scripts/get-version-number
> @@ -1,5 +1,5 @@
>   #!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0
> +# SPDX-License-Identifier: MIT
>   
>   scm_version()
>   {

