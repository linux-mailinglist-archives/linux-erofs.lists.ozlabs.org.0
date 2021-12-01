Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2020A465489
	for <lists+linux-erofs@lfdr.de>; Wed,  1 Dec 2021 18:58:38 +0100 (CET)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4J46Jq6WLBz30Ph
	for <lists+linux-erofs@lfdr.de>; Thu,  2 Dec 2021 04:58:35 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lists.ozlabs.org;
	s=201707; t=1638381515;
	bh=E5QiemI+WyyBIvLqZJnyJ1orWFc/xAWCenDyA+taZlE=;
	h=References:In-Reply-To:Date:Subject:To:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:Cc:
	 From;
	b=P0bzYkAJIGnVUSNdZQNJ154X8kyBBUGdwDgLzs7mWkJ/YO6WIP7+bcfBlC34irg72
	 v/uTKFxwZFzAxo+rKu9ciZuqTEvOVuCea2SHkZfmI/M7+2+CfVP6mmIf4BaIngE1Go
	 7c0EgQLYZ9l3lfV5Nfxq1VIPuVLwqJkN42fZ8S9aKumdzGjYEuL9/G6Lmjrh31YBwF
	 yps29uvYfrAPD0bB0x2lwSd2ZqEOVIIwSGWLoAmfjdlm7LTcqp4wxfStspoXeXMuR3
	 llkZXviV2ScQzWw/bGJImC/ubDgnyRPWj7tGy+EmZMFPA8K9q2T3hbUnrYDPoV1aPU
	 EA6RTURHeU/ew==
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=google.com (client-ip=2607:f8b0:4864:20::735;
 helo=mail-qk1-x735.google.com; envelope-from=zhangkelvin@google.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256
 header.s=20210112 header.b=V/HhH5Jl; dkim-atps=neutral
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4J46Jh50J5z2x9K
 for <linux-erofs@lists.ozlabs.org>; Thu,  2 Dec 2021 04:58:26 +1100 (AEDT)
Received: by mail-qk1-x735.google.com with SMTP id 132so31870775qkj.11
 for <linux-erofs@lists.ozlabs.org>; Wed, 01 Dec 2021 09:58:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E5QiemI+WyyBIvLqZJnyJ1orWFc/xAWCenDyA+taZlE=;
 b=fIXcMkBfBLrh5cnToSylBm+WQmulvn0i2ocKkPfwT2yzjHlcm79I1JexxNl+++UXQ8
 rTq02gjwF1AdhVvEavK/AtuFJyKW8VtQ5B+ESdSrcl1h2w69l78uHl30rqFfgW0GXGg5
 YW4s+02JONrtIlAip5Zjed8N1IQLKPZfkoAh7rIq+d2YxrbvgKtG3otM8QLS8mQkJaVg
 4JgJ1z+RtkAe+nvrBrxJBM5eNTJdDYa2Re08YVAL0J9KKWD8E7LMC9gibJsddeUZ2/yS
 PO9DcwBb83ttNbzsbdfY1NeOOUI3I3EqLlK8AbW43GFRXptqKvV/NoMpeAD/RyjuO5Lg
 oDiA==
X-Gm-Message-State: AOAM530KoQMPt38zCD7WPdS1LkVcfc0NCaq/Ilijdl28hBcUCDJKREHz
 zKvZrWO5DDNTPdqqN/f0Py5As9HgwiVBe25sLPVT9A==
X-Google-Smtp-Source: ABdhPJwnw+YySMMcddbeYIiXcY4WVjCwbQuKgI6R5OMrgO7T6XYwz/+WK5AfmGb/OKm3rNW4ChZuKH5Qk82Pgg4XRcc=
X-Received: by 2002:a37:670b:: with SMTP id b11mr7765893qkc.122.1638381500738; 
 Wed, 01 Dec 2021 09:58:20 -0800 (PST)
MIME-Version: 1.0
References: <20211201135315.3732-1-xiang@kernel.org>
In-Reply-To: <20211201135315.3732-1-xiang@kernel.org>
Date: Wed, 1 Dec 2021 09:58:09 -0800
Message-ID: <CAOSmRzgu8_mU8ysONL7G=fbg+Gc4901S6pBOVnq0_z9RryZtSA@mail.gmail.com>
Subject: Re: [PATCH] erofs-utils: make liberofs more C++ friendly
To: Gao Xiang <xiang@kernel.org>
Content-Type: multipart/alternative; boundary="0000000000005c29c805d2196b19"
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
From: Kelvin Zhang via Linux-erofs <linux-erofs@lists.ozlabs.org>
Reply-To: Kelvin Zhang <zhangkelvin@google.com>
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

--0000000000005c29c805d2196b19
Content-Type: text/plain; charset="UTF-8"

This patch works for me, thanks!

On Wed, Dec 1, 2021 at 5:53 AM Gao Xiang <xiang@kernel.org> wrote:

> From: Kelvin Zhang <zhangkelvin@google.com>
>
> 1. Add extern "C" wrappers to headers, so that they can be included
>    from C++
> 2. Add const keywords to certain pointer type params
>
> Signed-off-by: Kelvin Zhang <zhangkelvin@google.com>
> Signed-off-by: Gao Xiang <xiang@kernel.org>
> ---
> v3:
> https://lore.kernel.org/r/20211130055604.2876828-2-zhangkelvin@google.com/
> Hi Kelvin,
>
> Please help check if this patch meets your requirement.
> And I've applied to experimental branch.
>
> Thanks,
> Gao Xiang
>
>  include/erofs/blobchunk.h      |  9 +++++++++
>  include/erofs/block_list.h     | 10 ++++++++++
>  include/erofs/cache.h          |  9 +++++++++
>  include/erofs/compress.h       |  9 +++++++++
>  include/erofs/compress_hints.h | 10 ++++++++++
>  include/erofs/config.h         | 20 +++++++++-----------
>  include/erofs/decompress.h     |  9 +++++++++
>  include/erofs/defs.h           | 17 ++++++++++++++++-
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
>  lib/Makefile.am                |  3 ++-
>  lib/config.c                   |  1 +
>  lib/inode.c                    |  1 +
>  lib/liberofs_private.h         | 13 +++++++++++++
>  lib/xattr.c                    |  1 +
>  25 files changed, 211 insertions(+), 13 deletions(-)
>  create mode 100644 lib/liberofs_private.h
>
> diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h
> index 59a47013017f..4e1ae79938d6 100644
> --- a/include/erofs/blobchunk.h
> +++ b/include/erofs/blobchunk.h
> @@ -7,6 +7,11 @@
>  #ifndef __EROFS_BLOBCHUNK_H
>  #define __EROFS_BLOBCHUNK_H
>
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
>  #include "erofs/internal.h"
>
>  int erofs_blob_write_chunk_indexes(struct erofs_inode *inode, erofs_off_t
> off);
> @@ -16,4 +21,8 @@ void erofs_blob_exit(void);
>  int erofs_blob_init(const char *blobfile_path);
>  int erofs_generate_devtable(void);
>
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif
> diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h
> index 40df2282bf0c..ca8053ed28b7 100644
> --- a/include/erofs/block_list.h
> +++ b/include/erofs/block_list.h
> @@ -6,6 +6,11 @@
>  #ifndef __EROFS_BLOCK_LIST_H
>  #define __EROFS_BLOCK_LIST_H
>
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
>  #include "internal.h"
>
>  #ifdef WITH_ANDROID
> @@ -29,4 +34,9 @@ erofs_droid_blocklist_write_extent(struct erofs_inode
> *inode,
>                                    erofs_blk_t blk_start, erofs_blk_t
> nblocks,
>                                    bool first_extent, bool last_extent) {}
>  #endif
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif
> diff --git a/include/erofs/cache.h b/include/erofs/cache.h
> index 87cd51d9473b..7957ee5d0b73 100644
> --- a/include/erofs/cache.h
> +++ b/include/erofs/cache.h
> @@ -8,6 +8,11 @@
>  #ifndef __EROFS_CACHE_H
>  #define __EROFS_CACHE_H
>
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
>  #include "internal.h"
>
>  struct erofs_buffer_head;
> @@ -104,4 +109,8 @@ bool erofs_bflush(struct erofs_buffer_block *bb);
>
>  void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke);
>
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif
> diff --git a/include/erofs/compress.h b/include/erofs/compress.h
> index 4434aaa75b54..fdbf5ff66558 100644
> --- a/include/erofs/compress.h
> +++ b/include/erofs/compress.h
> @@ -7,6 +7,11 @@
>  #ifndef __EROFS_COMPRESS_H
>  #define __EROFS_COMPRESS_H
>
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
>  #include "internal.h"
>
>  /* workaround for an upstream lz4 compression issue, which can crash us */
> @@ -21,4 +26,8 @@ int z_erofs_compress_exit(void);
>
>  const char *z_erofs_list_available_compressors(unsigned int i);
>
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif
> diff --git a/include/erofs/compress_hints.h
> b/include/erofs/compress_hints.h
> index a5772c72b1c4..43f80e117816 100644
> --- a/include/erofs/compress_hints.h
> +++ b/include/erofs/compress_hints.h
> @@ -6,6 +6,11 @@
>  #ifndef __EROFS_COMPRESS_HINTS_H
>  #define __EROFS_COMPRESS_HINTS_H
>
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
>  #include "erofs/internal.h"
>  #include <sys/types.h>
>  #include <regex.h>
> @@ -20,4 +25,9 @@ struct erofs_compress_hints {
>  bool z_erofs_apply_compress_hints(struct erofs_inode *inode);
>  void erofs_cleanup_compress_hints(void);
>  int erofs_load_compress_hints(void);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif
> diff --git a/include/erofs/config.h b/include/erofs/config.h
> index 2040dc6ff154..cb064b651835 100644
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
>  enum {
>         FORCE_INODE_COMPACT = 1,
> @@ -96,4 +90,8 @@ static inline int erofs_selabel_open(const char
> *file_contexts)
>  }
>  #endif
>
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif
> diff --git a/include/erofs/decompress.h b/include/erofs/decompress.h
> index 3d0d9633865d..e649c80cf3a7 100644
> --- a/include/erofs/decompress.h
> +++ b/include/erofs/decompress.h
> @@ -6,6 +6,11 @@
>  #ifndef __EROFS_DECOMPRESS_H
>  #define __EROFS_DECOMPRESS_H
>
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
>  #include "internal.h"
>
>  struct z_erofs_decompress_req {
> @@ -25,4 +30,8 @@ struct z_erofs_decompress_req {
>
>  int z_erofs_decompress(struct z_erofs_decompress_req *rq);
>
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif
> diff --git a/include/erofs/defs.h b/include/erofs/defs.h
> index 6398cbb2aa4d..4db237f4dfb0 100644
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
> @@ -82,7 +87,9 @@ typedef int64_t         s64;
>  #endif
>  #endif
>
> -#ifndef __OPTIMIZE__
> +#ifdef __cplusplus
> +#define BUILD_BUG_ON(condition) static_assert(!(condition))
> +#elif !defined(__OPTIMIZE__)
>  #define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2 *
> !!(condition)]))
>  #else
>  #define BUILD_BUG_ON(condition) assert(!(condition))
> @@ -110,6 +117,8 @@ typedef int64_t         s64;
>  }                                                      \
>  )
>
> +/* Can easily conflict with C++'s std::min */
> +#ifndef __cplusplus
>  #define min(x, y) ({                           \
>         typeof(x) _min1 = (x);                  \
>         typeof(y) _min2 = (y);                  \
> @@ -121,6 +130,7 @@ typedef int64_t         s64;
>         typeof(y) _max2 = (y);                  \
>         (void) (&_max1 == &_max2);              \
>         _max1 > _max2 ? _max1 : _max2; })
> +#endif
>
>  /*
>   * ..and if you can't take the strict types, you can specify one yourself.
> @@ -308,4 +318,9 @@ unsigned long __roundup_pow_of_two(unsigned long n)
>  #define stat64         stat
>  #define lstat64                lstat
>  #endif
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif
> diff --git a/include/erofs/err.h b/include/erofs/err.h
> index a33bdd137879..18f152aa4608 100644
> --- a/include/erofs/err.h
> +++ b/include/erofs/err.h
> @@ -7,6 +7,11 @@
>  #ifndef __EROFS_ERR_H
>  #define __EROFS_ERR_H
>
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
>  #include <errno.h>
>
>  #define MAX_ERRNO (4095)
> @@ -28,4 +33,8 @@ static inline long PTR_ERR(const void *ptr)
>         return (long) ptr;
>  }
>
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif
> diff --git a/include/erofs/exclude.h b/include/erofs/exclude.h
> index 6930f2b43a47..599f01895807 100644
> --- a/include/erofs/exclude.h
> +++ b/include/erofs/exclude.h
> @@ -5,6 +5,11 @@
>  #ifndef __EROFS_EXCLUDE_H
>  #define __EROFS_EXCLUDE_H
>
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
>  #include <sys/types.h>
>  #include <regex.h>
>
> @@ -21,4 +26,9 @@ void erofs_cleanup_exclude_rules(void);
>  int erofs_parse_exclude_path(const char *args, bool is_regex);
>  struct erofs_exclude_rule *erofs_is_exclude_path(const char *dir,
>                                                  const char *name);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif
> diff --git a/include/erofs/flex-array.h b/include/erofs/flex-array.h
> index 59168d05ee5a..9b1642f77740 100644
> --- a/include/erofs/flex-array.h
> +++ b/include/erofs/flex-array.h
> @@ -2,6 +2,11 @@
>  #ifndef __EROFS_FLEX_ARRAY_H
>  #define __EROFS_FLEX_ARRAY_H
>
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <limits.h>
> @@ -144,4 +149,8 @@ static inline size_t st_add(size_t a, size_t b)
>  #define FLEXPTR_ALLOC_STR(x, ptrname, str) \
>         FLEXPTR_ALLOC_MEM((x), ptrname, (str), strlen(str))
>
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif
> diff --git a/include/erofs/hashmap.h b/include/erofs/hashmap.h
> index 024a14e497d4..3d3857890077 100644
> --- a/include/erofs/hashmap.h
> +++ b/include/erofs/hashmap.h
> @@ -2,6 +2,11 @@
>  #ifndef __EROFS_HASHMAP_H
>  #define __EROFS_HASHMAP_H
>
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
>  /* Copied from https://github.com/git/git.git */
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -100,4 +105,8 @@ static inline const char *strintern(const char *string)
>         return memintern(string, strlen(string));
>  }
>
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif
> diff --git a/include/erofs/hashtable.h b/include/erofs/hashtable.h
> index 90eb84ee8598..3c4dfc128eaa 100644
> --- a/include/erofs/hashtable.h
> +++ b/include/erofs/hashtable.h
> @@ -5,6 +5,11 @@
>  #ifndef __EROFS_HASHTABLE_H
>  #define __EROFS_HASHTABLE_H
>
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
>  /*
>   * Fast hashing routine for ints,  longs and pointers.
>   * (C) 2002 Nadia Yvette Chambers, IBM
> @@ -380,4 +385,8 @@ static inline void hash_del(struct hlist_node *node)
>  #define hash_for_each_possible(name, obj, member, key)                 \
>         hlist_for_each_entry(obj, &name[hash_min(key, HASH_BITS(name))],
> member)
>
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif
> diff --git a/include/erofs/inode.h b/include/erofs/inode.h
> index d5343c242aee..e23d65f42249 100644
> --- a/include/erofs/inode.h
> +++ b/include/erofs/inode.h
> @@ -8,6 +8,11 @@
>  #ifndef __EROFS_INODE_H
>  #define __EROFS_INODE_H
>
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
>  #include "erofs/internal.h"
>
>  unsigned char erofs_mode_to_ftype(umode_t mode);
> @@ -17,4 +22,8 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);
>  struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inode
> *parent,
>                                                     const char *path);
>
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif
> diff --git a/include/erofs/internal.h b/include/erofs/internal.h
> index 666d1f2df466..a68de325da39 100644
> --- a/include/erofs/internal.h
> +++ b/include/erofs/internal.h
> @@ -7,6 +7,11 @@
>  #ifndef __EROFS_INTERNAL_H
>  #define __EROFS_INTERNAL_H
>
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
>  #include "list.h"
>  #include "err.h"
>
> @@ -331,4 +336,8 @@ static inline u32 erofs_crc32c(u32 crc, const u8 *in,
> size_t len)
>         return crc;
>  }
>
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif
> diff --git a/include/erofs/io.h b/include/erofs/io.h
> index 10a3681882e1..6f51e06ee7c2 100644
> --- a/include/erofs/io.h
> +++ b/include/erofs/io.h
> @@ -7,7 +7,14 @@
>  #ifndef __EROFS_IO_H
>  #define __EROFS_IO_H
>
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
> +#ifndef _GNU_SOURCE
>  #define _GNU_SOURCE
> +#endif
>  #include <unistd.h>
>  #include "internal.h"
>
> @@ -47,4 +54,8 @@ static inline int blk_read(int device_id, void *buf,
>                          blknr_to_addr(nblocks));
>  }
>
> +#ifdef __cplusplus
> +}
>  #endif
> +
> +#endif // EROFS_IO_H_
> diff --git a/include/erofs/list.h b/include/erofs/list.h
> index d2bc704ae64b..fd5358d6bd19 100644
> --- a/include/erofs/list.h
> +++ b/include/erofs/list.h
> @@ -7,6 +7,11 @@
>  #ifndef __EROFS_LIST_HEAD_H
>  #define __EROFS_LIST_HEAD_H
>
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
>  #include "defs.h"
>
>  struct list_head {
> @@ -105,4 +110,9 @@ static inline int list_empty(struct list_head *head)
>              &pos->member != (head);
>      \
>              pos = n, n = list_next_entry(n, member))
>
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif
> diff --git a/include/erofs/print.h b/include/erofs/print.h
> index 91f864bacd55..2213d1d58de5 100644
> --- a/include/erofs/print.h
> +++ b/include/erofs/print.h
> @@ -7,6 +7,11 @@
>  #ifndef __EROFS_PRINT_H
>  #define __EROFS_PRINT_H
>
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
>  #include "config.h"
>  #include <stdio.h>
>
> @@ -72,4 +77,8 @@ enum {
>
>  #define erofs_dump(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)
>
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif
> diff --git a/include/erofs/trace.h b/include/erofs/trace.h
> index d70d23674c1a..893e16c5d6c1 100644
> --- a/include/erofs/trace.h
> +++ b/include/erofs/trace.h
> @@ -5,7 +5,16 @@
>  #ifndef __EROFS_TRACE_H
>  #define __EROFS_TRACE_H
>
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
>  #define trace_erofs_map_blocks_flatmode_enter(inode, map, flags) ((void)0)
>  #define trace_erofs_map_blocks_flatmode_exit(inode, map, flags, ret)
> ((void)0)
>
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif
> diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h
> index f0c4c268fecc..8e6881247f42 100644
> --- a/include/erofs/xattr.h
> +++ b/include/erofs/xattr.h
> @@ -7,6 +7,11 @@
>  #ifndef __EROFS_XATTR_H
>  #define __EROFS_XATTR_H
>
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
>  #include "internal.h"
>
>  #define EROFS_INODE_XATTR_ICOUNT(_size)        ({\
> @@ -44,4 +49,8 @@ int erofs_prepare_xattr_ibody(struct erofs_inode *inode);
>  char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned int
> size);
>  int erofs_build_shared_xattrs_from_path(const char *path);
>
> +#ifdef __cplusplus
> +}
> +#endif
> +
>  #endif
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index 395c712811b8..67ba798672b9 100644
> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -21,7 +21,8 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
>        $(top_srcdir)/include/erofs/print.h \
>        $(top_srcdir)/include/erofs/trace.h \
>        $(top_srcdir)/include/erofs/xattr.h \
> -      $(top_srcdir)/include/erofs/compress_hints.h
> +      $(top_srcdir)/include/erofs/compress_hints.h \
> +      $(top_srcdir)/lib/liberofs_private.h
>
>  noinst_HEADERS += compressor.h
>  liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c
> exclude.c \
> diff --git a/lib/config.c b/lib/config.c
> index 363dcc5a0525..f1c8edfda2dc 100644
> --- a/lib/config.c
> +++ b/lib/config.c
> @@ -8,6 +8,7 @@
>  #include <stdlib.h>
>  #include "erofs/print.h"
>  #include "erofs/internal.h"
> +#include "liberofs_private.h"
>
>  struct erofs_configure cfg;
>  struct erofs_sb_info sbi;
> diff --git a/lib/inode.c b/lib/inode.c
> index 2fa74e2686c9..461c7978dbdf 100644
> --- a/lib/inode.c
> +++ b/lib/inode.c
> @@ -25,6 +25,7 @@
>  #include "erofs/block_list.h"
>  #include "erofs/compress_hints.h"
>  #include "erofs/blobchunk.h"
> +#include "liberofs_private.h"
>
>  #define S_SHIFT                 12
>  static unsigned char erofs_ftype_by_mode[S_IFMT >> S_SHIFT] = {
> diff --git a/lib/liberofs_private.h b/lib/liberofs_private.h
> new file mode 100644
> index 000000000000..c2312e8e7a31
> --- /dev/null
> +++ b/lib/liberofs_private.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */
> +
> +#ifdef HAVE_LIBSELINUX
> +#include <selinux/selinux.h>
> +#include <selinux/label.h>
> +#endif
> +
> +#ifdef WITH_ANDROID
> +#include <selinux/android.h>
> +#include <private/android_filesystem_config.h>
> +#include <private/canned_fs_config.h>
> +#include <private/fs_config.h>
> +#endif
> diff --git a/lib/xattr.c b/lib/xattr.c
> index 196133a1a798..00fb963c68ef 100644
> --- a/lib/xattr.c
> +++ b/lib/xattr.c
> @@ -17,6 +17,7 @@
>  #include "erofs/xattr.h"
>  #include "erofs/cache.h"
>  #include "erofs/io.h"
> +#include "liberofs_private.h"
>
>  #define EA_HASHTABLE_BITS 16
>
> --
> 2.20.1
>
>

