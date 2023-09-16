Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0CE7A3156
	for <lists+linux-erofs@lfdr.de>; Sat, 16 Sep 2023 18:14:07 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Rnx2C6qb5z3c2k
	for <lists+linux-erofs@lfdr.de>; Sun, 17 Sep 2023 02:13:55 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.110; helo=out30-110.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Rnx244xrLz3byy
	for <linux-erofs@lists.ozlabs.org>; Sun, 17 Sep 2023 02:13:46 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R371e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VsAIGE2_1694880818;
Received: from 30.25.210.188(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VsAIGE2_1694880818)
          by smtp.aliyun-inc.com;
          Sun, 17 Sep 2023 00:13:39 +0800
Message-ID: <26f9be6d-34c0-3c40-ba88-1c9c3af9ee02@linux.alibaba.com>
Date: Sun, 17 Sep 2023 00:13:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v9] erofs-utils: add support for fuse 2/3 lowlevel API
To: Li Yiyan <lyy0627@sjtu.edu.cn>, linux-erofs@lists.ozlabs.org
References: <20230903113823.873232-1-lyy0627@sjtu.edu.cn>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230903113823.873232-1-lyy0627@sjtu.edu.cn>
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



On 2023/9/3 19:38, Li Yiyan wrote:
> Hi Xiang:
> 
> Could you please help me check V9? For readdirplus, not providing
> complete stat information does indeed lead to errors. I have fixed
> this issue. Thank you!

Sorry for late reply.

