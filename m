Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECB38C0DD3
	for <lists+linux-erofs@lfdr.de>; Thu,  9 May 2024 11:53:35 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VZnQN5Q94z3cTj
	for <lists+linux-erofs@lfdr.de>; Thu,  9 May 2024 19:53:32 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sjtu.edu.cn
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sjtu.edu.cn (client-ip=202.120.2.237; helo=smtp237.sjtu.edu.cn; envelope-from=zhaoyifan@sjtu.edu.cn; receiver=lists.ozlabs.org)
Received: from smtp237.sjtu.edu.cn (smtp237.sjtu.edu.cn [202.120.2.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VZnQF6NDZz30T0
	for <linux-erofs@lists.ozlabs.org>; Thu,  9 May 2024 19:53:23 +1000 (AEST)
Received: from proxy189.sjtu.edu.cn (smtp189.sjtu.edu.cn [202.120.2.189])
	by smtp237.sjtu.edu.cn (Postfix) with ESMTPS id D9D757FB50;
	Thu,  9 May 2024 17:53:13 +0800 (CST)
Received: from [7.250.24.31] (unknown [124.70.231.10])
	by proxy189.sjtu.edu.cn (Postfix) with ESMTPSA id 555363FC514;
	Thu,  9 May 2024 17:53:10 +0800 (CST)
Message-ID: <ab9bf1a7-6ea1-4a93-a21f-decfde503fe1@sjtu.edu.cn>
Date: Thu, 9 May 2024 17:53:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] erofs-utils: add preliminary zstd support
To: linux-erofs@lists.ozlabs.org, Gao Xiang <hsiangkao@linux.alibaba.com>
References: <20240508095818.3059914-1-hsiangkao@linux.alibaba.com>
Content-Language: en-CA
From: Yifan Zhao <zhaoyifan@sjtu.edu.cn>
In-Reply-To: <20240508095818.3059914-1-hsiangkao@linux.alibaba.com>
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

Hi Gao,

I found this zstd implementation failed in my smoking test[1] with 
-Eall-fragments and -Eztailpacking enabled. You could reproduce it with 
enwik8 workload.

After a galance I notice that libzstd_compress_destsize() may return a 
value larger than `dstsize`. I mark it in the code below.

I believe this will break the assumption in its caller and lead to 
broken image.

However I'm not an expert of zstd algorithms, could you please take a 
look at it?


[1] https://github.com/SToPire/erofsnightly/actions/runs/9004052391


On 2024/5/8 17:58, Gao Xiang wrote:
> This patch just adds a preliminary Zstandard support to erofs-utils
> since currently Zstandard doesn't support fixed-sized output compression
> officially.  Mkfs could take more time to finish but it works at least.
>
> The built-in zstd compressor for erofs-utils is slowly WIP, therefore
> apparently it will take more efforts.
>
> [ TODO: Later I tend to add another way to generate fixed-sized input
>          pclusters temporarily for relatively large pcluster sizes as
>          an option since it will have minor impacts to the results. ]
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>   configure.ac             |  34 ++++++++++
>   dump/Makefile.am         |   3 +-
>   fsck/Makefile.am         |   6 +-
>   fuse/Makefile.am         |   2 +-
>   include/erofs_fs.h       |  10 +++
>   lib/Makefile.am          |   3 +
>   lib/compress.c           |  24 ++++++++
>   lib/compressor.c         |   8 +++
>   lib/compressor.h         |   1 +
>   lib/compressor_libzstd.c | 130 +++++++++++++++++++++++++++++++++++++++
>   lib/decompress.c         |  59 ++++++++++++++++++
>   mkfs/Makefile.am         |   2 +-
>   12 files changed, 277 insertions(+), 5 deletions(-)
>   create mode 100644 lib/compressor_libzstd.c
>
> diff --git a/configure.ac b/configure.ac
> index 4a940a8..d862b4d 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -139,6 +139,10 @@ AC_ARG_WITH(libdeflate,
>         [Enable and build with libdeflate inflate support @<:@default=disabled@:>@])], [],
>         [with_libdeflate="no"])
>   
> +AC_ARG_WITH(libzstd,
> +   [AS_HELP_STRING([--with-libzstd],
> +      [Enable and build with of libzstd support @<:@default=auto@:>@])])
> +
>   AC_ARG_ENABLE(fuse,
>      [AS_HELP_STRING([--enable-fuse], [enable erofsfuse @<:@default=no@:>@])],
>      [enable_fuse="$enableval"], [enable_fuse="no"])
> @@ -474,6 +478,31 @@ AS_IF([test "x$with_libdeflate" != "xno"], [
>     LIBS="${saved_LIBS}"
>     CPPFLAGS="${saved_CPPFLAGS}"], [have_libdeflate="no"])
>   
> +# Configure libzstd
> +have_libzstd="no"
> +AS_IF([test "x$with_libzstd" != "xno"], [
> +  PKG_CHECK_MODULES([libzstd], [libzstd >= 1.4.0], [
> +    # Paranoia: don't trust the result reported by pkgconfig before trying out
> +    saved_LIBS="$LIBS"
> +    saved_CPPFLAGS=${CPPFLAGS}
> +    CPPFLAGS="${libzstd_CFLAGS} ${CPPFLAGS}"
> +    LIBS="${libzstd_LIBS} $LIBS"
> +    AC_CHECK_HEADERS([zstd.h],[
> +      AC_CHECK_LIB(zstd, ZSTD_decompressDCtx, [], [
> +        AC_MSG_ERROR([libzstd doesn't work properly])])
> +      AC_CHECK_DECL(ZSTD_decompressDCtx, [have_libzstd="yes"],
> +        [AC_MSG_ERROR([libzstd doesn't work properly])], [[
> +#include <zstd.h>
> +      ]])
> +    ])
> +    LIBS="${saved_LIBS}"
> +    CPPFLAGS="${saved_CPPFLAGS}"], [
> +    AS_IF([test "x$with_libzstd" = "xyes"], [
> +      AC_MSG_ERROR([Cannot find proper libzstd])
> +    ])
> +  ])
> +])
> +
>   # Enable 64-bit off_t
>   CFLAGS+=" -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
>   
> @@ -494,6 +523,7 @@ AM_CONDITIONAL([ENABLE_LZ4HC], [test "x${have_lz4hc}" = "xyes"])
>   AM_CONDITIONAL([ENABLE_FUSE], [test "x${have_fuse}" = "xyes"])
>   AM_CONDITIONAL([ENABLE_LIBLZMA], [test "x${have_liblzma}" = "xyes"])
>   AM_CONDITIONAL([ENABLE_LIBDEFLATE], [test "x${have_libdeflate}" = "xyes"])
> +AM_CONDITIONAL([ENABLE_LIBZSTD], [test "x${have_libzstd}" = "xyes"])
>   
>   if test "x$have_uuid" = "xyes"; then
>     AC_DEFINE([HAVE_LIBUUID], 1, [Define to 1 if libuuid is found])
> @@ -539,6 +569,10 @@ if test "x$have_libdeflate" = "xyes"; then
>     AC_DEFINE([HAVE_LIBDEFLATE], 1, [Define to 1 if libdeflate is found])
>   fi
>   
> +if test "x$have_libzstd" = "xyes"; then
> +  AC_DEFINE([HAVE_LIBZSTD], 1, [Define to 1 if libzstd is found])
> +fi
> +
>   # Dump maximum block size
>   AS_IF([test "x$erofs_cv_max_block_size" = "x"],
>         [$erofs_cv_max_block_size = 4096], [])
> diff --git a/dump/Makefile.am b/dump/Makefile.am
> index aed20c2..09c483e 100644
> --- a/dump/Makefile.am
> +++ b/dump/Makefile.am
> @@ -7,4 +7,5 @@ AM_CPPFLAGS = ${libuuid_CFLAGS}
>   dump_erofs_SOURCES = main.c
>   dump_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
>   dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
> -	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS}
> +	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
> +	${libzstd_LIBS}
> diff --git a/fsck/Makefile.am b/fsck/Makefile.am
> index d024405..70eacc0 100644
> --- a/fsck/Makefile.am
> +++ b/fsck/Makefile.am
> @@ -7,7 +7,8 @@ AM_CPPFLAGS = ${libuuid_CFLAGS}
>   fsck_erofs_SOURCES = main.c
>   fsck_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
>   fsck_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
> -	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS}
> +	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
> +	${libzstd_LIBS}
>   
>   if ENABLE_FUZZING
>   noinst_PROGRAMS   = fuzz_erofsfsck
> @@ -15,5 +16,6 @@ fuzz_erofsfsck_SOURCES = main.c
>   fuzz_erofsfsck_CFLAGS = -Wall -I$(top_srcdir)/include -DFUZZING
>   fuzz_erofsfsck_LDFLAGS = -fsanitize=address,fuzzer
>   fuzz_erofsfsck_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
> -	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS}
> +	${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} \
> +	${libzstd_LIBS}
>   endif
> diff --git a/fuse/Makefile.am b/fuse/Makefile.am
> index c63efcd..7eae5f6 100644
> --- a/fuse/Makefile.am
> +++ b/fuse/Makefile.am
> @@ -7,4 +7,4 @@ erofsfuse_SOURCES = main.c
>   erofsfuse_CFLAGS = -Wall -I$(top_srcdir)/include
>   erofsfuse_CFLAGS += ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
>   erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
> -	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS}
> +	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS} ${libzstd_LIBS}
> diff --git a/include/erofs_fs.h b/include/erofs_fs.h
> index eba6c26..907f3d8 100644
> --- a/include/erofs_fs.h
> +++ b/include/erofs_fs.h
> @@ -304,6 +304,7 @@ enum {
>   	Z_EROFS_COMPRESSION_LZ4		= 0,
>   	Z_EROFS_COMPRESSION_LZMA	= 1,
>   	Z_EROFS_COMPRESSION_DEFLATE	= 2,
> +	Z_EROFS_COMPRESSION_ZSTD	= 3,
>   	Z_EROFS_COMPRESSION_MAX
>   };
>   #define Z_EROFS_ALL_COMPR_ALGS		((1 << Z_EROFS_COMPRESSION_MAX) - 1)
> @@ -330,6 +331,15 @@ struct z_erofs_deflate_cfgs {
>   	u8 reserved[5];
>   } __packed;
>   
> +/* 6 bytes (+ length field = 8 bytes) */
> +struct z_erofs_zstd_cfgs {
> +	u8 format;
> +	u8 windowlog;		/* windowLog - ZSTD_WINDOWLOG_ABSOLUTEMIN(10) */
> +	u8 reserved[4];
> +} __packed;
> +
> +#define Z_EROFS_ZSTD_MAX_DICT_SIZE	Z_EROFS_PCLUSTER_MAX_SIZE
> +
>   /*
>    * bit 0 : COMPACTED_2B indexes (0 - off; 1 - on)
>    *  e.g. for 4k logical cluster size,      4B        if compacted 2B is off;
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index b3bea74..2cb4cab 100644
> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -53,6 +53,9 @@ liberofs_la_SOURCES += kite_deflate.c compressor_deflate.c
>   if ENABLE_LIBDEFLATE
>   liberofs_la_SOURCES += compressor_libdeflate.c
>   endif
> +if ENABLE_LIBZSTD
> +liberofs_la_SOURCES += compressor_libzstd.c
> +endif
>   if ENABLE_EROFS_MT
>   liberofs_la_LDFLAGS = -lpthread
>   liberofs_la_SOURCES += workqueue.c
> diff --git a/lib/compress.c b/lib/compress.c
> index e3e4c21..f783236 100644
> --- a/lib/compress.c
> +++ b/lib/compress.c
> @@ -1655,6 +1655,30 @@ static int z_erofs_build_compr_cfgs(struct erofs_sb_info *sbi,
>   				sizeof(zalg));
>   		bh->op = &erofs_drop_directly_bhops;
>   	}
> +#ifdef HAVE_LIBZSTD
> +	if (sbi->available_compr_algs & (1 << Z_EROFS_COMPRESSION_ZSTD)) {
> +		struct {
> +			__le16 size;
> +			struct z_erofs_zstd_cfgs z;
> +		} __packed zalg = {
> +			.size = cpu_to_le16(sizeof(struct z_erofs_zstd_cfgs)),
> +			.z = {
> +				.windowlog =
> +					ilog2(max_dict_size[Z_EROFS_COMPRESSION_ZSTD]) - 10,
> +			}
> +		};
> +
> +		bh = erofs_battach(bh, META, sizeof(zalg));
> +		if (IS_ERR(bh)) {
> +			DBG_BUGON(1);
> +			return PTR_ERR(bh);
> +		}
> +		erofs_mapbh(bh->block);
> +		ret = dev_write(sbi, &zalg, erofs_btell(bh, false),
> +				sizeof(zalg));
> +		bh->op = &erofs_drop_directly_bhops;
> +	}
> +#endif
>   	return ret;
>   }
>   
> diff --git a/lib/compressor.c b/lib/compressor.c
> index 175259e..24c99ac 100644
> --- a/lib/compressor.c
> +++ b/lib/compressor.c
> @@ -37,6 +37,14 @@ static const struct erofs_algorithm erofs_algs[] = {
>   	{ "libdeflate", &erofs_compressor_libdeflate,
>   	  Z_EROFS_COMPRESSION_DEFLATE, true },
>   #endif
> +
> +	{ "zstd",
> +#ifdef HAVE_LIBZSTD
> +		&erofs_compressor_libzstd,
> +#else
> +		NULL,
> +#endif
> +	  Z_EROFS_COMPRESSION_ZSTD, false },
>   };
>   
>   int z_erofs_get_compress_algorithm_id(const struct erofs_compress *c)
> diff --git a/lib/compressor.h b/lib/compressor.h
> index 96f2d21..59d525d 100644
> --- a/lib/compressor.h
> +++ b/lib/compressor.h
> @@ -53,6 +53,7 @@ extern const struct erofs_compressor erofs_compressor_lz4hc;
>   extern const struct erofs_compressor erofs_compressor_lzma;
>   extern const struct erofs_compressor erofs_compressor_deflate;
>   extern const struct erofs_compressor erofs_compressor_libdeflate;
> +extern const struct erofs_compressor erofs_compressor_libzstd;
>   
>   int z_erofs_get_compress_algorithm_id(const struct erofs_compress *c);
>   int erofs_compress_destsize(const struct erofs_compress *c,
> diff --git a/lib/compressor_libzstd.c b/lib/compressor_libzstd.c
> new file mode 100644
> index 0000000..e7c3375
> --- /dev/null
> +++ b/lib/compressor_libzstd.c
> @@ -0,0 +1,130 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +#include "erofs/internal.h"
> +#include "erofs/print.h"
> +#include "erofs/config.h"
> +#include <zstd.h>
> +#include <zstd_errors.h>
> +#include <alloca.h>
> +#include "compressor.h"
> +#include "erofs/atomic.h"
> +
> +static int libzstd_compress_destsize(const struct erofs_compress *c,
> +				       const void *src, unsigned int *srcsize,
> +				       void *dst, unsigned int dstsize)
> +{
> +	ZSTD_CCtx *cctx = c->private_data;
> +	size_t l = dstsize; /* largest input that fits so far */
> +	size_t l_csize = 0;
> +	size_t r = *srcsize + 1; /* smallest input that doesn't fit so far */
> +	size_t m;
> +	u8 *fitblk_buffer = alloca(dstsize + 32);
> +
> +	m = dstsize * 4;
> +	for (;;) {
> +		size_t csize;
> +
> +		m = max(m, l + 1);
> +		m = min(m, r - 1);
> +
> +		ZSTD_CCtx_setParameter(cctx, ZSTD_c_windowLog, ilog2(c->dict_size));
> +		csize = ZSTD_compressCCtx(cctx, fitblk_buffer,
> +				     dstsize + 32, src, m, c->compression_level);
> +		if (ZSTD_isError(csize)) {
> +			if (ZSTD_getErrorCode(csize) == ZSTD_error_dstSize_tooSmall)
> +				goto doesnt_fit;
> +			return -EFAULT;
> +		}
> +
> +		if (csize > 0 && csize <= dstsize) {
> +			/* Fits */
> +			memcpy(dst, fitblk_buffer, csize);
> +			l = m;
> +			l_csize = csize;
> +			if (r <= l + 1 || csize + 1 >= dstsize)
> +				break;
> +			/*
> +			 * Estimate needed input prefix size based on current
> +			 * compression ratio.
> +			 */
> +			m = (dstsize * m) / csize;
> +		} else {
> +doesnt_fit:
> +			/* Doesn't fit */
> +			r = m;
> +			if (r <= l + 1)
> +				break;
> +			m = (l + r) / 2;
> +		}
> +	}
> +	if (l <= dstsize)
> +		return max(*srcsize, dstsize) + 1;

