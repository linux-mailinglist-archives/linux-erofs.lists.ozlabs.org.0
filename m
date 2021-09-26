Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CC54185F3
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Sep 2021 05:22:28 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HHB0H2QWFz2yV4
	for <lists+linux-erofs@lfdr.de>; Sun, 26 Sep 2021 13:22:23 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=linux.alibaba.com (client-ip=47.88.44.36;
 helo=out4436.biz.mail.alibaba.com; envelope-from=hsiangkao@linux.alibaba.com;
 receiver=<UNKNOWN>)
Received: from out4436.biz.mail.alibaba.com (out4436.biz.mail.alibaba.com
 [47.88.44.36])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HHB091vmfz2yNL
 for <linux-erofs@lists.ozlabs.org>; Sun, 26 Sep 2021 13:22:14 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R111e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=hsiangkao@linux.alibaba.com;
 NM=1; PH=DS; RN=5; SR=0; TI=SMTPD_---0UpaL00X_1632626502; 
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com
 fp:SMTPD_---0UpaL00X_1632626502) by smtp.aliyun-inc.com(127.0.0.1);
 Sun, 26 Sep 2021 11:21:44 +0800
Date: Sun, 26 Sep 2021 11:21:42 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Guo Xuenan <guoxuenan@huawei.com>, mpiglet@outlook.com
Subject: Re: [PATCH v3 1/5] erofs-utils: introduce dump.erofs
Message-ID: <YU/nRm9ug/kFXHBD@B-P7TQMD6M-0146.local>
References: <20210915093537.2579575-1-guoxuenan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210915093537.2579575-1-guoxuenan@huawei.com>
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
Cc: linux-erofs@lists.ozlabs.org
Errors-To: linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org
Sender: "Linux-erofs"
 <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>

Hi Xuenan and Qi,

On Wed, Sep 15, 2021 at 05:35:33PM +0800, Guo Xuenan wrote:
> From: Wang Qi <mpiglet@outlook.com>
> 
> Add dump-tool for erofs to facilitate users directly
> analyzing the erofs image file.
> 
> Signed-off-by: Guo Xuenan <guoxuenan@huawei.com>
> Signed-off-by: Wang Qi <mpiglet@outlook.com>

I'm almost fine with the series, and I will merge some of the patches
later.

Due to busy work, my original plan was to fix some nits by myself and
apply. Anyway, I will reply some comments this evening...

Thanks,
Gao Xiang

> ---
>  Makefile.am        |  2 +-
>  configure.ac       |  1 +
>  dump/Makefile.am   |  8 +++++
>  dump/main.c        | 81 ++++++++++++++++++++++++++++++++++++++++++++++
>  include/erofs/io.h |  3 ++
>  lib/config.c       |  3 ++
>  lib/namei.c        |  5 ++-
>  7 files changed, 99 insertions(+), 4 deletions(-)
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
> index f626064..81c493a 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -280,6 +280,7 @@ AC_CONFIG_FILES([Makefile
>  		 man/Makefile
>  		 lib/Makefile
>  		 mkfs/Makefile
> +		 dump/Makefile
>  		 fuse/Makefile])
>  AC_OUTPUT
>  
> diff --git a/dump/Makefile.am b/dump/Makefile.am
> new file mode 100644
> index 0000000..3d8a32c
> --- /dev/null
> +++ b/dump/Makefile.am
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +# Makefile.am
> +
> +AUTOMAKE_OPTIONS = foreign
> +bin_PROGRAMS     = dump.erofs
> +dump_erofs_SOURCES = main.c
> +dump_erofs_CFLAGS = -Wall -Werror -I$(top_srcdir)/include
> +dump_erofs_LDADD = $(top_builddir)/lib/liberofs.la
> \ No newline at end of file
> diff --git a/dump/main.c b/dump/main.c
> new file mode 100644
> index 0000000..af8db4b
> --- /dev/null
> +++ b/dump/main.c
> @@ -0,0 +1,81 @@
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
> +	fputs("usage: [options] IMAGE\n\n"
> +		"Dump erofs layout from IMAGE, and [options] are:\n"
> +		"-V      print the version number of dump.erofs and exit.\n"
> +		"--help  display this help and exit.\n",
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
> +			usage();
> +			exit(0);
> +		default:
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
> +	if (err) {
> +		if (err == -EINVAL)
> +			usage();
> +		goto exit;
> +	}
> +
> +exit:
> +	erofs_exit_configure();
> +	return err;
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
> diff --git a/lib/config.c b/lib/config.c
> index 99fcf49..405fae6 100644
> --- a/lib/config.c
> +++ b/lib/config.c
> @@ -7,6 +7,7 @@
>   * Created by Li Guifu <bluce.liguifu@huawei.com>
>   */
>  #include <string.h>
> +#include <stdlib.h>
>  #include "erofs/print.h"
>  #include "erofs/internal.h"
>  
> @@ -45,6 +46,8 @@ void erofs_exit_configure(void)
>  	if (cfg.sehnd)
>  		selabel_close(cfg.sehnd);
>  #endif
> +	if (cfg.c_img_path)
> +		free(cfg.c_img_path);
>  }
>  
>  static unsigned int fullpath_prefix;	/* root directory prefix length */
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