-- 
Sincerely,

Kelvin Zhang

--0000000000005c29c805d2196b19
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This patch works for me, thanks!</div><br><div class=3D"gm=
ail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Dec 1, 2021 at 5:5=
3 AM Gao Xiang &lt;<a href=3D"mailto:xiang@kernel.org">xiang@kernel.org</a>=
&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">From=
: Kelvin Zhang &lt;<a href=3D"mailto:zhangkelvin@google.com" target=3D"_bla=
nk">zhangkelvin@google.com</a>&gt;<br>
<br>
1. Add extern &quot;C&quot; wrappers to headers, so that they can be includ=
ed<br>
=C2=A0 =C2=A0from C++<br>
2. Add const keywords to certain pointer type params<br>
<br>
Signed-off-by: Kelvin Zhang &lt;<a href=3D"mailto:zhangkelvin@google.com" t=
arget=3D"_blank">zhangkelvin@google.com</a>&gt;<br>
Signed-off-by: Gao Xiang &lt;<a href=3D"mailto:xiang@kernel.org" target=3D"=
_blank">xiang@kernel.org</a>&gt;<br>
---<br>
v3: <a href=3D"https://lore.kernel.org/r/20211130055604.2876828-2-zhangkelv=
in@google.com/" rel=3D"noreferrer" target=3D"_blank">https://lore.kernel.or=
g/r/20211130055604.2876828-2-zhangkelvin@google.com/</a><br>
Hi Kelvin,<br>
<br>
Please help check if this patch meets your requirement.<br>
And I&#39;ve applied to experimental branch.<br>
<br>
Thanks,<br>
Gao Xiang<br>
<br>
=C2=A0include/erofs/blobchunk.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 +++++++++<br>
=C2=A0include/erofs/block_list.h=C2=A0 =C2=A0 =C2=A0| 10 ++++++++++<br>
=C2=A0include/erofs/cache.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 +++=
++++++<br>
=C2=A0include/erofs/compress.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 9 ++++++++=
+<br>
=C2=A0include/erofs/compress_hints.h | 10 ++++++++++<br>
=C2=A0include/erofs/config.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 20 ++++++++=
+-----------<br>
=C2=A0include/erofs/decompress.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 9 +++++++++<br>
=C2=A0include/erofs/defs.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 17 +++=
+++++++++++++-<br>
=C2=A0include/erofs/err.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
9 +++++++++<br>
=C2=A0include/erofs/exclude.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 10 ++++++++++<br=
>
=C2=A0include/erofs/flex-array.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 9 +++++++++<br>
=C2=A0include/erofs/hashmap.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 ++++++++=
+<br>
=C2=A0include/erofs/hashtable.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 +++++++++<br>
=C2=A0include/erofs/inode.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 +++=
++++++<br>
=C2=A0include/erofs/internal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 9 ++++++++=
+<br>
=C2=A0include/erofs/io.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 1=
1 +++++++++++<br>
=C2=A0include/erofs/list.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 +++=
+++++++<br>
=C2=A0include/erofs/print.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 +++=
++++++<br>
=C2=A0include/erofs/trace.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 +++=
++++++<br>
=C2=A0include/erofs/xattr.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 +++=
++++++<br>
=C2=A0lib/Makefile.am=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 3 ++-<br>
=C2=A0lib/config.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0lib/inode.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A0lib/liberofs_private.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 13 ++++++++=
+++++<br>
=C2=A0lib/xattr.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 1 +<br>
=C2=A025 files changed, 211 insertions(+), 13 deletions(-)<br>
=C2=A0create mode 100644 lib/liberofs_private.h<br>
<br>
diff --git a/include/erofs/blobchunk.h b/include/erofs/blobchunk.h<br>
index 59a47013017f..4e1ae79938d6 100644<br>
--- a/include/erofs/blobchunk.h<br>
+++ b/include/erofs/blobchunk.h<br>
@@ -7,6 +7,11 @@<br>
=C2=A0#ifndef __EROFS_BLOBCHUNK_H<br>
=C2=A0#define __EROFS_BLOBCHUNK_H<br>
<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot;<br>
+{<br>
+#endif<br>
+<br>
=C2=A0#include &quot;erofs/internal.h&quot;<br>
<br>
=C2=A0int erofs_blob_write_chunk_indexes(struct erofs_inode *inode, erofs_o=
ff_t off);<br>
@@ -16,4 +21,8 @@ void erofs_blob_exit(void);<br>
=C2=A0int erofs_blob_init(const char *blobfile_path);<br>
=C2=A0int erofs_generate_devtable(void);<br>
<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
=C2=A0#endif<br>
diff --git a/include/erofs/block_list.h b/include/erofs/block_list.h<br>
index 40df2282bf0c..ca8053ed28b7 100644<br>
--- a/include/erofs/block_list.h<br>
+++ b/include/erofs/block_list.h<br>
@@ -6,6 +6,11 @@<br>
=C2=A0#ifndef __EROFS_BLOCK_LIST_H<br>
=C2=A0#define __EROFS_BLOCK_LIST_H<br>
<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot;<br>
+{<br>
+#endif<br>
+<br>
=C2=A0#include &quot;internal.h&quot;<br>
<br>
=C2=A0#ifdef WITH_ANDROID<br>
@@ -29,4 +34,9 @@ erofs_droid_blocklist_write_extent(struct erofs_inode *in=
ode,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0erofs_blk_t blk_start, =
erofs_blk_t nblocks,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool first_extent, bool=
 last_extent) {}<br>
=C2=A0#endif<br>
+<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
=C2=A0#endif<br>
diff --git a/include/erofs/cache.h b/include/erofs/cache.h<br>
index 87cd51d9473b..7957ee5d0b73 100644<br>
--- a/include/erofs/cache.h<br>
+++ b/include/erofs/cache.h<br>
@@ -8,6 +8,11 @@<br>
=C2=A0#ifndef __EROFS_CACHE_H<br>
=C2=A0#define __EROFS_CACHE_H<br>
<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot;<br>
+{<br>
+#endif<br>
+<br>
=C2=A0#include &quot;internal.h&quot;<br>
<br>
=C2=A0struct erofs_buffer_head;<br>
@@ -104,4 +109,8 @@ bool erofs_bflush(struct erofs_buffer_block *bb);<br>
<br>
=C2=A0void erofs_bdrop(struct erofs_buffer_head *bh, bool tryrevoke);<br>
<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
=C2=A0#endif<br>
diff --git a/include/erofs/compress.h b/include/erofs/compress.h<br>
index 4434aaa75b54..fdbf5ff66558 100644<br>
--- a/include/erofs/compress.h<br>
+++ b/include/erofs/compress.h<br>
@@ -7,6 +7,11 @@<br>
=C2=A0#ifndef __EROFS_COMPRESS_H<br>
=C2=A0#define __EROFS_COMPRESS_H<br>
<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot;<br>
+{<br>
+#endif<br>
+<br>
=C2=A0#include &quot;internal.h&quot;<br>
<br>
=C2=A0/* workaround for an upstream lz4 compression issue, which can crash =
us */<br>
@@ -21,4 +26,8 @@ int z_erofs_compress_exit(void);<br>
<br>
=C2=A0const char *z_erofs_list_available_compressors(unsigned int i);<br>
<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
=C2=A0#endif<br>
diff --git a/include/erofs/compress_hints.h b/include/erofs/compress_hints.=
h<br>
index a5772c72b1c4..43f80e117816 100644<br>
--- a/include/erofs/compress_hints.h<br>
+++ b/include/erofs/compress_hints.h<br>
@@ -6,6 +6,11 @@<br>
=C2=A0#ifndef __EROFS_COMPRESS_HINTS_H<br>
=C2=A0#define __EROFS_COMPRESS_HINTS_H<br>
<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot;<br>
+{<br>
+#endif<br>
+<br>
=C2=A0#include &quot;erofs/internal.h&quot;<br>
=C2=A0#include &lt;sys/types.h&gt;<br>
=C2=A0#include &lt;regex.h&gt;<br>
@@ -20,4 +25,9 @@ struct erofs_compress_hints {<br>
=C2=A0bool z_erofs_apply_compress_hints(struct erofs_inode *inode);<br>
=C2=A0void erofs_cleanup_compress_hints(void);<br>
=C2=A0int erofs_load_compress_hints(void);<br>
+<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
=C2=A0#endif<br>
diff --git a/include/erofs/config.h b/include/erofs/config.h<br>
index 2040dc6ff154..cb064b651835 100644<br>
--- a/include/erofs/config.h<br>
+++ b/include/erofs/config.h<br>
@@ -7,20 +7,14 @@<br>
=C2=A0#ifndef __EROFS_CONFIG_H<br>
=C2=A0#define __EROFS_CONFIG_H<br>
<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot;<br>
+{<br>
+#endif<br>
+<br>
=C2=A0#include &quot;defs.h&quot;<br>
=C2=A0#include &quot;err.h&quot;<br>
<br>
-#ifdef HAVE_LIBSELINUX<br>
-#include &lt;selinux/selinux.h&gt;<br>
-#include &lt;selinux/label.h&gt;<br>
-#endif<br>
-<br>
-#ifdef WITH_ANDROID<br>
-#include &lt;selinux/android.h&gt;<br>
-#include &lt;private/android_filesystem_config.h&gt;<br>
-#include &lt;private/canned_fs_config.h&gt;<br>
-#include &lt;private/fs_config.h&gt;<br>
-#endif<br>
<br>
=C2=A0enum {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 FORCE_INODE_COMPACT =3D 1,<br>
@@ -96,4 +90,8 @@ static inline int erofs_selabel_open(const char *file_con=
texts)<br>
=C2=A0}<br>
=C2=A0#endif<br>
<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
=C2=A0#endif<br>
diff --git a/include/erofs/decompress.h b/include/erofs/decompress.h<br>
index 3d0d9633865d..e649c80cf3a7 100644<br>
--- a/include/erofs/decompress.h<br>
+++ b/include/erofs/decompress.h<br>
@@ -6,6 +6,11 @@<br>
=C2=A0#ifndef __EROFS_DECOMPRESS_H<br>
=C2=A0#define __EROFS_DECOMPRESS_H<br>
<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot;<br>
+{<br>
+#endif<br>
+<br>
=C2=A0#include &quot;internal.h&quot;<br>
<br>
=C2=A0struct z_erofs_decompress_req {<br>
@@ -25,4 +30,8 @@ struct z_erofs_decompress_req {<br>
<br>
=C2=A0int z_erofs_decompress(struct z_erofs_decompress_req *rq);<br>
<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
=C2=A0#endif<br>
diff --git a/include/erofs/defs.h b/include/erofs/defs.h<br>
index 6398cbb2aa4d..4db237f4dfb0 100644<br>
--- a/include/erofs/defs.h<br>
+++ b/include/erofs/defs.h<br>
@@ -8,6 +8,11 @@<br>
=C2=A0#ifndef __EROFS_DEFS_H<br>
=C2=A0#define __EROFS_DEFS_H<br>
<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot;<br>
+{<br>
+#endif<br>
+<br>
=C2=A0#include &lt;stddef.h&gt;<br>
=C2=A0#include &lt;stdint.h&gt;<br>
=C2=A0#include &lt;assert.h&gt;<br>
@@ -82,7 +87,9 @@ typedef int64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s64;<br>
=C2=A0#endif<br>
=C2=A0#endif<br>
<br>
-#ifndef __OPTIMIZE__<br>
+#ifdef __cplusplus<br>
+#define BUILD_BUG_ON(condition) static_assert(!(condition))<br>
+#elif !defined(__OPTIMIZE__)<br>
=C2=A0#define BUILD_BUG_ON(condition) ((void)sizeof(char[1 - 2 * !!(conditi=
on)]))<br>
=C2=A0#else<br>
=C2=A0#define BUILD_BUG_ON(condition) assert(!(condition))<br>
@@ -110,6 +117,8 @@ typedef int64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s64;<b=
r>
=C2=A0}=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0)<br>
<br>
+/* Can easily conflict with C++&#39;s std::min */<br>
+#ifndef __cplusplus<br>
=C2=A0#define min(x, y) ({=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 typeof(x) _min1 =3D (x);=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 typeof(y) _min2 =3D (y);=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
@@ -121,6 +130,7 @@ typedef int64_t=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s64;<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 typeof(y) _max2 =3D (y);=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 (void) (&amp;_max1 =3D=3D &amp;_max2);=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 _max1 &gt; _max2 ? _max1 : _max2; })<br>
+#endif<br>
<br>
=C2=A0/*<br>
=C2=A0 * ..and if you can&#39;t take the strict types, you can specify one =
yourself.<br>
@@ -308,4 +318,9 @@ unsigned long __roundup_pow_of_two(unsigned long n)<br>
=C2=A0#define stat64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stat<br>
=C2=A0#define lstat64=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 lstat<br>
=C2=A0#endif<br>
+<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
=C2=A0#endif<br>
diff --git a/include/erofs/err.h b/include/erofs/err.h<br>
index a33bdd137879..18f152aa4608 100644<br>
--- a/include/erofs/err.h<br>
+++ b/include/erofs/err.h<br>
@@ -7,6 +7,11 @@<br>
=C2=A0#ifndef __EROFS_ERR_H<br>
=C2=A0#define __EROFS_ERR_H<br>
<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot;<br>
+{<br>
+#endif<br>
+<br>
=C2=A0#include &lt;errno.h&gt;<br>
<br>
=C2=A0#define MAX_ERRNO (4095)<br>
@@ -28,4 +33,8 @@ static inline long PTR_ERR(const void *ptr)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (long) ptr;<br>
=C2=A0}<br>
<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
=C2=A0#endif<br>
diff --git a/include/erofs/exclude.h b/include/erofs/exclude.h<br>
index 6930f2b43a47..599f01895807 100644<br>
--- a/include/erofs/exclude.h<br>
+++ b/include/erofs/exclude.h<br>
@@ -5,6 +5,11 @@<br>
=C2=A0#ifndef __EROFS_EXCLUDE_H<br>
=C2=A0#define __EROFS_EXCLUDE_H<br>
<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot;<br>
+{<br>
+#endif<br>
+<br>
=C2=A0#include &lt;sys/types.h&gt;<br>
=C2=A0#include &lt;regex.h&gt;<br>
<br>
@@ -21,4 +26,9 @@ void erofs_cleanup_exclude_rules(void);<br>
=C2=A0int erofs_parse_exclude_path(const char *args, bool is_regex);<br>
=C2=A0struct erofs_exclude_rule *erofs_is_exclude_path(const char *dir,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0const char *name);<br>
+<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
=C2=A0#endif<br>
diff --git a/include/erofs/flex-array.h b/include/erofs/flex-array.h<br>
index 59168d05ee5a..9b1642f77740 100644<br>
--- a/include/erofs/flex-array.h<br>
+++ b/include/erofs/flex-array.h<br>
@@ -2,6 +2,11 @@<br>
=C2=A0#ifndef __EROFS_FLEX_ARRAY_H<br>
=C2=A0#define __EROFS_FLEX_ARRAY_H<br>
<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot;<br>
+{<br>
+#endif<br>
+<br>
=C2=A0#include &lt;stdio.h&gt;<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
=C2=A0#include &lt;limits.h&gt;<br>
@@ -144,4 +149,8 @@ static inline size_t st_add(size_t a, size_t b)<br>
=C2=A0#define FLEXPTR_ALLOC_STR(x, ptrname, str) \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 FLEXPTR_ALLOC_MEM((x), ptrname, (str), strlen(s=
tr))<br>
<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
=C2=A0#endif<br>
diff --git a/include/erofs/hashmap.h b/include/erofs/hashmap.h<br>
index 024a14e497d4..3d3857890077 100644<br>
--- a/include/erofs/hashmap.h<br>
+++ b/include/erofs/hashmap.h<br>
@@ -2,6 +2,11 @@<br>
=C2=A0#ifndef __EROFS_HASHMAP_H<br>
=C2=A0#define __EROFS_HASHMAP_H<br>
<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot;<br>
+{<br>
+#endif<br>
+<br>
=C2=A0/* Copied from <a href=3D"https://github.com/git/git.git" rel=3D"nore=
ferrer" target=3D"_blank">https://github.com/git/git.git</a> */<br>
=C2=A0#include &lt;stdio.h&gt;<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
@@ -100,4 +105,8 @@ static inline const char *strintern(const char *string)=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return memintern(string, strlen(string));<br>
=C2=A0}<br>
<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
=C2=A0#endif<br>
diff --git a/include/erofs/hashtable.h b/include/erofs/hashtable.h<br>
index 90eb84ee8598..3c4dfc128eaa 100644<br>
--- a/include/erofs/hashtable.h<br>
+++ b/include/erofs/hashtable.h<br>
@@ -5,6 +5,11 @@<br>
=C2=A0#ifndef __EROFS_HASHTABLE_H<br>
=C2=A0#define __EROFS_HASHTABLE_H<br>
<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot;<br>
+{<br>
+#endif<br>
+<br>
=C2=A0/*<br>
=C2=A0 * Fast hashing routine for ints,=C2=A0 longs and pointers.<br>
=C2=A0 * (C) 2002 Nadia Yvette Chambers, IBM<br>
@@ -380,4 +385,8 @@ static inline void hash_del(struct hlist_node *node)<br=
>
=C2=A0#define hash_for_each_possible(name, obj, member, key)=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hlist_for_each_entry(obj, &amp;name[hash_min(ke=
y, HASH_BITS(name))], member)<br>
<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
=C2=A0#endif<br>
diff --git a/include/erofs/inode.h b/include/erofs/inode.h<br>
index d5343c242aee..e23d65f42249 100644<br>
--- a/include/erofs/inode.h<br>
+++ b/include/erofs/inode.h<br>
@@ -8,6 +8,11 @@<br>
=C2=A0#ifndef __EROFS_INODE_H<br>
=C2=A0#define __EROFS_INODE_H<br>
<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot;<br>
+{<br>
+#endif<br>
+<br>
=C2=A0#include &quot;erofs/internal.h&quot;<br>
<br>
=C2=A0unsigned char erofs_mode_to_ftype(umode_t mode);<br>
@@ -17,4 +22,8 @@ erofs_nid_t erofs_lookupnid(struct erofs_inode *inode);<b=
r>
=C2=A0struct erofs_inode *erofs_mkfs_build_tree_from_path(struct erofs_inod=
e *parent,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const char *path);<br>
<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
=C2=A0#endif<br>
diff --git a/include/erofs/internal.h b/include/erofs/internal.h<br>
index 666d1f2df466..a68de325da39 100644<br>
--- a/include/erofs/internal.h<br>
+++ b/include/erofs/internal.h<br>
@@ -7,6 +7,11 @@<br>
=C2=A0#ifndef __EROFS_INTERNAL_H<br>
=C2=A0#define __EROFS_INTERNAL_H<br>
<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot;<br>
+{<br>
+#endif<br>
+<br>
=C2=A0#include &quot;list.h&quot;<br>
=C2=A0#include &quot;err.h&quot;<br>
<br>
@@ -331,4 +336,8 @@ static inline u32 erofs_crc32c(u32 crc, const u8 *in, s=
ize_t len)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return crc;<br>
=C2=A0}<br>
<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
=C2=A0#endif<br>
diff --git a/include/erofs/io.h b/include/erofs/io.h<br>
index 10a3681882e1..6f51e06ee7c2 100644<br>
--- a/include/erofs/io.h<br>
+++ b/include/erofs/io.h<br>
@@ -7,7 +7,14 @@<br>
=C2=A0#ifndef __EROFS_IO_H<br>
=C2=A0#define __EROFS_IO_H<br>
<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot;<br>
+{<br>
+#endif<br>
+<br>
+#ifndef _GNU_SOURCE<br>
=C2=A0#define _GNU_SOURCE<br>
+#endif<br>
=C2=A0#include &lt;unistd.h&gt;<br>
=C2=A0#include &quot;internal.h&quot;<br>
<br>
@@ -47,4 +54,8 @@ static inline int blk_read(int device_id, void *buf,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0blknr_to_addr(nblocks));<br>
=C2=A0}<br>
<br>
+#ifdef __cplusplus<br>
+}<br>
=C2=A0#endif<br>
+<br>
+#endif // EROFS_IO_H_<br>
diff --git a/include/erofs/list.h b/include/erofs/list.h<br>
index d2bc704ae64b..fd5358d6bd19 100644<br>
--- a/include/erofs/list.h<br>
+++ b/include/erofs/list.h<br>
@@ -7,6 +7,11 @@<br>
=C2=A0#ifndef __EROFS_LIST_HEAD_H<br>
=C2=A0#define __EROFS_LIST_HEAD_H<br>
<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot;<br>
+{<br>
+#endif<br>
+<br>
=C2=A0#include &quot;defs.h&quot;<br>
<br>
=C2=A0struct list_head {<br>
@@ -105,4 +110,9 @@ static inline int list_empty(struct list_head *head)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;pos-&gt;member !=3D (h=
ead);=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pos =3D n, n =3D list_next_=
entry(n, member))<br>
<br>
+<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
=C2=A0#endif<br>
diff --git a/include/erofs/print.h b/include/erofs/print.h<br>
index 91f864bacd55..2213d1d58de5 100644<br>
--- a/include/erofs/print.h<br>
+++ b/include/erofs/print.h<br>
@@ -7,6 +7,11 @@<br>
=C2=A0#ifndef __EROFS_PRINT_H<br>
=C2=A0#define __EROFS_PRINT_H<br>
<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot;<br>
+{<br>
+#endif<br>
+<br>
=C2=A0#include &quot;config.h&quot;<br>
=C2=A0#include &lt;stdio.h&gt;<br>
<br>
@@ -72,4 +77,8 @@ enum {<br>
<br>
=C2=A0#define erofs_dump(fmt, ...) fprintf(stderr, fmt, ##__VA_ARGS__)<br>
<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
=C2=A0#endif<br>
diff --git a/include/erofs/trace.h b/include/erofs/trace.h<br>
index d70d23674c1a..893e16c5d6c1 100644<br>
--- a/include/erofs/trace.h<br>
+++ b/include/erofs/trace.h<br>
@@ -5,7 +5,16 @@<br>
=C2=A0#ifndef __EROFS_TRACE_H<br>
=C2=A0#define __EROFS_TRACE_H<br>
<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot;<br>
+{<br>
+#endif<br>
+<br>
=C2=A0#define trace_erofs_map_blocks_flatmode_enter(inode, map, flags) ((vo=
id)0)<br>
=C2=A0#define trace_erofs_map_blocks_flatmode_exit(inode, map, flags, ret) =
((void)0)<br>
<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
=C2=A0#endif<br>
diff --git a/include/erofs/xattr.h b/include/erofs/xattr.h<br>
index f0c4c268fecc..8e6881247f42 100644<br>
--- a/include/erofs/xattr.h<br>
+++ b/include/erofs/xattr.h<br>
@@ -7,6 +7,11 @@<br>
=C2=A0#ifndef __EROFS_XATTR_H<br>
=C2=A0#define __EROFS_XATTR_H<br>
<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot;<br>
+{<br>
+#endif<br>
+<br>
=C2=A0#include &quot;internal.h&quot;<br>
<br>
=C2=A0#define EROFS_INODE_XATTR_ICOUNT(_size)=C2=A0 =C2=A0 =C2=A0 =C2=A0 ({=
\<br>
@@ -44,4 +49,8 @@ int erofs_prepare_xattr_ibody(struct erofs_inode *inode);=
<br>
=C2=A0char *erofs_export_xattr_ibody(struct list_head *ixattrs, unsigned in=
t size);<br>
=C2=A0int erofs_build_shared_xattrs_from_path(const char *path);<br>
<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
=C2=A0#endif<br>
diff --git a/lib/Makefile.am b/lib/Makefile.am<br>
index 395c712811b8..67ba798672b9 100644<br>
--- a/lib/Makefile.am<br>
+++ b/lib/Makefile.am<br>
@@ -21,7 +21,8 @@ noinst_HEADERS =3D $(top_srcdir)/include/erofs_fs.h \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/include/erofs/print.h \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/include/erofs/trace.h \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0$(top_srcdir)/include/erofs/xattr.h \<br>
-=C2=A0 =C2=A0 =C2=A0 $(top_srcdir)/include/erofs/compress_hints.h<br>
+=C2=A0 =C2=A0 =C2=A0 $(top_srcdir)/include/erofs/compress_hints.h \<br>
+=C2=A0 =C2=A0 =C2=A0 $(top_srcdir)/lib/liberofs_private.h<br>
<br>
=C2=A0noinst_HEADERS +=3D compressor.h<br>
=C2=A0liberofs_la_SOURCES =3D config.c io.c cache.c super.c inode.c xattr.c=
 exclude.c \<br>
diff --git a/lib/config.c b/lib/config.c<br>
index 363dcc5a0525..f1c8edfda2dc 100644<br>
--- a/lib/config.c<br>
+++ b/lib/config.c<br>
@@ -8,6 +8,7 @@<br>
=C2=A0#include &lt;stdlib.h&gt;<br>
=C2=A0#include &quot;erofs/print.h&quot;<br>
=C2=A0#include &quot;erofs/internal.h&quot;<br>
+#include &quot;liberofs_private.h&quot;<br>
<br>
=C2=A0struct erofs_configure cfg;<br>
=C2=A0struct erofs_sb_info sbi;<br>
diff --git a/lib/inode.c b/lib/inode.c<br>
index 2fa74e2686c9..461c7978dbdf 100644<br>
--- a/lib/inode.c<br>
+++ b/lib/inode.c<br>
@@ -25,6 +25,7 @@<br>
=C2=A0#include &quot;erofs/block_list.h&quot;<br>
=C2=A0#include &quot;erofs/compress_hints.h&quot;<br>
=C2=A0#include &quot;erofs/blobchunk.h&quot;<br>
+#include &quot;liberofs_private.h&quot;<br>
<br>
=C2=A0#define S_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A012<br>
=C2=A0static unsigned char erofs_ftype_by_mode[S_IFMT &gt;&gt; S_SHIFT] =3D=
 {<br>
diff --git a/lib/liberofs_private.h b/lib/liberofs_private.h<br>
new file mode 100644<br>
index 000000000000..c2312e8e7a31<br>
--- /dev/null<br>
+++ b/lib/liberofs_private.h<br>
@@ -0,0 +1,13 @@<br>
+/* SPDX-License-Identifier: GPL-2.0-only OR Apache-2.0 */<br>
+<br>
+#ifdef HAVE_LIBSELINUX<br>
+#include &lt;selinux/selinux.h&gt;<br>
+#include &lt;selinux/label.h&gt;<br>
+#endif<br>
+<br>
+#ifdef WITH_ANDROID<br>
+#include &lt;selinux/android.h&gt;<br>
+#include &lt;private/android_filesystem_config.h&gt;<br>
+#include &lt;private/canned_fs_config.h&gt;<br>
+#include &lt;private/fs_config.h&gt;<br>
+#endif<br>
diff --git a/lib/xattr.c b/lib/xattr.c<br>
index 196133a1a798..00fb963c68ef 100644<br>
--- a/lib/xattr.c<br>
+++ b/lib/xattr.c<br>
@@ -17,6 +17,7 @@<br>
=C2=A0#include &quot;erofs/xattr.h&quot;<br>
=C2=A0#include &quot;erofs/cache.h&quot;<br>
=C2=A0#include &quot;erofs/io.h&quot;<br>
+#include &quot;liberofs_private.h&quot;<br>
<br>
=C2=A0#define EA_HASHTABLE_BITS 16<br>
<br>
-- <br>
2.20.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
 class=3D"gmail_signature"><div dir=3D"ltr">Sincerely,<div><br></div><div>K=
elvin Zhang</div></div></div>

--0000000000005c29c805d2196b19--