Here, if dstsize == 4096, the return value may be 4097.


Yifan Zhao

> +	*srcsize = l;
> +	return l_csize;
> +}
> +
> +static int compressor_libzstd_exit(struct erofs_compress *c)
> +{
> +	if (!c->private_data)
> +		return -EINVAL;
> +	ZSTD_freeCCtx(c->private_data);
> +	return 0;
> +}
> +
> +static int erofs_compressor_libzstd_setlevel(struct erofs_compress *c,
> +					     int compression_level)
> +{
> +	if (compression_level > erofs_compressor_libzstd.best_level) {
> +		erofs_err("invalid compression level %d", compression_level);
> +		return -EINVAL;
> +	}
> +	c->compression_level = compression_level;
> +	return 0;
> +}
> +
> +static int erofs_compressor_libzstd_setdictsize(struct erofs_compress *c,
> +						u32 dict_size)
> +{
> +	if (!dict_size) {
> +		if (erofs_compressor_libzstd.default_dictsize) {
> +			dict_size = erofs_compressor_libzstd.default_dictsize;
> +		} else {
> +			dict_size = min_t(u32, Z_EROFS_ZSTD_MAX_DICT_SIZE,
> +					  cfg.c_mkfs_pclustersize_max << 3);
> +			dict_size = 1 << ilog2(dict_size);
> +		}
> +	}
> +	if (dict_size != 1 << ilog2(dict_size) ||
> +	    dict_size > Z_EROFS_ZSTD_MAX_DICT_SIZE) {
> +		erofs_err("invalid dictionary size %u", dict_size);
> +		return -EINVAL;
> +	}
> +	c->dict_size = dict_size;
> +	return 0;
> +}
> +
> +static int compressor_libzstd_init(struct erofs_compress *c)
> +{
> +	static erofs_atomic_bool_t __warnonce;
> +
> +	ZSTD_freeCCtx(c->private_data);
> +	c->private_data = ZSTD_createCCtx();
> +	if (!c->private_data)
> +		return -ENOMEM;
> +
> +	if (!erofs_atomic_test_and_set(&__warnonce)) {
> +		erofs_warn("EXPERIMENTAL libzstd compressor in use. Note that `fitblk` isn't supported by upstream zstd for now.");
> +		erofs_warn("Therefore it will takes more time in order to get the optimal result.");
> +		erofs_info("You could clarify further needs in zstd repository <https://github.com/facebook/zstd/issues> for reference too.");
> +	}
> +	return 0;
> +}
> +
> +const struct erofs_compressor erofs_compressor_libzstd = {
> +	.default_level = ZSTD_CLEVEL_DEFAULT,
> +	.best_level = 22,
> +	.init = compressor_libzstd_init,
> +	.exit = compressor_libzstd_exit,
> +	.setlevel = erofs_compressor_libzstd_setlevel,
> +	.setdictsize = erofs_compressor_libzstd_setdictsize,
> +	.compress_destsize = libzstd_compress_destsize,
> +};
> diff --git a/lib/decompress.c b/lib/decompress.c
> index fe8a40c..8ff0b6b 100644
> --- a/lib/decompress.c
> +++ b/lib/decompress.c
> @@ -9,6 +9,61 @@
>   #include "erofs/err.h"
>   #include "erofs/print.h"
>   
> +#ifdef HAVE_LIBZSTD
> +#include <zstd.h>
> +#include <zstd_errors.h>
> +
> +/* also a very preliminary userspace version */
> +static int z_erofs_decompress_zstd(struct z_erofs_decompress_req *rq)
> +{
> +	struct erofs_sb_info *sbi = rq->sbi;
> +	int ret = 0;
> +	char *dest = rq->out;
> +	char *src = rq->in;
> +	char *buff = NULL;
> +	unsigned int inputmargin = 0;
> +	unsigned int total;
> +
> +	while (!src[inputmargin & (erofs_blksiz(sbi) - 1)])
> +		if (!(++inputmargin & (erofs_blksiz(sbi) - 1)))
> +			break;
> +
> +	if (inputmargin >= rq->inputsize)
> +		return -EFSCORRUPTED;
> +
> +	total = ZSTD_getDecompressedSize(src + inputmargin,
> +					 rq->inputsize - inputmargin);
> +	if (rq->decodedskip || total != rq->decodedlength) {
> +		buff = malloc(total);
> +		if (!buff)
> +			return -ENOMEM;
> +		dest = buff;
> +	}
> +
> +	ret = ZSTD_decompress(dest, total,
> +			      src + inputmargin, rq->inputsize - inputmargin);
> +	if (ZSTD_isError(ret)) {
> +		erofs_err("ZSTD decompress failed %d: %s", ZSTD_getErrorCode(ret),
> +			  ZSTD_getErrorName(ret));
> +		ret = -EIO;
> +		goto out;
> +	}
> +
> +	if (ret != (int)total) {
> +		erofs_err("ZSTD decompress length mismatch %d, expected %d",
> +			  ret, total);
> +		goto out;
> +	}
> +	if (rq->decodedskip || total != rq->decodedlength)
> +		memcpy(rq->out, dest + rq->decodedskip,
> +		       rq->decodedlength - rq->decodedskip);
> +out:
> +	if (buff)
> +		free(buff);
> +	return ret;
> +}
> +#endif
> +
>   #ifdef HAVE_LIBDEFLATE
>   /* if libdeflate is available, use libdeflate instead. */
>   #include <libdeflate.h>
> @@ -322,6 +377,10 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq)
>   #if defined(HAVE_ZLIB) || defined(HAVE_LIBDEFLATE)
>   	if (rq->alg == Z_EROFS_COMPRESSION_DEFLATE)
>   		return z_erofs_decompress_deflate(rq);
> +#endif
> +#ifdef HAVE_LIBZSTD
> +	if (rq->alg == Z_EROFS_COMPRESSION_ZSTD)
> +		return z_erofs_decompress_zstd(rq);
>   #endif
>   	return -EOPNOTSUPP;
>   }
> diff --git a/mkfs/Makefile.am b/mkfs/Makefile.am
> index dd75485..af97e39 100644
> --- a/mkfs/Makefile.am
> +++ b/mkfs/Makefile.am
> @@ -7,4 +7,4 @@ mkfs_erofs_SOURCES = main.c
>   mkfs_erofs_CFLAGS = -Wall -I$(top_srcdir)/include
>   mkfs_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} \
>   	${libuuid_LIBS} ${liblz4_LIBS} ${liblzma_LIBS} ${zlib_LIBS} \
> -	${libdeflate_LIBS}
> +	${libdeflate_LIBS} ${libzstd_LIBS}
