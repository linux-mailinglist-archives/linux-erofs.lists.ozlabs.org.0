Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4EA40AE4A
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Sep 2021 14:54:10 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H83FX0rM6z2yJJ
	for <lists+linux-erofs@lfdr.de>; Tue, 14 Sep 2021 22:54:08 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H83FL1xq7z2xrS
 for <linux-erofs@lists.ozlabs.org>; Tue, 14 Sep 2021 22:53:54 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R461e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0UoOE.lJ_1631624010; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UoOE.lJ_1631624010) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 14 Sep 2021 20:53:31 +0800
Date: Tue, 14 Sep 2021 20:53:30 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Guo Xuenan <guoxuenan@huawei.com>
Subject: Re: [PATCH v2 1/5] erofs-utils: introduce dump.erofs
Message-ID: <YUCbSmR8Lt7uG8f9@B-P7TQMD6M-0146.local>
References: <20210914074424.1875409-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210914074424.1875409-1-guoxuenan@huawei.com>
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
Cc: linux-erofs@lists.ozlabs.org, mpiglet@outlook.com
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xuenan,

some nit below:

On Tue, Sep 14, 2021 at 03:44:20PM +0800, Guo Xuenan wrote:
> From: Wang Qi <mpiglet@outlook.com>
> 
> Add dump-tool for erofs to facilitate users directly
> analyzing the erofs image file.
> 
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> Signed-off-by: Wang Qi <mpiglet@outlook.com>
> ---
>  Makefile.am        |  2 +-
>  configure.ac       |  2 ++
>  dump/Makefile.am   |  9 +++++
>  dump/main.c        | 85 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/erofs/io.h |  3 ++
>  lib/namei.c        |  5 ++-
>  6 files changed, 102 insertions(+), 4 deletions(-)
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
> index 0000000..8e18c0f
> --- /dev/null
> +++ b/dump/Makefile.am
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +# Makefile.am
> +
> +AUTOMAKE_OPTIONS = foreign
> +bin_PROGRAMS     = dump.erofs
> +dump_erofs_SOURCES = main.c
> +dump_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
> +dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la ${liblz4_LIBS}

I don't see the lz4 library is used in this patchset.
How about adding this dependency in the related patch if needed?

> +
> diff --git a/dump/main.c b/dump/main.c
> new file mode 100644
> index 0000000..8f299ca
> --- /dev/null
> +++ b/dump/main.c
> @@ -0,0 +1,85 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
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

Same here.

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
> +	fputs("usage: [options] erofs-image\n\n"
> +		"Dump erofs layout from erofs-image, and [options] are:\n"

usage: [options] IMAGE
Dump erofs layout from IMAGE, and [options] are:

> +		"--help  display this help and exit.\n"
> +		"-V      print the version number of dump.erofs and exit.\n",
> +		stderr);
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
> +	while ((opt = getopt_long(argc, argv, "V",
> +					long_options, NULL)) != -1) {
> +		switch (opt) {
> +		case 'V':
> +			dumpfs_print_version();
> +			exit(0);
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
> +
> +	if (cfg.c_img_path)
> +		free(cfg.c_img_path);

I can see this has been moved into lib/config.c, how about changing this
patch? (call erofs_exit_configure() instead here.)

Thanks,
Gao Xiang

> +
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
> index 4e06ba4..b45e9d8 100644
> --- a/lib/namei.c
> +++ b/lib/namei.c
> @@ -5,7 +5,6 @@
>   * Created by Li Guifu <blucerlee@gmail.com>
>   */
>  #include <linux/kdev_t.h>
> -#include <sys/types.h>
>  #include <unistd.h>
>  #include <stdio.h>
>  #include <errno.h>
> @@ -15,7 +14,7 @@
>  #include "erofs/print.h"
>  #include "erofs/io.h"
>  
> -static dev_t erofs_new_decode_dev(u32 dev)
> +dev_t erofs_new_decode_dev(u32 dev)
>  {
>  	const unsigned int major = (dev & 0xfff00) >> 8;
>  	const unsigned int minor = (dev & 0xff) | ((dev >> 12) & 0xfff00);
> @@ -23,7 +22,7 @@ static dev_t erofs_new_decode_dev(u32 dev)
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