> 
> Support FUSE low-level APIs for erofsfuse. Lowlevel APIs offer improved
> performance compared to the previous high-level APIs, while maintaining
> compatibility with libfuse version 2(>=2.6) and 3 (>=3.0).
> 
> Dataset: linux 5.15
> Compression algorithm: lz4hc,12
> Additional options: -T0 -C16384
> Test options: --warmup 3 -p "echo 3 > /proc/sys/vm/drop_caches; sleep 1"
> 
> Evaluation result (highlevel->lowlevel avg time):
> 	- Sequence metadata: 777.3 ms->180.9 ms
> 	- Sequence data: 3.282 s->818.1 ms
> 	- Random metadata: 1.571 s->928.3 ms
> 	- Random data: 2.461 s->597.8 ms
> 
> Signed-off-by: Li Yiyan <lyy0627@sjtu.edu.cn>
> ---
> Changes since v8:
> - correctly set umode of readdir
> - fill full stat for readdirplus
> 
> Changes since v7:
> - optimize errno
> - optimize mapping between nid and ino
> - remove redundant workaround
> 
> Changes since v6:
> - remove redundant code
> - optimize naming
> - add eval data
> 
> Changes since v5:
> - name retval to `ret` from `err`
> 
> Changes since v4:
> - support fuse option
> - default run in daemon
> - remove redundant log
> 
> Changes since v3:
> - remove ll identifier
> - optimize naming
> - remove redundant log
> - add fixme label for confusing xattr_buf
> 
> Changes since v2:
> - merge lowlevel.c into main.c
> - fix typo in autoconf
> - optimize naming
> - remove redundant code
> - avoid global sbi dependencies
> 
> Changes since v1:
> - remove highlevel fallback path
> - remove redundant code
> - add static for erofsfuse_ll_func
> 
>   configure.ac          |  23 +-
>   fuse/Makefile.am      |   4 +-
>   fuse/main.c           | 624 ++++++++++++++++++++++++++++++++++--------
>   include/erofs/inode.h |   1 +
>   lib/inode.c           |  19 ++
>   5 files changed, 544 insertions(+), 127 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index a8cecd0..6d08d96 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -336,15 +336,26 @@ AS_IF([test "x$with_selinux" != "xno"], [
>   
>   # Configure fuse
>   AS_IF([test "x$enable_fuse" != "xno"], [
> -  PKG_CHECK_MODULES([libfuse], [fuse >= 2.6])
>     # Paranoia: don't trust the result reported by pkgconfig before trying out
>     saved_LIBS="$LIBS"
>     saved_CPPFLAGS=${CPPFLAGS}
> -  CPPFLAGS="${libfuse_CFLAGS} ${CPPFLAGS}"
> -  LIBS="${libfuse_LIBS} $LIBS"
> -  AC_CHECK_LIB(fuse, fuse_main, [
> -    have_fuse="yes" ], [
> -    AC_MSG_ERROR([libfuse (>= 2.6) doesn't work properly])])
> +  PKG_CHECK_MODULES([libfuse3], [fuse3 >= 3.0], [
> +    AC_DEFINE([FUSE_USE_VERSION], [30], [used FUSE API version])
> +    CPPFLAGS="${libfuse3_CFLAGS} ${CPPFLAGS}"
> +    LIBS="${libfuse3_LIBS} $LIBS"
> +    AC_CHECK_LIB(fuse3, fuse_session_new, [], [
> +    AC_MSG_ERROR([libfuse3 (>= 3.0) doesn't work properly for lowlevel api])])
> +    have_fuse="yes"
> +  ], [
> +    PKG_CHECK_MODULES([libfuse2], [fuse >= 2.6], [
> +      AC_DEFINE([FUSE_USE_VERSION], [26], [used FUSE API version])
> +      CPPFLAGS="${libfuse2_CFLAGS} ${CPPFLAGS}"
> +      LIBS="${libfuse2_LIBS} $LIBS"
> +      AC_CHECK_LIB(fuse, fuse_lowlevel_new, [], [
> +        AC_MSG_ERROR([libfuse (>= 2.6) doesn't work properly for lowlevel api])])
> +      have_fuse="yes"
> +    ], [have_fuse="no"])
> +  ])
>     LIBS="${saved_LIBS}"
>     CPPFLAGS="${saved_CPPFLAGS}"], [have_fuse="no"])
>   
> diff --git a/fuse/Makefile.am b/fuse/Makefile.am
> index 50be783..c63efcd 100644
> --- a/fuse/Makefile.am
> +++ b/fuse/Makefile.am
> @@ -5,6 +5,6 @@ noinst_HEADERS = $(top_srcdir)/fuse/macosx.h
>   bin_PROGRAMS     = erofsfuse
>   erofsfuse_SOURCES = main.c
>   erofsfuse_CFLAGS = -Wall -I$(top_srcdir)/include
> -erofsfuse_CFLAGS += -DFUSE_USE_VERSION=26 ${libfuse_CFLAGS} ${libselinux_CFLAGS}
> -erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse_LIBS} ${liblz4_LIBS} \
> +erofsfuse_CFLAGS += ${libfuse2_CFLAGS} ${libfuse3_CFLAGS} ${libselinux_CFLAGS}
> +erofsfuse_LDADD = $(top_builddir)/lib/liberofs.la ${libfuse2_LIBS} ${libfuse3_LIBS} ${liblz4_LIBS} \
>   	${libselinux_LIBS} ${liblzma_LIBS} ${zlib_LIBS} ${libdeflate_LIBS}
> diff --git a/fuse/main.c b/fuse/main.c
> index 821d98c..25f4f34 100644
> --- a/fuse/main.c
> +++ b/fuse/main.c
> @@ -1,13 +1,12 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
>    * Created by Li Guifu <blucerlee@gmail.com>
> + * Lowlevel added by Li Yiyan <lyy0627@sjtu.edu.cn>
>    */
>   #include <stdlib.h>
>   #include <string.h>
>   #include <signal.h>
>   #include <libgen.h>
> -#include <fuse.h>
> -#include <fuse_opt.h>
>   #include "macosx.h"
>   #include "erofs/config.h"
>   #include "erofs/print.h"
> @@ -15,177 +14,501 @@
>   #include "erofs/dir.h"
>   #include "erofs/inode.h"
>   
> -struct erofsfuse_dir_context {
> +#include <float.h>
> +#include <fuse.h>
> +#include <fuse_lowlevel.h>
> +
> +#define EROFSFUSE_TIMEOUT DBL_MAX
> +
> +struct erofsfuse_readdir_context {
>   	struct erofs_dir_context ctx;
> -	fuse_fill_dir_t filler;
> -	struct fuse_file_info *fi;
> +
> +	fuse_req_t req;
>   	void *buf;
> +	int is_plus;
> +	size_t offset;
> +	size_t buf_size;

please rename it as buf_rem;

> +	size_t start_off;
> +	struct fuse_file_info *fi;
> +};
> +
> +struct erofsfuse_lookupdir_context {
> +	struct erofs_dir_context ctx;
> +
> +	const char *target_name;
> +	struct fuse_entry_param *ent;
>   };
>   
> -static int erofsfuse_fill_dentries(struct erofs_dir_context *ctx)
> +static inline erofs_nid_t erofsfuse_to_nid(fuse_ino_t ino)
> +{
> +	if (ino == FUSE_ROOT_ID)
> +		return sbi.root_nid;
> +	return (erofs_nid_t)(ino - FUSE_ROOT_ID);
> +}
> +
> +static inline fuse_ino_t erofsfuse_to_ino(erofs_nid_t nid)
> +{
> +	if (nid == sbi.root_nid)
> +		return FUSE_ROOT_ID;
> +	return (nid + FUSE_ROOT_ID);
> +}
> +
> +static void erofsfuse_fill_stat(struct erofs_inode *vi, struct stat *stbuf)
> +{
> +	if (S_ISBLK(vi->i_mode) || S_ISCHR(vi->i_mode))
> +		stbuf->st_rdev = vi->u.i_rdev;
> +
> +	stbuf->st_mode = vi->i_mode;
> +	stbuf->st_nlink = vi->i_nlink;
> +	stbuf->st_size = vi->i_size;
> +	stbuf->st_blocks = roundup(vi->i_size, erofs_blksiz(&sbi)) >> 9;
> +	stbuf->st_uid = vi->i_uid;
> +	stbuf->st_gid = vi->i_gid;
> +	stbuf->st_ctime = vi->i_mtime;
> +	stbuf->st_mtime = stbuf->st_ctime;
> +	stbuf->st_atime = stbuf->st_ctime;
> +}
> +
> +static int erofsfuse_add_dentry(struct erofs_dir_context *ctx)
>   {
> -	struct erofsfuse_dir_context *fusectx = (void *)ctx;
> -	struct stat st = {0};
> +	size_t size = 0;

please rename it as entsize,  or see:
https://github.com/libfuse/libfuse/blob/master/example/passthrough_ll.c#L665

There are many `size`s here, I'm not sure which size you're meaning.

>   	char dname[EROFS_NAME_LEN + 1];
> +	struct erofsfuse_readdir_context *readdir_ctx = (void *)ctx;
> +
> +	if (readdir_ctx->offset < readdir_ctx->start_off) {
> +		readdir_ctx->offset +=
> +			ctx->de_namelen + sizeof(struct erofs_dirent);

I still don't think it's right.

First, if you treat it as an real offset of directory file, this
        calculation is incorrect.  There are many reasons, the
        obvious one is that "each directory block may have trailing
        padding data"

Second, if you just treat it as an "index", for example.  Then,
         I don't really understand why you rename

       readdir_ctx->offset => readdir_ctx->index
       readdir_ctx->start_off => readdir_ctx->offset

and make readdir_ctx->index add by one for each iteration?

Anyway, this part seems quite odd to me.

> +		return 0;
> +	}
>   
>   	strncpy(dname, ctx->dname, ctx->de_namelen);
>   	dname[ctx->de_namelen] = '\0';
> -	st.st_mode = erofs_ftype_to_dtype(ctx->de_ftype) << 12;
> -	fusectx->filler(fusectx->buf, dname, &st, 0);
> +	readdir_ctx->offset += ctx->de_namelen + sizeof(struct erofs_dirent);
> +
> +	if (!readdir_ctx->is_plus) { /* fuse 3 still use non-plus readdir */
> +		struct stat st = { 0 };
> +
> +		st.st_mode = erofs_ftype_to_mode(ctx->de_ftype, 0);
> +		st.st_ino = ctx->de_nid;

I think it's buggy here, I think you need to:
		st.st_ino = erofsfuse_to_ino(ctx->de_nid);

> +		size = fuse_add_direntry(readdir_ctx->req, readdir_ctx->buf,
> +					 readdir_ctx->buf_size, dname, &st,
> +					 readdir_ctx->offset);
> +	} else {
> +#if FUSE_MAJOR_VERSION >= 3
> +		int ret;
> +		struct erofs_inode vi = {
> +			.sbi = &sbi,
> +			.nid = ctx->de_nid
> +		};
> +
> +		ret = erofs_read_inode_from_disk(&vi);
> +		if (ret < 0)
> +			return ret;
> +
> +		struct fuse_entry_param param = {
> +			.ino = erofsfuse_to_ino(ctx->de_nid),
> +			.attr.st_ino = erofsfuse_to_ino(ctx->de_nid),
> +			.generation = 0,
> +
> +			.attr_timeout = EROFSFUSE_TIMEOUT,
> +			.entry_timeout = EROFSFUSE_TIMEOUT,
> +		};
> +		erofsfuse_fill_stat(&vi, &(param.attr));
> +
> +		size = fuse_add_direntry_plus(readdir_ctx->req,
> +					      readdir_ctx->buf,
> +					      readdir_ctx->buf_size, dname,
> +					      &param, readdir_ctx->offset);

Please

   #else
		return -EOPNOTSUPP;

here.


> +#endif
> +	}
> +
> +	if (size > readdir_ctx->buf_size) {
> +		readdir_ctx->offset -=
> +			ctx->de_namelen + sizeof(struct erofs_dirent);

See above.

> +		return 1;
> +	}
> +	readdir_ctx->buf += size;
> +	readdir_ctx->buf_size -= size;


	readdir_ctx->buf += entsize;
	readdir_ctx->buf_rem -= entsize;

>   	return 0;
>   }
>   
> -int erofsfuse_readdir(const char *path, void *buf, fuse_fill_dir_t filler,
> -		      off_t offset, struct fuse_file_info *fi)

...

> +static inline void erofsfuse_readdir_general(fuse_req_t req, fuse_ino_t ino,
> +					     size_t size, off_t off,
> +					     struct fuse_file_info *fi,
> +					     int plus)
> +{
> +	int ret = 0;
> +	char *buf = NULL;
> +	struct erofsfuse_readdir_context ctx;

I'd suggest to use
	struct erofsfuse_readdir_context ctx = {};

to avoid potential uninitialization.

> +	struct erofs_inode *vi = (struct erofs_inode *)fi->fh;
> +
> +	erofs_dbg("ino: %lu, size: %lu, off: %lu, plus: %d", ino, size, off,

...

>   };
>   
>   static void usage(void)
>   {
> -	struct fuse_args args = FUSE_ARGS_INIT(0, NULL);
> +#if FUSE_MAJOR_VERSION >= 3
> +	fuse_lowlevel_version();
> +#endif
> +	fprintf(stderr, "erofsfuse version: %s\n\n", cfg.c_version);
>   
>   	fputs("usage: [options] IMAGE MOUNTPOINT\n\n"
>   	      "Options:\n"
> @@ -220,12 +548,15 @@ static void usage(void)
>   	      "    --device=#             specify an extra device to be used together\n"
>   #if FUSE_MAJOR_VERSION < 3
>   	      "    --help                 display this help and exit\n"
> +	      "    --version              display erofsfuse version\n"
>   #endif
>   	      "\n", stderr);
>   
>   #if FUSE_MAJOR_VERSION >= 3
> +	fputs("\nFUSE options:\n", stderr);
>   	fuse_cmdline_help();
>   #else
> +	struct fuse_args args = FUSE_ARGS_INIT(0, NULL);
>   	fuse_opt_add_arg(&args, ""); /* progname */
>   	fuse_opt_add_arg(&args, "-ho"); /* progname */
>   	fuse_parse_cmdline(&args, NULL, NULL, NULL);
> @@ -264,14 +595,14 @@ static int optional_opt_func(void *data, const char *arg, int key,
>   		if (!fusecfg.mountpoint)
>   			fusecfg.mountpoint = strdup(arg);
>   	case FUSE_OPT_KEY_OPT:
> -		if (!strcmp(arg, "-d"))
> +		if (!strncmp(arg, "-d", 2))
>   			fusecfg.odebug = true;
> -		break;
> -	default:
> -		DBG_BUGON(1);
> -		break;
> +		if (!strncmp(arg, "-h", 2))
> +			fusecfg.show_help = true;
> +		if (!strncmp(arg, "-V", 2))
> +			fusecfg.show_version = true;

Why you need to change this from strcmp to strncmp()?


Besides, please change all debugging messages into:

erofs_dbg("read (%llu): size = %zu, off = %lu", ino | 0ULL, size, off);
..
erofs_dbg("getxattr(%llu): name = %s, size = %zu",
	  ino | 0ULL, name, size);
..
erofs_dbg("listxattr(%llu): size = %zu", ino | 0ULL, size);


Finally, I try this commit with linux-6.1.53 source code and _libfuse2_,
and I got several false corruptions like below:

$fssum -MACUG mnt
stat failed for mnt//Documentation/ABI: Structure needs cleaning

[xize.gx@e69b19392.et15sqa /home/xize.gx/erofs-utils]
$fssum -MACUG mnt
stat failed for mnt//Documentation/ABI: Structure needs cleaning

[xize.gx@e69b19392.et15sqa /home/xize.gx/erofs-utils]
$fssum -MACUG mnt
stat failed for mnt//Documentation/.gitignore: Structure needs cleaning

[xize.gx@e69b19392.et15sqa /home/xize.gx/erofs-utils]
$fssum -MACUG mnt
stat failed for mnt//LICENSES/deprecated: Structure needs cleaning

[xize.gx@e69b19392.et15sqa /home/xize.gx/erofs-utils]
$fssum -MACUG mnt
stat failed for mnt//drivers/staging/most: Structure needs cleaning

[xize.gx@e69b19392.et15sqa /home/xize.gx/erofs-utils]
$fssum -MACUG mnt
stat failed for mnt//drivers/staging/most: Structure needs cleaning

[xize.gx@e69b19392.et15sqa /home/xize.gx/erofs-utils]
$fssum -MACUG mnt
stat failed for mnt//tools/testing/selftests/drivers/net/bonding/settings: Structure needs cleaning

I don't think it's a correct sign.  I try to debug more but
it seems more issues here, I gave up eveuatually.

Thanks,
Gao Xiang

