Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 7146340792B
	for <lists+linux-erofs@lfdr.de>; Sat, 11 Sep 2021 17:45:37 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H6HBl2gvzz2yMN
	for <lists+linux-erofs@lfdr.de>; Sun, 12 Sep 2021 01:45:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=sqIGRr7z;
	dkim-atps=neutral
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=xiang@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=sqIGRr7z; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H6HBd4sSXz2yHw
 for <linux-erofs@lists.ozlabs.org>; Sun, 12 Sep 2021 01:45:29 +1000 (AEST)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E872E611B0;
 Sat, 11 Sep 2021 15:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631375126;
 bh=TK8K6xOiYQDU7YiWz1KJcYMcys2KtP4G2ftjCm166S8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=sqIGRr7zmqKbAiLGDFEUE2PMGF7KIMUS1TrZs8HT+zFABwh7iyAfZZ7/jx+S3VgDX
 Uf1anUSwtHKSn/7wzGXAg9yO5ZEJ7f/tSuQn4K5V+Y2//OuOlB/QiwWHlOV7vxI0x5
 EqHs7RBXMfPQt2nr2weMHmT9E+UD2/vq+6YTsFtOJ3H5/KyFvH9vbYIGYOMxP0sICa
 9KlZTNUOVEImlvrk/8NEbTcNZcXZaH7nkAP3R6ACnNxuuSJmdjHiEzAZVlpFCLFJ4P
 mC3NmQGM4CpZPRXIe4ho6F1OSo2kOJk6nfPVM3H1azB4nNeAtQxUxceNcJ/GczaT/E
 7GhELT2czdPoA==
Date: Sat, 11 Sep 2021 23:45:13 +0800
From: Gao Xiang <xiang@kernel.org>
To: Guo Xuenan <guoxuenan@huawei.com>
Subject: Re: [PATCH v1 1/5] erofs-utils: introduce dump.erofs for utils
Message-ID: <20210911154512.GA3160@hsiangkao-HP-ZHAN-66-Pro-G1>
Mail-Followup-To: Guo Xuenan <guoxuenan@huawei.com>, xiang@kernel.org,
 linux-erofs@lists.ozlabs.org, mpiglet@outlook.com
References: <20210911134635.1253426-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210911134635.1253426-1-guoxuenan@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: xiang@kernel.org, linux-erofs@lists.ozlabs.org, mpiglet@outlook.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xuenan,

Thanks for working on dump.erofs! Such functionality was recently
requested by some other folks, it's quite helpful to be resolved
upstream.

Some comments in-line:

On Sat, Sep 11, 2021 at 09:46:31PM +0800, Guo Xuenan wrote:
> From: mpiglet <mpiglet@outlook.com>

mpiglet => "Wang Qi" (according to the name in the source header)

It'd be better to use the real name if possible. ;)

> 
> Add dump-tool for erofs to facilitate users directly
> analyzing the erofs image file.
> 
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> Signed-off-by: mpiglet <mpiglet@outlook.com>

Same here.

> ---
>  Makefile.am        |  2 +-
>  configure.ac       |  2 ++
>  dump/Makefile.am   | 10 ++++++
>  dump/main.c        | 84 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/erofs/io.h |  3 ++
>  lib/namei.c        |  4 +--
>  6 files changed, 102 insertions(+), 3 deletions(-)
>  create mode 100644 dump/Makefile.am
>  create mode 100644 dump/main.c
> 
> diff --git a/Makefile.am b/Makefile.am
> index b804aa9..fedf7b5 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -3,7 +3,7 @@
>  
>  ACLOCAL_AMFLAGS = -I m4
>  
> -SUBDIRS = man lib mkfs
> +SUBDIRS = man lib mkfs dump
>  if ENABLE_FUSE
>  SUBDIRS += fuse
>  endif
> diff --git a/configure.ac b/configure.ac
> index f626064..f4fe548 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -280,6 +280,8 @@ AC_CONFIG_FILES([Makefile
>  		 man/Makefile
>  		 lib/Makefile
>  		 mkfs/Makefile
> +		 dump/Makefile
>  		 fuse/Makefile])
> +
>  AC_OUTPUT
>  
> diff --git a/dump/Makefile.am b/dump/Makefile.am
> new file mode 100644
> index 0000000..e664799
> --- /dev/null
> +++ b/dump/Makefile.am
> @@ -0,0 +1,10 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +# Makefile.am
> +
> +AUTOMAKE_OPTIONS = foreign
> +bin_PROGRAMS     = dump.erofs
> +AM_CPPFLAGS = ${libuuid_CFLAGS} ${libselinux_CFLAGS}

Do we really need uuid and selinux libraries for dump.erofs?

> +dump_erofs_SOURCES = main.c
> +dump_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
> +dump_erofs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/liberofs.la ${libselinux_LIBS} ${liblz4_LIBS}

Same here.

