Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id F0DCE78C46C
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Aug 2023 14:44:58 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RZnFN6QwQz30hM
	for <lists+linux-erofs@lfdr.de>; Tue, 29 Aug 2023 22:44:56 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RZnFL4tCZz2xdZ
	for <linux-erofs@lists.ozlabs.org>; Tue, 29 Aug 2023 22:44:54 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VqrXFs0_1693313085;
Received: from 192.168.3.2(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VqrXFs0_1693313085)
          by smtp.aliyun-inc.com;
          Tue, 29 Aug 2023 20:44:47 +0800
Message-ID: <c20e71ab-15dd-6415-42a3-5ae4f277bb60@linux.alibaba.com>
Date: Tue, 29 Aug 2023 20:44:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v6 1/3] erofs-utils: add xxh32 library
To: Jingbo Xu <jefflexu@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230829124127.36719-1-jefflexu@linux.alibaba.com>
 <20230829124127.36719-2-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230829124127.36719-2-jefflexu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 2023/8/29 20:41, Jingbo Xu wrote:
> Add xxh32 library which could be used by following xattr bloom filter
> feature.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   include/erofs/xxhash.h |  72 ++++++++++++++++++++++++
>   lib/Makefile.am        |   3 +-
>   lib/xxhash.c           | 125 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 199 insertions(+), 1 deletion(-)
>   create mode 100644 include/erofs/xxhash.h
>   create mode 100644 lib/xxhash.c
> 
> diff --git a/include/erofs/xxhash.h b/include/erofs/xxhash.h
> new file mode 100644
> index 0000000..5459bd8
> --- /dev/null
> +++ b/include/erofs/xxhash.h
> @@ -0,0 +1,72 @@
> +// SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0-only

You should use:
/* SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0-only */

for each header, but I guess we could drop the copyright
below since it's just a declaration?

> +/*
> + * The xxhash is copied from the linux kernel at:
> + *	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/xxhash.c
> + *
> + * The original copyright is:
> + *
> + * xxHash - Extremely Fast Hash algorithm
> + * Copyright (C) 2012-2016, Yann Collet.
> + *
> + * BSD 2-Clause License (http://www.opensource.org/licenses/bsd-license.php)
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are
> + * met:
> + *
> + *   * Redistributions of source code must retain the above copyright
> + *     notice, this list of conditions and the following disclaimer.
> + *   * Redistributions in binary form must reproduce the above
> + *     copyright notice, this list of conditions and the following disclaimer
> + *     in the documentation and/or other materials provided with the
> + *     distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> + * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation. This program is dual-licensed; you may select
> + * either version 2 of the GNU General Public License ("GPL") or BSD license
> + * ("BSD").
> + *
> + * You can contact the author at:
> + * - xxHash homepage: https://cyan4973.github.io/xxHash/
> + * - xxHash source repository: https://github.com/Cyan4973/xxHash
> + */
> +
> +#ifndef __EROFS_XXHASH_H
> +#define __EROFS_XXHASH_H
> +
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
> +#include "defs.h"

#include <stdint.h> ?

> +
> +/**
> + * xxh32() - calculate the 32-bit hash of the input with a given seed.
> + *
> + * @input:  The data to hash.
> + * @length: The length of the data to hash.
> + * @seed:   The seed can be used to alter the result predictably.
> + *
> + * Return:  The 32-bit hash of the data.
> + */
> +uint32_t xxh32(const void *input, size_t length, uint32_t seed);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index 7a5dc03..3e09516 100644
> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -24,6 +24,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
>         $(top_srcdir)/include/erofs/xattr.h \
>         $(top_srcdir)/include/erofs/compress_hints.h \
>         $(top_srcdir)/include/erofs/fragments.h \
> +      $(top_srcdir)/include/erofs/xxhash.h \
>         $(top_srcdir)/lib/liberofs_private.h
>   
>   noinst_HEADERS += compressor.h
> @@ -31,7 +32,7 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
>   		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
>   		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
>   		      fragments.c rb_tree.c dedupe.c uuid_unparse.c uuid.c tar.c \
> -		      block_list.c
> +		      block_list.c xxhash.c
>   
>   liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
>   if ENABLE_LZ4
> diff --git a/lib/xxhash.c b/lib/xxhash.c
> new file mode 100644
> index 0000000..3d77fe3
> --- /dev/null
> +++ b/lib/xxhash.c
> @@ -0,0 +1,125 @@
> +// SPDX-License-Identifier: BSD-2-Clause OR GPL-2.0-only
> +/*
> + * The xxhash is copied from the linux kernel at:
> + *	https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/lib/xxhash.c
> + *
> + * The original copyright is:
> + *
> + * xxHash - Extremely Fast Hash algorithm
> + * Copyright (C) 2012-2016, Yann Collet.
> + *
> + * BSD 2-Clause License (http://www.opensource.org/licenses/bsd-license.php)
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions are
> + * met:
> + *
> + *   * Redistributions of source code must retain the above copyright
> + *     notice, this list of conditions and the following disclaimer.
> + *   * Redistributions in binary form must reproduce the above
> + *     copyright notice, this list of conditions and the following disclaimer
> + *     in the documentation and/or other materials provided with the
> + *     distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> + * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + *
> + * This program is free software; you can redistribute it and/or modify it under
> + * the terms of the GNU General Public License version 2 as published by the
> + * Free Software Foundation. This program is dual-licensed; you may select
> + * either version 2 of the GNU General Public License ("GPL") or BSD license
> + * ("BSD").
> + *
> + * You can contact the author at:
> + * - xxHash homepage: https://cyan4973.github.io/xxHash/
> + * - xxHash source repository: https://github.com/Cyan4973/xxHash
> + */
> 

#include "erofs/defs.h"

> +#include "erofs/xxhash.h"
> +

Thanks,
Gao Xiang
