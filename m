Return-Path: <linux-erofs-bounces+lists+linux-erofs=lfdr.de@lists.ozlabs.org>
X-Original-To: lists+linux-erofs@lfdr.de
Delivered-To: lists+linux-erofs@lfdr.de
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee1:b9f1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B6E797166
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Sep 2023 12:02:38 +0200 (CEST)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4RhFCv66Kjz3bwZ
	for <lists+linux-erofs@lfdr.de>; Thu,  7 Sep 2023 20:02:35 +1000 (AEST)
X-Original-To: linux-erofs@lists.ozlabs.org
Delivered-To: linux-erofs@lists.ozlabs.org
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.alibaba.com (client-ip=115.124.30.100; helo=out30-100.freemail.mail.aliyun.com; envelope-from=hsiangkao@linux.alibaba.com; receiver=lists.ozlabs.org)
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4RhFCp4gvPz2xZp
	for <linux-erofs@lists.ozlabs.org>; Thu,  7 Sep 2023 20:02:28 +1000 (AEST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=2;SR=0;TI=SMTPD_---0VrYQxbJ_1694080941;
Received: from 30.97.49.12(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VrYQxbJ_1694080941)
          by smtp.aliyun-inc.com;
          Thu, 07 Sep 2023 18:02:22 +0800
Message-ID: <99839f61-6c53-8d98-1682-8aed2b7cc298@linux.alibaba.com>
Date: Thu, 7 Sep 2023 18:02:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v6 06/11] erofs-utils: lib: add erofs_rebuild_get_dentry()
 helper
To: Jingbo Xu <jefflexu@linux.alibaba.com>, linux-erofs@lists.ozlabs.org
References: <20230905100227.1072-1-jefflexu@linux.alibaba.com>
 <20230905100227.1072-7-jefflexu@linux.alibaba.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20230905100227.1072-7-jefflexu@linux.alibaba.com>
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



On 2023/9/5 18:02, Jingbo Xu wrote:
> Rename tarerofs_get_dentry() to erofs_rebuild_get_dentry().
> 
> Also make `whout` and 'opq' parameter optional when `aufs` is false.
> 
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> ---
>   include/erofs/rebuild.h |  19 +++++++
>   lib/Makefile.am         |   3 +-
>   lib/rebuild.c           | 117 ++++++++++++++++++++++++++++++++++++++++
>   lib/tar.c               | 109 ++-----------------------------------
>   4 files changed, 141 insertions(+), 107 deletions(-)
>   create mode 100644 include/erofs/rebuild.h
>   create mode 100644 lib/rebuild.c
> 
> diff --git a/include/erofs/rebuild.h b/include/erofs/rebuild.h
> new file mode 100644
> index 0000000..92873c9
> --- /dev/null
> +++ b/include/erofs/rebuild.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0 */
> +#ifndef __EROFS_REBUILD_H
> +#define __EROFS_REBUILD_H
> +
> +#ifdef __cplusplus
> +extern "C"
> +{
> +#endif
> +
> +#include "internal.h"
> +
> +struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
> +		char *path, bool aufs, bool *whout, bool *opq);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif
> diff --git a/lib/Makefile.am b/lib/Makefile.am
> index 3e09516..8a45bd6 100644
> --- a/lib/Makefile.am
> +++ b/lib/Makefile.am
> @@ -25,6 +25,7 @@ noinst_HEADERS = $(top_srcdir)/include/erofs_fs.h \
>         $(top_srcdir)/include/erofs/compress_hints.h \
>         $(top_srcdir)/include/erofs/fragments.h \
>         $(top_srcdir)/include/erofs/xxhash.h \
> +      $(top_srcdir)/include/erofs/rebuild.h \
>         $(top_srcdir)/lib/liberofs_private.h
>   
>   noinst_HEADERS += compressor.h
> @@ -32,7 +33,7 @@ liberofs_la_SOURCES = config.c io.c cache.c super.c inode.c xattr.c exclude.c \
>   		      namei.c data.c compress.c compressor.c zmap.c decompress.c \
>   		      compress_hints.c hashmap.c sha256.c blobchunk.c dir.c \
>   		      fragments.c rb_tree.c dedupe.c uuid_unparse.c uuid.c tar.c \
> -		      block_list.c xxhash.c
> +		      block_list.c xxhash.c rebuild.c
>   
>   liberofs_la_CFLAGS = -Wall ${libuuid_CFLAGS} -I$(top_srcdir)/include
>   if ENABLE_LZ4
> diff --git a/lib/rebuild.c b/lib/rebuild.c
> new file mode 100644
> index 0000000..7aaa071
> --- /dev/null
> +++ b/lib/rebuild.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR Apache-2.0
> +#define _GNU_SOURCE
> +#include <unistd.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include "erofs/print.h"
> +#include "erofs/inode.h"
> +#include "erofs/rebuild.h"
> +#include "erofs/internal.h"
> +
> +#ifdef HAVE_LINUX_AUFS_TYPE_H
> +#include <linux/aufs_type.h>
> +#else
> +#define AUFS_WH_PFX		".wh."
> +#define AUFS_DIROPQ_NAME	AUFS_WH_PFX ".opq"
> +#define AUFS_WH_DIROPQ		AUFS_WH_PFX AUFS_DIROPQ_NAME
> +#endif
> +
> +static struct erofs_dentry *erofs_rebuild_mkdir(struct erofs_inode *dir,
> +						const char *s)
> +{
> +	struct erofs_inode *inode;
> +	struct erofs_dentry *d;
> +
> +	inode = erofs_new_inode();
> +	if (IS_ERR(inode))
> +		return ERR_CAST(inode);
> +
> +	inode->i_mode = S_IFDIR | 0755;
> +	inode->i_parent = dir;
> +	inode->i_uid = getuid();
> +	inode->i_gid = getgid();
> +	inode->i_mtime = inode->sbi->build_time;
> +	inode->i_mtime_nsec = inode->sbi->build_time_nsec;
> +	erofs_init_empty_dir(inode);
> +
> +	d = erofs_d_alloc(dir, s);
> +	if (!IS_ERR(d)) {
> +		d->type = EROFS_FT_DIR;
> +		d->inode = inode;
> +	}
> +	return d;
> +}
> +
> +struct erofs_dentry *erofs_rebuild_get_dentry(struct erofs_inode *pwd,
> +		char *path, bool aufs, bool *whout, bool *opq)
> +{
> +	struct erofs_dentry *d = NULL;
> +	unsigned int len = strlen(path);
> +	char *s = path;
> +
> +	if (aufs) {
> +		*whout = false;
> +		*opq = false;
> +	}

I'd suggest adding a boolean dumb instead here, otherwise
it looks good to me.

Thanks,
Gao Xiang