> +
> diff --git a/dump/main.c b/dump/main.c
> new file mode 100644
> index 0000000..8fbc24a
> --- /dev/null
> +++ b/dump/main.c
> @@ -0,0 +1,84 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * dump/main.c

It could cause some u-boot checkpatch problem...
It'd be better to get rid of the path.

> + *
> + * Copyright (C) 2021-2022 HUAWEI, Inc.
> + *             http://www.huawei.com/
> + * Created by Wang Qi <mpiglet@outlook.com>
> + *            Guo Xuenan <guoxuenan@huawei.com>
> + */
> +
> +#include <stdlib.h>
> +#include <getopt.h>
> +#include <sys/sysmacros.h>
> +#include <time.h>
> +#include <lz4.h>
> +
> +#include "erofs/print.h"
> +#include "erofs/io.h"
> +
> +static struct option long_options[] = {
> +	{"help", no_argument, 0, 1},
> +	{0, 0, 0, 0},
> +};
> +
> +static void usage(void)
> +{
> +	fputs("usage: [options] erofs-image \n\n"
> +		"Dump erofs layout from erofs-image, and [options] are:\n"
> +		"-v/-V      print dump.erofs version info\n"

How about leaving only one argument here.
It'd be better to keep in sync with dumpe2fs, so:
https://www.man7.org/linux/man-pages/man8/dumpe2fs.8.html

       -V     print the version number of dump.erofs and exit.

> +		"-h/--help  display this help and exit\n", stderr);

-h was used by dumpe2fs, so how about leaving --help only here?

> +}
> +static void dumpfs_print_version(void)
> +{
> +	fprintf(stderr, "dump.erofs %s\n", cfg.c_version);
> +}
> +
> +static int dumpfs_parse_options_cfg(int argc, char **argv)
> +{
> +	int opt;
> +
> +	while ((opt = getopt_long(argc, argv, "sSvVi:I:h",

It seems that not all options are used in this patch.
Also, it would be better to sort them all in the alphabetical order.

> +					long_options, NULL)) != -1) {
> +		switch (opt) {
> +		case 'v':
> +		case 'V':
> +			dumpfs_print_version();
> +			exit(0);
> +		case 'h':
> +		case 1:
> +		    usage();
> +		    exit(0);
> +		default: /* '?' */
> +			return -EINVAL;
> +		}
> +	}
> +
> +	if (optind >= argc)
> +		return -EINVAL;
> +
> +	cfg.c_img_path = strdup(argv[optind++]);
> +	if (!cfg.c_img_path)
> +		return -ENOMEM;
> +
> +	if (optind < argc) {
> +		erofs_err("unexpected argument: %s\n", argv[optind]);

minor nit: memory leak of c_img_path?

> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int err = 0;
> +
> +	erofs_init_configure();
> +	err = dumpfs_parse_options_cfg(argc, argv);
> +	if (err) {
> +		if (err == -EINVAL)
> +			usage();
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> diff --git a/include/erofs/io.h b/include/erofs/io.h
> index 5574245..00e5de8 100644
> --- a/include/erofs/io.h
> +++ b/include/erofs/io.h
> @@ -10,6 +10,7 @@
>  #define __EROFS_IO_H
>  
>  #include <unistd.h>
> +#include <sys/types.h>

How about removing "#include <sys/types.h>" in lib/namei.c?

Thanks,
Gao Xiang

>  #include "internal.h"
>  
>  #ifndef O_BINARY
> @@ -25,6 +26,8 @@ int dev_fillzero(u64 offset, size_t len, bool padding);
>  int dev_fsync(void);
>  int dev_resize(erofs_blk_t nblocks);
>  u64 dev_length(void);
> +dev_t erofs_new_decode_dev(u32 dev);
> +int erofs_read_inode_from_disk(struct erofs_inode *vi);
>  
>  static inline int blk_write(const void *buf, erofs_blk_t blkaddr,
>  			    u32 nblocks)
> diff --git a/lib/namei.c b/lib/namei.c
> index 4e06ba4..21631f1 100644
> --- a/lib/namei.c
> +++ b/lib/namei.c
> @@ -15,7 +15,7 @@
>  #include "erofs/print.h"
>  #include "erofs/io.h"
>  
> -static dev_t erofs_new_decode_dev(u32 dev)
> +dev_t erofs_new_decode_dev(u32 dev)
>  {
>  	const unsigned int major = (dev & 0xfff00) >> 8;
>  	const unsigned int minor = (dev & 0xff) | ((dev >> 12) & 0xfff00);
> @@ -23,7 +23,7 @@ static dev_t erofs_new_decode_dev(u32 dev)
>  	return makedev(major, minor);
>  }
>  
> -static int erofs_read_inode_from_disk(struct erofs_inode *vi)
> +int erofs_read_inode_from_disk(struct erofs_inode *vi)
>  {
>  	int ret, ifmt;
>  	char buf[sizeof(struct erofs_inode_extended)];
> -- 
> 2.25.4
> 
