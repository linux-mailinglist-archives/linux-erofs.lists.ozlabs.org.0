Return-Path: <linux-erofs+bounces-3170-lists+linux-erofs=lfdr.de@lists.ozlabs.org>
Delivered-To: lists+linux-erofs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHyVJm0KzmkwkgYAu9opvQ
	(envelope-from <linux-erofs+bounces-3170-lists+linux-erofs=lfdr.de@lists.ozlabs.org>)
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:19:25 +0200
X-Original-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:21b9:f100::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1988384661
	for <lists+linux-erofs@lfdr.de>; Thu, 02 Apr 2026 08:19:24 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fmWsQ52QGz2yYy;
	Thu, 02 Apr 2026 17:19:22 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=113.46.200.225
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775110762;
	cv=none; b=W46LppR+lDbSgROSwMSLknldek1VfTLGNJFAXUNwNspPVspd7S+rLEkiTAcr8bj8+wwToGpEEq89qd56j9hZU/0urB+fONSkDPGeybQcaeQGKYBSAo6gX82medsOvzjAY/D3UnicOwzI6JR6rRl7xJrviM54BZMKTTLJQnRhtwlmH4wgHUruAR0cERdK3F8ndAKYg/yZXleaVbUaHjELTY2kzxfCrf7H762OaRseSN7i/VmGUxgcRo8v7xjDDGcTyeEQ+cta5/8VbY3EjhpMqOE8hqZxmxrDlsacgm5nt2L77C3YkBHH+kWiuBqmnFXFRDkT0FWoWvDmTGf6z/IUIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775110762; c=relaxed/relaxed;
	bh=sj+HfzhnKq6uQPmrjT2y6BaE+fu3UcY66B6Rw4KMRuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=H33tl2FnYkJmwjLIAjWUwy6UX7j4JCxyBS/PEvUi1rDTyFLp7rv5p90wA/vxjzpw6Mq5e5cyUZscNfOfkdSotIIroANo2B7vmJILKiBfoGCkMD6UtWA1KrusunPaSSi3Xtoa4FtRlBRfu7FZHIZfuw0Y0T71JxiNzq115Vnzpxye4bAEVjESmF8Z0QlwNNJLwmBX1aZzjQ3rilr/KVmAm7WKHF75wUxiYHFs7H46Tr4AxdhxdmfqAl6UcLRZ95cn0aevFfgj3DEcv3AdE9hLxKVeFWVm6wX2EeZlYb+l5VzGCS5S+9psSSFApWVoaUY0J8T19Z6LZjU5tiYoyGSBFw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3WmbuUyJ; dkim-atps=neutral; spf=pass (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org) smtp.mailfrom=huawei.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=3WmbuUyJ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=huawei.com (client-ip=113.46.200.225; helo=canpmsgout10.his.huawei.com; envelope-from=zhaoyifan28@huawei.com; receiver=lists.ozlabs.org)
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fmWsP65ftz2yYK
	for <linux-erofs@lists.ozlabs.org>; Thu, 02 Apr 2026 17:19:21 +1100 (AEDT)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=sj+HfzhnKq6uQPmrjT2y6BaE+fu3UcY66B6Rw4KMRuc=;
	b=3WmbuUyJrl2Jiy0ukaHh0tlcVpAZVlDEgyAa+/Ojlh1e5EQ3tleBW8U12xR0OnCN6XHQvoVth
	DfSqDlw5udwirqEppQR3Q2oCXAxTC+z8/08j+J6EBBWbZjF4KKbVHYV1W0Y3LbJpNK+a7rJ0nmz
	1K86BNG3RF97L4b7+ntMCek=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4fmWkG5hwpz1K9Ch;
	Thu,  2 Apr 2026 14:13:10 +0800 (CST)
Received: from kwepemr100010.china.huawei.com (unknown [7.202.195.125])
	by mail.maildlp.com (Postfix) with ESMTPS id D6DA44056C;
	Thu,  2 Apr 2026 14:19:18 +0800 (CST)
Received: from [100.103.109.96] (100.103.109.96) by
 kwepemr100010.china.huawei.com (7.202.195.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 14:19:18 +0800
Message-ID: <8096c944-48fe-4644-8eab-b900b45cd060@huawei.com>
Date: Thu, 2 Apr 2026 14:19:17 +0800
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
To: Gao Xiang <hsiangkao@linux.alibaba.com>, <linux-erofs@lists.ozlabs.org>
References: <20260402060907.2268323-1-hsiangkao@linux.alibaba.com>
 <20260402060907.2268323-2-hsiangkao@linux.alibaba.com>
From: "zhaoyifan (H)" <zhaoyifan28@huawei.com>
In-Reply-To: <20260402060907.2268323-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [100.103.109.96]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr100010.china.huawei.com (7.202.195.125)
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
	TAGGED_FROM(0.00)[bounces-3170-lists,linux-erofs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hsiangkao@linux.alibaba.com,m:linux-erofs@lists.ozlabs.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	SUSPICIOUS_AUTH_ORIGIN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:133159, ipnet:2404:9400:2000::/36, country:AU];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PREVIOUSLY_DELIVERED(0.00)[linux-erofs@lists.ozlabs.org];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhaoyifan28@huawei.com,linux-erofs@lists.ozlabs.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_XOIP(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-erofs];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.ozlabs.org:helo,lists.ozlabs.org:rdns,autogen.sh:url,makefile.am:url,huawei.com:dkim,huawei.com:mid,huawei.com:email,huawei.com:url,sjtu.edu.cn:email,alibaba.com:email]
X-Rspamd-Queue-Id: C1988384661
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reviewed-by: Yifan Zhao <zhaoyifan28@huawei.com>

On 2026/4/2 14:09, Gao Xiang wrote:
> Let's switch other source files to MIT license since we're absolutely
> NOT working on secret rocket science, so licenses should not be
> a bottleneck to innovation in the Cloud Native and AI era.
>
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
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

