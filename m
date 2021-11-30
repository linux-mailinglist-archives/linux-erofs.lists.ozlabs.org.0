Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B22B462C02
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Nov 2021 06:23:37 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J39c73Dmkz3bNB
	for <lists+linux-erofs@lfdr.de>; Tue, 30 Nov 2021 16:23:35 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.133;
 helo=out30-133.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J39by4jPdz2yPV
 for <linux-erofs@lists.ozlabs.org>; Tue, 30 Nov 2021 16:23:23 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R151e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e01424; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0Uyq6d38_1638249783; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uyq6d38_1638249783) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 30 Nov 2021 13:23:05 +0800
Date: Tue, 30 Nov 2021 13:23:03 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: [PATCH v2 2/2] erofs-utils: Make erofs-utils more C++ friendly
Message-ID: <YaW1NwkjrXfxsfx8@B-P7TQMD6M-0146.local>
References: <YaWYErBYsG4Yjboh@B-P7TQMD6M-0146.local>
 <20211130032546.2825384-1-zhangkelvin@google.com>
 <20211130032546.2825384-2-zhangkelvin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211130032546.2825384-2-zhangkelvin@google.com>
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
Cc: Miao Xie <miaoxie@huawei.com>,
 linux-erofs mailing list <linux-erofs@lists.ozlabs.org>
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

On Mon, Nov 29, 2021 at 07:25:46PM -0800, Kelvin Zhang wrote:
> 1. Add extern "C" wrappers to headers, so that they can be included from
> C++
> 2. Add const keyworkds to certain pointer type params
> 
> Change-Id: Ica96c5626de7cc511ffa9a73e0e5ddf7601a7451
> Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
> ---
>  include/erofs/blobchunk.h      | 10 ++++++++++
>  include/erofs/block_list.h     | 10 ++++++++++
>  include/erofs/cache.h          |  9 +++++++++
>  include/erofs/compress.h       |  9 +++++++++
>  include/erofs/compress_hints.h | 10 ++++++++++
>  include/erofs/config.h         | 20 +++++++++-----------
>  include/erofs/decompress.h     |  9 +++++++++
>  include/erofs/defs.h           | 20 ++++++++++++++++++++
>  include/erofs/err.h            |  9 +++++++++
>  include/erofs/exclude.h        | 10 ++++++++++
>  include/erofs/flex-array.h     |  9 +++++++++
>  include/erofs/hashmap.h        |  9 +++++++++
>  include/erofs/hashtable.h      |  9 +++++++++
>  include/erofs/inode.h          |  9 +++++++++
>  include/erofs/internal.h       |  9 +++++++++
>  include/erofs/io.h             | 11 +++++++++++
>  include/erofs/list.h           | 10 ++++++++++
>  include/erofs/print.h          |  9 +++++++++
>  include/erofs/trace.h          |  9 +++++++++
>  include/erofs/xattr.h          |  9 +++++++++
>  include/erofs_fs.h             |  9 +++++++++
>  lib/config.c                   | 12 ++++++++++++
>  lib/inode.c                    |  7 +++++++
>  lib/xattr.c                    | 12 ++++++++++++
>  mkfs/main.c                    |  7 +++++++
>  25 files changed, 245 insertions(+), 11 deletions(-)
> 

...

> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index 2040dc6..6ba1a30 100644
> --- a/include/erofs/config.h
> +++ b/include/erofs/config.h
> @@ -7,20 +7,14 @@
>  #ifndef __EROFS_CONFIG_H
>  #define __EROFS_CONFIG_H
>  
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
>  #include "defs.h"
>  #include "err.h"
>  
> -#ifdef HAVE_LIBSELINUX
> -#include <selinux/selinux.h>
> -#include <selinux/label.h>
> -#endif
> -
> -#ifdef WITH_ANDROID
> -#include <selinux/android.h>
> -#include <private/android_filesystem_config.h>
> -#include <private/canned_fs_config.h>
> -#include <private/fs_config.h>
> -#endif
>  

Out of curiousity, why do we move these headers to each source files?

Thanks,
Gao Xiang
