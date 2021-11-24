Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C8245B23F
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 03:51:55 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HzQWs4sQKz2yns
	for <lists+linux-erofs@lfdr.de>; Wed, 24 Nov 2021 13:51:53 +1100 (AEDT)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.131;
 helo=out30-131.freemail.mail.aliyun.com;
 envelope-from=hsiangkao@linux.alibaba.com; receiver=<UNKNOWN>)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HzQWn4jhLz2yJv
 for <linux-erofs@lists.ozlabs.org>; Wed, 24 Nov 2021 13:51:45 +1100 (AEDT)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R191e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0Uy37D2m_1637722284; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0Uy37D2m_1637722284) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 24 Nov 2021 10:51:26 +0800
Date: Wed, 24 Nov 2021 10:51:24 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Kelvin Zhang <zhangkelvin@google.com>
Subject: Re: [PATCH v2] Refactor out some I/O logic into separate function
Message-ID: <YZ2orHfVF2qbPQHj@B-P7TQMD6M-0146.local>
References: <20211124002614.1303130-1-zhangkelvin@google.com>
 <20211124003640.1319587-1-zhangkelvin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211124003640.1319587-1-zhangkelvin@google.com>
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

Hi Kelvin,

On Tue, Nov 23, 2021 at 04:36:40PM -0800, Kelvin Zhang wrote:
> Many of the global variables are for I/O purposes. To make the codebase
> more library friendly, decouple I/O and parsing into separate functions.
> 
> Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>

I think I understand the general main point of this. I'm little afraid
if erofs_parse_inode_from_buffer and erofs_parse_superblock are enough
for your use cases...

If that isn't enough, how about adding more seekable I/O source (lib/io.c)
so that it's not only limited to I/O functions but also from memory?

> ---
>  include/erofs/defs.h  | 19 +++++++++++++
>  include/erofs/parse.h | 23 +++++++++++++++
>  include/erofs_fs.h    | 12 ++++++++
>  lib/io.c              |  1 +
>  lib/namei.c           | 38 ++++++++++++++++---------
>  lib/super.c           | 66 +++++++++++++++++++++++++------------------
>  6 files changed, 119 insertions(+), 40 deletions(-)
>  create mode 100644 include/erofs/parse.h
> 
> diff --git a/include/erofs/defs.h b/include/erofs/defs.h
> index 6398cbb..16376dc 100644
> --- a/include/erofs/defs.h
> +++ b/include/erofs/defs.h
> @@ -8,6 +8,11 @@
>  #ifndef __EROFS_DEFS_H
>  #define __EROFS_DEFS_H
>  
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
>  #include <stddef.h>
>  #include <stdint.h>
>  #include <assert.h>
> @@ -82,12 +87,18 @@ typedef int64_t         s64;
>  #endif
>  #endif
>  
> +#ifdef __cplusplus
> +#define BUILD_BUG_ON(condition) static_assert(!condition)
> +#else
> +
>  #ifndef __OPTIMIZE__
>  #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2 * !!(condition)]))
>  #else
>  #define BUILD_BUG_ON(condition) assert(!(condition))
>  #endif
>  
> +#endif
> +
>  #define DIV_ROUND_UP(n, d) (((n) + (d) - 1) / (d))
>  
>  #define __round_mask(x, y)      ((__typeof__(x))((y)-1))
> @@ -110,6 +121,8 @@ typedef int64_t         s64;
>  }							\
>  )
>  
> +// Defining min/max macros in C++ will cause conflicts with std::min/max
> +#ifndef __cplusplus
>  #define min(x, y) ({				\
>  	typeof(x) _min1 = (x);			\
>  	typeof(y) _min2 = (y);			\
> @@ -121,6 +134,7 @@ typedef int64_t         s64;
>  	typeof(y) _max2 = (y);			\
>  	(void) (&_max1 == &_max2);		\
>  	_max1 > _max2 ? _max1 : _max2; })
> +#endif
>  
>  /*
>   * ..and if you can't take the strict types, you can specify one yourself.
> @@ -308,4 +322,9 @@ unsigned long __roundup_pow_of_two(unsigned long n)
>  #define stat64		stat
>  #define lstat64		lstat
>  #endif
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif
> diff --git a/include/erofs/parse.h b/include/erofs/parse.h
> new file mode 100644
> index 0000000..65948a1
> --- /dev/null
> +++ b/include/erofs/parse.h
> @@ -0,0 +1,23 @@
> +
> +#ifndef __EROFS_PARSE_H
> +#define __EROFS_PARSE_H
> +
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
> +#include "erofs_fs.h"
> +#include "internal.h"
> +
> +int erofs_parse_inode_from_buffer(const char buf[EROFS_MAX_INODE_SIZE],
> +                                  struct erofs_inode *vi);
> +
> +int erofs_parse_superblock(const char data[EROFS_BLKSIZ],
> +                           struct erofs_sb_info *sbi);

How about moving them into include/erofs/internal.h?


> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif
> diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> index 9a91877..3f1f645 100644
> --- a/include/erofs_fs.h
> +++ b/include/erofs_fs.h
> @@ -9,6 +9,12 @@
>  #ifndef __EROFS_FS_H
>  #define __EROFS_FS_H
>  
> +#ifdef __cplusplus
> +#define inline constexpr
> +extern "C"
> +{
> +#endif
> +
>  #define EROFS_SUPER_MAGIC_V1    0xE0F5E1E2
>  #define EROFS_SUPER_OFFSET      1024
>  
> @@ -189,6 +195,8 @@ struct erofs_inode_extended {
>  	__u8   i_reserved2[16];
>  };
>  
> +#define EROFS_MAX_INODE_SIZE sizeof(struct erofs_inode_extended)
> +

Could we move it into include/erofs/internal.h as well?
Since erofs_fs.h is the on-disk definition only and keeps in sync
with the kernel header.

Thanks,
Gao Xiang
